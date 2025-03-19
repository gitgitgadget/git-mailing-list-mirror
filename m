Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351D20B7E8
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409478; cv=none; b=apRrs4NMU238qZ4xKHejUX+DxWerrnMDB1osmN4usRO/wfxqDcwr2OXtloAxpEKxCUQl4EPLPx3N+jBPGEmv4gzRZ6gNxIxZqCnHG7U4j7LVlbbDYDHOlHQ0w++C3jPoKdUkYWS/T74LxyluUU5cfEsWO6XOsYtkp0Vf1aZEKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409478; c=relaxed/simple;
	bh=1ri0Yvle3HOAwEKdNm9itxSgSocxZMnxm5aOWYaWHhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QA4vI0fCW7D+Z3Lf7fFObNaoOsTkuniibGG/LMJiRshJor9O7PXwm671ooE0a2j63kRyQyvmpEdzJFzSHj6bLkSJsjvopxl4BGlXZhzJ6ks3W5g+RhSqjfOht+roSmaZVwz6nrDtxITwHQ4kOLWyzjTFtg7D82zcLmwf0K91C+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBiP+WtQ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBiP+WtQ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72bb9725de4so517a34.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742409475; x=1743014275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQVXCYQtc1oR2c6RpGn5NHX8fVCOMoNbZ3Y9aQTvuHU=;
        b=bBiP+WtQJS+CI+mVjh0fAEeY4UuzAyZIISimEeHGdeDjBfBd7NHir/5Nl2VX6PHHeq
         /v2mcZKiOw76y3x8DImKZejkVL3hYNQyh64HXLwidIgPsH7R5RuAe1GnpJ9QN3qfhc9x
         rXE0m/u0P28r3lz0J7m59gtEwVDQdGbpgFmpugHj77RH9zwUtrNgo/2joLxRaes7BcWT
         CnacBUuIVHGa/Z8FaZnAXyiFu1semJNVR+kmk81SG+1kmqZIssZ5Puwdc4+soUSJDweC
         rTkazNQQPy7tzc7mRJj/QvKiz0Yr5uIj7HJZ28iyDMG+nKjeoWGLWjbMo7wiZlq2np2L
         Y+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409475; x=1743014275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQVXCYQtc1oR2c6RpGn5NHX8fVCOMoNbZ3Y9aQTvuHU=;
        b=c41z+OAPUh4IENr5VrCOOCwQYn1rq9y1dyvuhMsE/WAlNNH4D2dVdFi1R4iHgDi8GE
         uJXdJStZJKqHjsqcq+l0882parLKuqyPj1KVtOWn7rKmHqhrYT7Aj9rg4PbkDS2QvxUW
         CEMuoNV69Y7gQ0fF7xMOGHtAvNETBosHvNf3kCfeQjhzeRS1/INwhfFNfIjEm43r4N80
         9ioEKOzBpk/qZCOSg/uV4jSuws/L4xU5ZZLU2hC2UILj/atK35zPVEXMOg9WBpepXBG/
         8yHw1ecbs7/09BDjtRfUyLH3awTT/Cgfc9ucNeuRBax4Y4P7lC9DYacKEsXjjyu/so2v
         doVw==
X-Gm-Message-State: AOJu0YzZOq7XbhcogY0QYvxnylt2Vf/IrZsRJriGOTK+Hhq1ByyWDWMJ
	SBGeGykpuUdBA431HcTLgGCzFu3lVCLHZmx2Kjrc14y3XbnP/Q/r3GLv9g==
X-Gm-Gg: ASbGnctmqIMysFILmRtITOJ2k0SttLe7t31x8j8Wh2dGFm7TFpD4SG26zZCr78c6MkB
	QGr3FDdCSGa2jxG8De4pAV0Xe4Lz+BikcxkQOoQAkDhHRcGiXhRMhhqbyIptSPVvKyS1Cryo7Xt
	2w6MWVq1ncbN5/IEj8IMQBQa2+vcrVOn3YGo66uE+ObUuptPjEBfRDZH7l/KVfk9HvD+wv20eG3
	axJ5xb3NivxXNfwdLW8lhIGAM1zGFpq/ORUZgbYLJNyWc6YE8WGgURacxlPUBpwODlDPmrNrmPB
	e0HNrI2Qyi7xA6C0bL9IB2KUZmNiHOcWqmG1hGb5vLIoWGAMyHqL
X-Google-Smtp-Source: AGHT+IG9nvHXNPhOL1TBLlyb+AUpIr+MOtL0obOKhaf37geJPsInrk1lBLeDDQ4WqjKcMIicyD4wrQ==
X-Received: by 2002:a05:6830:6d84:b0:72b:95e5:edab with SMTP id 46e09a7af769-72bfbdbec9fmr3377402a34.1.1742409475409;
        Wed, 19 Mar 2025 11:37:55 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e796sm2561943a34.48.2025.03.19.11.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:37:54 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 3/5] rev-list: support delimiting objects with NUL bytes
Date: Wed, 19 Mar 2025 13:34:08 -0500
Message-ID: <20250319183410.1225428-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250319183410.1225428-1-jltobler@gmail.com>
References: <20250313235747.9583-1-jltobler@gmail.com>
 <20250319183410.1225428-1-jltobler@gmail.com>
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

For now, the `--objects` flag is the only options that can be used in
combination with `-z`. In a subsequent commit, NUL-delimited support for
other options is added. Other options that do not make sense when used
in combination with `-z` are rejected.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.adoc | 21 +++++++++++++++++
 builtin/rev-list.c                  | 35 ++++++++++++++++++++++++-----
 t/t6000-rev-list-misc.sh            | 35 +++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 785c0786e0..aef83813b8 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -361,6 +361,27 @@ ifdef::git-rev-list[]
 --progress=<header>::
 	Show progress reports on stderr as objects are considered. The
 	`<header>` text will be printed with each progress update.
+
+-z::
+	Instead of being newline-delimited, each outputted object and its
+	accompanying metadata is delimited using NUL bytes. Output is printed
+	in the following form:
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
+This mode is only compatible with the `--objects` output option.
 endif::git-rev-list[]
 
 History Simplification
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 04d9c893b5..17de99d9ca 100644
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
@@ -642,6 +650,9 @@ int cmd_rev_list(int argc,
 			revs.exclude_promisor_objects = 1;
 		} else if (skip_prefix(arg, "--missing=", &arg)) {
 			parse_missing_action_value(arg);
+		} else if (!strcmp(arg, "-z")) {
+			line_term = '\0';
+			info_term = '\0';
 		}
 	}
 
@@ -757,6 +768,20 @@ int cmd_rev_list(int argc,
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
index 6289a2e8b0..886e2fc710 100755
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
+	oid1=$(git -C repo rev-parse HEAD~) &&
+	oid2=$(git -C repo rev-parse HEAD) &&
+
+	printf "%s\0%s\0" "$oid2" "$oid1" >expect &&
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
-- 
2.49.0.rc2

