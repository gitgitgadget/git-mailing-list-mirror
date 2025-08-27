Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B038027B345
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308315; cv=none; b=bJlqDQwMH00lp334kj5+suLYehJlkREl/Pqle/m1czXWp/8JMjLhEE1P/L1as6tzBGx3nx05CkBxsD7zNSn7b8Ek9ZvFVVl0SXQxwHqd80e9QoqBdOXVXSsH3jn8eNeT+JfitY3x7SHdjNl76oaHIAbbMVIkhSUkZ2QdpqekCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308315; c=relaxed/simple;
	bh=d3g1MzmMLGP0mOltV32UIe3P33oLfFzRzxWMPoSzpqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7F72PIJxqyGs+GcYBgnZ0AirjqkXFT+4HF12IIeBAGmMmODBc1xS9rl5D+aZOl2fah9H29oll6fUffSJvXnCSN43YMU7AFsOFtkythjh848e1Q2Rs6EsRtZ/CLX6r2KHkY/QfhrqXcLeecBWHfTbJQ6MZgAULfUUebv+IRsDYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Klt7QrUX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klt7QrUX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b629c8035so19923205e9.3
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308312; x=1756913112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V/OARFG+zqT+Qqg/4xwC+Ous+6Qw3zBlLOYgxVeHV+0=;
        b=Klt7QrUXZ/Q8Bn0hVvSryg8VO05FXWiZ7t22FWyKpTANSJ71y83PaAouAtC087amd2
         9NvrW5jG3D0ZlWjKJ+EUYQaHIYiDCDVr7EHFwcX9U5B6waw1npt9puqsHK2CwU6l1yoZ
         1AanPjpvVpke4XQwOTLWK0fqihzLPAJ1OCFGBgVUD8wuWF9R5JtlPW6iTioKiz3LYcy5
         9J5I7Htp/on+9fJ7nofjFTvhHXlLTC9moSgOAP5hjiOOtoobzfHeBTjMKXZZYrkYdymu
         EWoTJjHdDZ0BXHqqanVbuvpP9i2Ww9fwIQTuE1a9WVWYEZVYjYwOlwpkWm8NUsLwgL/e
         CY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308312; x=1756913112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/OARFG+zqT+Qqg/4xwC+Ous+6Qw3zBlLOYgxVeHV+0=;
        b=uvtt01g+y3wb+IxEtfZ5YmE2nlwcrX/VqQ8l4jraUjN8R18mKKlEFtJClCoQFtqMoP
         Imw4a5GFlsi/ecA70b+K5SYjGpShbdu9JD8PFSmF+ScdEnclNxaAc2aS9yDwnj9wGvy4
         sFENmt+oQ1057wSpj46TM0U9lVZwuuqSUxLXQAjJLhctQDkmNdou34SelhKQ3lPp7GYB
         earlqeqL+QvMAyibJqok+AH0F0JSsdnCzu6ziQAky7Y+yVXi8bbQj1HW4Y9UA0Z0nwLP
         z1IoPDuMwci3urjPe1Az7avo2TmD41qOiRwnc1SA1hRBX5dFYwq7V9a1993fAyY1U/d5
         bJbQ==
X-Gm-Message-State: AOJu0YwKG/96b2ZMtJ/9cNvMZ8BLAnK32D0/bAN5nPQo5yiIkyTW4ky3
	/dvdz7U+WBdDWQeUfInsZVqzz5woKB52ZzX1eueRgDLPebm5Y9+unskxKCXzMg==
X-Gm-Gg: ASbGncv0zncDOFv75AaIF2qqtDdhfo+JBJoRX2fAu231ApNtsZxeOoIv80BhxGk+FsT
	gKn6c2X1PhawLKO4h1mnGMvkzz85Foby0RUng1reo3JUORzVh4jnKkRwCVhLKqRTTT7EyP5jfJS
	I81YfWNNOP+SQK3hSjJwe5L1lKAD4rRMyF7/Y42lPceI+w11ZuRFQCcoe8JTR3SDGT5Kbf+8Rhc
	eFWN4dJiDC9/1dDlVzChx0XPGcHWmP79O+P+TFWaNJGpDg4+O8ptScnYr4UlsQWtcpVfGihwLiU
	BnbsPeq8OAr/8JUveE0Vszm7bjj319emfILWMTrLzQZZ1V52Fgoh/Hb6+EdnGS8Q0iuPdLl3eo+
	DRSTWrk+eqUw+kDrVevhOR7kUkCTt1zYYmqRzrFuyJUN8Iw==
X-Google-Smtp-Source: AGHT+IG0ieFmfUXexvQ/lZF49G2YriO8jQFlWkhD9jBkm3UUMU4bOiJRIuo+7q+hinq8y4t63wDaIg==
X-Received: by 2002:a05:600c:1c25:b0:458:bc3f:6a7b with SMTP id 5b1f17b1804b1-45b72e9ae0bmr18952635e9.18.1756308311698;
        Wed, 27 Aug 2025 08:25:11 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73627bc4sm17894305e9.9.2025.08.27.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:25:11 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 5/6] t1403: remove dependency on GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
Date: Wed, 27 Aug 2025 16:24:49 +0100
Message-ID: <a46c0dd25a63c2e7520a0aada691334bfd6b819f.1756308283.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Some of the tests use GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME when
checking if a ref exists. However, as that variable is always set to
"main" at the start of the test file, we can hard code the name in the
tests in preparation for removing GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
in Git 3.0.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t1403-show-ref.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9da3650e91b..7b83daeaa32 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -229,15 +229,15 @@ test_expect_success 'show-ref sub-modes are mutually exclusive' '
 '
 
 test_expect_success '--exists with existing reference' '
-	git show-ref --exists refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+	git show-ref --exists refs/heads/main
 '
 
 test_expect_success '--exists with missing reference' '
 	test_expect_code 2 git show-ref --exists refs/heads/does-not-exist
 '
 
 test_expect_success '--exists does not use DWIM' '
-	test_expect_code 2 git show-ref --exists $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME 2>err &&
+	test_expect_code 2 git show-ref --exists main 2>err &&
 	grep "reference does not exist" err
 '
 
@@ -254,7 +254,7 @@ test_expect_success '--exists with bad reference name' '
 
 test_expect_success '--exists with arbitrary symref' '
 	test_when_finished "git symbolic-ref -d refs/symref" &&
-	git symbolic-ref refs/symref refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
+	git symbolic-ref refs/symref refs/heads/main &&
 	git show-ref --exists refs/symref
 '
 
-- 
2.49.0.897.gfad3eb7d210

