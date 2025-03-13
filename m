Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170CFC0B
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825280; cv=none; b=NYSOAXDXBDWVuUhssaNVuY+KceqG3GuHRhj+ytePOmsQxiU5ySxISVup03BLWCqdpm7pDGKGKDqXQ4PGsoQaAjtyb6frXL5UAt08hx7qvyoubGJf87NOdpB7hl+HJxr0ObdPLA60FYjZ3nCySwyJoqKp8amSYlfqs4txG20oq+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825280; c=relaxed/simple;
	bh=pnUrcVzfhDwmwHhW7nXOCQMnp1DWq9nvmw8OyM14Z6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4JE2ZKVUVD/GNdYtGlutkXDkJNPVoov7KZzmjeKRPyQuRCrwq+JzAenT5u+S3C8dKr3WhNatRrrwjhcUlSuODv/nYTyoET3qv+IHwNFS3ql/Hwu0EbEM+5dcEMvIKMcgTaZEywqdDFkeO6jyiRqHKaKD1AO8qOvdV7TcLOaGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RA73Zmbk; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RA73Zmbk"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72a0a9cb29fso253863a34.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 17:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741825277; x=1742430077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG/RDhQ++6Lu7GLLG+X9qvWRXgk7wQ2sLknwdcmVfH4=;
        b=RA73ZmbkYrou7B3wj90kKeAJ/pkG1h2Fvfc+kBAGn4O/EHhVUT95AJ+dgKj1AJLh3I
         spOwNnls62XxKZuW7Ci33dsmDgVHRMAf3BBDcJYqnHub3DicUcxDB1leN7lFUWxxgLaz
         El9St7zwz5BSYQOWVpjXol5cDnHoJX6zh+wvXZp7CMgdeWsog4jQ1RhthsRrhePU+SNo
         6JAZEpoN0QO7Oia3MP48C+l3BFtb4pauWSu/1EUIGA2ryp/+4VtIw/8v0h3PdLS3rqgU
         20tD9Y6gdeC8hmnXbWhUM0N/V4U6avtjud1WpLgQPERAyK+ajgkuh4pVgHSHDv8Or+XR
         ZEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741825277; x=1742430077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XG/RDhQ++6Lu7GLLG+X9qvWRXgk7wQ2sLknwdcmVfH4=;
        b=gJnivHumpmt+5p/3u34ZZgA18ejz5BGrxNJ/ZedsMgZjnDYOsTihGACsb60sp89pRq
         zNyKxNJBtxUkGGpQL7INDYcB68JgK8aHX4AJEGdOsCElG5h1kT0tIqvULqd3TVFUMua7
         BNthdISqMuKXxgngg6Z5fGUPj5qzIvC4rPuIWbrKEfTZPVc1eLHuC1dpcvi4fVmIF1I/
         Vvfbe7Dcayf1Q6EEkV82o/tYKcq38dHep6Yzrp8oZ+LLBAAELadH5PWkAlx6Q9FEH5UY
         bUD2yyy4IVzTg5h3+KW7KE8GgbptbttRcWes+S3VTc1/Q5hylH4RjZ1hg/KmLwo1lFTB
         Mt9g==
X-Gm-Message-State: AOJu0YwhYC91qy146+W9rHMY7aotiM1WLWjblzs19k3xqoM0tJnMR8c5
	buHjFcoeq8580PB1ZSQRzWPQkZSSj2KCtDmfHmFoe7DQ3jdyMCqIWsfHvGLD
X-Gm-Gg: ASbGncsdrVTyphy1m2TOJi+mnwiU2Wj6cyrcHLz0ivoaMjpfNo9SJATL7YmhJOl9IS8
	OwtTsorXODNtmJLpW0tB4u1jXVtetjPnt960VWtIjnaQq6D7nV8uJCFPqZXLaq2xsnEDz6wbXaN
	CmSdAepHISSyrxHWt4dTUOspsCOKeuBhzhai0RwJLFh3ln04OtCy5TRb98g2uB3LA5Jt3HfgH6y
	cJzLUwG75YAP5RZbRgr8pQZNKUza5lHZTYzoP4tFqSOAald/aRfwOXT+hCMaePMnAhWckWjdcOF
	mj4vCQ0qBJBY+yhnIzMtl6yFhKUTlB7NDOADS12ayKuE+RXjdZDdrGcO9PETpKw=
