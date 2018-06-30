Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D7C31F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934162AbeF3JIg (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:08:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45460 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754019AbeF3JI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id g3-v6so9064315ljk.12
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGXjCzVbycAjvUm6csnOI1r0f/nLcXHpeWY9C2HdyHA=;
        b=VzPfn3SwMZBl06p2pNrDVJBB9EGJ2482twob7NAXV4rqXoEVjJHDBdGLN2TyunjKBi
         ZYFqo9cMfnG0TdLHBwJdOY3UXNRs4E0wC09gr3Lz4kcdeXuqnE3TXWOERKTx6fm5w7Tu
         RDfpTOIsLjurJuvRcQ/bM/9g4BtMGpHdeN0zkzVYwh/dDqpbbfjzeMZyge0wtuqMB+Pd
         qyWym4ceQRXZdX2Eh3rc6tClqWH6S18dTufRWN1V8WZltOGM99HNHGBRQTK3DuRw96k4
         9oMAzAK4DSAw9SEOZINXNAMSqxu5by/icikxRgxY8jOSgjLQpbA9wH4k5iwGAUFp2+p+
         +C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGXjCzVbycAjvUm6csnOI1r0f/nLcXHpeWY9C2HdyHA=;
        b=Ydf2JtX3cqnyeopZZsX9kTi76Q6hog1WgO6tYhIaulv117uVD5ckI41TDtx43GWXsk
         Ipl51xRNp5XSVDndaW3WRIs7nSPSbIQv7TrxDCGY2X+QD8i0RGshqlA9A42uX1G2nOfz
         6oOF4qHrnvxhbABPent/iWL3CFnCbuFtZz3jU6AW5/gsU/CTjpcEiiQ3Yq6I8FY1lnnv
         npxLGVwZiMPQu/c8DK7AWfLQ8PQvWcfYH1G0CoXRGXMCSz7dn/sxqQ7+tMkaIQ2PcQ1/
         zMkuRUBLsHp/YxRgK4wRghGFm4XxR1+uid2gRmShxP260TOOFFdEc7uBlzm2G8i+49FL
         TfuQ==
X-Gm-Message-State: APt69E1oL7OTjAcHo6dv3onXdA7oOXLPmk3CDkrTjhvRAmXT7a/wBg+w
        YwkhO+ZoAt34coZt+jQ6p3SnkQ==
X-Google-Smtp-Source: AAOMgpeQcws0Nnh9Vb5F80tykRJHhaYSYNb97mhITVfLpcFN3RQde+C4m1lOxoC361nzuf92c/oHng==
X-Received: by 2002:a2e:40c:: with SMTP id 12-v6mr12005945lje.146.1530349704620;
        Sat, 30 Jun 2018 02:08:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/23] Update messages in preparation for i18n
Date:   Sat, 30 Jun 2018 11:07:56 +0200
Message-Id: <20180630090818.28937-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many messages will be marked for translation in the following
commits. This commit updates some of them to be more consistent and
reduce diff noise in those commits. Changes are

- keep the first letter of die(), error() and warning() in lowercase
- no full stop in die(), error() or warning() if it's single sentence
  messages
- indentation
- some messages are turned to BUG(), or prefixed with "BUG:" and will
  not be marked for i18n
- some messages are improved to give more information
- some messages are broken down by sentence to be i18n friendly
- the trailing \n is converted to printf_ln if possible
- errno_errno() is used instead of explicit strerror()

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 archive-zip.c                     |  2 +-
 builtin/config.c                  | 18 +++++++-----
 builtin/grep.c                    | 10 +++----
 builtin/pack-objects.c            | 10 +++----
 builtin/replace.c                 | 22 +++++++-------
 config.c                          |  2 +-
 connect.c                         | 33 +++++++++++----------
 convert.c                         |  6 ++--
 dir.c                             |  4 +--
 pkt-line.c                        |  2 +-
 refs.c                            | 12 ++++----
 refspec.c                         |  2 +-
 sequencer.c                       |  8 +++---
 sha1-file.c                       |  8 +++---
 t/t1400-update-ref.sh             |  8 +++---
 t/t3005-ls-files-relative.sh      |  4 +--
 t/t5801-remote-helpers.sh         |  6 ++--
 t/t7063-status-untracked-cache.sh |  2 +-
 transport-helper.c                | 48 +++++++++++++++----------------
 transport.c                       |  8 +++---
 20 files changed, 111 insertions(+), 104 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 74f3fe9103..48d843489c 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -309,7 +309,7 @@ static int write_zip_entry(struct archiver_args *args,
 		if (is_utf8(path))
 			flags |= ZIP_UTF8;
 		else
-			warning("Path is not valid UTF-8: %s", path);
+			warning("path is not valid UTF-8: %s", path);
 	}
 
 	if (pathlen > 0xffff) {
diff --git a/builtin/config.c b/builtin/config.c
index b29d26dede..ebeb4c5638 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -110,7 +110,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 		 * --int' and '--type=bool
 		 * --type=int'.
 		 */
-		error("only one type at a time.");
+		error("only one type at a time");
 		usage_with_options(builtin_config_usage,
 			builtin_config_options);
 	}
