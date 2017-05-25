Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC90C20284
	for <e@80x24.org>; Thu, 25 May 2017 19:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036731AbdEYTrM (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34563 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036692AbdEYTrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so55397684wmf.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ur2dKfXbO6aHjHF49XiB6tP4MtDtv1nw0BJRybcO2QQ=;
        b=uR+9ELqowxwYFS5Mycxm7oC9mG8TL09AFDWuqaCoSWEaKsrFNZMkvFV6jUcZGV8XFi
         Tck7fqJPP5HJng/JsjHYGGbpfzVS15MvOWfQGO2PWAoQX3vKBZvEhgEx91P6O3aY/BgV
         uI/D73sED6y1LcWL7hC0OsFndXLk5of7Dd+yy0DUDxP71A00NWVGSgDTlFN2KSnEj7Uz
         TL6ss9nAH7PrSTzGWqbVah1+CECg+6hElEBEuBRTtO7G5tB7q3UXM0M3yODfBvBHHyvH
         ROA/KkVpCGKv+FlzkywvP/thTZbvfr69nHwFA6a91mVPGWNbZJTdOK/mfLkjMuOCRIBT
         Auww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ur2dKfXbO6aHjHF49XiB6tP4MtDtv1nw0BJRybcO2QQ=;
        b=qQwOwJBk4LNRLLEWoKQCfy0MW8E0vfSacONaZ/hCXGxEgoc/PSG38njSG/5CDn39ce
         n3MNTam3/2p6xSg1gzfJM5bf7zasn/rO9jgXbB0Ssep3NMYiZzmiW2IA55JnZq/ZDWWL
         SP/2oyGeoH2P6J4gYhBUH5ynwKFdwVq87Ruao+Glq2dJGhoz15s4EebXXbjgsDIFHEnm
         1SbS1usQhgF1NYqS0yG02AxfT1L+YYeXuIkI4HhyPRio31HV2By+K3du5uViDg4YdicS
         uIJ661RKYuxZRYkwNGYhtEvCI0ZoCHmOkRmBwAX9p5i49W0+ThNLgVB/n6UDChua/zhB
         HRKw==
X-Gm-Message-State: AODbwcA6DQhkf0GqEuswbGgd/0qnHPiSdYeutI4Ft7OxRlYYXHIsEyaN
        Zl+M4iPdROMP/A==
X-Received: by 10.28.29.17 with SMTP id d17mr11636393wmd.90.1495741610243;
        Thu, 25 May 2017 12:46:50 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:49 -0700 (PDT)
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
Subject: [PATCH v4 15/31] perf: add a GIT_PERF_MAKE_COMMAND for when *_MAKE_OPTS won't do
Date:   Thu, 25 May 2017 19:45:19 +0000
Message-Id: <20170525194535.9324-16-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
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
 t/perf/README | 17 ++++++++++++++++-
 t/perf/run    | 11 +++++++++--
 3 files changed, 28 insertions(+), 3 deletions(-)

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
index 49ea4349be..0b6a8d2906 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -60,7 +60,22 @@ You can set the following variables (also in your config.mak):
 
     GIT_PERF_MAKE_OPTS
 	Options to use when automatically building a git tree for
-	performance testing.  E.g., -j6 would be useful.
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
 
     GIT_PERF_REPO
     GIT_PERF_LARGE_REPO
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

