Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984172D7B2
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594431; cv=none; b=RaW02pHQFqu4R+h6PeGlDRTVnnyHkZpBrCjov7r1P61O0xFVypT5FS7T+rX4sadu/1yIhkIWeNk9ZdGg4PPna3GqYDfJ3aYvtJ7Co4fvo2c3FZHp5GV47os5ft5hK1Yd6pz739aCxT3KdcptfwdNmywuQ6McYEocuDZnJk5ZiLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594431; c=relaxed/simple;
	bh=If5MDstJm6UXUQVFy+yGlRKP6w/PB5yaW4LYC51sIyo=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=Fl+WTeh6pDueebOKer6ZpQWOErSckxOjo2U+aLBjWKv8d0YyuWQ+WjdGoTwGxZ/DF8sCNRTlb25SMyAyqGkFXCBSwuX3+AaMdrX1VvLYadhaM/7WmbYYPrX70nHFPtzGEvPdKmNgnYNNwHNXUPKzA1eL7sm8Kek2CAqwBp626YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Y9D8NRcw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MYL/tcWO; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Y9D8NRcw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MYL/tcWO"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 7FCBD5C00D7;
	Thu, 18 Jan 2024 11:13:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 18 Jan 2024 11:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705594428; x=1705680828; bh=2OghQhbmWpHOC/sVwSElZqCL2q8M21Kb
	+JxGTfqgIMk=; b=Y9D8NRcwm6ZSgew1CoZldK+qsjPrBc1CxcmEwWGN2mcx1Zbi
	q/mdz/AL18b1X0EQoBvHGsVtPP9CMJq6aqcCIrOc1UDKW/mr+Riq+cTEVE0Dj8XZ
	SMPFvAxIVdQq/geVWIRmt9fGx+voKmTQgzW9KYLfhvFdmO68pzy+jf+p6piSoUak
	vi2dhcerupPFjoHaeXyq91tuoHHLuDt3T+zW1W5FnzHBUBjXjUloA2YIhqdVujMx
	CTrLPeXS5IP5J39F6sdW9O3bo3ZZJOh1BeCFDcfCXsEHhh5jfZEtQKSlqIFJeolw
	lgNsQ9pR875BOy/8WTF8Q7w5V0NZv+vcUQeXQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705594428; x=
	1705680828; bh=2OghQhbmWpHOC/sVwSElZqCL2q8M21Kb+JxGTfqgIMk=; b=M
	YL/tcWO5seKjuVYVjrHoIhRPL37xJXNJUbNKfnKooSGKepnAkK7WpYbrPqtQVuKp
	ZeujyfehgU3I6nfIW548550V6T00++amDOkcZo8xSaNBKLrNpWwL3kIoK+xu1wf2
	ySYyAT9861Z3/7Y7Rp2++f64VSyvZ9AkUL5iEWsdhKXoHrODz4z2STNf4CvA7dbS
	EN2OafUqawXmiB20exa91VhpaWFhXkq1GGrtRE9Y5r+EBtnrbA6DaXp43cnSR5sy
	zDzjR/mG32vS1SvvIjszh5Dz7vznJw2golDnmHzSxozUFs9URyicZNfcmnAop1Jo
	yu34QVpaH6GlWXMYHQGtg==
X-ME-Sender: <xms:PE6pZcbdh0yyO0lOpph59bwcoNnRDXMvFmvYj6FyQjTmKKCgdyYrobA>
    <xme:PE6pZXZtlxXyeyuHb4eKAMxiaEeztStj8RRzTdOlR8GeIxgxlmtzJhiViDBny0E0s
    PQV9w6LG7__mRvLFQ>
X-ME-Received: <xmr:PE6pZW_3-XHpXdwG63JmkSctj_0Sq3BBk-bvQ9XedoU0ktXT0N0EpDfLo5Lth48txlAOrt8abZ2_SVMyPHsyWSm0DbemTNFKGNlrq_UMGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepueeiueffuefftefhhfefleelhfeuheettedt
    heevgeejteehgfevffeugffglefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:PE6pZWqA87w-aCxWLy8G5rgt-aePbbyScycaRtKX6VGJ1-p8iNJmTQ>
    <xmx:PE6pZXqtCMPFYjhVII9u6DLkN7dZF_tBMrY_-KaFHaHvHwebj2O1DA>
    <xmx:PE6pZUQV7A_Pa-M2jj1KLDPNV5R6CV6FDht0sgDTLlxQxoXUKvF8pg>
    <xmx:PE6pZYAluUOlHuAixWw9TYD8zNHGwojxVwTtFFcC-T1MUPwJuWxYdA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 11:13:46 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] config: factor out global config file retrieval
Date: Thu, 18 Jan 2024 17:12:51 +0100
Message-ID: <0643a85892cf8a7732593646f1e8a4d0e37d38b7.1705593810.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705593810.git.code@khaugsbakk.name>
References: <cover.1697660181.git.code@khaugsbakk.name> <cover.1705593810.git.code@khaugsbakk.name>
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

Notes (series):
    v3:
    • Remove doc on `git_global_config`
    • https://lore.kernel.org/git/c87b3d93-74db-4377-a57c-80f766d46e7f@app.fastmail.com/
    v2:
    • Don’t die; return `NULL`

 builtin/config.c | 25 +++----------------------
 config.c         | 20 ++++++++++++++++++++
 config.h         |  1 +
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 6fff2655816..08fe36d4997 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -708,30 +708,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
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
+		given_config_source.file = git_global_config();
+		if (!given_config_source.file)
 			die(_("$HOME not set"));
-
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
index ebc6a57e1c3..3cfeb3d8bd9 100644
--- a/config.c
+++ b/config.c
@@ -1987,6 +1987,26 @@ char *git_system_config(void)
 	return system_config;
 }
 
+char *git_global_config(void)
+{
+	char *user_config, *xdg_config;
+
+	git_global_config_paths(&user_config, &xdg_config);
+	if (!user_config) {
+		free(xdg_config);
+		return NULL;
+	}
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
index e5e523553cc..5dba984f770 100644
--- a/config.h
+++ b/config.h
@@ -382,6 +382,7 @@ int config_error_nonbool(const char *);
 #endif
 
 char *git_system_config(void);
+char *git_global_config(void);
 void git_global_config_paths(char **user, char **xdg);
 
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
-- 
2.43.0

