Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B8347C2
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467705; cv=none; b=jr0ZEEKddDsknfxx7+bcdWQqYhMBTamTIg47Smipa8hWF7T95dABOCF5lc5tMqM86YIGMXYDcjVGt5gTGJvfegxqnFGdGJWIKlkcQCWPquqS3FEHCKzYhyu0H9dmtFTbYbzm+zxHD6aS+Wweu3Z4vy4BheLMq8KQ79RIbbAQuuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467705; c=relaxed/simple;
	bh=KWGftTZWltnyHv7KprcRsyIleLZPGChVbAUL5MpiC4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVmKghuxgbKIdfuhjXFHYbrH/90S1I98tEytPZV4CYI4jzjTO5QX2uLFs16qGtSes0JyGgF9+tO4Zj2Myw0ImcZID4+mrw/MrsMf+nEe7aOTQ+yMH8kTiZt9Wr3ITfBcKXwVBjrj0LHVTcRG7dLNbTpjRCvjSaYlm1oUYtibsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOnghfFh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOnghfFh"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70b1207bc22so1313350b3a.3
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721467702; x=1722072502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HyRvKV3x3NyIXBZ8uXWHSMiQZ+VUHeCHGOW28QSyNzw=;
        b=NOnghfFh7tRwT2m27QHy5PuEw8E1wc3WBaozhlZt19SlLZ6Zja+VIMzbtplEnqsq49
         IqFnzie+d75PahcsjkO64e82JNP3L+M8N4tO3GP726x0mhmu5wnIMNGyzL2qzalpbpa5
         3KtM1EhzHbF7hjZ484c9j1fOKpcxJD9sR+QdD32zPke2VTTeA8Jq3SIDBt9n+4HhNCE1
         rrayuGdFPRY0lTeg6VtuDoy88BqgbbHgg2v/hXgvf88Y2vjcOfAIdWKRNPlqWCyPN7Cy
         Jvpc83qZaOrBMBGY23leFsYHWveuZY/96zfhUIeL2CQgBbvlq1OuPkjQCowhZcQzu++d
         eLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721467702; x=1722072502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyRvKV3x3NyIXBZ8uXWHSMiQZ+VUHeCHGOW28QSyNzw=;
        b=dnCgMqZDGUZ5SKEVjglaKTDaceHGJbPfRljMzuPlDiNQbn2AttCyGOcitmv2N8zHLa
         ETNqjbQS881M10zOjq8jVQ4b/KVhUcPhsF+86I0hah7QsEZ0woqYrL636lbmw6GqeQPh
         hh59CPt5japHE1NNZO/Hm3bBTicbJs2nLUXG69yu582j0VkxJD5ML10dagvrPZJTXtqu
         LI996+q3FQxEAaOXabCzxHwEqeuiIzGpYWPVqB9fEwPKihRX7SYPtw/bkv5fOpOpeiqX
         vNlKZvuLVlxzss9yXLwj+0n5dBinRle3LCHbp22QIXEcfEhb0nA93xUouBpLX+6HMFJN
         eUPQ==
X-Gm-Message-State: AOJu0Yzw5Dp4DlEjHaWxC/otRi+96R6GRE09Ji+T9+TrG7EGGe4WFXZv
	QRvlPqXpqcpvQz/Rra/w+Q221BDTW8DvJZdL4xM+qh98ihOuicFDmWLLJQ==
X-Google-Smtp-Source: AGHT+IGJB2lhj2rppWNnDn5w61LPLaXbzHq7G/MW2Hjelh0C2CsR277KVHF1xhb3V6QzatmSgMcj8A==
X-Received: by 2002:a05:6a00:1250:b0:70b:29bf:bbde with SMTP id d2e1a72fcca58-70d084b4cf9mr3214028b3a.12.1721467702086;
        Sat, 20 Jul 2024 02:28:22 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0a3ded37sm1324309a12.11.2024.07.20.02.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 02:28:21 -0700 (PDT)
Date: Sat, 20 Jul 2024 17:28:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v12 06/10] git refs: add verify subcommand
Message-ID: <ZpuDQDbt9hazvn7D@ArchLinux>
References: <ZpuCg1GL1YE_sJBP@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpuCg1GL1YE_sJBP@ArchLinux>

Introduce a new subcommand "verify" in git-refs(1) to allow the user to
check the reference database consistency and also this subcommand will
be used as the entry point of checking refs for "git-fsck(1)". Last, add
"verbose" field into "fsck_options" to indicate whether we should print
verbose messages when checking refs and objects consistency.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-refs.txt | 13 +++++++++++
 builtin/refs.c             | 44 ++++++++++++++++++++++++++++++++++++++
 fsck.h                     |  1 +
 3 files changed, 58 insertions(+)

diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
index 5b99e04385..1244a85b64 100644
--- a/Documentation/git-refs.txt
+++ b/Documentation/git-refs.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git refs migrate' --ref-format=<format> [--dry-run]
+'git refs verify' [--strict] [--verbose]
 
 DESCRIPTION
 -----------
@@ -22,6 +23,9 @@ COMMANDS
 migrate::
 	Migrate ref store between different formats.
 
+verify::
+	Verify reference database consistency.
+
 OPTIONS
 -------
 
@@ -39,6 +43,15 @@ include::ref-storage-format.txt[]
 	can be used to double check that the migration works as expected before
 	performing the actual migration.
 
+The following options are specific to 'git refs verify':
+
+--strict::
+	Enable more strict checking, every WARN severity for the `Fsck Messages`
+	be seen as ERROR. See linkgit:git-fsck[1].
+
+--verbose::
+	When verifying the reference database consistency, be chatty.
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 46dcd150d4..4831c9e28e 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -1,4 +1,6 @@
 #include "builtin.h"
+#include "config.h"
+#include "fsck.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "repository.h"
@@ -7,6 +9,9 @@
 #define REFS_MIGRATE_USAGE \
 	N_("git refs migrate --ref-format=<format> [--dry-run]")
 
+#define REFS_VERIFY_USAGE \
+	N_("git refs verify [--strict] [--verbose]")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 {
 	const char * const migrate_usage[] = {
@@ -58,15 +63,54 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 	return err;
 }
 
+static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
+{
+	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
+	const char * const verify_usage[] = {
+		REFS_VERIFY_USAGE,
+		NULL,
+	};
+	unsigned int verbose = 0, strict = 0;
+	struct option options[] = {
+		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
+		OPT_END(),
+	};
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
+	if (argc)
+		usage(_("'git refs verify' takes no arguments"));
+
+	if (verbose)
+		fsck_refs_options.verbose = 1;
+	if (strict)
+		fsck_refs_options.strict = 1;
+
+	git_config(git_fsck_config, &fsck_refs_options);
+	prepare_repo_settings(the_repository);
+
+	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
+
+	/*
+	 * Explicitly free the allocated array and "skip_oids" set
+	 */
+	free(fsck_refs_options.msg_type);
+	oidset_clear(&fsck_refs_options.skip_oids);
+	return ret;
+}
+
 int cmd_refs(int argc, const char **argv, const char *prefix)
 {
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
+		REFS_VERIFY_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option opts[] = {
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
+		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
 		OPT_END(),
 	};
 
diff --git a/fsck.h b/fsck.h
index a3870ffe2b..98e2225593 100644
--- a/fsck.h
+++ b/fsck.h
@@ -155,6 +155,7 @@ struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
+	unsigned verbose:1;
 	enum fsck_msg_type *msg_type;
 	struct fsck_refs_info refs_info;
 	struct oidset skip_oids;
-- 
2.45.2

