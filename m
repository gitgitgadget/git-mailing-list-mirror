Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB44C042A
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001250; cv=none; b=KkskETCPktjElLtmiMC9cQAVOl7azZCyDWJqxyUTd8ZxR3jCQqlNP5A4FdvHrmgS/CIptBc+OBGUwJTVMkFa4k1i2IamD4xTGkTpk7rXyIO41lfcs1DtztbB5iuiCARjMNEGU0EhQVSSsUYN0g8wQqQ66bWiGWbIBV/E2OTHMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001250; c=relaxed/simple;
	bh=+daoOnC56RWD95KQ3aSWjhUpipUQY9pkzs93GQoERcE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qVp6cQ8bvwNCgcwX4uWYjtHRQMHxYw+pz4D8oyxlwb2P0NdjfJfR/TWRjeDHmigEyZEgKuTyws/k8TErOZZ7czAgN58fo2yK6ly84ePLD28ouk2ICobQgVmILAlgUwlL+j2jmpOKO+WloyIBRy+Lj/AI6pWcRHR1nBnY2GqAm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=tQNPKV3N; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="tQNPKV3N"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3810e733d85so153463a91.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1783001246; x=1783606046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLUZLWjhFgoDaauov4lhokjOl1Fh0zg+N5tSXyIW/VA=;
        b=tQNPKV3NhU8DJ/rk+OAh5DAASDNZTAHEJCw+U+rNo6/ROLmr3I3VvjKWFqRxWWszFW
         pccy/1Sn1KFYWUOs2ECdNHDPHy6d8iNPSECcyPBcZjfpB4hgGR5R3G96TsETrHn9vIFC
         Lcq9MNo0PcBLJ/Sr6tpX0giTkzT1fyIelUzQACkdGW4YAimK01nVD53H2P2UZeOprXFh
         kYK2fK+4Mn3fJnCUyHsvLXI015NTnSG5Fu31GfM9sBdCZN/6yV7jomzYYsFipzH2XZk8
         +TDLnH6fVciINmuKXrMdNKLr1hewom/iNOoS8Lgh2e3oWhapcZHmaVfYwdNRE7WBrYr/
         P3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783001246; x=1783606046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLUZLWjhFgoDaauov4lhokjOl1Fh0zg+N5tSXyIW/VA=;
        b=XUaTHl3kC6UEvYHOVOvwixzkgGd/pZI3/WmArQYBIXd01pNky+1Jms5A4AJmSgn377
         uwjV5DDPlHmhoCo+sTgnDsjMtczlAgNzH8DNZoYxribMSKoxxa3bynYAvohPCqe7vCJn
         0F2kB3immP+ZFiBNwoVlMMB0iS9wHoAo6V/j8WacukwsUozyNeqiutlXqUelr0CAReRf
         RrB9GkHQQgHVl2G0kz8kBOtPp0zMfdFDZlYySf0LVmc3MdYBqBr5TKz4ocPdqQJeChQn
         ZsHMe8IxOEBglAJf18id8DIhE9aGuXHKwC3mKghUA3zQyyAw41KmdKjtbUJs8hVdCgch
         p8aA==
X-Gm-Message-State: AOJu0YxqDEIU/zorYYuesASOw9MUZbrA0SwfneCJbxsOMilQ9I4obGim
	xEzYX2btHqC5Z7Koc3/tEFh8LIO+2rCFKgVRfxHgEHb961NtJKNdlljD3pc+i859eEAsLiMBgVk
	WgspK7pr9Pg==
