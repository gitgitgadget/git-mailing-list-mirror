Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 385621F404
	for <e@80x24.org>; Tue, 27 Mar 2018 17:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbeC0Ral (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 13:30:41 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:39099 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbeC0Raa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 13:30:30 -0400
Received: by mail-lf0-f50.google.com with SMTP id p142-v6so34463424lfd.6
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 10:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nuJpdffB+AvCUBBJ5J50VlA4GZyGe4zZZz52JZekFuY=;
        b=eu0O/ysGjnZzPihnruXm7Aty8PAlZ9LSO//GoW2AOWD/gQm8I6xmZica/SVYtS9Fon
         ARM9afpn+AeTZa2mEvUZWfMO2UIB1hzjY3Fy20/F+p8kNNHqfyySOUPJeAI7wiLwALrt
         mJUqjYE+fLa4RQxwSE9j5By14d9ZRTZCGsu6L+3Ni1dv6MoekFPOSLA8/cHi/dpTKJjv
         ujvTOoyJg61tck0XYKpkfr5KTjBxu6i4WTNCYYXMUU1OneFshn8NpCil7OllsYvlQlHS
         1LeM37XMIF/Da4g03aU2N1IKEiM/bChmjEIwZillbPf1QeYczZwSek2x7JON27qWjawG
         Aing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nuJpdffB+AvCUBBJ5J50VlA4GZyGe4zZZz52JZekFuY=;
        b=um+A5BRw3SGbY5MTA0HSUE8yzKFaOMXSLHuBdbBLpy2qbdWNj9XLlYvUsusJGkOEeB
         G/x36mH1mb6dEfeM7hUETacJ7TTfus9OdYyu1L4qc9Zd47E8SjXUup0DxM1sTtlbcs/p
         EttlVHKXhgtRzzdhQmzTchV2Gy8o+kkdHC28IQpHbi4eZKziqzLjnwGltUmmokVudj1A
         S7eZLYHfDozs0UGvrwM2M9kch9Rg/gva0UKmBoMy9dcprtfhuwroHRIIzA7g5l0BWIIm
         FWvz121/a3OxGFp8wdPoOOGQU5FsQiY509TzU1V7O6oNae2Mq5jDpYhjBOdW3MP5IYu3
         zIRg==
X-Gm-Message-State: AElRT7HG7o48+KhHV7Weco2mM3Q5EXozmbwLkorEbIZgoPMLPmqfgPG7
        ULo6pkzKM4VigB+ZPbK4rcBDYg==
X-Google-Smtp-Source: AIpwx4/zclDirNQGQlfrSN8KZyHRHhCN6p3udlaVrL16sRYZ8+SkIbp18LCDrP33O1OquHxLqHbSzw==
X-Received: by 2002:a19:7904:: with SMTP id u4-v6mr102608lfc.129.1522171828354;
        Tue, 27 Mar 2018 10:30:28 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c74-v6sm315194lfe.96.2018.03.27.10.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Mar 2018 10:30:27 -0700 (PDT)
Date:   Tue, 27 Mar 2018 19:30:24 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git complains packed-refs is not a directory when used with
 GIT_DIR and GIT_WORK_TREE envvars.
Message-ID: <20180327173024.GA5017@duynguyen.home>
References: <CACUQV5_3Pw+vnyyNUL4oE4tMLG_wKVdqdVk01rg4V92ufUYHHA@mail.gmail.com>
 <20180327063137.GA24044@sigill.intra.peff.net>
 <CACsJy8DP53Og1crS1bLoJf6w8cJhjGKy=ggfbsqzJ6AU4eNhPA@mail.gmail.com>
 <20180327164757.GB24747@sigill.intra.peff.net>
 <CACsJy8Bog6U7X-jvzDhq14heQWx0HA_21HsSYR0nykU9aDsCYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8Bog6U7X-jvzDhq14heQWx0HA_21HsSYR0nykU9aDsCYQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 07:09:36PM +0200, Duy Nguyen wrote:
> I would rather have something like ref_store_reinit() in the same
> spirit as the second call of set_git_dir() in setup_work_tree. It is
> hacky, but it works and keeps changes to minimal (so that it could be
> easily replaced later).

So in the name of hacky and dirty things, it would look something like
this. This passed your test case. The test suite is still running
(slow laptop) but I don't expect breakages there.

-- 8< --
diff --git a/refs.c b/refs.c
index 20ba82b434..c6116c4f7a 100644
--- a/refs.c
+++ b/refs.c
@@ -1660,6 +1660,16 @@ struct ref_store *get_main_ref_store(void)
 	return main_ref_store;
 }
 
