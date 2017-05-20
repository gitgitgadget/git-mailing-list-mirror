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
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E53201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756392AbdETVnd (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33648 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932211AbdETVnV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:21 -0400
Received: by mail-wr0-f195.google.com with SMTP id w50so5750755wrc.0
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ba8s41cz5c5VOj8gWS3nLYxWBH6HVZzf8VHUSmmQzUw=;
        b=u/VfdEiifItif+SA73xOKgzOGzVHuohTn2zwnNf5lKOZPgEEHqkpQ1k9/ZVmR7od4G
         FSgMqNsEdNO2fWm5m7SAP4vBShPUwZ6tnNwMQpLxtUE7KM9PMou2Mem6qit1Nt+11m1J
         A60/6JsBs/qgT7SMO0rNxj7vd7n981u5esXK2DIx3+VMCpR/frAFhE8+neDEtU9kirey
         yPcEqo/+pEoB9t4L4bUj2d5wgCh15tpS4uLCyhR6RtkZxHi/3xFeRL4ut3uDFalp9k8C
         SxBE6f+2oISHiN5FrsVBmyYN88tG6X78369rWg0jJFUW1PL7RZf9yrTI1bMtMpTWmnS5
         5Szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ba8s41cz5c5VOj8gWS3nLYxWBH6HVZzf8VHUSmmQzUw=;
        b=D+/CbEuFZ6xwiCKen1vtYTRWLfgecJm9RnXjJnqdPNpa+zMhomcliEJjb07Wp8nDTp
         0UHKBt4rtuS8O92PqqrRC2GliS+vU4F4BscEOH6IcW6ry/00J9mLApAJ0LTb/EcsMRac
         lkkHWun0RQ8NvDn9E22h2tbRv+/oVxc1v59f1iPiSkayxVR19ZvbYI3Om8+NemAhBRem
         C2W7TVdISBDI6qe1Qixl9j7+W0bOEbydvzGpHVvjp8mZpK2H6p7QuXJBXys7E5cb+6Ui
         kglJPTrZJz+tCgSyXdqUIBdhtAkekgWBSTx1qjyMyRM7DA5J5DcARWEszyV6405eZCGx
         5MMA==
X-Gm-Message-State: AODbwcAEYgKe846YzaIz/Oe/oSKJ+DMibdjUFGWhpg3XGFVr/k4Fuwyo
        rHIlNkzw+X9HBw==
X-Received: by 10.223.145.162 with SMTP id 31mr7433835wri.43.1495316599861;
        Sat, 20 May 2017 14:43:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:18 -0700 (PDT)
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
Subject: [PATCH v3 15/30] perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
Date:   Sat, 20 May 2017 21:42:18 +0000
Message-Id: <20170520214233.7183-16-avarab@gmail.com>
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
2.13.0.303.g4ebf302169

