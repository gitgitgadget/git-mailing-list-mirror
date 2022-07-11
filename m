Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840EEC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 05:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiGKFA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 01:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGKFA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 01:00:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBDC15FDB
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 22:00:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so4348797wme.0
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 22:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8wAs4dxFC664S7ca9XuFinSLf84dtjjY5LcMKKuJIKM=;
        b=F2+MEMbC4LhA0LI6tAXhv90CJs6gLUVXph9BpsdnQQtFWi3jNUikJ81lZV7ag3+aq+
         E664m6gRHV+6gW6/Y3fIpw7YfM5g2Svolq7vwkqvwN6Q98br5FQP4/2CE/qWtMTc/rUd
         LPxCvJn8+WOCrHW6z7+1fF2AoXD0nFp46rdJTNnZ2kDVnIqeGBLoeQzL+1NYzvS/9gh2
         RVMJlsjYYDajHTQ0ZDuTyTJM0vEs+oPRyCiGmg/cyY6He3eUDcwxgR1zKhBSu3QUJGw6
         T8v+43bQ0FP1VYnLMuoLtEN3Gfq3nfotK7IU+Qo3CZMmgCnA9x/zGgP70J11cIkdboC4
         h3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8wAs4dxFC664S7ca9XuFinSLf84dtjjY5LcMKKuJIKM=;
        b=e81ednYWIlCT5ucfkzBgs98i8i1nlOcYVvq6PoZTEofsJ1ErM3MTe41MajgOxuAhIK
         khIkftGbJld1D3KqoJcnPyP9jEHKdLQFtJIqTGQHJAYwKMPZYekOjuwDZoBi2lHQti/S
         SWYuNPj1pkO/lU/RiR2dIGjxoqHVtcC8v51TW40bGBHwXWd1q6OEqUNJhIDXBC9FKg4r
         gH5rBjrAL4B2nbvdJHjDUT0eMXB9yfQiO3eh3foGgn1lVL8al2hHoVDqDp7c/zkslb5D
         nc1AejTssqwq/fFU+lmdDLUrqzt4OOzo4KwS8daMnnWc6x8Un4bvHsTGq4TePPai5AWE
         w7BA==
X-Gm-Message-State: AJIora8WzEktDWdNbRKZVCjTszU84MqTE3y0JRvXZUL3B+yRvTQaFBPQ
        g6FmngW1oEIrAN4aYgpCL27dhmhntKY=
X-Google-Smtp-Source: AGRyM1sxb1ahPBab4eUnI5s13be94JNiAb7P4dWZ0iz3IikA4F8sYFlDOoimO0VE/WbnlfNoMu0yRA==
X-Received: by 2002:a05:600c:4f95:b0:3a1:7310:62d8 with SMTP id n21-20020a05600c4f9500b003a1731062d8mr13544529wmq.16.1657515651782;
        Sun, 10 Jul 2022 22:00:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h26-20020adfa4da000000b0021b966abc19sm4861241wrb.19.2022.07.10.22.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 22:00:51 -0700 (PDT)
Message-Id: <pull.1281.v4.git.1657515650587.gitgitgadget@gmail.com>
In-Reply-To: <pull.1281.v3.git.1657341817595.gitgitgadget@gmail.com>
References: <pull.1281.v3.git.1657341817595.gitgitgadget@gmail.com>
From:   "Jaydeep Das via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Jul 2022 05:00:50 +0000
Subject: [PATCH v4] gpg-interface: add function for converting trust level to
 string
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jaydeep Das <jaydeepjd.8914@gmail.com>

Add new helper function `gpg_trust_level_to_str()` which will
convert a given member of `enum signature_trust_level` to its
corresponding string (in lowercase). For example, `TRUST_ULTIMATE`
will yield the string "ultimate".

