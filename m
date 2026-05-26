Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8C402439
	for <git@vger.kernel.org>; Tue, 26 May 2026 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814060; cv=none; b=e6qe6WIX3HY2OD1GjB0+SAzrVfqwsQ1LInvR1FlhMwLl2zRFQcxvRBP9lZEQ1ouoFjBrwnPxPlrxZ1CzHEYgziPNZT+r0fRxPcmnHxrKGcF0uatSibc5zXWDmGEKHxE1cVoDUhbEtC26jO0cv+s+b2Sqb2DbeyeLsGuMwYOhzBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814060; c=relaxed/simple;
	bh=hsGubLMil1YbPhyMr6MMT1xb2nv+Oz++/qFEh66Ssqk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gSr9LrS3nTfC9u5w+axwVR4JSLRL0rRUaos0XmavfByfb/7PP/Y4nfehfMOFzpDjTnTG5bAGQ7F7F5sFgcSpc9llaBDf8GpE19xGjaZWsCtdkyle6Ak46gx8aao93nNADhtkr1RlQCH4UsJxmLOeb/mj8VzGOgwXXLBPE78657c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLJn0GcI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLJn0GcI"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-914c5898245so274669785a.1
        for <git@vger.kernel.org>; Tue, 26 May 2026 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779814058; x=1780418858; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYv5iy99GI6O8FVTJpNFMPoOu0BsVGhjQ1nfUdZ956I=;
        b=BLJn0GcIqByA5aOcufEPryrrAE1/mPQv9zqyma/5d/BzPx5xQLrkNc6+zGomIHQnuZ
         cuZEYQz3hbCVZXfYBobLlh+HdOu1pEBsxqRWwemnbW2FEja+S1oRJknjP1i1dRoIsq3F
         tSeH78F36UdLOIxYCdvixCmzO8bkBY1uUhBMTgcG93g2KsY0QYC4Rksno8WkG3PNLCEo
         cuP5l9TEcKr5hflhyToydlHy8fUBR13qJmLmLOcz1Hb9ryd/97fLZId7rAe+3GSIQyjD
         3lMUULOUvjKRa726ghHykxqPRHfc7+Dr1tRqDTl4MgRkyc8rld5ftHrgb3syowVl8VHy
         F1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779814058; x=1780418858;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DYv5iy99GI6O8FVTJpNFMPoOu0BsVGhjQ1nfUdZ956I=;
        b=C0o/KRUHy6e1G9xVcLpshgAKA2GOWuWGgvE5+w7ux/uI/GTOx1jr3LdJO3byeC9Fi/
         Uj+I1/sBGzvXhsNI5a4B24KMwEF+OrsAB5NHIzByQqcLDYUUrS/acXXlbBVmNwhnIWRR
         ZI+ocw0+dLqbEqZmS/3oV0SUAqNOnKr3j2Wwh+5XNycU9T684ZWRdor7d8XzhNrZh7d9
         ZpSjgJy2lWRzzgRdtpWBP6VjwbGbdRQukmJbvbunNCMnYlO492SpWpMOPvyqUGJqr7ed
         YYuU4InRhSFZfbAES8CthDuGe3IvL50UWyDVRw+vK4V+ZB1MuSgmQMp7V6Rq4mMpF9h0
         hIEg==
X-Gm-Message-State: AOJu0Yxuydu3XSqmMLa7Hw7Sxw+FbrdJNCoTYuPMKPaEywZplrn354mw
	XnDJBwYoUG5MX4W/qU4eRXoNrfMUKa8s0PKOEUpxcnd0iKTJIwPdtKXki/aQBw==
