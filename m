Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26477D094
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209440; cv=none; b=ZAUOgGZe9kUcDBYFRG3x6HCgItDCjeTxUVQ8hq9lCA/kbNO748adU8NmdFJq6pwx2215/tsXVCsO6lBoJ9QorGIpSJFxLMklWDS5MxwOUc/w7kn7OO9EiulxLG5yRjFS3FdhA/Ym5sMJAEVbsOLZn2s1mKpPLjdEV+xlyOuIAy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209440; c=relaxed/simple;
	bh=qgMo4xWcyOdWqhak+2yCx/2wr56+g6alcrMUgzUl1kw=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ogSpIO0oRY1D30YZGVtwVqveg3NUzT5RRa9vhgN3W7fmKB/hgoj99uj07lxMK8gnIA5qLYJLSyf8buv/u3TC6+yMz067bc/2kZW3+Q+KnkKaJ0xBEWtwwAKhaM3yGhtSXrvXskwnYNJ1kRrXe1h4GldiFU99g4DZKhF4uRfrbHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYtuL6FV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYtuL6FV"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ddd1624beso507700f8f.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 04:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709209436; x=1709814236; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BryZW81biC0SOd3q1dNaYiIevu0dbTReNybK6+7KyaU=;
        b=LYtuL6FVZWlvM5TuW5lgl50bmjiT8rKVQwKbLcOEiLuwL1hKI/heFGM07fmbV0vlvG
         9+abpI1tC/TlBbqe9z1ZAAlO1M572114eH87S8n9oWunlNYDti+uiIN9RjV3r76B1Kp8
         XOJBuFjT+BR99bsNAjtnPBHtOQuv1DONYHrP44wyXrH3MBiJIFquWVuTNSTwBz2qsX70
         KpVZUEmqomVK4rKIsmtpeIhHN9hDSMtU5JezRJXfA2G+AaSG+z+OBjsZIi6UbEwD5Dmm
         wpu8BIIFhfCknI+dbIwjnAtPiaN54/obS0M/SWSBKfCQvXHz3ka7pJWMpyCZG6WwdOc5
         BRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709209436; x=1709814236;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BryZW81biC0SOd3q1dNaYiIevu0dbTReNybK6+7KyaU=;
        b=BdOi0BpxCyriprHR2uY3OxmZYplXAz+2hRjqwyhCiU88VgJnYX0C+BQRpw5k7kf5fL
         6k9+AmZ2l3+iOg6XOVM5l1oSgX1snesxUJ4tcKCuNJ4UkBzUOW/slajCcneRbgNmZTul
         Cx5hRU0c3RifhvJpl/DX/ZhCRu+llUQDj+Ku02KKx2MslGrOeSSkalLJdN7pzpuIxAZL
         7MBkSaBvbjA4dfc0gDmHbapf/Q39d+EFGhOxKFXcPmJBL1klb1lEr001gbotWwqdTVHA
         ia0o7j0noqv+gnrcClRc1CjfAwxuklFEF7an4jJCJGDw7/AXyPi8cKPBH4Qq29pqMpdY
         N45w==
X-Gm-Message-State: AOJu0Yypd0Fmpkl0SCLS41jvLuGiSdd1gOt85TgRyFxZQX/iwQH21EUS
	JdyaN7rr1NLSyjEns/tDHW3gVxk/nHytsrHqt8GrgjL/TPL27w4yamaCAZ4q
X-Google-Smtp-Source: AGHT+IGecxlFmk4L2is2bggku8GaUIPdMcB929XBZyu7j9lnO5BQD+rGK38ygFwdIRbh0KrR+wx5nQ==
X-Received: by 2002:adf:db51:0:b0:33d:eb13:9e27 with SMTP id f17-20020adfdb51000000b0033deb139e27mr1966710wrj.23.1709209436280;
        Thu, 29 Feb 2024 04:23:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0033e12a67fb3sm942791wrq.50.2024.02.29.04.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:23:56 -0800 (PST)
Message-ID: <pull.1675.git.1709209435242.gitgitgadget@gmail.com>
From: "Aryan Gupta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 29 Feb 2024 12:23:55 +0000
Subject: [PATCH] tests: modernize the test script t0010-racy-git.sh
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
Cc: "Patrick Steinhardt [ ]" <ps@pks.im>,
    "Michal =?UTF-8?Q?Such=C3=A1nek?= [ ]" <msuchanek@suse.de>,
    "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    Aryan Gupta <garyan447@gmail.com>,
    aryangupta701 <garyan447@gmail.com>

From: aryangupta701 <garyan447@gmail.com>

Modernize the formatting of the test script to align with current
standards and improve its overall readability.

Signed-off-by: Aryan Gupta <garyan447@gmail.com>
---
    [GSOC] [PATCH] Modernize a test script

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1675%2Faryangupta701%2Ftest-modernize-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1675/aryangupta701/test-modernize-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1675

 t/t0010-racy-git.sh | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh
index 837c8b7228b..04dc1cf3ff5 100755
--- a/t/t0010-racy-git.sh
+++ b/t/t0010-racy-git.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='racy GIT'
+test_description='racy git'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
@@ -16,19 +16,18 @@ do
 	echo xyzzy >infocom
 
 	files=$(git diff-files -p)
-	test_expect_success \
-	"Racy GIT trial #$trial part A" \
-	'test "" != "$files"'
+	test_expect_success 'Racy git trial #$trial part A' '
+		test "" != "$files"
+	'
 
 	sleep 1
 	echo xyzzy >cornerstone
 	git update-index --add cornerstone
 
 	files=$(git diff-files -p)
-	test_expect_success \
-	"Racy GIT trial #$trial part B" \
-	'test "" != "$files"'
-
+	test_expect_success 'Racy git trial #$trial part B' '
+		test "" != "$files"
+	'
 done
 
 test_done

base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
-- 
gitgitgadget