This will abstract out some code in `pretty.c` relating to gpg
signature trust levels.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
---
    gpg-interface: add function for converting trust level to string
    
    Add new helper function gpg_trust_level_to_str() which will convert a
    given member of enum signature_trust_level to its corresponding string
    in lowercase. For example, TRUST_ULTIMATE will yield the string
    "ultimate".
    
    This will abstract out some code in pretty.c relating to gpg signature
    trust levels.
    
    Changes since v1:
    
     * gpg_trust_level_to_str() now returns the string in lowercase.
    
    Changes since v2:
    
     * Updated docs.
    
    Changes since v3:
    
     * gpg_trust_level_to_str() now returns a static string. So the caller
       does not have to worry about free()ing it.
     * Updated pretty.c and docs accordingly.
    
    Mentored-by: Christian Couder chriscool@tuxfamily.org Mentored-by:
    Hariom Verma hariom18599@gmail.com Signed-off-by: Jaydeep Das
    jaydeepjd.8914@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1281%2FJDeepD%2Fgpg-wrap-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1281/JDeepD/gpg-wrap-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1281

Range-diff vs v3:

 1:  933d6caa916 ! 1:  7692b83821d gpg-interface: add function for converting trust level to string
     @@ gpg-interface.c: static struct {
       	{ 0, "TRUST_", GPG_STATUS_TRUST_LEVEL },
       };
       
     +-static struct {
      +/* Keep the order same as enum signature_trust_level */
     - static struct {
     ++static struct sigcheck_gpg_trust_level {
       	const char *key;
     ++	const char *display_key;
       	enum signature_trust_level value;
     + } sigcheck_gpg_trust_level[] = {
     +-	{ "UNDEFINED", TRUST_UNDEFINED },
     +-	{ "NEVER", TRUST_NEVER },
     +-	{ "MARGINAL", TRUST_MARGINAL },
     +-	{ "FULLY", TRUST_FULLY },
     +-	{ "ULTIMATE", TRUST_ULTIMATE },
     ++	{ "UNDEFINED", "undefined", TRUST_UNDEFINED },
     ++	{ "NEVER", "never", TRUST_NEVER },
     ++	{ "MARGINAL", "marginal", TRUST_MARGINAL },
     ++	{ "FULLY", "fully", TRUST_FULLY },
     ++	{ "ULTIMATE", "ultimate", TRUST_ULTIMATE },
     + };
     + 
     + static void replace_cstring(char **field, const char *line, const char *next)
      @@ gpg-interface.c: const char *get_signing_key(void)
       	return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
       }
       
     -+char *gpg_trust_level_to_str(enum signature_trust_level level){
     -+	if (level < TRUST_UNDEFINED || level > TRUST_ULTIMATE)
     -+		return NULL;
     -+	return xstrdup_tolower(sigcheck_gpg_trust_level[level].key);
     ++const char *gpg_trust_level_to_str(enum signature_trust_level level)
     ++{
     ++	struct sigcheck_gpg_trust_level *trust;
     ++
     ++	if (level < 0 || level >= ARRAY_SIZE(sigcheck_gpg_trust_level))
     ++		BUG("invalid trust level requested %d", level);
     ++
     ++	trust = &sigcheck_gpg_trust_level[level];
     ++	if (trust->value != level)
     ++		BUG("sigcheck_gpg_trust_level[] unsorted");
     ++
     ++	return sigcheck_gpg_trust_level[level].display_key;
      +}
      +
       int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
     @@ gpg-interface.h: size_t parse_signed_buffer(const char *buf, size_t size);
      +/*
      + * Returns corresponding string in lowercase for a given member of
      + * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
     -+ * return "ultimate". Since it uses xstrdup_tolower(), which uses
     -+ * xmallocz(), the caller has to free up the memory for returned string
     -+ * after usage.
     ++ * return "ultimate".
      + */
     -+char *gpg_trust_level_to_str(enum signature_trust_level level);
     ++const char *gpg_trust_level_to_str(enum signature_trust_level level);
      +
       int git_gpg_config(const char *, const char *, void *);
       void set_signing_key(const char *);
       const char *get_signing_key(void);
      
       ## pretty.c ##
     -@@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
     - 	const char *msg = c->message;
     - 	struct commit_list *p;
     - 	const char *arg, *eol;
     -+	char *sig_str;
     - 	size_t res;
     - 	char **slot;
     - 
      @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
       				strbuf_addstr(sb, c->signature_check.primary_key_fingerprint);
       			break;
     @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
      -				strbuf_addstr(sb, "ultimate");
      -				break;
      -			}
     -+			sig_str = gpg_trust_level_to_str(c->signature_check.trust_level);
     -+			if (sig_str)
     -+				strbuf_addstr(sb, sig_str);
     -+			free(sig_str);
     ++			strbuf_addstr(sb, gpg_trust_level_to_str(c->signature_check.trust_level));
       			break;
       		default:
       			return 0;


 gpg-interface.c | 28 ++++++++++++++++++++++------
 gpg-interface.h |  8 ++++++++
 pretty.c        | 18 +-----------------
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 947b58ad4da..6dff2414603 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -165,15 +165,17 @@ static struct {
 	{ 0, "TRUST_", GPG_STATUS_TRUST_LEVEL },
 };
 
-static struct {
+/* Keep the order same as enum signature_trust_level */
+static struct sigcheck_gpg_trust_level {
 	const char *key;
+	const char *display_key;
 	enum signature_trust_level value;
 } sigcheck_gpg_trust_level[] = {
-	{ "UNDEFINED", TRUST_UNDEFINED },
-	{ "NEVER", TRUST_NEVER },
-	{ "MARGINAL", TRUST_MARGINAL },
-	{ "FULLY", TRUST_FULLY },
-	{ "ULTIMATE", TRUST_ULTIMATE },
+	{ "UNDEFINED", "undefined", TRUST_UNDEFINED },
+	{ "NEVER", "never", TRUST_NEVER },
+	{ "MARGINAL", "marginal", TRUST_MARGINAL },
+	{ "FULLY", "fully", TRUST_FULLY },
+	{ "ULTIMATE", "ultimate", TRUST_ULTIMATE },
 };
 
 static void replace_cstring(char **field, const char *line, const char *next)
@@ -905,6 +907,20 @@ const char *get_signing_key(void)
 	return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
 }
 
+const char *gpg_trust_level_to_str(enum signature_trust_level level)
+{
+	struct sigcheck_gpg_trust_level *trust;
+
+	if (level < 0 || level >= ARRAY_SIZE(sigcheck_gpg_trust_level))
+		BUG("invalid trust level requested %d", level);
+
+	trust = &sigcheck_gpg_trust_level[level];
+	if (trust->value != level)
+		BUG("sigcheck_gpg_trust_level[] unsorted");
+
+	return sigcheck_gpg_trust_level[level].display_key;
+}
+
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
 	return use_format->sign_buffer(buffer, signature, signing_key);
diff --git a/gpg-interface.h b/gpg-interface.h
index b30cbdcd3da..8a9ef41779e 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -71,6 +71,14 @@ size_t parse_signed_buffer(const char *buf, size_t size);
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
 		const char *signing_key);
 
