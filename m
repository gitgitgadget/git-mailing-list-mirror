Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424EFC432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 14:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132AC2073C
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 14:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfLBOty (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:49:54 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:32920 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBOty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 09:49:54 -0500
Received: by mail-io1-f66.google.com with SMTP id j13so40866498ioe.0
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 06:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9IlSOGjkufcUns0MTmZnB6MHCf4TGmMWfGqGpFlut0g=;
        b=hDfk9/5+P11QfwPnPyklHFfVJ0COZ3Dib6Yl1rs0M8cZ2NUmYSOCe+RqPuPmCT4CYN
         KOqeqG+EsLNd1MNM3B20ujsP7JhH2LJfy847qPE3/OZsUXpeADuBBvguheW5vUr6wx82
         fv2CKrgi09EdgkE53EdiK7SLws/h7RA/l14fJK7xp4QcmeTtQiYB28yb0NdP1WenEvjk
         B5eMQ8D9XQ+C5Ej6Y/i9sf/o+WW+vyLgF4COJoefTA0chCyr/Bcgu6Ql5+sSyHuetcio
         tXJCD6whVGR0fYVFF3bdRk2NYbBDGPRLlck56EBID4ZFkFpRc3ktwQeqHYRKCzunUL8m
         C8eg==
X-Gm-Message-State: APjAAAU8EO4iG0DI9b9PC5QjvZ9LF1A6DLZjij31TtomdmtGNTmsWIHd
        HRoneZYbqU8f0jTrMvc1PL7JY5H7eFbAAiZq9LrQtGB6
X-Google-Smtp-Source: APXvYqzXNRGJG+StQ+4j2i7zRtskvWPv9LL8L8bi9NiNXvfJ2OC3rhw9cc5lTsTrvFShUg2z/ilq6DPJdkhiwnEy2fI=
X-Received: by 2002:a6b:5a13:: with SMTP id o19mr17155685iob.120.1575298193540;
 Mon, 02 Dec 2019 06:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20191127151708.50531-1-emaste@freefall.freebsd.org>
 <20191127171507.56354-1-emaste@freefall.freebsd.org> <20191127172035.GB1123@sigill.intra.peff.net>
In-Reply-To: <20191127172035.GB1123@sigill.intra.peff.net>
From:   Ed Maste <emaste@freebsd.org>
Date:   Mon, 2 Dec 2019 06:03:23 -0500
Message-ID: <CAPyFy2CiRS_Mwgg=_uc6h0MtPfw0D-t9xiwuFVVy=-U85dyLPw@mail.gmail.com>
Subject: Re: [PATCH v2] t4210: skip i18n tests that don't work on FreeBSD
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Nov 2019 at 12:20, Jeff King <peff@peff.net> wrote:
>
> It would probably be cleaner to set them ahead of time and just unset
> them selectively in MINGW, etc. But we don't have any way to unset a
> prereq, so lets' go with this for now. :)

Also, what's the next step for this patch (is there anything I should
do)? I'd like to next work on getting FreeBSD CI going (via Cirrus-CI)
once this is sorted, so that I can start with no failing tests.
