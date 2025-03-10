Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C321D3E0
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610203; cv=none; b=rj7lg2uVJSY0PlcCHw2YTpv6aYaJqZaqE9t/+/th/6G6G1qPJfZJWuORS6RN665x4pDmu+Qz5UEfkliqsWnxKfGL8KFyDwtPL6DUeH6jZl04/Ur0ZgugmkmotMs5gzEgpI5AcUVRo6Y8cRKM0tGe1B/8kTPS6tOnxy9fSpkuNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610203; c=relaxed/simple;
	bh=0OXbebQXC/GlmdQs1xh89+fl+wnynIQyP+DGgKeDSu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=O+Y1j7Ul0h+UgSZU6tSWdSdmzJv5dE1ntVY3MyMhQLfdtIpKzcUiXsLp5HGMScu3bxxIoX2fZ+KAlGlLj3CaPKT+3tuH3CVjlf/pnbPz/5otWzmG94lAcfNx7NFJ4NTIjw+x9MB+99PhIUN2YuuI0KNSsCo1bQscZxABPGO6VfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z26F0QeF; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z26F0QeF"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso7408424a12.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 05:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741610200; x=1742215000; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9XIOHUj4EjN9T/sW7d9uacnE9z9+Il1FgmzEDBsWzg=;
        b=Z26F0QeFDPKse4YldtqVyE4MooLo7I6g2Vl429tiOgd/SJEL56+OcOyhAQhOjqmChU
         tm9mTlVorhFXC+HeKpmoK/JVgCp4ukyD8XeCIJBS+iJpIJtFwI+zrbJpiMCnad+GtNbG
         ptdx1IgeInQ0yEMQD9QF22Kx81d+f3XXNp7JNt9Yp8TwR1TzwJCOlhGAy8RL5tFQByS1
         znd6RL34f+4WSpy/mqPTPj90ebCjPo0b+GWr0x9fOOSxrgVYjFcI3KPJt+gFAoJtH2sk
         st4yG94LxaFG1DwZPRPKt3jRIwoZWOPNvQxha04rUdAZa+Z+46oUtxdzL+uEGsq14BNP
         +68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741610200; x=1742215000;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9XIOHUj4EjN9T/sW7d9uacnE9z9+Il1FgmzEDBsWzg=;
        b=bLhnVp6gXlzrXYCDlqEOqCCkhzO/dTQziVozYQdV/FIduMddSd0dV6k7s06rTOoI8x
         WTqq4XrIfFLhQKCH16uea66+H8Aixd/bekZqmJIf7+WvsJdfL7ljE+HBciWFdW0IMWjy
         ah1CrzSqKfuCWxDPjENYboSghA151joEDFZbYJqWtfc6zBVaZ5ba5IPmbzvRaeb0GaB4
         KbArNeEEfQmq/b+WX4dUDzXhVLLekW/zcyfz//EHzNZ057dGroWBiBHtDw+TEl+HJuhH
         tGahc71hlxIqXE17H18hlTbkbVhiJvseGbVp5yiqsQPu8vs0ukYyQtHHWstEI6TRK1ps
         JNXw==
X-Gm-Message-State: AOJu0YzJ7qiP68rC8d1T0NXbAEEQ/Gc/tf2UDdgOtZ9ntztYgOEiT7fG
	03Y3n35JR56lSxZ2euWk5l227gZ80QNEsVIE5CptqviNdEx6263I
X-Gm-Gg: ASbGncu76G+rBa++WiNeLudGcsTOxQ0c/h3Lq5bOaQ9zgYiIz+nsTYb2FwguiXFkBb5
	Y8LgbAFDIKjJEL4E0VVLwbfXUJwuwhooxdaHVrgv2wJqQzS/vTliNGU4oPwB+40LwbQtirdItzf
	b+lzW2sQV6ZczY8lU9tUYnVHOh+uhGLKFBDQTSOW2XCSAODfHmcRuQrVFBLzNnP+OIAyuBG8iHJ
	Owe1dFWn5rWC3i6sb3REWzMuMb2v5XhbHKNugDBEuWBim6AAe4gJlF6Ey/Ng3mhhax//7LYBUij
	0+EA9wfEDDJwll/fQZuMgAb0xdTTwYsNCLot5qX/Up/I
