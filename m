Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964AF12BE98
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670673; cv=none; b=uICzfrCYT4dUcWOctBX5AAhvGxud0qx129mqGbego2Ue4MxKvi+Hvq4e/XZWRJx68Tac6DFFIyKUMR9/Fx0paXLjCU+EsbdybwILAWmdKPgLc7BV/WLu9seEaoeh/6y5o9yF6GwgdyO3gygcZxSsUfG3djnZTRKBekR2H99TLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670673; c=relaxed/simple;
	bh=CAu2Cznz8dj54jHCkSOS5VkPWVqfpjEDPFniAcMcTOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKYqpog7871kk/fhtrJyxS337TO98dFAx1xJbNhLTl83gjRsR9AVNX41rZP2hjo6Vr10f5a22DbkkYA0OAi3sKxKE2t/1ORC7r2i75oG4G4YxyPEhGOeiMaPBhpwVfhbY5f/CF2jkfFayxg+51G9tPcyyhmFtyelS+6g4h62Has=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=01wC+cSJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AW0mSPmZ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="01wC+cSJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AW0mSPmZ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 23E4F11401B3;
	Tue,  5 Mar 2024 15:31:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 05 Mar 2024 15:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709670670; x=1709757070; bh=E4kE6309FcVAHRwre8io7X/pNfglQE+5
	qkNyheEtu/I=; b=01wC+cSJwKK0n6Y9te/fGY7uhWtCUhqU6zAraTvUJAfaAawZ
	ezf6g8xaiWaFAp/9kYmu9j3E3Xgzkt6hE5RE+PIF2I9eJ7n5/sd/kWYbjWFa7heh
	ebCvnWat0HWKhp0//g40J205APrO+TR4yhqzXg8bGJi0FbOaK8I5zS283k6tEf7y
	K4m/Le1eJ9/8oFicRMij42bMge6S6iv1i3ASdTv145QxZVF1Qc+V+mFSju+LN0aS
	39OeNfulpHGBDkcBBbIFy7sJ1hv+pWE1Dv6IurGqaL1UsLcIPhgzHAE9idNgRHrl
	bEz9+1gGPlAYWOFU23V6rKk5W840GhELJ1t3LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709670670; x=
	1709757070; bh=E4kE6309FcVAHRwre8io7X/pNfglQE+5qkNyheEtu/I=; b=A
	W0mSPmZ2jmY+/+WfSPvgrsWh0w+JkawVOb7fNftfEye3YLdTVhnsDtrgZhkAqfGq
	3BhBQBJ2WHNowe3HN8+Jyt6vdP2Pm/dYv+wKmh0ie4F0WD3DPE1lZgUfVMhmI1GM
	rJQHCWSAOR1b3Az93v+s2YwC63KzsFEm0SrDriloVwO3nMgdgGxreYUYZ0StY4kE
	kmIacLxABT28nhmsUZdVjIUAmd8Q3qF4CWCI0U9HAKS1m69/zLNRH5wl4GaDZvIW
	a1JlFxvMhYfKxu+Woo2hBvvIic0NWXf0BjKJ4dIS46yo5t5Rsh/NRZjSPvyBccNx
	H74RgmRU/swLcKrQVevRQ==
X-ME-Sender: <xms:DYHnZbex9D5D0OoKSKWpM_CqUQjc8Ti63OFY9Is17OTkBkir2e25dpE>
    <xme:DYHnZRMxhHQol_mOe6DTVz8tv0izdKSGJ2ANoAK5X1TFbtmmPioQcZJp7DYFBMpje
    F5F9rT8LMJN-Xf8Dg>
X-ME-Received: <xmr:DYHnZUhPRA_3ZUO1fKJGAm2S-8vBQ_pYZ-vRwAS42J_n3IiXN4uV62KL-rgMx7eG3sNUJB8-wvXBZ-Mj-zbqKelXJ_3JJVnGiP8cRTGW1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:DoHnZc_dk6qwsVFoTwzKj7y7st2cmGauVXGSRtBw9GUx33ZxJsJjNg>
    <xmx:DoHnZXsvVbPPiKDKA7DtCR7911rDCHOUDxLvCkkoMpQHIKLBAizaiw>
    <xmx:DoHnZbFVONSRbqtTPZZSamRPy1sFDsHjHVgx-xKOlVlDbBThLLemoQ>
    <xmx:DoHnZQ6RCgXQWOcupwJKr8MWBxmkik4QcdBqAg986QI5hxuaqpI_vw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Mar 2024 15:31:08 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v4 5/5] branch: advise about ref syntax rules
Date: Tue,  5 Mar 2024 21:29:43 +0100
Message-ID: <97b53c04894578b23d0c650f69885f734699afc7.1709670287.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709670287.git.code@khaugsbakk.name>
References: <cover.1709590037.git.code@khaugsbakk.name> <cover.1709670287.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 97b53c04894578b23d0c650f69885f734699afc7
X-Previous-Commits: 4ad5d4190649dcb5f26c73a6f15ab731891b9dfd d275d1d179b90592ddd7b5da2ae4573b3f7a37b7 402b7937951073466bf4527caffd38175391c7da
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
    v4:
    • Update refSyntax entry for consistency with the rest of the entries
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
index dd52041bc94..06c754899c5 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -94,6 +94,9 @@ advice.*::
 		`pushNonFFCurrent`, `pushNonFFMatching`, `pushAlreadyExists`,
 		`pushFetchFirst`, `pushNeedsForce`, and `pushRefNeedsUpdate`
 		simultaneously.
+	refSyntax::
+		Shown when the user provides an illegal ref name, to
+		tell the user about the ref syntax documentation.
 	resetNoRefresh::
 		Shown when linkgit:git-reset[1] takes more than 2
 		seconds to refresh the index after reset, to tell the user
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
index 060b27097e8..dd7525d1b8c 100755
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

