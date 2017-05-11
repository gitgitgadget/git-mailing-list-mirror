Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001421FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755244AbdEKJTl (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:41 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34880 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755226AbdEKJTj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:39 -0400
Received: by mail-wr0-f193.google.com with SMTP id g12so2623515wrg.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ez/44xm3UAaN1Rc/9O0aq12mszsXbdcwX1KL6wShc9Q=;
        b=eirIyV9k1MSv4q/k/Hq93CTbTRqGHFEIo0n/SBXPx3wN4q65Lw+SPg6KMbljE7Qu5F
         HE9BIbtUy+h4xN5udNPFKmnQu8vKyqJccqRL6cQCgSvSYE8CX0OpaaS138d5TXAC+YxD
         ZPB06tJ5O+4932YBCsjoVR90UhIW2tLV2gzC0hQNxluKi5z/W6SH90CUgWzS0iqFXcap
         /aVxlnjXWn326Bo58Za7mzWexHUM5w+xtTdjFMEeGqva5k7NJHr5KNBcwTandy7zN+gE
         3q99bdMjsZjVt9iLmhUPMt06eXh2RiZCMnHt3m26gVPIP6EH+cP+Dk490Kz+iQhYZsPm
         wTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ez/44xm3UAaN1Rc/9O0aq12mszsXbdcwX1KL6wShc9Q=;
        b=IeKpGHyOlR/HUtcdBKe53TiV2IldJBmVfhP1gBCFaA5mJSWljkShbmcN7TDoFh9c0N
         BRWj8QD0GqBmpDZEXwE9jPrCQxNh2R9K6LjguPBonqD1M7W/n0uKVu2Sn92DWKl6OFHf
         NoGXsoaKmrgqWV+TvLj+jL0bQhQxq+Z4RCZ78BoRn7wK5CyPqmLtWP2Hy+jGXYbOD3MH
         pBlPyRdgdXaeWnROLZ3Oi1syc+fP3DtBFE10kBZxvr27l+oYKfmPFeRgLoHaedMrQlss
         XIwONuZR47t2eM9LVlS4RlyFMelKmE92xKET4Q/3HrmZZqb791UJu6uraN2rlBEm9Ngb
         +KpQ==
X-Gm-Message-State: AODbwcDeemI4L6qMMRfFBgSBPZg7W3fMM2MMmm4cPtVNv7LG0B5UIaNF
        tVHaafZVJx8Jxg==
X-Received: by 10.80.182.89 with SMTP id c25mr9696ede.55.1494494372794;
        Thu, 11 May 2017 02:19:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/29] perf: emit progress output when unpacking & building
Date:   Thu, 11 May 2017 09:18:15 +0000
Message-Id: <20170511091829.5634-16-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the t/perf/run output so that in addition to the "Running N
tests" heading currently being emitted, it also emits "Unpacking $rev"
and "Building $rev" when setting up the build/$rev directory & when
building it, respectively.

This makes it easier to see what's going on and what revision is being
tested as the output scrolls by.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/run | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index b61024a830..beb4acc0e4 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -24,6 +24,7 @@ run_one_dir () {
 
 unpack_git_rev () {
 	rev=$1
+	echo "=== Unpacking $rev in build/$rev ==="
 	mkdir -p build/$rev
 	(cd "$(git rev-parse --show-cdup)" && git archive --format=tar $rev) |
 	(cd build/$rev && tar x)
@@ -37,6 +38,7 @@ build_git_rev () {
 			cp "../../$config" "build/$rev/"
 		fi
 	done
+	echo "=== Building $rev ==="
 	(
 		cd build/$rev &&
 		if test -n "$GIT_PERF_MAKE_COMMAND"
-- 
2.11.0