X-Google-Smtp-Source: AGHT+IFxyRTSFp2ezk7O+1aopi2Uq7tGRVE+aXH/kJDKXOgh0fnjwRIyeKSXKIu25iWRmaB403y0wA==
X-Received: by 2002:a05:6830:6c8e:b0:72a:449e:2b6e with SMTP id 46e09a7af769-72a449e302emr8746164a34.5.1741825277089;
        Wed, 12 Mar 2025 17:21:17 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb267a8b4sm24028a34.9.2025.03.12.17.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 17:21:16 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/6] rev-list: support delimiting objects with NUL bytes
Date: Wed, 12 Mar 2025 19:17:04 -0500
Message-ID: <20250313001706.3390502-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313001706.3390502-1-jltobler@gmail.com>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250313001706.3390502-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When walking objects, git-rev-list(1) prints each object entry on a
separate line. Some options, such as `--objects`, may print additional
information about tree and blob object on the same line in the form:

        $ git rev-list --objects <rev>
        <tree/blob oid> SP [<path>] LF

Note that in this form the SP is appended regardless of whether the tree
or blob object has path information available. Paths containing a
newline are also truncated at the newline.

Introduce the `-z` option for git-rev-list(1) which reformats the output
to use NUL-delimiters between objects and associated info in the
following form:

        $ git rev-list -z --objects <rev>
        <oid> NUL [path=<path> NUL]

In this form, the start of each record is signaled by an OID entry that
is all hexidecimal and does not contain any '='. Additional path info
from `--objects` is appended to the record as a token/value pair
`path=<path>` as-is without any truncation.

In this mode, revision and pathspec arguments provided on stdin with the
`--stdin` option are also separated by a NUL byte instead of being
newline delimited.

For now, the `--objects` and `--stdin` flag are the only options that
can be used in combination with `-z`. In a subsequent commit,
NUL-delimited support for other options is added. Other options that do
not make sense with be used in combination with `-z` are rejected.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.adoc | 23 ++++++++++++++++++
 builtin/rev-list.c                  | 36 +++++++++++++++++++++++++----
 t/t6000-rev-list-misc.sh            | 35 ++++++++++++++++++++++++++++
 t/t6017-rev-list-stdin.sh           |  9 ++++++++
 4 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 785c0786e0..166d3cd19e 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -361,6 +361,29 @@ ifdef::git-rev-list[]
 --progress=<header>::
 	Show progress reports on stderr as objects are considered. The
 	`<header>` text will be printed with each progress update.
+
+-z::
+	Instead of being newline-delimited, each outputted object and its
+	accompanying metadata is delimited using NUL bytes in the following
+	form:
++
+-----------------------------------------------------------------------
+<OID> NUL [<token>=<value> NUL]...
+-----------------------------------------------------------------------
++
+Additional object metadata, such as object paths, is printed using the
+`<token>=<value>` form. Token values are printed as-is without any
+encoding/truncation. An OID entry never contains a '=' character and thus
+is used to signal the start of a new object record. Examples:
++
+-----------------------------------------------------------------------
+<OID> NUL
+<OID> NUL path=<path> NUL
+-----------------------------------------------------------------------
++
+This mode is only compatible with the `--objects` output option. Also, revision
+and pathspec argument parsing on stdin with the `--stdin` option is NUL byte
+delimited instead of using newlines while in this mode.
 endif::git-rev-list[]
 
 History Simplification
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 04d9c893b5..f048500679 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -65,6 +65,7 @@ static const char rev_list_usage[] =
 "    --abbrev-commit\n"
 "    --left-right\n"
 "    --count\n"
