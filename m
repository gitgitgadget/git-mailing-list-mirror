Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED76920248
	for <e@80x24.org>; Mon, 25 Mar 2019 12:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfCYMIw (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 08:08:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55924 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731071AbfCYMIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 08:08:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so8611152wmf.5
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZdn2OfGSJf10mW5ZEiCMQsMAV45Sp0Jf/ljJmQRzdc=;
        b=TucLxcWWzxKLMiKbar4etl9MJ8IEphbmjLhfFPEZCnH8UVi/cs+DKHD8jCgI8idhsQ
         qBTgLdpMM6P7ZfPFZ8xw1RLq07WQQMamq5hq+uFcgntdzI3Sjs/69C8imR9Mb0bEpcfM
         Vdl/sVLHf2cBqbyCFiryurrr0ZhXh1M/GNS7T13vp8eOgzJfegqDFCGEdiDZ/C2giZ+C
         nTD/Sitx99vWF42F5LxpJ32e96gSM8O1Zd2+2f4JKLbPW2EdQ3TczvGmS6nFb+yVr9IG
         duFUQ1yg4twIkURYC+R2PSOzQgXSvb+pGgc6C/3lDZFLTLV+jBOxgramBEBuvqCsLPG5
         W8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZdn2OfGSJf10mW5ZEiCMQsMAV45Sp0Jf/ljJmQRzdc=;
        b=ozLXMAKLadYACvmYgqGGp8ItH+IDQvZLP13njXjABjSqhwyE8TyLCAvvIEK58BMR89
         MXW5jurutP2ZlKMvMdhqiRgK5iRW52ZEiQNiKrgK+xz+XWdTinQ81qBpMA/Ooquh61pc
         Q3okJg759bK0led5ZgDXts+CF9z44GZLTclE3dkxblV8JYkVKLNYJV2xUvc/CSG5cfKr
         Xcz7FtzvUuXAXWAXVKR6aed4nPbauVrEHnZgzMKxHaMnqQ/FOrGxbUaWIwaUcV5uK3tI
         25STLFOHAiZynd6NZgoSyJiHOOOv9K1sodccbNlYJGltIa39umR6mu8/xzH+9iktc6YY
         2L9g==
X-Gm-Message-State: APjAAAVHubgl7GB+0c5qryfAt7dSiMQoMVMh8m4m4UtA+S1+Cn6IBcvP
        +rmyDbgVirEHz+WyD3MpKVjguXEB
X-Google-Smtp-Source: APXvYqzi6GDDbGIR2i5rZAZMJSKBbcriMjzykmzjGjiIcotqLTQrM/pwH9GVCxVurYXoLkwvYBsSmw==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr5243606wme.24.1553515729065;
        Mon, 25 Mar 2019 05:08:49 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n188sm15339464wme.13.2019.03.25.05.08.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 05:08:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/8] commit-graph: fix segfault on e.g. "git status"
Date:   Mon, 25 Mar 2019 13:08:29 +0100
Message-Id: <20190325120834.15529-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314214740.23360-1-avarab@gmail.com>
References: <20190314214740.23360-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When core.commitGraph=true is set, various common commands now consult
the commit graph. Because the commit-graph code is very trusting of
its input data, it's possibly to construct a graph that'll cause an
immediate segfault on e.g. "status" (and e.g. "log", "blame", ...). In
some other cases where git immediately exits with a cryptic error
about the graph being broken.

The root cause of this is that while the "commit-graph verify"
sub-command exhaustively verifies the graph, other users of the graph
simply trust the graph, and will e.g. deference data found at certain
offsets as pointers, causing segfaults.

This change does the bare minimum to ensure that we don't segfault in
the common fill_commit_in_graph() codepath called by
e.g. setup_revisions(), to do this instrument the "commit-graph
verify" tests to always check if "status" would subsequently
segfault. This fixes the following tests which would previously
segfault:

    not ok 50 - detect low chunk count
    not ok 51 - detect missing OID fanout chunk
    not ok 52 - detect missing OID lookup chunk
    not ok 53 - detect missing commit data chunk

Those happened because with the commit-graph enabled setup_revisions()
would eventually call fill_commit_in_graph(), where e.g.
g->chunk_commit_data is used early as an offset (and will be
0x0). With this change we get far enough to detect that the graph is
broken, and show an error instead. E.g.:

    $ git status; echo $?
    error: commit-graph is missing the Commit Data chunk
    1

That also sucks, we should *warn* and not hard-fail "status" just
because the commit-graph is corrupt, but fixing is left to a follow-up
change.

A side-effect of changing the reporting from graph_report() to error()
is that we now have an "error: " prefix for these even for
"commit-graph verify". Pseudo-diff before/after:

    $ git commit-graph verify
    -commit-graph is missing the Commit Data chunk
    +error: commit-graph is missing the Commit Data chunk

Changing that is OK. Various errors it emits now early on are prefixed
with "error: ", moving these over and changing the output doesn't
break anything.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c          | 43 ++++++++++++++++++++++++++++++++---------
 t/t5318-commit-graph.sh |  3 ++-
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 47e9be0a3a..f8201d888b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -112,6 +112,36 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	return ret;
 }
 
+static int verify_commit_graph_lite(struct commit_graph *g)
+{
+	/*
+	 * Basic validation shared between parse_commit_graph()
+	 * which'll be called every time the graph is used, and the
+	 * much more expensive verify_commit_graph() used by
+	 * "commit-graph verify".
+	 *
+	 * There should only be very basic checks here to ensure that
+	 * we don't e.g. segfault in fill_commit_in_graph(), but
+	 * because this is a very hot codepath nothing that e.g. loops
+	 * over g->num_commits, or runs a checksum on the commit-graph
+	 * itself.
+	 */
+	if (!g->chunk_oid_fanout) {
+		error("commit-graph is missing the OID Fanout chunk");
+		return 1;
+	}
+	if (!g->chunk_oid_lookup) {
+		error("commit-graph is missing the OID Lookup chunk");
+		return 1;
+	}
+	if (!g->chunk_commit_data) {
+		error("commit-graph is missing the Commit Data chunk");
+		return 1;
+	}
+
+	return 0;
+}
+
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size)
 {
@@ -233,6 +263,9 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		last_chunk_offset = chunk_offset;
 	}
 
+	if (verify_commit_graph_lite(graph))
+		return NULL;
+
 	return graph;
 }
 
@@ -1089,15 +1122,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
 		return 1;
 	}
 
-	verify_commit_graph_error = 0;
-
-	if (!g->chunk_oid_fanout)
-		graph_report("commit-graph is missing the OID Fanout chunk");
-	if (!g->chunk_oid_lookup)
-		graph_report("commit-graph is missing the OID Lookup chunk");
-	if (!g->chunk_commit_data)
-		graph_report("commit-graph is missing the Commit Data chunk");
-
+	verify_commit_graph_error = verify_commit_graph_lite(g);
 	if (verify_commit_graph_error)
 		return verify_commit_graph_error;
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index ce3459a6f5..ad3a695f76 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -376,7 +376,8 @@ corrupt_graph_verify() {
 	grepstr=$1
 	test_must_fail git commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
-	test_i18ngrep "$grepstr" err
+	test_i18ngrep "$grepstr" err &&
+	test_might_fail git status --short
 }
 
 # usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
-- 
2.21.0.360.g471c308f928

