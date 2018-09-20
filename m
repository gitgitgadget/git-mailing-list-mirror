Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C008A1F453
	for <e@80x24.org>; Thu, 20 Sep 2018 14:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbeITUKe (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 16:10:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44992 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbeITUKe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 16:10:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so9607310wro.11
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WS/b1tGluMJToqiqIgVIwk6nsK0CJxdenzBvvqZ4MyM=;
        b=mkDckt1T3Fz3/XUtWcRJLoSnqA0tusZxj/AYqdeXfp8aKTiKAmspuUSpVqmyb3ppjv
         Y+TKaktD05SbQhaMBN0J3+5sO5t0aeZPLDDRqc/wqrImuPYL58egklKEmkcJQHssnQCs
         lp1lal3U7ruvPMQnFf1s+CKMP++FXh3kNEUMlGU51y/z94JLWgKHkmXZtz40Mx3xZ4fD
         nSs2X19tmAtHMYLBOyrHU2lid7cF/MlPgrQEC6OM9bXpbN1GnQMkN13yAlPatnviaa4u
         Mceu2bLWsfbGR36/O0grMa3vZepaMQASlrD04UV2zU0UNeUOuCRmqkGd03pdr+LNs059
         3ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WS/b1tGluMJToqiqIgVIwk6nsK0CJxdenzBvvqZ4MyM=;
        b=fIlto/tXp15oD7FTNy91g7YGtfcNRZ4eA82nUoGHlHtckxtfF88RXJhxvXevOr/pIe
         oZl4DLPI8MDppu6YSXnjIwS4lQnJ5Bj0LS9wMykX6Zj2QcF745OcZI31wFfQxiYTB3u1
         XChDlj/duBtgJM7BlObMPy/62eHE1w1hZ5/m3ammvJtPC1wLkUnFb8FGH53diVLtcvoC
         9sujqmJrtLL00ytg1v+JwKfBsckfHvQn063bYNJPr8JWK2xmflWSC76bYoS/IXjdSr9e
         LuX++IA9kXYvjopkPi59czn751MFkGCwghl42/oyKcEhakosiNWhObCoQPAgTKFRsQiu
         Xdnw==
X-Gm-Message-State: APzg51BgR8JlIggcnsDPYQc+mCHU+68qKFMltxOIWsT4MPDPxo04YWOD
        M64Xrv/yPZQvtwKsQHGL81+baFar
X-Google-Smtp-Source: ANB0VdYeb6GG5vrqtiiJon/uGrfqquoCy8RcO2jULq0q+smn36mHi5NiIggl13DX8QkxmlTukoiR8A==
X-Received: by 2002:adf:ab0b:: with SMTP id q11-v6mr34654349wrc.239.1537453607936;
        Thu, 20 Sep 2018 07:26:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c19-v6sm27388593wre.86.2018.09.20.07.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 07:26:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 1/9] Makefile: add a hdr-check target
References: <d24df21a-7ab2-84f6-8b18-83fd9c8c2b30@ramsayjones.plus.com>
Date:   Thu, 20 Sep 2018 07:26:46 -0700
In-Reply-To: <d24df21a-7ab2-84f6-8b18-83fd9c8c2b30@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 19 Sep 2018 01:07:08 +0100")
Message-ID: <xmqqbm8s2qjd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Commit ef3ca95475 ("Add missing includes and forward declarations",
> 2018-08-15) resulted from the author employing a manual method to
> create a C file consisting of a pair of pre-processor #include
> lines (for 'git-compat-util.h' and a given toplevel header), and
> fixing any resulting compiler errors or warnings.

It makes sense to have tool do what we do not have to do manually.

One thing that makes me wonder with the patch is that the new check
command does not seem to need to see what is on CFLAGS and friends.
Having seen that "make DEVELOPER=1" adds more -W... on the command
line of the compiler and makes a build fail on a source that
otherwise would build, I am wondering if there are some (subset of)
options that the header-check command line wants to give to the
compiler.

Of course, there are also conditionally compiled sections of code,
which are affected by the choice of -DMACRO=VALUE; how does this new
feature handle that?

> Add a Makefile target to automate this process. This implementation
> relies on the '-include' and '-xc' arguments to the 'gcc' and 'clang'
> compilers, which allows us to effectively create the required C
> compilation unit on-the-fly. This limits the portability of this
> solution to those systems which have such a compiler.
