Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFD84D34
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738235317; cv=none; b=X57yasYm/aN1e2rKB5gGguLCCO0G78ZMG9FWGh9dmDk7rz93qzUfFIKvCIwSp9WCkhwlfZCVlfsPPzyQM5xVpuOESQA4Urb0BKLr0VDg0Tb3MN0JxrZsYXtD1mViYKgyJG8fwe94xQijTcxMSGzPSR7IcjoH7oKiQfhxn3Ef4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738235317; c=relaxed/simple;
	bh=VLFbdSpKpzS5hpiGJrnAbaFBkk7B21CWFEy7J8ecSWA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Mloye7KpGfX1jcfdxv4+IWQF/nFo8rBF6WwibRjdQprQywac1QyAj6zu1s+5Tf4v3hLOW3/+4R/Z5SlnAydjA0FVmDCRBD3SzRHVW1eBdrCJNv0JLy8XjXoDNVCzo5YITDjUAl2hL7xDW6lvEol2Hg7GWKQ0lfvE1Vm9hzuYXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzH2JvP0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzH2JvP0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38a8b35e168so351845f8f.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 03:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738235312; x=1738840112; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WGbGHR/95TWRNjgVws9gJDYHoRkn9T/r7OWzC1YTgNU=;
        b=DzH2JvP0vHv2WBJ5xT/MILEj2iELspLs789Wj85v/chsY5j+5ZAodWwdGdbvbJopCA
         QrwBkZykhaetcpxxwUcfcVhyekMp7m2Lf9kI2O+BlOcsaOZgbi4JD6mYmJvFZfiHUjTS
         wBCnqK+t9pqB6B4A6gPaA/MMET26U+fJyjwRRUaUxfSaJrcWyFj07XQBmi+OBBrqKpWw
         Ub2sCGfuKUlt2haIlLT6Su8v1c6Hd2iwKUhBlf7dMlCOhHybhf5MmnCsKGwXUXCkOd6T
         24a+3M11sNBs/ffqbyxz96PNaTmn6gODtBPw5ltIRmc2752DPfYNt/qUZmJQ8eKjRNnc
         Hiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738235312; x=1738840112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGbGHR/95TWRNjgVws9gJDYHoRkn9T/r7OWzC1YTgNU=;
        b=FlaAe+o4koFZkX8nzu4SC+cmW8qVQkSy2jv3YpuWBoplKlTwO429fMgzaSQjbc6Qfc
         JO/GIY/FQr1qsZwF+FptCI4mC/ONyQjnppx+ttZbFg17EMNe9s9tiAOmmALAxvZ25M7/
         9LN9QsBAZhvJgsB8iTlUlWP75jdFOqW8bmls3/y4TbG3MGcuutvSePzMhB4DuLIyt7Zt
         GNYpNvKv0mO0WYZ8Wmio/aH+1c81nkYyCLmznjpx9Ah6yq/Bp4qHf54u8PfsmTxLzv9O
         Le916wZ3W2O8XBEfDRk6HyJv9Gh7Q57xFnJGTZGFI4rYINuAU6UMRPXY8I8zwe5eJtLv
         XP4A==
X-Gm-Message-State: AOJu0Yx6zy/Um6L236H4jOpJSxHX+UCVjtjEx4OpUrAsNX5AmlCpCsTK
	sQG1GmZb+EjonI+Q941vG+MOBkiOdwHSSYqhb0ScZAcpuafYLYEyrEFgaA==
X-Gm-Gg: ASbGncujJ3/ZRkE+U1XKe/uhL3JZHGxWTI0ttHEgswx63+dBwwfhk1SoxieNUeff8h4
	bbfMaG50HtS39wO6bdMYP8FXxsY6b/dyp0ZAScEr2ZGYttpBaAVC6I+3QIFLIDQVpOa1un1vY11
	hvfX1fDvfOVgKkkWg/Sp4Wli4jQlM9TsG6RTKMRZnc+537aPakoMhHb4NH5vxhi3lDm7PLu8fdo
	0R4AHd6JXPoD2WdtAR8ZorPWlgKYf3BedktGVD1tI+mN/7n7KEY+6H19Se0rjDqfCo7p5ld+46l
	hUkRIoB76AmGRVob
X-Google-Smtp-Source: AGHT+IH1agF1qQM3/ppxl50Yb1ESWvShn+nSsB9NcZXRL8zGJron252079dNuSaTM0bTkk5TiHtYgQ==
X-Received: by 2002:a5d:648a:0:b0:38b:f4dc:4494 with SMTP id ffacd0b85a97d-38c5a9bf605mr2429492f8f.26.1738235312100;
        Thu, 30 Jan 2025 03:08:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b5780sm1660162f8f.67.2025.01.30.03.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 03:08:31 -0800 (PST)
Message-Id: <pull.1858.git.1738235310815.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Jan 2025 11:08:30 +0000
Subject: [PATCH] apply: detect overflow when parsing hunk header
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
Cc: =?UTF-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

"git apply" uses strtoul() to parse the numbers in the hunk header but
silently ignores overflows. As LONG_MAX is a legitimate return value for
strtoul() we need to set errno to zero before the call to strtoul() and
check that it is still zero afterwards. The error message we display is
not particularly helpful as it does not say what was wrong.  However, it
seems pretty unlikely that users are going to trigger this error in
practice and we can always improve it later if needed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    apply: detect overflow when parsing hunk header
    
    We should do something similar in "git add -p" but I'll wait to see what
    happens with
    https://lore.kernel.org/git/20250126125638.3089-2-soekkle@freenet.de/
    first

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1858%2Fphillipwood%2Fapply-detect-hunk-header-overflow-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1858/phillipwood/apply-detect-hunk-header-overflow-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1858

 apply.c               |  3 +++
 t/t4100-apply-stat.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/apply.c b/apply.c
index 4a7b6120ac8..b124678b93b 100644
--- a/apply.c
+++ b/apply.c
@@ -1423,7 +1423,10 @@ static int parse_num(const char *line, unsigned long *p)
 
 	if (!isdigit(*line))
 		return 0;
+	errno = 0;
 	*p = strtoul(line, &ptr, 10);
+	if (errno)
+		return 0;
 	return ptr - line;
 }
 
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index 146e73d8f55..a5664f3eb3c 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -38,4 +38,17 @@ incomplete (1)
 incomplete (2)
 EOF
 
+test_expect_success 'applying a hunk header which overflows fails' '
+	cat >patch <<-\EOF &&
+	diff -u a/file b/file
+	--- a/file
+	+++ b/file
+	@@ -98765432109876543210 +98765432109876543210 @@
+	-a
+	+b
+	EOF
+	test_must_fail git apply patch 2>err &&
+	echo "error: corrupt patch at line 4" >expect &&
+	test_cmp expect err
+'
 test_done

base-commit: fbe8d3079d4a96aeb4e4529cc93cc0043b759a05
-- 
gitgitgadget
