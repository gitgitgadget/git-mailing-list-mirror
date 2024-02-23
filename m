Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138BB64C
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658309; cv=none; b=pEGbwKtUxKTzbrB5jT/NsEO1t/EbE8gfYyRYBxRneMLwZ0gHVq7LNZ//a+aQxto5V8DiSoONBgXGlFkRIX6jp3hCFavODEBs9VA6Ltqy2IbyxeXD7/f+aLB5p313pjb7J+VAI8vtx+0bKXlQTPZjxjVcUC0v13EDgJhiHPcQxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658309; c=relaxed/simple;
	bh=nvIzn7oVbV3QlBqTXXG8JwzeEDEpJ1m5+6x5d3KATLQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DcLufMoJCA5qaJ7mWdA6TFWd716yRlhJp/mMQr4Tr4aOTRTiGOfM3wM5gGjEyOwOHIJNJe5wpVnfBbkVaKSpTmEWX0VNefn+0meC5RUGhrBIv7oAToGIGBDYFhEVJTEOGlqMusfiqejybECw53Jz9djdg//ZQEmB1RRwcQkrp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsnppaVi; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsnppaVi"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d23a22233fso5594041fa.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658305; x=1709263105; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zyv4HE+62H12UhKwJANnJSL70xjGQPKa7udGRWyRwEU=;
        b=fsnppaViH/dIF4UM/lpcK0QIOMGIffo2qityVlyxTmN4UxytSIZmYIJE6sngzIXL1w
         xQI9jZP+3a+SzdnQGI2Ky1IxFYfHl704pj42Bo2IS8Owxxl/UcinBWarpZiswwj6QpbK
         fFOfGKGyOzq/Qk6Bjsx0pHWNI66L2GDwX2Y4LU7u2nAPWev0eTcrpkE15PzEtsvqqxZc
         WYiEwRt0TZltxwxBplndkYe8Mtf7lvSlG8lB5c46cr0RmlntJw38dYMfJG1Nk4Bf4bBx
         QtakQKOdpN30D1yeuO5cUsjUOpxGoOYXHB+cjkZxnEqS8MVFutvqrk6UsZGHrDXjxZ+9
         5TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658305; x=1709263105;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zyv4HE+62H12UhKwJANnJSL70xjGQPKa7udGRWyRwEU=;
        b=jE+hcXub7oRS9IKg9ckZolZ8YPLRFG/5t3BTzyl9Iy/gVkNgTpqv38agR53JmfTiJ6
         ubz9TUaGj3eC/wcEbIf0mmCSnOKryPmYqJRrRlO6yYrYjgdO942274k7BEWwOZcT7BQm
         hz2JBDGcpAeeT+kzc0Y4lqVfUYGWssQAIZheSfoasFpT0sEB2mVfW0JBFvLyvswn1T2W
         HNESruTa0MA8QYaC5b7RW5YU6amfeqCQw29F2bCOcgCtM/Ye+cK5yfL2p7l2UDwNB5zN
         kAcoqUu+h5QNHbp4pRUGtGoQQ/Hb4JqdEyWJh2OKtAWgXYN2VBbIZ8v2RlSGOQdxoVFL
         mueA==
X-Gm-Message-State: AOJu0Ywxm0m+BbHv7fGjd9JyKb/2AfDhK94gLhzVmbxAWycPiKHEFggr
	qbxNHdi/00M5lIIcGJamZLdD4PAxe330I+fQuAG9ynY9mVmrMnyFV2923e3S
X-Google-Smtp-Source: AGHT+IFmMHnMSLWwLbjhn+y/EpV1Q8yDT9SDvyGbsyjLyE/cn1pcFSd1U7cL5xJZj9T0YGvbNy/QUw==
X-Received: by 2002:a2e:9e85:0:b0:2d2:4703:1ac2 with SMTP id f5-20020a2e9e85000000b002d247031ac2mr490775ljk.32.1708658305582;
        Thu, 22 Feb 2024 19:18:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b004101f27737asm574716wmd.29.2024.02.22.19.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:25 -0800 (PST)
Message-ID: <dad079ade7f8817f235d59c5339b82aecf4a17db.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:07 +0000
Subject: [PATCH v2 03/16] t7527: temporarily disable case-insensitive tests
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Add non-existent "SKIPME" prereq to the case-insensitive tests.

The previous commit added test cases to demonstrate an error where
FSMonitor can get confused on a case-insensitive file system when the
on-disk spelling of a file or directory is wrong.  Let's disable those
tests before we incrementally teach Git to properly recognize and
handle those types of problems (so that a bisect between here and the
final commit in this patch series won't throw a false alarm).

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/t7527-builtin-fsmonitor.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 3d21295f789..4acb547819c 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -1051,7 +1051,7 @@ test_expect_success 'split-index and FSMonitor work well together' '
 #
 # The setup is a little contrived.
 #
-test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
+test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
 	test_when_finished "stop_daemon_delete_repo subdir_case_wrong" &&
 
 	git init subdir_case_wrong &&
@@ -1128,7 +1128,7 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
 	! grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
 '
 
-test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
+test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
 	test_when_finished "stop_daemon_delete_repo file_case_wrong" &&
 
 	git init file_case_wrong &&
-- 
gitgitgadget

