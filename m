Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9496620D09
	for <e@80x24.org>; Sun, 16 Apr 2017 22:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbdDPWVa (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 18:21:30 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36382 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbdDPWV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 18:21:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id o21so18497836wrb.3
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uHc9SZasMMrgHVkUuSrYfLvw7kigsz8W9KIoGFvOKs=;
        b=UAbTiWy4Gty+8tGrWCsYmIQjurQynohhJxHJ4e+fhBquZIVa8xKpwWS4zJTGGUvfZe
         IZEN+q+WdtGx+yUaSX/U2jI2+MdNOfEBr2Vb2L1A+zFdv1vS7z+jULy2G6RDiCx/PR2V
         xnl7f9z/yIg3CxYigJx/PanuGgYCdfd7epGhlQwLeiThTmhtmdy8COaTkDLchXC3Q7Df
         vpP1o4TELLeo07r3JU7razhtWqaqOd+tQoqCx0pPckoA4cnXp0Eo6cf1LkDX1ZzUoqrv
         6rT/WfDoX1NviRBvvxveN2nPb/qssR+knMYiJxCVOMB1Jpnzq+YGMoUfUZx8VaKGpu7O
         FMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uHc9SZasMMrgHVkUuSrYfLvw7kigsz8W9KIoGFvOKs=;
        b=ZL2uqvlMFeNfPOCWuam8GudPyYyH4sWy38q90DVEGQ9QwtW35KkXMWlCnGe0pAkh5J
         J9Bf5AvvLRvWTls37RRSebCn2q2+SA27d3kN/ZfAGh3867ZzYAh6vMgINjew9PhjjJUZ
         wLwF+CJG793vDDwCkRThvqXUlkwf0B4KyprFR8A2ZkizjqqNmpiP+Yaeug7KS1thANdI
         ZOW73Wk6pqfvr/9t0MwpBB3looh0oH8QAT1i5+vHNNNhVlh70Oq6dkikNNsd+zQ8nFJM
         PlyjHzeA3tT9pdn8mlSN4B8XHemz/meYTJeN+k3My7rX1bDyrlnkYlXADllEQNc05vXe
         2DOA==
X-Gm-Message-State: AN3rC/7nO/TTwI3TryPwxvT9knkfPrnakXDNQybAqhSvQ2L0Uk7V5kYN
        ChIcEoVrtolbGw==
X-Received: by 10.223.146.98 with SMTP id 89mr15206314wrj.71.1492381287259;
        Sun, 16 Apr 2017 15:21:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o9sm8045022wmd.4.2017.04.16.15.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 15:21:26 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] grep: don't redundantly compile throwaway patterns under threading
Date:   Sun, 16 Apr 2017 22:20:57 +0000
Message-Id: <20170416222102.2320-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170416222102.2320-1-avarab@gmail.com>
References: <20170416222102.2320-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the pattern compilation logic under threading so that grep
doesn't compile a pattern it never ends up using on the non-threaded
code path, only to compile it again N times for N threads which will
each use their own copy, ignoring the initially compiled pattern.

This redundant compilation dates back to the initial introduction of
the threaded grep in commit 5b594f457a ("Threaded grep",
2010-01-25).

There was never any reason for doing this redundant work other than an
oversight in the initial commit. Jeff King suggested on-list in
<20170414212325.fefrl3qdjigwyitd@sigill.intra.peff.net> that this
might be needed to check the pattern for sanity before threaded
execution commences.

That's not the case. The pattern is compiled under threading in
start_threads() before any concurrent execution has started by calling
pthread_create(), so if the pattern contains an error we still do the
right thing. I.e. die with one error before any threaded execution has
commenced, instead of e.g. spewing out an error for each N threads,
which could be a regression a change like this might inadvertently
introduce.

The undocumented --debug mode added in commit 17bf35a3c7 ("grep: teach
--debug option to dump the parse tree", 2012-09-13) still works
properly with this change. It only emits debugging info during pattern
compilation, which is now dumped by the pattern compiled just before
the first thread is started.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 3aa7836a04..a3d380551b 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -224,7 +224,8 @@ static void start_threads(struct grep_opt *opt)
 		int err;
 		struct grep_opt *o = grep_opt_dup(opt);
 		o->output = strbuf_out;
-		o->debug = 0;
+		if (i)
+			o->debug = 0;
 		compile_grep_patterns(o);
 		err = pthread_create(&threads[i], NULL, run, o);
 
@@ -1154,8 +1155,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!opt.fixed && opt.ignore_case)
 		opt.regflags |= REG_ICASE;
 
-	compile_grep_patterns(&opt);
-
 	/*
 	 * We have to find "--" in a separate pass, because its presence
 	 * influences how we will parse arguments that come before it.
@@ -1230,6 +1229,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	num_threads = 0;
 #endif
 
+	if (!num_threads)
+		/*
+		 * The compiled patterns on the main path are only
+		 * used when not using threading. Otherwise
+		 * start_threads() below calls compile_grep_patterns()
+		 * for each thread.
+		 */
+		compile_grep_patterns(&opt);
+
 #ifndef NO_PTHREADS
 	if (num_threads) {
 		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
-- 
2.11.0

