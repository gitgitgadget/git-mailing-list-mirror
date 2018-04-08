Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904631F424
	for <e@80x24.org>; Sun,  8 Apr 2018 11:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeDHLql (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 07:46:41 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36642 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeDHLqj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 07:46:39 -0400
Received: by mail-wm0-f46.google.com with SMTP id x82so10516559wmg.1
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 04:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=sUUctnGBiMVD13fyB0pA8FBarflikmxcepCKcCwxOjA=;
        b=o/L8ZlZkgT2C+YZ08BNzz4HY6kpeUZXPGp2OfowtE8YzjjeFgzGD6Me/v3IQFa4lVN
         2PjPx8zj4LfFbeeCv6NyqeOCCb0t3+4HSo3kCp+s3wt+mu7Nca6rvd1Su5lG9jhACEIg
         S58Y02kgaqeXc44sGDkxdbTRfi0dtF//fTWq+PJGcJVb1zOZ09mcZvSHKWddcs7d1dKa
         el8zG3GRU9hhCnUe9vWJyLaoilnytypyDi0ewzFuICo4UmbqAw+U72FuLmsMVC8O1izW
         MWJPo5no6rHlvTeoCLetyqI07eI58RqfEolYTfiRLs3bySmHTkjXsAjpVeR8VefV9ysj
         mBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=sUUctnGBiMVD13fyB0pA8FBarflikmxcepCKcCwxOjA=;
        b=sjWDOXQss9jU28HoMWbUnycDjFmDJUniXa225vNw8QDmEeltZ0gRYCnkvGy6OjUts4
         iACTixKBjXfyZxDhAT+NXtNxYXpeXxRcHNVYty8gEAkzKbdlSq8YwjyGDUc3fsPnfopz
         0QUtgscKqx2wgoVZoCDp8zry4IYDNb8Wk+7nNhP8wn300QtukbePXmae3rDC1Vbf9E7S
         zu8aVpMVsJTKy1yxCbasuIYsfncqc9wBoDnO9vujLje9BbfKVwmgdmVQgR/uRN364rGD
         d1kq0SziFv2r6X2PVJOr1OUfWDTNalPpgGNA1X5v6ugmIFRmivz3Mi96nKLADAkTMsEB
         4x1Q==
X-Gm-Message-State: ALQs6tA3sLV7EdiqxwLg9dk03i70WAJUXN8lDl7B8ikm5zXxKblDVaDD
        e6yZNgm4TXHIl2/xnBcXupArz0OF
X-Google-Smtp-Source: AIpwx4/mv3CvjUBrFx++4h3Zif48hF9mcuTdUBclBtntRQxOXns0rKOtkxobCsuK0SOgLf1YrJKkvA==
X-Received: by 10.80.142.174 with SMTP id w43mr16189029edw.140.1523187997922;
        Sun, 08 Apr 2018 04:46:37 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id a18sm9198156edj.89.2018.04.08.04.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 04:46:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michal Novotny <clime@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: getting pull and push URLs for the current branch
References: <CANT8FXS_vsXb5oyma+d7fgEaYBqFYjM2N=S6O6hksObHhN8gWw@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CANT8FXS_vsXb5oyma+d7fgEaYBqFYjM2N=S6O6hksObHhN8gWw@mail.gmail.com>
Date:   Sun, 08 Apr 2018 13:46:36 +0200
Message-ID: <87o9itzzs3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 08 2018, Michal Novotny wrote:

> is there a way to get remote url  for the current branch? That is the
> url that will be used when I call `git pull`. It doesn't seem to be a
> particularly easy task.

You'd do something like this (sans error checking):

    git remote get-url $(git config branch.$(git rev-parse --abbrev-ref HEAD).remote)

I.e. your HEAD may have remote tracking info set up, this'll get the
remote URL for the remote it points at.
