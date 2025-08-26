Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD2C2F60A5
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193819; cv=none; b=exgGAdbdIjVMyS0Ebw5wmYbvt33XpfwHZgXKjbt9P97rUa8Ec0DpNFh5rDHat/h7BspnMLIdXHiE5tQAH6PLlDeFk2mvErVnghZ8TUOAUkyBx+UV5G5HvMMRBOXXSfuTACKQP1VjR+etiAmLVvgSEBvbREBgob7iniLBIZdShD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193819; c=relaxed/simple;
	bh=0DSeY5lwFgIuUmPlYOBEUSCwORzO3qk5PMaUOE3pKt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BA+m+qHOZ40L9Sj2/tChp/bT9ZFB/5nPOTIyv1gYgVvBQ9MQJPfZqyAfXPNA50Pjj8TI3S8/GVRVHqIRIHVa2Pl/k4y9pHuSGYR52b6qm/HklLvlQTxS2OJ3+mT7S7VAGzOYrZvlqj3lnYSK5uyyw+sXrD0hhYkz1+jyH9tiVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cv03HZD+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cv03HZD+"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so5046721b3a.2
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 00:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756193817; x=1756798617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmN5oYWplPFUur6U2cjlWGQNEzTu6GP7Y1ltB2dIVrc=;
        b=cv03HZD+E0YHorfws15T/C529zpE9dRAAAwOxZlH9guuoA3Jr00umFl4Z7mrCGdKDy
         0+SSSWPbVmNaka0PmCZDP5H1zdoj+os59oDqaHn4eu1Jj6A9Jf3k1lXfC3iUPZUvXe1e
         UXkOGUz7xmZKtBVwnJ8dV0AovWJp4CxSMw+WevVUefEYdqsYjLNk85Rl175QxLFVxqxz
         /dK4yugHOAXHi8O2D3eVB/HyK0PKHkcsf/1o+uKi4vpHRnAF5RUSm83GQ1jV0MBcRXaO
         ZvsRmoLaxBrFzdRgtmnCBX4U7gUokCXXq6ptQNXTMc/IYnmSyvlAaVVsOH792ecAE524
         Rexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193817; x=1756798617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmN5oYWplPFUur6U2cjlWGQNEzTu6GP7Y1ltB2dIVrc=;
        b=AXz8egHrj6xfs57A+OCF9w/3uUzL4qFogjSwswh+uvGXnxhugfDMlkZWPQV4xWZwwu
         Iw3UQDZyQL4b2rMYfoP8PRY57HseorsGzfCqaFqHwfSLVbQt++2/0hl3OMX1Rcoy5QZG
         o/ymrk7n0imNg5CgLxlwqAPSgp4L9SialylHHVMr7I13Dy+rrUY8NUoLLY0nnRJMFy2R
         Y8tNOp2DHiM7be7m4LNRJ+6kjElEmwEbmOL8+FxNfGSxmr5HzHd+AnTZ8tNlJSk4Vqps
         yvR/IUDOeIGz6phGAhSVAKg4cWl5Avyqn04QIRb2/TLuPQdPxyblC8cc/nAb8tVT5Ney
         Q9zg==
X-Gm-Message-State: AOJu0YxUWF3BH1OAG8B6L9vXe1xinEuCzkFUZ4v85Ccvy6NfLECn+iTP
	ugEx8X6sN3Pe2tOBCU9gBgs7btOobhpdqAyLykKgmK0QN2ng81HB1ElRszjulw==
X-Gm-Gg: ASbGnct8ZuVzavfftsHJ6ERmkaVt9KJNkBXQo/IrflwoGgYoECb5c+Mwy2/BQ+X5SSo
	WuEJJc5QKi8DCj7AGgghw8AEo3XlGXvL/IXgEdhMefcPyaSX4vzZSYDRjIYJRNL2SqQ1DIpF370
	90o3MSh+DZFLUTubEwLCoeaJk1Tt2vJ2C2coHkzBolnT2w4TEsEN2U3tJUSv0uLKdT1nXT+xncp
	f6qnO5k5Fui48xPIWGPJD16Oa+wpAlvXoieY/5ThIIVBnEcw6krS+uo7+eEomjmruVMKtzoO4FH
	ZdIcwxxRz4LnMvMTdcODEPAorcawuyJcPFUwHidbjU7l6JunbiEP7VwxhtrkTpfOhGm0T21P4kF
	21mkizV6A7OnMKHQJCO3Zb9OzDFfV+g==
