Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE18C388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6E720759
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390026AbgJ1XCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:02:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39298 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389863AbgJ1XAm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:00:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id y12so783973wrp.6
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Di3CtIsD20qR75x+QmcvWVywMgT8SwgZ0V0Sst2i/rk=;
        b=rqRZoB3H/ZTCZwFUjnE29mZ8BHK767db0DUpZ4iwO5NQZguEoealy1jGHD0QIqA2dX
         DbRCACNBIdy2E1gL1JMkYM+KVbAAC/ZySmUJO+hNFuBY9ecwSUxtga7gDbIG5MEWtFW9
         OOoqhQZFL6FkEMXEGw2aelNEJ9PC7CgTG4rgw/M/XafqOnBLm/fKNx4UhVuJSfyCUbrx
         7rcrJvBmeRQCS0Php/xspcSeCuk05OGvgWrlWAGuA3hizCWzUMcqLWBO9ajgBSVWVPgf
         40eUD/JZHFSS2vyVXQ159720qufyea8DrG0b/qFEzwTawcMfnsKa7qayPFX/b96LZH58
         OKhg==
X-Gm-Message-State: AOAM533n+iKPLr7G+X/zN3GXpD/w9XqNdbjC4/ZiKXsQaRJ2tiWg5TAT
        M7FlOC8KKuv4gUrpQK7s7doqv4ZebQzFcIVC/q3BSHw9
X-Google-Smtp-Source: ABdhPJwGnHeWRqiIJGkkuT7SDN6HZuEv7SQRvLlBpVw0FID2snkvduaHI1TD1/FLr2/vScruwN4Hnm4Ed12aB0IF0oU=
X-Received: by 2002:a17:906:c041:: with SMTP id bm1mr153674ejb.202.1603906005454;
 Wed, 28 Oct 2020 10:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.774.git.1603889270.gitgitgadget@gmail.com> <da76a10717c917abab9e1bd5ab78db2a4f7ca7c0.1603889270.git.gitgitgadget@gmail.com>
In-Reply-To: <da76a10717c917abab9e1bd5ab78db2a4f7ca7c0.1603889270.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Oct 2020 13:26:34 -0400
Message-ID: <CAPig+cTA7akd7oB_14yBRhxXrH-mVX3yVtaPDdFDT+OTZdQuQQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] doc: add more pointers to gitattributes(5) for userdiff
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 28, 2020 at 8:48 AM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Several Git commands can make use of the builtin userdiff patterns, but
> it's not obvious in the documentation. Add pointers to the 'Defining a
> custom hunk header' part of gitattributes(5) in the description of the
> following options:
> [...]
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> @@ -695,7 +695,10 @@ endif::git-format-patch[]
>  --function-context::
> -       Show whole surrounding functions of changes.
> +       Show whole functions as context lines for each changes.

s/changes/change/

> +       The function names are determined in the same way as
> +       `git diff` works out patch hunk headers (see 'Defining a
> +       custom hunk-header' in linkgit:gitattributes[5]).
