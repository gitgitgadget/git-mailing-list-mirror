Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5127F1F576
	for <e@80x24.org>; Mon, 26 Feb 2018 09:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBZJau (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 04:30:50 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36559 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbeBZJat (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 04:30:49 -0500
Received: by mail-pf0-f194.google.com with SMTP id 68so6283213pfx.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 01:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0A0ZJNMcF29zuYkdSK3RCUhHDwFU2AhbXECWl1WDh00=;
        b=VmBwUzDFLNMqn7km/Ysi9ubJr87QkPduS3V0J0muzheNX8q1r3JjqekPLSXXzdG+kS
         2HB8aOlSPnKcwa9RPGU9HbSojlbgApbcCWn7FqYMo583vrNF0eS8QdOZLGcziwqpujGw
         dXqaCD7wlDr9gQJKwa2w5+bOASyZmnocjRAN+OkjqvmJQd+E6KqeR7Xrz9m6JlfISdi3
         YEiVL96M4AuCVMwzdslrbbSpvJWyUeJi/IMdBPSH6OfslrgXWzwXQRrEfKFL+lKtZEe/
         zWfBOXnyELhehssbmWtlcfLxtvw1kSpzW18jd1TQ3yZDdUXUd1R70obeS0BvLyK64Ie0
         AD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0A0ZJNMcF29zuYkdSK3RCUhHDwFU2AhbXECWl1WDh00=;
        b=bN9WgAewzLCLeJVODfCoPjm7fxMYrZ749Ws5syaVZKt5o1c/5jQCDm0nwSm/bGzMlG
         i4LUR+ZOEn+oNoXQkP1fjZbZzJgSlN2pjMbitTBRAuib9j3vLFBax/aLqhI8PMx+2a05
         cd6ILgaapIIpfuDFg7eTob4QgRve/m2lDgoeKl+QaIbF+ZNJdjWLImWc1GIasXe7linY
         xv/KS2Ekes01V8Bgw4PJVW981f3YYn0ZvWBIAmBbO7rnFOc4dk3jwaWga/JJHsdms9L9
         PiiXrkyk5Q7Sru1D2sxMll5P+UQwI6Ymo4C0ooPM+Zy9z+PwqgaSGHgpOJo8aHNwQ+My
         FW4w==
X-Gm-Message-State: APf1xPADK29vUhKg7/fIeAwJieKIMm4ak6zZ7ghYcc33sPuR3d7oNjk9
        LoQxxinnOLdN9Q9Kx58C6LM9EA==
X-Google-Smtp-Source: AG47ELtR/KFaEbRrJ1xgO3ChaXuYvf5phZl2tbRwrsb4cvWbSRh8Nucs9mJmZrEe4nQ9vaCm5thpjQ==
X-Received: by 10.98.178.17 with SMTP id x17mr575842pfe.2.1519637448880;
        Mon, 26 Feb 2018 01:30:48 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 205sm17122461pfy.117.2018.02.26.01.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2018 01:30:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 26 Feb 2018 16:30:41 +0700
Date:   Mon, 26 Feb 2018 16:30:41 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 01/27] repository: introduce raw object store field
Message-ID: <20180226093040.GA10479@ash>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
 <20180224004754.129721-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224004754.129721-2-sbeller@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 04:47:28PM -0800, Stefan Beller wrote:
>  /* The main repository */
>  static struct repository the_repo = {
> -	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
> +	NULL, NULL,
> +	RAW_OBJECT_STORE_INIT,
> +	NULL, NULL, NULL,
> +	NULL, NULL, NULL,
> +	&the_index,
> +	&hash_algos[GIT_HASH_SHA1],
> +	0, 0
>  };
>  struct repository *the_repository = &the_repo;

I wonder if we should do something like this. It makes the_repo
initialization easier to read and it helps unify the init code with
submodule.

No don't reroll. If you think it's a good idea, you can do something
like this in the next series instead.

-- 8< --
diff --git a/check-racy.c b/check-racy.c
index 24b6542352..47cbb4eb6d 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -1,10 +1,12 @@
 #include "cache.h"
+#include "repository.h"
 
 int main(int ac, char **av)
 {
 	int i;
 	int dirty, clean, racy;
 
+	init_the_repository();
 	dirty = clean = racy = 0;
 	read_cache();
 	for (i = 0; i < active_nr; i++) {
diff --git a/common-main.c b/common-main.c
index 6a689007e7..a13ab981aa 100644
--- a/common-main.c
+++ b/common-main.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "attr.h"
+#include "repository.h"
 
 /*
  * Many parts of Git have subprograms communicate via pipe, expect the
@@ -32,6 +33,8 @@ int main(int argc, const char **argv)
 	 */
 	sanitize_stdfds();
 
+	init_the_repository();
+
 	git_setup_gettext();
 
 	attr_start();
diff --git a/object-store.h b/object-store.h
index cf35760ceb..c3253ebc59 100644
--- a/object-store.h
+++ b/object-store.h
@@ -8,8 +8,8 @@ struct raw_object_store {
 	 */
 	char *objectdir;
 };
-#define RAW_OBJECT_STORE_INIT { NULL }
 
+void raw_object_store_init(struct raw_object_store *o);
 void raw_object_store_clear(struct raw_object_store *o);
 
 #endif /* OBJECT_STORE_H */
diff --git a/object.c b/object.c
index 11d904c033..8a4d01dd5f 100644
--- a/object.c
+++ b/object.c
@@ -446,6 +446,11 @@ void clear_commit_marks_all(unsigned int flags)
 	}
 }
 
+void raw_object_store_init(struct raw_object_store *o)
+{
+	memset(o, 0, sizeof(*o));
+}
+
 void raw_object_store_clear(struct raw_object_store *o)
 {
 	free(o->objectdir);
diff --git a/repository.c b/repository.c
index 2255ff657e..0ebcca8539 100644
--- a/repository.c
+++ b/repository.c
@@ -5,16 +5,22 @@
 #include "submodule-config.h"
 
 /* The main repository */
-static struct repository the_repo = {
-	NULL, NULL,
-	RAW_OBJECT_STORE_INIT,
-	NULL, NULL, NULL,
-	NULL, NULL, NULL,
-	&the_index,
-	&hash_algos[GIT_HASH_SHA1],
-	0, 0
-};
-struct repository *the_repository = &the_repo;
+static struct repository the_repo;
+struct repository *the_repository;
+
+static void repo_pre_init(struct repository *repo)
+{
+	memset(repo, 0, sizeof(*repo));
+	raw_object_store_init(&repo->objects);
+}
+
+void init_the_repository(void)
+{
+	the_repository = &the_repo;
+	repo_pre_init(the_repository);
+	the_repository->index = &the_index;
+	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+}
 
 static char *git_path_from_env(const char *envvar, const char *git_dir,
 			       const char *path, int fromenv)
@@ -138,7 +144,8 @@ static int read_and_verify_repository_format(struct repository_format *format,
 int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 {
 	struct repository_format format;
-	memset(repo, 0, sizeof(*repo));
+
+	repo_pre_init(repo);
 
 	repo->ignore_env = 1;
 
diff --git a/repository.h b/repository.h
index 1f8bc7a7cf..da6a8f9af9 100644
--- a/repository.h
+++ b/repository.h
@@ -93,6 +93,7 @@ extern void repo_set_gitdir(struct repository *repo, const char *path);
 extern void repo_set_worktree(struct repository *repo, const char *path);
 extern void repo_set_hash_algo(struct repository *repo, int algo);
 extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
+extern void init_the_repository(void);
 extern int repo_submodule_init(struct repository *submodule,
 			       struct repository *superproject,
 			       const char *path);
-- 8< --
