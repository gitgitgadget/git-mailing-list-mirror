Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB0B666
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910516; cv=none; b=lzmId/Lr3tbHv7QIkhnFy6rJeKVNvPn1RVUvrp1eaZgWCrTH515vmcSCHiBkrhOhrA7EKFJXIS1oYE2M6ORHHBYx0Iij5NhxrITv2xXxOwlsmOaKCbgsrZ3hDaMv7ERvRCsf/KQaVgMhWTKHOqOvZFrQIQPITbaovdSOUv6I6PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910516; c=relaxed/simple;
	bh=88FZpwprawUSteQxa3xEbaTsl6pxzgSNK6v8lTNWCa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgqouZv0sfj3UvtJEtdgeSkVI/124y4kIENj8DpzD3pxGJZZdkSxkzF0uDt314GGHXhMbFYj1KEUHFVsRsmNFtEo/a1g/N3CbkSJ26ml2Id/tkImSirWNyxs/wonceTfNHaNHX9ezPiSFI/VqJdaHJAU3WyyVPzzddwh1qn4IKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcynQeiZ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcynQeiZ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72726e4f96cso1082256a34.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741910513; x=1742515313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHIaAkLgr1QyCTUkWHHHsjUZcVf5huqVvZpIuQz5XdU=;
        b=AcynQeiZ4yaLy0fUDrX7UaY2eDuAVO+SUhkDecuot9yvYwzj6KjFPN3pcyvV0MKwoj
         dsC45Frgrn3xMN2PKuwf+a7QBJwceuXxEmUmgtis4YHUoBgHjzITJ2vWm3WDkg5XGwwH
         RDdiOLRmc6T5A4BkvCUtF7NubCv2f5CgXb640Ydu0P+DUag3/DaZ548NmyL1tnCSU0qd
         B4ofhxBhE/kSH5XExaLtJc/ckd6vaOF7oGQjYdeSw14405Wcsxc2gRR9Q1ko3L6l2HdH
         s0TR/1up+FxBZKzwSuH67OR9wLadzz5JyZUGmLa6mJr6DpRdyYcK8j8hOQFvAQDZNZ0u
         WDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741910513; x=1742515313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHIaAkLgr1QyCTUkWHHHsjUZcVf5huqVvZpIuQz5XdU=;
        b=wAi1iMUjJMWYxQj+ebeUWMb7Mjd6iUWZ+ZHpJkd0iu2wfjsk0kRRxGQqsI3ZYsf/Mw
         upHs8m5G+8Ms3pADQV2gC55jeDVZqozwLNYXPTnZDBzswlMliC5GdFW7GDsZTTDE1UIi
         Rx7ZYtyC8N/qk4mUQFLRGA+VSZnrOZOOYVOIvz4+uGlbTNwH9+rEhAkJls/zZShDoNUa
         lQEtBIlKJozHw4sKo2bLSHJaKlRtZ/997oIIkzDnaLTQJWVd9rCXhEFvzFH3537Bt53V
         QN0tkyiMU5rwNbbTrP0VMCaWVrB9YJTJFcworQ490npKjFiQPqideNC7VURwUw7fRi/t
         lGfQ==
X-Gm-Message-State: AOJu0YxsSTtLIkfAndoPP8SSBsLH+fl+n9uQwuLvXi2oPjpEPvXhyfEb
	PXxOrVcgtyyrOv5+myRCE5HegMdOvseh+zzoS9ghoD7hius9tjmns5MM9w==
X-Gm-Gg: ASbGncvOPdQfY+BumRzksw78k4As/EdXiD4Ybte648P8M5ObJHjPSOEhyDbPAotuuvR
	bm5yg4zSXWQw6I9dG3GFqoOfzhxQ/e63etJk98tGzg3fsOj8qYVoGwGOX9r0vd+HK3/b7OiLMSB
	MXA4CQVhIAkc/Z5XJBjQXVQ0+qp2Ho2HUOQuzlIzT1BOoj5y7PXHTucIDIO6Lu3dZE9ujLcV5DR
	sHjlOlnv2Vvs6rul/0zQ5+pGu/+ovkTYkF61ULZQ5bfQE01EnqAl2GvD0vtSDyRRbjlDq0gwSpF
	QnnPDMXvNo4kdBQs0jcHkNASs9vIvm3wS1wGK0qxtPbUYpnGFFIa
X-Google-Smtp-Source: AGHT+IHNjDwVpfzJBna2j+/Nri2ki6eNo3+TYnXOwE0Xv7tsBweM/a0PIue5mZcEwhF4BJCgwaVDEA==
X-Received: by 2002:a05:6830:2aa6:b0:72b:a06b:dd71 with SMTP id 46e09a7af769-72bbc23fc86mr250909a34.5.1741910513031;
        Thu, 13 Mar 2025 17:01:53 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e973sm423485a34.43.2025.03.13.17.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:01:49 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 6/6] rev-list: support NUL-delimited --missing option
