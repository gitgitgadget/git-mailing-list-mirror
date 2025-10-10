Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687C22126D
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760058857; cv=none; b=Vz+etpY6CLm49o0MysA2T56dG+j/ADm+dd+fhUq/V7q5eGEV9KVuV3v5asXtIjkXcGbzN7nZlKszbcI1mcD5oNe2gu7AX1rdsD0PyyKEQcJR3SXwLMbQvJNE/iPzRlW8P4ED/LYVIEUmZMIwIY4xcvhZg/hDATsA4MleTw/VKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760058857; c=relaxed/simple;
	bh=n8CVw9x1a7OaqvVbsGglfhEllepzAGcRWG2EwYis8bU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Un8vNsv//9pgo+ZN2LtrTrOqQ+4sxfpYT9VIZCuU5CRNIwv3ognFwbkfTOi3T2A7pZBBnvurO/7QKiACyhVnV+dGm3YyLgZmRK9gA7w0+2sl0rFbw8Khr5pq7TCJ9XqLJuQneY5UDtgam3vYoLX8xIgLA4DsYSJLUp6az6nPToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abM4ESN+; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abM4ESN+"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-856328df6e1so163732485a.0
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760058853; x=1760663653; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ag4zLPhLPixbVfg3zC62mLOyK9e5hyBsmgv8LgyKqpU=;
        b=abM4ESN+vsMjmfIY6YWgR7auMSFXsBQrZDrD8cj9kyGnO3D5kS0oC1TAM3N7DHLZmj
         DdMFH5CZR2qGTcvfUUGFZPdiP8bEszACCDDygAvLvyerxuoET06tMltY85kD4O9zoLnR
         xoa0N1iclWdZadLiHk5f3MfH3bGYocOxaqTzkeQt4ltPYHYwHawQlzVUgQJ0c5xR5FXn
         gRbDTAR0xpuyUeJAqzJVFFXChAEwxjX76NIiOxW9hEkUJ5ULEEIsOdDCvzOxi4tzmzwg
         YGf+SgBtx/19rPMwkrXUu9abKJn9OBs6pruC05kA5HPeVXbF6C+3bnpoTdbE8Va+pE+H
         TTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760058853; x=1760663653;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ag4zLPhLPixbVfg3zC62mLOyK9e5hyBsmgv8LgyKqpU=;
        b=sV135J2jYVNPY4MBgzOfbkfBYlX0BVR7C7uxEPMC1IbEFLKQmBn92Y77vabOqrvA9U
         tZNiFcyFhhyVsjqo1/EOyROyeheB4ngdFBNxtQwRMrk0JpJEWDDqFHtNyj7zAIlhlij/
         ELMEkzxqffBKuiplYOWB/zp1QMpAX1ZgeIfmonoeqEYVdhpyn1b52RMNFYsrUjTE38l1
         EwMfNtAVqlKAFwteFVzG6/DTXe7O4GmgeOHQb/vZNduGjzBRFSCQHag0oPK7i4ODKUiv
         Xt89+7VErBAcSDqiD5JTwcI3B1cSAYl9mq2N5jTMJ2IXHBR+sGad32rjTDPCAvDL4pF3
         RRwg==
X-Gm-Message-State: AOJu0YwO13x6wJ15io63N764MeOt7UNhUwFnY6VeSCz0xVhWiBToxPuz
	GV6soHORui3r9TxExNK1svwXf2uTqGxiVGqqq6gpLdeku+oIi69E4BtdL236Dg==
X-Gm-Gg: ASbGnctFGyaSlbvJ13E0T0zAFqnnbNJVA4FhgF17FuCRbxwWOJzHPlpDKfWCLtkFUXe
	Nk6U4sc0/V6gHH4L40aGFTemAjM78NJIP16gSNPgmS6vtldVBDL859frAFun41ICpE6WlpQlEm5
	KcfZPZAZPBuhCenoIKVcfmXMvzKh41iltYvIJRgTcVLC2EOnyejA3RwEcPhrEgW7YGxJKftpyU/
	ApkMR6Q7XHJnzEagv0KU1wN5pvbsXUCd3REBlctkzCjmxBkN3TbPgJ2at4qiwwkfklKh+EjaA6L
	52TtWSy0aZ2BH173w8cUP8XyVoKTzalRvt6kQkTGGoMUPjrs0G5GU5MBNlt3WDWfPKC2B6k0mh1
	LNIXoSEjCazNBF8fm3cDA8hQKdZ4aYdz/abiohnWK6+t0/C7Gf44j6q2t/nEFK9aRoMlX
