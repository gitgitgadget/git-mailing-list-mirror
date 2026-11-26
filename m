Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710376;
	b=upkwjG8akndlFo9JTz/ztpE55voz7kRwL6UBZH6Wbf/70B/ChVnMb0lnlho+LzMMrAHk
	 lWjEDF3VwphK8zIMFT9cBPynz801FGDYVLIlMQYPmLWZaV6R7QiuDseJisDXMpVCXs6Pk
	 FuzVN300Xosfcmj/KnWhwUP0RIJ0bQgcEdUL5+R2G4BoiSnLy3aAv3lOfi5zgmAKXOa5f
	 FisgcTQr7G8YEk62qQnUApkNXl3jBR172b1WFeFUxHMEPjFFIitGg6RkvyWa8VPAm6Or7
	 xilhFBlRkm6mY9ITPKeHKfjgpttLvLIqZt8E9aEAmXSYIbjEy0M2GY04CFbEzG9eVOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=27rJmdIbcjwcY+suinNWagcGcx4130m00I+z9zc+isU=;
	b=wQTZBYMBQYt5EbM2G66nsrrI2bvZ2T/ig2YrxVXm5U3dFwcNqBNNYGnCe0uTh7JCdLSK
	 5WBhSL5B/lalHzdbLYEiZET7xsuZlrukTVjxDLejs8O1C4g1Swlcz6lRU09iHKYJsNkCU
	 +wLcVPP+7o5S9cIIjjMuARJglvxHSxPNrwMtBJv3EE6BD/kp0C5GzDjHgEW812qAaC9r/
	 vKh8BX/Ll+6/y0TTpm27UdtO2sd3mew0P2TF/PeVImXa02eYeo3pNv2DLXNRGfcDEg0hs
	 Mi2HndCKeZi+qu8NPSobh3zObtc98H6aM1wiQ/91k6EO1zcnJu7BKoqkRT2OZwdqtHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l/RHpRFi";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB6C606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 16:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEB6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l/RHpRFi
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so73878105e9.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 08:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710374; x=1796315174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=27rJmdIbcjwcY+suinNWagcGcx4130m00I+z9zc+isU=;
        b=l/RHpRFikpIJMrUWj5BYP6ZRP3Msx5J9HbkC9gxw2IesZdQz3MqoY6RVgjPR74alZA
         z4AXTfuRIRbsda+jUtyVaDIrCRS92KHyD8LbebbY1Z4MVrUWxIqWfCLpSaIMi7FL9TgQ
         1615Xo3ROr/ksjhayEOAC2FgMX9x/lmo6aivQrAxgNW8kMRY0+pm9RCMG/ujuvZWs3wT
         Xy8xkFBhKGo96+RsSQqNOwxWG440WCT1fkja1X81DSKztvS/Ixg6mll9feyigVXuoIvl
         xmRhL31DMYsoMAFaCSWSnRsRZeYJIQcGWrhdJwmCwl2+fED1NLWpdw9aS62q0l/1ma69
         ZJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710374; x=1796315174;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27rJmdIbcjwcY+suinNWagcGcx4130m00I+z9zc+isU=;
        b=vvmcEHE/Ic9l144Yiw/zMb9FHKsAmIUPXeCIPRsWQM9pibPE1RJABgPr+as4uPL6Q9
         twN7DyHi0mS7za4GDalFivd1bokkjrYIFZVXtyvcbJ/lmLrw6eVriud5/dp8ZCgZVgqj
         K9+tRSHplvjrB3BmiCeyU5lGQC3EFWKsc0GdtOSlbN1h0z6uOA1y9R3fKtNHSs0sk8Ps
         /JQ++f5XIqTC1msMjECufeHL47EMDLOb88l/3xrI+OPAgKVICYOeVEriLRa/oRqj90a7
         5SeaEEL0G9DwyQN0v+s4q3uDjwcylNsKZfgZTEFXyzcGotQBQOlTITvsPps0TarW9b6b
         nerw==
X-Gm-Message-State: APuU4Z/aH49LpEOwhNZoNSup7+JyZObL/ugxd7zUrPKf5TbyFxtdMcgj
	xuRPtvE1+wR/6xhw4DnzGCcb8Nh1Tn3bL1A42aw/HbLcJRuSMmVOIqZXAowhhg==
