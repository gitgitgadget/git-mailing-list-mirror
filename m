Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE20C1F576
	for <e@80x24.org>; Sun,  4 Feb 2018 09:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeBDJig (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 04:38:36 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34825 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeBDJid (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 04:38:33 -0500
Received: by mail-pl0-f67.google.com with SMTP id j19so9705775pll.2
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 01:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCJEmX+B8AVS+Avz1lUCBv/PczikqEVTGgTQgwWDLAw=;
        b=mlqp4V1y8VbSv+9sc7oDx/bbiSCannHtVvfds2uuIFUAa/GYGtrITbnQwtv0SIjl8H
         uoXXqYMN+qBaxSOe+phtq9pdFf9fvbUvue9PWr4HiCGNxUDGw6EmQNy0ESRShIbQ4Waz
         DkqtMvzv/0PGTLF10Q/SslpPoYjhxuFGDU7/Hv0PNWoWfoNH15r4aMzkAx2hmKCqvUG3
         rZBEIq6fcc/AfHNZ3PMThX/W2IMwEK4cdnzxFvWzvXqXMk9qMkNeX72HTPaiYmdS8+M3
         92TCOOfgRVGarrGD8IGzklCcxJSFlSdgI7E0nd/b1jBuI1xbj/4BNE9oqep7XWDh5JoA
         MfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCJEmX+B8AVS+Avz1lUCBv/PczikqEVTGgTQgwWDLAw=;
        b=fKtNDPT1a1L2mtVgbYjGrZctd96ja+NeajdmSwM7GBJzNQjsZjOSpBxZ4hMS5W4Xyw
         kUDFyGBy5IAIJ/Svj2ZQMKFVqXfRcEnyAsP/nK9Ah3990/X6PEYkVs8vEGIH7xejIvhR
         APhzH9O66g/RiULMm76G91rlzT3Fpt7FQRXyOGbJUPnabGdWa/3wnjBtvbGRXKMlD+Iz
         8nLdy0mES4PJ584NRxvOq9YICjOfDkyNJ83TlHdp1BG0ecSmdw4AUKstl5UnSpCt9aED
         0GVCc6C20fjqhH3ekwIQLV2LdBAsXWssZYS6vxB81C+/3L0dFh22+UjG57mqt+aV3hVy
         s47w==
X-Gm-Message-State: AKwxyteYtOj++cLnsZFY2bmoysXU6z+LnLU6xTUN7X095mMaVIyAC/bv
        1/AgNV9jo7XpsNCRN5CgSaQ=
X-Google-Smtp-Source: AH8x2243RfpoyIS2BFrEAE0XwNXbGtsf9y+FIc5HpHFjyimVLc+V02PoYICg3a8phWCb29WmKyZ9Vg==
X-Received: by 2002:a17:902:8c91:: with SMTP id t17-v6mr13064825plo.310.1517737112484;
        Sun, 04 Feb 2018 01:38:32 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id o7sm8690471pgp.18.2018.02.04.01.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Feb 2018 01:38:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 04 Feb 2018 16:38:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] dir.c: ignore paths containing .git when invalidating untracked cache
Date:   Sun,  4 Feb 2018 16:38:23 +0700
Message-Id: <20180204093823.3671-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <CACsJy8DH2_gBqj3xs4Cr6kOAUsQ5hn88weMeXR8GtYCNvYgLDQ@mail.gmail.com>
References: <CACsJy8DH2_gBqj3xs4Cr6kOAUsQ5hn88weMeXR8GtYCNvYgLDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_directory() code ignores all paths named ".git" even if it's not
a valid git repository. See treat_path() for details. Since ".git" is
basically invisible to read_directory(), when we are asked to
invalidate a path that contains ".git", we can safely ignore it
because the slow path would not consider it anyway.

This helps when fsmonitor is used and we have a real ".git" repo at
worktree top. Occasionally .git/index will be updated and if the
fsmonitor hook does not filter it, untracked cache is asked to
invalidate the path ".git/index".

Without this patch, we invalidate the root directory unncessarily,
which:

- makes read_directory() fall back to slow path for root directory
  (slower)

- makes the index dirty (because UNTR extension is updated). Depending
  on the index size, writing it down could also be slow.

Noticed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Sorry for the resend, I forgot git@vger.

 dir.c             | 13 ++++++++++++-
 git-compat-util.h |  2 ++
 wrapper.c         | 12 ++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 7c4b45e30e..f8b4cabba9 100644
--- a/dir.c
+++ b/dir.c
@@ -1773,7 +1773,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 	if (!de)
 		return treat_path_fast(dir, untracked, cdir, istate, path,
 				       baselen, pathspec);
-	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
+	if (is_dot_or_dotdot(de->d_name) || !fspathcmp(de->d_name, ".git"))
 		return path_none;
 	strbuf_setlen(path, baselen);
 	strbuf_addstr(path, de->d_name);
@@ -2970,8 +2970,19 @@ static int invalidate_one_component(struct untracked_cache *uc,
 void untracked_cache_invalidate_path(struct index_state *istate,
 				     const char *path)
 {
+	const char *end;
+	int skipped;
+
 	if (!istate->untracked || !istate->untracked->root)
 		return;
+	if (!fspathcmp(path, ".git"))
+		return;
+	if (ignore_case)
+		skipped = skip_caseprefix(path, "/.git", &end);
+	else
+		skipped = skip_prefix(path, "/.git", &end);
+	if (skipped && (*end == '\0' || *end == '/'))
+		return;
 	invalidate_one_component(istate->untracked, istate->untracked->root,
 				 path, strlen(path));
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index 68b2ad531e..27e0b761a3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -484,6 +484,8 @@ static inline int skip_prefix(const char *str, const char *prefix,
 	return 0;
 }
 
+int skip_caseprefix(const char *str, const char *prefix, const char **out);
+
 /*
  * If the string "str" is the same as the string in "prefix", then the "arg"
  * parameter is set to the "def" parameter and 1 is returned.
diff --git a/wrapper.c b/wrapper.c
index d20356a776..bb888d9401 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -690,3 +690,15 @@ int xgethostname(char *buf, size_t len)
 		buf[len - 1] = 0;
 	return ret;
 }
+
+int skip_caseprefix(const char *str, const char *prefix, const char **out)
+{
+	do {
+		if (!*prefix) {
+			*out = str;
+			return 1;
+		}
+	} while (tolower(*str++) == tolower(*prefix++));
+
+	return 0;
+}
-- 
2.16.1.207.gedba492059

