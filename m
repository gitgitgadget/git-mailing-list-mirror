Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D8CE1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 14:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeC2O5d (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 10:57:33 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38137 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeC2O5b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 10:57:31 -0400
Received: by mail-lf0-f67.google.com with SMTP id u3-v6so8821923lff.5
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EuF9YYAChOBmOftQtO9LfS3K0orvcB4bb1uwUYPlf8E=;
        b=nHelqZMImknNrRgY58TwaZfmSuRO9ug/d/TeyOZdTEKXaH/hRAFQYpYrk0Mc4x43VI
         eS+xkqihI8tENfrFd0t+3Q8M5ODyN5zsPHPl+loOlv54PyU1d+JRXEcxLBppETTn/jwB
         n4j0ep+QIKyyrjOFukjDpIcAuWJapjrVjkVQLAXaUe7B7C6PVa8hdBvPakNb2u+E3WKk
         cBfG2hPb4acK0YvMvjEcCtZQpZ3kWc3LoLhUd3Jv+rgbVtimUqeOoGPoOSn7XmUQugBj
         kgX1X5cDCU52Kyq9ncxzgvp5hWMVUoKILVLC5H20lfOTcsosixAEzOShdBenXhhDGrSo
         4zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EuF9YYAChOBmOftQtO9LfS3K0orvcB4bb1uwUYPlf8E=;
        b=YDqdY5hh5YTy1cuvaykzk9FLBIif5RZj+1sMHFNcTu2iD4bX2az9hbbusWcu37gRco
         3qyBfvzxu8LJrUTYgdb+EKAJvFlvl+eFFsbssh1IQd1/+bZhF/HhwCgSrnjSQJKvhLlp
         gRuWJqB74z00QRxabAcJXXbnbdAkcQbwR10J1yY55EJVwDwcPxvapl6gvmRbWkVUOftW
         jireTWq6dnaWRYLGQ235UlnihH0wJyJuY7jQ3JpSFLcN4DXmuRr9gJde9Q6NqClK+C2w
         78ac+ah4lMZVeWV5W33BsZGZdRddTPg2ZEM9ThM4Fk/U0SXaP3/Yop/8NhVXK9/FPloC
         kcAQ==
X-Gm-Message-State: AElRT7EB+TlubfEKhDFOTHxDRHTb0fSPG6YFeDQ35IcKHjP3k2vFQnad
        y0SgHIqXKCJqFMpyJemsreUB+A==
X-Google-Smtp-Source: AIpwx4+Xjw4+YU1o8qdYULIMhKomV3s6yFQubhVt/n/rWj/MjNs8LGiIJjafInOLqb5kLhtfzPceOA==
X-Received: by 2002:a19:a9d3:: with SMTP id s202-v6mr5814950lfe.30.1522335449467;
        Thu, 29 Mar 2018 07:57:29 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x17-v6sm1200169lfi.30.2018.03.29.07.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Mar 2018 07:57:28 -0700 (PDT)
Date:   Thu, 29 Mar 2018 16:57:26 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Rafael Ascensao <rafa.almas@gmail.com>
Subject: Re: [PATCH 0/8] Re: git complains packed-refs is not a directory
 when used with GIT_DIR and GIT_WORK_TREE envvars.
Message-ID: <20180329145726.GA10253@duynguyen.home>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
 <20180328181932.GB16565@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328181932.GB16565@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 02:19:32PM -0400, Jeff King wrote:
> 
> > I will probably rework on top of your chdir-notify instead (and let
> > yours to be merged earlier)
> 
> Thanks. I like some of the related changes you made, like including this
> in the tracing output. That should be easy to do on top of mine, I
> think.

Yeah. But is it possible to sneak something like this in your series
(I assume you will reroll anyway)? I could do it separately, but it
looks nicer if it's split out and merged in individual patches that
add new chdir-notify call site.

diff --git a/chdir-notify.c b/chdir-notify.c
index 7034e98d71..a2a33443f8 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -4,21 +4,26 @@
 #include "strbuf.h"
 
 struct chdir_notify_entry {
+	const char *name;
 	chdir_notify_callback cb;
 	void *data;
 	struct list_head list;
 };
 static LIST_HEAD(chdir_notify_entries);
 
-void chdir_notify_register(chdir_notify_callback cb, void *data)
+void chdir_notify_register(const char *name,
+			   chdir_notify_callback cb,
+			   void *data)
 {
 	struct chdir_notify_entry *e = xmalloc(sizeof(*e));
 	e->cb = cb;
 	e->data = data;
+	e->name = name;
 	list_add_tail(&e->list, &chdir_notify_entries);
 }
 
-static void reparent_cb(const char *old_cwd,
+static void reparent_cb(const char *name,
+			const char *old_cwd,
 			const char *new_cwd,
 			void *data)
 {
@@ -28,12 +33,16 @@ static void reparent_cb(const char *old_cwd,
 	if (!tmp || !is_absolute_path(tmp))
 		return;
 	*path = reparent_relative_path(old_cwd, new_cwd, tmp);
+	if (name)
+		trace_printf_key(&trace_setup_key,
+				 "setup: reparent %s to '%s'",
+				 name, *path);
 	free(tmp);
 }
 
-void chdir_notify_reparent(char **path)
+void chdir_notify_reparent(const char *name, char **path)
 {
-	chdir_notify_register(reparent_cb, path);
+	chdir_notify_register(name, reparent_cb, path);
 }
 
 int chdir_notify(const char *new_cwd)
@@ -45,11 +54,12 @@ int chdir_notify(const char *new_cwd)
 		return -1;
 	if (chdir(new_cwd) < 0)
 		return -1;
+	trace_printf_key(&trace_setup_key, "setup: chdir to '%s'", new_cwd);
 
 	list_for_each(pos, &chdir_notify_entries) {
 		struct chdir_notify_entry *e =
 			list_entry(pos, struct chdir_notify_entry, list);
-		e->cb(old_cwd.buf, new_cwd, e->data);
+		e->cb(e->name, old_cwd.buf, new_cwd, e->data);
 	}
 
 	strbuf_release(&old_cwd);
diff --git a/chdir-notify.h b/chdir-notify.h
index c3bd818a85..b9be1b54ac 100644
--- a/chdir-notify.h
+++ b/chdir-notify.h
@@ -16,23 +16,29 @@
  *	warning("switched from %s to %s!", old_path, new_path);
  *   }
  *   ...
- *   chdir_notify_register(foo, data);
+ *   chdir_notify_register("description", foo, data);
  *
  * In practice most callers will want to move a relative path to the new root;
  * they can use the reparent_relative_path() helper for that. If that's all
  * you're doing, you can also use the convenience function:
  *
- *   chdir_notify_reparent(&my_path);
+ *   chdir_notify_reparent("description", &my_path);
  *
  * Registered functions are called in the order in which they were added. Note
  * that there's currently no way to remove a function, so make sure that the
  * data parameter remains valid for the rest of the program.
+ *
+ * The first argument is used for tracing purpose only. when my_path is updated
+ * by chdir_notify_reparent() it will print a message if $GIT_TRACE_SETUP is set.
+ * This argument could be NULL.
  */
-typedef void (*chdir_notify_callback)(const char *old_cwd,
+typedef void (*chdir_notify_callback)(const char *name,
+				      const char *old_cwd,
 				      const char *new_cwd,
 				      void *data);
-void chdir_notify_register(chdir_notify_callback cb, void *data);
-void chdir_notify_reparent(char **path);
+void chdir_notify_register(const char *name, chdir_notify_callback cb,
+			   void *data);
+void chdir_notify_reparent(const char *name, char **path);
 
 /*
  *
diff --git a/environment.c b/environment.c
index 794a75a717..92701cbc0c 100644
--- a/environment.c
+++ b/environment.c
@@ -330,11 +330,15 @@ static void set_git_dir_1(const char *path)
 	setup_git_env(path);
 }
 
-static void update_relative_gitdir(const char *old_cwd,
+static void update_relative_gitdir(const char *name,
+				   const char *old_cwd,
 				   const char *new_cwd,
 				   void *data)
 {
 	char *path = reparent_relative_path(old_cwd, new_cwd, get_git_dir());
+	trace_printf_key(&trace_setup_key,
+			 "setup: move $GIR_DIR and others to '%s'",
+			 path);
 	set_git_dir_1(path);
 	free(path);
 }
@@ -343,7 +347,7 @@ void set_git_dir(const char *path)
 {
 	set_git_dir_1(path);
 	if (!is_absolute_path(path))
-		chdir_notify_register(update_relative_gitdir, NULL);
+		chdir_notify_register(NULL, update_relative_gitdir, NULL);
 }
 
 const char *get_log_output_encoding(void)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ab3e00ffa0..861072c0dc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -107,8 +107,8 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
 	refs->packed_ref_store = packed_ref_store_create(sb.buf, flags);
 	strbuf_release(&sb);
 
-	chdir_notify_reparent(&refs->gitdir);
-	chdir_notify_reparent(&refs->gitcommondir);
+	chdir_notify_reparent("files-backend $GIT_DIR", &refs->gitdir);
+	chdir_notify_reparent("files-backedn $GIT_COMMONDIR", &refs->gitcommondir);
 
 	return ref_store;
 }
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6725742f00..369c34f886 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -203,7 +203,7 @@ struct ref_store *packed_ref_store_create(const char *path,
 	refs->store_flags = store_flags;
 
 	refs->path = xstrdup(path);
-	chdir_notify_reparent(&refs->path);
+	chdir_notify_reparent("packed-refs", &refs->path);
 
 	return ref_store;
 }
diff --git a/trace.c b/trace.c
index 7f3b08e148..fc623e91fd 100644
--- a/trace.c
+++ b/trace.c
@@ -26,6 +26,7 @@
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
 struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
+struct trace_key trace_setup_key = TRACE_KEY_INIT(SETUP);
 
 /* Get a trace file descriptor from "key" env variable. */
 static int get_trace_fd(struct trace_key *key)
@@ -300,11 +301,10 @@ static const char *quote_crnl(const char *path)
 /* FIXME: move prefix to startup_info struct and get rid of this arg */
 void trace_repo_setup(const char *prefix)
 {
-	static struct trace_key key = TRACE_KEY_INIT(SETUP);
 	const char *git_work_tree;
 	char *cwd;
 
-	if (!trace_want(&key))
+	if (!trace_want(&trace_setup_key))
 		return;
 
 	cwd = xgetcwd();
@@ -315,11 +315,11 @@ void trace_repo_setup(const char *prefix)
 	if (!prefix)
 		prefix = "(null)";
 
-	trace_printf_key(&key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
-	trace_printf_key(&key, "setup: git_common_dir: %s\n", quote_crnl(get_git_common_dir()));
-	trace_printf_key(&key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
-	trace_printf_key(&key, "setup: cwd: %s\n", quote_crnl(cwd));
-	trace_printf_key(&key, "setup: prefix: %s\n", quote_crnl(prefix));
+	trace_printf_key(&trace_setup_key, "setup: git_dir: %s\n", quote_crnl(get_git_dir()));
+	trace_printf_key(&trace_setup_key, "setup: git_common_dir: %s\n", quote_crnl(get_git_common_dir()));
+	trace_printf_key(&trace_setup_key, "setup: worktree: %s\n", quote_crnl(git_work_tree));
+	trace_printf_key(&trace_setup_key, "setup: cwd: %s\n", quote_crnl(cwd));
+	trace_printf_key(&trace_setup_key, "setup: prefix: %s\n", quote_crnl(prefix));
 
 	free(cwd);
 }
diff --git a/trace.h b/trace.h
index 88055abef7..2b6a1bc17c 100644
--- a/trace.h
+++ b/trace.h
@@ -15,6 +15,7 @@ extern struct trace_key trace_default_key;
 
 #define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
 extern struct trace_key trace_perf_key;
+extern struct trace_key trace_setup_key;
 
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(struct trace_key *key);