X-Google-Smtp-Source: AGHT+IGsudQ0biRpp868tMzR89M5DoEKZ0tUC9GZLeoqLrhycPVjE0zG+qntAbmS2h4eWZ+zheEKAw==
X-Received: by 2002:a17:906:f594:b0:ac1:e00c:a564 with SMTP id a640c23a62f3a-ac252ba468cmr1569246766b.38.1741610199592;
        Mon, 10 Mar 2025 05:36:39 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768ef30sm6823116a12.69.2025.03.10.05.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:36:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 10 Mar 2025 13:36:25 +0100
Subject: [PATCH v2] reflog: implement subcommand to drop reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-493-add-command-to-purge-reflog-entries-v2-1-05caa92e0bfa@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMjczmcC/42NQQ6CMBBFr0Jm7ZhSioAr72FYFDpAE2hJi0RDu
 LsDiXuX7/+Z/zaIFCxFuCcbBFpttN4xyEsC7aBdT2gNM0ghc5GJG6oqQ20Mtn6atDO4eJxfge8
 CdaPvkdxyDGJjpMxVoU2mNPDazL19n6ZnzTzYuPjwOcVreqQ/R/G3Y01RYKl0U+ayaruKHv2k7
 XjlP6j3ff8Ce5PaR94AAAA=
X-Change-ID: 20250306-493-add-command-to-purge-reflog-entries-bd22547ad34a
In-Reply-To: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, kristofferhaugsbakk@fastmail.com, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=15113;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=0OXbebQXC/GlmdQs1xh89+fl+wnynIQyP+DGgKeDSu8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfO3NYHS8YBiUFNFVmtJ1tbjRSnYifeueKQ8
 s+72OmOzsAkC4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnztzWAAoJED7VnySO
 Rox/0qMMAIeD1fY1vAOoGtY4OVLjKph6tF7VA/bL9KKPyuS1RklkTXSNffsRM9wdyBb8Jtw15t2
 GfzpKGuwGUMXmwx9zMoCjfF2lJJL3Fp9Bu3b/2E1oqiWfuyMIH/cxsTLzcV7ttrHq7v8uZwv954
 HQf69zg17JCcPcr5FZGRPPfGh9dq0y9QaFBTxjRve5GeT4GH40SySwE77KDp1rJesIKfVH4ygmw
 sJg/fmDIiMv1p7/cZ3gfLnQ8pHIfTqEBNKertaBZZPjV9rkYaxSCgsXCXZjgm2jwGYNs9hP26Ru
 I0G6x+ZS6x8wWwIEdzfkjGF4dAx0hHkzD47l71o7NC1S3PQbgbZ6MAKsLsZMYT+TslF1VMZEhAb
 /79+BEkBUJi/z7IJCldzvBAvnZxN2a79ySkHdv9XZgygUJJl6LwlP8tr0iwurNLFGOERHjle7cJ
 vxV38siCNjJo6vKXgDB8bAAVqssrKaG1QginwfwcV8qgLsC+xJMekd4fqlTvStfA1luFC4BzJE5
 2s=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While 'git-reflog(1)' currently allows users to expire reflogs and
delete individual entries, it lacks functionality to completely remove
reflogs for specific references. This becomes problematic in
repositories where reflogs are not needed but continue to accumulate
entries despite setting 'core.logAllRefUpdates=false'.

Add a new 'drop' subcommand to git-reflog that allows users to delete
the entire reflog for a specified reference. Include a '--all' flag to
enable dropping all reflogs in a repository.

While here, remove an extraneous newline in the file.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Rephrase the commit message to be clearer and fix typo.
- Move the documentation to be next to 'git reflog delete' and also
  add missing documentation for the '--all' flag.
- Ensure '--all' is not used with references and add a test.
- Cleanup variable assignment.
- Check for error message in the test.
- Drop the cleanup commit.
- Rebased on top of master a36e024e98 (Merge branch 'js/win-2.49-build-fixes',
  2025-03-06), this was to include the adoc changes which were breaking
  tests on the CI. 
