Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D3202997
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 06:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755928824; cv=none; b=lALCkxRHAg0Xi6R1hkLTIEtUVhs3qrTEr2IuQ7uqNvLGkdN7+vMbR9ngk2R57vNSDWQ2WZxVWmeyPEpIrnk8RJvs1lqAA8tnsKHL4o+ks52IOc2X6eGeYX0AYo5Wb5y/wdV+Ph1jGLO1Jc77j5GoWiOJR6WwlrSz2iShiUwG4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755928824; c=relaxed/simple;
	bh=9evmU7pmSDoCJVIfdWLjaNwplpQI8LtPu7lSrIVKmV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKMYWTdiJnH6bGAqhfZJ5+YwZF15sBXGdJcgkJboVu3aUhdjeFqNdI34a/SdO6p8d7mWbVteUN8dXUMFPBzFYpHUbs7Kv0imGKfSBB3fAl/fz5jLDfn+yyaPFGZ+LZoEPJ8GI+9b8qrdbetcdTNLpJm9nLG+8olNOF3fY3Q30BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=le+3Gxl+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="le+3Gxl+"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so2923708b3a.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 23:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755928821; x=1756533621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhT2tJVg/2nJsxbvo/Yg5nTL8E1aYmi59y/5rAGP73k=;
        b=le+3Gxl+ulQOdCQZ+KiZW6KaGVgW90dFyXJ1vkEWRVG4fQNZQMcKGZPymgMA7aDIgX
         7lHHGI+goJBcu9oHYmhqRHjeLZ89H1UW9z4J2cuuZ+1XtioQyR5ls9UpsndfbRPCegws
         UDMxrMlTzUy8HgHoIbpFb/sxEno2U8IlNJt/VbXt+ojRRfMSx40ymOClz0BoVYDj5b0o
         YoHp+0XUWS0bmfSod75ohjn23gs5TY57OQaxrWiB06yTUloxt/7TzvgTyuAxscBYbCsa
         GWg1Jj9oYSqfDY0hMgLzl3p8l1xEyDipQoV11crRJKScAEhn5ZGTb/uhGBwhWBHGwpNa
         TMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755928821; x=1756533621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhT2tJVg/2nJsxbvo/Yg5nTL8E1aYmi59y/5rAGP73k=;
        b=EcPrBJHogg6NOk9oRuKEJr39JIRuc2C6TKDVKL3MRiWTmM0lADlJgVZyR/rr8PP5b3
         t3ifShhV8tmDTnLgfnxeWPos15bApRvrzm6xRUqXvPWA06FMR7u0X6vCz4FL/7Bq91cx
         XDxJD3QX9Hv6fCXBdPZ76/vCjM7bGkoo7x/7K1DLrc5Uq5O2A1pMilw5KAwjoZuu5SiY
         sWs76h+mBDMuzjmHGCxH5FlOTLnJ0bSodQc6AFKq4jXm/tj/UgmPKTVsxuT4zX3GtUDR
         PFRrTXXe3J8uVXJkgVN003E8lHIck41MormxFrrHGLsMk2gYPH4CO97439MgFLYWqyND
         jBkg==
X-Gm-Message-State: AOJu0Yybs1hExlJGq4XIy/fEJESykzC9sDJ6ul30cPf5ASYaRrYM8zgt
	pa/3zWP2bT/JnYi6M0e2IozxC4bMHgCcx4Uc0MhyqKnm5MvcgQFbi/8ElnTbeg==
X-Gm-Gg: ASbGncsGR4Ern7XgqzKXVX+S6lqFXHXxBZ6E3FZlvAq3TkQWNWzX9Xvm8u7shK3Akaa
	rMatM6qVDKw91Qz6SNtQ4/9MB6qnMKqWJ35E/jr5Y40dREhtn836tEBmqR59QHK9y4l9LGTNqwT
	I7OJrCTYrFYjulajWTldJKSojQ/5wCgYDARO62zdTpAFIVugN5cQLnwNyScCYzMgQZlkrSaTfpm
	q74hqy0oBGIcEw4RaPNce9JAJvldZYWfdGnfE9R0/wL/gdr3pQxktSWynTZm+8CKFskJCzggsYT
	MyMC9rLlXtv07EQh68vo8KxPknSFKW+sa83FvA5pm2T7kCVm8TbuUuKnoo5EL1Uct6RJE96QLUs
	8CXlRriSNl9wMZGD/R0ZFaXOc0HgrNQ==