X-Gm-Gg: AfdE7cmQwAWYL6EoZ97UD7BDrAhcVYvVhszajlK4xpHIVoVMb3pkPIWlkMv2uJasWyw
	CKzA+ZQ2cSVurSGQFChbRPi7OWUbR1fEG8YAmeljicKjNXhY9eiWljy0cRu25Hn3JdEGgYHCqrw
	c1XOBuXr7xi9KHnR5xyFhJv2HCQJgMlVXkUIxgasN5m899kiLpA8hdaJTMblK4gHeIjARnC2Py/
	mBi2+HJAkpgxYRrh9huAeo6j11byAXUThTkLW7YuTrY1px1WgqeDg/dGD0oOVBX2Jjm+N6uJodI
	eJJYBlCmlAytwgL/+2EpQCygMZG9r/gtIsrM/vNuL7TctsoZ1qGTTQ9xbgKImN4PJbypZ890GCc
	j/tGjUoylXD3ztaG7jjA8aHUncl21SsJDctg84eeNdGMFRQdsp9/hBGm45rpQKil5IAmu/G/d5f
	IIbYNYsrJHZ/V/oseHDeDinWY20As30zM82S2hDmQUanP/0f/ALYVVWMUNTtvzDv1/KDoBCUxZP
	CI=
X-Received: by 2002:a17:90b:564f:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-380aa0f47aamr6612073a91.8.1783001246226;
        Thu, 02 Jul 2026 07:07:26 -0700 (PDT)
Received: from avocado.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b9a1bsm10020636eec.3.2026.07.02.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:07:25 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: git@vger.kernel.org
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	Vinicius Lira de Freitas <vinilira@usp.br>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t9811: replace 'test -f' and '! test -f' with 'test_path_*'
Date: Thu,  2 Jul 2026 11:07:04 -0300
Message-Id: <20260702140704.65805-1-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the basic shell commands 'test -f', with more modern test
helpers 'test_path_is_file' and 'test_path_is_missing'.

Co-authored-by: Vinicius Lira de Freitas <vinilira@usp.br>
Signed-off-by: Vinicius Lira de Freitas <vinilira@usp.br>
Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
---
 t/t9811-git-p4-label-import.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 7614dfbd95..93d6b4c479 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -62,9 +62,9 @@ test_expect_success 'basic p4 labels' '
 
 		cd main &&
 		git checkout TAG_F1_ONLY &&
-		! test -f f2 &&
+		test_path_is_missing f2 &&
 		git checkout TAG_WITH\$_SHELL_CHAR &&
-		test -f f1 && test -f f2 && test -f file_with_\$metachar &&
+		test_path_is_file f1 && test_path_is_file f2 && test_path_is_file file_with_\$metachar &&
 
 		git show TAG_LONG_LABEL | grep -q "A Label second line"
 	)
@@ -102,11 +102,11 @@ test_expect_success 'two labels on the same changelist' '
 
 		git checkout TAG_F1_1 &&
 		ls &&
-		test -f f1 &&
+		test_path_is_file f1 &&
 
 		git checkout TAG_F1_2 &&
 		ls &&
-		test -f f1
+		test_path_is_file f1
 	)
 '
 
@@ -135,9 +135,9 @@ test_expect_success 'export git tags to p4' '
 		p4 labels ... | grep LIGHTWEIGHT_TAG &&
 		p4 label -o GIT_TAG_1 | grep "tag created in git:xyzzy" &&
 		p4 sync ...@GIT_TAG_1 &&
-		! test -f main/f10 &&
+		test_path_is_missing main/f10 &&
 		p4 sync ...@GIT_TAG_2 &&
-		test -f main/f10
+		test_path_is_file main/f10
 	)
 '
 
@@ -168,9 +168,9 @@ test_expect_success 'export git tags to p4 with deletion' '
 		cd "$cli" &&
 		p4 sync ... &&
 		p4 sync ...@GIT_TAG_ON_DELETED &&
-		test -f main/deleted_file &&
+		test_path_is_file main/deleted_file &&
 		p4 sync ...@GIT_TAG_AFTER_DELETION &&
-		! test -f main/deleted_file &&
+		test_path_is_missing main/deleted_file &&
 		echo "checking label contents" &&
 		p4 label -o GIT_TAG_ON_DELETED | grep "tag on deleted file"
 	)

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.34.1