X-Google-Smtp-Source: AGHT+IE3HwO0V/7yEqiEN3ldTstbi0eLDN+36fqrsM5RXUvihRyIsTsJalgbTBCQFqbufadaRpLQXA==
X-Received: by 2002:a05:620a:254a:b0:86e:5d59:1d28 with SMTP id af79cd13be357-883527c871amr1213155685a.62.1760058853506;
        Thu, 09 Oct 2025 18:14:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.60.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a28445c8sm294103685a.56.2025.10.09.18.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 18:14:12 -0700 (PDT)
Message-Id: <9d8af4e6164002b8096fc03fa8189a670133bc77.1760058849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
From: "Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Oct 2025 01:14:08 +0000
Subject: [PATCH/RFC 3/4] config: read global scope via config_sequence
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Delilah Ashley Wu <delilahwu@microsoft.com>,
    Derrick Stolee <stolee@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>,
    Delilah Ashley Wu <delilahwu@linux.microsoft.com>,
    Delilah Ashley Wu <delilahwu@microsoft.com>

From: Delilah Ashley Wu <delilahwu@microsoft.com>

The output of `git config list --global` should include both the home
(`$HOME/.gitconfig`) and XDG (`$XDG_CONFIG_HOME/git/config`) configs,
but it only reads from the former.

We assumed each config scope corresponds to a single config file. Under
this assumption, `git config list --global` reads the global config by
calling `git_config_from_file_with_options(...,"~/.gitconfig", ...)`.
This function usage restricts us to a single config file. Because the
global scope includes two files, we should read the configs via another
method.

The output of `git config list --show-scope --show-origin` (without
`--global`) correctly includes both the home and XDG config files. So
there's existing code that respects both locations, namely the
`do_git_config_sequence()` function which reads from all scopes.
Introduce flags to make it possible to ignore all but the global scope
(i.e. ignore system, local, worktree, and cmdline). Then, reuse the
function to read only the global scope when `--global` is specified.
This was the suggested solution in the bug report:
https://lore.kernel.org/git/kl6ly1oze7wb.fsf@chooglen-macbookpro.roam.corp.google.com.

Then, modify the tests to check that `git config list --global` includes
both home and XDG configs.

This patch introduces a regression. If both global config files are
unreadable, then `git config list --global` should exit non-zero. This
is no longer the case, so mark the corresponding test as a "TODO known
breakage" and address the issue in the next patch, config: keep bailing
on unreadable global files.

Implementation notes:
  1. The `ignore_global` flag is not set anywhere, so the
     `if (!opts->ignore_global)` condition is always met. We can remove
     this flag if desired.

  2. I've assumed that `config_source->scope == CONFIG_SCOPE_GLOBAL` iff
     `--global` is specified. This comparison determines whether to call
     `do_git_config_sequence()` for the global scope, or to keep calling
     `git_config_from_file_with_options()` for other scopes.

  3. Keep populating `opts->source.file` in `builtin/config.c` because
     it is used as the destination config file for write operations.
     The proposed changes could convolute the code because there is no
     single source of truth for the config file locations in the global
     scope. Add a comment to help clarify this. Please let me know if
     it's unclear.

