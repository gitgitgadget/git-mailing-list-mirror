Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865D8202BB
	for <e@80x24.org>; Thu, 14 Mar 2019 21:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfCNVr7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 17:47:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37348 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfCNVr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 17:47:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15so7492021wro.4
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ADw/39BKW2DmILzPBg+2hLrVPJ2sS57KqRuTNYmYq60=;
        b=D0XOUXdl1Q1BfPtTTn+J6Y3CoJMf+LKAvwpGqNQe3CIMfyc/zRiaayT8CxfC2d7o63
         qi029R/Y6K1tF2x05Yf96tNL9pTeeuKUghkkR7uinFJPYM0vXWDilHTt2iyoPCMANrZw
         /rFz5BtCycYbINr5Jmx6M9aRW4tA8WKARBnlxlmkIXzKZb+1HY1Iz6N2o072ih0Y+BWD
         Qy+HByipNezhI5XJchxXORcieC7QsnKsyR9IGtc7jEzTLIQTATi5sE+fWueYznXsQEQJ
         /2EaCtacPCXBaLh2otGTg1lyPxdy6+aS9lfHjckZ3E/EDAWcCY39XcVTQa55Spy08t68
         Hueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADw/39BKW2DmILzPBg+2hLrVPJ2sS57KqRuTNYmYq60=;
        b=Bl9FqKacmwYW7pi+gBak7sqOQbbaXrmETbixmXF6vMKgjiUyD3vYIVOMRij4u3HrtR
         FNzDJMVNoUaPJ/9vjyXfdwQlLsVYlbgEJT1IE5B4dEcbIq8t2YITmfTkhMEBt1tC2SRv
         h7SkNj1wrwquX2ho2I/jxieNAQDOhaX/C0keeCuvVjiE4OgKtZ/bSRld/E5byYOtW+ZG
         m6uU74GS8qRN1GDC90mb8jd30UkYGJbF7Q4TCVd6BFJpxY80G47inSorDFfrfTaQMD1+
         RRgFK7pcWEhbrZSKGP0r4GSdxmU6+rvpsZNKcgI12Hd7xij7KZW+vyxwX6ZTRR5XYYHW
         b7EQ==
X-Gm-Message-State: APjAAAXByL/g2BJ+tZFvvpWz5hBSLOGc/wAUFJu7keaEQaWUFPjE/ZAF
        loIIHh9wWbBwsVsRnRDzQnBSK6l0G3E=
X-Google-Smtp-Source: APXvYqyE/aWUcjZ1r8j/fcY2ReZczW+p0ZwTw1dQuYI3YQSyAqr+pKLnI46b+JlgepOL1G4mhKJi6Q==
X-Received: by 2002:adf:fe83:: with SMTP id l3mr46285wrr.229.1552600076314;
        Thu, 14 Mar 2019 14:47:56 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h137sm194348wmg.41.2019.03.14.14.47.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 14:47:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/8] commit-graph: fix segfault on e.g. "git status"
Date:   Thu, 14 Mar 2019 22:47:35 +0100
Message-Id: <20190314214740.23360-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190221223753.20070-1-avarab@gmail.com>
References: <20190221223753.20070-1-avarab@gmail.com>
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
 commit-graph.h          |  1 +
 t/t5318-commit-graph.sh |  3 ++-
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 47e9be0a3a..980fbf47ea 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -233,6 +233,9 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		last_chunk_offset = chunk_offset;
 	}
 
+	if (verify_commit_graph_lite(graph))
+		return NULL;
+
 	return graph;
 }
 
@@ -1075,6 +1078,36 @@ static void graph_report(const char *fmt, ...)
 #define GENERATION_ZERO_EXISTS 1
 #define GENERATION_NUMBER_EXISTS 2
 
+int verify_commit_graph_lite(struct commit_graph *g)
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
 int verify_commit_graph(struct repository *r, struct commit_graph *g)
 {
 	uint32_t i, cur_fanout_pos = 0;
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
 
diff --git a/commit-graph.h b/commit-graph.h
index 096d8bac34..275f97d006 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -70,6 +70,7 @@ void write_commit_graph(const char *obj_dir,
 			struct string_list *commit_hex,
 			int append, int report_progress);
 
+int verify_commit_graph_lite(struct commit_graph *g);
 int verify_commit_graph(struct repository *r, struct commit_graph *g);
 
 void close_commit_graph(struct repository *);
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

