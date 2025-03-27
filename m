Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B52144DE
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079440; cv=none; b=J0HFtOrJJIkJ0T2jFcqdc22835L8lDBDeJpi2HoGYYGJZUDn98YkKpzIwVyONRw/okN+FF46RrWnpfrSJpMXg3qLY2Eo44YvGv6Rf3euAstWpgwU++YzdKyGyrUwT7g/chK1xt45545NGHmCf3cfqVi8BKa3IoJIfw9xZYtcchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079440; c=relaxed/simple;
	bh=rnJxDOswibqYNmHD1rwN9R7eB/NV0BSl4QMFAoOvM6I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e5/SpYH4XnXLMenu4DHS3N1FW/doirbiel4jSxwT2Y7ERYS0dCkSI4xvWX+C+ART9pWNJ1+ru9Kte7+V/4y2JxEfnO76SwYmVYCYAXTJi0c4MYpoI/JC+NPMGIm6QqkqM8lpAmqi307fs23rk/UDzLu0nezBzJKRha6k3hAhNqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1KNjgjp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1KNjgjp"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so5830095e9.1
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743079436; x=1743684236; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hs9LKklgxOmXUC5BldmoUhvvuQB2wTBAkM89AYKqWY=;
        b=W1KNjgjpBCfzg2lyTjuVEQT/sQtmdXolsaqSs4nKtnZoYyKRtX0HExTfJr9lBxQngy
         83w6xKptsAAcktwDONpM3kEYKB4ot+chSE4xXhPMxomG5I35xzbQz4Ewf2MXXGuzxFjl
         iccnMHv5F+mLoqq1lULs1Kwh93E5SxsmPwm/WfAVvlwkwkhWLlCkuhgF7QR06Ahsj/Cf
         ucWXEnxS++RFWHBUIsvMmCDzNz40YYtATzreR6XQ4FaYtzwdPxFUVP1R0VhLsZ8gQebX
         NUUDKkEhQjR+sPS6qfGzwZYbTdJjeVu8RmXRNH6xRy/52k+wd+gSFhzkDjoBdSQHLF8M
         XkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743079436; x=1743684236;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Hs9LKklgxOmXUC5BldmoUhvvuQB2wTBAkM89AYKqWY=;
        b=NvY0fGjn8HUFZRk3857//MUPaJu+vcRmNCoMSOsOnk2DgLt68HAyFayX4mAVzbTlTh
         jYQWmu5oQlHjyw9zQ7Zj6v0MfSvaPUZLi3oYdjdpWWf+/Xr4LgaQYSXRjh92mtGFMVPt
         Xr9KfWgyBssdVLG7G15CQryZVlWOyS7TjjKTGHvy+eI5y//xUF8ykvzPJWw1EM+GmYo2
         Wvj3cJdNgfUCRHC/s9SQbL5j/42BjxIoV6prmXGlHHXPrPowQsdo+hsjN8aj2g/qAQka
         FnN8PDXm71p6qoNEZN1ZTVw8LGGMM4O4HFCWTpJfpTCrz3SvKVIa0H4pjPVY26VHduiA
         PxNg==
X-Gm-Message-State: AOJu0YwGprq6IWA/TTmqiWlHN2LVT+R6EE9Oax4eoFax54EqlsKN0TuZ
	LXj3cJuefsP+7+l7XUMkXaNL0QllyOCyXLmFrlH8Ezx6jGZMmpxfYqIDhw==
X-Gm-Gg: ASbGncv0tV1GOzQascCS5L1IX7D8vcbj4iDG/Fbrdp2gbJMU3VI8bA98dmD4F6rvCWr
	Vc39jYKh9Jw4X71p6IfjftTz9QCSZDtaMxtDLT4Jtlto/P5iIm1DJFSQDE9wjPm2JY3KUrmhOhY
	ZGBo+MnpK3cehq2TX6LNSjdZQeUBe8jTpVx5pZBMjB8qkrjcPRqay2e1gwn9NL28P5wUABJkMCq
	Y3GjD0gDyf32RmWJCzgTpD4rQhwiWj3BF0amJhjVa4d9nLYpctMO9XlV6BZbEuJ3/FZjIQis27k
	8cPU9L2br+oDl7P3WK3gs8gXI3q9lw+Uo12bWVEyVxxg+Q==
X-Google-Smtp-Source: AGHT+IEhYbC0Ubw+v5g9LZIepcrzG3n0VmHhhy1+twOD1ydYuhCI1qakjxAHM76IDVK45dv3pqCpMw==
X-Received: by 2002:a7b:cb98:0:b0:43c:f680:5c2e with SMTP id 5b1f17b1804b1-43d776e9f19mr62670865e9.13.1743079436523;
        Thu, 27 Mar 2025 05:43:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e6a63esm36840145e9.11.2025.03.27.05.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 05:43:56 -0700 (PDT)
Message-Id: <d630e95b9672e6b4b3114c077f2995c5170a6a8f.1743079429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
References: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 12:43:49 +0000
Subject: [PATCH 4/4] load_pack_mtimes_file(): avoid accessing uninitialized
 data
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

The `mtimes_size` variable is uninitialzed when the function errors out,
yet its value is assigned to another variable. Let's just initialize it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pack-mtimes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-mtimes.c b/pack-mtimes.c
index cdf30b8d2b0..c1f531d45a0 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -29,7 +29,7 @@ static int load_pack_mtimes_file(char *mtimes_file,
 	int fd, ret = 0;
 	struct stat st;
 	uint32_t *data = NULL;
-	size_t mtimes_size, expected_size;
+	size_t mtimes_size = 0, expected_size;
 	struct mtimes_header header;
 
 	fd = git_open(mtimes_file);
-- 
gitgitgadget
