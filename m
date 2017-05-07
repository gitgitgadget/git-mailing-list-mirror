Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8A4620188
	for <e@80x24.org>; Mon,  8 May 2017 00:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbdEHAhD (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 20:37:03 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36234 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdEHAhC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 20:37:02 -0400
Received: by mail-it0-f68.google.com with SMTP id x188so5949298itb.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 17:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qZd9xuFpGHnvuj/PfIsTlN+E1rZA0zfKbzDX/O8W9qo=;
        b=WznF31GtSLPgBnlxq/1fV72tF6pDsBgCm/DEm5NRgmczUaT95NobH1pRBFy3rId2Bn
         yZFwfvy7V+uPB2wNf7Qa9cakoSmy9NEyrXBHAJbKZPX6T9R9az5GFQWDUthueUUPAbbc
         1Uvz9tmAAQFJ2Mh6dZJDp2P7HUwfZXEQ6DJcFbsD2bfrT96ZQyJKIvXAEpAi/qdYFoUB
         GlufMkeUZ4ln8rOM/38qivV/zDyf+NtycaRa/veg6WvcAt4dsW79PyEDzCb0R07yr8ij
         ZdVJF9PIvhANuPzo6ETDmsp9QWnn2vsqwe82YKd6V5cZy3bVb2uObH6oH1UfmhRMLTp5
         OYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qZd9xuFpGHnvuj/PfIsTlN+E1rZA0zfKbzDX/O8W9qo=;
        b=jIkD5i7tl9BP8+OKJhlumnm7hTQCF1Xjh7NJ4Ize4alfMAzfXDo1oFMAtGEBGZmKx/
         etlBA11WDjwsX4qX2KAN9OnhYMQIMT6Skzpjo04gFJ9ZeOiNwYiHimqdjgDeQWz8+h+y
         9bu31OW+ktO38xX79G7fjzCxuH7lGhQBzw924XE7DEqDogoHsNyA64DynPHtT0sno5pl
         xS6MI/v5/KEZe8E1s130uNL7JmjgYeWDpzUj4EhfPk1ZL5+NiNoqb1GFbunPZ1Kvt68I
         GId67KPfxoFWCJL1ODF+bQ+RsSUAFHZyE181PeknXGHJhIlVbiPTaJHULTLMZBA4SkuQ
         RPHQ==
X-Gm-Message-State: AN3rC/7W4HSr2R5YjXGJOiuMlwSGtk+qMv8J9IRQ3JAt1cVxLu9Gr6gy
        IBYr7nAUbIuGdTFRkoaYS85dKzQkGcSuxG8=
X-Received: by 10.36.41.7 with SMTP id p7mr14472074itp.92.1494130860213; Sat,
 06 May 2017 21:21:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.88 with HTTP; Sat, 6 May 2017 21:20:39 -0700 (PDT)
In-Reply-To: <xmqqd1bp9nvj.fsf@gitster.mtv.corp.google.com>
References: <20170420112609.26089-1-pclouds@gmail.com> <20170503101706.9223-1-pclouds@gmail.com>
 <xmqqd1bp9nvj.fsf@gitster.mtv.corp.google.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Sun, 7 May 2017 13:20:39 +0900
X-Google-Sender-Auth: 3g78NZdQa5ro6YIIdq0thYZnzIM
Message-ID: <CAPc5daVwnsC2iqrX4PYL9LJyfD76dA1TS3xCNM7qHtmfHd0aWg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21]
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 4, 2017 at 2:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > Changes since v1:
> >
> >  - fopen_or_warn() and warn_on_fopen_errors() are introduced. The
> >    latter's name is probably not great...
> >  - A new patch (first one) to convert a bunch to using xfopen()
> >  - Fix test failure on Windows, found by Johannes Sixt
> >  - Fix the memory leak in log.c, found by Jeff
> >
> > There are still a couple of fopen() remained, but I'm getting slow
> > again so let's get these in first and worry about the rest when
> > somebody has time.

Hmm, is this topic responsible for recent breakage Travis claims on MacOS X=
?

https://travis-ci.org/git/git/jobs/229585098#L3091

seems to expect an error when test-config is fed a-directory but we are
not getting the expected warning and error?
