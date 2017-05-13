Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88EC20188
	for <e@80x24.org>; Sat, 13 May 2017 23:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758823AbdEMXQi (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:16:38 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35291 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758804AbdEMXQc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:16:32 -0400
Received: by mail-qt0-f195.google.com with SMTP id r58so11221818qtb.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5rl0Indxe4Sbsgj0FtQ8anmUKrW1lYu0eqzAFnE3Y04=;
        b=btejjuKayFfaHmBLuIP0SfmDU8z+//ud3yOmhlcAfw6CX8joVnnums1PfMsRLVN8QG
         Tr7Qn9LUKicUEvQ7rdsoF69n12TWUW36ApqfgO3kKczdkmuBc4LpgmuESUdoaravIYQE
         gwaKACqQf5Q4wmldZAkuii7lrIGLTUZL9dbrXtVpT68kvIg+4LPEvu4BXprXlSudmOtC
         TZpdRgb4Z8z3y7Ph+EcQv8rPOEQYS3xqWa9qRgvOCfqno9O3fQPizYxbczgqjMNiNcBm
         5e/YL8VLXd6m1VFMsGWVxCqEhubeZHhEgeUmO9PN55hA13o/nxXYWufPoAphrVhukghj
         puWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5rl0Indxe4Sbsgj0FtQ8anmUKrW1lYu0eqzAFnE3Y04=;
        b=UE1+zC7/xuug5HEhfwYQCnJwDX/Aa2m3MiwMkWi/V/7t6c1R/6Z212SnV2kq3tVckX
         axNpRlS0dAc6e0DiZ/THUg53UmdWjzNaUxKtYd8vZc2jZnx2inps87QJwIs6YuSp2CnB
         Prje00hIWYNWCYEy+PDSrupwp/4Vmh0V38yiiSG90pntjcly0bqKx9UW8tLho/IhYWWf
         FwlXpRGHTXHA4VmVSQIz5GarC/PRBatsYEzKy8xSkCkPcHu9CoP2gpVE6to7/EmjYL4I
         Ii4SAW75BIne9wzAAIDcmb0RITnOqy5iEmqcObDrV2XpqhZ1NXswR27LG0pnkgsoZB5m
         VKWg==
X-Gm-Message-State: AODbwcDkCDgKRP2WQVqmftoYJ1vG1fSTaUxZsi3XTw32Te1zLxFuVzuS
        cWhSsNU+yI8E7A==
X-Received: by 10.200.51.66 with SMTP id u2mr10697827qta.12.1494717391835;
        Sat, 13 May 2017 16:16:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:31 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/29] perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
Date:   Sat, 13 May 2017 23:14:54 +0000
Message-Id: <20170513231509.7834-15-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a git GIT_PERF_MAKE_COMMAND variable to compliment the existing
GIT_PERF_MAKE_OPTS facility. This allows specifying an arbitrary shell
command to execute instead of 'make'.

This is useful e.g. in cases where the name, semantics or defaults of
a Makefile flag have changed over time. It can even be used to change
the contents of the tree, useful for monkeypatching ancient versions
of git to get them to build.

This opens Pandora's box in some ways, it's now possible to
"jailbreak" the perf environment and e.g. modify the source tree via
this arbitrary instead of just issuing a custom "make" command, such a
command has to be re-entrant in the sense that subsequent perf runs
will re-use the possibly modified tree.

It would be pointless to try to mitigate or work around that caveat in
a tool purely aimed at Git developers, so this change makes no attempt
to do so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile      |  3 +++
 t/perf/README | 19 +++++++++++++++++--
 t/perf/run    | 11 +++++++++--
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index eedadb8056..d1587452f1 100644
--- a/Makefile
+++ b/Makefile
@@ -2272,6 +2272,9 @@ endif
 ifdef GIT_PERF_MAKE_OPTS
 	@echo GIT_PERF_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_OPTS)))'\' >>$@+
 endif
+ifdef GIT_PERF_MAKE_COMMAND
+	@echo GIT_PERF_MAKE_COMMAND=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_COMMAND)))'\' >>$@+
+endif
 ifdef GIT_INTEROP_MAKE_OPTS
 	@echo GIT_INTEROP_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_INTEROP_MAKE_OPTS)))'\' >>$@+
 endif
diff --git a/t/perf/README b/t/perf/README
index 49ea4349be..b3d95042a8 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -60,8 +60,23 @@ You can set the following variables (also in your config.mak):
 
     GIT_PERF_MAKE_OPTS
 	Options to use when automatically building a git tree for
-	performance testing.  E.g., -j6 would be useful.
-
+	performance testing. E.g., -j6 would be useful. Passed
+	directly to make as "make $GIT_PERF_MAKE_OPTS".
+
+    GIT_PERF_MAKE_COMMAND
+	An arbitrary command that'll be run in place of the make
+	command, if set the GIT_PERF_MAKE_OPTS variable is
+	ignored. Useful in cases where source tree changes might
+	require issuing a different make command to different
+	revisions.
+
+	This can be (ab)used to monkeypatch or otherwise change the
+	tree about to be built. Note that the build directory can be
+	re-used for subsequent runs so the make command might get
+	executed multiple times on the same tree, but don't count on
+	any of that, that's an implementation detail that might change
+	in the future.
+ 
     GIT_PERF_REPO
     GIT_PERF_LARGE_REPO
 	Repositories to copy for the performance tests.  The normal
diff --git a/t/perf/run b/t/perf/run
index c788d713ae..b61024a830 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -37,8 +37,15 @@ build_git_rev () {
 			cp "../../$config" "build/$rev/"
 		fi
 	done
-	(cd build/$rev && make $GIT_PERF_MAKE_OPTS) ||
-	die "failed to build revision '$mydir'"
+	(
+		cd build/$rev &&
+		if test -n "$GIT_PERF_MAKE_COMMAND"
+		then
+			sh -c "$GIT_PERF_MAKE_COMMAND"
+		else
+			make $GIT_PERF_MAKE_OPTS
+		fi
+	) || die "failed to build revision '$mydir'"
 }
 
 run_dirs_helper () {
-- 
2.11.0

