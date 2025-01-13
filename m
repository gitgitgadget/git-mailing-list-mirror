Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC1229803
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788424; cv=none; b=qnTu/Zu9UNsuOn90zPMa34WM+npEPKtXoIpKNtm+CJ8fGJS2UdQqcRYbKSbF09p9ZsuJ1B4KhdI5pTyB6fd69qhaavHgMlVSBuBMdFo7vnO5oWnzjbeQjy3wzlYgdmBky8I2mUqdZGAoMK/LNfDysX4up6yn8KiKW90vsjDAWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788424; c=relaxed/simple;
	bh=tA7xEDSHSFPfr9X6z/2wAGJYIpnSgFXqPI2vccl+8mA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o2qUK2xtLhn6aotzrlnZPl5VCGiITwbw6tlYVS8ZYiRGop2Cj2Pi27dECyvUqSTOFy2mXrAFPvzlrbrw5t8hO1IDpHeyjqUUhEvUIX1xxINrZOW01XysV0Z55VEcwRSfG3B6uIVdlKBpc6tFxFkfg2a9FQmBVWMJ+ATYSnTS/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhVioMBz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhVioMBz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361815b96cso32232755e9.1
        for <git@vger.kernel.org>; Mon, 13 Jan 2025 09:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736788420; x=1737393220; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iky9COyblPjCe6Vs9V0YsA85myOvFMxjMFX6DhAQiA=;
        b=ZhVioMBz4LANd0bqIC/l15QW4AJiK88fWRI3WkzQpe+e8+yEaHnP0W+k8VdFivSgYQ
         8cFig8P6STzizLnO8KXJxOjBi9HE7ERAdOcz8z/wJcgApXujHxnxJ9Saqas0hJ6rAyy7
         gejYZqlXOw5bL2goWZILn3c2ebzeP5irER0vm52eqesSz+O9dZZWgxNekNpG/EzzznKe
         vu3XoK5ApO7cIagDwZh00G1Afmy+60cyJo/AEsXlwk3BESJ/QFMNakN5h2fTlly25isU
         m+fndCC2pEJmbRDeSzs1nO2rKrwIrIMnHeNz/16c1sQ/SrHUETXpcWbE8J9Xwyu2X89E
         b+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736788420; x=1737393220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iky9COyblPjCe6Vs9V0YsA85myOvFMxjMFX6DhAQiA=;
        b=WkimFUj0cJ+3KyTDnnKm+JaJzrgPj/jd/sxab+UOwWkZoCuotRNwRGj5d6nYr0osPS
         Fn3WCYKiGs3EX6gJ5MEpdZVpdMeCWWUljSHgGeBy+DnqpquxROTIxQQV3UrWMCIN2eIL
         jQTzaGwhUYzgYls/UkYG85goWZRHVagWshYEkgqFejHzxgocVpkRE7e4iaFii6BsBKTd
         //ESodgght4KzSHgtSYbsVw5SG4BXt3etWSxZiIcy5PkGSPitijtcGR2PJf8/zrGKON0
         udSiG6AogNFPO0fTmuOljYrmjBxOE9olZzr/fgsC+TOmOjAZCN+K/JQ+v8enL6B6B23a
         wStA==
X-Gm-Message-State: AOJu0YwDEfdQrbV7hg+kh+9hcnv1gBo5H6zglihboIu2XnAV5STKAudV
	/tRXaV5de0wm9HnBXXincWpNmY40t9zpjLIgw7zyPqOB1r0lX293Bto9fw==
X-Gm-Gg: ASbGncut+BBjYGNHB4A6BNAR3aTVxuAUqhoEaj7+oV5jfSmDwRFN86kB8MGxyqDiIb6
	BbvuFg9aOnjnJRdbjk3eYzpzf83ksgg9J+drG+Uo94h5dFVnFs+Fx+Y0lESy4sBdGsHyZvkQR1t
	QXbboKVzjm3dAauMP8inbq1Q63Jz/DyAh1GhmKHJapXIkhPjjIdk2QJA+cKyciSdoH7ZIO/YhGb
	AaK+Six9CUz/gcZJSjfijaJtnujIP+Uk66Desnmhmyun8mXT/UK8HL9Xg==