+void make_main_ref_store_use_absolute_paths(void)
+{
+	files_force_absolute_paths(get_main_ref_store());
+}
+
+void make_main_ref_store_use_relative_paths(const char *cwd)
+{
+	files_make_relative_paths(get_main_ref_store(), cwd);
+}
+
 /*
  * Associate a ref store with a name. It is a fatal error to call this
  * function twice for the same name.
diff --git a/refs.h b/refs.h
index 01be5ae32f..532a4ad09d 100644
--- a/refs.h
+++ b/refs.h
@@ -759,6 +759,9 @@ int reflog_expire(const char *refname, const struct object_id *oid,
 int ref_storage_backend_exists(const char *name);
 
 struct ref_store *get_main_ref_store(void);
+void make_main_ref_store_use_absolute_paths(void);
+void make_main_ref_store_use_relative_paths(const char *cwd);
+
 /*
  * Return the ref_store instance for the specified submodule. For the
  * main repository, use submodule==NULL; such a call cannot fail. For
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bec8e30e9e..629198826f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3092,6 +3092,32 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	return -1;
 }
 
+void files_force_absolute_paths(struct ref_store *ref_store)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_WRITE, "don't ask");
+
+	char *path = refs->gitdir;
+	refs->gitdir = absolute_pathdup(path);
+	free(path);
+
+	path = refs->gitcommondir;
+	refs->gitcommondir = absolute_pathdup(path);
+	free(path);
+}
+
+void files_make_relative_paths(struct ref_store *ref_store, const char *cwd)
+{
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_WRITE, "don't ask");
+
+	const char *path = remove_leading_path(refs->gitdir, cwd);
+	refs->gitdir = absolute_pathdup(path);
+
+	path = remove_leading_path(refs->gitcommondir, cwd);
+	refs->gitcommondir = absolute_pathdup(path);
+}
+
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
 	struct files_ref_store *refs =
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dd834314bd..827e97bcca 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -669,4 +669,7 @@ struct ref_store {
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be);
 
+void files_force_absolute_paths(struct ref_store *refs);
+void files_make_relative_paths(struct ref_store *refs, const char *cwd);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/setup.c b/setup.c
index 7287779642..a5f4396b4e 100644
--- a/setup.c
+++ b/setup.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "dir.h"
 #include "string-list.h"
+#include "refs.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
@@ -389,8 +390,10 @@ void setup_work_tree(void)
 
 	work_tree = get_git_work_tree();
 	git_dir = get_git_dir();
-	if (!is_absolute_path(git_dir))
+	if (!is_absolute_path(git_dir)) {
 		git_dir = real_path(get_git_dir());
+		make_main_ref_store_use_absolute_paths();
+	}
 	if (!work_tree || chdir(work_tree))
 		die(_("this operation must be run in a work tree"));
 
@@ -402,6 +405,7 @@ void setup_work_tree(void)
 		setenv(GIT_WORK_TREE_ENVIRONMENT, ".", 1);
 
 	set_git_dir(remove_leading_path(git_dir, work_tree));
+	make_main_ref_store_use_relative_paths(work_tree);
 	initialized = 1;
 }
 
-- 8< --