@@ -160,7 +160,11 @@ static struct option builtin_config_options[] = {
 static void check_argc(int argc, int min, int max) {
 	if (argc >= min && argc <= max)
 		return;
-	error("wrong number of arguments");
+	if (min == max)
+		error("wrong number of arguments, should be %d", min);
+	else
+		error("wrong number of arguments, should be from %d to %d",
+		      min, max);
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
 
@@ -595,7 +599,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 
 	if (use_global_config + use_system_config + use_local_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
-		error("only one config file at a time.");
+		error("only one config file at a time");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
@@ -622,7 +626,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			 * location; error out even if XDG_CONFIG_HOME
 			 * is set and points at a sane location.
 			 */
-			die("$HOME not set");
+			die("$HOME is not set");
 
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
@@ -664,7 +668,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (HAS_MULTI_BITS(actions)) {
-		error("only one action at a time.");
+		error("only one action at a time");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 	if (actions == 0)
@@ -819,7 +823,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("No such section!");
+			die("no such section: %s", argv[0]);
 	}
 	else if (actions == ACTION_REMOVE_SECTION) {
 		int ret;
@@ -830,7 +834,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			die("No such section!");
+			die("no such section: %s", argv[0]);
 	}
 	else if (actions == ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
diff --git a/builtin/grep.c b/builtin/grep.c
index ee753a403e..9774920999 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -959,7 +959,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!opt.pattern_list)
-		die(_("no pattern given."));
+		die(_("no pattern given"));
 
 	/*
 	 * We have to find "--" in a separate pass, because its presence
@@ -1085,19 +1085,19 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (recurse_submodules && (!use_index || untracked))
-		die(_("option not supported with --recurse-submodules."));
+		die(_("option not supported with --recurse-submodules"));
 
 	if (!show_in_pager && !opt.status_only)
 		setup_pager();
 
 	if (!use_index && (untracked || cached))
-		die(_("--cached or --untracked cannot be used with --no-index."));
+		die(_("--cached or --untracked cannot be used with --no-index"));
 
 	if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
 		hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
 	} else if (0 <= opt_exclude) {
-		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
+		die(_("--[no-]exclude-standard cannot be used for tracked contents"));
 	} else if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
@@ -1105,7 +1105,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		hit = grep_cache(&opt, the_repository, &pathspec, cached);
 	} else {
 		if (cached)
-			die(_("both --cached and trees are given."));
+			die(_("both --cached and trees are given"));
 
 		hit = grep_objects(&opt, &pathspec, &list);
 	}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 71056d8294..1a6ece425d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2341,7 +2341,7 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		return;
 	}
 	if (progress > pack_to_stdout)
-		fprintf(stderr, "Delta compression using up to %d threads.\n",
+		fprintf_ln(stderr, "Delta compression using up to %d threads.",
 				delta_search_threads);
 	p = xcalloc(delta_search_threads, sizeof(*p));
 
@@ -2638,7 +2638,7 @@ static void read_object_list_from_stdin(void)
 			if (feof(stdin))
 				break;
 			if (!ferror(stdin))
-				die("fgets returned NULL, not EOF, not error!");
+				die("BUG: fgets returned NULL, not EOF, not error!");
 			if (errno != EINTR)
 				die_errno("fgets");
 			clearerr(stdin);
@@ -3353,8 +3353,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		prepare_pack(window, depth);
 	write_pack_file();
 	if (progress)
-		fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
-			" reused %"PRIu32" (delta %"PRIu32")\n",
-			written, written_delta, reused, reused_delta);
+		fprintf_ln(stderr, "Total %"PRIu32" (delta %"PRIu32"),"
+			   " reused %"PRIu32" (delta %"PRIu32")",
+			   written, written_delta, reused, reused_delta);
 	return 0;
 }
diff --git a/builtin/replace.c b/builtin/replace.c
index 6da2411e14..de826e8209 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -54,7 +54,7 @@ static int show_reference(const char *refname, const struct object_id *oid,
 			enum object_type obj_type, repl_type;
 
 			if (get_oid(refname, &object))
-				return error("Failed to resolve '%s' as a valid ref.", refname);
+				return error("failed to resolve '%s' as a valid ref", refname);
 
 			obj_type = oid_object_info(the_repository, &object,
 						   NULL);
@@ -108,7 +108,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 
 	for (p = argv; *p; p++) {
 		if (get_oid(*p, &oid)) {
-			error("Failed to resolve '%s' as a valid ref.", *p);
+			error("failed to resolve '%s' as a valid ref", *p);
 			had_error = 1;
 			continue;
 		}
@@ -118,7 +118,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 		full_hex = ref.buf + base_len;
 
 		if (read_ref(ref.buf, &oid)) {
-			error("replace ref '%s' not found.", full_hex);
+			error("replace ref '%s' not found", full_hex);
 			had_error = 1;
 			continue;
 		}
@@ -134,7 +134,7 @@ static int delete_replace_ref(const char *name, const char *ref,
 {
 	if (delete_ref(NULL, ref, oid, 0))
 		return 1;
-	printf("Deleted replace ref '%s'\n", name);
+	printf_ln("Deleted replace ref '%s'", name);
 	return 0;
 }
 
@@ -146,7 +146,7 @@ static int check_ref_valid(struct object_id *object,
 	strbuf_reset(ref);
 	strbuf_addf(ref, "%s%s", git_replace_ref_base, oid_to_hex(object));
 	if (check_refname_format(ref->buf, 0))
-		return error("'%s' is not a valid ref name.", ref->buf);
+		return error("'%s' is not a valid ref name", ref->buf);
 
 	if (read_ref(ref->buf, prev))
 		oidclr(prev);
@@ -200,10 +200,10 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
 	struct object_id object, repl;
 
 	if (get_oid(object_ref, &object))
-		return error("Failed to resolve '%s' as a valid ref.",
+		return error("failed to resolve '%s' as a valid ref",
 			     object_ref);
 	if (get_oid(replace_ref, &repl))
-		return error("Failed to resolve '%s' as a valid ref.",
+		return error("failed to resolve '%s' as a valid ref",
 			     replace_ref);
 
 	return replace_object_oid(object_ref, &object, replace_ref, &repl, force);
@@ -315,7 +315,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	struct strbuf ref = STRBUF_INIT;
 
 	if (get_oid(object_ref, &old_oid) < 0)
-		return error("Not a valid object name: '%s'", object_ref);
+		return error("not a valid object name: '%s'", object_ref);
 
 	type = oid_object_info(the_repository, &old_oid, NULL);
 	if (type < 0)
@@ -368,7 +368,7 @@ static int replace_parents(struct strbuf *buf, int argc, const char **argv)
 		struct object_id oid;
 		if (get_oid(argv[i], &oid) < 0) {
 			strbuf_release(&new_parents);
-			return error(_("Not a valid object name: '%s'"),
+			return error(_("not a valid object name: '%s'"),
 				     argv[i]);
 		}
 		if (!lookup_commit_reference(&oid)) {
@@ -412,7 +412,7 @@ static int check_one_mergetag(struct commit *commit,
 	for (i = 1; i < mergetag_data->argc; i++) {
 		struct object_id oid;
 		if (get_oid(mergetag_data->argv[i], &oid) < 0)
-			return error(_("Not a valid object name: '%s'"),
+			return error(_("not a valid object name: '%s'"),
 				     mergetag_data->argv[i]);
 		if (!oidcmp(&tag->tagged->oid, &oid))
 			return 0; /* found */
@@ -442,7 +442,7 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 	unsigned long size;
 
 	if (get_oid(old_ref, &old_oid) < 0)
-		return error(_("Not a valid object name: '%s'"), old_ref);
+		return error(_("not a valid object name: '%s'"), old_ref);
 	commit = lookup_commit_reference(&old_oid);
 	if (!commit)
 		return error(_("could not parse %s"), old_ref);
diff --git a/config.c b/config.c
index f4a208a166..bb2e30fe3d 100644
--- a/config.c
+++ b/config.c
@@ -461,7 +461,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	envw = xstrdup(env);
 
 	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
-		ret = error("bogus format in " CONFIG_DATA_ENVIRONMENT);
+		ret = error("bogus format in %s", CONFIG_DATA_ENVIRONMENT);
 		goto out;
 	}
 
diff --git a/connect.c b/connect.c
index 968e91b18c..083cf804a7 100644
--- a/connect.c
+++ b/connect.c
@@ -58,7 +58,7 @@ static NORETURN void die_initial_contact(int unexpected)
 	 * response does not necessarily mean an ACL problem, though.
 	 */
 	if (unexpected)
-		die(_("The remote end hung up upon initial contact"));
+		die(_("the remote end hung up upon initial contact"));
 	else
 		die(_("Could not read from remote repository.\n\n"
 		      "Please make sure you have the correct access rights\n"
@@ -230,7 +230,7 @@ static int process_dummy_ref(const char *line)
 static void check_no_capabilities(const char *line, int len)
 {
 	if (strlen(line) != len)
-		warning("Ignoring capabilities after first line '%s'",
+		warning("ignoring capabilities after first line '%s'",
 			line + strlen(line));
 }
 
@@ -544,7 +544,7 @@ static enum protocol get_protocol(const char *name)
 		return PROTO_SSH;
 	if (!strcmp(name, "file"))
 		return PROTO_FILE;
-	die("I don't handle protocol '%s'", name);
+	die("protocol '%s' is not supported", name);
 }
 
 static char *host_end(char **hoststart, int removebrackets)
@@ -595,8 +595,7 @@ static void enable_keepalive(int sockfd)
 	int ka = 1;
 
 	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0)
-		fprintf(stderr, "unable to set SO_KEEPALIVE on socket: %s\n",
-			strerror(errno));
+		error_errno("unable to set SO_KEEPALIVE on socket");
 }
 
 #ifndef NO_IPV6
@@ -640,10 +639,12 @@ static int git_tcp_connect_sock(char *host, int flags)
 
 	gai = getaddrinfo(host, port, &hints, &ai);
 	if (gai)
-		die("Unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
+		die("unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
 
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
+	if (flags & CONNECT_VERBOSE) {
+		fprintf_ln(stderr, "done.");
+		fprintf(stderr, "Connecting to %s (port %s) ... ", host, port);
+	}
 
 	for (ai0 = ai; ai; ai = ai->ai_next, cnt++) {
 		sockfd = socket(ai->ai_family,
@@ -670,7 +671,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 	enable_keepalive(sockfd);
 
 	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\n");
+		fprintf_ln(stderr, "done.");
 
 	strbuf_release(&error_message);
 
@@ -701,18 +702,20 @@ static int git_tcp_connect_sock(char *host, int flags)
 
 	he = gethostbyname(host);
 	if (!he)
-		die("Unable to look up %s (%s)", host, hstrerror(h_errno));
+		die("unable to look up %s (%s)", host, hstrerror(h_errno));
 	nport = strtoul(port, &ep, 10);
 	if ( ep == port || *ep ) {
 		/* Not numeric */
 		struct servent *se = getservbyname(port,"tcp");
 		if ( !se )
-			die("Unknown port %s", port);
+			die("unknown port %s", port);
 		nport = se->s_port;
 	}
 
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
+	if (flags & CONNECT_VERBOSE) {
+		fprintf_ln(stderr, "done.");
+		fprintf(stderr, "Connecting to %s (port %s) ... ", host, port);
+	}
 
 	for (cnt = 0, ap = he->h_addr_list; *ap; ap++, cnt++) {
 		memset(&sa, 0, sizeof sa);
@@ -745,7 +748,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 	enable_keepalive(sockfd);
 
 	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\n");
+		fprintf_ln(stderr, "done.");
 
 	return sockfd;
 }
@@ -921,7 +924,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 		path = strchr(end, separator);
 
 	if (!path || !*path)
-		die("No path specified. See 'man git-pull' for valid url syntax");
+		die("no path specified; see 'git help pull' for valid url syntax");
 
 	/*
 	 * null-terminate hostname and point path to ~ for URL's like this:
diff --git a/convert.c b/convert.c
index 64d0d30e08..f47e60022e 100644
--- a/convert.c
+++ b/convert.c
@@ -190,7 +190,7 @@ static enum eol output_eol(enum crlf_action crlf_action)
 		/* fall through */
 		return text_eol_is_crlf() ? EOL_CRLF : EOL_LF;
 	}
-	warning("Illegal crlf_action %d\n", (int)crlf_action);
+	warning("illegal crlf_action %d", (int)crlf_action);
 	return core_eol;
 }
 
@@ -203,7 +203,7 @@ static void check_global_conv_flags_eol(const char *path, enum crlf_action crlf_
 		 * CRLFs would not be restored by checkout
 		 */
 		if (conv_flags & CONV_EOL_RNDTRP_DIE)
-			die(_("CRLF would be replaced by LF in %s."), path);
+			die(_("CRLF would be replaced by LF in %s"), path);
 		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
 			warning(_("CRLF will be replaced by LF in %s.\n"
 				  "The file will have its original line"
@@ -493,7 +493,7 @@ static int encode_to_worktree(const char *path, const char *src, size_t src_len,
 				  &dst_len);
 	if (!dst) {
 		error("failed to encode '%s' from %s to %s",
-			path, default_encoding, enc);
+		      path, default_encoding, enc);
 		return 0;
 	}
 
diff --git a/dir.c b/dir.c
index fe9bf58e4c..e1a2e1cffb 100644
--- a/dir.c
+++ b/dir.c
@@ -560,7 +560,7 @@ int report_path_error(const char *ps_matched,
 		if (found_dup)
 			continue;
 
-		error("pathspec '%s' did not match any file(s) known to git.",
+		error("pathspec '%s' did not match any file(s) known to git",
 		      pathspec->items[num].original);
 		errors++;
 	}
@@ -2230,7 +2230,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 
 	if (!ident_in_untracked(dir->untracked)) {
-		warning(_("Untracked cache is disabled on this system or location."));
+		warning(_("untracked cache is disabled on this system or location"));
 		return NULL;
 	}
 
diff --git a/pkt-line.c b/pkt-line.c
index a593c08aad..941e41dfc1 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -296,7 +296,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 		if (options & PACKET_READ_GENTLE_ON_EOF)
 			return -1;
 
-		die("The remote end hung up unexpectedly");
+		die("the remote end hung up unexpectedly");
 	}
 
 	return ret;
diff --git a/refs.c b/refs.c
index 0eb379f931..a033910353 100644
--- a/refs.c
+++ b/refs.c
@@ -567,9 +567,9 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 			if (!warn_ambiguous_refs)
 				break;
 		} else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
-			warning("ignoring dangling symref %s.", fullref.buf);
+			warning("ignoring dangling symref %s", fullref.buf);
 		} else if ((flag & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
-			warning("ignoring broken ref %s.", fullref.buf);
+			warning("ignoring broken ref %s", fullref.buf);
 		}
 	}
 	strbuf_release(&fullref);
@@ -871,13 +871,13 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 		if (!is_null_oid(&cb->ooid)) {
 			oidcpy(cb->oid, noid);
 			if (oidcmp(&cb->ooid, noid))
-				warning("Log for ref %s has gap after %s.",
+				warning("log for ref %s has gap after %s",
 					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
 		}
 		else if (cb->date == cb->at_time)
 			oidcpy(cb->oid, noid);
 		else if (oidcmp(noid, cb->oid))
-			warning("Log for ref %s unexpectedly ended on %s.",
+			warning("log for ref %s unexpectedly ended on %s",
 				cb->refname, show_date(cb->date, cb->tz,
 						       DATE_MODE(RFC2822)));
 		oidcpy(&cb->ooid, ooid);
@@ -935,7 +935,7 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 		if (flags & GET_OID_QUIETLY)
 			exit(128);
 		else
-			die("Log for %s is empty.", refname);
+			die("log for %s is empty", refname);
 	}
 	if (cb.found_it)
 		return 0;
@@ -1845,7 +1845,7 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 
 		if (!cmp) {
 			strbuf_addf(err,
-				    "multiple updates for ref '%s' not allowed.",
+				    "multiple updates for ref '%s' not allowed",
 				    refnames->items[i].string);
 			return 1;
 		} else if (cmp > 0) {
diff --git a/refspec.c b/refspec.c
index e8010dce0c..c66351743b 100644
--- a/refspec.c
+++ b/refspec.c
@@ -134,7 +134,7 @@ void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
 			      int fetch)
 {
 	if (!refspec_item_init(item, refspec, fetch))
-		die("Invalid refspec '%s'", refspec);
+		die("invalid refspec '%s'", refspec);
 }
 
 void refspec_item_clear(struct refspec_item *item)
diff --git a/sequencer.c b/sequencer.c
index 5354d4d51e..6b6162d194 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -306,7 +306,7 @@ static const char *action_name(const struct replay_opts *opts)
 	case REPLAY_INTERACTIVE_REBASE:
 		return N_("rebase -i");
 	}
-	die(_("Unknown action: %d"), opts->action);
+	die(_("unknown action: %d"), opts->action);
 }
 
 struct commit_message {
@@ -1444,7 +1444,7 @@ static const char *command_to_string(const enum todo_command command)
 {
 	if (command < TODO_COMMENT)
 		return todo_command_info[command].str;
-	die("Unknown command: %d", command);
+	die("unknown command: %d", command);
 }
 
 static char command_to_char(const enum todo_command command)
@@ -2608,7 +2608,7 @@ static int error_with_patch(struct commit *commit,
 			"\n"
 			"  git rebase --continue\n", gpg_sign_opt_quoted(opts));
 	} else if (exit_code)
-		fprintf(stderr, "Could not apply %s... %.*s\n",
+		fprintf_ln(stderr, "Could not apply %s... %.*s",
 			short_commit_name(commit), subject_len, subject);
 
 	return exit_code;
@@ -2719,7 +2719,7 @@ static int do_label(const char *name, int len)
 	struct object_id head_oid;
 
 	if (len == 1 && *name == '#')
-		return error("Illegal label name: '%.*s'", len, name);
+		return error("illegal label name: '%.*s'", len, name);
 
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 	strbuf_addf(&msg, "rebase -i (label) '%.*s'", len, name);
diff --git a/sha1-file.c b/sha1-file.c
index de4839e634..ed7ac73fa9 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -71,17 +71,17 @@ static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
 
 static void git_hash_unknown_init(git_hash_ctx *ctx)
 {
-	die("trying to init unknown hash");
+	BUG("trying to init unknown hash");
 }
 
 static void git_hash_unknown_update(git_hash_ctx *ctx, const void *data, size_t len)
 {
-	die("trying to update unknown hash");
+	BUG("trying to update unknown hash");
 }
 
 static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)
 {
-	die("trying to finalize unknown hash");
+	BUG("trying to finalize unknown hash");
 }
 
 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
@@ -379,7 +379,7 @@ static int alt_odb_usable(struct raw_object_store *o,
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path->buf)) {
 		error("object directory %s does not exist; "
-		      "check .git/objects/info/alternates.",
+		      "check .git/objects/info/alternates",
 		      path->buf);
 		return 0;
 	}
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e1fd0f0ca8..05e68a6671 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -390,7 +390,7 @@ test_expect_success 'Query "master@{2005-05-26 23:33:01}" (middle of history wit
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
 	test $B = $(cat o) &&
-	test "warning: Log for ref $m has gap after $gd." = "$(cat e)"
+	test "warning: log for ref $m has gap after $gd" = "$(cat e)"
 '
 test_expect_success 'Query "master@{2005-05-26 23:38:00}" (middle of history)' '
 	test_when_finished "rm -f o e" &&
@@ -408,7 +408,7 @@ test_expect_success 'Query "master@{2005-05-28}" (past end of history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
 	test $D = $(cat o) &&
-	test "warning: Log for ref $m unexpectedly ended on $ld." = "$(cat e)"
+	test "warning: log for ref $m unexpectedly ended on $ld" = "$(cat e)"
 '
 
 rm -f .git/$m .git/logs/$m expect
@@ -650,7 +650,7 @@ test_expect_success 'stdin fails with duplicate refs' '
 	create $a $m
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
+	grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed" err
 '
 
 test_expect_success 'stdin create ref works' '
@@ -1052,7 +1052,7 @@ test_expect_success 'stdin -z fails option with unknown name' '
 test_expect_success 'stdin -z fails with duplicate refs' '
 	printf $F "create $a" "$m" "create $b" "$m" "create $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
+	grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed" err
 '
 
 test_expect_success 'stdin -z create ref works' '
diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index 377869432e..341fad54ce 100755
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
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 362b1581e0..88c7f158ef 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -126,7 +126,7 @@ test_expect_success 'forced push' '
 test_expect_success 'cloning without refspec' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" \
 	git clone "testgit::${PWD}/server" local2 2>error &&
-	grep "This remote helper should implement refspec capability" error &&
+	grep "this remote helper should implement refspec capability" error &&
 	compare_refs local2 HEAD server HEAD
 '
 
@@ -134,7 +134,7 @@ test_expect_success 'pulling without refspecs' '
 	(cd local2 &&
 	git reset --hard &&
 	GIT_REMOTE_TESTGIT_REFSPEC="" git pull 2>../error) &&
-	grep "This remote helper should implement refspec capability" error &&
+	grep "this remote helper should implement refspec capability" error &&
 	compare_refs local2 HEAD server HEAD
 '
 
@@ -246,7 +246,7 @@ test_expect_success 'proper failure checks for fetching' '
 	(cd local &&
 	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git fetch 2>error &&
 	cat error &&
-	grep -q "Error while running fast-import" error
+	grep -q "error while running fast-import" error
 	)
 '
 
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index c61e304e97..c9162c54f4 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -666,7 +666,7 @@ test_expect_success 'test ident field is working' '
 	mkdir ../other_worktree &&
 	cp -R done dthree dtwo four three ../other_worktree &&
 	GIT_WORK_TREE=../other_worktree git status 2>../err &&
-	echo "warning: Untracked cache is disabled on this system or location." >../expect &&
+	echo "warning: untracked cache is disabled on this system or location" >../expect &&
 	test_i18ncmp ../expect ../err
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 1f8ff7e942..9f487cc905 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -48,7 +48,7 @@ static void sendline(struct helper_data *helper, struct strbuf *buffer)
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", buffer->buf);
 	if (write_in_full(helper->helper->in, buffer->buf, buffer->len) < 0)
-		die_errno("Full write to remote helper failed");
+		die_errno("full write to remote helper failed");
 }
 
 static int recvline_fh(FILE *helper, struct strbuf *buffer)
@@ -77,7 +77,7 @@ static void write_constant(int fd, const char *str)
 	if (debug)
 		fprintf(stderr, "Debug: Remote helper: -> %s", str);
 	if (write_in_full(fd, str, strlen(str)) < 0)
-		die_errno("Full write to remote helper failed");
+		die_errno("full write to remote helper failed");
 }
 
 static const char *remove_ext_force(const char *url)
@@ -129,7 +129,7 @@ static struct child_process *get_helper(struct transport *transport)
 
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
-		die("Unable to find remote helper for '%s'", data->name);
+		die("unable to find remote helper for '%s'", data->name);
 	else if (code != 0)
 		exit(code);
 
@@ -145,7 +145,7 @@ static struct child_process *get_helper(struct transport *transport)
 	 */
 	duped = dup(helper->out);
 	if (duped < 0)
-		die_errno("Can't dup helper output fd");
+		die_errno("can't dup helper output fd");
 	data->out = xfdopen(duped, "r");
 
 	write_constant(helper->in, "capabilities\n");
@@ -196,13 +196,13 @@ static struct child_process *get_helper(struct transport *transport)
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
 		} else if (mandatory) {
-			die("Unknown mandatory capability %s. This remote "
-			    "helper probably needs newer version of Git.",
+			die("unknown mandatory capability %s; this remote "
+			    "helper probably needs newer version of Git",
 			    capname);
 		}
 	}
 	if (!data->rs.nr && (data->import || data->bidi_import || data->export)) {
-		warning("This remote helper should implement refspec capability.");
+		warning("this remote helper should implement refspec capability");
 	}
 	strbuf_release(&buf);
 	if (debug)