+"    -z\n"
 "  special purpose:\n"
 "    --bisect\n"
 "    --bisect-vars\n"
@@ -97,6 +98,9 @@ static int arg_show_object_names = 1;
 
 #define DEFAULT_OIDSET_SIZE     (16*1024)
 
+static char line_term = '\n';
+static char info_term = ' ';
+
 static int show_disk_usage;
 static off_t total_disk_usage;
 static int human_readable;
@@ -264,7 +268,7 @@ static void show_commit(struct commit *commit, void *data)
 	if (revs->commit_format == CMIT_FMT_ONELINE)
 		putchar(' ');
 	else if (revs->include_header)
-		putchar('\n');
+		putchar(line_term);
 
 	if (revs->verbose_header) {
 		struct strbuf buf = STRBUF_INIT;
@@ -361,12 +365,16 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
 	printf("%s", oid_to_hex(&obj->oid));
 
 	if (arg_show_object_names) {
-		putchar(' ');
-		for (const char *p = name; *p && *p != '\n'; p++)
-			putchar(*p);
+		if (line_term) {
+			putchar(info_term);
+			for (const char *p = name; *p && *p != '\n'; p++)
+				putchar(*p);
+		} else if (*name) {
+			printf("%cpath=%s", info_term, name);
+		}
 	}
 
-	putchar('\n');
+	putchar(line_term);
 }
 
 static void show_edge(struct commit *commit)
@@ -642,6 +650,10 @@ int cmd_rev_list(int argc,
 			revs.exclude_promisor_objects = 1;
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(arg);
+		} else if (!strcmp(arg, "-z")) {
+			s_r_opt.nul_delim_stdin = 1;
+			line_term = '\0';
+			info_term = '\0';
 		}
 	}
 
@@ -757,6 +769,20 @@ int cmd_rev_list(int argc,
 		usage(rev_list_usage);
 
 	}
+
+	/*
+	 * Reject options currently incompatible with -z. For some options, this
+	 * is not an inherent limitation and support may be implemented in the
+	 * future.
+	 */
+	if (!line_term) {
+		if (revs.graph || revs.verbose_header || show_disk_usage ||
+		    info.show_timestamp || info.header_prefix || bisect_list ||
+		    use_bitmap_index || revs.edge_hint || revs.left_right ||
+		    revs.cherry_mark || arg_missing_action || revs.boundary)
+			die(_("-z option used with unsupported option"));
+	}
+
 	if (revs.commit_format != CMIT_FMT_USERFORMAT)
 		revs.include_header = 1;
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 6289a2e8b0..dfbbc0aee6 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -182,4 +182,39 @@ test_expect_success 'rev-list --unpacked' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list -z' '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+
+	oid1=$(git -C repo rev-parse HEAD) &&
+	oid2=$(git -C repo rev-parse HEAD~) &&
+
+	printf "%s\0%s\0" "$oid1" "$oid2" >expect &&
+	git -C repo rev-list -z HEAD >actual &&
+
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list -z --objects' '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+
+	oid1=$(git -C repo rev-parse HEAD:1.t) &&
+	oid2=$(git -C repo rev-parse HEAD:2.t) &&
+	path1=1.t &&
+	path2=2.t &&
+
+	printf "%s\0path=%s\0%s\0path=%s\0" "$oid1" "$path1" "$oid2" "$path2" \
+		>expect &&
+	git -C repo rev-list -z --objects HEAD:1.t HEAD:2.t >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index 4821b90e74..362a8b126a 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -148,4 +148,13 @@ test_expect_success '--not via stdin does not influence revisions from command l
 	test_cmp expect actual
 '
 
+test_expect_success 'NUL-delimited stdin' '
+	printf "%s\0%s\0%s\0" "HEAD" "--" "file-1" > input &&
+
+	git rev-list -z --objects HEAD -- file-1 >expect &&
+	git rev-list -z --objects --stdin <input >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.49.0.rc2

