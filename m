Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BDD33BBAB
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946969; cv=none; b=YnLDEbz/6061pBIBIC5i14GHK6eXWQBvRYZIV9nIfgW69FdtcQuTIC3Pv5okQtjP81+cDhOaoL2q7KSiCSodh+2fxH8tGzbov/O6YMjsVCwWQObqjfG++gJAMVj+3bwpme409FJZ4JoiaLwSMnMYlx6KJPGuXUw3oV6dSHCuAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946969; c=relaxed/simple;
	bh=2VfQit1KacBHCYA5GK+sLpvalM7bM/E/vJtRGbY8Rkw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DoLtxIgislBflBj4TmZ/NbjrY3Czs0DRZnhm0QhyE9P4OGFXcPnk8DxrKU0Rxhnsyh8FkDnP4eFJrEd1VRFBrGkuYi99vKKIJS7c897aLMesXkNg9SyVjiJFvZWhSl/6YHh2aPQDk5upb84++9Bag767chVH35YLjYpvi/y+0x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IewtnnDf; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IewtnnDf"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4edf1be4434so14530011cf.1
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946963; x=1765551763; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp3icUk0BgVzAoV0eS8ExmZLwZUm1qYrjh29LN/N6Kw=;
        b=IewtnnDfp9ldBSILpz/F5mWEGgO7nijrKqQyrns2zfWOHJmS32JAWet/6KNYzkS67E
         X/b/j4va6KlhnReCON4Pc5pKbzkH4uUhH77zpZlkeqAv1ivSuyEYTgsPhnYIOouAbKVF
         auJtu4AWb/w17DFGUpHmq2z453Kkm5axB+ZZRCfG2b23es/iRvtO+/12S/psCGuqb0BT
         FwmfrtS0PSDXobdVOJafBQAgJ04bOiSU3hUs0pU106AYoSsRZ5Xm69eHSZ5auIrpABmz
         nNT98Hyrr8gnD5WWNgSrl+wXBXlV0Advh8da/7ojy9BUTJOcbEV57Iq3ERoCMSWoNo6W
         02fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946963; x=1765551763;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dp3icUk0BgVzAoV0eS8ExmZLwZUm1qYrjh29LN/N6Kw=;
        b=jT+wtPf+DWi/cYYGvdMrFUkWKCnpuYRIwSEb007yI9BVJqwH4VlQJxDxBjERE01Se1
         WQ6vOGuvSiayMKF8+k3FarKi2Ucwfep+YxXe8yV1p8Logaa1ERzB3DCwgFnBrk6fWZor
         O71q8gk+5VBWZNs4qCQ3pS2uhFARFf7nClqoVhd7S/abESFXZc7CSBrJ3D2DkmioRo7v
         t+CITW4ZvCTKk5mOChYo0hTqikuH3OS3y1rIvtmzJu0M5A1XKUy6nEGoB3P2JIGOv6cB
         7i9A/Krnph/WnQ92SkzPUCztprf3cEQ37Y49BQAAn474/ew44Fzz/iD/TL6TinEW+ADs
         A0xw==
X-Gm-Message-State: AOJu0Yy9p8Z8SdLoG/BGDPitMYt7kM3Deu5oZWWL1JgiXBEwD0mEqAGj
	7e4QI5A+TI1V+BEF+gQ+7i94YLS3sRyJsn730YBaJjJKD72Nq+ayaY+SgPe5AQ==
X-Gm-Gg: ASbGncvXQCmJnK0hLhgaX9g5VW9hGxUqmosxC+uf+tUH3X9jOzUlVUZUFdjBsHsS0Li
	UAYVw6/T/twuDEn0NfottZI0YmSNuOoTBHSh2xW8KsK5dGWbcNrp/w1icvVLOKO/e3kBK1w4RNZ
	JgkIA1EIoWxS75zpJyzbX/uONH0zFrrqx9vESt1PhqKHhxJ0g/Mv1EJ6z1Y2p7KNoYI8AxkXi02
	6jRs6qKDCf+L8EzjhPGX3QfP26GIN2wxcsV9TQS+hdO8gJujZnA37PJBaMJ75uXRIG1zvOsoGUQ
	s7K4yU6M6kG2dGuP5zozXJw7LiDx8Tq0J9+twXvqV2zgSVfrmu4NJpxFyie0FWo0g47KTFhk1VI
	h5bXn5mFqlodsoaRxxsqBDt2XTw+mZpNV+PSwPmieUDOx+4S1PJrGNEzK5aH1g0Q1/qbTb+tXD3
	xWaUaxmX5P8yAg
X-Google-Smtp-Source: AGHT+IHD1E69+Kd6saxsNuFhGspzQlFElKvHECaXLLdhjR3mI8WoiLy4ZEFZaNJoFBL03l3PTBSv+w==
X-Received: by 2002:ac8:5889:0:b0:4ee:1ec9:f947 with SMTP id d75a77b69052e-4f0239d8771mr105165941cf.3.1764946962386;
        Fri, 05 Dec 2025 07:02:42 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f027d56fd6sm26854631cf.30.2025.12.05.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:02:41 -0800 (PST)
Message-Id: <945306b5d4ed35d317805b35e1c2dd719cc7829f.1764946945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Dec 2025 15:02:25 +0000
Subject: [PATCH v2 10/10] t7800: work around the MSYS path conversion on
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
