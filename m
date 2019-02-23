Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AAFD20248
	for <e@80x24.org>; Sat, 23 Feb 2019 23:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfBWXjM (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 18:39:12 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52154 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfBWXjM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 18:39:12 -0500
Received: by mail-pf1-f201.google.com with SMTP id x134so4757498pfd.18
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 15:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XEtEND9vfCrppGuzoz/9WVKITc9pEfxWjm0g1lpZBek=;
        b=pmpctPiWvbWg6HddvR0DvtNYiYJnNl4eaAwu3EnCTG4QaNybKEu8LcGL+DVkaQtBOf
         IA4XN+a1OIiurvWOKY0VLfBtv36Oi1cn+hH+2F6CE4KbM8KvvdR3+Bjwickmr8MFO1RY
         +Hco6vrQavynVjrdQZ2dGSLycuCQ+CtYcmEBYpNFtzxyHkHM01FpHamlUIuysLTpMwbd
         mQ+Um/pW4qwC2jpQUZgJTSb/Oek64SvgcX9L9lmkm23+xQ4ZiRaHY1vpa9TNpVmjyl52
         DbL+ChM2f+yD+1MC8Y+Xs2kvmWow7V24iNyOTK+4f2hv6mBjbfhxHDDzWRXTmm/Nt5R8
         o8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XEtEND9vfCrppGuzoz/9WVKITc9pEfxWjm0g1lpZBek=;
        b=QnbstzLvlNWfOryyuFMruscNAcTXvMh8U+EiO4JOfMvH54MZkb1MaWezinzLFEUHgk
         WcI8EUhI4eZnOHEJQJh+PAs2DbrYX6Ez77oFB/Lwrl+0QRrjOvC1OLkPBnLRiuOqkwff
         uql1QbuYokofHGSvyAJdt4NqdljjVxz7uL915CF6MoJqYV72i8faOUbjamZ/wt1OzUG9
         VceFnBBXHIjdNjiQk7iMe/s5I2oUVVwgGBMhdxIslYGEXsVwid6BaWCsv3k5sz0thtQa
         C7r1E7CgCZ1ituRf/lGnFFLAdRnatAXigVoi2+UfrLpA+SSUvSYyMe6EqRYBQlEX9nAL
         ehEg==
X-Gm-Message-State: AHQUAuZ3sqdkQLiJIIIdB8lhO2qrKl34gWXwdrIzl/KJV9P9PaWTIMja
        trONgmW8Q6+NOTNcMVKy6ymX5OrDJIMFmioGiI3E5uMFru2qXSuCmKTJZ4kL+twUB4NumNyScXX
        o/1sqAdUPx0bWrUvsOH15jqWv7FE4q1tYDab7umWPlpaGhmcbMeWodTtbwNRBHfY7qz0UpFRM/7
        uq
X-Google-Smtp-Source: AHgI3IZconPH0GrvVmdaOfoe1E0yZnXH00TaO8ezP5r6y5xqGp49NGNITJ9rWC1r5qtBxTnZuoaJmG5GVJ0X/rJGo19f
X-Received: by 2002:a63:f055:: with SMTP id s21mr4373163pgj.129.1550965151347;
 Sat, 23 Feb 2019 15:39:11 -0800 (PST)
Date:   Sat, 23 Feb 2019 15:38:57 -0800
In-Reply-To: <cover.1550963965.git.jonathantanmy@google.com>
Message-Id: <0d4b4678963fa08b7d73572fa4ae50d08f9e90ce.1550963965.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 3/7] http-fetch: support fetching packfiles by URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach http-fetch the ability to download packfiles directly, given a
URL, and to verify them.

The http_pack_request suite of functions have been modified to support a
NULL target. When target is NULL, the given URL is downloaded directly
instead of being treated as the root of a repository.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-http-fetch.txt |  7 +++-
 http-fetch.c                     | 65 +++++++++++++++++++++++++-------
 http.c                           | 41 ++++++++++++++------
 http.h                           | 11 ++++--
 t/t5550-http-fetch-dumb.sh       | 18 +++++++++
 5 files changed, 113 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 666b042679..e667544bb1 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -9,7 +9,7 @@ git-http-fetch - Download from a remote Git repository via HTTP
 SYNOPSIS
 --------
 [verse]
-'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
+'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin | --packfile | <commit>] <url>
 
 DESCRIPTION
 -----------
@@ -40,6 +40,11 @@ commit-id::
 
 		<commit-id>['\t'<filename-as-in--w>]
 
