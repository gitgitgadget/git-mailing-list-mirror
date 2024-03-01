Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9323A8E3
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307551; cv=none; b=Ej2RFpQySyryXQ75F6mg5Xu9QmGMfREdLIBjN2Rm+Rg46EnCUYwMuCc+cFpZ4ozdbMnuHTk7T92P+gF/0ODQTVjBakUJfHQFIg1AOI+Rqn0asnDBVLmL+aAS8kejnIFGCMO7YFDMqXQh74BfqOAD5+YZgaI47vweAisK98oNn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307551; c=relaxed/simple;
	bh=66sl6Ii7QwFbmAIxDeMn06GjNUk6YAl3NlG79MJz1DM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mu4QRZahpH/W53Nanmb5Nv01RBhVA21IZm9rKzq1nAwDm9S5cwI6VQvJgSHEoOvAyYZzpEgS9Ua8igSKwktq6TyxAr5jK+oeXtTmUoi/he0Mznw+gNbiJREWFd5xD4GiDOtPedxR5ufeHCa6isPiUVrg+QAK0ZIYyRWwKWFmOAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Xj99v6sQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsTtRgez; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Xj99v6sQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsTtRgez"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 587B61380128;
	Fri,  1 Mar 2024 10:39:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 01 Mar 2024 10:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1709307548; x=
	1709393948; bh=SdJdR4sXXCmKrA6+ko4PFgsBrRDQa9ZvobE9ThBe7VU=; b=X
	j99v6sQAszBlXaQwvH1o830dHrRk/xKRVlpjioxx0+oP5Zl56eKihlUktV2Wo5P1
	nZ7stLzIajGwhQOiuna7Og95KMqaYs5YNhWCSVuTFSC11ZWk8qOdh7wJjmS8WoMv
	j0W/GuEK10Hu5tPdAzFDM9UrTr862luyk+Jo8j+HYWZDcOmnf3qD3pzS7gucFRXI
	rTMrES5Tv6C5FC7xQzsQF5If0ynX7uspHPsLjSTBSZKSWVp+ugD3tBQ2KvEjuIS3
	YpoD/HDyX3PTZLjzevOxjO6FDBXcDHGW27YjZefeFR22FqnYfmK41uXageifrDNp
	NOVreu8p7THu1mrwoKekg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1709307548; x=1709393948; bh=SdJdR4sXXCmKr
	A6+ko4PFgsBrRDQa9ZvobE9ThBe7VU=; b=JsTtRgez5cGnMhIOoHApGwWh+OcQh
	wd94Kbo2u03d2ZLl+3/ip4i3IgnecWDA2Uf5KdSCYd0gfXu3jbzqyO6pBYkDLOaE
	YSOtB80IhDvfxaDCYdQ11cGtlQ67ZJwiqH1VdXud/d9WStF21VOI5v2BsYfJ7vGK
	T16M4pS3WWrwNy7naeX7fspvPr9CY+g/xEH1oxzVK+K/acz+nDD5XK/uS9n48jpR
	Mhx9U3lNYLTpnzr2n6zwKGqnwWGaHfDiugcNYtioKsMBdN3dal+vcJcbQD6EXsb6
	gvdN1BapOjSFUJ5337RUV0axaJ2C19yn5Vxdqi9pJcbqg2gF1kikKEfeQ==
X-ME-Sender: <xms:nPbhZcliXSfIXYXdTwdQ-nFEFr0Dmv65gYuZk7IGvHVce96pN-80pFE>
    <xme:nPbhZb3BxVD6toLBEfcEXbFZprDuekCIuvqL_ZkCkrveEhkS3fbqCqx4-PmPtxb7p
    bKMjWPFryRFUiLpRQ>
