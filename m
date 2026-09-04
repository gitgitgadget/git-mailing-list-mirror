Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75A3BD64A
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537092; cv=none; b=Xg4lGQFOoZ5aCc7OsHDALtu1/BeYq3asKf1sHeR8nRK/yzoUL6v9sPjXOfmfkGgUOOQjAMJCHJjUFXQj8KDtdwtw/Cm+Xx5iRXFvKESMv9dSgDwOiRwNkBwCqN4F22mgg1e5Tp0CcQ7nBheoGJxVATmeuzw18KKgDw6UI27FHUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537092; c=relaxed/simple;
	bh=+neXbSDJ5dQLNTmRU8oAOqqdh2nqeVhECoN8rb2kg8k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TR95N2kqO48pEPgfMSk95AFIrLGhLoaSszaXQZZi5BIqaaM5KOSZuFqc2El4dE6C8/xA0VAzlak3Q42ITJ4kexYplAPUygEhMjnTPQxrbfFAKoxFmnr+ijs0Y6fkZQNmiBPkljx56yBeww0mWmJeMzdS49rSZA22LWb/iVIrIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzIijCTi; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzIijCTi"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f4f824de5dso612630a34.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788537090; x=1789141890; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GUCk5ZswPZFGEk6qoPTRr4KJEBIAH+/Oc79X53w6Mfo=;
        b=PzIijCTi4L5YmljRQnZkt2NLOX0CwVXH3dML3BKjFbf1b4RX2ZQ7UG7lQpespNt8p1
         ZCEjrhSKzSn2NGG5SFjXY1moDt0NKueI3NkMN9gnsMPm6kArv0w8/4kY1Nidpp0NL/yJ
         32Av9AwZBpcyjKiuuS5psPjH9W8UfhjFrG3EINmNlRYmCaimuKzLY/h6r8M7MciUvKTH
         Uy4mTS0lHiA6cf4chDJBMRx54TTPIr6Vt2oKBF1SPAOMa4g3HaZYpay7Lt501yKHrSIQ
         bfTzPFBxOpy5YwYbZ1k3jKIjlhiWIyapUPMIUyXtwU0FsMm6ZEOw1bhHsFFlPuynB7lm
         sqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788537090; x=1789141890;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GUCk5ZswPZFGEk6qoPTRr4KJEBIAH+/Oc79X53w6Mfo=;
        b=UbfOPbtSDYllOZZ/Y0vXnvDO3+4YuNd6c7afr3ig47rwfMmsJet23tgXBQGEu5gLox
         HXL+ixB8SWRPpkogY4raZYnxx0R8GSs6hxAu7C5plbf3MArIIn451/L1Lw0pyAuvO6Yh
         c6QYfHHnxNTwlb6yVtR+0hOITYn0PjmlIVgdQxmspus80uqeiozxMQLmTF31E9KVReu0
         uVDnp7ZduI/X8Zmk0c5JHX+4kK4I73brgrrfwXGOG9SouPTA4sHfo88PfBRfzwSPZxdG
         xdCkNT4du+hDuMnINHcYRMN0TPUc1HCQzYMHf3nxNo8/Uu/EIyT1V1b+lj/kN4lYWqQx
         1RZg==
X-Gm-Message-State: AFuF++mVvUyCY5H8XBr45j2466U+17sgRvUk4iVe4EUugiIY0I+0nPjj
	vHye53Xn17/yNF3TYIeMQbcvJEyh2eTjv/ukHWwDaf51TEMlYtxqfFkye55jozsC
X-Gm-Gg: AYBFou2byuH+6051gfO9jJoNXG5Wo1sMIxeNlwWXPJZo19VGy/L6Jcjc/BE0tsrCTmg
	XZEFnjXgQTd8xtMC6gCycVDvlwoEqj0EUMZCbNzDZDQGhwlTpmVphv6HPTXxwypXCxDHau/d0+b
	cgg6BV7VgaMYJpDhiZpvj+eJJPOSfTOKlV5jncVD1TeJoIxH7q++RyJ/Mz2y8N34uOqtO5zj2Zh
	srSfdIjYP+4YgB0VYk8q+BZgm9yuVPEvbpHZCmLbFb3aNAhFyJ2gWYRougbOWY66jPZ/iwbSvrN
	UclSuDpdQqaC3xvX9z7olSLKBxKIob41YHWsPBw7F67lFnWbaxX2UrlZ6+Rnaqd+Ayx2THg7Kxo
	/41NAUL71x9rrLCGFYBRFXlTkKFxakMPbx+FJZY+MtYdR2UmuIux/PFgaDOZihttc6hBCqm95s4
	Xhg0xiFIbNJ3JUVLcYZzhgjjfTRS+yIPAVSXWCZopHbgLDAc5skCJa12COmRbYijNGy3W9Kpvso
	A==
X-Received: by 2002:a05:6820:991:b0:6b1:c679:7117 with SMTP id 006d021491bc7-6b6faee2795mr5094558eaf.4.1788537089625;
        Fri, 04 Sep 2026 08:51:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.247.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534152sm7387426eec.10.2026.09.04.08.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:51:29 -0700 (PDT)
Message-Id: <ef8087e80db18c511e31dd9c7dd6ea3d57dd543c.1788537086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Sep 2026 15:51:24 +0000
Subject: [PATCH v2 1/3] config: add git_config_append_parameter()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

Split the part of git_config_push_split_parameter() that formats one
GIT_CONFIG_PARAMETERS entry into a helper that appends it to a strbuf,
so that a caller can build a value for a child's environment without
knowing the quoting. The sequencer is about to do that.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 config.c | 20 +++++++++++++-------
 config.h | 10 ++++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index d9019e7e6c..e0bb29b53d 100644
--- a/config.c
+++ b/config.c
@@ -450,18 +450,24 @@ static int git_config_include(const char *var, const char *value,
 	return ret;
 }
 
+void git_config_append_parameter(struct strbuf *env, const char *key,
+				 const char *value)
+{
+	if (env->len)
+		strbuf_addch(env, ' ');
+	sq_quote_buf(env, key);
+	strbuf_addch(env, '=');
+	if (value)
+		sq_quote_buf(env, value);
+}
+
 static void git_config_push_split_parameter(const char *key, const char *value)
 {
 	struct strbuf env = STRBUF_INIT;
 	const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
-	if (old && *old) {
+	if (old && *old)
 		strbuf_addstr(&env, old);
-		strbuf_addch(&env, ' ');
-	}
-	sq_quote_buf(&env, key);
-	strbuf_addch(&env, '=');
-	if (value)
-		sq_quote_buf(&env, value);
+	git_config_append_parameter(&env, key, value);
 	setenv(CONFIG_DATA_ENVIRONMENT, env.buf, 1);
 	strbuf_release(&env);
 }
diff --git a/config.h b/config.h
index b66dd08007..fcf48f6245 100644
--- a/config.h
+++ b/config.h
@@ -22,6 +22,7 @@
  */
 
 struct object_id;
+struct strbuf;
 
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
@@ -186,6 +187,15 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     enum config_scope scope);
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
+
+/*
+ * Append `key=value` to the GIT_CONFIG_PARAMETERS value in `env`, quoted
+ * the way git_config_from_parameters() reads it, so that a child can be
+ * given configuration on top of what this process was given. A NULL
+ * `value` appends a boolean entry.
+ */
+void git_config_append_parameter(struct strbuf *env, const char *key,
+				 const char *value);
 int git_config_from_parameters(config_fn_t fn, void *data);
 
 /*
-- 
gitgitgadget

