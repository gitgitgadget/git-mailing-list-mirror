Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6934DCCC
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885595; cv=none; b=cgePC44moJIhMWQzzOAn6/0pH6C5avQm+IcwpsrBGrw5PY/iYpoN/UuP372jSpMfgpxXnNlMW3SPj9TK4DIDMi99T/pX0MIqVROuECTq/iZdfpxCkzwvF6L9rz3XfpN6O/NQrGgxj8tMXlkc9yDmaxbnOm+761vHgc8t8scRGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885595; c=relaxed/simple;
	bh=2VfQit1KacBHCYA5GK+sLpvalM7bM/E/vJtRGbY8Rkw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FmuCTVhkojHN9F8GjPsGdPgvFYXyEefKtlsR+FLSHSxgAFhPUGV/3fEdE885Rspem996kWuG3XfBe55ZE2p9bXoKZydm7tucgKXKUXPyekm+bsOYX9uwlxU2mZpcoiI8EbO1nKoDLTaoZpW8E6ECqNdkfKjvA3WUWDbKakDi/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec39Ba2/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec39Ba2/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so5150235b3a.0
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 03:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765885593; x=1766490393; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp3icUk0BgVzAoV0eS8ExmZLwZUm1qYrjh29LN/N6Kw=;
        b=Ec39Ba2/A0pCvp9JaCuJ7wqlv9FbsZEaBIVWC6vvnMJYg0ePkbSB0bUSLSuBk4oJ2t
         y+ZrDbjV/LP0OnyisIW7+WKbMxT7HV++59xwh2QmUnRB7/enr4vsX0h7ZqSKBmlwM+0C
         rj7sZgN/b68wNZTv9kXJNqH+U8uhQ0Kgpl3iAKtiblUbEMPKvjouIJw9tUFD5b3rHQOq
         cXKCHBLET0V6guxFsKn/BYAlkHnfrrqVG6Lr89vFRqdGfpZPpE8VQBfnU7hZd2kuT8fk
         25ILewCtD3LJx5ZA77hP883cePeoDj6k3dyrtlxG11e8aTfJ8OIv9su7XEhRRf6EgRS8
         YIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885593; x=1766490393;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dp3icUk0BgVzAoV0eS8ExmZLwZUm1qYrjh29LN/N6Kw=;
        b=c2HWnvXpOQ75DKtaNyi0W2RZZFExJ/tQ/vuBAA0FRDK5BIdsCZV4K+8IHZIKMfGYI9
         A2NcUvtebUcZ/WFSFCOc/hcOxDGrgk95I4yqS6cDjIugWnXSE35eKxQGn/yy8JmdC25D
         ZskzLs3TXixS4Vj0zTzJTxMmkd0OrXzlTYw1xjkbsfq3JqITUeroihbdAznxP19PrG/8
         fKFVaWxYss5Foa4dUAycMQPA0UAdHGC1lVdNUXhwHjeN+B6s14KhIqf9ZaDM1dzNmhvt
         P3Tw2LgC1fvnSYpWEOB+YaCC5qiVErPkNJcryv6rPMM64ZHQ2hvQAjkDapKe+5RvNKkk
         uGnA==
X-Gm-Message-State: AOJu0YxHjQOzTC0cOrHf/Fbm2s+oq2dD+96HZVISq/ifsvXlqooEp0Uw
	tmwbfUIO2pQKhDaKJEMGMvnq0UhUOPZX1Ah7FKfU8v/ZsRV+1PoENZ6/E0rr3g==
