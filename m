Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B487E11D
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590117; cv=none; b=MMWw5HUYK9eKOcMXEf06295bKDZ15toBqSTTw3tIjJC2lSNcfDXx+7ItPs0vgJTHzNHy/2TFpAom0BwG/chiMhnlQm5AQB4y7FmXg1FNSBGYXtJbTUGKbRshRCTZkEWYnsmEgaAbSEu/qvK4Cm4NwONsRi6oUx/U0YAYVbguUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590117; c=relaxed/simple;
	bh=HnbXe2UVLy6qJAiR0tFF/Hh75W/26mzREOjkWr0Q/qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEQHwb9CHJOjX56MaJrXiYihhwRu7MM4yziq1ng2dkYKeHoJbCGL3B21xDQcq3mvveEhDinurtYlrTq5ZpFyN/xT7RivLJDEvJUvHxeIFcCWd7/kJj+AthI6vBX45t6S9+OnTb55cggKv2nHgH1toX6ix0cj8fWFgpN6KgEFhAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=0fu+AcGq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r/E8SA5e; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="0fu+AcGq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r/E8SA5e"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id ED33413800DB;
	Mon,  4 Mar 2024 17:08:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 17:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709590114; x=1709676514; bh=F0BXsr6dHsAh5t9TealuDWJRv6Ozc+VU
	M9yjSOg0dG4=; b=0fu+AcGqV/DGg68FmkINuhW6LRjd9OfZh9xg/yyYWpgxDQi2
	clo1n7puk1HlVJaJegA6Wdak7zCKxC5IADp2MDE6iH3GSd+PIlFLdGwQXLmmV1fT
	lp++tOj9GxiQR4Qm1Exk3VF436lF0CvVwmwU8gj8TOKCgBKa1rZucAAel5t8bGsb
	7N4QEg3tonc0HLAGOuwMr5sZOcpLa3U6OP5L7sTtS6sMGp/yr+WAiWYIUo/CuWJA
	PjEIbel06KWzqVAfne3DoZS40B/J4op2K110O4W2D4ty3bsAuqN5nVN9OyN7ZNaQ
	g143JOlTq9M2JGA9WpKqAPsLiitayBqzuncKXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709590114; x=
	1709676514; bh=F0BXsr6dHsAh5t9TealuDWJRv6Ozc+VUM9yjSOg0dG4=; b=r
	/E8SA5eSzoiBX8RNKMwGEQL2VGpBY6oWaJLu8KizRZruy6hS5Cke/iUaX/BKX/9B
	PGSDU54WsBMyvyY5A/jgAWu27+vy4LFeGs9l/nw3kz5Gws322DSSlBNgZb+nSiux
	lkMKTZ1DENZgI/YQKNy5ZnlHv5pqAJDPWfFOdKpUlSgueNquAzYp2hK9CKXi53Eg
	G7TtcmXnHZLwmXcCQ6LJmd6OPjUIVkrFmAKIVGatqqR/4Q3aJBlUZHjCZCL6LvZz
	UtVAl3oAvm2w9AHbK5UfJKSLfgSLNIB6K5BctGTT7xCxogZAaO5raPPAYAdE04oU
	Y5OtDoSm+lLnCYF4qYL5Q==
X-ME-Sender: <xms:YkbmZWkpZjP20SjN9Iw90WlvTl18mLYn64d1ZDq6mKdoNB_IXReLUyM>
    <xme:YkbmZd0Tdi6M6L-_v5uoG89O2ivcHTcdDLe4PR-xCzZjs_YLCPhc823oDvxb6hZdC
    UdkjbjBvFXo9p0V9A>
X-ME-Received: <xmr:YkbmZUpbO8s_RBTCK2ufg18BgQdWBOVT6nRiXIPkZlEAuZKQrphNHJVL1jmpqkeipQSNstVYU1a0CG4ZL9pa5RWkSECU7XYmyW_duBufa0oDv-6fQiMePRvFow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:YkbmZanGZXWx-KFRHGFf3YPzRnW2KygZBFr7gmqhPiQARFTwKioCJw>
    <xmx:YkbmZU0w4VrBrKkDaEkYZjWpD1iK3VqEM6igybD4cvGWvBNOf8T1EQ>
    <xmx:YkbmZRtbKdGDMXZCMisE_PWYXLR6PCqmzP1pDTuDC3GwwrR77rLPig>
    <xmx:YkbmZSAa8x4oks2BbWF42e0fXXmGCQNYT6FSKI2W212OUiF_V_eNQA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 17:08:33 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 5/5] branch: advise about ref syntax rules