X-Google-Smtp-Source: AGHT+IGjtrAjulp7aQr3MPE78cWJGkkCg1RjncaAz20hMdaFsMrVLBM86l5KuE5U04CQb2reALfC6Q==
X-Received: by 2002:a05:600c:4e46:b0:436:488f:50a with SMTP id 5b1f17b1804b1-436e26be5aemr209765945e9.17.1736788420110;
        Mon, 13 Jan 2025 09:13:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38c880sm12758917f8f.57.2025.01.13.09.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 09:13:39 -0800 (PST)
Message-Id: <19f84dfc9cc33616f3720d740c449b29de8d492e.1736788417.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1844.v3.git.1736788417.gitgitgadget@gmail.com>
References: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
	<pull.1844.v3.git.1736788417.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Jan 2025 17:13:37 +0000
Subject: [PATCH v3 2/2] object-name: be more strict in parsing describe-like
 output
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

From Documentation/revisions.txt:
    '<describeOutput>', e.g. 'v1.7.4.2-679-g3bee7fb'::
      Output from `git describe`; i.e. a closest tag, optionally
      followed by a dash and a number of commits, followed by a dash, a
      'g', and an abbreviated object name.
which means that output of the format
    ${REFNAME}-${INTEGER}-g${HASH}
should parse to fully expanded ${HASH}.  This is fine.  However, we
currently don't validate any of ${REFNAME}-${INTEGER}, we only parse
-g${HASH} and assume the rest is valid.  That is problematic, since it
breaks things like

    git cat-file -p branchname:path/to/file/named/i-gaffed

which, when commit (or tree or blob) affed exists, will not return us
information about the file we are looking for but will instead
erroneously tell us about object affed.

A few additional notes:
  - This is a slight backward incompatibility break, because we used
    to allow ${GARBAGE}-g${HASH} as a way to spell ${HASH}.  However,
    a backward incompatible break is necessary, because there is no
    other way for someone to be more specific and disambiguate that they
    want the blob master:path/to/who-gabbed instead of the object abbed.
  - There is a possibility that check_refname_format() rules change in
    the future.  However, we can only realistically loosen the rules
    for what that function accepts rather than tighten.  If we were to
    tighten the rules, some real world repositories may already have
    refnames that suddenly become unacceptable and we break those
    repositories.  As such, any describe-like syntax of the form
    ${VALID_FOR_A_REFNAME}-${INTEGER}-g${HASH} that is valid with the
    changes in this commit will remain valid in the future.
  - The fact that check_refname_format() rules could loosen in the
    future is probably also an important reason to make this change.  If
    the rules loosen, there might be additional cases within
    ${GARBAGE}-g${HASH} that become ambiguous in the future.  While
    abbreviated hashes can be disambiguated by abbreviating less, it may
    well be that these alternative object names have no way of being
    disambiguated (much like pathnames cannot be).  Accepting all random
    ${GARBAGE} thus makes it difficult for us to allow future
    extensions to object naming.

So, tighten up the parsing to make sure ${REFNAME} and ${INTEGER} are
present in the string, and would be considered a valid ref and
non-negative integer.

Also, add a few tests for git describe using object names of the form
    ${REVISION_NAME}${MODIFIERS}
since an early version of this patch failed on constructs like
    git describe v2.48.0-rc2-161-g6c2274cdbc^0

Reported-by: Gabriel Amaral <gabriel-amaral@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 object-name.c       | 55 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t6120-describe.sh | 24 ++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/object-name.c b/object-name.c
index 8e80841acd3..cb96a0e6161 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1271,6 +1271,58 @@ static int peel_onion(struct repository *r, const char *name, int len,
 	return 0;
 }
 
