Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6569762D0
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782936; cv=none; b=LKIvg8tJX1kFtOymTpMrKptpUyn+ucC9vYEDlSLsUSXljte86CWcHEGhHIeJLItquRRxzikqs80fRhfEcm8JEnzLjR9W8S15EMAzajg8mDlf9G1t1gMCG6LbKY3f570YN6XB226PUzzsuVslLkiBJw4vIt2/MXplxTarbAaBnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782936; c=relaxed/simple;
	bh=VodnOPh5WO1nlmB6xwoFQoqK80utX3kci6yumDJkeaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmfEhtW2E/l5PEme3TSC1ZMs4Z+P6cn3NVf6BpuPauSQy/s6F1tvE/2MdS/pZQDt/GziLpd5U10CjA0bOJNDC0pkoM73Dmrq7KmNJlVFF/JxTy73KnvYeNLLJZlWkZJ5op0KBrusCdSsanz6Ylz2T1OOGSJWpNGEq5RgvEYy7/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RamOyiOz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RamOyiOz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c306e87b1fso4924155a91.3
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718782933; x=1719387733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TGrvTYjj5qxu44bU63Q3wLCWgfp16TiJWXB8Q+bWEsM=;
        b=RamOyiOzQXUjCo2Am+C3epPwOC2zgY1kxxboz4MboUPzGQWkIY82OtOySD6+x16r8A
         TFMES60pW8dZwuLUpNmLSyWX2QCL2RGNdyTPbyHnZwmCQZ0qR7Z7rZxlybZjb+vanq6U
         QL2N5ev5/XnilwyzIV9aeDkiQG1mXsTwY71TmQAYlMTJBvSGcvN/iRhEcK8uUUjwbm64
         IKAJLvVM01OrlLaazklPZjClOaOIcLEXMsiz2Eed8EGcvm9jyh3fBoStW/vhujhk4geq
         RWByzp680wdmkW4QyggB/IsDmyjFs6h2K0heIAVxndAyIdn0pOEuHxAoENt9YT+tcWUU
         w8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782933; x=1719387733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGrvTYjj5qxu44bU63Q3wLCWgfp16TiJWXB8Q+bWEsM=;
        b=eS8PVbKnie9pTeUCOvP27w6rswIBK4HmjlAeDpHM5yR47rwpHBOlWjPCBTNYc3bH0E
         Nejp4TBrcvUIwMf1hhzqWplweZMSBOsCXmE1rwijcj9DobpjRQuoRA4ygZ6gxz5Muzhg
         2b7U2OOQCCp9UQTQ35nXiQl4sRfl2DYTkLRgWNJO+WzCIBwD0/jMFtbm/zXp+TcTBdEW
         mILd8Wv5kv0ivSpeNcsA6zNuYEOUqHPXziJ5HtCHSIuxo/LHUSEGxHEWX1MrFBl7UuAr
         6mInlyepUG50HnUik42+9Y8GqQ3Zt/CJexwLaWqp4a89PX/zGaXndtlwZGv9Yw0Bpn62
         tdEQ==
X-Gm-Message-State: AOJu0YyYF2gFrpu10ydKVirQrar02FYxClZrgC0rmOY02HS2f1jTnmmP
	RRDMLS8X/cAN8N4k4LUbUP5spAqt4v1DbSzhShx61+DSSdp67OEx6qsf3A==
X-Google-Smtp-Source: AGHT+IFH0tPwW0beIRVknt+1lLwxWWu2yp+PBT8MUcf4wUMORSbVQoFg2q24HS+1FaV9ytNLppPjSA==
X-Received: by 2002:a17:90a:df07:b0:2c1:ebc4:4f1f with SMTP id 98e67ed59e1d1-2c7b5d56b91mr1769098a91.33.1718782932988;
        Wed, 19 Jun 2024 00:42:12 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a7603158sm14486223a91.27.2024.06.19.00.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:42:12 -0700 (PDT)
Date: Wed, 19 Jun 2024 15:42:11 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v4 3/7] builtin/refs: add verify subcommand
Message-ID: <ZnKL0-u_s19-Fdmt@ArchLinux>
References: <ZnKKy52QFO2UhqM6@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnKKy52QFO2UhqM6@ArchLinux>

Introduce a new subcommand "verify" in git-refs(1) to allow the user to
check the reference database consistency.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-refs.txt | 13 +++++++++++
 builtin/refs.c             | 45 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

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
index 46dcd150d4..231a051f6b 100644
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
@@ -58,15 +63,55 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 	return err;
 }
 
+static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
+{
+	const char * const verify_usage[] = {
+		REFS_VERIFY_USAGE,
+		NULL,
+	};
+	int ret = 0;
+	unsigned int verbose = 0, strict = 0;
+	struct fsck_options fsck_options = FSCK_OPTIONS_DEFAULT;
+	struct option options[] = {
+		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (verbose)
+		fsck_options.verbose = 1;
+	if (strict)
+		fsck_options.strict = 1;
+
+	git_config(git_fsck_config, &fsck_options);
+	prepare_repo_settings(the_repository);
+
+	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_options);
+
+	/*
+	 * Explicitly free the allocated array and object skiplist set. Because
+	 * we reuse `git_fsck_config` here. It will still set the skiplist.
+	 */
+	free(fsck_options.msg_type);
+	oidset_clear(&fsck_options.objs_options.skiplist);
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
 
-- 
2.45.2

