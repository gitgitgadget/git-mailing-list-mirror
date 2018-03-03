Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11671F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeCCLhC (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:37:02 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46015 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeCCLhB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:37:01 -0500
Received: by mail-pf0-f194.google.com with SMTP id h19so4255562pfd.12
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qENhMJaxQ0vyS5allNVDucI748NFmgEtuTqzFt8q3Q=;
        b=SA47y8usjFVnwIr5y1UEPCKl9n8CHjB6UslTHc4/xMgVRkTcOyEORPQBjClpDPsZv+
         xOngH15KcPcKgo6mrveIkMu7Ms3sYxRiDO0lXAwv1gbNZBQWeS5Wy9tgSxAOiuclgJCG
         fop+1AJd6EDmnRlEvBPd53hTSJ5+x6N9jo3XXMo4nb6Kv+sGZL8iwfeyM3uvhk/1TZET
         feTHsZQjrbWkdsR53tOESH1JuLzhbKKGLRh61dfwAJotOjafPOOeJ+Z/HQ0uvujhi2/s
         WOEMVb1jmWeDFgdQli7nJHtdEH5qvDzmj2RWB7NgO2JdtJ4Ajsz+WipzZ9SgFkE4BS4r
         z9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qENhMJaxQ0vyS5allNVDucI748NFmgEtuTqzFt8q3Q=;
        b=tJnevQ+SjAwDm3wEQbKZo7VO3vI8OeMrLQMFoyZr/AUjDG7+5A0iqFoYBIOE1o8sBI
         bOlJ+WnXu3Dcx6A1JImgxdMfbqs1L3MljdIa0wnRW8QrZrbQWoUb8plzOZ5Sdg/EnUNf
         A0YckfzG4hrCoas+p4etdYH79NgdMBj1aMQ9H+A8bqa3E7+t+r4sM2D6tPWmzVBRAxaK
         L9q7b50/cDyH5AfLwiT+9kNfSOpUTPp3z3fzlnmXR0a7VxVDnZfXATtuWzlIjJLaDCdB
         CZpFKWh7fDxw8KjO37Jv+oo3+KAIdfF134CdrHizAvbNW+pvNwMgyv4wvJxafGfjyaV3
         YBlw==
X-Gm-Message-State: APf1xPAKxR/iy84tIKcYoDhntDU9pYQ0bpslcB5zRiWrTWLCpp0g0sX3
        G5MG0rV8+32Li9NhKUnJgSEy9Q==
X-Google-Smtp-Source: AG47ELt6INWW2xc6pl+qVrPGupP5R+dr1nO5OOUq4HBvpGLx/vmXjBby/fjPmlcAnec0KFL00OXkVw==
X-Received: by 10.98.11.19 with SMTP id t19mr8844983pfi.70.1520077020699;
        Sat, 03 Mar 2018 03:37:00 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id e5sm12811223pgs.17.2018.03.03.03.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:37:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:36:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/44] repository.c: delete dead functions
Date:   Sat,  3 Mar 2018 18:35:56 +0700
Message-Id: <20180303113637.26518-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 repository.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/repository.c b/repository.c
index bb53b54b6d..e65f4138a7 100644
--- a/repository.c
+++ b/repository.c
@@ -15,31 +15,6 @@ void initialize_the_repository(void)
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
 
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
 static void expand_base_dir(char **out, const char *in,
 			    const char *base_dir, const char *def_in)
 {
-- 
2.16.1.435.g8f24da2e1a

