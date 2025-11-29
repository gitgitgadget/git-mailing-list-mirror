Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE11312802
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440921; cv=none; b=YEe6X/YEw72gkE5b+hYeFlIsGPAeTlWG/BtUGaVFS6ly5yg8w3HRzqYw5CE15bmDTbbKMiLtucHVH3nh7yfen+Ui/dNIiswtOEFVF10CwCOTUGP9fIJS5FGmS8aji7jqtX8ZDZRQ+FsjFiuT3IOgL41JVZU/Nd8LsVFJmFZo/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440921; c=relaxed/simple;
	bh=rMV91nQ/tiBuBzSqZx+K8CebyVyDPsaXNDyDQr4XJCI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i/X/bqHo3IwvoCEkiCfUdgZmik7vZPN7NAC4hhAT8cSbw57CrjQZtDLt8IPGWvcPid7BlpFC0i8PtSZo/aQFB628V/yAzkeSrW7LXMnYW44BbgnmkTBSdHGwMNGwsqzY1/GCtc/EdUIrhOwlNpGdEmm+MpcmheKpQSM93WBlzZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuCnNlG1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuCnNlG1"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-880503ab181so29429316d6.2
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440918; x=1765045718; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/ryRAebtMjjichxOsxJMCrKkQ/OBsBsdmGjLzGoEWY=;
        b=FuCnNlG1Jf7OeZoEdxODT7PIlAIYiNbcjfRuu3Fd3LLAJ3emIQwuRVMvGIJdYIREnj
         Zhgknjo+LFzuB/fje4qgC8pLBCjpdqBNEVp6Zm4dRCI4dQhHgXIVAVQgU6Yam/zVQxs6
         31hbu0kCsOCKAr+qwRjdoc3Dr/Go+z9zSy6g9fcv6WSwCmUyDhX6ihEcL1gKkeXZmkoH
         aVM2q3Bg9n7NdCMTB3QaQ2pZV/exYuus2TYVGAgaVhZ6IsNzunlG+7cWX7LU1Cs4v/dD
         pJX3fMuyvv/GtQedo7Rzg3DWv1UO1B8Z4e8+BncdtqdRaGUGkwnV5lLWClRm3Oa9z0sl
         3rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440918; x=1765045718;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/ryRAebtMjjichxOsxJMCrKkQ/OBsBsdmGjLzGoEWY=;
        b=bKIUyz2e3uRpk77/L92c3DxFOLWPRHZE8RlKQ11YhpZbZoacQnvi9jvdk+hDl1/A9G
         jW6uRkpvKa5xtdac5SOY8c/tDhSp77ss2Vf9ikth98jsjgEo4aN8a9ulm66Krst+RmZe
         mUJVGe8BnQEK7Bb8xcmphbmXnzIRvMdl/GiR9kY36EhQvprONXJNLj464jraay4COT/8
         9NFCFoTeYDCx5jD3Padc/KcU90OnGaTRq368x0GtVFNzljjl8H3IzEEP8koQo4t2vhOB
         42vFkp9lXSROe5SY6nvzJtwp29iqVS6Fj6rftpeEcb5cIgALyanfD3C6leMwmaZYv3qr
         O7Zg==
X-Gm-Message-State: AOJu0Ywa+JxxeZkzyrC/Y8nw1dZzzjdr0XQyLXGzCWfpmkVStL/t6CYO
	qBUD2ssm/Gv4KhLoDs6BBOR+AvkgMsJxU66H1lXREhHMbOlPwivIJddohUmwmA==
