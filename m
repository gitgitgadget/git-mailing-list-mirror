Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D626C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 21:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDE42073E
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 21:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgF3V7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:59:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36096 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF3V7a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 17:59:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id 17so21026502wmo.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 14:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fd7mU8O5yBfKsfbdjsvsMLbHBCuh5f3rnVkyd36TVUo=;
        b=XZa2K2M6h9zLg0c4U9lDkFc0y6NdqWjtPpV/OqmRUCI/FJBFePdea+EssPRnm+doBt
         9ZHgfe1U4bSky0vW19BvJc9um1/FYdhaT1MiGq53KvIEH8Zu/8OewnercVKBRy9QOI/Q
         ecAMvuO+uZwJ5vx7pBRSjwUwBM2k4PrPewB4eBECt+ro9IdwbVFKr0F5Bp/gxYW5D/9f
         vDHDWWdabAbB4ZUmeDYpNgtTS3Adb5wrELPuT8ivXdhYeXI2SG4+SStJCFcDv+i9hwcK
         DIKk9wWz4PnaBbxTTD8sffhuPauqBAg2b3V6DBrcbsmhZDywxeJpm1dG1soXiFgzR+UZ
         5rHw==
X-Gm-Message-State: AOAM5325/47CMBeDEkuvRbXWrPYoglEq95mnHOOCvutmx0EmSKWbMTUD
        cr4KKg3fvRBvX2aELMtijxkgnR8S5aFDemWIgsAz+Q==
X-Google-Smtp-Source: ABdhPJxACbByNoSJcDkDh3nXU6RjIobmVqwsE+EyZGv/ItrgpGoudmq+2L5Ex5FsMpkhzL8WPc0xAmcS+SbgKMxmuw8=
X-Received: by 2002:a1c:9d0c:: with SMTP id g12mr16981693wme.107.1593554368978;
 Tue, 30 Jun 2020 14:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593529394.git.liu.denton@gmail.com> <01e29450fe51a4ba13e07c611d8795ffd0282b9e.1593529394.git.liu.denton@gmail.com>
 <CAPig+cSNK1MDitZyh7Ax-eRAh6NjG_QsoF0feEo4475GjZ5ezw@mail.gmail.com>
In-Reply-To: <CAPig+cSNK1MDitZyh7Ax-eRAh6NjG_QsoF0feEo4475GjZ5ezw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Jun 2020 17:59:17 -0400
Message-ID: <CAPig+cQdqYkCW7UED+sn+P-is+tDDGtY-KConhgJZW=CCHAk9A@mail.gmail.com>
Subject: Re: [PATCH 5/5] test-lib-functions: restrict test_must_fail usage
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 4:56 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 30, 2020 at 11:03 AM Denton Liu <liu.denton@gmail.com> wrote:
> > +                       case "$1" in *?=*) ;; *) break ;; esac
>
> Isn't '*?=*' the same as '?=', or am I misunderstanding the intention?

Nevermind. My brain blipped out while reading that. Obviously '?=' is
not the same as '*?=*' here.

The rest of the review comments still stand (I think).