X-Gm-Gg: Acq92OH4/I5tw/xfgJ9q/h8StMMiREGVKytPF/yetiDDGu3Rt4x/qp+ZxosUX6C6WW2
	aP2EOZP3E9tJQMxsDSMZuqwFjMOJkr9DOm1ajlicAGXSR5GTKSuPNZIVVTJs5l7i3JEViHDupGF
	KCPh/kT4gVHIUTTQCjcmNInnrX4PFaK97IVh4fXOgCbUS2UXb5SULtBFX9ODI90mQfW8la7d5iF
	ebIY6Vn3s9WdO3IM0onwsC+1mEd2u8FaOHbpdhvcC9CVF/fmBZM91J3D36pFfkdlu1aJnnNqHNL
	TS9ZuH7rZqH4sAEsOlcM11Pdt2J2pVpsisuOIUVFKM2Gh7yEq1yKrdLpQFCrh8y9N4J0NTm+l7Z
	sPK9RIvQNbWDxPgD2Lqg7OZ00G9es3nkb+Xd9XL1QuIXdVrV6BWOHN/AlljErGgW/Nd9kLKrwrJ
	zW7WQmip8Cmnoky0WgJWQsTZo=
X-Received: by 2002:a05:620a:4502:b0:8cf:db04:8a1e with SMTP id af79cd13be357-914b48eafd0mr2799203385a.23.1779814058078;
        Tue, 26 May 2026 09:47:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87fc449sm273614685a.35.2026.05.26.09.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:47:37 -0700 (PDT)
Message-Id: <4ed8b58566dbe6f56d09c8e98f155cff4a297cfe.1779814052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
References: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
From: "Evan Haque via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 16:47:31 +0000
Subject: [PATCH 5/5] git-son: add tests
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
Cc: Evan Haque <evanhaque1@gmail.com>,
    Evan Haque <evanhaque1@gmail.com>

From: Evan Haque <evanhaque1@gmail.com>

Add t5151-son.sh with nine test cases covering:

 - basic child repository creation
 - parent remote configuration in the child
 - .gitignore update in the parent
 - initial commit presence in the child
 - failure when the target directory already exists
 - --branch without --inherit is rejected cleanly
 - no leftover directory on validation failure
 - --inherit fetches parent history

Register the test in t/meson.build so the meson build system
discovers and runs it.

Assisted-by: Claude Opus 4.6
Signed-off-by: Evan Haque <evanhaque1@gmail.com>
---
 t/meson.build  |  1 +
 t/t5151-son.sh | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100755 t/t5151-son.sh

diff --git a/t/meson.build b/t/meson.build
index fd955f44ef..523062df66 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -591,6 +591,7 @@ integration_tests = [
   't5004-archive-corner-cases.sh',
   't5100-mailinfo.sh',
   't5150-request-pull.sh',
+  't5151-son.sh',
   't5200-update-server-info.sh',
   't5300-pack-object.sh',
   't5301-sliding-window.sh',
diff --git a/t/t5151-son.sh b/t/t5151-son.sh
new file mode 100755
index 0000000000..826cbbfa66
--- /dev/null
+++ b/t/t5151-son.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='Test git son command.'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup parent repository' '
+	echo "parent content" >file.txt &&
+	git add file.txt &&
+	git commit -m "Initial parent commit"
+'
+
+test_expect_success 'son creates child repository' '
+	git son my-child &&
+	test -d my-child &&
+	test -d my-child/.git
+'
+
+test_expect_success 'son sets parent remote in child' '
+	(
+		cd my-child &&
+		git remote get-url parent
+	)
+'
+
+test_expect_success 'son adds child to parent .gitignore' '
+	grep "my-child/" .gitignore
+'
+
+test_expect_success 'son child has initial commit' '
+	(
+		cd my-child &&
+		test $(git log --oneline | wc -l) -eq 1
+	)
+'
+
+test_expect_success 'son fails if target already exists' '
+	test_must_fail git son my-child
+'
+
+test_expect_success 'son with --branch requires --inherit' '
+	test_must_fail git son --branch main branch-child
+'
+
+test_expect_success 'son with --branch leaves no directory on failure' '
+	! test -e branch-child
+'
+
+test_expect_success 'son with --inherit fetches parent history' '
+	git init --bare "$TRASH_DIRECTORY/parent.git" &&
+	git push "$TRASH_DIRECTORY/parent.git" main &&
+	git remote add origin "file://$TRASH_DIRECTORY/parent.git" &&
+	git son --inherit inherited-child &&
+	(
+		cd inherited-child &&
+		git log --oneline parent/main
+	)
+'
+
+test_done
-- 
gitgitgadget