+
+/*
+ * Returns corresponding string in lowercase for a given member of
+ * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
+ * return "ultimate".
+ */
+const char *gpg_trust_level_to_str(enum signature_trust_level level);
+
 int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
 const char *get_signing_key(void);
diff --git a/pretty.c b/pretty.c
index ee6114e3f0a..6d819103fbf 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1575,23 +1575,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				strbuf_addstr(sb, c->signature_check.primary_key_fingerprint);
 			break;
 		case 'T':
-			switch (c->signature_check.trust_level) {
-			case TRUST_UNDEFINED:
-				strbuf_addstr(sb, "undefined");
-				break;
-			case TRUST_NEVER:
-				strbuf_addstr(sb, "never");
-				break;
-			case TRUST_MARGINAL:
-				strbuf_addstr(sb, "marginal");
-				break;
-			case TRUST_FULLY:
-				strbuf_addstr(sb, "fully");
-				break;
-			case TRUST_ULTIMATE:
-				strbuf_addstr(sb, "ultimate");
-				break;
-			}
+			strbuf_addstr(sb, gpg_trust_level_to_str(c->signature_check.trust_level));
 			break;
 		default:
 			return 0;

base-commit: 30cc8d0f147546d4dd77bf497f4dec51e7265bd8
-- 
gitgitgadget
