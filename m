Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFD27A133
	for <git@vger.kernel.org>; Sat,  3 May 2025 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746288620; cv=none; b=e/1qbvKd3yhyMemzjRCV+P7EkZorAnL5sP/bluoKQO6b85A3ih+xpDB8KyeGyBWEdeQAHtZk5wV+tl3sWFh2+CJt5GPr1A7dfG51B58YTdx94bPPFut2NmeDEtbnTCPlJso8CPCJGjNVc49LIqHOwqmn9hUzG5vBfUOCdY9jbjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746288620; c=relaxed/simple;
	bh=+Npa3TFNaleVmYZ2rUMfV2flxt6RUF81L3Pf+6+SOyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQp9wOttXi8i7hOH4UXs7febBqIANF2Vzcx1WlGW7fRy91B+fcF9HiWJnqlqteZCklpGGQXuWBEnWJ5vSb8rF1Ym7ZbolhzbKk3fddd5Y7nRibu2AhoxwGDIRyIs4qtdNw3vriAiJulTwoMKNaH1bcpiyxCrQgV8tIP9K16uY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lazar.co.nz; spf=fail smtp.mailfrom=lazar.co.nz; dkim=pass (2048-bit key) header.d=lazar-co-nz.20230601.gappssmtp.com header.i=@lazar-co-nz.20230601.gappssmtp.com header.b=ZRMrQcPl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lazar.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=lazar.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lazar-co-nz.20230601.gappssmtp.com header.i=@lazar-co-nz.20230601.gappssmtp.com header.b="ZRMrQcPl"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so1737529f8f.0
        for <git@vger.kernel.org>; Sat, 03 May 2025 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lazar-co-nz.20230601.gappssmtp.com; s=20230601; t=1746288615; x=1746893415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qORCx+39/uFvrfU5GH+eAwD4hm/2Utcm2msUTJttIK4=;
        b=ZRMrQcPlgQNWX5so+gCX0/sOu/h2L3/9hzgmPxEA8Mg1rWtWh6m/U3vA23HZbuJdqI
         fsfumlq7KUUzfHcEuKwoHfziKpZleW+JPeIWyD8FE/vX28Hy02/8G1nNCN/nSP7Q4ood
         oH9UEagvpY5FLVWHBw2kWcZoD3u+apu4LoYnUXjhUOHNoy4eAtLsXB8ErmLxuvv8JKdx
         mEAmBLwsHrbwLqp5JjllArjXPitcepYN668yh9/GPgJWTOjtQR9wV7b5J5hnr5Qd85LB
         zOEv0ymgk7bGOJPXlADjuq1/24x9s+iHEuu7/lUXWGTlYDPQe0NPf2wh9u9uW5pr/z8V
         8N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746288615; x=1746893415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qORCx+39/uFvrfU5GH+eAwD4hm/2Utcm2msUTJttIK4=;
        b=Ya2tTzzHvBA8OsQbKoxqiBu9RbQkgUe/5ZuEnlUMsK/wBdrfnYEsz7lVPgL8apl7wY
         OnfjQ3eYmcB+yizM2Ix649akQ79U85qwj+9J1Iim4g+071PPnIIQgHBJflXPEHVrH4zK
         PeH899Lg4zFKa9qLxJdTElYRKtfUkNAPeyabOYl4t+o0m30cUFdf/IJCiQ6z9itQ6H6L
         VJQoLX/AH9oIYujGsIjcBSnYGMOV8HQfZP4lYN21FfNRzAUHc1Ij9Lpm4e+2sHr3jsvb
         1xLI8jQ2PRPdez93gwdXfqmlU8V0tHVvnBS/RWZJ94CIqqkCN5oc/mojcm3gdHE/Oj5v
         7CiQ==
X-Gm-Message-State: AOJu0YzSPwifdO1EMqhcH2zGQiku/dp89KRvIlKbWTiAb0/RDvAYeiWg
	8902fM0qgHNqkBCS4bAtLO7Dmks0z1Ak1ZEsiwhADPF1rOOtouDlbdhKqCdeWsLm+F8c4DuXuUZ
	7+HH9fA==
X-Gm-Gg: ASbGncvM2yZJ247N3ZmvpmjiXqjTn7GfN3dYKK0kKGMOWW4L7uUEa2hmzFzuQnDzL7p
	v4WrYcrq/UmN2Pvll79tdyhAS6UEWUkogUuXVjxzOFZIpCzjB7qHLX87bSwVdh5dag+FQ4SNhnZ
	G2wz022GjPCeOqip2QlYRkNsg3iabTmShuC1FdtmfZUP95OIqEM3n6+hEBzDKYff5xSgKx4eaOx
	0IEmVwXzn4nrhOfnWdcasXpSD3a5NCs4XFUIRVSZtxCcgP+/uY4mJxLmjI7mnKQJKAo3bDG1Nq9
	KtEiUQj0Gy36lPpyrNQfkSXd5IIy30UH+TSJraCW+RQnLrZTMFpG4zE=
