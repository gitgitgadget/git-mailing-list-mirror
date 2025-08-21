Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBBD2ED848
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766377; cv=none; b=Am7ZvERRfnGayjzILLAnp6UJOdYczcBo2ppmysgceXvpK9Z8C4B+gDrBlMmgqWDjcc7mtfN0Zd7o47qXr+XvENA0JhvyH6RpojnTw5JMx5PgOmCXF4V32et4Laz0K8O/mx9pqHI9JFOjXyxXDqqjawcmHiwRoaIhualL9nwH860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766377; c=relaxed/simple;
	bh=QjWoqB+VBoXAWM0rhgprYSSpu1lKhnVAibQZ/iShSYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3JfnPdw0qt3VbbjyVw8LLLSBYyEQj9Wp0zdD07Cq5aviZAfMpQmZ4WNsHV+vaa3N97XPInm303kTT5Fyw/9b4/4SB+yCaD5f1dm/JB024meTeZxqjEEP2UdPWdT3wo2DJiiuPyt/sUcJWjnTEQfWNEhYCGpYFcK2OsiKWr6Uc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPp0nfIO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPp0nfIO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2445806d44fso6018345ad.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755766375; x=1756371175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9h4+JJwFlpRp5toIcGLAnUTPqv4uyNaBdHUYmL2CQk=;
        b=ZPp0nfIOPUMRGalleYFSPS3pTcNdzMOCWnBPIsQroM4OS0ZBm43+91eSJge65a+HGM
         4uca1RMHhssxwsJwUBxrRRc850d0uLjmHdDihDePTybIZNcuFoLv9VCrmvzJtN3+z+MG
         SgA3afVgHDwpQAUzWfBVpvAbOY75NtccdhnUS7SR4uJEahreZP2/lqkEkiMWP4481hYd
         V/2ZbZGGVo3VTGN4AR1ZwEhKazD3TrQjaZZqg7szZ3CkBIHaUQednump7TqI1umrBIkh
         uoJEeTkvjTlDIZCjEuBDDicRMuzYcD0Fy1HXTPRp5lqXF0tDqy4wpbC889V3X1gHZhjJ
         Tqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766375; x=1756371175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9h4+JJwFlpRp5toIcGLAnUTPqv4uyNaBdHUYmL2CQk=;
        b=VKpQbVh8DFerIf+xMHkwcZd7zI2cyHdI49uBRBVfvX87LO51DuqvpPC/JpESTwpTav
         7Hh/LcnmWrRHjg1LeztzUWPN2cKRZJdWMBuhuc779XdGuaSB1MmOEv02t7taYqrw+EY3
         aTnHQ+i8+fDMWOlBbeUyMkyH4JRDaW1Ft69MqS6zWYaA0wItQAvHl1nXfP2AUDCLe49p
         7B2G9iagGdC+mr8DHVu911FiZDYCK7aeq5Sz6Sg1N2/OTj/vZ2mBQumHXER48SQ5JapF
         47bvtBoTxe0aWcgmBqeBz1LC1+0e1yrf9e+ca5+8No4IPoMZBFoRK/KIka+vIDrPoTtK
         lJjw==
X-Gm-Message-State: AOJu0Yy7k3lVsUE+W22EiLV2COolvPzp/Ps6xM0cuXbXYa6LliOm6VM6
	RaSS9S3csgTDKnC5ltBZ5x4w+tPumsfO6K1carrc21L8Sau3AZsET3XO3AhRyQ==
X-Gm-Gg: ASbGncuU7YeWPDMg4LayySkJPBRbDvMi/QYo4jgGIfz46d/udCJGSAXMC75W7e+NrHv
	JbDiWnDz+c041m8N2QU6W9D9huD/D0w/RvNrJrlQKmXBeMXu+haqvZcberNMFPacyGgVuxDIfSv
	aZGMrHHGSEJb2hoIv/k3WG5o2jIHYVTcVAztb+iZxjAGqXEdNhOPzCG4XVmfzpsjoqfUrGGGd3g
	zJ8QYZ4ShLwvDekiidGtk+t3L0VDKYx86O60rkezgdHBc7VNVPYFXGqgvBbYXYdjFXZ3vTxPadM
	AbZZRSdlGrfk+LaANch11Xch/Tor+od64k8EPxChCqNBiSlZQvc7TtoV7lE037cjfqn88R9cXTu
	+DmOR3J5Ddb3rgSeqIIFQCIeFMmR62A==
X-Google-Smtp-Source: AGHT+IGIuxJV+vF1UOoLjt0a4Kub7DhMXt/JIxOWjssIHt//pmAmnwvh8NfnH3EYN9vaaqXFsFEmrQ==
X-Received: by 2002:a17:903:384c:b0:240:640a:b2e4 with SMTP id d9443c01a7336-245fede0b63mr24561045ad.49.1755766375030;
        Thu, 21 Aug 2025 01:52:55 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7d7fsm48949525ad.80.2025.08.21.01.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:52:54 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH 1/2] builtin/refs: add 'exists' subcommand
Date: Thu, 21 Aug 2025 14:22:45 +0530
Message-Id: <20250821085246.929307-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821085246.929307-1-meetsoni3017@gmail.com>
References: <20250821085246.929307-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the ongoing effort to consolidate reference handling,
introduce a new `exists` subcommand. This command provides the same
functionality and exit-code behavior as `git show-ref --exists`, serving
as its modern replacement.

The logic for `show-ref --exists` is minimal. Rather than creating a
shared helper function which would be overkill for ~20 lines of code,
its implementation is intentionally duplicated here. This contrasts with
`git refs list`, where sharing the larger implementation of
`for-each-ref` was necessary.

Documentation for the new subcommand is also added to the `git-refs(1)`
man page.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-refs.adoc |  7 ++++++
 builtin/refs.c              | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index d462953fb5..bfa9b3ea2d 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -18,6 +18,7 @@ git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
 		   [(--exclude=<pattern>)...] [--start-after=<marker>]
 		   [ --stdin | (<pattern>...)]
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
index 76224feba4..617d8ab138 100644
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
+
+	const char * const exists_usage[] = {
+		REFS_EXISTS_USAGE,
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, exists_usage, 0);
+	if (!argc)
+		die("'git refs exists' requires a reference");
+
+	ref = *argv++;
+	if (*argv)
+		die("'git refs exists' requires exactly one reference");
+
+	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
+			      &unused_oid, &unused_referent, &unused_type,
+			      &failure_errno)) {
+		if (failure_errno == ENOENT || failure_errno == EISDIR) {
+			error(_("reference does not exist"));
+			return 2;
+		} else {
+			errno = failure_errno;
+			error_errno(_("failed to look up reference"));
+			return 1;
+		}
+	}
+
+	strbuf_release(&unused_referent);
+	return 0;
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