+--packfile::
+	Instead of a commit id on the command line (which is not expected in
+	this case), 'git http-fetch' fetches the packfile directly at the given
+	URL and generates the corresponding .idx file.
+
 --recover::
 	Verify that everything reachable from target is fetched.  Used after
 	an earlier fetch is interrupted.
diff --git a/http-fetch.c b/http-fetch.c
index a32ac118d9..d283ce83a5 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -5,7 +5,7 @@
 #include "walker.h"
 
 static const char http_fetch_usage[] = "git http-fetch "
-"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
+"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin | --packfile | commit-id] url";
 
 int cmd_main(int argc, const char **argv)
 {
@@ -19,6 +19,7 @@ int cmd_main(int argc, const char **argv)
 	int rc = 0;
 	int get_verbosely = 0;
 	int get_recover = 0;
+	int packfile = 0;
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
@@ -35,43 +36,81 @@ int cmd_main(int argc, const char **argv)
 			get_recover = 1;
 		} else if (!strcmp(argv[arg], "--stdin")) {
 			commits_on_stdin = 1;
+		} else if (!strcmp(argv[arg], "--packfile")) {
+			packfile = 1;
 		}
 		arg++;
 	}
-	if (argc != arg + 2 - commits_on_stdin)
+	if (argc != arg + 2 - (commits_on_stdin || packfile))
 		usage(http_fetch_usage);
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
+	} else if (packfile) {
+		/* URL will be set later */
 	} else {
 		commit_id = (char **) &argv[arg++];
 		commits = 1;
 	}
 
-	if (argv[arg])
-		str_end_url_with_slash(argv[arg], &url);
+	if (packfile) {
+		url = xstrdup(argv[arg]);
+	} else {
+		if (argv[arg])
+			str_end_url_with_slash(argv[arg], &url);
+	}
 
 	setup_git_directory();
 
 	git_config(git_default_config, NULL);
 
 	http_init(NULL, url, 0);
-	walker = get_http_walker(url);
-	walker->get_verbosely = get_verbosely;
-	walker->get_recover = get_recover;
 
-	rc = walker_fetch(walker, commits, commit_id, write_ref, url);
+	if (packfile) {
+		struct http_pack_request *preq;
+		struct slot_results results;
+		int ret;
+		char *lockfile;
+
+		preq = new_http_pack_request(NULL, url);
+		if (preq == NULL)
+			die("couldn't create http pack request");
+		preq->slot->results = &results;
+
+		if (start_active_slot(preq->slot)) {
+			run_active_slot(preq->slot);
+			if (results.curl_result != CURLE_OK) {
+				die("Unable to get pack file %s\n%s", preq->url,
+				    curl_errorstr);
+			}
+		} else {
+			die("Unable to start request");
+		}
+
+		if ((ret = finish_http_pack_request(preq, &lockfile)))
+			die("finish_http_pack_request gave result %d", ret);
+		unlink(lockfile);
+		release_http_pack_request(preq);
+		rc = 0;
+	} else {
+		walker = get_http_walker(url);
+		walker->get_verbosely = get_verbosely;
+		walker->get_recover = get_recover;
+
+		rc = walker_fetch(walker, commits, commit_id, write_ref, url);
 
-	if (commits_on_stdin)
-		walker_targets_free(commits, commit_id, write_ref);
+		if (commits_on_stdin)
+			walker_targets_free(commits, commit_id, write_ref);
 
-	if (walker->corrupt_object_found) {
-		fprintf(stderr,
+		if (walker->corrupt_object_found) {
+			fprintf(stderr,
 "Some loose object were found to be corrupt, but they might be just\n"
 "a false '404 Not Found' error message sent with incorrect HTTP\n"
 "status code.  Suggest running 'git fsck'.\n");
+		}
+
+		walker_free(walker);
 	}
 
-	walker_free(walker);
 	http_cleanup();
 
 	free(url);
diff --git a/http.c b/http.c
index 5f8e602cd2..73c3e6295b 100644
--- a/http.c
+++ b/http.c
@@ -2208,15 +2208,18 @@ int finish_http_pack_request(struct http_pack_request *preq, char **lockfile)
 	int tmpfile_fd;
 	int ret = 0;
 
-	close_pack_index(p);
+	if (p)
+		close_pack_index(p);
 
 	fclose(preq->packfile);
 	preq->packfile = NULL;
 
-	lst = preq->lst;
-	while (*lst != p)
-		lst = &((*lst)->next);
-	*lst = (*lst)->next;
+	if (p) {
+		lst = preq->lst;
+		while (*lst != p)
+			lst = &((*lst)->next);
+		*lst = (*lst)->next;
+	}
 
 	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
 
@@ -2240,7 +2243,8 @@ int finish_http_pack_request(struct http_pack_request *preq, char **lockfile)
 		goto cleanup;
 	}
 
-	install_packed_git(the_repository, p);
+	if (p)
+		install_packed_git(the_repository, p);
 cleanup:
 	close(tmpfile_fd);
 	unlink(preq->tmpfile.buf);
@@ -2258,12 +2262,24 @@ struct http_pack_request *new_http_pack_request(
 	strbuf_init(&preq->tmpfile, 0);
 	preq->target = target;
 
-	end_url_with_slash(&buf, base_url);
-	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
-		sha1_to_hex(target->sha1));
-	preq->url = strbuf_detach(&buf, NULL);
+	if (target) {
+		end_url_with_slash(&buf, base_url);
+		strbuf_addf(&buf, "objects/pack/pack-%s.pack",
+			sha1_to_hex(target->sha1));
+		preq->url = strbuf_detach(&buf, NULL);
+	} else {
+		preq->url = xstrdup(base_url);
+	}
+
+	if (target) {
+		strbuf_addf(&preq->tmpfile, "%s.temp",
+			    sha1_pack_name(target->sha1));
+	} else {
+		strbuf_addf(&preq->tmpfile, "%s/pack/pack-", get_object_directory());
+		strbuf_addstr_urlencode(&preq->tmpfile, base_url, 1);
+		strbuf_addstr(&preq->tmpfile, ".temp");
+	}
 
-	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(target->sha1));
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
 		error("Unable to open local file %s for pack",
@@ -2287,7 +2303,8 @@ struct http_pack_request *new_http_pack_request(
 		if (http_is_verbose)
 			fprintf(stderr,
 				"Resuming fetch of pack %s at byte %"PRIuMAX"\n",
-				sha1_to_hex(target->sha1), (uintmax_t)prev_posn);
+				target ? sha1_to_hex(target->sha1) : base_url,
+				(uintmax_t)prev_posn);
 		http_opt_request_remainder(preq->slot->curl, prev_posn);
 	}
 
