Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D22D796
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594428; cv=none; b=qFOXC2prqyOUnvN82JR45WhlhJItZ4D79WSTz4gLfAWzaHvknambP8FCytNXDJFRWuxWingY/rmNvs7L1+GO2YHQ88AG9iX3/ZOwRKipiAVgii7uhtCbI1MEku8MLXBQZt2SQKVwzfcAt+0eCHDTY7LMaPYthB5XbGhgPI1Oqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594428; c=relaxed/simple;
	bh=79cOdscSHblUIPlzLaTQc17ai/urYL0tuT2ZIHnkCXg=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=J/5DYVf/XkNVlFHE6RjpxaBlBWrjrqSOJth8q3bsT0fiY9OwKhmio/ghFsM9Zq2zTX1/LrYx6nQmvrmODZAjAVSRynY0LxI6DO0bPOj2hdV1Yw1ARR3WTb2urYYTmv68fYsARs9QhlQy6QOixcgDA14sIQ2s9o+P1RDbWnOnrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=i1JSoFTX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p8FwPJcM; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="i1JSoFTX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p8FwPJcM"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 14BD45C00DE;
	Thu, 18 Jan 2024 11:13:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 18 Jan 2024 11:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1705594426; x=
	1705680826; bh=TLtZL3NgybPv6rdIHhR1knaHaa+Qi6aI6gTVnGlZrQM=; b=i
	1JSoFTXI3lSdVW3KOJ6ks1/DH15waI3MhPgr26a9XGyYcyoY9wrvFMS60UaGgT/l
	XhTs2zA/YoVD8kNtWWmfsx+jmPX55CdwWqoUMQlPJ0dAnlEBfZWhZa6UEoOE2uqV
	fhVR+LXKxqngOjJkqbnu4NBdsP3actaZipZviYt4z/AEzK4kfMpQzc77XEjFlubM
	8kcizAnwI8oVBy16wCQYdSAEIvAEa0de70OVu3Xxrqkn0aZuZbevVkWpR4gS4mIL
	LeRZgSlf8iCaQvHpdJqy95kf2sBowcPlrE/ZGwclux/j9Pf98aTu99PFziPpw5VG
	sVSXZtyio8KXS3abAwCug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705594426; x=
	1705680826; bh=TLtZL3NgybPv6rdIHhR1knaHaa+Qi6aI6gTVnGlZrQM=; b=p
	8FwPJcMXrOn5yBSCvHi5j7vYYwfFam9LPuk35CH763KBbkNZmsW/4Gw0yjASaBK5
	Fw5PthyqpnAUKvEYofKfPCexotIzFtjVt6UZeg7iK/RB1xtoubLQUzoh68O0luUJ
	2ZJXCvpgWHbeD+mOg+MkdM71fpafDSgATGutExWEMtTf2Sg+o9j7z1TLZ6oNYRjA
	GTceBECL4ZT2HSx0m7WYqkqy5BtoItqkaK4Vey4JUhHbcML/y3l0Wcc9cO9Mq6Ya
	A73J2rCE9rbupFgFwbbgMpLoLF0UAnAQY8pG2F+m9pkAY5KxjbBTHomLGo2vE8JO
	CC3lUeGoE8QZ+JKsi7cyw==
X-ME-Sender: <xms:OU6pZUz8Z-hcbn-LoanLcW0U6Pc-XPfL2P9vnZyRmkzLl5D21Qj6YZ0>
    <xme:OU6pZYTQ-CagRkeZbkWm9ov_PhKyr0cLC0c8BH9pJgNlvpjb9KLO-_FHiewT2oZbW
    fJ6rRP67iVrOiO_QA>