X-Google-Smtp-Source: AGHT+IEeolJ1yN1CaoQUt44J/K/Hqrq88Vgxv+isVxNORd/DAjH9J57LAIEqkdlzMTC2ClBbN47EHw==
X-Received: by 2002:a05:6000:2501:b0:391:4873:7943 with SMTP id ffacd0b85a97d-3a09fd88991mr1225226f8f.32.1746288614620;
        Sat, 03 May 2025 09:10:14 -0700 (PDT)
Received: from DESKTOP-H1V1TGM.mynet ([143.58.255.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae8117sm5235754f8f.56.2025.05.03.09.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 09:10:14 -0700 (PDT)
From: Lazar Sumar <sumar@lazar.co.nz>
X-Google-Original-From: Lazar Sumar <bugzilla@lazar.co.nz>
To: git@vger.kernel.org
Cc: Lazar Sumar <bugzilla@lazar.co.nz>,
	Denton Liu <liu.denton@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Calvin Wan <calvinwan@google.com>,
	Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/1] Add git remote group sub-command
Date: Sat,  3 May 2025 17:09:52 +0100
Message-ID: <20250503160953.196329-2-bugzilla@lazar.co.nz>
X-Mailer: git-send-email 2.49.0.460.g0390bdefd0.dirty
In-Reply-To: <20250503160953.196329-1-bugzilla@lazar.co.nz>
References: <20250503160953.196329-1-bugzilla@lazar.co.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remote groups are an existing feature of git presently managed
exclusively via the config. This patch gives them their own subcommand
for listing the existing groups with the intent of adding future
subcommands under it for adding/updating/removing groups.

As a side-effect this command can now be used in bash tab completion for
the fetch command which did not offer them as a completion option
previously. Note that the push command does not accept remote groups as
an argument.

Signed-off-by: Lazar Sumar <bugzilla@lazar.co.nz>
---
 Documentation/git-remote.adoc          |  6 ++++
 builtin/remote.c                       | 47 ++++++++++++++++++++++++++
 contrib/completion/git-completion.bash | 21 ++++++++++--
 t/t5506-remote-groups.sh               | 31 +++++++++++++++++
 4 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index 932a5c3ea4..87ddda8d58 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -22,6 +22,7 @@ SYNOPSIS
 'git remote' [-v | --verbose] 'show' [-n] <name>...
 'git remote prune' [-n | --dry-run] <name>...
 'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
+'git remote group'
 
 DESCRIPTION
 -----------
@@ -197,6 +198,11 @@ be updated.  (See linkgit:git-config[1]).
 +
 With `--prune` option, run pruning against all the remotes that are updated.
 
+'group'::
+
+List all configured remote groups. The remote groups configuration is achieved
+using the `remotes.<group>` configuration variables.  (See
+linkgit:git-config[1]).
 
 DISCUSSION
 ----------
diff --git a/builtin/remote.c b/builtin/remote.c
index b4baa34e66..2217447230 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -28,6 +28,7 @@ static const char * const builtin_remote_usage[] = {
 	N_("git remote [-v | --verbose] show [-n] <name>"),
 	N_("git remote prune [-n | --dry-run] <name>"),
 	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
+	N_("git remote group"),
 	N_("git remote set-branches [--add] <name> <branch>..."),
 	N_("git remote get-url [--push] [--all] <name>"),
 	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
@@ -77,6 +78,11 @@ static const char * const builtin_remote_update_usage[] = {
 	NULL
 };
 
+static const char * const builtin_remote_group_usage[] = {
+	N_("git remote group"),
+	NULL
+};
+
 static const char * const builtin_remote_geturl_usage[] = {
 	N_("git remote get-url [--push] [--all] <name>"),
 	NULL
@@ -1633,6 +1639,46 @@ static int update(int argc, const char **argv, const char *prefix,
 	return run_command(&cmd);
 }
 
+static int get_remote_group(const char *key, const char *value UNUSED,
+			    const struct config_context *ctx UNUSED,
+			    void *priv)
+{
+	struct string_list *remote_group_list = priv;
+
+	if (skip_prefix(key, "remotes.", &key)) {
+		size_t wordlen = strlen(key);
+		if (wordlen >= 1)
+			string_list_append_nodup(remote_group_list,
+						xstrndup(key, wordlen));
+	}
+	string_list_remove_duplicates(remote_group_list, 0);
+
+	return 0;
+}
+
+static int group(int argc, const char **argv, const char *prefix,
+	struct repository *repo UNUSED)
+{
+	struct string_list remote_group_list = STRING_LIST_INIT_DUP;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+		builtin_remote_group_usage, 0);
+	if (argc != 0)
+		usage_with_options(builtin_remote_group_usage, options);
+
+	git_config(get_remote_group, &remote_group_list);
+	for (int i = 0; i < remote_group_list.nr; i++) {
+		const char *name = remote_group_list.items[i].string;
+		printf_ln(_("%s"), name);
+	}
+	string_list_clear(&remote_group_list, 0);
+
+	return 0;
+}
+
 static int remove_all_fetch_refspecs(const char *key)
 {
 	return git_config_set_multivar_gently(key, NULL, NULL,
@@ -1844,6 +1890,7 @@ int cmd_remote(int argc,
 		OPT_SUBCOMMAND("show", &fn, show),
 		OPT_SUBCOMMAND("prune", &fn, prune),
 		OPT_SUBCOMMAND("update", &fn, update),
+		OPT_SUBCOMMAND("group", &fn, group),
 		OPT_END()
 	};
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3d88b0672..658bea9d96 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1050,6 +1050,17 @@ __git_remotes ()
 	__git remote
 }
 
+__git_remote_groups ()
+{
+	__git remote group
+}
+
+__git_remotes_or_groups ()
+{
+	__git_remotes
+	__git_remote_groups
+}
+
 # Returns true if $1 matches the name of a configured remote, false otherwise.
 __git_is_configured_remote ()
 {
@@ -1181,7 +1192,10 @@ __git_complete_remote_or_refspec ()
 		((c++))
 	done
 	if [ -z "$remote" ]; then
-		__gitcomp_nl "$(__git_remotes)"
+		case "$cmd" in
+		push) __gitcomp_nl "$(__git_remotes)" ;;
+		*) __gitcomp_nl "$(__git_remotes_or_groups)" ;;
+		esac
 		return
 	fi
 	if [ $no_complete_refspec = 1 ]; then
@@ -3073,7 +3087,7 @@ _git_remote ()
 {
 	local subcommands="
 		add rename remove set-head set-branches
-		get-url set-url show prune update
+		get-url set-url show prune update group
 		"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
@@ -3109,6 +3123,9 @@ _git_remote ()
 	update,*)
 		__gitcomp "$(__git_remotes) $(__git_get_config_variables "remotes")"
 		;;
+	group,--*)
+		__gitcomp_builtin remote_group
+		;;
 	set-url,--*)
 		__gitcomp_builtin remote_set-url
 		;;
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 16e9a1bc2f..7859e6805b 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -31,6 +31,12 @@ repo_fetched() {
 	return 1
 }
 
