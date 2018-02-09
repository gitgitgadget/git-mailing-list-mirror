Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412791F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeBILDK (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:03:10 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44079 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbeBILDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:03:09 -0500
Received: by mail-pl0-f68.google.com with SMTP id f8so1308246plk.11
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3w6E07NZ94bdK7YrbbjkCD93JKXZEiInxV45rY08VF8=;
        b=RctAgsQNKYeUD95FhkrlbPYl0+DDtasjDYoF5WesHmr/hTeJIfyu9TREyBxQdAiULS
         hRIiOJaPlakcNE4r4XXrdA3VXJ21h9cxPYqVyM+3J61MBPh4JMuWWfZCK1scH3+Bhrpi
         IBKNJS1LX1pcw9CMy4ADWHIQqzZ1ArnxYI96dm6rR7ffZklBgecuV5P6YsKCyGJAHvWI
         qWam+49o2kut0L78lfJaGj+vcYq6HoiHUZc/DFk8mKRiworyHAvdUuHyyQmP6lORP+HD
         CYcwRHMQTXlj4phD57OIngsENzCRrZZTTAL6AvaZrkBH+4QHcKS7GMYiIU5O5gLs5Jbh
         PW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3w6E07NZ94bdK7YrbbjkCD93JKXZEiInxV45rY08VF8=;
        b=VLEfEMV8/HHEcDajsNdf+ZG+SSqNUV54+15hPn8bCrQrAnbOHhZPxoOPSj3ekWmpsT
         Yf+DowfS8XSP+cPmsSjNkvy7iF6vEtj5dlbnwI4qiUE0gzbO0Ag6ZTjMsH6q1q0NvKEv
         PD5Mwx5WBrodRZ8Z9JJ0COfbtUnvhl88wV5uh84GRmE7RQx3yl8GVYZB2ppPaiLcKTbK
         7VCTRE6Vl31nAvpSYu3Ky5DoN2D4e4aSKSiW8O425zYu9l8zmK/M3OMx21PIEBsTgABW
         HePpAqZNen34ca+mTiFKZnTdCkvsk9Or9I9FJL81hEs0PLmQKIOlox6JmK5peKLsnjsR
         szfw==
X-Gm-Message-State: APf1xPAgLyjzM8XgdtuPbpgUJPORVa+dIzzZroDaT2LqtQzJuUkhvtqI
        OsnEtWjJf7wfZ7iRow8EGTvZmA==
X-Google-Smtp-Source: AH8x227L+x29Kn2dxUOHVWAE9+ObHMsvYJLwWTI8KoISg7JtczN/SplSx9qoE+WoMo6Y8HmXMz4jIA==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37-v6mr2284333pla.186.1518174188714;
        Fri, 09 Feb 2018 03:03:08 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id e18sm4267555pgr.3.2018.02.09.03.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:03:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:03:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 06/42] completion: use __gitcomp_builtin in _git_am
Date:   Fri,  9 Feb 2018 18:01:45 +0700
Message-Id: <20180209110221.27224-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--directory
--exclude
--gpg-sign
--include
--keep-cr
--keep-non-patch
--message-id
--no-keep-cr
--patch-format
--quiet
--reject
--resolvemsg=

In-progress options like --continue will be part of --git-completion-helper
then filtered out by _git_am() unless the operation is in progress. This
helps keep marking of these operations in just one place.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 11 ++++-------
 parse-options.h                        |  4 ++--
 rerere.h                               |  3 ++-
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1e0bd835fe..eba482eb9c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1105,12 +1105,13 @@ __git_count_arguments ()
 }
 
 __git_whitespacelist="nowarn warn error error-all fix"
+__git_am_inprogress_options="--skip --continue --resolved --abort"
 
 _git_am ()
 {
 	__git_find_repo_path
 	if [ -d "$__git_repo_path"/rebase-apply ]; then
-		__gitcomp "--skip --continue --resolved --abort"
+		__gitcomp "$__git_am_inprogress_options"
 		return
 	fi
 	case "$cur" in
@@ -1119,12 +1120,8 @@ _git_am ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--3way --committer-date-is-author-date --ignore-date
-			--ignore-whitespace --ignore-space-change
-			--interactive --keep --no-utf8 --signoff --utf8
-			--whitespace= --scissors
-			"
+		__gitcomp_builtin am "--no-utf8" \
+			"$__git_am_inprogress_options"
 		return
 	esac
 }
diff --git a/parse-options.h b/parse-options.h
index 3c32401736..009cd863e5 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -144,8 +144,8 @@ struct option {
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
 				      (h), 0, &parse_opt_string_list }
-#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
+#define OPT_UYN(s, l, v, h, f)      { OPTION_CALLBACK, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG|(f), &parse_opt_tertiary }
 #define OPT_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,	\
 	  parse_opt_approxidate_cb }
diff --git a/rerere.h b/rerere.h
index c2961feaaa..5e5a312e4c 100644
--- a/rerere.h
+++ b/rerere.h
@@ -37,6 +37,7 @@ extern void rerere_clear(struct string_list *);
 extern void rerere_gc(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
-	N_("update the index with reused conflict resolution if possible"))
+	N_("update the index with reused conflict resolution if possible"), \
+	PARSE_OPT_NOCOMPLETE)
 
 #endif
-- 
2.16.1.207.gedba492059

