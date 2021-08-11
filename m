Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49228C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 13:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1780C60FE6
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 13:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhHKNvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhHKNvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 09:51:22 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC360C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 06:50:58 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id p22so1186485qki.10
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PE5shFURadCBcs1/Klp20Te3l3Dnbi19IFEwo6S5Rts=;
        b=Q39g5c1SdEC6R0bih/D29wxBPfRJy3HkAboiO4znr/P9srnpBilOKikkYJm9Tzecmc
         N2wjFBZZo4SK5UMsmktqwJVd2FbO4ztXW+fcUq6FPWLuuSJlnLkjLfUmRMa/AMZnv9Ls
         mY2ZIr4+uogWKcMDY16k2IxRW09KfAa06aAPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PE5shFURadCBcs1/Klp20Te3l3Dnbi19IFEwo6S5Rts=;
        b=Yyrku3gVu2PbdZfUpyJvxRDxYKEOGb8MFkspvTgY0WynFp4eE1cRjySo1at0BcFQBR
         SGWYOIrhGFVJI/TMZgLPxXJ0XxVuHCbEeaHScqb0tC6FtDWwKxauxD+D4tXC0YdJSu9C
         GxVbinSuJvcv2KS9E3socHph4xJK+x3lApfRyKfaD1QbCnZ+ME2MjQMcA3daGQ6ifiP6
         viyAKJidpszR3TxtZz5IjX9B91rJVZq9FGzLnfBkBIavC6jYI2NzuB8R06hj+oDv4Sw+
         xY4QiocW24ikQD8QF2TqbR4l9z0vcyJTOBljR+FHYGiTH5H7L53bBiURgBh8B0RrT93X
         view==
X-Gm-Message-State: AOAM531hi6I78KtkZYc1GmtV0Dpj1VwwJAiuwt9GkcjZXWtugyqRbBEp
        X7YJA/VckTlLTYKuZsRArCsrVvYK2WyZi+Lp
X-Google-Smtp-Source: ABdhPJx95YJHSAFW+mQFAIXYom4o7oYlQ8jur1teOr1uXwWqN/M6+jPBDFE8NpPQWC/U5l1b0RAHfg==
X-Received: by 2002:a37:6688:: with SMTP id a130mr12716849qkc.310.1628689857855;
        Wed, 11 Aug 2021 06:50:57 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id m19sm9477388qtx.84.2021.08.11.06.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 06:50:57 -0700 (PDT)
Date:   Wed, 11 Aug 2021 09:50:55 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [QUESTION]Is it possible that git would support two-factor
 authentication?
Message-ID: <20210811135055.tqdblurgk3vw5lgm@nitro.local>
References: <66e42438fa9311ebaeb60026b95c99cc@oschina.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66e42438fa9311ebaeb60026b95c99cc@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 07:00:50PM +0800, lilinchao@oschina.cn wrote:
> Many websites support two-factor authentication(2FA) to log in, like Github, I wander if we can support it in application layer.
> When client clone something, they need  input username and password, it is like a website login process. For security, we can
> enable  2FA during this process.

As you well know, "cloning" a repository can be done via any number of
mechanisms:

1. locally from another repository on disk
2. locally, from a git bundle file
3. remotely, using the anonymous git:// protocol
4. remotely, using ssh or http(s) protocols

2-factor authentication does not make sense in the first three cases (you
already have access to all the objects with 1 and 2, and the git:// protocol
is public and anonymous by design). For the ssh/https scheme, 2fa is already
supported by the underlying protocol, so it does not make sense for git to
implement it again on the application level.

Hope this helps.

-K
