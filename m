Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6631D370
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946966; cv=none; b=MD2rjCK3c8L/ccOhQkjXUAJNcSydS452fCcbNfIeznpvCosuV7sw3W5mBIfxw80VIQrpKa9mf2XQAxfzqWfpLjM+x+5Kt6rozckD61k5GMdSTfdHw/KeHGmeNff1gRIkDxyNakcCKXP5xKnW4Vm1PG5X+prd41pLPiox/uWmfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946966; c=relaxed/simple;
	bh=rMV91nQ/tiBuBzSqZx+K8CebyVyDPsaXNDyDQr4XJCI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Cb/Fzx0XsPK2G4kgmcaWgcvPpTGS1P1YI1wxWlOiTuKAHKOs1zvk96HOWe24j4sOVXo4z3iBzHtI5a8gg610UtDWcpXArz5P7uCZmYyNYozluI/gUa7DiJEpBUwkQ+pJP3XtRqUiO2ARCz7dzuvBtUcRD98Pp+RQhuag1OrsBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR8gSwXR; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR8gSwXR"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8804ca2a730so33142646d6.2
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 07:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946958; x=1765551758; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/ryRAebtMjjichxOsxJMCrKkQ/OBsBsdmGjLzGoEWY=;
        b=BR8gSwXRY5iBjGa4yOGFFL+wchRgcZRDrCNP8RIMyR52HHvF2zG6n2/95ewN9j94f6
         pHPGbOYSiY82UTUjK51uuWfjXEHE/I7iJOv3TAqoYzou0ifdw3Th6i97ZhXiQ3x3x6bz
         WKyZ7r7KqUZOI9ueLSPMvc0PKwVToLV6XLv0/6a+GD8vo3pDpIkcvpZ1fKNhkflso+gr
         nt5h+YZgRzOla6qaOiheFPqyoLJG85ZXvnWumiJDSH8nYGCyu9ZDTCa2WprcakRe+MEQ
         4APErXO43Z3NgwfnrKiuaPy0S1mdYYn7WrUDTw5JrJfpgS5dcVZyumBsaVHo5SBTKiaa
         SgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946958; x=1765551758;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/ryRAebtMjjichxOsxJMCrKkQ/OBsBsdmGjLzGoEWY=;
        b=L1WY7NaARE0SbpRjcePybhMzPc19pwUPZlR1WmtCO32coJm/h7Xt/ppl5tlwM1G3ra
         ugtlgY53JYVa4Ev0xOmVxcKUW+7oNc1JzkNX7/anoLWi3Iqbawqt1J3Uvk6411bTMA55
         WDRzNnsB1/HXMB2Dp6SDrIY0RljBz5LK1Gu/rdZ/GLpG6qvhul/LV/vg3vyCwKFJTEi+
         Qt6y4jipV88W6FfcBXnFFoA3aDqjKWLyR7UC0rbi/WHV+8HNOtJNb7f0PRcA3kaaxHoH
         MXj/mrc+lSZ5VRNghNg9vxz+Qb/wCaNIerOWza+7yXN7fhWF36SxT7TBmErC4NB2O4x4
         DfaA==
X-Gm-Message-State: AOJu0YycigGo0S1cMw5jjpZ96uDs91qGK0MdZA2m3pvMCLM7U9YMFk0g
	wp54vbXOhYpeA1OF++Y99iDTD4QMCfjpx6s2Iyr5E+piYMJzpe9FGIx83n39ig==
X-Gm-Gg: ASbGncvYk7tXL3kI18F6g+VmrRyl6+HS9Z5T+UnIh639ed0AvfNCBYfo1xULtM2sw3c
	0ZSPySkX9AbtUw4cRQYOy9FdHUe8iBOUzJ2wlBcW6lz//S8IWGxIQzUW1ZkRR9b76nDTKPOCQuq
	W1HOCnte4CLLFuUN4Ra8golmnafkowAZ4XY1/Q2Fg/YqEDq76cbmuAZFmLsEp4piYM8/6HQ7PIJ
	+a0FvFQg4IAvUak1L/OtYz25dn9Dw5jV2mZ3qizpOEUYoRXwHx/05HO3ATRdC0V14t6ajfvmRtm
	OltsaD1CDCRQnDNE7s6Jr6eZR7yqTY6s/gtxjkgFQuRfxjwH7YRist+BK3cKJ/B7rfTyp5S1J49
	eON4prk73a3W2Bot/7Ygxj7DxzGQR5phxbzMyQKDS+7NgtW8Ho6NFyYz17M9LqdQyi4hew0jctp
	IIV+h6mDkKaO+8
X-Google-Smtp-Source: AGHT+IEFdJclxQr3MqYWsvLJLFexH1uKBv2e6TVLoZVyxeRYbC6mxQr6zb9Xoi09DszRlJH/R2FTCw==
X-Received: by 2002:a05:6214:d04:b0:880:51f0:5ba7 with SMTP id 6a1803df08f44-88819587ca1mr146004576d6.42.1764946956418;
        Fri, 05 Dec 2025 07:02:36 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88827f4cacasm35812116d6.16.2025.12.05.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:02:35 -0800 (PST)
Message-Id: <ea74e678f9440a9f42541a8fd207d90b058ce152.1764946945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Dec 2025 15:02:22 +0000
Subject: [PATCH v2 07/10] t1006: accommodate for symlink support in MSYS2
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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

