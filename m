Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6A3E007
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="nsTxC3sn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="olgxaf6A"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B4D10DD
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 13:29:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 858E05C0267;
	Wed, 18 Oct 2023 16:29:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 16:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1697660961; x=1697747361; bh=OKuqjneD8+v87x9+Y+Iv3A4XU
	462/xfToiSeUDirN1k=; b=nsTxC3snRlaK1rzDgKVFRyZwDQj7jM08e5RdibRGc
	z0L/Kry5bBeMqEm6gHvonfxGNE3RUgYhKU1E1GpqGRRo+yu7cg8fEyL/kaN4fcAu
	Vx3XxMb0BgMTn64/5mzMgcEQiay3FrOZrlbbj5ngsZzZe9yRLuzWjS48wA3W9yAZ
	INcvzBPvr7WaO/DdeCLxsGspPDbN+CVoyxMuyPiW+Gj3LJ8Ty9AdVxQ4c9GqSuE8
	wMyp3D3jcVyzxoDQFl0wLd4TSoeo72F98l30sVBGF5loA1KfruiJjalQsXrSwK0D
	l5FGRuxQj+y4/cLfhkwxhzfDVyz/jlDGAWyKUnJQMAcqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697660961; x=1697747361; bh=OKuqjneD8+v87x9+Y+Iv3A4XU462/xfToiS
	eUDirN1k=; b=olgxaf6AygB46blulGacNn/5Fg+Q/p2Numki6z4KTH5PlJiciep
	7+UULQXOSt3qnakwR/OGsvsko+oAziYfPP8Q0SYOviXgBPsZwgsvY1fBphW+MXbB
	jMXf5BY0fJxBbk9Dxu84x1AXYCdeXw7js/sSw36LibOt7moR0XCujiFYesz2KaR/
	aIk1WvRsGnG30x9I/jKAL5xV/RHcKrG2OF6ZCfBijjJeURVIvPBvhPMTRFHoHIiX
	oqJv/CC/rMsRhnKpIaaAxD5IDBZH8SqzWWrRT7P4sr2lMWGPrUo3+pQVqXpIIEXK
	5lMUnBOqZ9Q/JXHCD5icfw2hgv3yaCR8gyQ==
X-ME-Sender: <xms:IUAwZUF8HprNBGvwB4h42GzfYBF0jGTaLm8bS6cdhvns7a8NyvyGUu8>
    <xme:IUAwZdVpfzRPPE3v3orQakWRedksv7J6XUWQrOPNPqE2vckosNpqza0BoxMdvLAr_
    Se3nKAeYzdYreFKwA>
X-ME-Received: <xmr:IUAwZeLFERH5Litqxs3Oxhw5w9ivML701YWxlsrPSg3bGF14sV3YnlS43ZAREEUnxrWYjgljeU0E42QI7Io7BhMvXD7jD_l_5RsfGaIEK9GK0f7b1R4Bk-pJKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:IUAwZWG5lemTVJlOH1uSQhS_qzoghpO8yE34Th63rmFuWngJBvEF0Q>
    <xmx:IUAwZaXY_Di6dX72yq7MWhsn__myPWcMNJiKQTrj1yZ34spC-s37JA>
    <xmx:IUAwZZMYT70Sz50Z2EfI6OV1zczhbahjYfaZ8jPHwGACe12LCAYJZw>
    <xmx:IUAwZXh1yuqkuoLJoAOo8elA0RUgNnpP-X0tjB-ouKaj80oARnGwbA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 16:29:20 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com
Subject: [PATCH v1 3/4] config: factor out global config file retrieval
Date: Wed, 18 Oct 2023 22:28:40 +0200
Message-ID: <147c767443c35b3b4a5516bf40557f41bb201078.1697660181.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
In-Reply-To: <cover.1697660181.git.code@khaugsbakk.name>
References: <cover.1697660181.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Factor out code that retrieves the global config file so that we can use
it in `gc.c` as well.

Use the old name from the previous commit since this function acts
functionally the same as `git_system_config` but for “global”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/config.c | 25 ++-----------------------
 config.c         | 24 ++++++++++++++++++++++++
 config.h         |  1 +
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 6fff2655816..df06b766fad 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -708,30 +708,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (use_global_config) {
-		char *user_config, *xdg_config;
-
-		git_global_config_paths(&user_config, &xdg_config);
-		if (!user_config)
-			/*
-			 * It is unknown if HOME/.gitconfig exists, so
-			 * we do not know if we should write to XDG
-			 * location; error out even if XDG_CONFIG_HOME
-			 * is set and points at a sane location.
-			 */
-			die(_("$HOME not set"));
-
+		given_config_source.file = git_global_config();
 		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
-
-		if (access_or_warn(user_config, R_OK, 0) &&
-		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
-			given_config_source.file = xdg_config;
-			free(user_config);
-		} else {
-			given_config_source.file = user_config;
-			free(xdg_config);
-		}
-	}
-	else if (use_system_config) {
+	} else if (use_system_config) {
 		given_config_source.file = git_system_config();
 		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
 	} else if (use_local_config) {
diff --git a/config.c b/config.c
index d2cdda96edd..2ff766c56ff 100644
--- a/config.c
+++ b/config.c
@@ -2111,6 +2111,30 @@ char *git_system_config(void)
 	return system_config;
 }
 
+char *git_global_config(void)
+{
+	char *user_config, *xdg_config;
+
+	git_global_config_paths(&user_config, &xdg_config);
+	if (!user_config)
+		/*
+		 * It is unknown if HOME/.gitconfig exists, so
+		 * we do not know if we should write to XDG
+		 * location; error out even if XDG_CONFIG_HOME
+		 * is set and points at a sane location.
+		 */
+		die(_("$HOME not set"));
+
+	if (access_or_warn(user_config, R_OK, 0) && xdg_config &&
+	    !access_or_warn(xdg_config, R_OK, 0)) {
+		free(user_config);
+		return xdg_config;
+	} else {
+		free(xdg_config);
+		return user_config;
+	}
+}
+
 void git_global_config_paths(char **user_out, char **xdg_out)
 {
 	char *user_config = xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
diff --git a/config.h b/config.h
index 9f04de8ee3e..5cf961b548d 100644
--- a/config.h
+++ b/config.h
@@ -394,6 +394,7 @@ int config_error_nonbool(const char *);
 #endif
 
 char *git_system_config(void);
+char *git_global_config(void);
 void git_global_config_paths(char **user, char **xdg);
 
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
-- 
2.42.0.2.g879ad04204

