Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D0D20248
	for <e@80x24.org>; Mon,  4 Mar 2019 13:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfCDNrI (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 08:47:08 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:38103 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfCDNrI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 08:47:08 -0500
Received: by mail-ed1-f44.google.com with SMTP id h58so4289528edb.5
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 05:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rP3ik00VxaJYkS+ujbRT9Mvag7+5SqSfrGErI3anDI8=;
        b=LoV/28/cvGsxbYAYQmC8tn24KIzO845iZByFZNcAovrPqbFGoQW/19VnmAtvqrmGv+
         qR1rV5jJZasyjFZZ603xYplyc2BJlNpLbaclbPyBVLIzfX1O70evZFzjo01x+CQlcgws
         3H7KTu0+l/P6p5ibAWIrL4Cu1IKB36yzyy4AwTkeWIXTUQ/7ipzqk/zg6LYspqgJqWT2
         c+24G7g6FKESvMfCDQ6aqtJh9dBUCfQyjQVZjw/qlcb7SNcXBSliRoFCyIsLQLPcvrnr
         zjgQMVZIud1omLJWS7rnquB/o0cqIuMtLhNiE0cVgP+NWtB8InR8HF7awuvg3e4d9XLU
         S1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rP3ik00VxaJYkS+ujbRT9Mvag7+5SqSfrGErI3anDI8=;
        b=U6gXCv7GU3FcWseWmS3Rist9nWg9XoVMBxN/0nUz8i3f2XDtmOeTE489twZY6iPv6E
         bmbqiLLPVJXYvxdrZ7wjq08bvIYaLMepC2n/CgL3Zr1/W+R8apULUdiBN0SK/e5vEqzT
         ef2sgpEsWSsvluYE3FiRUGsVaC8Kx4o5nucz5bv1WJebZYc8AEK982KxNB3SzJ12in/7
         gMkwbAopybuASHolSx7WsLSsDhAE2UqWaIgbELunjcW+AuMeqQdF8ZgQEi8giKqao5Mi
         9rtN19UvzRfWuiQOmULHg/KBuTCkdEoeC67e92eKXUyymHaT0TCLlGVSRHmfAYn9qZjX
         Cs2A==
X-Gm-Message-State: APjAAAVqPYrokzwauuNKypsl3kL/J2VhHJpsoJP4hB3lcInvmxKgJYoC
        Po6ExWnuXctO29Ax+/Kb6mi9CWPo
X-Google-Smtp-Source: APXvYqwhWTbkoI19+IwoJlM+8Hj0o7tKI/5KoHpSWF0EZ5R2435ZDMNb3nkq8qlMqbhcm66MJ/b+jQ==
X-Received: by 2002:a17:906:7b0d:: with SMTP id e13mr12288916ejo.165.1551707226427;
        Mon, 04 Mar 2019 05:47:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm1187052ejn.77.2019.03.04.05.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:47:05 -0800 (PST)
Date:   Mon, 04 Mar 2019 05:47:05 -0800 (PST)
X-Google-Original-Date: Mon, 04 Mar 2019 13:47:04 GMT
Message-Id: <pull.130.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.130.git.gitgitgadget@gmail.com>
References: <pull.130.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Avoid calling find in the Makefile, if possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed this quite a bit of time ago, but did not get a chance to look
into it in detail: all of a sudden, make started really slowly over here.

The culprit turned out to be a find call, which was in the Makefile for
ages, so I was puzzled why it only caused problems recently.

After some digging, I found out that the hdr-check target is the culprit:
before it was introduced, $(LIB_H) did not need to be expanded, and as a
consequence the find call was not executed. Once hdr-check made it into 
master, though, $(LIB_H) must be expanded to define that rule.

Since I have tons of worktrees as subdirectories of my principal Git clone,
and since I also have a 3rdparty/ directory with tons of repositories I use
for various testing/contributing purposes, this find is quite a little slow
over here.

So here is my suggested fix. It is based on similar code we already had in
the Makefile, obviously also intended to avoid an expensive find invocation.

Changes since v1:

 * Since LIB_H's lazy evaluation kicks in all the time anyway, changed the = 
   to := to avoid evaluating it three times.
 * Clarified in the commit message that the existing sites using $(LIB_H) 
   are not affected by this change (or at least not affected as long as no
   untracked header files are included in .c files).

Johannes Schindelin (1):
  Makefile: use `git ls-files` to list header files, if possible

 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: c65a2884eae159bad540135479bc8afe20ff62d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-130%2Fdscho%2Favoid-find-in-makefile-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-130/dscho/avoid-find-in-makefile-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/130

Range-diff vs v1:

 1:  0b5529406b ! 1:  cb253bd0cf Makefile: use `git ls-files` to list header files, if possible
     @@ -29,7 +29,11 @@
          than from a clone of Git's sources).
      
          This has one notable consequence: we no longer include `command-list.h`
     -    in `LIB_H`, as it is a generated file, not a tracked one.
     +    in `LIB_H`, as it is a generated file, not a tracked one, but that is
     +    easily worked around. Of the three sites that use `LIB_H`, two
     +    (`LOCALIZED_C` and `CHK_HDRS`) already handle generated headers
     +    separately. In the third, the computed-dependency fallback, we can just
     +    add in a reference to $(GENERATED_H).
      
          Likewise, we no longer include not-yet-tracked header files in `LIB_H`.
      
     @@ -46,7 +50,7 @@
       GENERATED_H += command-list.h
       
      -LIB_H = $(shell $(FIND) . \
     -+LIB_H = $(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
     ++LIB_H := $(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
      +	$(FIND) . \
       	-name .git -prune -o \
       	-name t -prune -o \

-- 
gitgitgadget
