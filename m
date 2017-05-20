Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3392027B
	for <e@80x24.org>; Sat, 20 May 2017 21:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbdETVnp (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35485 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932316AbdETVnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:25 -0400
Received: by mail-wr0-f196.google.com with SMTP id g12so5760888wrg.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNFMSYx4vu4HF1wJzvnwYbErwrDUvD1bWcEL7kDeag4=;
        b=uesRS2XfJdREpQxkTSGD311Do+JCOUZwjVVFgEil0YM8RxT3h0cPaUjFII69PpR+u8
         pCkh3WSrLhA9MNg/i4KSU0jN5mL5CZobzJ8fVR9Qlf1ca44V10E7IGX3upeg7DTnx92O
         BLrLQXm+pFxERnjY6uxew0ogOM6nbLngxxQXzrQ7ku2+1R+SFo/rsZdR1RdgDZzIIMVc
         zHhwEkkzvI+3TE+QvpsYEAuJN2SYBkqCFeUEcpxobcHtSYXrX4Vv0KMSZTxxIAsC0BK+
         OumYcu+hrD3jONNO5/ONObhiCJ0UymELUXz22PChMzDc0fxqn0QtzEyThI86syLYIQcr
         mIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNFMSYx4vu4HF1wJzvnwYbErwrDUvD1bWcEL7kDeag4=;
        b=icT1xWEnV+qlnjmYXOVPmuWhzF62kOtbnAvONUPUJ4yea4W9BCTmoSEgC06zJBusRM
         rht5ihOgcX+5On6stlt8KK5bsxSk4yIP+EkHTQf7tu2SZ2KuWKHClEdP5G+XwAUkX4/t
         EUjmNgVflSwcyfMiDb/SAtna4dvjOso0D8zYjGOh9cfWLbCqOTn0HKvUBKwJlJ0zlmVJ
         SxFJhVEPXcAGZtl+dQuTOOF4Fbo0+r+IK60gj8fQ50AW6UJYRtvGV8E5OUoDqLz8cp5g
         bmzekIJnX7axWu+6JrVcO9ecuPcB6aEGiKq/xRRjyqqQlCUwwJf8+vl7HW2aCakIMaRF
         F8lA==
X-Gm-Message-State: AODbwcCXOxuUtQxRZXxwI4PG0SBWvPpU8RlFwvDjgUXInL0rpUaqNyZq
        z2rKapQre7oQMgKhDMI=
X-Received: by 10.223.134.46 with SMTP id 43mr7997839wrv.123.1495316603401;
        Sat, 20 May 2017 14:43:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:22 -0700 (PDT)
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
Subject: [PATCH v3 16/30] perf: emit progress output when unpacking & building
Date:   Sat, 20 May 2017 21:42:19 +0000
Message-Id: <20170520214233.7183-17-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
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
2.13.0.303.g4ebf302169