@@ -476,7 +476,7 @@ static int fetch_with_import(struct transport *transport,
 	get_helper(transport);
 
 	if (get_importer(transport, &fastimport))
-		die("Couldn't run fast-import");
+		die("couldn't run fast-import");
 
 	for (i = 0; i < nr_heads; i++) {
 		posn = to_fetch[i];
@@ -499,7 +499,7 @@ static int fetch_with_import(struct transport *transport,
 	 */
 
 	if (finish_command(&fastimport))
-		die("Error while running fast-import");
+		die("error while running fast-import");
 
 	/*
 	 * The fast-import stream of a remote helper that advertises
@@ -528,7 +528,7 @@ static int fetch_with_import(struct transport *transport,
 			private = xstrdup(name);
 		if (private) {
 			if (read_ref(private, &posn->old_oid) < 0)
-				die("Could not read ref %s", private);
+				die("could not read ref %s", private);
 			free(private);
 		}
 	}
@@ -554,7 +554,7 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 	 */
 	duped = dup(helper->out);
 	if (duped < 0)
-		die_errno("Can't dup helper output fd");
+		die_errno("can't dup helper output fd");
 	input = xfdopen(duped, "r");
 	setvbuf(input, NULL, _IONBF, 0);
 
@@ -573,7 +573,7 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
 			fprintf(stderr, "Debug: Falling back to dumb "
 				"transport.\n");
 	} else {
-		die("Unknown response to connect: %s",
+		die("unknown response to connect: %s",
 			cmdbuf->buf);
 	}
 
@@ -595,9 +595,9 @@ static int process_connect_service(struct transport *transport,
 	if (strcmp(name, exec)) {
 		int r = set_helper_option(transport, "servpath", exec);
 		if (r > 0)
-			warning("Setting remote service path not supported by protocol.");
+			warning("setting remote service path not supported by protocol");
 		else if (r < 0)
-			warning("Invalid remote service path.");
+			warning("invalid remote service path");
 	}
 
 	if (data->connect) {
@@ -640,10 +640,10 @@ static int connect_helper(struct transport *transport, const char *name,
 	/* Get_helper so connect is inited. */
 	get_helper(transport);
 	if (!data->connect)
-		die("Operation not supported by protocol.");
+		die("operation not supported by protocol");
 
 	if (!process_connect_service(transport, name, exec))
-		die("Can't connect to subservice %s.", name);
+		die("can't connect to subservice %s", name);
 
 	fd[0] = data->helper->out;
 	fd[1] = data->helper->in;
@@ -978,12 +978,12 @@ static int push_refs_with_export(struct transport *transport,
 	}
 
 	if (get_exporter(transport, &exporter, &revlist_args))
-		die("Couldn't run fast-export");
+		die("couldn't run fast-export");
 
 	string_list_clear(&revlist_args, 1);
 
 	if (finish_command(&exporter))
-		die("Error while running fast-export");
+		die("error while running fast-export");
 	if (push_update_refs_status(data, remote_refs, flags))
 		return 1;
 
@@ -1070,7 +1070,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 
 		eov = strchr(buf.buf, ' ');
 		if (!eov)
-			die("Malformed response in ref list: %s", buf.buf);
+			die("malformed response in ref list: %s", buf.buf);
 		eon = strchr(eov + 1, ' ');
 		*eov = '\0';
 		if (eon)
@@ -1084,7 +1084,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 			if (has_attribute(eon + 1, "unchanged")) {
 				(*tail)->status |= REF_STATUS_UPTODATE;
 				if (read_ref((*tail)->name, &(*tail)->old_oid) < 0)
-					die(_("Could not read ref %s"),
+					die(_("could not read ref %s"),
 					    (*tail)->name);
 			}
 		}
@@ -1322,11 +1322,11 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	err = pthread_create(&gtp_thread, NULL, udt_copy_task_routine,
 		&s->gtp);
 	if (err)
-		die("Can't start thread for copying data: %s", strerror(err));
+		die("can't start thread for copying data: %s", strerror(err));
 	err = pthread_create(&ptg_thread, NULL, udt_copy_task_routine,
 		&s->ptg);
 	if (err)
-		die("Can't start thread for copying data: %s", strerror(err));
+		die("can't start thread for copying data: %s", strerror(err));
 
 	ret |= tloop_join(gtp_thread, "Git to program copy");
 	ret |= tloop_join(ptg_thread, "Program to git copy");
@@ -1385,7 +1385,7 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	/* Fork thread #1: git to program. */
 	pid1 = fork();
 	if (pid1 < 0)
-		die_errno("Can't start thread for copying data");
+		die_errno("can't start thread for copying data");
 	else if (pid1 == 0) {
 		udt_kill_transfer(&s->ptg);
 		exit(udt_copy_task_routine(&s->gtp) ? 0 : 1);
@@ -1394,7 +1394,7 @@ static int tloop_spawnwait_tasks(struct bidirectional_transfer_state *s)
 	/* Fork thread #2: program to git. */
 	pid2 = fork();
 	if (pid2 < 0)
-		die_errno("Can't start thread for copying data");
+		die_errno("can't start thread for copying data");
 	else if (pid2 == 0) {
 		udt_kill_transfer(&s->gtp);
 		exit(udt_copy_task_routine(&s->ptg) ? 0 : 1);
diff --git a/transport.c b/transport.c
index a32da30dee..2f6a7cb4cd 100644
--- a/transport.c
+++ b/transport.c
@@ -139,7 +139,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 		close(data->fd);
 	data->fd = read_bundle_header(transport->url, &data->header);
 	if (data->fd < 0)
-		die ("Could not read bundle '%s'.", transport->url);
+		die("could not read bundle '%s'.", transport->url);
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
 		struct ref *ref = alloc_ref(e->name);
@@ -875,7 +875,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	ret->progress = isatty(2);
 
 	if (!remote)
-		die("No remote provided to transport_get()");
+		BUG("No remote provided to transport_get()");
 
 	ret->got_remote_refs = 0;
 	ret->remote = remote;
@@ -1143,7 +1143,7 @@ int transport_push(struct transport *transport,
 						      transport->push_options,
 						      pretend)) {
 				oid_array_clear(&commits);
-				die("Failed to push all needed submodules!");
+				die("failed to push all needed submodules!");
 			}
 			oid_array_clear(&commits);
 		}
@@ -1265,7 +1265,7 @@ int transport_connect(struct transport *transport, const char *name,
 	if (transport->vtable->connect)
 		return transport->vtable->connect(transport, name, exec, fd);
 	else
-		die("Operation not supported by protocol");
+		die("operation not supported by protocol");
 }
 
 int transport_disconnect(struct transport *transport)
-- 
2.18.0.rc2.476.g39500d3211