X-ME-Received: <xmr:OU6pZWW4V8zpTmKnRd-DrYYXKiZaTflK2sGHKZtppd6x3LwQUzyDxi0hD6keshmj97m_pxx88D9uU7zd1WwU7As13ETY2Igc4Eg8AKBZlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeetudeiheeguddtgfduveekhfevudeiieetjefh
    ffetiedtgeejieehtdfhjefgteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:OU6pZSitA6mHulSxQFGrVKxtCX0W5UQDkTCq-NlqReoKFL-Inb5cvg>
    <xmx:OU6pZWBuRtFr6Hl0kzTyxNiODnkOZgQ-UB30tXU4RpiS8QCFNnHshA>
    <xmx:OU6pZTLbjeNPuYX8HnAo9cpnz4FvVurSaAueuZxX-bkvhAbj9cnUzw>
    <xmx:Ok6pZd4VvPAt-Aj_eafuBOolLOMSMIW9doCfOIYDsTz9MpGkMt7ZkA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 11:13:43 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] config: rename global config function
Date: Thu, 18 Jan 2024 17:12:50 +0100
Message-ID: <269490794bc17053c151d6773c7157cfb30e35bb.1705593810.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705593810.git.code@khaugsbakk.name>
References: <cover.1697660181.git.code@khaugsbakk.name> <cover.1705593810.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename this function to a more descriptive name since we want to use the
existing name for a new function.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/config.c | 2 +-
 builtin/gc.c     | 4 ++--
 builtin/var.c    | 2 +-
 config.c         | 4 ++--
 config.h         | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 87d0dc92d99..6fff2655816 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -710,7 +710,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	if (use_global_config) {
 		char *user_config, *xdg_config;
 
-		git_global_config(&user_config, &xdg_config);
+		git_global_config_paths(&user_config, &xdg_config);
 		if (!user_config)
 			/*
 			 * It is unknown if HOME/.gitconfig exists, so
diff --git a/builtin/gc.c b/builtin/gc.c
index 7c11d5ebef0..c078751824c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1546,7 +1546,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 		char *user_config = NULL, *xdg_config = NULL;
 
 		if (!config_file) {
-			git_global_config(&user_config, &xdg_config);
+			git_global_config_paths(&user_config, &xdg_config);
 			config_file = user_config;
 			if (!user_config)
 				die(_("$HOME not set"));
@@ -1614,7 +1614,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		int rc;
 		char *user_config = NULL, *xdg_config = NULL;
 		if (!config_file) {
-			git_global_config(&user_config, &xdg_config);
+			git_global_config_paths(&user_config, &xdg_config);
 			config_file = user_config;
 			if (!user_config)
 				die(_("$HOME not set"));
diff --git a/builtin/var.c b/builtin/var.c
index 8cf7dd9e2e5..cf5567208a2 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -90,7 +90,7 @@ static char *git_config_val_global(int ident_flag UNUSED)
 	char *user, *xdg;
 	size_t unused;
 
-	git_global_config(&user, &xdg);
+	git_global_config_paths(&user, &xdg);
 	if (xdg && *xdg) {
 		normalize_path_copy(xdg, xdg);
 		strbuf_addf(&buf, "%s\n", xdg);
diff --git a/config.c b/config.c
index d26e16e3ce3..ebc6a57e1c3 100644
--- a/config.c
+++ b/config.c
@@ -1987,7 +1987,7 @@ char *git_system_config(void)
 	return system_config;
 }
 
-void git_global_config(char **user_out, char **xdg_out)
+void git_global_config_paths(char **user_out, char **xdg_out)
 {
 	char *user_config = xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
 	char *xdg_config = NULL;
@@ -2040,7 +2040,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 							 data, CONFIG_SCOPE_SYSTEM,
 							 NULL);
 
-	git_global_config(&user_config, &xdg_config);
+	git_global_config_paths(&user_config, &xdg_config);
 
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
 		ret += git_config_from_file_with_options(fn, xdg_config, data,
diff --git a/config.h b/config.h
index 14f881ecfaf..e5e523553cc 100644
--- a/config.h
+++ b/config.h
@@ -382,7 +382,7 @@ int config_error_nonbool(const char *);
 #endif
 
 char *git_system_config(void);
-void git_global_config(char **user, char **xdg);
+void git_global_config_paths(char **user, char **xdg);
 
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
-- 
2.43.0

