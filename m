Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F813A26B
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799175; cv=none; b=qiw3buZ/Zmk0WsLtcPSjB+DTAPLmYDhenJRx/L2WgxjfgBY5hP0n3SoDQnXDC8EDMB+o7H5I8OHioAOfqyEUZ6yRAfQlZOAkwTkskGim+KMp8mUsHBAiSST08ju3M12dgliNlzaQ1DQssXCZ2mBuRL7RLU5S3gHpxnNhehy9Idk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799175; c=relaxed/simple;
	bh=4oBDUBX3b50zDdo5wHuL3SddDEDy9BfoqAp7ySWAyto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kebBHdUU+yW7bYfj9Pf4c2TAbhWohPZeksGeGzPAbHOH8aOmv1p5QoW9qcUlmhEb++beunCC1WorZNccFClaeBQNtlDGaiWRZlRe7J8lgeXrNB+u+e98NCM7Kz7/0h6FUmX3Ge+CvHFYD1rrXk8a2imoOwkHwRu3cedUTAFFkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uggn2ZZ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p0wslXw6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uggn2ZZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p0wslXw6"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4ECB711503C9;
	Fri, 16 Aug 2024 04:57:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 04:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723798635; x=1723885035; bh=5ZGO114fXb
	W3ixSpgeMS+E0spQQejFp5tHq5IKoPzbg=; b=Uggn2ZZ7oeBDaRKjTfzgqwT1rA
	ClJmizU8dN1jaYkv46PaC0BOAYzITKQFZK0CeTvB8oq60jn5Mip4COhQJHB8oJPq
	GF7+8XS1RiYTqTgzs3lDrbSfm+2Cau1YV6jkPCBDx5KRcKWEieg8I0a8A7DHRfv3
	AbNwGRxZrrA4ZibrbY1+F7KqO6gQpACAXEzxlRc6NTsfopxumKqeCp7JTDRCuZgB
	FWbu4uxFyygYlCabyyA0LMa6+kkWrqQMnu3Zun7PbYQN9cWn8GXFyXN4JyHrCETh
	XKv2RmRa/DWqbvaX5vAyl/YPQaATgz2prmN/8N9F1smV3t37EHQc4SR2DfbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723798635; x=1723885035; bh=5ZGO114fXbW3ixSpgeMS+E0spQQe
	jFp5tHq5IKoPzbg=; b=p0wslXw62Nfo8e2BsqdKxFMfVygHVNG48QzYtHWMEvnP
	V9jt8Py1TB7NecIa+sUT3ULzUcu2TMrvF1GfeC+vt5GYTDuOV8PkTRgdemTE4XCi
	APEyuFmAb2CKmMwMmbq6cgtbi55Qcjcr/C3TCffTd1M75aW74gc9WlroAUBl1OSJ
	FyKmP79QvUlfqaKxMKf4PlFR0d1AbObQRARADXdMMJOoOInEu/i36gM6qmTFSUHY
	1s7fQ1xofvuXSb+/2G9pwdPVDGA6nBYaU1vBEsARgE0vIDpyipvo8cuXITgx7bCZ
	MF1+/XpihIDrdorItfgD9Y+vpSnKRr7kogRYa77Cwg==
X-ME-Sender: <xms:axS_ZsC8ai9PjMVEeZQfvXOdLebNiyLfwoYLfnAu3g9_pvN_40ERWg>
    <xme:axS_Zuj5_N5ZRVdYEQzGaoXzL-4csB3mFqxLBy-zKcaW-cgAOeUpmXpc_XJFTqVsU
    EVB7_N2cM4_-ltwMQ>
X-ME-Received: <xmr:axS_ZvkvfcNrLgTVmFJ_HVJFwluWVj5ZVoKfqK3nIAT-idViTeYSSvU1Vx64eaQvVTytoz06zwBZhVDhLy3C8-a3ZQyq3Jdtfv7rHjbTJwtho_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhstghhuhgsvghrthhhsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    rghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:axS_ZiyP1iHrfOOhxrN_lqY2rkuHJQEbWOT8tI1i92XY8zvfo45P9g>
    <xmx:axS_ZhRC0I0C3532yidao5rez6Gi7IQS8BnDsRVElXQSVatTT8y64w>
    <xmx:axS_Zta2YECqxltNseZbUHhyYzqaGdoLghtG5Aaw1_P6rmiSwpTZtQ>
    <xmx:axS_ZqSuV-Efc1dtxlHiGapBkE72Fz2sxy1qkzRA7-guIosGrer01A>
    <xmx:axS_ZqKYnLlDdI6tmuXDVS4pRQN0SJd0OW978Eu8fMsH5nNzpIKmW7SU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:57:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a54b75c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:56:51 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:57:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/5] setup: make ref storage format configurable via config
