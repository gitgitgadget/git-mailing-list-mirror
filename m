Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2BF40DFB4
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258012; cv=none; b=XfphdWZD0BX8sIqpGY+EkSFEr9GQF6RkNz7WED+nhOQKIN6nbtNyZ1qBsPFaB+xPJ9KC1Xhjqybo0K/gD49tNEOSubdFnqv0b+3x0rGfS7TwAyTsepGow+uCSHg6a8+GtBVnA9UObPeolG4eqk9oADEgmZaAqcSMD29M6+gPzZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258012; c=relaxed/simple;
	bh=KagLR7KbQvLzgYWI4al8JmyZHmrtLaRSdvNr/76ZMqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRcxw123z6w2KUqfnRk9raWl/aJ59vKEuLBAhu8zH4KuWCtabLF8O+u8CTBTGR+UDDDkhvmRcYOhXFQHBIpxmkUDnQiYKu87E9w+6qIl3qctjwsSKWDBkLj06P9BySuUYc7QbKT2kONZfahr1zCyt1NZb3+Y2nP2rV4dIt+DVUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHpuxgWy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHpuxgWy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso1699505e9.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258009; x=1773862809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfXZmY5/10IVCOaOVcw4iHlFHDo24WiY/2P6Pv6Q/2w=;
        b=AHpuxgWymyTOI5Rr7bqvvKJ6b1zRTpCaRZMgOZNbg+NIGyvcF5kK+JeJLjaB++rFkn
         g1SE7rfb/N2LMLGxXB2WOObUCDUS5xgIV2UitYA6iVOK+95bE0Cc7n1Xx+qQd/R7QMzg
         HqXqX7qe1e16Qq9DXC+druAIjqHB4F+QKuKIcb9/7MxZZhN+90htUzWk0yzirEORBw3b
         SM9z2vqDch4DVFBG7+Mp6+7NiB+kwLXpAGn3ntxPeMj0A8Rwq4Ts6iRJ5kZGxnagFLbg
         SKWMjzO0JLnDKH18wn0t6jzi0pzebLu/wRuxLHR+ljP6Z5Y6CzpN5OfmB2vpW4b0F/Ih
         bXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258009; x=1773862809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfXZmY5/10IVCOaOVcw4iHlFHDo24WiY/2P6Pv6Q/2w=;
        b=OCec77qjcPZukwmE/zkgbULSYJc9tf3IjpOKKgs6jcATekKK2adxRgiRqksxB13LUK
         tV3N91+DxguHdgAPiIIl/bbE7gvMdTmdcYns8pPyHxBjcL25dSqqUePAFnBhm+93IL1U
         l4WaDHykbQeW4BVAEXHGsxvuWtJlKD808KPQ0HS2patIzbG1lRyzgSIIrQ3ShSJF7GAO
         1oSrk1f9bCcEcV3TCISOmwDoqiI92xnow+K+J0nEidj8vRYOA4klAG2a9UIglVsw9kcr
         XYlSH360H5nhdN1tvpVVdbqaJDOOwGq8cmC3mtgHmU+q85jmsDfJQb9xL7nXifBbr5MV
         F4XA==
X-Gm-Message-State: AOJu0YyvczDUBV85TV//1sVN7GhVcgJX54ONkokcmZUr8UxC+ZR0GXWV
	j5bzpxLY/Ordwt3HOyVz/KYL9HRh255vTYi9RiZXbQ7lnhDLFlnrW3Ajv+Rkl1U6Fkw=
X-Gm-Gg: ATEYQzxoeQA3mjgTwyK4tHoAlwgk4oqtwiEdLU+mx9r9LSRgpRIOl9NFSZzVgQL55tX
	GmlYrbh3WhKB0I5sylaKVIM+vkkQ0qNvvpOHiwt9GJpBAzg4Rmizo9B75fk7iclAktjArHWvISb
	cSZknXA5ioM6GT2cGIRmcuNeObmtEAgT4IOFRqZU0phltqz5ZZ/Lop9S+YI0sFcXnNfFP7YN9c4
	nWX9KJalgD1yPUPRlJzOdOavCzbvwTGfKOjJavFZ3XcowPrAZ4Y2gtMcFN8xdz0SfqkWfVWGmkn
	30DTyJOpKCTtfgKVD3qOzB/kJIQhSJ28driE+ER7DwnTLn1fSGVQO+dLeHa9GcwqpeqCIAqXCDV
	Vd1Y+vzVocVOhlF63AJ0X4pydWYHn0Ef4KrWJNC3qwZ6rECuEz8phv9ZoIRXWod0jk4fffDQnmQ
	lNbxJ3AVOlaV6akkrUsdu5ZgVyG9F/owamwdEIq1h0DK8Ys0yaGDHpsk19KEHmbzvAi5qAJ7oL/
	+R1yZE/cn6mn+S25Z+GyBhjTwd2Iqnow8y1E6RrE/YeOYSkyWg3s/nP+HwpISp6W9zTBQ==
X-Received: by 2002:a05:600c:458e:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-4854b0ac93fmr57252155e9.1.1773258009280;
        Wed, 11 Mar 2026 12:40:09 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe23afc5sm1694775f8f.39.2026.03.11.12.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:40:08 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH] t9200: handle missing CVS with skip_all
Date: Wed, 11 Mar 2026 20:40:02 +0100
Message-ID: <20260311194002.190195-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CVS initialization runs outside a test_expect_success and when it
fails, the error report isn't good.

Wrap CVS initialization in a skip_all check so when CVS initialization
fails, the error report becomes clearer.

Move the Git repo initialization into its own test_expect_success instead
of being in the same CVS check.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/t9200-git-cvsexportcommit.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index a44eabf0d8..cba3b1a28a 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -30,13 +30,17 @@ export CVSROOT CVSWORK GIT_DIR
 
 rm -rf "$CVSROOT" "$CVSWORK"
 
-cvs init &&
-test -d "$CVSROOT" &&
-cvs -Q co -d "$CVSWORK" . &&
-echo >empty &&
-git add empty &&
-git commit -q -a -m "Initial" 2>/dev/null ||
-exit 1
+if ! cvs init || ! test -d "$CVSROOT" || ! cvs -Q co -d "$CVSWORK" .
+then
+	skip_all="cvs repository set-up fails"
+	test_done
+fi
+
+test_expect_success 'git setup' '
+	echo >empty &&
+	git add empty &&
+	git commit -q -a -m Initial
+'
 
 check_entries () {
 	# $1 == directory, $2 == expected
-- 
2.43.0