Date: Thu, 13 Mar 2025 18:57:47 -0500
Message-ID: <20250313235747.9583-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250313235747.9583-1-jltobler@gmail.com>
References: <20250313001706.3390502-1-jltobler@gmail.com>
 <20250313235747.9583-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--missing={print,print-info}` option for git-rev-list(1) prints
missing objects found while performing the object walk in the form:

        $ git rev-list --missing=print-info <rev>
        ?<oid> [SP <token>=<value>]... LF

Add support for printing missing objects in a NUL-delimited format when
the `-z` option is enabled.

        $ git rev-list -z --missing=print-info <rev>
        <oid> NUL missing=yes NUL [<token>=<value> NUL]...

In this mode, values containing special characters or spaces are printed
as-is without being escaped or quoted. Instead of prefixing the missing
OID with '?', a separate `missing=yes` token/value pair is appended.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.adoc |  5 +++--
 builtin/rev-list.c                  | 31 ++++++++++++++++++++---------
 t/t6022-rev-list-missing.sh         | 31 +++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 92ac31a8e8..f4764b72f5 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -382,10 +382,11 @@ and thus is used to signal the start of a new object record. Examples:
 <OID> NUL
 <OID> NUL path=<path> NUL
 <OID> NUL boundary=yes NUL
+<OID> NUL missing=yes NUL [<token>=<value> NUL]...
 -----------------------------------------------------------------------
 +
-This mode is only compatible with the `--objects` and `--boundary` output
-options.
+This mode is only compatible with the `--objects`, `--boundary`, and
+`--missing` output options.
 endif::git-rev-list[]
 
 History Simplification
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 7c6d4b25b0..036fcc26d5 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -136,24 +136,37 @@ static void print_missing_object(struct missing_objects_map_entry *entry,
 {
 	struct strbuf sb = STRBUF_INIT;
 
+	if (line_term)
+		printf("?%s", oid_to_hex(&entry->entry.oid));
+	else
+		printf("%s%cmissing=yes", oid_to_hex(&entry->entry.oid),
+		       info_term);
+
 	if (!print_missing_info) {
-		printf("?%s\n", oid_to_hex(&entry->entry.oid));
+		putchar(line_term);
 		return;
 	}
 
 	if (entry->path && *entry->path) {
-		struct strbuf path = STRBUF_INIT;
+		strbuf_addf(&sb, "%cpath=", info_term);
+
+		if (line_term) {
+			struct strbuf path = STRBUF_INIT;
 
-		strbuf_addstr(&sb, " path=");
-		quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
-		strbuf_addbuf(&sb, &path);
+			quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
+			strbuf_addbuf(&sb, &path);
 
-		strbuf_release(&path);
+			strbuf_release(&path);
+		} else {
+			strbuf_addstr(&sb, entry->path);
+		}
 	}
 	if (entry->type)
-		strbuf_addf(&sb, " type=%s", type_name(entry->type));
+		strbuf_addf(&sb, "%ctype=%s", info_term, type_name(entry->type));
+
+	fwrite(sb.buf, sizeof(char), sb.len, stdout);
+	putchar(line_term);
 
-	printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
 	strbuf_release(&sb);
 }
 
@@ -784,7 +797,7 @@ int cmd_rev_list(int argc,
 		if (revs.graph || revs.verbose_header || show_disk_usage ||
 		    info.show_timestamp || info.header_prefix || bisect_list ||
 		    use_bitmap_index || revs.edge_hint || revs.left_right ||
-		    revs.cherry_mark || arg_missing_action)
+		    revs.cherry_mark)
 			die(_("-z option used with unsupported option"));
 	}
 
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 3e2790d4c8..08e92dd002 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -198,4 +198,35 @@ do
 	'
 done
 
+test_expect_success "-z nul-delimited --missing" '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m first &&
+
+		path="foo bar" &&
+		echo foobar >"$path" &&
+		git add -A &&
+		git commit -m second &&
+
+		oid=$(git rev-parse "HEAD:$path") &&
+		type="$(git cat-file -t $oid)" &&
+
+		obj_path=".git/objects/$(test_oid_to_path $oid)" &&
+
+		git rev-list -z --objects --no-object-names \
+			HEAD ^"$oid" >expect &&
+		printf "%s\0missing=yes\0path=%s\0type=%s\0" "$oid" "$path" \
+			"$type" >>expect &&
+
+		mv "$obj_path" "$obj_path.hidden" &&
+		git rev-list -z --objects --no-object-names \
+			--missing=print-info HEAD >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.49.0.rc2

