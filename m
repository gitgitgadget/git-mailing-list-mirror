Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA642C8C0
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Z1QvHFdD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Faz5Slec"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71189CE
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 14:04:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 37F9F32009E6;
	Sat, 14 Oct 2023 17:04:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 14 Oct 2023 17:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697317495; x=
	1697403895; bh=dw8buPTJdlKDy5hDY8V/t7O3X08xShC2YdVPaOFevjc=; b=Z
	1QvHFdDC17/OGbAQDJF0/UUOjh7/lsMu9v6agrchS3ShTj+3VgRRt3hnbFf5H4yb
	b0DzHfoFMkfiknf4bUTKjCNqFQqXWReV1skmBUPNHvJqOcYfYUNT/L22/P4+Upe7
	MGxLZGFGDMhhdCPs97l+RFZWAakPnQCvQ6XmFoMuLNzlKhqEy2jJmLYwTtqByIAC
	f1UMFqX3EAS1Wod8yUuhDkMU3M1/l89fH/A2Kr3m44FuPo1Zx/KAuc43nGUHygcU
	yI0w9I0QHTIQcMtZP8XVjIDp8N18PTzKaoc2SOyN5JKQvYnwqHoldpKEWITw6vzC
	R1bdNE0Zv8bhwNn2tbasQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697317495; x=
	1697403895; bh=dw8buPTJdlKDy5hDY8V/t7O3X08xShC2YdVPaOFevjc=; b=F
	az5Slecj6QzpmB5ZJoMm5wpc38C4XFm/NrZELni/QuKxsacuxh/fFQlSv62QIaio
	qmXB0hiSAtZlG34H86ScMOhXnAVvYvwqapRcUQDA3tw7rjXbO3Md6kQiAjY2odTA
	2Solt3JmAhJcbmVQTFaffRNgpQlW9P5VMlTI7xXeQexf4hkAy4p2Qj+DGyIGvvSZ
	AS+6u9KCfXqXs+FA51CUzFtv+M2/0hd+yfKj590gJhi4Woe/fFGvIE+jbSUfP4EF
	jIcecR7H57t6OWXaudPyPdNbFuPQFRhcjx+nyI9kxvPGEhKDgioQ0N23mH0RIwik
	poHdNPeJc4MKzJe4zqX3w==
X-ME-Sender: <xms:dwIrZeA_SnZT0sS34bhltiNLbsZhsj69HK1q8yZ05ygsO68tfhUtp7o>
    <xme:dwIrZYiOdn3dmRke9UonreyJtkrZfbZYMqk0V3rY27O85kCtSxsN949gEEVTQBQXT
    hqJXnCg1-EVF1DaCg>
X-ME-Received: <xmr:dwIrZRk4STwNgL4eIAWdFKV49tp2E3fO96oxbW1bEKEeaSfK1C4tpU7UWAiF_g2_Im41Lcejw-FyvuCVLlDUOUMws_nl-taB7kuBZWaGFoHgm2IE92b1-O2SxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieehgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenuc
    ggtffrrghtthgvrhhnpeetudeiheeguddtgfduveekhfevudeiieetjefhffetiedtgeej
    ieehtdfhjefgteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:dwIrZczEgh3xhW3cnk9aA6YobErDajYFcew-w-MO_uc4QYgFvD9B2g>
    <xmx:dwIrZTTX0J1g8elgYR_KubtP0SoSJC_Sdu-1nHvaKLQ5a1EZ_z_d7Q>
    <xmx:dwIrZXb1GtDuocuLxExNJYOMfSoKseXRxRjSIggpJwKlnwalsMaliA>
    <xmx:dwIrZaId6Ub-e8qXyDLX8_i5FMph1GY-5zP8_vEQwmKISR5fdZoQIw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Oct 2023 17:04:54 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: code@khaugsbakk.name
Cc: git@vger.kernel.org,
	ks1322@gmail.com
Subject: [PATCH] grep: die gracefully when outside repository
Date: Sat, 14 Oct 2023 23:02:38 +0200
Message-ID: <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
In-Reply-To: <6bb48aac-460c-4d7f-9057-40c3df0c807d@app.fastmail.com>
References: <6bb48aac-460c-4d7f-9057-40c3df0c807d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Die gracefully when `git grep --no-index` is run outside of a Git
repository and the path is outside the directory tree.

If you are not in a Git repository and say:

    git grep --no-index search ..

You trigger a `BUG`:

    BUG: environment.c:213: git environment hasn't been setup
    Aborted (core dumped)

Because `..` is a valid path which is treated as a pathspec. Then
`pathspec` figures out that it is not in the current directory tree. The
`BUG` is triggered when `pathspec` tries to advice the user about the path
to the (non-existing) repository.

Reported-by: ks1322 ks1322 <ks1322@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 pathspec.c      |  3 +++
 t/t7810-grep.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 3a3a5724c44..e115832f17a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -468,6 +468,9 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 					   &prefixlen, copyfrom);
 		if (!match) {
 			const char *hint_path = get_git_work_tree();
+			if (!have_git_dir())
+				die(_("'%s' is outside the directory tree"),
+				    copyfrom);
 			if (!hint_path)
 				hint_path = get_git_dir();
 			die(_("%s: '%s' is outside repository at '%s'"), elt,
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 39d6d713ecb..b976f81a166 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1234,6 +1234,19 @@ test_expect_success 'outside of git repository with fallbackToNoIndex' '
 	)
 '
 
+test_expect_success 'outside of git repository with pathspec outside the directory tree' '
+	test_when_finished rm -fr non &&
+	rm -fr non &&
+	mkdir -p non/git/sub &&
+	(
+		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd non/git &&
+		test_expect_code 128 git grep --no-index search .. 2>error &&
+		grep "is outside the directory tree" error
+	)
+'
+
 test_expect_success 'inside git repository but with --no-index' '
 	rm -fr is &&
 	mkdir -p is/git/sub &&

base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
-- 
2.42.0.2.g879ad04204

