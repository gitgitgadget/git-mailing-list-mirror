Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB72208AA
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="j5ZfIAwp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qGzMv7lr"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E9D51
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:04:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 9E33A320097A;
	Fri, 20 Oct 2023 14:04:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 20 Oct 2023 14:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1697825054; x=1697911454; bh=HQRkjUSahfPoiaeG0eyzuk0a1
	qJ0K8f9Wd/K0IOpCDM=; b=j5ZfIAwpf1olUVlq7U6Vap4Hpppi9cV+zV4tjKoAb
	0cXd+3ai/2+RHuvv6zeFWzYsp2o9UZYP518Pe/vxGzPWAyE6E5cJUGG+Wy7ugo+s
	SQF2wvqLd13DHOyKInAMworhVSJ/ZXQMHVFg2h34wwYAtwp1SVkCnq+eDG5++2sb
	PPWLXrTccqd9ODb0YLk1FdxP+q1F+V8Uda2vZ/qF9c6UfrjYbVpjLwO+G9t6lkrZ
	BkfnUARcSB3sKyCyAp/dPYLrVOKASYK+au6IT4mbnRWgI21i4lC8HbeSKpIuIkJS
	3gUzQq7ubLEqFt8iMMWl10MPcTmZvWrRC48SZ9RvhKqCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697825054; x=1697911454; bh=HQRkjUSahfPoiaeG0eyzuk0a1qJ0K8f9Wd/
	K0IOpCDM=; b=qGzMv7lrbDZvXlv+EpGWUUahetQ0t0GS+xFN6exUPimuVAUIpS2
	+QrIXy8gTb7ZhaEwcEWNOCTn9CuwzyZYLkcH2uO/UH3p59H4aXuT67etLavbc89S
	SEvvaolUNKcThEQNz4qm/TAnJE3i5mY04WpvYFtVRxVc8rGHO5Jvudl8hUCeosim
	ua5l5tECTzSTdRXHtKwcnRo9gfaf5trN7rH1Ct0VlvWdhnQUTMjHH6/oAgxDGBLx
	B/VZWmyNXZboUtCaCztdlH11yVw0QrwJpNgs+aDIGRJxA/Y1MSCqzxAndjJPkNex
	bZ5NrLXwRHpNeg2qLE/waOr/C+/qFHiQQEA==
X-ME-Sender: <xms:HcEyZecDiwwczgH3bS93o4zeaSbbvixmPEejwjcesEZmXK743L_U96o>
    <xme:HcEyZYNPnG_Kl4UCqQARhx_TVkk85BNzLd6uXWsKEGd_2L_-GmqGpdR01YLR0gls-
    hRyeSQ1Pr1BI8JPPA>
X-ME-Received: <xmr:HcEyZfjkIdMdMSSQp96k3lGIC94ZzPpxOYfCY-0k-echeTfGI6Sa3Rq18edUaqzJoL5yEioZpyQOi5zo3w2hqBA3U8AETPlQ1g1ql2HCJuUszqGVq5EZDOtO2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeekgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgv
    rhcujfgruhhgshgsrghkkhcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqne
    cuggftrfgrthhtvghrnhepueeiueffuefftefhhfefleelhfeuheettedtheevgeejteeh
    gfevffeugffglefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhs
    sggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:HcEyZb-5qMLQvM23ufgIiGtFFxZQ-_4PsNXtTDCAOdYSa4cn10q6bQ>
    <xmx:HcEyZat0EJP0rtYnZWNf9OQQFpcnmUSsFA0fXcrOgoDlf5GxAEvBRw>
    <xmx:HcEyZSHrXb-CtXcj4pKDaV83t1L3r4wdo0VjQT1hlneqAdRy9gomcQ>
    <xmx:HsEyZeIzkmCN_TEa5TZxZi970HdRaCiqO_tVqQE3e3d_z2C_b_HopQ>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Oct 2023 14:04:12 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: code@khaugsbakk.name
Cc: gitster@pobox.com,
	sunshine@sunshineco.com,
	ks1322@gmail.com,
	git@vger.kernel.org
Subject: [PATCH v3] grep: die gracefully when outside repository
Date: Fri, 20 Oct 2023 20:04:04 +0200
Message-ID: <82b6a48b8f98036e5c394ae39f96ef5f3f6a641e.1697824787.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
In-Reply-To: <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
References: <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
`BUG` is triggered when `pathspec` tries to advise the user about how the
path is not in the current (non-existing) repository.

Reported-by: ks1322 ks1322 <ks1322@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    - Initialize `hint_path` after we know that we are in a Git repository
    - Apply Junio's suggestion for the test: https://lore.kernel.org/git/xmqqzg0hf0g8.fsf@gitster.g/
    v3:
    - commit message: correct to “advise” (“advice” is a noun)

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