+check_groups() {
+	echo $@ | sort >expected_groups;
+	git remote group | sort >listed_groups;
+	git diff --no-index --quiet expected_groups listed_groups
+}
+
 test_expect_success 'setup' '
 	mkdir one && (cd one && git init) &&
 	mkdir two && (cd two && git init) &&
@@ -64,6 +70,12 @@ test_expect_success 'updating group updates all members (remote update)' '
 	repo_fetched two
 '
 
+test_expect_success 'prints the configured group "all" once (remote group)' '
+	echo "all" >expect &&
+	test_expect_code 0 git remote group 1>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'updating group updates all members (fetch)' '
 	mark fetch-group-all &&
 	update_repos &&
@@ -81,6 +93,15 @@ test_expect_success 'updating group does not update non-members (remote update)'
 	! repo_fetched two
 '
 
+test_expect_success 'prints configured groups "all" and "some" (remote group)' '
+	cat >expect <<-EOF &&
+	all
+	some
+	EOF
+	test_expect_code 0 git remote group 1>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'updating group does not update non-members (fetch)' '
 	mark fetch-group-some &&
 	update_repos &&
@@ -107,4 +128,14 @@ test_expect_success 'updating group in parallel with a duplicate remote does not
 	repo_fetched one
 '
 
+test_expect_success 'groups are printed in order of configuration (remote group)' '
+	cat >expect <<-EOF &&
+	all
+	some
+	duplicate
+	EOF
+	test_expect_code 0 git remote group 1>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.49.0.460.g0390bdefd0.dirty