Date: Mon,  4 Mar 2024 23:07:30 +0100
Message-ID: <402b7937951073466bf4527caffd38175391c7da.1709590037.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709590037.git.code@khaugsbakk.name>
References: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name> <cover.1709590037.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 402b7937951073466bf4527caffd38175391c7da
X-Previous-Commits: 4ad5d4190649dcb5f26c73a6f15ab731891b9dfd d275d1d179b90592ddd7b5da2ae4573b3f7a37b7
Content-Transfer-Encoding: 8bit

git-branch(1) will error out if you give it a bad ref name. But the user
might not understand why or what part of the name is illegal.

The user might know that there are some limitations based on the *loose
ref* format (filenames), but there are also further rules for
easier integration with shell-based tools, pathname expansion, and
playing well with reference name expressions.

The man page for git-check-ref-format(1) contains these rules. Let’s
advise about it since that is not a command that you just happen
upon. Also make this advise configurable since you might not want to be
reminded every time you make a little typo.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Tweak advice doc for the new entry
    • Better test style
    v2:
    • Make the advise optional via configuration
    • Propagate error properly with `die_message(…)` instead of `exit(1)`
    • Flesh out commit message a bit

 Documentation/config/advice.txt |  3 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 branch.c                        |  8 ++++++--
 builtin/branch.c                |  8 ++++++--
 t/t3200-branch.sh               | 10 ++++++++++
 6 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c5d3d6790a5..06a3a3cc9b5 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -94,6 +94,9 @@ advice.*::
 		`pushNonFFCurrent`, `pushNonFFMatching`, `pushAlreadyExists`,
 		`pushFetchFirst`, `pushNeedsForce`, and `pushRefNeedsUpdate`
 		simultaneously.
+	refSyntax::
+		Shown when the user provides an illegal ref name: point
+		towards the ref syntax documentation.
 	resetNoRefresh::
 		Shown when linkgit:git-reset[1] takes more than 2
 		seconds to refresh the index after reset: tell the user
diff --git a/advice.c b/advice.c
index 6e9098ff089..550c2968908 100644
--- a/advice.c
+++ b/advice.c
@@ -68,6 +68,7 @@ static struct {
 	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName" },
 	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected" },
 	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward" }, /* backwards compatibility */
+	[ADVICE_REF_SYNTAX]				= { "refSyntax" },
 	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh" },
 	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict" },
 	[ADVICE_RM_HINTS]				= { "rmHints" },
diff --git a/advice.h b/advice.h
index 9d4f49ae38b..d15fe2351ab 100644
--- a/advice.h
+++ b/advice.h
@@ -36,6 +36,7 @@ enum advice_type {
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
 	ADVICE_PUSH_UPDATE_REJECTED,
 	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
+	ADVICE_REF_SYNTAX,
 	ADVICE_RESET_NO_REFRESH_WARNING,
 	ADVICE_RESOLVE_CONFLICT,
 	ADVICE_RM_HINTS,
diff --git a/branch.c b/branch.c
index 6719a181bd1..621019fcf4b 100644
--- a/branch.c
+++ b/branch.c
@@ -370,8 +370,12 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
  */
 int validate_branchname(const char *name, struct strbuf *ref)
 {
-	if (strbuf_check_branch_ref(ref, name))
-		die(_("'%s' is not a valid branch name"), name);
+	if (strbuf_check_branch_ref(ref, name)) {
+		int code = die_message(_("'%s' is not a valid branch name"), name);
+		advise_if_enabled(ADVICE_REF_SYNTAX,
+				  _("See `man git check-ref-format`"));
+		exit(code);
+	}
 
 	return ref_exists(ref->buf);
 }
diff --git a/builtin/branch.c b/builtin/branch.c
index cfb63cce5fb..1c122ee8a7b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -576,8 +576,12 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		 */
 		if (ref_exists(oldref.buf))
 			recovery = 1;
-		else
-			die(_("invalid branch name: '%s'"), oldname);
+		else {
+			int code = die_message(_("invalid branch name: '%s'"), oldname);
+			advise_if_enabled(ADVICE_REF_SYNTAX,
+					  _("See `man git check-ref-format`"));
+			exit(code);
+		}
 	}
 
 	for (int i = 0; worktrees[i]; i++) {
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 273a57a72d8..30a97e3776e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1722,4 +1722,14 @@ test_expect_success '--track overrides branch.autoSetupMerge' '
 	test_cmp_config "" --default "" branch.foo5.merge
 '
 
+test_expect_success 'errors if given a bad branch name' '
+	cat <<-\EOF >expect &&
+	fatal: '\''foo..bar'\'' is not a valid branch name
+	hint: See `man git check-ref-format`
+	hint: Disable this message with "git config advice.refSyntax false"
+	EOF
+	test_must_fail git branch foo..bar >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.44.0.64.g52b67adbeb2

