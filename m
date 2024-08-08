Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C913D265
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116421; cv=none; b=NCVFfftU6burzoDcnx9JGVgqzo3uB6+Lzp/7NvlfAdea7AYAaqflC29ICmtMt+U9S49pepG8OX0CseDzaVZtWWQQgLQnkID9pyzEw3pXaHZpJazJBsYftsEYurMXEJpJ1Lp5gnAzuhFlS4L9MmmyBFd1u/nvuwLZQBnS8NJgtxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116421; c=relaxed/simple;
	bh=N9xRKpjrHbB9tsaEzajlwDt3WHbvwnJxrPemJ5BljeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxjWG7YHJOerctlffm1v5gZxDQuZymAVIar0njV62rwtujMmw79F2hOlHBNh9wG8+hg4eppze8eEQW4ny177lQcjT48b4vxBHCCnDTk1FdclRoFqYWl/+NtHLhdmMv5e0SHr28BVfPamzFFy7KM+oJ/p5I/PjecBoRWxmcagMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1O0QM50; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1O0QM50"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso634027a12.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116419; x=1723721219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U94p9qk0likNuFXerMrbcXs96yvdKsqw/CM63bN9Kr8=;
        b=m1O0QM50e9uWfn00EMOToB0Jk2Fzu2qrA1NfcYx2IwZZ4bgAZS802cojigyMi6k2in
         TuKuaCnTxbrneAYGqy0R2+ZEpEHY8Kfi8JpdZDUKNxiKZHwW2+djR2Y7uH2U+shcJ7ub
         fDOUWs+Kc28jyAL8I1XQAgDmbxLCLy32yBwUexvwuCoaFguiOfsA6NFA3kVCH+sGGoE2
         7HZ291qNAxWXZavZUdt9/XYoCUCIdwKuQFwKhkIJcTzeMifFUokzw6zQUEq6wid5dqQE
         x1mGAzOsuoGw90u2CVI7V7IE3Ih2Rp1bcFUvuwVniEpYzfTN9zmOkhAaXukCCObQv8IC
         ksUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116419; x=1723721219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U94p9qk0likNuFXerMrbcXs96yvdKsqw/CM63bN9Kr8=;
        b=R0/ktq47xzxRAl6mzxbz/e5X0d3SqR7+oUdZ08s6HKTYqBDm5SRODqbkagP654q4nz
         9xjyeobFwHbOh2tWye7Ajn5rc2dBM0anOEzuXyo/KJUJgQEF5wqp6/AgSk4Xy7sV4ts6
         9Nip00NG4WStISa0CHYLk3lOJOx6ERowbQXtTATqcCE++KCNibzhektMlXhA2lKXveEj
         dA+l/a3XO7ZH7f4adArmoC3OcBym7N39AuisGXihHaAwzmLARzst/lz6h1onnAlnKIlF
         APpKjLO39/bl93HuWNhggLzcnh5Is+rte0JeVVaexgNkJUMhO8rByVevHoQiz+xP5YT+
         RBlw==
X-Gm-Message-State: AOJu0YyS4z2oYXn39RAmeDkaK0yfK2Uuh7iQ7LTlPOg6dBqj0rrhwTlT
	fVoz3KE9jLmRx9V/46rM6VDGe55T697eQYURpUhBYHqGtXSdOe8rQqhHcoATaGA=
X-Google-Smtp-Source: AGHT+IFc7oUcpDLEA+bAYYruCb4Ow7V5Us47uZzYXkfw/PAzGRqNNu+4Ys19dmliVeh0bazPuT/66Q==
X-Received: by 2002:a05:6a21:6d91:b0:1c4:8291:e94e with SMTP id adf61e73a8af0-1c6fcf8515cmr1834322637.45.1723116418990;
        Thu, 08 Aug 2024 04:26:58 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59060112sm122186375ad.137.2024.08.08.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:26:58 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:27:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v16 7/9] builtin/refs: add verify subcommand
Message-ID: <ZrSroE8vLlZCK2jp@ArchLinux>
References: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>

Introduce a new subcommand "verify" in git-refs(1) to allow the user to
check the reference database consistency and also this subcommand will
be used as the entry point of checking refs for "git-fsck(1)".

Add "verbose" field into "fsck_options" to indicate whether we should
print verbose messages when checking refs and objects consistency.

Remove bit-field for "strict" field, this is because we cannot take
address of a bit-field which makes it unhandy to set member variables
when parsing the command line options.

The "git-fsck(1)" declares "fsck_options" variable with "static"
identifier which avoids complaint by the leak-checker. However, in
"git-refs verify", we need to do memory clean manually. Thus add
"fsck_options_clear" function in "fsck.c" to provide memory clean
operation.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/git-refs.txt | 13 +++++++++++++
 builtin/refs.c             | 34 ++++++++++++++++++++++++++++++++++
 fsck.c                     | 11 +++++++++++
 fsck.h                     |  8 +++++++-
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
index 5b99e04385..ce31f93061 100644
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
+	Enable stricter error checking. This will cause warnings to be
+	reported as errors. See linkgit:git-fsck[1].
+
+--verbose::
+	When verifying the reference database consistency, be chatty.
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/builtin/refs.c b/builtin/refs.c
index 46dcd150d4..131f98be98 100644
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
@@ -58,15 +63,44 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
 	return err;
 }
 
+static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
+{
+	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
+	const char * const verify_usage[] = {
+		REFS_VERIFY_USAGE,
+		NULL,
+	};
+	struct option options[] = {
+		OPT_BOOL(0, "verbose", &fsck_refs_options.verbose, N_("be verbose")),
+		OPT_BOOL(0, "strict", &fsck_refs_options.strict, N_("enable strict checking")),
+		OPT_END(),
+	};
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
+	if (argc)
+		usage(_("'git refs verify' takes no arguments"));
+
+	git_config(git_fsck_config, &fsck_refs_options);
+	prepare_repo_settings(the_repository);
+
+	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
+
+	fsck_options_clear(&fsck_refs_options);
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
 
diff --git a/fsck.c b/fsck.c
index e16c892f6a..3756f52459 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1331,6 +1331,17 @@ int fsck_finish(struct fsck_options *options)
 	return ret;
 }
 
+void fsck_options_clear(struct fsck_options *options)
+{
+	free(options->msg_type);
+	oidset_clear(&options->skip_oids);
+	oidset_clear(&options->gitmodules_found);
+	oidset_clear(&options->gitmodules_done);
+	oidset_clear(&options->gitattributes_found);
+	oidset_clear(&options->gitattributes_done);
+	kh_clear_oid_map(options->object_names);
+}
+
 int git_fsck_config(const char *var, const char *value,
 		    const struct config_context *ctx, void *cb)
 {
diff --git a/fsck.h b/fsck.h
index 2002590f60..d551a9fe86 100644
--- a/fsck.h
+++ b/fsck.h
@@ -153,7 +153,8 @@ struct fsck_ref_report {
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
-	unsigned strict:1;
+	unsigned strict;
+	unsigned verbose;
 	enum fsck_msg_type *msg_type;
 	struct oidset skip_oids;
 	struct oidset gitmodules_found;
@@ -231,6 +232,11 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+/*
+ * Clear the fsck_options struct, freeing any allocated memory.
+ */
+void fsck_options_clear(struct fsck_options *options);
+
 /*
  * Report an error or warning for refs.
  */
-- 
2.46.0

