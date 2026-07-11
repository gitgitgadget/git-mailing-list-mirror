Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F329992A
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785927; cv=none; b=EcpgjfFcH9h6XaPvRe37aNfVg12T1DdwHVvcnmtDG+YZHoUOrpW9iMrE796PDoi+K6xV1MD9xUNBVA0a5LTJR5an54gVyh+3G99jLEnQntsg7CLC7pXwcPjIF75ieZjBdzugW7GGQWfnXlMKlx6xsb3WxGg6DyTnbBpTEhm5ZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785927; c=relaxed/simple;
	bh=0slPbYyI+e8a/D6kPVCdgWgd3tgKc0+d5dH66nGKqwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVxIEIaYFvnO11AXVPxP4js9UnfDkkmmV+7SvO16twys8Yw5bH7lCBveKrYwzGK4+rVRk8kPgvAYUXxjZ0Hoqz7Xj1nLN33Q927xBS30JvhntMXNaOkrRnwhD+ORSdXFtxDJ5f9V6mRgItdT3dFGI9VYF91HvMIPQUPEA6diGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=EEp97i/1; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="EEp97i/1"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80e2cfe6918so21146977b3.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1783785924; x=1784390724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ecaVDx6/8nD+mRa4665fAbdEcqeUvln9SwlqOSmOgLg=;
        b=EEp97i/1ERm00QdzfgXQ0Gn+GAHNMjH8Ssg8tQIWj1gEqFfntNdxs6kvGzuzsDnaYw
         /BgpROUzJXdn5f73NRC8cQjelCWc3hX9I5GXKNm+Tzo0/0pMPcWvShJ0JlUJCErXkXi8
         CO5xrocw8IJnNxIDfbhb409iZrz3ByKp50zRghUbRZ4U4eVjXlZQYl/cSgFMUXw3bwMB
         a0SI3PWIkCAjOQZLuT0taVKiuWfeNvZ+WHOqaIHtVhB5i2yBXAC3sIwzPwgBSNTGz5AB
         QQ67+GA63kvYjfpMzmhWf6rnFt5nUIdu904IgPWPBHBDM8MUFnenbl+8FxE+66omwxYn
         TsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785924; x=1784390724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ecaVDx6/8nD+mRa4665fAbdEcqeUvln9SwlqOSmOgLg=;
        b=L3LLMy5/MkpwLy9L3d01OsKtNy1pqiK5cmGln+4pxLijzGFedSfntKR6ri9gLZVl1i
         28IeFMUWMeqFnDVSdrXzrFVgZFI1R7uR17t+rJKcpHx7UNf819tpv39H4quxQIgmjuOg
         gI5gbV2OCqoAykDCo7XET2Vyg1JIcSc1FrW4l4QisGMXEtH05ekC8YtL61StN5yWQEvN
         KgxocPpZT6v/iT9AKgl66yVh7luD5hOKRX4iM7pl3rD8hWUlEZjymwlKonRILIVswwJ9
         I0igyR956WhcRVjgh19JZmIWtHb0z51yVIZzZ/xJESn3aizOJ3ZwFhKtC9oRw8Aft381
         RuhQ==
X-Gm-Message-State: AOJu0YwHCOa475wdNgishnpBNeFgE43MYEdmJHnrdnymILTWZ7NYuiLo
	MWHTBH8SJhcuLls7UPJtWHMVr3vFVhUIeBIngyJNxIlGd+iIFD4psUD7T7Y95RNaTCejJ+zXWuk
	EOjN3krw=
X-Gm-Gg: AfdE7ck4Mt9c6TEGPO/LuBMnvy4KpEhLAU+Zb7lVaM1Y+2IaPFY+nlC9fx7efEC6gbb
	CufZwhjqeYjs+kjj4hdJss6QM12iOBCmYu0N0OcXPCFIeKaBHYV3pfCHSNjVaT7g7yB5wDG8Fry
	XmQ7fJTa3IFuMDydj5kTA6tgkqedf6/0X6BmNoI9ixQKBQitDx+QSLYuqN1WtQ8xmjTKs0B224z
	16euAeHhVfCT6Dd4OgQqG2As+k9CD3kZP2jAWSnT7eiUIF+Hm8Tg9LNAhsYc8yR+WOllajBWVc1
	4oRbqtg+jYwAIo208/x+rQQZjN8hElbAH/0dmeyyMIBP8kjeUQ1BgieB0MpzgOdZCs8bJ6nTgEm
	srsjJE1CN2BxB7BDzhOZEqwMLKzYG203n2POTVXuHfW/hk8uQDGeaHjIkpU6QS0GQP2ABtXQOaD
	wRK+uE6Y6Bcy4FZ9fmALmhZjJjzkQCHLFkaly1vrbpCN7iTmAP68nF1iOtDrG/
X-Received: by 2002:a05:690c:b98:b0:80c:85c6:8983 with SMTP id 00721157ae682-81e902e744emr24021037b3.66.1783785924177;
        Sat, 11 Jul 2026 09:05:24 -0700 (PDT)
Received: from avocado.meuintelbras.local ([187.10.85.73])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e950567eesm12606787b3.13.2026.07.11.09.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:05:23 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: git@vger.kernel.org
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	Vinicius Lira de Freitas <vinilira@usp.br>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] t9811: replace 'test -f' and '! test -f' with 'test_path_*'
Date: Sat, 11 Jul 2026 13:04:47 -0300
Message-Id: <20260711160447.99708-3-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711160447.99708-1-marcelomlage@usp.br>
References: <20260702140704.65805-1-marcelomlage@usp.br>
 <20260711160447.99708-1-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the basic shell commands 'test -f', with more modern test
helpers 'test_path_is_file' and 'test_path_is_missing'.
These modern helpers emit useful information when the corresponding
tests fail, unlike 'test -f' and '! test -f'.

The occurrences of '! test -f filename' were replaced by
'file_path_is_missing filename', a stronger guarantee equivalent to
'! test -e filename'.

Co-authored-by: Vinicius Lira de Freitas <vinilira@usp.br>
Signed-off-by: Vinicius Lira de Freitas <vinilira@usp.br>
Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
---
 t/t9811-git-p4-label-import.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 072bc88210..866d7b597b 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -62,11 +62,11 @@ test_expect_success 'basic p4 labels' '
 
 		cd main &&
 		git checkout TAG_F1_ONLY &&
-		! test -f f2 &&
+		test_path_is_missing f2 &&
 		git checkout TAG_WITH\$_SHELL_CHAR &&
-		test -f f1 &&
-		test -f f2 &&
-		test -f file_with_\$metachar &&
+		test_path_is_file f1 &&
+		test_path_is_file f2 &&
+		test_path_is_file file_with_\$metachar &&
 
 		git show TAG_LONG_LABEL | grep -q "A Label second line"
 	)
@@ -104,11 +104,11 @@ test_expect_success 'two labels on the same changelist' '
 
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
 
@@ -137,9 +137,9 @@ test_expect_success 'export git tags to p4' '
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
 
@@ -170,9 +170,9 @@ test_expect_success 'export git tags to p4 with deletion' '
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
-- 
2.34.1