+/*
+ * Documentation/revisions.txt says:
+ *    '<describeOutput>', e.g. 'v1.7.4.2-679-g3bee7fb'::
+ *      Output from `git describe`; i.e. a closest tag, optionally
+ *      followed by a dash and a number of commits, followed by a dash, a
+ *      'g', and an abbreviated object name.
+ *
+ * which means that the stuff before '-g${HASH}' needs to be a valid
+ * refname, a dash, and a non-negative integer.  This function verifies
+ * that.
+ *
+ * In particular, we do not want to treat
+ *   branchname:path/to/file/named/i-gaffed
+ * as a request for commit affed.
+ *
+ * More generally, we should probably not treat
+ *   'refs/heads/./../.../ ~^:/?*[////\\\&}/busted.lock-g050e0ef6ead'
+ * as a request for object 050e0ef6ead either.
+ *
+ * We are called with name[len] == '-' and name[len+1] == 'g', i.e.
+ * we are verifying ${REFNAME}-{INTEGER} part of the name.
+ */
+static int ref_and_count_parts_valid(const char *name, int len)
+{
+	struct strbuf sb;
+	const char *cp;
+	int flags = REFNAME_ALLOW_ONELEVEL;
+	int ret = 1;
+
+	/* Ensure we have at least one digit */
+	if (!isxdigit(name[len-1]))
+		return 0;
+
+	/* Skip over digits backwards until we get to the dash */
+	for (cp = name + len - 2; name < cp; cp--) {
+		if (*cp == '-')
+			break;
+		if (!isxdigit(*cp))
+			return 0;
+	}
+	/* Ensure we found the leading dash */
+	if (*cp != '-')
+		return 0;
+
+	len = cp - name;
+	strbuf_init(&sb, len);
+	strbuf_add(&sb, name, len);
+	ret = !check_refname_format(sb.buf, flags);
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int get_describe_name(struct repository *r,
 			     const char *name, int len,
 			     struct object_id *oid)
@@ -1284,7 +1336,8 @@ static int get_describe_name(struct repository *r,
 			/* We must be looking at g in "SOMETHING-g"
 			 * for it to be describe output.
 			 */
-			if (ch == 'g' && cp[-1] == '-') {
+			if (ch == 'g' && cp[-1] == '-' &&
+			    ref_and_count_parts_valid(name, cp - 1 - name)) {
 				cp++;
 				len -= cp - name;
 				return get_short_oid(r,
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 3f6160d702b..76843a61691 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -82,11 +82,13 @@ check_describe R-2-gHASH HEAD^^
 check_describe A-3-gHASH HEAD^^2
 check_describe B HEAD^^2^
 check_describe R-1-gHASH HEAD^^^
+check_describe R-1-gHASH R-1-g$(git rev-parse --short HEAD^^)~1
 
 check_describe c-7-gHASH --tags HEAD
 check_describe c-6-gHASH --tags HEAD^
 check_describe e-1-gHASH --tags HEAD^^
 check_describe c-2-gHASH --tags HEAD^^2
+check_describe c-2-gHASH --tags c-2-g$(git rev-parse --short HEAD^^2)^0
 check_describe B --tags HEAD^^2^
 check_describe e --tags HEAD^^^
 check_describe e --tags --exact-match HEAD^^^
@@ -725,4 +727,26 @@ test_expect_success '--exact-match does not show --always fallback' '
 	test_must_fail git describe --exact-match --always
 '
 
+test_expect_success 'avoid being fooled by describe-like filename' '
+	test_when_finished rm out &&
+
+	git rev-parse --short HEAD >out &&
+	FILENAME=filename-g$(cat out) &&
+	touch $FILENAME &&
+	git add $FILENAME &&
+	git commit -m "Add $FILENAME" &&
+
+	git cat-file -t HEAD:$FILENAME >actual &&
+
+	echo blob >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'do not be fooled by invalid describe format ' '
+	test_when_finished rm out &&
+
+	git rev-parse --short HEAD >out &&
+	test_must_fail git cat-file -t "refs/tags/super-invalid/./../...../ ~^:/?*[////\\\\\\&}/busted.lock-42-g"$(cat out)
+'
+
 test_done
-- 
gitgitgadget
