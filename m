Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7713FC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 07:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiJJHuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 03:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiJJHuW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 03:50:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCC1ADA2
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 00:49:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so15713315wrp.10
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utoctwKJ7I0PE3KvdqHgelNY8CWmwBxOTvdAgkDvdW4=;
        b=idKzhHoGvM1D+lveMnYj3cvRHXN73mpctOjc7tXcCnmMIh/FyzIQ4cRFnb03utgFjB
         rrL3DI0vhSZo6ZD446T7IgEwds0xM360oOMGwYIXu09A0zEhyXFRSElC1oeBAO2i9V1K
         sS2hJQD1/+mNeQUFAk6s0HioNKS1ug2/kBpEvJXlw6nRl1jnchAfo5Lyixj5RrjAiZll
         10PEKmn+y4Q7GSuAPAIOWk4mSPUQCdQp1/HNz6G3Er7GduRQE3r4lv0z3tEh583r84NI
         vszts4/WQ5AqSDrRzqjh9pzmRhMbsIcneZeK4COlf4t/VDgMBE1PEDmlXoexs3Se6Tfy
         6i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utoctwKJ7I0PE3KvdqHgelNY8CWmwBxOTvdAgkDvdW4=;
        b=Z+j7LgEx+Lm4Sqr2t+8Z1cuLbBHNOuveQaza58IA2NpODK3CzYOGSYBoZcguS1mBj/
         ksITltP+hSoCM1smS7msvaaTA/FZqY5ZI485ZL3S5xA2NfC0KsLj1IIhQJvvcyc3sRZN
         Tn6a7MzSh/2AFTASyhaWdnOCwL69B3y0nIyQY/cEeGxR4mAHZ+XLDIsNNDVLThRdmFMH
         jcZiP0JgAsD+jykBoHlvx0SPnFl9zanqFilUyNJEhGAh38QRH7taA5Y8nA471LyA7wfe
         l4LTzaet9iwEVteuyEYYiesLW1b0FiEoI2dGMVXcQsknZJEUNvw9OsPLyumyApUlOIIH
         aQ5g==
X-Gm-Message-State: ACrzQf1yACLetqXNCnJkx1vIsa5UK5G17dlZisabBsaRbfJjjsa47opp
        AK0IOVCvgVOaZNQNuIusKaAVq0+TvsY=
X-Google-Smtp-Source: AMsMyM4A+f698/UnfrYFwSr04bfm/Nx+9+62pLKfBbqqjugr4ilFOhAXmaEvxR9bpxTKVbb4al5jZg==
X-Received: by 2002:adf:fdcf:0:b0:22e:3ef3:1d28 with SMTP id i15-20020adffdcf000000b0022e3ef31d28mr10993891wrs.331.1665388140366;
        Mon, 10 Oct 2022 00:49:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6809000000b0022aeba020casm8201846wru.83.2022.10.10.00.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 00:48:59 -0700 (PDT)
Message-Id: <4ee163b9a2c4c657e649159ae6c83b13613028f3.1665388136.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
References: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>
From:   "Oscar Dominguez via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 07:48:56 +0000
Subject: [PATCH 2/2] ci(main): linux32 uses actions/checkout@v2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Oscar Dominguez <dominguez.celada@gmail.com>,
        Oscar Dominguez <dominguez.celada@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Oscar Dominguez <dominguez.celada@gmail.com>

to prevent issue tracked in https://github.com/actions/checkout/issues/560

Signed-off-by: Oscar Dominguez <dominguez.celada@gmail.com>
---
 .github/workflows/main.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 8dc9d938159..4eb5042f0d6 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -281,17 +281,20 @@ jobs:
         vector:
         - jobname: linux-musl
           image: alpine
+          checkout_version: 3
         - jobname: linux32
           os: ubuntu32
           image: daald/ubuntu32:xenial
+          checkout_version: 2
         - jobname: pedantic
           image: fedora
+          checkout_version: 3
     env:
       jobname: ${{matrix.vector.jobname}}
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@${{matrix.vector.checkout_version}}
     - run: ci/install-docker-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - name: print test failures
-- 
gitgitgadget
