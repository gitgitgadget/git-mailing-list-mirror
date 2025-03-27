Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F32139A6
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076400; cv=none; b=Ai9Ul73uK56ACwJdmQmvw7hCJuepU//UXH7G6MgIVMtCNxZeFallkafucXLGmWGX6rCpTVQSv2ZOljd/pgyhpLOGCxduFpk0LDNjcAUA7Razw8I2xSUoQOozqBtEPRZdLQuOxPZZcapRM0PbyHYrvoieVSkcwqj/4Mzo/tMq/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076400; c=relaxed/simple;
	bh=jxONQ6s62+5sRT4ioUjENFFii3OSXI5UZe6sbKzOSfU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K95JsWxA5OHvGy9u/ZUKCJ2ooK0vM0wCRSacWYuQpPBfQPBnnwmGgXD8q48kcs1v0mGb1h6b58BbYRrdiM6Qo8Wm22fL9iwkjjxBYA41T8UjyAo4tXKM22KYZ9xjynVyJB830jhdnucZijLDRgWVbIIQvMHRtEM7A1s+gpLSh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCtPszb1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCtPszb1"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso9240975e9.3
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076397; x=1743681197; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYjefgmN4vorNNHFzM9z/rnT9aBHiu5F3geZIfynNug=;
        b=OCtPszb1lqp8533eG11IzkTEzsS404XBvYs6bcEPbpDwhz7rW1UFZcE9OvSY4nJy2C
         7Vjlum3ycKqpZk5DyCCvzB4FJoR7mGSbyD/TddwR/nKi+9M5uiwE5ZoJu3iLwKVOAEU6
         vkffoGmKfZ8iz7QBHa4cacy7PEEbeIWbFkdMeVIo+PbFpxwllSW/8UKUDmpC5TY4Ar95
         lP6UozID4sDWpqRjPbefsg1UOqDWIOVk7MjiAAN2NJLTEEc+LrTSwVk3sLAzsd8sV/+1
         vfwVV4t8a4273hDGprAWfNErTsDuJIQRfNfVj9gVKKT5HRdZQwD1g/ku130LXQaPI92l
         1YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076397; x=1743681197;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYjefgmN4vorNNHFzM9z/rnT9aBHiu5F3geZIfynNug=;
        b=xPVmNJum+rkUXHV4jHIqL7eDcRoVVA7gjT5XQMdgpnGfMXM5zJdXWHQKRjK8vKJA77
         Tkknxcawwc5GD2NJcLGFA0lGHD7zxrgNGD+QvRqmcYkr43X0Bd0gSIJfPpTUNCeJ3RFv
         JMIa9uwG/zousysMB388IGiw+JN65fV9TXrSiabFELJ7rsJXOVNhkF8ehaEw+752Ds1P
         lui+0qJrycYbKSFcrP9nvSItezgUEMONfQv9ksoVzmicBM8pEyeOgXEeWXrjSxe7zHOr
         Xk6Bo0ywwq2XwTtXrDShqjjbVSqZzM3PjPNA3IICBJlhJqzeMKPf9F43xUoBEmsN+ltU
         90AQ==
X-Gm-Message-State: AOJu0Yy8Es3SLp6JnB5NQtfPglXPfUTOMoInKoVi73rDx/K1k72avbbD
	KIMjqe7oh4017K3ko5P/nitZEZ10liPLerPltrPq/mlqg+WEQw2HMy8UtA==
X-Gm-Gg: ASbGncthqoXLwk3VTzij5HwFMWjIgIutwlPVqYCZHD0FJgaxiJPKWFQp5rHGcCk7C2E
	Nz66lfoGeveLEE1EndBndYZDG1udGK1917+PWTfyTY5dqWKWR52ThlqqYmW3j95Wg00p+ItXY+J
	xbWfPsBjoAIa+IFpS50f/y1X7UKZjuJDf9i+DmmY1L9hW9ksFRnZVPj5TN3WI4kSQnguCghdQP1
	ezjOFdYvLBBpUPFEUvwox9tKj8onBI9SQIN0MmN8sxzVAFLID0pXMs9IK8ADoUFvTV3k5ErlIAf
	eqwPTDkq60Nle2pdwAgK8ZMlPE1Oayd+QlXy2SahLRHPPQ==
X-Google-Smtp-Source: AGHT+IEvrtVRWhveU5k8ll/zis7zUgbb6q+52BrS3kvt6nND0Foupl+uiV/axWPP9yBQ2i7PZ0XyNg==
X-Received: by 2002:a05:600c:4e46:b0:43c:eec7:eab7 with SMTP id 5b1f17b1804b1-43d8801a634mr27685335e9.11.1743076396689;
        Thu, 27 Mar 2025 04:53:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b5536sm20264847f8f.54.2025.03.27.04.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:53:16 -0700 (PDT)
Message-Id: <77f1dcaca1c9df9e24880680311e5bb3eaeec1f8.1743076383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:53:03 +0000
Subject: [PATCH v3 10/10] detect-compiler: detect clang even if it found CUDA
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Chris Torek <chris.torek@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In my setup, clang finds `/usr/local/cuda` and hence the output of
`clang -v` ends with this line:

	Found CUDA installation: /usr/local/cuda, version

This confuses the `detect-compiler` script because it matches _all_
lines that contain the needle "version" surrounded by spaces. As a
consequence, the `get_family` function returns two lines: "Ubuntu clang"
and above-mentioned line, which the `case` statement does not handle
well and hence reports "unknown compiler family" instead of the expected
set of "clang14", "clang13", ..., "clang1" output.

Let's unconfuse the script by letting it parse the first matching line
and ignore the rest.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 detect-compiler | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/detect-compiler b/detect-compiler
index a87650b71bb..124ebdd4c9d 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -9,7 +9,7 @@ CC="$*"
 #
 # FreeBSD clang version 3.4.1 (tags/RELEASE...)
 get_version_line() {
-	LANG=C LC_ALL=C $CC -v 2>&1 | grep ' version '
+	LANG=C LC_ALL=C $CC -v 2>&1 | sed -n '/ version /{p;q;}'
 }
 
 get_family() {
-- 
gitgitgadget