Message-ID: <b68a841450e8f2eeb73e59ddf6f38f4931589788.1723798388.git.ps@pks.im>
References: <cover.1723708417.git.ps@pks.im>
 <cover.1723798388.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723798388.git.ps@pks.im>

Similar to the preceding commit, introduce a new "init.defaultRefFormat"
config that allows the user to globally set the ref storage format used
by newly created repositories.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/init.txt |  5 ++++
 setup.c                       | 14 +++++++++++
 t/t0001-init.sh               | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
index d6f8b6e61b..e45b2a8121 100644
--- a/Documentation/config/init.txt
+++ b/Documentation/config/init.txt
@@ -13,3 +13,8 @@ endif::[]
 	`--object-format=` in linkgit:git-init[1]. Both the command line option
 	and the `GIT_DEFAULT_HASH` environment variable take precedence over
 	this config.
+`init.defaultRefFormat`::
+	Allows overriding the default ref storage format for new repositories.
+	See `--ref-format=` in linkgit:git-init[1]. Both the command line
+	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
+	precedence over this config.
diff --git a/setup.c b/setup.c
index 770ad1393f..dd2251f655 100644
--- a/setup.c
+++ b/setup.c
@@ -2286,6 +2286,7 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 
 struct default_format_config {
 	int hash;
+	enum ref_storage_format ref_format;
 };
 
 static int read_default_format_config(const char *key, const char *value,
@@ -2306,6 +2307,16 @@ static int read_default_format_config(const char *key, const char *value,
 		goto out;
 	}
 
+	if (!strcmp(key, "init.defaultrefformat")) {
+		ret = git_config_string(&str, key, value);
+		if (ret)
+			goto out;
+		cfg->ref_format = ref_storage_format_by_name(str);
+		if (cfg->ref_format == REF_STORAGE_FORMAT_UNKNOWN)
+			warning(_("unknown ref storage format '%s'"), str);
+		goto out;
+	}
+
 	ret = 0;
 out:
 	free(str);
@@ -2317,6 +2328,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 {
 	struct default_format_config cfg = {
 		.hash = GIT_HASH_UNKNOWN,
+		.ref_format = REF_STORAGE_FORMAT_UNKNOWN,
 	};
 	struct config_options opts = {
 		.respect_includes = 1,
@@ -2359,6 +2371,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		if (ref_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), env);
 		repo_fmt->ref_storage_format = ref_format;
+	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
+		repo_fmt->ref_storage_format = cfg.ref_format;
 	}
 	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
 }
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index cd34710f32..0178aa62a4 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -620,6 +620,19 @@ test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
 	test_cmp expect err
 '
 
+test_expect_success 'init warns about invalid init.defaultRefFormat' '
+	test_when_finished "rm -rf repo" &&
+	test_config_global init.defaultRefFormat garbage &&
+
+	echo "warning: unknown ref storage format ${SQ}garbage${SQ}" >expect &&
+	git init repo 2>err &&
+	test_cmp expect err &&
+
+	git -C repo rev-parse --show-ref-format >actual &&
+	echo $GIT_DEFAULT_REF_FORMAT >expected &&
+	test_cmp expected actual
+'
+
 backends="files reftable"
 for format in $backends
 do
@@ -650,6 +663,27 @@ do
 		git -C refformat rev-parse --show-ref-format >actual &&
 		test_cmp expect actual
 	'
+
+	test_expect_success "init with init.defaultRefFormat=$format" '
+		test_when_finished "rm -rf refformat" &&
+		test_config_global init.defaultRefFormat $format &&
+		(
+			sane_unset GIT_DEFAULT_REF_FORMAT &&
+			git init refformat
+		) &&
+
+		echo $format >expect &&
+		git -C refformat rev-parse --show-ref-format >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "--ref-format=$format overrides GIT_DEFAULT_REF_FORMAT" '
+		test_when_finished "rm -rf refformat" &&
+		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-format=$format refformat &&
+		echo $format >expect &&
+		git -C refformat rev-parse --show-ref-format >actual &&
+		test_cmp expect actual
+	'
 done
 
 test_expect_success "--ref-format= overrides GIT_DEFAULT_REF_FORMAT" '
@@ -660,6 +694,16 @@ test_expect_success "--ref-format= overrides GIT_DEFAULT_REF_FORMAT" '
 	test_cmp expect actual
 '
 
+test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides init.defaultRefFormat" '
+	test_when_finished "rm -rf refformat" &&
+	test_config_global init.defaultRefFormat files &&
+
+	GIT_DEFAULT_REF_FORMAT=reftable git init refformat &&
+	echo reftable >expect &&
+	git -C refformat rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
 for from_format in $backends
 do
 	test_expect_success "re-init with same format ($from_format)" '
-- 
2.46.0.46.g406f326d27.dirty