X-Google-Smtp-Source: AGHT+IERMtG/UclKczU/ySTvFtvefDLrep0iXmFBYRJhgGWx/aTzYL0sVCaXbEB6y45e4G4xCTqlfg==
X-Received: by 2002:a05:6a20:394b:b0:23d:6475:40aa with SMTP id adf61e73a8af0-2434089fd50mr8267517637.0.1755928821320;
        Fri, 22 Aug 2025 23:00:21 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7b6fbsm1434145a12.30.2025.08.22.23.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 23:00:20 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v2 1/4] builtin/refs: add 'exists' subcommand
Date: Sat, 23 Aug 2025 11:30:09 +0530
Message-Id: <20250823060012.540433-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823060012.540433-1-meetsoni3017@gmail.com>
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
 <20250823060012.540433-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the ongoing effort to consolidate reference handling,
introduce `exists` subcommand. This command provides the same
functionality and exit-code behavior as `git show-ref --exists`, serving
as its modern replacement.

The logic for `show-ref --exists` is minimal. Rather than creating a
shared helper function which would be overkill for ~20 lines of code,
its implementation is intentionally duplicated here. This contrasts with
`git refs list`, where sharing the larger implementation of
`for-each-ref` was necessary.

Documentation for this subcommand is also added to the `git-refs(1)`
man page.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-refs.adoc |  7 ++++++
 builtin/refs.c              | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index e608980711..5d2032b318 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -18,6 +18,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
 		   [(--exclude=<pattern>)...] [--start-after=<marker>]
 		   [ --stdin | <pattern>... ]
+git refs exists <ref>
 
 DESCRIPTION
 -----------
@@ -38,6 +39,12 @@ list::
 	formatting, and sorting. This subcommand is an alias for
 	linkgit:git-for-each-ref[1] and offers identical functionality.
 
+exists::
+	Check whether the given reference exists. Returns an exit code of 0 if
+	it does, 2 if it is missing, and 1 in case looking up the reference
+	failed with an error other than the reference being missing. This does
+	not verify whether the reference resolves to an actual object.
+
 OPTIONS
 -------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 76224feba4..91548783b7 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "worktree.h"
 #include "for-each-ref.h"
+#include "refs/refs-internal.h"
 
 #define REFS_MIGRATE_USAGE \
 	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
@@ -14,6 +15,9 @@
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
 
+#define REFS_EXISTS_USAGE \
+	N_("git refs exists <ref>")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo UNUSED)
 {
@@ -113,6 +117,48 @@ static int cmd_refs_list(int argc, const char **argv, const char *prefix,
 	return for_each_ref_core(argc, argv, prefix, repo, refs_list_usage);
 }
 
+static int cmd_refs_exists(int argc, const char **argv, const char *prefix,
+			   struct repository *repo UNUSED)
+{
+	struct strbuf unused_referent = STRBUF_INIT;
+	struct object_id unused_oid;
+	unsigned int unused_type;
+	int failure_errno = 0;
+	const char *ref;
+	int ret = 0;
+	const char * const exists_usage[] = {
+		REFS_EXISTS_USAGE,
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, exists_usage, 0);
+	if (argc != 1)
+		die(_("'git refs exists' requires a reference"));
+
+	ref = *argv++;
+	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
+			      &unused_oid, &unused_referent, &unused_type,
+			      &failure_errno)) {
+		if (failure_errno == ENOENT || failure_errno == EISDIR) {
+			error(_("reference does not exist"));
+			ret = 2;
+		} else {
+			errno = failure_errno;
+			error_errno(_("failed to look up reference"));
+			ret = 1;
+		}
+
+		goto out;
+	}
+
+out:
+	strbuf_release(&unused_referent);
+	return ret;
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -122,6 +168,7 @@ int cmd_refs(int argc,
 		REFS_MIGRATE_USAGE,
 		REFS_VERIFY_USAGE,
 		"git refs list " COMMON_USAGE_FOR_EACH_REF,
+		REFS_EXISTS_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -129,6 +176,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
 		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
 		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
+		OPT_SUBCOMMAND("exists", &fn, cmd_refs_exists),
 		OPT_END(),
 	};
 
-- 
2.34.1

