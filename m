Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C52DF65
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594433; cv=none; b=IUrlW9P4Q3IH9+2Iw/WjAtrHaA9wDQqdn8BnngoHjUwMi1E5VhUCapeEKwModwqm3ghgXOvBtuwUPO7EVWofeTUpKkjiARGnEqqdIh9SucB5PEF3ZIVWH/IvZ3bwnvOJO86u8XCMPOfgdFXO3CCjpMaL0hGMoTxgBGOGI3zRA/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594433; c=relaxed/simple;
	bh=cpL6lIRIMWPvwhiVkeP7FuNVvovLlGwbSB80JcUDnug=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=NC+o4jYAcLujf+lDAztR+VVJh5lylPUTtsWnI1aveKneKlioArcJWPcSS0El4U2DAJatCL7Ey3daOr7o8JmpL8L9mKu9lhGXwIiwyiXt0EjORbj5qy/T04Prq4lCb2cqAzWoW3CjYSyWLOD5EAn/LGyJ1/N7aKrheW0OYv5zr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=N+H4OpMN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsbYyC+i; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="N+H4OpMN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsbYyC+i"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 9CFC25C00DE;
	Thu, 18 Jan 2024 11:13:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 18 Jan 2024 11:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705594430; x=1705680830; bh=DW7CRPU9dPo0SDRpw3mxElfp0Xq0I0hG
	ctA/vo834Tk=; b=N+H4OpMNLa0cZ9Z4jPgMJT38LDe1AAi7ryioXCeu1w6RAVl5
	ZqrmDFoM2oMHGUxuqrqRvaqOYtwHpfZnbNrQY6L4MzRfmumJ57zbtURg1ARcfcwZ
	pJ7w/nhThyWMcl3pmC15ZRQwKU9CNSadjNAnDx626HUHPqWaIciOxynXbGOgbZQg
	E+ux0Jk9byTFyIhJAn2KZe7UgMXQB4GyK/NtsjhrFRaymWEsOqey8jH2Ga2NqhjU
	hsguORPiL6vQet5FFe3RfIAKG9DN6sUsuOxqGKCgTte/rT7QCNP6KNRy6VljCq2C
	XOA5igEmt1A7C1YVEy6WWhj5+FYjsRFImeFBTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705594430; x=
	1705680830; bh=DW7CRPU9dPo0SDRpw3mxElfp0Xq0I0hGctA/vo834Tk=; b=J
	sbYyC+itxEJp3aUGPdLO2Qb7ACrfyDDXoSKAk0KP9egD83ILjZmKgfe9OG3SHysd
	cAhEDNMflHj3nSZ0+1iXQoU/+mN23B9Uvc4654B82reViNodJ33e9TZyvtD6ab/D
	W2T67WlUImJmxXYEFsyUGjHDm4Ku+8LQvNGOfhUeAOBxjH2kW2MZknl5uUYUCstq
	iUjsO2B4roKYHiaQiG0vPzxLzJEy0sSwQchYJdnxWEBuikkz+/FQEjjXPcYV8NEN
	EHkPIAh4YobRdOGdGAdB91RrMzoZR7s8C7tsMFiZEHKV7eP6Yllnu8C2J+BIX26A
	udAIVCQlDGOunAeNTwvwg==
X-ME-Sender: <xms:Pk6pZeg2I4g7D5XfnC8I9F2y0GPI_g77Uz-HwFM7clsxKTj3Kd4Laiw>
    <xme:Pk6pZfDsKLCgd7nuMYsdOJVPI_LGPXSUTq0sZWj__GwBCERr3s9a3xFAmdOQDpuZZ
    ehV_FFLzzfG6dVz6w>
X-ME-Received: <xmr:Pk6pZWHa7EqwYIKo92CY0fr5_5IOUlBk3bPvP6RrnV-gvocKkOvkeBTtv-q1pzdG-ZZxhVY5KNKLiJm0yygbO-zjGy7TKF8wZuld3QjtCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhepvefgleevieekgeejieekueevhfelieduvdel
    geefkeejtdekvedttefgffevtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:Pk6pZXSNW2cw-Ap2c6tV04QcvC3Sh-kMsEPB5qDQ-qRmKL9pCi-14A>
    <xmx:Pk6pZbw2RX426jozn0zZfxtmckCCvCbKXeeNa8Gb7GefknOwBl2unA>
    <xmx:Pk6pZV7S2_BSF5p25QUfvXpE2lt9-cuErGxiJjBhbui_FQeZ6fMC0A>
    <xmx:Pk6pZWrEa3bNNcxzCPXi2_mWcFIKs2h3RoT_ZDt9bO0eFdWqQqQyAA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 11:13:48 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] maintenance: use XDG config if it exists
