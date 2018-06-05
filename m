Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195321F403
	for <e@80x24.org>; Tue,  5 Jun 2018 14:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbeFEOlB (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 10:41:01 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36433 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeFEOlA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 10:41:00 -0400
Received: by mail-wr0-f193.google.com with SMTP id f16-v6so2725000wrm.3
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxSKVPJSpTeH+iHSgbSlP6HDcTQ3whTeWYZMm/SRK50=;
        b=UBvQMKRJw+MRnPNUFLzdIx0hppZfxUOvH8NR//CwCiXvR6AsRPyZ9918Dsxr2ZVAO8
         Yjfbzd786do3EYmksBx3F9pQZ89xRI/Zxtj7UJNPyXmJl3E7uBKwa1Hn6KJ7gqqyRbAo
         86ixiY1XK6g6UbumEwCzv2EegzxzvlLxcJ3C09h6Kg2uI7Hz2KYy8/sWNksSzN7GAGQC
         Wm3wext/3j4gzch/JWpwBV+5xZ72d0u4Xey6LB5iKSQmhfRmX8VDB3A6edWvEAP9TOgR
         6SfPxFMWef96Teo/nwOL0qQscgh6EiNQR+tS1yBNDp05WGVTYF2ixlBynMyFBgvsORmy
         YtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxSKVPJSpTeH+iHSgbSlP6HDcTQ3whTeWYZMm/SRK50=;
        b=PRixz4emXwudG13gadx+XN09eRIuRDWv348yKzdk0XzpnEjbemXS17ZnrCP4J7DrQe
         N/pcxIpckPtlz7YKzNEAIk60A9bxqXr5Opas91+x4RDxcSLaX9129P8aX7M6jaxegIeJ
         xOIA3qzawb4ttvBtSN4ZvsQ7fIi7QMbbAITk6rt+qgOA5PNFTd9BkpAvPexzjRGjmTX9
         2f2MgMgtbAWEYhUFHIMN1vg5jxParR5m1kmDxFLJRNxbgRn5tzGa9+eUy1rLYynqHEcM
         qjT8FJBtQCpI0M57qnuVbjenXoqPSVjPXJdYI1MEDxY8nuHdj7TnvvjVxdMmXN+W/c/m
         UZ7g==
X-Gm-Message-State: ALKqPwfe1fzXM8pSd6vkDyMZdZnY7d28tW6ZXNXJjXdZ3P67XU9jYwEO
        JL5u2dYRRtZhn5DxJWfHmwoLw70R
X-Google-Smtp-Source: ADUXVKK2qtba+DeWvjLyb7M/ifDE/dTfGB5dJBJu5YPDgrfIdbRObyDRr3G0mSd7Tr9ghRMu86Tl7g==
X-Received: by 2002:adf:8e89:: with SMTP id q9-v6mr19821468wrb.269.1528209658529;
        Tue, 05 Jun 2018 07:40:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i76-v6sm2458910wmd.20.2018.06.05.07.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 07:40:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 0/8] ambiguous checkout UI & checkout.defaultRemote
Date:   Tue,  5 Jun 2018 14:40:41 +0000
Message-Id: <20180605144049.26488-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes issues noted with v6, hopefully ready for queuing. A tbdiff with
v6:

1: ab4529d9f5 = 1: 2ca81c76fc checkout tests: index should be clean after dwim checkout
2: c8bbece403 = 2: 19b14a1c75 checkout.h: wrap the arguments to unique_tracking_name()
3: 881fe63f4f = 3: 8bc6a9c052 checkout.c: introduce an *_INIT macro
4: 72ddaeddd3 ! 4: 34f3b67f9b checkout.c: change "unique" member to "num_matches"
    @@ -1,6 +1,6 @@
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    -    checkout.c]: change "unique" member to "num_matches"
    +    checkout.c: change "unique" member to "num_matches"
         
         Internally track how many matches we find in the check_tracking_name()
         callback. Nothing uses this now, but it will be made use of in a later
