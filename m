Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 101281F576
	for <e@80x24.org>; Tue, 27 Feb 2018 09:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeB0J7M (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 04:59:12 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34611 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbeB0J7G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 04:59:06 -0500
Received: by mail-pf0-f195.google.com with SMTP id j20so4315225pfi.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ha0+AV2C37zXkQh5Hcj7zkDlZyl9HLQFQt6CBwTeRLE=;
        b=JvMDB82FNrmWawBRrZFX8fNkkaOSlZANoVf4O4U/s8fLsX8oKl9/dyZkASQ1vI+KAO
         UTdxJD5zIrC1cWZYccrnIK5uASB1Nw0kQxZ2+TYylgRGT1dkeuRiCgB58bYyqwuVf0SN
         M5hfmbbDDOjpAFGp8se9KLUc21gW9McYAXxPjZpyYNGNK1RiZbizVnMhzTtdpiSLUNqT
         kpX5RseM60mxPCblUdraBm9iNYJ/UpOru0FXFwOMSLf5dRyBoRixL1e1owdXaxJmZ1DP
         0J3AW4e972FPT4IzkCyYizBOYVXjYLp22KMXI7Rv8dTzCm13Xd8Vxqlun5hUJCFtrh/T
         TuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ha0+AV2C37zXkQh5Hcj7zkDlZyl9HLQFQt6CBwTeRLE=;
        b=LnUrt8UdzFOODFWNCvyv09qiLRB5JY6rTpba/6Mi5AdEfafDDvsX3GwQHXKjCtrwpc
         xoxolJz/+HDMRPtf0dCcVBdFDOaMce1L00SndFp5bnH+Nu8p6N0/NoaRHACqcxXGcX9Y
         D6BPS8d9CCsXRIpY6N0Oe6nipy+5F+1r79Ryp6V6uEI8TKlWbzFwXPOah3ztNp1cAObH
         EJD/m7caelHI3+PsN/B7C+aqxhXkncCrPNzXFOFS9gx+VjAciGcqreMnkelJs4wCYPyt
         3MsuLpm49iQGBwhcBeNYTQo1aWQBu6rwiU9dRJ0mjCs7uSKb6lE1H2aWPfzwsGpf3/dY
         31eg==
X-Gm-Message-State: APf1xPDghAASZnDBS7CnB9UTyshE4JuNY64RQAy2XuwGLwMMUBXU80sk
        AzmravHi7F/380/7Aw23G+E=
X-Google-Smtp-Source: AG47ELu8OWGeRBTOorTS9B5M4cCORpUHLzFUy7CsUsAICdHJyclu8pSViI32ELZhcOynD/Y1tTP3BA==
X-Received: by 10.98.67.216 with SMTP id l85mr6118680pfi.214.1519725546022;
        Tue, 27 Feb 2018 01:59:06 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id e22sm17444683pgn.50.2018.02.27.01.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 01:59:05 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 27 Feb 2018 16:58:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH v2 2/4] repository.c: delete dead functions
Date:   Tue, 27 Feb 2018 16:58:44 +0700
Message-Id: <20180227095846.9238-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180227095846.9238-1-pclouds@gmail.com>
References: <20180226103030.26900-1-pclouds@gmail.com>
 <20180227095846.9238-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 repository.c | 45 ---------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/repository.c b/repository.c
index 343efe7282..7654b8ada9 100644
--- a/repository.c
+++ b/repository.c
@@ -16,51 +16,6 @@ static struct repository the_repo = {
 };
 struct repository *the_repository = &the_repo;
 
-static char *git_path_from_env(const char *envvar, const char *git_dir,
-			       const char *path, int fromenv)
-{
-	if (fromenv) {
-		const char *value = getenv(envvar);
-		if (value)
-			return xstrdup(value);
-	}
-
-	return xstrfmt("%s/%s", git_dir, path);
-}
-
-static int find_common_dir(struct strbuf *sb, const char *gitdir, int fromenv)
-{
-	if (fromenv) {
-		const char *value = getenv(GIT_COMMON_DIR_ENVIRONMENT);
-		if (value) {
-			strbuf_addstr(sb, value);
-			return 1;
-		}
-	}
-
-	return get_common_dir_noenv(sb, gitdir);
-}
-
-static void repo_setup_env(struct repository *repo)
-{
-	struct strbuf sb = STRBUF_INIT;
-
-	repo->different_commondir = find_common_dir(&sb, repo->gitdir,
-						    !repo->ignore_env);
-	free(repo->commondir);
-	repo->commondir = strbuf_detach(&sb, NULL);
-	raw_object_store_clear(&repo->objects);
-	repo->objects.objectdir =
-		git_path_from_env(DB_ENVIRONMENT, repo->commondir,
-				  "objects", !repo->ignore_env);
-	free(repo->graft_file);
-	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
-					     "info/grafts", !repo->ignore_env);
-	free(repo->index_file);
-	repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
-					     "index", !repo->ignore_env);
-}
-
 static void expand_base_dir(char **out, const char *in,
 			    const char *base_dir, const char *def_in)
 {
-- 
2.16.1.435.g8f24da2e1a

