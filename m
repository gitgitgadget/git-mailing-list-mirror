Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9293E010
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="m5EYduWB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LfrDQY23"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350D110E6
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 13:29:24 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 2E1A95C0116;
	Wed, 18 Oct 2023 16:29:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 18 Oct 2023 16:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697660963; x=
	1697747363; bh=CvDfaddkbFav4E/axthUtVquSo78BG12GBoUBh5Nh7g=; b=m
	5EYduWBynE7mggd2LmrTUJLh6eG9vKK8RPI8EL3hQM/YaZWZ9QoSk48llz5keP5L
	WuazxNWDoEP9btKcWp44SWiK+8sgc1eOIWaKY/SF8R7uoy2xGi0YgLueUQC9QHLI
	1NsEGqF8Ez6VxqNsXNEqgGcO2OsDYF6u07x6bAP1/8r2tH0i0rrt5IqUp5SIhEma
	IFu7BBSXPBdg/Z6K9seVhThOTzSg1aykf30NNV4sqJBVSKXHe/55jWYy8OTl8mCB
	p8/cdPnaTj+SNFeha4EY/xvWCUknYoy7g2NT0jRIBfhxU41HODrzzK5TUzEO3hVe
	kT4JekqacHEE37Fd9mm4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697660963; x=
	1697747363; bh=CvDfaddkbFav4E/axthUtVquSo78BG12GBoUBh5Nh7g=; b=L
	frDQY23qjK3VMUQOf6GeKGp00moTN/uzXqhw1KQgAYFFiKk+7+8JNkWzLAntJ7ja
	CHSY++f1admiRqwtR0qs82u4rutz7PTMbJdIxlor5zgOX69/Wc9zIYIqZ61/R3/I
	4xmrI1eveFhElmPMvGVj6BQX1yY+YJrMUjqSUHubPZZRC2O5dkcqQEya21fuH5ez
	8WcATXwmKDglrilNrlqxTw7RGvp+WUYknb4Dg5uNHDQOi51qbQWYHRvLh+8X0GKs
	Kw8AiQM4t/n3eI/adfObNkWHNRpXumd3QMFovWNGkRUlmVjtDo62XGBI1ykWknkG
	l+a+m3UmfeXY/Hx+RuVIQ==
X-ME-Sender: <xms:IkAwZTaCjulQP2K4Os06CtxI3613T9FW0mbSNtXX0re_ZvoQU_tVYCo>
    <xme:IkAwZSYRaKDCauLX3bFvGWGzkVQosHdqgRkLsJYSv9bObdDr-WKA_5Aw411B7MNJu
    bs99TC8kv2jGlpb0g>
X-ME-Received: <xmr:IkAwZV_JH4a1Sd_HcHJL5OV-5LdDTiqZEXzb2samkTIJx4Iuf5WARRmGw7RzYabympz9c08To_ccGDKkE59RZtn3YvRJTbvWEpcQobz4o1BkIWX1YkCbayxEJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeeggddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteduie
    ehgedutdfgudevkefhveduieeiteejhfffteeitdegjeeihedthfejgfetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:I0AwZZqD6_Rg94z_ZOa7DDgtFyaCNUrCS4_2yYZJCH_yvxfQQduflA>
    <xmx:I0AwZeoov_omIfvNF9ALNHnMbaOetEuRMWx8DZD472xDvXrlDtWkZg>
    <xmx:I0AwZfRDxaYIV4K6B1FJxA4cKktrHzQfXOjZF_YmeCy-4rZvdBbuyA>
    <xmx:I0AwZV2pqglhPwyyLLPP_Z5AtRowB7WofRFanAnZJvVVcKZziCrmXA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 16:29:21 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ps@pks.im,
	stolee@gmail.com
Subject: [PATCH v1 4/4] maintenance: use XDG config if it exists
Date: Wed, 18 Oct 2023 22:28:41 +0200
Message-ID: <1e2376a4b998b5b182cc5f72afc7282134bcdf2c.1697660181.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
In-Reply-To: <cover.1697660181.git.code@khaugsbakk.name>
References: <cover.1697660181.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 builtin/gc.c           | 23 +++++------------------
 t/t7900-maintenance.sh | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 17fc031f63a..7b780f2ab38 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1526,19 +1526,12 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 
 	if (!found) {
 		int rc;
-		char *user_config = NULL, *xdg_config = NULL;
 
-		if (!config_file) {
-			git_global_config_paths(&user_config, &xdg_config);
-			config_file = user_config;
-			if (!user_config)
-				die(_("$HOME not set"));
-		}
+		if (!config_file)
+			config_file = git_global_config();
 		rc = git_config_set_multivar_in_file_gently(
 			config_file, "maintenance.repo", maintpath,
 			CONFIG_REGEX_NONE, 0);
-		free(user_config);
-		free(xdg_config);
 
 		if (rc)
 			die(_("unable to add '%s' value of '%s'"),
@@ -1595,18 +1588,12 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 
 	if (found) {
 		int rc;
-		char *user_config = NULL, *xdg_config = NULL;
-		if (!config_file) {
-			git_global_config_paths(&user_config, &xdg_config);
-			config_file = user_config;
-			if (!user_config)
-				die(_("$HOME not set"));
-		}
+
+		if (!config_file)
+			config_file = git_global_config();
 		rc = git_config_set_multivar_in_file_gently(
 			config_file, key, NULL, maintpath,
 			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);
-		free(user_config);
-		free(xdg_config);
 
 		if (rc &&
 		    (!force || rc == CONFIG_NOTHING_SET))
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 487e326b3fa..a11e6c61520 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -67,6 +67,27 @@ test_expect_success 'maintenance.auto config option' '
 	test_subcommand ! git maintenance run --auto --quiet  <false
 '
 
+test_expect_success 'register uses XDG_CONFIG_HOME config if it exists' '
+	XDG_CONFIG_HOME=.config &&
+	test_when_finished rm -r "$XDG_CONFIG_HOME"/git/config &&
+	export "XDG_CONFIG_HOME" &&
+	mkdir -p "$XDG_CONFIG_HOME"/git &&
+	touch "$XDG_CONFIG_HOME"/git/config &&
+	git maintenance register &&
+	git config --file="$XDG_CONFIG_HOME"/git/config --get maintenance.repo >actual &&
+	pwd >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'register does not need XDG_CONFIG_HOME config to exist' '
+	test_when_finished git maintenance unregister &&
+	test_path_is_missing "$XDG_CONFIG_HOME"/git/config &&
+	git maintenance register &&
+	git config --global --get maintenance.repo >actual &&
+	pwd >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'maintenance.<task>.enabled' '
 	git config maintenance.gc.enabled false &&
 	git config maintenance.commit-graph.enabled true &&
-- 
2.42.0.2.g879ad04204

