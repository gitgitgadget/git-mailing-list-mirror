Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FD1DFCE
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709492361; cv=none; b=MlqrSlqD8sVxxaRt0T1SPPWVFomH6HZzZLVlZBRezt4chCnNfbLWtJqGPw5/PHkhmWYjn+Y6+zhEgMpDnAfyJGkTauhgbC443TX3UCZ8/lSUjH8cfxySYPqhhQATd2tOGC2y8qyK0wnm06BAdmkf/OZIq7LeyK9JI7nh8b6BGH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709492361; c=relaxed/simple;
	bh=2UV3Q1BTCIQnFf3tN9ZW+M5Y7/CkR8w4wcwLQKLzLyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLqHxW99Cprp4nHNURBT8Yh/FNIF0pnTxvTTZD4zqN0HBeE8bVJ+UszleUeNPmOq5qYA8jz3ZLr6oyD7SeIkYTxBU9OgC96qOc3YP9r18iwx9MD81FXfW2lbpRd0YPzJSvY64k3R+JCNbYJMK6JTujmofIKReC8z/yI/vXb9RMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=YkHr1a+2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CAJilHLS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="YkHr1a+2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CAJilHLS"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0F02E11400DD;
	Sun,  3 Mar 2024 13:59:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 03 Mar 2024 13:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709492358; x=1709578758; bh=xkEoacpabcOyw1DB40rjJ44Ypi3fetlx
	0zRhIEj7XZs=; b=YkHr1a+2hBfCz5ZnZH80zgCcT7pbHBxxFzKiPekNIu+0YX4o
	Z/AeEdR6ZabSnG9jW099l+Yd0NlsxvZVM6H6IKD/S5npe/60x1g5sys9FaGKSKQD
	DkfAQFS2a44RaCEGtlKaVXozuSKlnTyVZRcMdQjPRj4+Cy2799xz8t2jkbKP5QAj
	wwhpoF8X/bxEausUnH6QHDQ9ByO4dUMVJzN5pjH8h/V5H0frm3X71f7IBbpo6A/5
	rwgQCXtSDxZxhwvnz9Fev6mrGk1qaVkGFhDB1GDggZLFGaeuZZXhPLSHBpIMYmTT
	STc8rDE4hVXMpw7zwdzQfQgLQ15CPnWJbGyOSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709492358; x=
	1709578758; bh=xkEoacpabcOyw1DB40rjJ44Ypi3fetlx0zRhIEj7XZs=; b=C
	AJilHLSTXhTsIPDfERwP4hMoVhLjNmAA2O6n+Ts9sUghtbNj6khmwiZgN8+/nL1L
	LqcB7o/uL0ObzNYAMbKgvD4YGCHY9JW7gB6UEfwf1umD49k8SAJQEah8/5AlfRBM
	1foGTMNw2xWV5C5Ge2cMXqXYAA/IZRVBUMQOiwoG5+wuNP4vhQ6XLugzFq43DtF0
	NsQ+2BH03rh+4lVrGHJjr45NOvyiHxV17wooYZCXfVnl2oialEFD2bfe8llll2e+
	DO1AAjBHMABUCWAOKGgV0N929u98rzxulhTWLCiJ45slsA1T20QGAtlpMxQ35XwR
	H4x2I//gXgVnhih69vLDA==
X-ME-Sender: <xms:hcjkZatje0qRIyyPzXtr3CGOc6z06vdSPoSLwKPQ9DYh-5ohuvq0j6c>
    <xme:hcjkZfctrwW0oDl-9s3EnnvcCN0TDd7sw2AbIih9w684dTHri5JlAx90hVu-PhdF8
    TEmQwHoSATixMxK_g>
X-ME-Received: <xmr:hcjkZVzU9leeFYsUUJrT8wUlNDcNEMg2UpMOBzHR25jXQlWNNbjBvxPwRw5gc3C0_EeB8ECukz2o4qj5jcKuXRV-KAwZwDZv5sPMTbVRGgfV0WflVlFsif4Xmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheehgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceo
    tghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeevgf
    elveeikeegjeeikeeuvefhleeiuddvleegfeekjedtkeevtdetgfffveettdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:hcjkZVN_lgjfQ6FxrcOX0i4w1KSYw-wK-ix3k_LTjuI5VMlCrOsvwg>
    <xmx:hcjkZa-MQHX5m0YOtVu2qWnlFRHh0XUh3XH6-jqKwZDUanlquvs1bw>
    <xmx:hcjkZdW8G9-b5zIRwrweMMbiT5UlQZiDD5DAs55w_3du9bxzfkhbKg>
    <xmx:hsjkZcLgyPeSNzmYqGXq-jblaV2c7QgjnjPR3K9bXgszms_WNRax_w>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Mar 2024 13:59:16 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 1/1] branch: advise about ref syntax rules
Date: Sun,  3 Mar 2024 19:58:21 +0100
Message-ID: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709491818.git.code@khaugsbakk.name>
References: <d275d1d179b90592ddd7b5da2ae4573b3f7a37b7.1709307442.git.code@khaugsbakk.name> <cover.1709491818.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 4ad5d4190649dcb5f26c73a6f15ab731891b9dfd
X-Previous-Commits: d275d1d179b90592ddd7b5da2ae4573b3f7a37b7
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
    v2:
    • Make the advise optional via configuration
    • Propagate error properly with `die_message(…)` instead of `exit(1)`
    • Flesh out commit message a bit

 Documentation/config/advice.txt |  3 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 branch.c                        |  8 ++++++--
 builtin/branch.c                |  8 ++++++--
 t/t3200-branch.sh               | 11 +++++++++++
 6 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c7ea70f2e2e..552cfbcd48c 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -94,6 +94,9 @@ advice.*::
 		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
 		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
 		simultaneously.
+	refSyntax::
+		Point the user towards the ref syntax documentation if
+		they give an invalid ref name.
 	resetNoRefresh::
 		Advice to consider using the `--no-refresh` option to
 		linkgit:git-reset[1] when the command takes more than 2 seconds
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
index de7d3014e4f..d21fdf09c90 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1725,4 +1725,15 @@ test_expect_success '--track overrides branch.autoSetupMerge' '
 	test_cmp_config "" --default "" branch.foo5.merge
 '
 
+cat <<\EOF >expect
+fatal: 'foo..bar' is not a valid branch name
+hint: See `man git check-ref-format`
+hint: Disable this message with "git config advice.refSyntax false"
+EOF
+
+test_expect_success 'errors if given a bad branch name' '
+	test_must_fail git branch foo..bar >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.44.0.64.g52b67adbeb2

