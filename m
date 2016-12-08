Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F381FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 01:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933023AbcLHBWh (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 20:22:37 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36102 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932400AbcLHBWg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 20:22:36 -0500
Received: by mail-qk0-f171.google.com with SMTP id n21so436253488qka.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 17:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wmlovVzHyCO7do1sVKwDzFuK69tMCuG0JJgeouCaJN4=;
        b=CbAV+GEAsf2SZVMcMtCul9EpHh/zmBLo3W4/TNf+Z5Yd0wcmWMVF8/TDtUkoMXfTfS
         qbKeCPsFJLHE10qu8+30+GqT153cjt7rTEp+L4z7AzPwXSqQil4NJqqG9uwLXMWabVUw
         KSrp5wm65Z5ypqKBzYlJ7UqjYU7jBUDOF/UioT0BHuralTQygDNQOh3xDzRy9WESqxs7
         c1IITqULRGxGkuxFCgPwk+Npe50XnVLvENYa5c5bfBH4WLu11/Lpi72eusoz87giRztp
         t0DAv6zUZSHEwW7TsGQp7uX64VEiQsJN9zw4ve+SAgNjh0pMWGtEiBkilcQZDzO5f476
         teJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wmlovVzHyCO7do1sVKwDzFuK69tMCuG0JJgeouCaJN4=;
        b=C8eyvCFvUHEW6eG3v/FBcpv4RNdxYS0N1xvZ+rNLoTPTmIH19i9ECbFDYWxJ5+jFMG
         5mYuMNJ4XIDZi6/FzTHA7Kgsl9rdv9FlaBaEDJXB/U5FyzLA+r5w1C0GG4VYzlN14/Hn
         3GEhF6Lu2RV4tXR+i5AoXIPmcTV4zWdzdNSIBBdSzQj1gJ01Aj8X6SRMaUlvSZTZpbmM
         9RgIAIFZCv8uUOerpOhrDikMYxYM6Ge9NAorFwqr3tBKKG9faCgst4+nWvp7YOtd2GCL
         jwH2be1dxS4+V7M14qG3x4clVLe11zG2K5NHqMB3AbGQdsLiGSQLs/LADhsZ+nIXKtrG
         y/Iw==
X-Gm-Message-State: AKaTC01qb2ZAQai3q6wp2jTV7MsTl2SIDYiCDGT0Vmk+2YFsZyOEGmejrlmnuLxY8+SvckbJ5lsJdmU5/eN7BtcD
X-Received: by 10.55.191.134 with SMTP id p128mr59600627qkf.58.1481160150546;
 Wed, 07 Dec 2016 17:22:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 7 Dec 2016 17:22:30 -0800 (PST)
In-Reply-To: <20161208003940.28794-1-vi0oss@gmail.com>
References: <20161208003940.28794-1-vi0oss@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Dec 2016 17:22:30 -0800
Message-ID: <CAGZ79kZU401JRp4EtwTGHzk3Zq+snQhX3GArDfF6SpKxsSwtWg@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper: set alternateLocation for cloned submodules
To:     vi0oss <vi0oss@gmail.com>, Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:39 PM,  <vi0oss@gmail.com> wrote:

>
>     Previously test contained errorneous
>     test_must_fail, which was masked by
>     missing &&.

I wonder if we could make either
the test_must_fail intelligent to detect such a broken && call chain
or the test_expect_success macro to see for those broken chains.

Patch looks good to me except one very minor nit. :)

> +test_expect_success 'nested submodule alternate in works and is actually used' '
> +       test_when_finished "rm -rf supersuper-clone" &&
> +       git clone --recursive --reference supersuper supersuper supersuper-clone &&
> +       (
> +               cd supersuper-clone &&
> +               # test superproject has alternates setup correctly
> +               test_alternate_is_used .git/objects/info/alternates . &&
> +               # immediate submodule has alternate:
> +               test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub

here is a && missing ;)