Reported-by: Jade Lovelace <lists@jade.fyi>
Suggested-by: Glen Choo <glencbz@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/config.c     | 12 ++++++++++++
 config.c             | 26 +++++++++++++++-----------
 config.h             |  2 ++
 t/t1300-config.sh    |  6 +++---
 t/t1306-xdg-files.sh |  2 +-
 5 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 59fb113b07..3fd1bd7f8d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -768,6 +768,18 @@ static void location_options_init(struct config_location_options *opts,
 	}
 
 	if (opts->use_global_config) {
+		/*
+		 * Since global config is sourced from more than one location,
+		 * use `config.c#do_git_config_sequence()` with `opts->options`
+		 * to read it. However, writing global config should point to a
+		 * single destination, set in `opts->source.file`.
+		 */
+		opts->options.ignore_repo = 1;
+		opts->options.ignore_cmdline= 1;
+		opts->options.ignore_worktree = 1;
+		opts->options.ignore_system = 1;
+		opts->source.scope = CONFIG_SCOPE_GLOBAL;
+
 		opts->source.file = opts->file_to_free = git_global_config();
 		if (!opts->source.file)
 			/*
diff --git a/config.c b/config.c
index 74bf76a97e..4b9f3831b1 100644
--- a/config.c
+++ b/config.c
@@ -1526,22 +1526,27 @@ static int do_git_config_sequence(const struct config_options *opts,
 		worktree_config = NULL;
 	}
 
-	if (git_config_system() && system_config &&
+	if (!opts->ignore_system && git_config_system() && system_config &&
 	    !access_or_die(system_config, R_OK,
 			   opts->system_gently ? ACCESS_EACCES_OK : 0))
 		ret += git_config_from_file_with_options(fn, system_config,
 							 data, CONFIG_SCOPE_SYSTEM,
 							 NULL);
 
-	git_global_config_paths(&user_config, &xdg_config);
+	if (!opts->ignore_global) {
+		git_global_config_paths(&user_config, &xdg_config);
+
+		if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
+			ret += git_config_from_file_with_options(fn, xdg_config, data,
+						CONFIG_SCOPE_GLOBAL, NULL);
 
-	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file_with_options(fn, xdg_config, data,
-							 CONFIG_SCOPE_GLOBAL, NULL);
+		if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
+			ret += git_config_from_file_with_options(fn, user_config, data,
+						CONFIG_SCOPE_GLOBAL, NULL);
 
-	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
-		ret += git_config_from_file_with_options(fn, user_config, data,
-							 CONFIG_SCOPE_GLOBAL, NULL);
+		free(xdg_config);
+		free(user_config);
+	}
 
 	if (!opts->ignore_repo && repo_config &&
 	    !access_or_die(repo_config, R_OK, 0))
@@ -1560,8 +1565,6 @@ static int do_git_config_sequence(const struct config_options *opts,
 		die(_("unable to parse command-line config"));
 
 	free(system_config);
-	free(xdg_config);
-	free(user_config);
 	free(repo_config);
 	free(worktree_config);
 	return ret;
@@ -1591,7 +1594,8 @@ int config_with_options(config_fn_t fn, void *data,
 	 */
 	if (config_source && config_source->use_stdin) {
 		ret = git_config_from_stdin(fn, data, config_source->scope);
-	} else if (config_source && config_source->file) {
+	} else if (config_source && config_source->file &&
+		   config_source->scope != CONFIG_SCOPE_GLOBAL) {
 		ret = git_config_from_file_with_options(fn, config_source->file,
 							data, config_source->scope,
 							NULL);
diff --git a/config.h b/config.h
index 19c87fc0bc..9425fe115d 100644
--- a/config.h
+++ b/config.h
@@ -87,6 +87,8 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 
 struct config_options {
 	unsigned int respect_includes : 1;
+	unsigned int ignore_system : 1;
+	unsigned int ignore_global : 1;
 	unsigned int ignore_repo : 1;
 	unsigned int ignore_worktree : 1;
 	unsigned int ignore_cmdline : 1;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 5fa0111bd9..42f256e122 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2372,7 +2372,7 @@ test_expect_success 'list with nonexistent global config' '
 	git config ${mode_prefix}list --show-scope
 '
 
-test_expect_success 'list --global with nonexistent global config' '
+test_expect_failure 'list --global with nonexistent global config' '
 	rm -rf "$HOME"/.gitconfig "$HOME"/.config/git/config &&
 	test_must_fail git config ${mode_prefix}list --global --show-scope
 '
@@ -2429,7 +2429,7 @@ test_expect_success 'list --global with both home and xdg' '
 	global	file:$HOME/.gitconfig	home.config=true
 	EOF
 	git config ${mode_prefix}list --global --show-scope --show-origin >output &&
-	! test_cmp expect output
+	test_cmp expect output
 '
 
 test_expect_success 'override global and system config' '
@@ -2483,7 +2483,7 @@ test_expect_success 'override global and system config' '
 	test_cmp expect output
 '
 
-test_expect_success 'override global and system config with missing file' '
+test_expect_failure 'override global and system config with missing file' '
 	test_must_fail env GIT_CONFIG_GLOBAL=does-not-exist GIT_CONFIG_SYSTEM=/dev/null git config ${mode_prefix}list --global &&
 	test_must_fail env GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_SYSTEM=does-not-exist git config ${mode_prefix}list --system &&
 	GIT_CONFIG_GLOBAL=does-not-exist GIT_CONFIG_SYSTEM=does-not-exist git version
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 0318755799..475bd26aba 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -71,7 +71,7 @@ test_expect_success 'read with --list: xdg file exists and ~/.gitconfig exists'
 	echo user.name=read_config >expected &&
 	echo user.name=read_gitconfig >>expected &&
 	git config --global --list >actual &&
-	! test_cmp expected actual
+	test_cmp expected actual
 '
 
 
-- 
gitgitgadget

