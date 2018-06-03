Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A5C1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 16:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeFCQeo (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 12:34:44 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:44842 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeFCQen (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 12:34:43 -0400
Received: by mail-lf0-f52.google.com with SMTP id 36-v6so19619683lfr.11
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LWoS4Pm4AhdTpLsaErRINfxMSpqp2CuE0Rixi1jHycA=;
        b=RNoF0oUL9TxLaAxxyoMBj1JAoUdZsvnq1lSfpuu8cKPC9v8Hvy3vTORZPlCBDA19kJ
         l+Fk59ouMItJenMPnbrPQPBl1X2i5V7dp8PnvIanXmisOzN+BXg9zELnRNIL++xsJSIt
         Z28yvMhf6WvZWP/7uHdEqOZWyGVgvr+PvqxSMTJPHYbYoB4vFTWgRuChCOSV1V+thC3y
         b9kyM8ZC+znENo5AnPTRFqHW3MIZ60dFIFK2CMXJBhIv563+McVythabYqxZl/GfO9c3
         ekCstxAC+QqvAFYexFwd7dmopynm7dx5MeBqUnQ14IExRs+DvxtFS7dKN6JjOvjJWWLk
         JAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LWoS4Pm4AhdTpLsaErRINfxMSpqp2CuE0Rixi1jHycA=;
        b=FsAeP7gUIDO8eevvz3dilR9ARhoVITZkg5jXBym76OL7ALuDmjAI2BfywDQf57PS02
         wq1nnDhaz7NQ86tFsa4QoIik+fFT8vTE8G+F8UJGOhLlhC7e+ZDv/HD02RQowwrZ/hw6
         0gz+0buGHngnyDbLJb9V1tIyGN0AZmalYVJLKDgHkXHzpLd1GweZxY6jZxy+M85O/4ZW
         L+npbf3Lw1Lx3+xiJac+O+URMX7LvknBga4K9dzVRSIjoONxDD1WIohxchfsi9VrSTFr
         IJJxVB6gvCPRYSSQMi8ETUSo1quHQq4lS1ImQlp9LyMf4eHnBwqSDSKoWSGNIM2MA+D1
         P63g==
X-Gm-Message-State: APt69E0WXoi6a6ixpRyXs7jIgJwfAUspdChutgR1V2jAg+Qj8Bem2luO
        UrLlVIjJ/k1HaZ2etuHRVfs=
X-Google-Smtp-Source: ADUXVKKsHaczxbT78IfuLovKulPZVSvCZqJecW4IUJy8ROQi2Egf1RadV85NpRrMpq7hX2eMIv7Mdw==
X-Received: by 2002:a2e:96c6:: with SMTP id d6-v6mr1490515ljj.21.1528043681963;
        Sun, 03 Jun 2018 09:34:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v79-v6sm4726895lfd.32.2018.06.03.09.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jun 2018 09:34:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/23] Mark strings for translation
Date:   Sun,  3 Jun 2018 18:33:57 +0200
Message-Id: <20180603163420.13702-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180602043241.9941-1-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 changes

- fix one _() (was "()" by accident)
- improve some error messages while i'm making changes
- restore some multi-sentence messages back

All non-_() changes are now collected in the first patch.

Interdiff

diff --git a/builtin/config.c b/builtin/config.c
index 85f043a243..3c26df6c48 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -160,7 +160,11 @@ static struct option builtin_config_options[] = {
 static void check_argc(int argc, int min, int max) {
 	if (argc >= min && argc <= max)
 		return;
-	error(_("wrong number of arguments"));
+	if (min == max)
+		error(_("wrong number of arguments, should be %d"), min);
+	else
+		error(_("wrong number of arguments, should be from %d to %d"),
+		      min, max);
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
 
@@ -746,7 +750,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
-			"       Use a regexp, --add or --replace-all to change %s"), argv[0]);
+			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
 		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
@@ -819,7 +823,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die(_("no such section!"));
+			die(_("no such section: %s"), argv[0]);
 	}
 	else if (actions == ACTION_REMOVE_SECTION) {
 		int ret;
@@ -830,7 +834,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die(_("no such section!"));
+			die(_("no such section: %s"), argv[0]);
 	}
 	else if (actions == ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
diff --git a/builtin/replace.c b/builtin/replace.c
index c203534fd3..c77b325aa1 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -171,10 +171,10 @@ static int replace_object_oid(const char *object_ref,
 	obj_type = oid_object_info(the_repository, object, NULL);
 	repl_type = oid_object_info(the_repository, repl, NULL);
 	if (!force && obj_type != repl_type)
-		return error(_("objects must be of the same type.\n"
+		return error(_("Objects must be of the same type.\n"
 			       "'%s' points to a replaced object of type '%s'\n"
 			       "while '%s' points to a replacement object of "
-			       "type '%s'"),
+			       "type '%s'."),
 			     object_ref, type_name(obj_type),
 			     replace_ref, type_name(repl_type));
 
diff --git a/config.c b/config.c
index 80eae290e9..96b6020819 100644
--- a/config.c
+++ b/config.c
@@ -461,7 +461,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	envw = xstrdup(env);
 
 	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
-		ret = error(("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
+		ret = error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
 		goto out;
 	}
 
diff --git a/connect.c b/connect.c
index af8a581d0e..70b97cfef6 100644
--- a/connect.c
+++ b/connect.c
@@ -60,7 +60,7 @@ static NORETURN void die_initial_contact(int unexpected)
 	if (unexpected)
 		die(_("the remote end hung up upon initial contact"));
 	else
-		die(_("could not read from remote repository.\n\n"
+		die(_("Could not read from remote repository.\n\n"
 		      "Please make sure you have the correct access rights\n"
 		      "and the repository exists."));
 }
@@ -928,7 +928,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 		path = strchr(end, separator);
 
 	if (!path || !*path)
-		die(_("no path specified. See 'man git-pull' for valid url syntax"));
+		die(_("no path specified; see 'git help pull' for valid url syntax"));
 
 	/*
 	 * null-terminate hostname and point path to ~ for URL's like this:
diff --git a/dir.c b/dir.c
index 848df83321..8e7fa02a01 100644
--- a/dir.c
+++ b/dir.c
@@ -560,7 +560,7 @@ int report_path_error(const char *ps_matched,
 		if (found_dup)
 			continue;
 
-		error(_("pathspec '%s' did not match any file(s) known to git."),
+		error(_("pathspec '%s' did not match any file(s) known to git"),
 		      pathspec->items[num].original);
 		errors++;
 	}
diff --git a/refs.c b/refs.c
index 88b60ac1c6..becb78e441 100644
--- a/refs.c
+++ b/refs.c
@@ -567,9 +567,9 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 			if (!warn_ambiguous_refs)
 				break;
 		} else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
-			warning(_("ignoring dangling symref %s."), fullref.buf);
+			warning(_("ignoring dangling symref %s"), fullref.buf);
 		} else if ((flag & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
-			warning(_("ignoring broken ref %s."), fullref.buf);
+			warning(_("ignoring broken ref %s"), fullref.buf);
 		}
 	}
 	strbuf_release(&fullref);
@@ -1845,7 +1845,7 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 
 		if (!cmp) {
 			strbuf_addf(err,
-				    _("multiple updates for ref '%s' not allowed."),
+				    _("multiple updates for ref '%s' not allowed"),
 				    refnames->items[i].string);
 			return 1;
 		} else if (cmp > 0) {
diff --git a/sequencer.c b/sequencer.c
index 1802b49626..01f3afe7f4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -304,7 +304,7 @@ static const char *action_name(const struct replay_opts *opts)
 	case REPLAY_INTERACTIVE_REBASE:
 		return N_("rebase -i");
 	}
-	die(_("Unknown action: %d"), opts->action);
+	die(_("unknown action: %d"), opts->action);
 }
 
 struct commit_message {
diff --git a/sha1-file.c b/sha1-file.c
index ab055181ec..a0ce97b10b 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -71,17 +71,17 @@ static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
 
 static void git_hash_unknown_init(git_hash_ctx *ctx)
 {
-	die(_("trying to init unknown hash"));
+	BUG("trying to init unknown hash");
 }
 
 static void git_hash_unknown_update(git_hash_ctx *ctx, const void *data, size_t len)
 {
-	die(_("trying to update unknown hash"));
+	BUG("trying to update unknown hash");
 }
 
 static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)
 {
-	die(_("trying to finalize unknown hash"));
+	BUG("trying to finalize unknown hash");
 }
 
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
@@ -379,7 +379,7 @@ static int alt_odb_usable(struct raw_object_store *o,
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path->buf)) {
 		error(_("object directory %s does not exist; "
-			"check .git/objects/info/alternates."),
+			"check .git/objects/info/alternates"),
 		      path->buf);
 		return 0;
 	}
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 2a0007a985..7c8df20955 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -650,7 +650,7 @@ test_expect_success 'stdin fails with duplicate refs' '
 	create $a $m
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	test_i18ngrep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
+	test_i18ngrep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed" err
 '
 
 test_expect_success 'stdin create ref works' '
@@ -1052,7 +1052,7 @@ test_expect_success 'stdin -z fails option with unknown name' '
 test_expect_success 'stdin -z fails with duplicate refs' '
 	printf $F "create $a" "$m" "create $b" "$m" "create $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	test_i18ngrep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
+	test_i18ngrep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed" err
 '
 
 test_expect_success 'stdin -z create ref works' '
diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index cd63ad129a..209b4c7cd8 100755
--- a/t/t3005-ls-files-relative.sh
+++ b/t/t3005-ls-files-relative.sh
@@ -44,7 +44,7 @@ test_expect_success 'ls-files -c' '
 		cd top/sub &&
 		for f in ../y*
 		do
-			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."
+			echo "error: pathspec $sq$f$sq did not match any file(s) known to git"
 		done >expect.err &&
 		echo "Did you forget to ${sq}git add${sq}?" >>expect.err &&
 		ls ../x* >expect.out &&
@@ -59,7 +59,7 @@ test_expect_success 'ls-files -o' '
 		cd top/sub &&
 		for f in ../x*
 		do
-			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."
+			echo "error: pathspec $sq$f$sq did not match any file(s) known to git"
 		done >expect.err &&
 		echo "Did you forget to ${sq}git add${sq}?" >>expect.err &&
 		ls ../y* >expect.out &&
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 051d2659ae..6a949484d0 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -130,7 +130,7 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 	fi &&
 	cat >exp <<-EOF &&
 	fatal: '\''$does_not_exist'\'' does not appear to be a git repository
-	fatal: could not read from remote repository.
+	fatal: Could not read from remote repository.
 
 	Please make sure you have the correct access rights
 	and the repository exists.
diff --git a/transport-helper.c b/transport-helper.c
index 442acec4f4..84a10661cc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -196,8 +196,8 @@ static struct child_process *get_helper(struct transport *transport)
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
 		} else if (mandatory) {
-			die(_("Unknown mandatory capability %s. This remote "
-			      "helper probably needs newer version of Git."),
+			die(_("unknown mandatory capability %s; this remote "
+			      "helper probably needs newer version of Git"),
 			    capname);
 		}
 	}

Nguyễn Thái Ngọc Duy (23):
  Update messages in preparation for i18n
  archive-tar.c: mark more strings for translation
  archive-zip.c: mark more strings for translation
  builtin/config.c: mark more strings for translation
  builtin/grep.c: mark strings for translation and no full stops
  builtin/pack-objects.c: mark more strings for translation
  builtin/replace.c: mark more strings for translation
  commit-graph.c: mark more strings for translation
  config.c: mark more strings for translation
  connect.c: mark more strings for translation
  convert.c: mark more strings for translation
  dir.c: mark more strings for translation
  environment.c: mark more strings for translation
  exec-cmd.c: mark more strings for translation
  object.c: mark more strings for translation
  pkt-line.c: mark more strings for translation
  refs.c: mark more strings for translation
  refspec.c: mark more strings for translation
  replace-object.c: mark more strings for translation
  sequencer.c: mark more strings for translation
  sha1-file.c: mark more strings for translation
  transport.c: mark more strings for translation
  transport-helper.c: mark more strings for translation

 archive-tar.c                         |  12 +--
 archive-zip.c                         |  14 ++--
 builtin/config.c                      |  50 ++++++------
 builtin/grep.c                        |  12 +--
 builtin/pack-objects.c                | 108 ++++++++++++-------------
 builtin/replace.c                     |  90 ++++++++++-----------
 commit-graph.c                        |  20 ++---
 config.c                              |  76 +++++++++---------
 connect.c                             |  85 +++++++++++---------
 convert.c                             |  42 +++++-----
 dir.c                                 |   8 +-
 environment.c                         |   4 +-
 exec-cmd.c                            |   2 +-
 object.c                              |  10 +--
 pkt-line.c                            |  26 +++---
 refs.c                                |  40 +++++-----
 refspec.c                             |   2 +-
 replace-object.c                      |   6 +-
 sequencer.c                           |  28 ++++---
 sha1-file.c                           | 110 +++++++++++++-------------
 t/t0021-conversion.sh                 |   2 +-
 t/t1305-config-include.sh             |   2 +-
 t/t1308-config-set.sh                 |   2 +-
 t/t1400-update-ref.sh                 |  20 ++---
 t/t1404-update-ref-errors.sh          |   4 +-
 t/t1450-fsck.sh                       |   2 +-
 t/t3005-ls-files-relative.sh          |   8 +-
 t/t3210-pack-refs.sh                  |   2 +-
 t/t3310-notes-merge-manual-resolve.sh |   6 +-
 t/t5500-fetch-pack.sh                 |   2 +-
 t/t5505-remote.sh                     |   2 +-
 t/t5570-git-daemon.sh                 |   6 +-
 t/t5801-remote-helpers.sh             |   8 +-
 t/t7063-status-untracked-cache.sh     |   2 +-
 t/t7400-submodule-basic.sh            |   2 +-
 transport-helper.c                    |  89 ++++++++++-----------
 transport.c                           |  18 ++---
 37 files changed, 470 insertions(+), 452 deletions(-)

-- 
2.18.0.rc0.333.g22e6ee6cdf

