Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB4920248
	for <e@80x24.org>; Sat, 30 Mar 2019 11:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfC3LUx (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 07:20:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40365 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbfC3LUx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 07:20:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id b11so2213807plr.7
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLHFfdnN0jx4Qdk7kWZsPEECXBZdnTGBSUUpleGoRQ8=;
        b=I+sTZ4120m27/Cp8RO1DlGTGfiU15SuOJO+4Pg4elb30OyVosZ2jKF6s0yRIpXKBhA
         9cSdAMPzqsB5p/cJBSCudCO7NKoBJ2RGuZ3UYWbHJjSLDjG9Kz2fVQqC/3FrQFkqQg8E
         BqPAdPtQHQpKyAfQihOgRyPs3PKY9qAI9aubIqQa2QG+GQIzURV+LfDXQw6ozwFmCTDP
         XIXrD2nDBTzDGDPz9f5ZOGLqKx2qnB0u+0q8cC/TcHYZj/Fr1H888bUiGbRiLRBTay3b
         gUCFgbxpvNfb3upg1YT3w944gnqFX8sVJ34ZMTRKBnApUpn64jBm0sFIg5GorJ+oblWV
         CYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLHFfdnN0jx4Qdk7kWZsPEECXBZdnTGBSUUpleGoRQ8=;
        b=Ay2lGFzqBIxBN4ZWEAkKLoBtbXVTP8zAgokTj9TdXHQ4QVo5+wv9UzU+QpO6ih8KcR
         UPkRLoF8SGr0qC9RWOr5b2N7HjJ8Nl8eqkKnlfU+3CyHFWWxq6iJvihDfpF3dSwtdFO+
         51sxLv9UfQ6SjbXc1ov6kOm/1GTbvm3zM3CQjDEIEUpUzEYcII2vRvem2K6tBmukByGo
         +0vEj0RZZaW4cryTXADx4nxjaebKnRJ3tPZhWe6qsBa3TOnJuYVIiK5Bi/r39ttAFwHx
         T9ozLT3k7LPJIFtvciYjkzWY12dISnJvoRXbWx+r9mVRSzsCNsOnwn2XEsdka4l2tIUT
         pCiw==
X-Gm-Message-State: APjAAAW7CJvPWvEWogIheozSfPRpU/O37iupJyzne1Zw18svWyDLvYdv
        fYc6n0uC0qtEg045xQk3s+dUyVMn
X-Google-Smtp-Source: APXvYqxaBaWtVz6y8Wph1mgK9v4BBC0ixfOdrBAE9iLdbHeDGBrxev/tM50HHKcdLUYmse65BiDz9A==
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr55159750plb.22.1553944852822;
        Sat, 30 Mar 2019 04:20:52 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id p3sm9599302pfn.167.2019.03.30.04.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:20:52 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 30 Mar 2019 18:20:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/31] refs.c: remove the_repo from expand_ref()
Date:   Sat, 30 Mar 2019 18:19:01 +0700
Message-Id: <20190330111927.18645-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c        | 10 ++++++----
 refs.h        |  2 +-
 upload-pack.c |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 44df049796..1f5864aa36 100644
--- a/refs.c
+++ b/refs.c
@@ -558,12 +558,13 @@ static char *substitute_branch_name(struct repository *r,
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
 {
 	char *last_branch = substitute_branch_name(the_repository, &str, &len);
-	int   refs_found  = expand_ref(str, len, oid, ref);
+	int   refs_found  = expand_ref(the_repository, str, len, oid, ref);
 	free(last_branch);
 	return refs_found;
 }
 
-int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
+int expand_ref(struct repository *repo, const char *str, int len,
+	       struct object_id *oid, char **ref)
 {
 	const char **p, *r;
 	int refs_found = 0;
@@ -578,8 +579,9 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
-		r = resolve_ref_unsafe(fullref.buf, RESOLVE_REF_READING,
-				       this_result, &flag);
+		r = refs_resolve_ref_unsafe(get_main_ref_store(repo),
+					    fullref.buf, RESOLVE_REF_READING,
+					    this_result, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
diff --git a/refs.h b/refs.h
index 5627570241..b630d5bde7 100644
--- a/refs.h
+++ b/refs.h
@@ -148,7 +148,7 @@ int refname_match(const char *abbrev_name, const char *full_name);
 struct argv_array;
 void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
 
-int expand_ref(const char *str, int len, struct object_id *oid, char **ref);
+int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
diff --git a/upload-pack.c b/upload-pack.c
index d098ef5982..56505d60c3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -834,7 +834,7 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	if (skip_prefix(line, "deepen-not ", &arg)) {
 		char *ref = NULL;
 		struct object_id oid;
-		if (expand_ref(arg, strlen(arg), &oid, &ref) != 1)
+		if (expand_ref(the_repository, arg, strlen(arg), &oid, &ref) != 1)
 			die("git upload-pack: ambiguous deepen-not: %s", line);
 		string_list_append(deepen_not, ref);
 		free(ref);
-- 
2.21.0.479.g47ac719cd3

