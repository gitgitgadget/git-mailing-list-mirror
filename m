Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB88C20248
	for <e@80x24.org>; Mon, 18 Mar 2019 16:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfCRQPX (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 12:15:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54029 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCRQPW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 12:15:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id e74so13606398wmg.3
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6J0bm9qt+NMJmfG62ylVW6hUjWAnBLYsD9/T5zi/N34=;
        b=kXkd2y71Vv01oa7RhC8cpZJYpEGfehbLInH/CEfZbdaiarhrK5h6cJBMzZi+7n0F7L
         +1fYU5QvvZCDX/dz6ZBId5Nla6hbOWR5P0IkJjNMyLYhe7hVvggSurZ+4a74dLrOWPV5
         xaK78G1oSw1ZF5qdimmvBl2B0LziLlGCCsRvET/d7xD8Nac1nDD9DXf9+dSc+w041Vbu
         1h4NFhT1ADZdGKyKgqL334Qoc7RHnXFWm/7S65WD7X/d493a5sG3iVImLAYswDycK47c
         4GqqQziY5reVaRrSHC38hIRiTtyq+a+/SL5OzJoVuHIcByGy4f455jGN50UmSHjT8jUZ
         1nUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6J0bm9qt+NMJmfG62ylVW6hUjWAnBLYsD9/T5zi/N34=;
        b=uhv9fxYIn8UgOP5yIS51whlalnuD517ne9EB85Q2kj7zZvKVypduPw9RGa95ciYKFT
         Er68gefDaIzKFxR8i4qUAZDdc1LFn7fGEDpvW+NRtS2knrO1FHesevW6y6d14m+AHpQO
         TZZf5DU+F8mxeeXDqrtfzwREa3P3OHlpSpVspR/ddrerNC+ZAd6+wyzR97vwtuYBWE6y
         NWyS2UZlR//CFL7J/1Wjx3QsbFjDkj79xbAcPBcebYP8ztGejcVRp1brdCcgZkmS8vVF
         2v8jvAQuzQMcX+ufMBordcQqE0IrT/9nOHH6c35GQzlTkOfrGXaV/akUnJl29JMKHrIT
         wBdg==
X-Gm-Message-State: APjAAAVp+BLYcRCGdEenf3yAlRDoGLmUDVwt1062qFhRxkvhvlWIUAES
        AxoIdXSPPPo0ZGwM40e6rQsWDJBoQjg=
X-Google-Smtp-Source: APXvYqz5uxFN2cyrolYqcBeWRu8UyDmOqQPiNPBxtb5n6Sppj77gBg+4/J8oUqONeE5W6d+KoSjRgQ==
X-Received: by 2002:a7b:c404:: with SMTP id k4mr12324185wmi.117.1552925720184;
        Mon, 18 Mar 2019 09:15:20 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z9sm3269728wmf.12.2019.03.18.09.15.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Mar 2019 09:15:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] gc docs: de-duplicate "OPTIONS" and "CONFIGURATION"
Date:   Mon, 18 Mar 2019 17:15:01 +0100
Message-Id: <20190318161502.7979-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an earlier commit I started including the "gc.*" documentation from
git-config(1) in the git-gc(1) documentation. That still left us in a
state where the "--auto" option and "gc.auto" were redundantly
discussing the same thing.

Fix that by briefly discussing how the option itself works for
"--auto", and for the rest referring to the configuration
documentation.

This revealed existing blind spots in the configuration documentation,
move over the documentation and reword as appropriate.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/gc.txt | 27 +++++++++++++++++++++++----
 Documentation/git-gc.txt    | 25 ++++---------------------
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index a834a801cd6..605e14bc80b 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -19,13 +19,27 @@ gc.auto::
 	objects in the repository, `git gc --auto` will pack them.
 	Some Porcelain commands use this command to perform a
 	light-weight garbage collection from time to time.  The
-	default value is 6700.  Setting this to 0 disables it.
+	default value is 6700.
++
+Setting this to 0 disables not only automatic packing based on the
+number of loose objects, but any other heuristic `git gc --auto` will
+otherwise use to determine if there's work to do, such as
+`gc.autoPackLimit`.
++
+The repacking of loose objects will be performed with `git repack -d
+-l`.
 
 gc.autoPackLimit::
+
 	When there are more than this many packs that are not
 	marked with `*.keep` file in the repository, `git gc
 	--auto` consolidates them into one larger pack.  The
-	default	value is 50.  Setting this to 0 disables it.
+	default value is 50.  Setting this (or `gc.auto`) to 0
+	disables it. Packs will be consolidated using the `-A` option
+	of `git repack`.
++
+See the `gc.bigPackThreshold` configuration variable below. When in
+use it'll effect how the auto pack limit works.
 
 gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
@@ -35,13 +49,18 @@ gc.bigPackThreshold::
 	If non-zero, all packs larger than this limit are kept when
 	`git gc` is run. This is very similar to `--keep-base-pack`
 	except that all packs that meet the threshold are kept, not
-	just the base pack. Defaults to zero. Common unit suffixes of
-	'k', 'm', or 'g' are supported.
+	just the base pack. Defaults to zero or a memory heuristic.
+	Common unit suffixes of 'k', 'm', or 'g' are supported.
 +
 Note that if the number of kept packs is more than gc.autoPackLimit,
 this configuration variable is ignored, all packs except the base pack
 will be repacked. After this the number of packs should go below
 gc.autoPackLimit and gc.bigPackThreshold should be respected again.
++
+If the amount of memory is estimated not enough for `git repack` to
+run smoothly and `gc.bigPackThreshold` is not set, the largest pack
+will also be excluded (which is the equivalent of running `git gc`
+with `--keep-base-pack`).
 
 gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 9edf4e465b4..154c7c5e652 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -49,29 +49,12 @@ OPTIONS
 --auto::
 	With this option, 'git gc' checks whether any housekeeping is
 	required; if not, it exits without performing any work.
-	Some git commands run `git gc --auto` after performing
-	operations that could create many loose objects. Housekeeping
-	is required if there are too many loose objects or too many
-	packs in the repository.
 +
-If the number of loose objects exceeds the value of the `gc.auto`
-configuration variable, then all loose objects are combined into a
-single pack using `git repack -d -l`.  Setting the value of `gc.auto`
-to 0 disables automatic packing of loose objects.
+See the `gc.auto' option in the "CONFIGURATION" below for how this
+heuristic works.
 +
-If the number of packs exceeds the value of `gc.autoPackLimit`,
-then existing packs (except those marked with a `.keep` file
-or over `gc.bigPackThreshold` limit)
-are consolidated into a single pack by using the `-A` option of
-'git repack'.
-If the amount of memory is estimated not enough for `git repack` to
-run smoothly and `gc.bigPackThreshold` is not set, the largest
-pack will also be excluded (this is the equivalent of running `git gc`
-with `--keep-base-pack`).
-Setting `gc.autoPackLimit` to 0 disables automatic consolidation of
-packs.
-+
-If houskeeping is required due to many loose objects or packs, all
+Once housekeeping is triggered by exceeding the limits of
+configurations options such as `gc.auto` and `gc.autoPackLimit`, all
 other housekeeping tasks (e.g. rerere, working trees, reflog...) will
 be performed as well.
 
-- 
2.21.0.360.g471c308f928