Date: Thu, 18 Jan 2024 17:12:52 +0100
Message-ID: <e0880af0a31aff06ce1d3da97aea568d3e2641b4.1705593810.git.code@khaugsbakk.name>
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

`git maintenance register` registers the repository in the user's global
config. `$XDG_CONFIG_HOME/git/config` is supposed to be used if
`~/.gitconfig` does not exist. However, this command creates a
`~/.gitconfig` file and writes to that one even though the XDG variant
exists.

This used to work correctly until 50a044f1e4 (gc: replace config
subprocesses with API calls, 2022-09-27), when the command started calling
the config API instead of git-config(1).

Also change `unregister` accordingly.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Add `unregister` tests
    • Use subshell when exporting an env. variable
    • Style in tests
    • Free variables properly

 builtin/gc.c           | 27 ++++++++++++-------------
 t/t7900-maintenance.sh | 45 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c078751824c..cb80ced6cb5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1543,19 +1543,18 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 
 	if (!found) {
 		int rc;
-		char *user_config = NULL, *xdg_config = NULL;
+		char *global_config_file = NULL;
 
 		if (!config_file) {
-			git_global_config_paths(&user_config, &xdg_config);
-			config_file = user_config;
-			if (!user_config)
-				die(_("$HOME not set"));
+			global_config_file = git_global_config();
+			config_file = global_config_file;
 		}
+		if (!config_file)
+			die(_("$HOME not set"));
 		rc = git_config_set_multivar_in_file_gently(
 			config_file, "maintenance.repo", maintpath,
 			CONFIG_REGEX_NONE, 0);
-		free(user_config);
-		free(xdg_config);
+		free(global_config_file);
 
 		if (rc)
 			die(_("unable to add '%s' value of '%s'"),
@@ -1612,18 +1611,18 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 
 	if (found) {
 		int rc;
-		char *user_config = NULL, *xdg_config = NULL;
+		char *global_config_file = NULL;
+
 		if (!config_file) {
-			git_global_config_paths(&user_config, &xdg_config);
-			config_file = user_config;
-			if (!user_config)
-				die(_("$HOME not set"));
+			global_config_file = git_global_config();
+			config_file = global_config_file;
 		}
+		if (!config_file)
+			die(_("$HOME not set"));
 		rc = git_config_set_multivar_in_file_gently(
 			config_file, key, NULL, maintpath,
 			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);
-		free(user_config);
-		free(xdg_config);
+		free(global_config_file);
 
 		if (rc &&
 		    (!force || rc == CONFIG_NOTHING_SET))
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 00d29871e65..0943dfa18a3 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -67,6 +67,51 @@ test_expect_success 'maintenance.auto config option' '
 	test_subcommand ! git maintenance run --auto --quiet  <false
 '
 
+test_expect_success 'register uses XDG_CONFIG_HOME config if it exists' '
+	test_when_finished rm -r .config/git/config &&
+	(
+		XDG_CONFIG_HOME=.config &&
+		export XDG_CONFIG_HOME &&
+		mkdir -p $XDG_CONFIG_HOME/git &&
+		>$XDG_CONFIG_HOME/git/config &&
+		git maintenance register &&
+		git config --file=$XDG_CONFIG_HOME/git/config --get maintenance.repo >actual &&
+		pwd >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'register does not need XDG_CONFIG_HOME config to exist' '
+	test_when_finished git maintenance unregister &&
+	test_path_is_missing $XDG_CONFIG_HOME/git/config &&
+	git maintenance register &&
+	git config --global --get maintenance.repo >actual &&
+	pwd >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'unregister uses XDG_CONFIG_HOME config if it exists' '
+	test_when_finished rm -r .config/git/config &&
+	(
+		XDG_CONFIG_HOME=.config &&
+		export XDG_CONFIG_HOME &&
+		mkdir -p $XDG_CONFIG_HOME/git &&
+		>$XDG_CONFIG_HOME/git/config &&
+		git maintenance register &&
+		git maintenance unregister &&
+		test_must_fail git config --file=$XDG_CONFIG_HOME/git/config --get maintenance.repo >actual &&
+		test_must_be_empty actual
+	)
+'
+
+test_expect_success 'unregister does not need XDG_CONFIG_HOME config to exist' '
+	test_path_is_missing $XDG_CONFIG_HOME/git/config &&
+	git maintenance register &&
+	git maintenance unregister &&
+	test_must_fail git config --global --get maintenance.repo >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'maintenance.<task>.enabled' '
 	git config maintenance.gc.enabled false &&
 	git config maintenance.commit-graph.enabled true &&
-- 
2.43.0