diff --git a/http.h b/http.h
index 1aa556257e..a33f2aa4b9 100644
--- a/http.h
+++ b/http.h
@@ -210,7 +210,8 @@ struct http_pack_request {
 	struct active_request_slot *slot;
 
 	/*
-	 * After calling new_http_pack_request(), point lst to the head of the
+	 * After calling new_http_pack_request(), if fetching a pack that
+	 * http_get_info_packs() told us about, point lst to the head of the
 	 * pack list that target is in. finish_http_pack_request() will remove
 	 * target from lst and call install_packed_git() on target.
 	 */
@@ -224,8 +225,12 @@ struct http_pack_request {
 };
 
 /*
- * target must be an element in a pack list obtained from
- * http_get_info_packs().
+ * If fetching a pack that http_get_info_packs() told us about, set target to
+ * an element in a pack list obtained from http_get_info_packs(). The actual
+ * URL fetched will be base_url followed by a suffix with the hash of the pack.
+ *
+ * Otherwise, set target to NULL. The actual URL fetched will be base_url
+ * itself.
  */
 extern struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url);
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 6d7d88ccc9..be81d33d68 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -199,6 +199,16 @@ test_expect_success 'fetch packed objects' '
 	git clone $HTTPD_URL/dumb/repo_pack.git
 '
 
+test_expect_success 'http-fetch --packfile' '
+	git init packfileclient &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git && ls objects/pack/pack-*.pack) &&
+	git -C packfileclient http-fetch --packfile "$HTTPD_URL"/dumb/repo_pack.git/$p &&
+
+	# Ensure that it has the HEAD of repo_pack, at least
+	HASH=$(git -C "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git rev-parse HEAD) &&
+	git -C packfileclient cat-file -e "$HASH"
+'
+
 test_expect_success 'fetch notices corrupt pack' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
@@ -214,6 +224,14 @@ test_expect_success 'fetch notices corrupt pack' '
 	)
 '
 
+test_expect_success 'http-fetch --packfile with corrupt pack' '
+	rm -rf packfileclient &&
+	git init packfileclient &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git && ls objects/pack/pack-*.pack) &&
+	test_must_fail git -C packfileclient http-fetch --packfile \
+		"$HTTPD_URL"/dumb/repo_bad1.git/$p
+'
+
 test_expect_success 'fetch notices corrupt idx' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
-- 
2.19.0.271.gfe8321ec05.dirty