X-Google-Smtp-Source: AGHT+IFbNoeeESrVVKBzQJxH5bpbP+ufHJUvDoV8OxuZbLS9AviOwL1gNmPhtk4SZ6oOME4mmldJhw==
X-Received: by 2002:a05:6a00:a02:b0:76e:987b:1dc with SMTP id d2e1a72fcca58-7702f9f5b6emr19831326b3a.12.1756193817221;
        Tue, 26 Aug 2025 00:36:57 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e814cbe1sm4046216b3a.27.2025.08.26.00.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:36:56 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH 3/5] builtin/refs: add optimize subcommand
Date: Tue, 26 Aug 2025 13:06:43 +0530
Message-Id: <20250826073645.1074397-4-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826073645.1074397-1-meetsoni3017@gmail.com>
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the ongoing effort to consolidate reference handling,
introduce a new `optimize` subcommand. This command provides the same
functionality and exit-code behavior as `git pack-refs`, serving
as its modern replacement.

Implement `cmd_refs_optimize` by having it call the `pack_refs_core()`
helper function. This helper was factored out of the original
`cmd_pack_refs` in a preceding commit, allowing both commands to
share the same core logic as independent peers.

Add documentation for the new command. The man page leverages the shared
options file, created in a previous commit, by using the AsciiDoc
`include::` macro to ensure consistency with git-pack-refs(1).

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-refs.adoc | 10 ++++++++++
 builtin/refs.c              | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index e608980711..121a2fbeff 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -18,6 +18,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
 		   [(--exclude=<pattern>)...] [--start-after=<marker>]
 		   [ --stdin | <pattern>... ]
+git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
 
 DESCRIPTION
 -----------
@@ -38,6 +39,11 @@ list::
 	formatting, and sorting. This subcommand is an alias for
 	linkgit:git-for-each-ref[1] and offers identical functionality.
 
+optimize::
+        Pack references into a single file to improve repository performance
+        and reduce storage usage. This subcommand is an alias for
+        linkgit:git-pack-refs[1] and offers identical functionality.
+
 OPTIONS
 -------
 
@@ -73,6 +79,10 @@ The following options are specific to 'git refs list':
 
 include::for-each-ref-options.adoc[]
 
+The following options are specific to 'git refs optimize':
+
+include::pack-refs-options.adoc[]
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 76224feba4..e05fa5b8a6 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "fsck.h"
+#include "pack-refs.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "strbuf.h"
@@ -14,6 +15,9 @@
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
 
+#define REFS_OPTIMIZE_USAGE \
+	N_("git refs optimize " PACK_REFS_OPTS)
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo UNUSED)
 {
@@ -113,6 +117,16 @@ static int cmd_refs_list(int argc, const char **argv, const char *prefix,
 	return for_each_ref_core(argc, argv, prefix, repo, refs_list_usage);
 }
 
+static int cmd_refs_optimize(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	static char const * const refs_optimize_usage[] = {
+		REFS_OPTIMIZE_USAGE,
+		NULL
+	};
+	return pack_refs_core(argc, argv, prefix, repo, refs_optimize_usage);
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -122,6 +136,7 @@ int cmd_refs(int argc,
 		REFS_MIGRATE_USAGE,
 		REFS_VERIFY_USAGE,
 		"git refs list " COMMON_USAGE_FOR_EACH_REF,
+		REFS_OPTIMIZE_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -129,6 +144,7 @@ int cmd_refs(int argc,
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
 		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
 		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
+		OPT_SUBCOMMAND("optimize", &fn, cmd_refs_optimize),
 		OPT_END(),
 	};
 
-- 
2.34.1