5: 5e8c82680b = 5: 7d81c06a23 checkout: pass the "num_matches" up to callers
6: 07e667f80a = 6: e86636ad2c builtin/checkout.c: use "ret" variable for return
7: 0a148182e6 ! 7: c2130b347c checkout: add advice for ambiguous "checkout <branch>"
    @@ -27,6 +27,28 @@
             hint: you can do so by fully qualifying the name with the --track option:
             hint:
             hint:     git checkout --track origin/<name>
    +    
    +    Note that the "error: pathspec[...]" message is still printed. This is
    +    because whatever else checkout may have tried earlier, its final
    +    fallback is to try to resolve the argument as a path. E.g. in this
    +    case:
    +    
    +        $ ./git --exec-path=$PWD checkout master pu
    +        error: pathspec 'master' did not match any file(s) known to git.
    +        error: pathspec 'pu' did not match any file(s) known to git.
    +    
    +    There we don't print the "hint:" implicitly due to earlier logic
    +    around the DWIM fallback. That fallback is only used if it looks like
    +    we have one argument that might be a branch.
    +    
    +    I can't think of an intrinsic reason for why we couldn't in some
    +    future change skip printing the "error: pathspec[...]" error. However,
    +    to do so we'd need to pass something down to checkout_paths() to make
    +    it suppress printing an error on its own, and for us to be confident
    +    that we're not silencing cases where those errors are meaningful.
    +    
    +    I don't think that's worth it since determining whether that's the
    +    case could easily change due to future changes in the checkout logic.
         
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
8: f3a52a26a2 ! 8: f1ac0f7351 checkout & worktree: introduce checkout.defaultRemote
    @@ -53,12 +53,12 @@
         
             $ ./git --exec-path=$PWD checkout master
             error: pathspec 'master' did not match any file(s) known to git.
    -        hint: The argument 'master' matched more than one remote tracking branch.
    +        hint: 'master' matched more than one remote tracking branch.
             hint: We found 26 remotes with a reference that matched. So we fell back
             hint: on trying to resolve the argument as a path, but failed there too!
             hint:
    -        hint: If you meant to check out a remote tracking branch on e.g. 'origin'
    -        hint: you can do so by fully-qualifying the name with the --track option:
    +        hint: If you meant to check out a remote tracking branch on, e.g. 'origin',
    +        hint: you can do so by fully qualifying the name with the --track option:
             hint:
             hint:     git checkout --track origin/<name>
             hint:
    @@ -263,7 +263,7 @@
      	status_uno_is_clean &&
     -	test_i18ngrep ! "^hint: " stderr
     +	test_i18ngrep ! "^hint: " stderr &&
    -+	# Make sure the likes of checkout -p don not print this hint
    ++	# Make sure the likes of checkout -p do not print this hint
     +	git checkout -p foo 2>stderr &&
     +	test_i18ngrep ! "^hint: " stderr &&
     +	status_uno_is_clean

Ævar Arnfjörð Bjarmason (8):
  checkout tests: index should be clean after dwim checkout
  checkout.h: wrap the arguments to unique_tracking_name()
  checkout.c: introduce an *_INIT macro
  checkout.c: change "unique" member to "num_matches"
  checkout: pass the "num_matches" up to callers
  builtin/checkout.c: use "ret" variable for return
  checkout: add advice for ambiguous "checkout <branch>"
  checkout & worktree: introduce checkout.defaultRemote

 Documentation/config.txt       | 26 +++++++++++++++
 Documentation/git-checkout.txt |  9 ++++++
 Documentation/git-worktree.txt |  9 ++++++
 advice.c                       |  2 ++
 advice.h                       |  1 +
 builtin/checkout.c             | 41 ++++++++++++++++++-----
 builtin/worktree.c             |  4 +--
 checkout.c                     | 37 ++++++++++++++++++---
 checkout.h                     |  4 ++-
 t/t2024-checkout-dwim.sh       | 59 ++++++++++++++++++++++++++++++++++
 t/t2025-worktree-add.sh        | 21 ++++++++++++
 11 files changed, 197 insertions(+), 16 deletions(-)

-- 
2.17.0.290.gded63e768a

