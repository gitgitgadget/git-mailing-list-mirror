Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736431F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 20:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389922AbfAOUjW (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 15:39:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52323 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732643AbfAOUjV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 15:39:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so4728346wml.2
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 12:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aBznOdKsuR+mUToFhvPr4h6LSkCyECHwsIrSH9WYVko=;
        b=P2n7w3Bn4t1B6wKqg5fGhSxnHHBQrzzDUUdhNmbgjzJYtFTQwJktpv46pXuytZx7dP
         2fINXkYTbLvpZnFA71M9QrcicvJDyUWF1oBhgc30+mHNEkwwPFj6d6huVoOX5FPJgCSR
         Mf5lqwAncS3EE2TboMA3LuK7WR3d68H1Ie3jFHjlMiAKuUBp0lrKbHNM4OK144fkHGhr
         rng7jS23kVq9p5PRG5LfYibSuBd4CgP7vvUGGR/bIGBiOHR4TEtjk/rE868odxw5ZxzU
         EaWfPRbnArw4SOlFUnOtTkcs2UoUg4SCqh8ogPVMBXDZmLFm9v/XF3CqaydzK+LkWxHP
         bUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aBznOdKsuR+mUToFhvPr4h6LSkCyECHwsIrSH9WYVko=;
        b=SOKMMN5ZgyxzVH/hd6QKdFZeCwDGE2MHhxYkwhv2U62WThK/pgC6XpzqTu0zkriIRL
         qMB9JcYSS1NwGoiehvWY8NIynHJb7CD5Y4dszRfvtsQvrtHGEc2HII3zxkjM0QxGRgAU
         yY54BuU8ZB2MoAQ2CmPlWclPgj0Np+9ROG4Hl7KNyxGj2Ry6ShVkZJ5+W0Y9i0aeBB7C
         HT8/1GieBl2v56KL7LUGyhXIuDEUnoD+fMsqtRKwXB952RKG03vZ3yakR/K52lc8hsMr
         suUCrIq21Lb0t23TGUCjRTAyqkmAsnPkvROXPBSq41dyTVqKm2n0WqayIKDNZpAYXbGu
         Cwig==
X-Gm-Message-State: AJcUukdZL8sO0ih8KyRponMX074e9yfZai+yazlxzlbzpWgaCUwavXMe
        RmQ4JJX2PtiDOL75sQHGzik=
X-Google-Smtp-Source: ALg8bN5ow/lfRTM+IXuWjb4H8kE3Kpy7ejrYFO8tk+RQUrKkwdkgXgceV77ZAQPfBdGm7WbvbtABDA==
X-Received: by 2002:a1c:a503:: with SMTP id o3mr4709858wme.122.1547584759482;
        Tue, 15 Jan 2019 12:39:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s16sm61107045wrt.77.2019.01.15.12.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:39:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v5 3/3] Makefile: correct example fuzz build
References: <cover.1544048946.git.steadmon@google.com>
        <cover.1547582104.git.steadmon@google.com>
        <350ea5f7c97aa4166eea56aa57b66ddc9c53de4a.1547582104.git.steadmon@google.com>
Date:   Tue, 15 Jan 2019 12:39:18 -0800
In-Reply-To: <350ea5f7c97aa4166eea56aa57b66ddc9c53de4a.1547582104.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 15 Jan 2019 11:59:55 -0800")
Message-ID: <xmqqimypr6yx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 6b72f37c29..bbcfc2bc9f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3104,7 +3104,7 @@ cover_db_html: cover_db
>  # An example command to build against libFuzzer from LLVM 4.0.0:
>  #
>  # make CC=clang CXX=clang++ \
> -#      FUZZ_CXXFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
> +#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
>  #      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
>  #      fuzz-all
>  #

I know this appeared in v2 of the series, but I cannot quite read
the reasoning/justification behind this change.  After this hunk
there is

    FUZZ_CXXFLAGS ?= $(CFLAGS)

so if you do not give CFLAGS but give FUZZ_CXXFLAGS, like the
sample, shouldn't it have worked just fine?  IOW "correct" in the
title is a bit too terse as an explanation for this change.