X-Gm-Gg: ASbGnct74ldbC9L8+PJ9QLA0KRUhNS8oy+U+eqW8MSPQZN+G22K45U42SRjxNIe+uxu
	R+8Jz7v2REv/eDWFzWQAzEaqsHlFli/uH0hKs1y7NKIprStUp9Z5nsmJ/lvS5yBN4zgrC1iKZDo
	7mqXRs36ARk13z2C5C1pZvdF4UL43Cexrf4OtqQqH+NqCiFBYIFywfmuF2ohnANF8uMQBwjIw5t
	LgXlM3n62aUqeEw1+GTzlCSfqILswCYz+j6/OsKSyxBzw92PfkYO66cVuBUSb4KWCSY+5pMi9p5
	pyntDjgJgj0Uo+qFK28HvtFrYjnLNwAcpfI89v+c+BCzJVWybGH2OgEC9mGvJn8Ab/VMFTBj1px
	dD7sD4AM5zdE0owYyk31lfl1YMdHNe/hX2R77KCieNiKV23NxvEAGabCYkTNjKOPeKNzAMrX88n
	M5EzG6fBUAUQ3q
X-Google-Smtp-Source: AGHT+IHLc2X8PlUiD/ED5Q/RIXTurvc3VB395CakNQztahYSvHBsfNeKdm2E3XSx427o4Cl8JkWa5g==
X-Received: by 2002:a05:6214:41a0:b0:882:6d84:ebc3 with SMTP id 6a1803df08f44-8847c526e10mr493420496d6.34.1764440917795;
        Sat, 29 Nov 2025 10:28:37 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88652b91ba3sm51463146d6.53.2025.11.29.10.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:28:37 -0800 (PST)
Message-Id: <8a7c68b629f64a3fd8c08f54b5e8693f6568885c.1764440906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 18:28:23 +0000
Subject: [PATCH 07/10] t1006: accommodate for symlink support in MSYS2
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The MSYS2 runtime (which inherits this trait from the Cygwin runtime,
and which is used by Git for Windows' Bash to emulate POSIX
functionality on Windows, the same Bash that is also used to run Git's
test suite on Windows) has a mode where it can create native symbolic
links on Windows.

Naturally, this is a bit of a strange feature, given that Cygwin goes
out of its way to support Unix-like paths even if no Win32 program
understands those, and the symbolic links have to use Win32 paths
instead (which Win32 programs understand very well).

As a consequence, the symbolic link targets get normalized before the
links are created.

This results in certain quirks that Git's test suite is ill equipped to
accommodate (because Git's test suite expects to be able to use
Unix-like paths even on Windows).

The test script t1006-cat-file.sh contains two prime examples, two test
cases that need to skip a couple assertions because they are simply
wrong in the context of Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1006-cat-file.sh | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 1f61b666a7..0eee3bb878 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1048,18 +1048,28 @@ test_expect_success 'git cat-file --batch-check --follow-symlinks works for out-
 	echo .. >>expect &&
 	echo HEAD:dir/subdir/out-of-repo-link-dir | git cat-file --batch-check --follow-symlinks >actual &&
 	test_cmp expect actual &&
-	echo symlink 3 >expect &&
-	echo ../ >>expect &&
+	if test_have_prereq MINGW,SYMLINKS
+	then
+		test_write_lines "symlink 2" ..
+	else
+		test_write_lines "symlink 3" ../
+	fi >expect &&
 	echo HEAD:dir/subdir/out-of-repo-link-dir-trailing | git cat-file --batch-check --follow-symlinks >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git cat-file --batch-check --follow-symlinks works for symlinks with internal ..' '
-	echo HEAD: | git cat-file --batch-check >expect &&
-	echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >actual &&
-	test_cmp expect actual &&
-	echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks >actual &&
-	test_cmp expect actual &&
+	if test_have_prereq !MINGW
+	then
+		# The `up-down` and `up-down-trailing` symlinks are normalized
+		# in MSYS in `winsymlinks` mode and are therefore in a
+		# different shape than Git expects them.
+		echo HEAD: | git cat-file --batch-check >expect &&
+		echo HEAD:up-down | git cat-file --batch-check --follow-symlinks >actual &&
+		test_cmp expect actual &&
+		echo HEAD:up-down-trailing | git cat-file --batch-check --follow-symlinks >actual &&
+		test_cmp expect actual
+	fi &&
 	echo HEAD:up-down-file | git cat-file --batch-check --follow-symlinks >actual &&
 	test_cmp found actual &&
 	echo symlink 7 >expect &&
-- 
gitgitgadget