X-Gm-Gg: AY/fxX55sjBRNwjmFTwlge14H5HpatuuPPChT3aqLfvaLV75DXGHeMN4S8Xr+rgTxvm
	pqL3vT+eZeC8d+xvbjIpioTlmvz6OfyMiCWj1TIfewlqaEhb0mHaUifZubR/d1+jwTEDVuc/4Jb
	58Y84D0ebp2YN2Rr3q9OsbrqRlAZojjzU9T8ydU9/4Y6g8HsX21a1GI2ojNxrG0R3k/KEeyMpH+
	JzeuiVXJp0pokIunyHqmMjt7XuCofVSwh2UldT8tigrhKY79Ca+hgNVM+yvJAt/1+Hzs7xOFBGL
	kdl3P70BN0QtLekKtQt/AptPpvOyzHPjh3E7ZqdN/SKrK1dtizf1iCBVRbOIVquTmwVPhOLlAZ2
	3NlHsXNo5YhMwZuTJbBALm55ps6Lel+I7ROlqO2IorgEMmYQgy/c1Od99zQVUwyO8pFzOIimG3L
	b8E9VHlS2573Z4
X-Google-Smtp-Source: AGHT+IHsik9TOB4zk773nMQVEzwD7HA97VLJqcrvS1gvIsk3MRlrE3bFdPY+8zejxa+pNa4aFZg3oA==
X-Received: by 2002:a05:7022:ea43:b0:11b:9386:8265 with SMTP id a92af1059eb24-11f34c16992mr8295954c88.42.1765885592594;
        Tue, 16 Dec 2025 03:46:32 -0800 (PST)
Received: from [127.0.0.1] ([52.161.69.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb3b4sm51416376c88.4.2025.12.16.03.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:46:32 -0800 (PST)
Message-Id: <5f056902df52aa64ae92c37ff4ac161701b4bd71.1765885577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 11:46:17 +0000
Subject: [PATCH v3 10/10] t7800: work around the MSYS path conversion on
 Windows
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

Git's test suite's relies on Unix shell scripting, which is
understandable, of course, given Git's firm roots (and indeed, ongoing
focus) on Linux.

This fact, combined with Unix shell scripting's natural
habitat -- which is, naturally... *drumroll*... Unix --
often has unintended side effects, where developers expect the test
suite to run in a Unix environment, which is an incorrect assumption.

One instance of this problem can be observed in the 'difftool --dir-diff
handles modified symlinks' test case in `t7800-difftool.sh`, which
assumes that all absolute paths start with a forward slash. That
assumption is incorrect in general, e.g. on Windows, where absolute
paths have many shapes and forms, none of which starts with a forward
slash.

The only saving grace is that this test case is currently not run on
Windows because of the `SYMLINK` prerequisite. However, I am currently
working towards upstreaming symbolic link support from Git for Windows
to upstream Git, which will put a crack into that saving grace.

Let's change that test case so that it does not rely on absolute paths
(which are passed to the "external command" `ls` as parameters and are
therefore part of its output, and which the test case wants to filter
out before verifying that the output is as expected) starting with a
forward slash. Let's instead rely on the much more reliable fact that
`ls` will output the path in a line that ends in a colon, and simply
filter out those lines by matching said colon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7800-difftool.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 9b74db5563..bf0f67378d 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -752,11 +752,11 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 		c
 	EOF
 	git difftool --symlinks --dir-diff --extcmd ls >output &&
-	grep -v ^/ output >actual &&
+	grep -v ":\$" output >actual &&
 	test_cmp expect actual &&
 
 	git difftool --no-symlinks --dir-diff --extcmd ls >output &&
-	grep -v ^/ output >actual &&
+	grep -v ":\$" output >actual &&
 	test_cmp expect actual &&
 
 	# The left side contains symlink "c" that points to "b"
@@ -786,11 +786,11 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 
 	EOF
 	git difftool --symlinks --dir-diff --extcmd ls >output &&
-	grep -v ^/ output >actual &&
+	grep -v ":\$" output >actual &&
 	test_cmp expect actual &&
 
 	git difftool --no-symlinks --dir-diff --extcmd ls >output &&
-	grep -v ^/ output >actual &&
+	grep -v ":\$" output >actual &&
 	test_cmp expect actual
 '
 
-- 
gitgitgadget
