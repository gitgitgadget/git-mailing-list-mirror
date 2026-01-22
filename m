Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC34E3792
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097149; cv=none; b=QRKOFljN65tf8fTsfvMUzLdElacY+FpwJQZ4N/bWXtpsXEiiqLCmvwtEo/fsQf0AmMtGVjMjzC6Pedau/x7yZVb5SdqRbC4sQ/nCE4XudScLZu9EqRB6R/DlcqfEpJGEDr06D0IwMRCL/dsPt77UrUGUsf7X27f47OjJDwXRExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097149; c=relaxed/simple;
	bh=eYtNHs80H3g9KCdM/Ix3Nj/luIKhmgamHuATFveRCXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSwfWeJGorW4geSVQVf0/8sbIRHhiTmcGpFQ9/BAY7vvYF2664v8dsAMI1JYsOnbp6saR/prcP1xaUvaU4JKgdHsmjpOUq/T6pWe4e8IxZqnTfmMEyR3d2BZefqmkbkTbdqsX5z9mPl9NxIFv/3ZoyaJq+UwKxZQQDPjhVlIU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGsGK56I; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGsGK56I"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0d52768ccso8684275ad.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097138; x=1769701938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqrii66u60l9tgbdznMouE4wmV4m2pKxZZXTYEzmXZU=;
        b=SGsGK56Ih5VeuhlN/zE8ULpt2Q4bOs1UfECIdup4lv4aMmGO/g/Pf7s2xlUsrvlMgJ
         3Zr3pC89C0lH1jIix3vEGAqJfacA/fwIc49/N6Qh63L3s8bw8yCyTurFO10WrsgHqaEs
         u+iphp7ISjWvSuiIA0rRsxOGIN3FA3WCkSqWx1/ClgdnE2r+SlwmTW2hQH/ksE/gvCVf
         XXNqXPwII+k1N8OA+UQbT7bE6Zc1e6OkjqmZO4lRWpXpKZDtFjsBq8pNLsYAvcihB6JT
         KMvx6nmR67spwhDLWv4HlwebO6lfRLOZeoWg/GnvY+F6nOuM6eMOJanTfYaLPrcil1rv
         ckNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097138; x=1769701938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqrii66u60l9tgbdznMouE4wmV4m2pKxZZXTYEzmXZU=;
        b=ccTnfdJeBRtCjNxTeNwnm6+kd0/z5MKOEHjbRMgni6iGr+Mb/jL7JFQrWlYj795LEO
         H5mWWzvsjYB+ERwzNzdDVKoxeGpQ7c4lZGE8ughcPFoP2AOx/sqgSeVVhqkSj8ZTAsN8
         XYux2JatPBvNZ12bpBtoNtpnt7kc17GVoUEDyHJsvramZBTO4ST0zG3j/8IvlA+mOJbH
         iA9Gu/X6/rYvLa1a00okmaUo5+54KVSTxa5zfbp5xlp1aY5CFdd9nzRThpoFYTlZw2DC
         U8eOIU9/q77TluLnxnaQ6XUqRfThS+2k9Aax9ObzFUKT7+O7VOu10N/RdgVQBFso2t22
         XXfA==
X-Gm-Message-State: AOJu0YxsVHzF/udVvs0M/JWRA/j4dfISX2VKkhsSsl8ry4L3aq7Znzx2
	ZvVydE7up6mYOr/67+Mjpq2BmJ5oXy0/ksSPww86NtQguWgfzDIypBHWKZxdlw==
X-Gm-Gg: AZuq6aKOvF3CbCXKIbqnCQED5FN6NRji3jgHYjKtZ62s1Nc58TVJzLi16qMhU+p+Qr2
	LFX6wQtlydE/5/G9mPhYR4nTcDjt7fXgjZho76J5zd87r7h9xBGwWB394Dy/p3aC2dZ6V06+ulC
	xKjPE7HvXLTMIJvQQMPXC5XDaRmG7HQQD7GJIogSNJ0LCXYiN6Pf9fkfIWUVM71NTfVOkEb9xL3
	q4agschxqW5ixo5MZToAmL8+iJ5BZY4LOP5OKOG2KlZ7dSNofMSc7aee2/duLfrqdUdOnsEgLiM
	FgGcb+ITH3mw8lBkRwb+pPw/tyvkOYfbCyWB3fiMq5ro+Ep/Bb5vzYGFlj9byXmxQghbjXhWsM8
	InqOkYq29xK73UDmzEk9hSuKcv4EJnBW+A8XYdMu1EIqjObyWlGhmf1sIbmxyE8/IZvS3Mzmw41
	+ENNVQGT/DApq3IOuO2v0Qvdwx/LMd8o72
X-Received: by 2002:a17:902:ce8b:b0:29f:301a:f6cf with SMTP id d9443c01a7336-2a7175c30damr196187425ad.35.1769097138425;
        Thu, 22 Jan 2026 07:52:18 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce2ebsm190268605ad.32.2026.01.22.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:52:18 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH] reset: avoid reflog update on no-op reset
Date: Thu, 22 Jan 2026 15:47:45 +0000
Message-ID: <20260122154743.20496-3-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git reset" is invoked with a target that already matches HEAD,
it currently writes a reflog entry even though no reference is updated.

Detect this no-op case and avoid updating ORIG_HEAD and HEAD, skipping
the reflog entry entirely.

Add a regression test to ensure no reflog entry is written for a no-op
reset.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 builtin/reset.c   |  4 ++++
 t/t1410-reflog.sh | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index ed35802af1..900c2f2fe8 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -309,6 +309,10 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 		old_orig = &oid_old_orig;
 	if (!repo_get_oid(the_repository, "HEAD", &oid_orig)) {
 		orig = &oid_orig;
+		if (oideq(orig, oid)) {
+			strbuf_release(&msg);
+			return 0;
+		}
 		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
 		refs_update_ref(get_main_ref_store(the_repository), msg.buf,
 				"ORIG_HEAD", orig, old_orig, 0,
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ce71f9a30a..54f8692c53 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -533,6 +533,21 @@ test_expect_success 'reflog for symref with unborn target can be listed' '
 	)
 '
 
+test_expect_success 'reset does not write reflog entry on no-op' '
+	git init no-op-reset &&
+	(
+		cd no-op-reset &&
+		echo a >file &&
+		git add file &&
+		git commit -m initial &&
+
+		before=$(git reflog | wc -l) &&
+		git reset HEAD &&
+		after=$(git reflog | wc -l) &&
+		test "$before" = "$after"
+	)
+'
+
 test_expect_success 'reflog with invalid object ID can be listed' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.43.0

