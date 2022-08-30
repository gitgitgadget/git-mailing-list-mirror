Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1470FECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 13:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiH3Nyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiH3Nyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 09:54:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5860C26F5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:54:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k9so14376108wri.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=Go35E9NK1s0Z/aI3Xs6MZeIVIbJFw9cP9xCbNsY1cKQ=;
        b=MehmBPrSZK1L/WQX5LNC4Mje8nw59ma5rfsMPDVduX9k/Va9prn8bRZrLsvxAcnmV3
         33WJvuSladp+Q/VuICMA81LvzkG0nMrQ+VvjZSuEhZZwzFO6F/CoIf46CALlUI34t291
         EbU02HKgthkxwh8y1giZNXsgwq58tYWjo5GfllV++ahoPgVgkebPqUK3AnGRx56H4R1P
         iPUupK7aWdkkwkcBMAtSHrKG7R2PhPg9BPnlhx+gSRkdr/HzVBRLCrFaA9hi+6j/DhlN
         qc3EjPYaNPTQXIiR35PKFIZaCnoYoNzJOsqjC0OAjiYBDD8oiimCpTm2LWWSvI/b6BKL
         elsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=Go35E9NK1s0Z/aI3Xs6MZeIVIbJFw9cP9xCbNsY1cKQ=;
        b=OyLBamO7lkwKkIIJaYhbkSseSpNjI4NkRhtwu+JxpF3rT9DFuVGXtfskM188twc7WG
         xCWBGLLHDbY9yBJzPbm+JaAFbGQUPJqpPUvqIAmC8SArIM8aW1EsDHLfja5eT5NDhwwx
         vuoRQszKOFMNpvTU99Kv3+ZZebv4uFRRdTcr6wahddfayKbjc1c6LHOhfr1o2zxOpStB
         ff2qN3samW9H6XzhIFLhFFygKblbNxpVXnHGAyDLWwSiozwzXD6OX/o1Q3fdctTRU50A
         QW7Bbp1wISsG97SC7JJVb8oPeVFOixWPDAik4bVmXXzBzKa+U8GhHWi4zZENOmkvy8vO
         +qHQ==
X-Gm-Message-State: ACgBeo2s1ggiChE3gfltra2y0yUk6rAoNZMIIXY9mMKT/7KViJuSJX6D
        QaRHwO2ALr7CfPJMIxBE/vFRP8HlHgs=
X-Google-Smtp-Source: AA6agR5uB6cb8SW+hlHG0mGBzccQzhNPz7z27cYDkIn8Nb3XoGrkW/ze3RZ5g1ajxkTWvK3RAMdmCA==
X-Received: by 2002:a05:6000:1acd:b0:220:62c2:bc29 with SMTP id i13-20020a0560001acd00b0022062c2bc29mr8989394wry.620.1661867666441;
        Tue, 30 Aug 2022 06:54:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c430c00b003a60bc8ae8fsm11524650wme.21.2022.08.30.06.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:54:25 -0700 (PDT)
Message-Id: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 13:54:21 +0000
Subject: [PATCH 0/3] A couple of CI fixes regarding the built-in add --patch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an attempt to address the concern Junio raised in
https://lore.kernel.org/git/xmqq7d3gm1bl.fsf@gitster.g/: originally
motivated by a test suite failure when running Git's test suite in Visual
Studio, this pulls out the signed vs unsigned fix whose implications are
potentially much wider than Visual C.

While in that space, I spent the time (which took almost as long as I
expected
[https://lore.kernel.org/git/nrr2312s-q256-61n7-2843-7r0s817rp432@tzk.qr/])
to craft a semantic patch to scrutinize Git's source code for similar issues
(narrator's voice: there were no other instances, what did ya expect?).

To verify the fix, I then worked on a patch to exercise the built-in git add
-p in the test suite even when NO_PERL is set, and while developing this
patch and validating it, I got really puzzled that the add -p test case in
t6132 did not need to be guarded behind a PERL prereq. So this patch series
also includes a fix for that.

The story arc that binds all of these patches together is that they all
revolve around NO_PERL and CI issues that involve git add --patch.

Note: This patch series is based on ds/github-actions-use-newer-ubuntu (but
probably applies cleanly even on maint) because I tried to develop a
semantic patch to fix similar issues in the code base. However, I've since
run into what looks like a bug in Coccinelle
[https://github.com/coccinelle/coccinelle/issues/284]. My latest version of
that semantic patch looks like this, but I stopped when running it on Git's
source code triggered the bug for 66 of Git's .c files:

@@
type T = { unsigned int };
T:n b;
type S != { unsigned int, size_t };
S s;
binary operator o != { &&, || };
@@
-s o b
+s o (S)b

@@
type T = { unsigned int };
T:n b;
type S != { unsigned int, size_t };
S s;
binary operator o != { &&, || };
@@
-b o s
+(S)b o s


Johannes Schindelin (3):
  add -p: avoid ambiguous signed/unsigned comparison
  t3701: test the built-in `add -i` regardless of NO_PERL
  t6132(NO_PERL): do not run the scripted `add -p`

 add-patch.c                 | 2 +-
 t/t3701-add-interactive.sh  | 4 ++--
 t/t6132-pathspec-exclude.sh | 6 +++++-
 3 files changed, 8 insertions(+), 4 deletions(-)


base-commit: ef46584831268a83591412a33783caf866867482
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1340%2Fdscho%2Fbuilt-in-add-i-does-not-need-perl-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1340/dscho/built-in-add-i-does-not-need-perl-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1340
-- 
gitgitgadget