X-Gm-Gg: AZFdTZfq3tLli4UVVtkxlacxSbTH/76qZjnndicK7TC0tYUzkR2iU2TUL1lxpK+7VlB
	EXKc6J57/6RhHoEnRJKXxvXt2RhbesHwTWA6wq8vNmnP1PzBG0G0T3ZRaVFcXajKP+91pK+YAA7
	9xeldSn+5AzCdoUsaCCokCmt6pgyM4Wxth49Ud8e9LIDMIKtgJaMg/Nv/fhBm3xoQ2Z3KC+4UMb
	i0ll1avEg//kd7+Gy8wvANbCfXTqR2noj+e3alzcZAek3PyHWiNEx+0ZdPjlqGlZ99t7r1i6nrh
	8TYXHW3OzXzXt5YhIw+yCpHWbIA4RE575mz6+fCgt5SFEz4ABBS1tabtbYVz+ThZuYPFncUdvnB
	MGhnsE42jNSMQu3t6/+Czi6mVpAoH5izYkJ5P+FShoRKQo+VazrAWf9VYRX+R29MyGkpa713277
	lSh2RMILRfi7bYAlGoJCWD9MsPmrmyboF4fnenJ55k0dxPaJRU40A0+aq4ZI3RhrUPP4bt+H+jI
	n2jtucQVMh6vzK3haNBCTHZAqMvrwe0xV0qEMqco5AvcppAXWhpr0L5vJ10FJxXdS3o4vOvemEV
	7DH210osNWDgEPZKTE0sk/VXDYOejoMt
X-Received: by 2002:a05:600c:4e0c:b0:4bb:875b:f23f with SMTP id 5b1f17b1804b1-4bb88827f0bmr416413785e9.33.1795710373961;
        Thu, 26 Nov 2026 08:26:13 -0800 (PST)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm961842615e9.14.2026.11.26.08.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:26:13 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2] var: add GIT_COMMENT_STRING
Date: Thu, 26 Nov 2026 16:25:52 +0000
Message-ID: <6e310e0af58cf693819a8d7384c1560e2e342d4b.1795710343.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.1.576.g0cfbda1d5c7.dirty
In-Reply-To: <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
References: <fa8b80af26481e0dc96fd8f80f3c7ba84f60f9d4.1795516651.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since commit 9ccf3e9b22 (config: add core.commentString, 2024-03-27)
we have two separate config keys that set the comment string used by git
when creating template commit messages etc. As that commit notes, when
core.commentString is set to a multi-byte string, it can be useful to
keep core.commentChar set to a single character for compatibility with
older versions of git. That makes it awkward for scripts to determine
what the comment string is because they need to do something like

    {
        echo ' #'
        git config --get-regex '^core.comment(char|string)$'
    } | sed -n '$s/^[^ ] //p'

Add GIT_COMMENT_STRING to "git var" to make it easier for scripts to
determine the comment string.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
Changes since V1:
 - Fixed typos in commit message
 - Added a reference to `git var GIT_COMMENT_STRING` to the
   documentation for core.commentString
 - Added a reference to the relevant config keys to the documentation
   for GIT_COMMENT_STRING

base-commit: f7de81456940dd6f3274e461149bba12965de609
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fvar-comment-string%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/f7de81456...6e310e0af
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/var-comment-string/v2

 Documentation/config/core.adoc |  3 ++-
 Documentation/git-var.adoc     |  4 ++++
 builtin/var.c                  |  9 +++++++++
 t/t0007-git-var.sh             | 10 ++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index bdc74d291cc..e348d8895d1 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -549,7 +549,8 @@ core.commentString::
 	Commands such as `commit` and `tag` that let you edit
 	messages consider a line that begins with this character
 	commented, and removes them after the editor returns
-	(default '#').
+	(default '#'). Scripts can query the comment string with
+	"`git var GIT_COMMENT_STRING`".
 +
 ifndef::with-breaking-changes[]
 If set to "auto", `git-commit` will select a character that is not
diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 5f240eb56e3..9c3778b2535 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -130,6 +130,10 @@ endif::git-default-pager[]
     The path to the global (per-user) configuration files, if any.
     This variable can have multiple values.
 
+`GIT_COMMENT_STRING`::
+    The comment string used in template commit messages and rebase todo
+    lists etc. as set by `core.commentString` or `core.commentChar`.
+
 `GIT_HOSTNAME`::
     The hostname of the machine, as reported by the operating system.
     This is the hostname matched by `includeIf "hostname:..."` (see
diff --git a/builtin/var.c b/builtin/var.c
index eb85a985b15..6dc8ec4ba9f 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -188,6 +188,11 @@ static char *hostname(int ident_flag UNUSED)
 	return xstrdup(buf);
 }
 
+static char *comment_string(int ident_flag UNUSED)
+{
+	return xstrdup(comment_line_str);
+}
+
 struct git_var {
 	const char *name;
 	char *(*read)(int);
@@ -262,6 +267,10 @@ static struct git_var git_vars[] = {
 		.name = "GIT_CONFIG_GLOBAL",
 		.multiread = git_config_val_global,
 	},
+	{
+		.name = "GIT_COMMENT_STRING",
+		.read = comment_string,
+	},
 	{
 		.name = "GIT_HOSTNAME",
 		.read = hostname,
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 883a45399e2..f228cb5bb6f 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -434,4 +434,14 @@ test_expect_success 'git var -l lists the identity components' '
 	test_grep "^GIT_COMMITTER_DATE=" actual
 '
 
+test_expect_success 'GIT_COMMENT_STRING' '
+	git var GIT_COMMENT_STRING >actual &&
+	echo "#" >expect &&
+	test_cmp expect actual &&
+	git -c core.commentChar=: -c core.commentString=%% \
+		var GIT_COMMENT_STRING >actual &&
+	echo %%>expect &&
+	test_cmp expect actual
+'
+
 test_done

Range-diff against v1:
1:  fa8b80af264 ! 1:  6e310e0af58 var: add GIT_COMMENT_STRING
    @@ Metadata
      ## Commit message ##
         var: add GIT_COMMENT_STRING
     
    -    Since commit 9ccf3e9b22 (config: add core.commentString, 2024-03-27) we
    -    have two separate config keys that set the comment string used by git
    +    Since commit 9ccf3e9b22 (config: add core.commentString, 2024-03-27)
    +    we have two separate config keys that set the comment string used by git
         when creating template commit messages etc. As that commit notes, when
         core.commentString is set to a multi-byte string, it can be useful to
    -    keep core.commentChar set to a single chararcter for compatibilty with
    +    keep core.commentChar set to a single character for compatibility with
         older versions of git. That makes it awkward for scripts to determine
    -    what the comment chararcter is because they need to do something like
    +    what the comment string is because they need to do something like
     
             {
                 echo ' #'
                 git config --get-regex '^core.comment(char|string)$'
             } | sed -n '$s/^[^ ] //p'
     
         Add GIT_COMMENT_STRING to "git var" to make it easier for scripts to
    -    determine the comment character.
    +    determine the comment string.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    + ## Documentation/config/core.adoc ##
    +@@ Documentation/config/core.adoc: core.commentString::
    + 	Commands such as `commit` and `tag` that let you edit
    + 	messages consider a line that begins with this character
    + 	commented, and removes them after the editor returns
    +-	(default '#').
    ++	(default '#'). Scripts can query the comment string with
    ++	"`git var GIT_COMMENT_STRING`".
    + +
    + ifndef::with-breaking-changes[]
    + If set to "auto", `git-commit` will select a character that is not
    +
      ## Documentation/git-var.adoc ##
     @@ Documentation/git-var.adoc: endif::git-default-pager[]
          The path to the global (per-user) configuration files, if any.
          This variable can have multiple values.
      
     +`GIT_COMMENT_STRING`::
     +    The comment string used in template commit messages and rebase todo
    -+    lists etc.
    ++    lists etc. as set by `core.commentString` or `core.commentChar`.
     +
      `GIT_HOSTNAME`::
          The hostname of the machine, as reported by the operating system.
-- 
2.56.1.576.g0cfbda1d5c7.dirty

