Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED81A73E
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="q1IyzW2w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kMHMXkx0"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2DC18F
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:40:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 2436C5C0A3E;
	Fri, 20 Oct 2023 12:40:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 20 Oct 2023 12:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697820032; x=
	1697906432; bh=TweKuaZMWKvVWXRvp2XvsvEDpxryNMVq0dJBsV/2WtQ=; b=q
	1IyzW2wgwIVZzefwBbCD8/mUEJX2jOLKJ1N+QTFJx5j1AQIL2tSbcLA6/HMaodDi
	W4eSeQ4lABpgfEhzNXJMwpA0+tmfuaEoqc4Bwh1TymADPDs85MHfL+6OpdsCBQcy
	6JmGNqGsuZU+Bm2D1efEcs3b+QREfuVVubAflO1TBmPzpzLepidlVrSoXvtf7SW6
	gGwFKrwR0d+bV1bTSzIuskOQ33yiPBkNgb7i78c5aaaRz2VwJU6G0jbfYXL7wPxN
	AdiTHyKSs5JlVUAVpBNo2UdOZKsLaBkC9fKkmAhVwV0ysVDPl51F8QMFDl9lciRb
	8BcVSzC/+bQLCgwC+v1sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697820032; x=
	1697906432; bh=TweKuaZMWKvVWXRvp2XvsvEDpxryNMVq0dJBsV/2WtQ=; b=k
	MHMXkx0FIRjFMUkhfgSz1am44htZkEwdc4LIuUt/1PNfCPfLovfhIE9uk1Vfe8T+
	mXrKch2rW4i6RWJ+2aQtdwN9xLLFeZhECg+q1EPOdxI9QSkUAJ9kglv42S40bVOo
	UfeKG7XLT63gOuLTl8YepLUy9MIA979v9Gh3LIzxkaLXX6AtBd7PFQlsHFI69Ntu
	N44GXN4UT8nN8jgFOUILbjtHfQ3iHod8NnEP2i9jIK14LOO1g5KkNu+daRN9HoFG
	ZQgIiu3H/xibuhaPDUvph+mr186CtAJZ/Syr4knz7GgryF+25ic99oe9DnKpgcDK
	yi56X3ooQL6A6EyfhWbaA==
X-ME-Sender: <xms:f60yZYPvNUniEnfarCZmkfaCrJDs1aUwj-PEm0wt_v-f1-fKlO1QM7k>
    <xme:f60yZe_I4E9C81AzE0CNkn1TiGPeuc0gt6lPk6TcYv8HLa9OqjPGIN676OB6xH3kg
    wtPeICfIqGfZ8xQcw>
X-ME-Received: <xmr:f60yZfSf8GxeV_SI5VsoT-zBK0uRzVjGfHDrKiDZ1Py95E6Hf13zAZY0-u8kGlpHGsRQ3C0O-zjdyyLGc1fxdfH2TqUuf68bQc3QjdPs0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenuc
    ggtffrrghtthgvrhhnpefhudevveejtddttedvhfelffeuuefhffeugeeluedtgfdtuefh
    tefhudelleekteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgs
    rghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:f60yZQu__OOywqXEy-2_XsP8MKz5KNmFNzWSY47i0i7e7BF8aJ97tg>
    <xmx:f60yZQf-qAo9Wb6EP5l3welRdqGpNhiPKU9BLFqRclyyuPQTma7zBQ>
    <xmx:f60yZU0PiR_JWROkmPUyHdwP5Zqnz72VmPJxLrY6GciR0vTPq8cItw>
    <xmx:gK0yZRolXSLaHVAMIWBy2O5AB1Akd7xDm4ADOJCHHs7_Qj1Ooz6g7w>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Oct 2023 12:40:30 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: code@khaugsbakk.name
Cc: gitster@pobox.com,
	ks1322@gmail.com,
	git@vger.kernel.org
Subject: [PATCH v2] grep: die gracefully when outside repository
Date: Fri, 20 Oct 2023 18:40:07 +0200
Message-ID: <5c8ef6bec1c99e0fae7ada903885a8e77f8137f9.1697819838.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
In-Reply-To: <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
References: <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Die gracefully when `git grep --no-index` is run outside of a Git
repository and the path is outside the directory tree.

If you are not in a Git repository and say:

    git grep --no-index search ..

You trigger a `BUG`:

    BUG: environment.c:213: git environment hasn't been setup
    Aborted (core dumped)

Because `..` is a valid path which is treated as a pathspec. Then
`pathspec` figures out that it is not in the current directory tree. The
`BUG` is triggered when `pathspec` tries to advice the user about how the
path is not in the current (non-existing) repository.

Reported-by: ks1322 ks1322 <ks1322@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    - Initialize `hint_path` after we know that we are in a Git repository
    - Apply Junio's suggestion for the test: https://lore.kernel.org/git/xmqqzg0hf0g8.fsf@gitster.g/

 pathspec.c      |  7 ++++++-
 t/t7810-grep.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index 3a3a5724c44..264b4929a55 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -467,7 +467,12 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 		match = prefix_path_gently(prefix, prefixlen,
 					   &prefixlen, copyfrom);
 		if (!match) {
-			const char *hint_path = get_git_work_tree();
+			const char *hint_path;
+
+			if (!have_git_dir())
+				die(_("'%s' is outside the directory tree"),
+				    copyfrom);
+			hint_path = get_git_work_tree();
 			if (!hint_path)
 				hint_path = get_git_dir();
 			die(_("%s: '%s' is outside repository at '%s'"), elt,
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 39d6d713ecb..84838c0fe1b 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1234,6 +1234,33 @@ test_expect_success 'outside of git repository with fallbackToNoIndex' '
 	)
 '
 
+test_expect_success 'no repository with path outside $cwd' '
+	test_when_finished rm -fr non &&
+	rm -fr non &&
+	mkdir -p non/git/sub non/tig &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_expect_code 128 git grep --no-index search .. 2>error &&
+		grep "is outside the directory tree" error
+	) &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_expect_code 128 git grep --no-index search ../tig 2>error &&
+		grep "is outside the directory tree" error
+	) &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_expect_code 128 git grep --no-index search ../non 2>error &&
+		grep "no such path in the working tree" error
+	)
+'
+
 test_expect_success 'inside git repository but with --no-index' '
 	rm -fr is &&
 	mkdir -p is/git/sub &&
-- 
2.42.0.2.g879ad04204

