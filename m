Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECF271F453
	for <e@80x24.org>; Sat, 27 Oct 2018 14:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbeJ0XPR (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 19:15:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51823 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbeJ0XPR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 19:15:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so4019453wmf.1
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 07:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ezl71esJRCYoVcPmrb8K/42sehJAdBaZoa4bpRluddU=;
        b=l6B/3oD6YSiAqpSvGRHf+8Xpr1CPj8KoXFDQYEOhddB4qn0Iem/ra2jDYVLQFqG1ho
         mnUgOLYuaGyhwRutus3XNiEn/jMhBYd8DvpRPyuMcTBrwSrr19LG10tBy6z/Ur4VPRgn
         w4nId8HQSLnGbYS63+UYMdAhRsBX4Qw+HqNWnRP4A/QiFHe2YIGh4htK3uGy2B7jjPG2
         oeyY76O8kAt29l7gDYhS9ufhY8cIKkOLETg6ePGvsvlCwVQdDYQKHLdkSxRGMEkEdoCl
         IEvtvtXHXPn3Wfy/4BGvhACX8rWT5PstuKdL8fp7PrLoBJOivQssaVxwX8op32PaI1Sz
         M8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Ezl71esJRCYoVcPmrb8K/42sehJAdBaZoa4bpRluddU=;
        b=Y4zN+Ar7DeLrUMhyaOCbgD5B3z5iVXNX9mtU1u2ecPt2+ThN7swP5jIjHd5m4KgOac
         h9yOWICKT/YUzpruM7nTdD3Hb66oLrGaGHZqqgcqYxFVTdpVh3PFufz/DVjZQ9fC1sdn
         Nw32XcmJa2NXQ0U7O7dVBede2jwCgCKhHxkwrEH8zv+n86LxDhCz55rB2Wi3igaShKyb
         ZR+zciqTtJWuXQVv7sBnyh6uCyGUskQmMyQ0mXlLQYuj217qaV9DN4SJArGMO+45AX8P
         I1IOAklbOtYaR9EZKSUAX3EiwZbEwf/yfHcnpYq/p+5KpbuR9pmNU6YkQGewqi/zK81d
         G0HA==
X-Gm-Message-State: AGRZ1gKp004hpGAwcrR/v7tU8NtmjhLTsNlISDbP8jRFDkWYHYszkGWO
        GpbxcQoZtgUKa/ypHjYnLKk=
X-Google-Smtp-Source: AJdET5cxVD5eE4dc1sWxtJRN/TzGEL/nDE5F94cUIyx9X7q1gP4jlZBVgmRjF1vB7ZYkbcdrrK19rg==
X-Received: by 2002:a1c:59c4:: with SMTP id n187-v6mr5458043wmb.98.1540650845455;
        Sat, 27 Oct 2018 07:34:05 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egq108.neoplus.adsl.tpnet.pl. [83.21.80.108])
        by smtp.gmail.com with ESMTPSA id l6-v6sm444783wrs.85.2018.10.27.07.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Oct 2018 07:34:04 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 10/12] Add a base implementation of SHA-256 support
References: <20181022024342.489564-1-sandals@crustytoothpaste.net>
        <20181022024342.489564-11-sandals@crustytoothpaste.net>
Date:   Sat, 27 Oct 2018 16:34:03 +0200
In-Reply-To: <20181022024342.489564-11-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 22 Oct 2018 02:43:40 +0000")
Message-ID: <86o9bf4fxg.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> SHA-1 is weak and we need to transition to a new hash function.  For
> some time, we have referred to this new function as NewHash.  Recently,
> we decided to pick SHA-256 as NewHash.

Even if we have decided to not repeat the reasoning behind the need to
switch away from SHA-1, and the choice of SHA-256 as NewHash, I think we
should provide _references_ to those discussion (either to the mailing
list via public-inbox, or via Git Rev News articles).

So the above paragraph would be:

  SHA-1 is weak and we need to transition to a new hash function [1].  For
  some time, we have referred to this new function as NewHash.  Recently,
  we decided to pick SHA-256 as NewHash [2].

  [1]: <some URL>
  [2]: <some URL>

>
> Add a basic implementation of SHA-256 based off libtomcrypt, which is in
> the public domain.  Optimize it and restructure it to meet our coding
> standards.  Pull in the update and final functions from the SHA-1 block
> implementation, as we know these function correctly with all compilers.
> This implementation is slower than SHA-1, but more performant
> implementations will be introduced in future commits.
>
> Wire up SHA-256 in the list of hash algorithms, and add a test that the
> algorithm works correctly.
>
> Note that with this patch, it is still not possible to switch to using
> SHA-256 in Git.  Additional patches are needed to prepare the code to
> handle a larger hash algorithm and further test fixes are needed.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Best,
--=20
Jakub Nar=C4=99bski