- Link to v1: https://lore.kernel.org/r/20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com

 Documentation/git-reflog.adoc | 18 +++++++++---
 builtin/reflog.c              | 60 +++++++++++++++++++++++++++++++++++++-
 t/t1410-reflog.sh             | 67 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 5 deletions(-)

Karthik Nayak (1):
      reflog: implement subcommand to drop reflogs

Range-diff versus v1:

1:  7c37f97eb0 < -:  ---------- reflog: drop usage of global variables
2:  d321bf14ae ! 1:  cac494d5cc reflog: implement subcommand to drop reflogs
    @@ Metadata
      ## Commit message ##
         reflog: implement subcommand to drop reflogs
     
    -    Add a new 'drop' subcommand to git-reflog that allows users to delete
    -    the entire reflog for a specified reference. Include a '--all' flag to
    -    enable dropping all reflogs in a repository.
    -
         While 'git-reflog(1)' currently allows users to expire reflogs and
         delete individual entries, it lacks functionality to completely remove
         reflogs for specific references. This becomes problematic in
         repositories where reflogs are not needed but continue to accumulate
         entries despite setting 'core.logAllRefUpdates=false'.
     
    -    While here, remove an erranous newline in the file.
    +    Add a new 'drop' subcommand to git-reflog that allows users to delete
    +    the entire reflog for a specified reference. Include a '--all' flag to
    +    enable dropping all reflogs in a repository.
    +
    +    While here, remove an extraneous newline in the file.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/git-reflog.adoc ##
     @@ Documentation/git-reflog.adoc: SYNOPSIS
    + 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
      'git reflog delete' [--rewrite] [--updateref]
      	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
    - 'git reflog exists' <ref>
     +'git reflog drop' [--all | <refs>...]
    + 'git reflog exists' <ref>
      
      DESCRIPTION
    - -----------
    -@@ Documentation/git-reflog.adoc: The "exists" subcommand checks whether a ref has a reflog.  It exits
    +@@ Documentation/git-reflog.adoc: and not reachable from the current tip, are removed from the reflog.
    + This is typically not used directly by end users -- instead, see
    + linkgit:git-gc[1].
    + 
    +-The "delete" subcommand deletes single entries from the reflog. Its
    +-argument must be an _exact_ entry (e.g. "`git reflog delete
    +-master@{2}`"). This subcommand is also typically not used directly by
    +-end users.
    ++The "delete" subcommand deletes single entries from the reflog, but
    ++not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
    ++reflog delete master@{2}`"). This subcommand is also typically not used
    ++directly by end users.
    + 
    + The "exists" subcommand checks whether a ref has a reflog.  It exits
      with zero status if the reflog exists, and non-zero status if it does
      not.
      
    -+The "drop" subcommand removes the reflog for the specified references.
    -+In contrast, "expire" can be used to prune all entries from a reflog,
    -+but the reflog itself will still exist for that reference. To fully
    -+remove the reflog for specific references, use the "drop" subcommand.
    ++The "drop" subcommand completely removes the reflog for the specified
    ++references. This is in contrast to "expire" and "delete", both of which
    ++can be used to delete reflog entries, but not the reflog itself.
     +
      OPTIONS
      -------
      
    +@@ Documentation/git-reflog.adoc: Options for `delete`
    + `--dry-run`, and `--verbose`, with the same meanings as when they are
    + used with `expire`.
    + 
    ++Options for `drop`
    ++~~~~~~~~~~~~~~~~~~~~
    ++
    ++--all::
    ++	Drop the reflogs of all references from all worktrees.
    + 
    + GIT
    + ---
     
      ## builtin/reflog.c ##
     @@
    @@ builtin/reflog.c: static const char *const reflog_exists_usage[] = {
      	BUILTIN_REFLOG_LIST_USAGE,
      	BUILTIN_REFLOG_EXPIRE_USAGE,
      	BUILTIN_REFLOG_DELETE_USAGE,
    - 	BUILTIN_REFLOG_EXISTS_USAGE,
     +	BUILTIN_REFLOG_DROP_USAGE,
    + 	BUILTIN_REFLOG_EXISTS_USAGE,
      	NULL
      };
    - 
     @@ builtin/reflog.c: static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
      				   refname);
      }
    @@ builtin/reflog.c: static int cmd_reflog_exists(int argc, const char **argv, cons
     +static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
     +			   struct repository *repo)
     +{
    -+	int i, ret, do_all;
    ++	int ret = 0, do_all = 0;
     +	const struct option options[] = {
     +		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
     +		OPT_END()
     +	};
     +
    -+	do_all = ret = 0;
     +	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
     +
    ++	if (argc && do_all)
    ++		die(_("references specified along with --all"));
    ++
     +	if (do_all) {
     +		struct worktree_reflogs collected = {
     +			.reflogs = STRING_LIST_INIT_DUP,
    @@ builtin/reflog.c: static int cmd_reflog_exists(int argc, const char **argv, cons
     +		string_list_clear(&collected.reflogs, 0);
     +	}
     +
    -+	for (i = 0; i < argc; i++) {
    ++	for (int i = 0; i < argc; i++) {
     +		char *ref;
     +		if (!repo_dwim_log(repo, argv[i], strlen(argv[i]), NULL, &ref)) {
     +			ret |= error(_("%s points nowhere!"), argv[i]);
    @@ t/t1410-reflog.sh: test_expect_success 'reflog with invalid object ID can be lis
     +	(
     +		cd repo &&
     +		test_must_fail git reflog exists refs/heads/non-existent &&
    -+		test_must_fail git reflog drop refs/heads/non-existent
    ++		test_must_fail git reflog drop refs/heads/non-existent 2>stderr &&
    ++		test_grep "error: refs/heads/non-existent points nowhere!" stderr
     +	)
     +'
     +
    @@ t/t1410-reflog.sh: test_expect_success 'reflog with invalid object ID can be lis
     +		test_must_fail git reflog exists refs/heads/branch
     +	)
     +'
    ++
    ++test_expect_success 'reflog drop --all with reference' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit A &&
    ++		test_must_fail git reflog drop --all refs/heads/main 2>stderr &&
    ++		test_grep "fatal: references specified along with --all" stderr
    ++	)
    ++'
     +
      test_done


base-commit: a36e024e989f4d35f35987a60e3af8022cac3420
change-id: 20250306-493-add-command-to-purge-reflog-entries-bd22547ad34a

Thanks
- Karthik
---

---
 Documentation/git-reflog.adoc | 18 +++++++++---
 builtin/reflog.c              | 60 +++++++++++++++++++++++++++++++++++++-
 t/t1410-reflog.sh             | 67 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
index a929c52982..6ed98ddaef 100644
--- a/Documentation/git-reflog.adoc
+++ b/Documentation/git-reflog.adoc
@@ -16,6 +16,7 @@ SYNOPSIS
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
 'git reflog delete' [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
+'git reflog drop' [--all | <refs>...]
 'git reflog exists' <ref>
 
 DESCRIPTION
@@ -48,15 +49,19 @@ and not reachable from the current tip, are removed from the reflog.
 This is typically not used directly by end users -- instead, see
 linkgit:git-gc[1].
 
-The "delete" subcommand deletes single entries from the reflog. Its
-argument must be an _exact_ entry (e.g. "`git reflog delete
-master@{2}`"). This subcommand is also typically not used directly by
-end users.
+The "delete" subcommand deletes single entries from the reflog, but
+not the reflog itself. Its argument must be an _exact_ entry (e.g. "`git
+reflog delete master@{2}`"). This subcommand is also typically not used
+directly by end users.
 
 The "exists" subcommand checks whether a ref has a reflog.  It exits
 with zero status if the reflog exists, and non-zero status if it does
 not.
 
+The "drop" subcommand completely removes the reflog for the specified
+references. This is in contrast to "expire" and "delete", both of which
+can be used to delete reflog entries, but not the reflog itself.
+
 OPTIONS
 -------
 
@@ -132,6 +137,11 @@ Options for `delete`
 `--dry-run`, and `--verbose`, with the same meanings as when they are
 used with `expire`.
 
+Options for `drop`
+~~~~~~~~~~~~~~~~~~~~
+
+--all::
+	Drop the reflogs of all references from all worktrees.
 
 GIT
 ---
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 95f264989b..cd93a0bef9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -29,6 +29,9 @@
 #define BUILTIN_REFLOG_EXISTS_USAGE \
 	N_("git reflog exists <ref>")
 
+#define BUILTIN_REFLOG_DROP_USAGE \
+	N_("git reflog drop [--all | <refs>...]")
+
 static const char *const reflog_show_usage[] = {
 	BUILTIN_REFLOG_SHOW_USAGE,
 	NULL,
@@ -54,11 +57,17 @@ static const char *const reflog_exists_usage[] = {
 	NULL,
 };
 
+static const char *const reflog_drop_usage[] = {
+	BUILTIN_REFLOG_DROP_USAGE,
+	NULL,
+};
+
 static const char *const reflog_usage[] = {
 	BUILTIN_REFLOG_SHOW_USAGE,
 	BUILTIN_REFLOG_LIST_USAGE,
 	BUILTIN_REFLOG_EXPIRE_USAGE,
 	BUILTIN_REFLOG_DELETE_USAGE,
+	BUILTIN_REFLOG_DROP_USAGE,
 	BUILTIN_REFLOG_EXISTS_USAGE,
 	NULL
 };
@@ -449,10 +458,58 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix,
 				   refname);
 }
 
+static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
+			   struct repository *repo)
+{
+	int ret = 0, do_all = 0;
+	const struct option options[] = {
+		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
+
+	if (argc && do_all)
+		die(_("references specified along with --all"));
+
+	if (do_all) {
+		struct worktree_reflogs collected = {
+			.reflogs = STRING_LIST_INIT_DUP,
+		};
+		struct string_list_item *item;
+		struct worktree **worktrees, **p;
+
+		worktrees = get_worktrees();
+		for (p = worktrees; *p; p++) {
+			collected.worktree = *p;
+			refs_for_each_reflog(get_worktree_ref_store(*p),
+					     collect_reflog, &collected);
+		}
+		free_worktrees(worktrees);
+
+		for_each_string_list_item(item, &collected.reflogs)
+			ret |= refs_delete_reflog(get_main_ref_store(repo),
+						     item->string);
+		string_list_clear(&collected.reflogs, 0);
+	}
+
+	for (int i = 0; i < argc; i++) {
+		char *ref;
+		if (!repo_dwim_log(repo, argv[i], strlen(argv[i]), NULL, &ref)) {
+			ret |= error(_("%s points nowhere!"), argv[i]);
+			continue;
+		}
+
+		ret |= refs_delete_reflog(get_main_ref_store(repo), ref);
+		free(ref);
+	}
+
+	return ret;
+}
+
 /*
  * main "reflog"
  */
-
 int cmd_reflog(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -465,6 +522,7 @@ int cmd_reflog(int argc,
 		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
 		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
 		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
+		OPT_SUBCOMMAND("drop", &fn, cmd_reflog_drop),
 		OPT_END()
 	};
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 388fdf9ae5..251caaf9a4 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -551,4 +551,71 @@ test_expect_success 'reflog with invalid object ID can be listed' '
 	)
 '
 
+test_expect_success 'reflog drop non-existent ref' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_must_fail git reflog exists refs/heads/non-existent &&
+		test_must_fail git reflog drop refs/heads/non-existent 2>stderr &&
+		test_grep "error: refs/heads/non-existent points nowhere!" stderr
+	)
+'
+
+test_expect_success 'reflog drop' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit_bulk --ref=refs/heads/branch 1 &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch &&
+		git reflog drop refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch
+	)
+'
+
+test_expect_success 'reflog drop multiple references' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit_bulk --ref=refs/heads/branch 1 &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch &&
+		git reflog drop refs/heads/main refs/heads/branch &&
+		test_must_fail git reflog exists refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/branch
+	)
+'
+
+test_expect_success 'reflog drop --all' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_commit_bulk --ref=refs/heads/branch 1 &&
+		git reflog exists refs/heads/main &&
+		git reflog exists refs/heads/branch &&
+		git reflog drop --all &&
+		test_must_fail git reflog exists refs/heads/main &&
+		test_must_fail git reflog exists refs/heads/branch
+	)
+'
+
+test_expect_success 'reflog drop --all with reference' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test_must_fail git reflog drop --all refs/heads/main 2>stderr &&
+		test_grep "fatal: references specified along with --all" stderr
+	)
+'
+
 test_done