X-ME-Received: <xmr:nPbhZaqj34cuwGiv4Ah3PAtiCmWHB2Clj5ukFcnAHsDdyIUJfbi3QNr1TkArAQ_ASnfPQJuozOlmmGtNLkQKJNE0EmP0joOxrIuuhhCSOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrhedugdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertd
    ertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepgfdvhefgff
    ekgfeiheeivdetffelkefhheeitdejhfelhffhkeevudfhleekvdeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgsh
    gsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:nPbhZYnX3lheHcIrtXVwlWlHjfKoje3l0Iakj12KjGb5C40PfBT4OA>
    <xmx:nPbhZa2fFsklli589dD-zESBcI9O2DmjZ8PnjlqY_iQC7GhRdDlr0Q>
    <xmx:nPbhZfsGeqzsj6nlWoyLd1XYvnIIlCiDmvJ_D3vitP_nycOXHH_Vgg>
    <xmx:nPbhZYAV4zwVvbodg82wmhs_eHeLaUjcT49M-1JpTZYjuz-Lm03DVg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Mar 2024 10:39:07 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] branch: advise about ref syntax rules
Date: Fri,  1 Mar 2024 16:38:41 +0100
Message-ID: <d275d1d179b90592ddd7b5da2ae4573b3f7a37b7.1709307442.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.106.g650c15c891b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: d275d1d179b90592ddd7b5da2ae4573b3f7a37b7
Content-Transfer-Encoding: 8bit

git-branch(1) will error out if you give it a bad ref name. But the user
might not understand why or what part of the name is illegal. The man
page for git-check-ref-format(1) contains these rules. Let’s advise
about it since that is not a command that you just happen upon.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Hopefully I am using `advice.h` correctly here.
    
    § git-replace(1)
    
    I did not add a hint for a similar message in `builtin/replace.c`.
    
    `builtin/replace.c` has an error message in `check_ref_valid` for an
    invalid ref name:
    
    ```
    return error(_("'%s' is not a valid ref name"), ref->buf);
    ```
    
    But there doesn’t seem to be a point to placing a hint here.
    
    The preceding calls to `repo_get_oid` will catch both missing refs and
    existing refs with invalid names:
    
    ```
     if (repo_get_oid(r, refname, &object))
    	 return error(_("failed to resolve '%s' as a valid ref"), refname);
    ```
    
    Like for example this:
    
    ```
    $ printf $(git rev-parse @~) > .git/refs/heads/hello..goodbye
    $ git replace @ hello..goodbye
    error: failed to resolve 'hello..goodbye' as a valid ref
    […]
    $ git replace @ non-existing
    error: failed to resolve 'non-existing' as a valid ref
    ```
    
    § Alternatives (to this change)
    
    While working on this I also thought that it might be nice to have a
    man page `gitrefsyntax`. That one could use a lot of the content from
    `man git check-ref-format` verbatim. Then the hint could point towards
    that man page. And it seems that AsciiDoc supports _includes_ which
    means that the rules don’t have to be duplicated between the two man
    pages.

 branch.c          |  7 +++++--
 builtin/branch.c  |  7 +++++--
 t/t3200-branch.sh | 10 ++++++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/branch.c b/branch.c
index 6719a181bd1..1386918c60e 100644
--- a/branch.c
+++ b/branch.c
@@ -370,8 +370,11 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
  */
 int validate_branchname(const char *name, struct strbuf *ref)
 {
-	if (strbuf_check_branch_ref(ref, name))
-		die(_("'%s' is not a valid branch name"), name);
+	if (strbuf_check_branch_ref(ref, name)) {
+		error(_("'%s' is not a valid branch name"), name);
+		advise(_("See `man git check-ref-format`"));
+		exit(1);
+	}
 
 	return ref_exists(ref->buf);
 }
diff --git a/builtin/branch.c b/builtin/branch.c
index cfb63cce5fb..fa81e359157 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -576,8 +576,11 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		 */
 		if (ref_exists(oldref.buf))
 			recovery = 1;
-		else
-			die(_("invalid branch name: '%s'"), oldname);
+		else {
+			error(_("invalid branch name: '%s'"), oldname);
+			advise(_("See `man git check-ref-format`"));
+			exit(1);
+		}
 	}
 
 	for (int i = 0; worktrees[i]; i++) {
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index de7d3014e4f..9400a8baa35 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1725,4 +1725,14 @@ test_expect_success '--track overrides branch.autoSetupMerge' '
 	test_cmp_config "" --default "" branch.foo5.merge
 '
 
+cat <<\EOF >expect
+error: 'foo..bar' is not a valid branch name
+hint: See `man git check-ref-format`
+EOF
+
+test_expect_success 'errors if given a bad branch name' '
+	test_must_fail git branch foo..bar >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.44.0.106.g650c15c891b

