Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37F0231C87
	for <git@vger.kernel.org>; Sat,  5 Oct 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728125293; cv=none; b=jmig88ivxRhvSRrMFLG1X0n7Q8lQCfVXJJAdKJMWhnFYrgo/AIPJ1ZLLdnK0L5gINpMrre0L+7B31D7SUSZ42tXqJGmhZY48orCMQB/0Ncm8GdINCaLOedE7ArRse+ZspZ9BlpKthiEezNAPwQ0+J7lGd2HVByfphC3SMMyM3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728125293; c=relaxed/simple;
	bh=SI80Ntcct84OMyB25+u0Z+3OyKA8XtDpSVw9iOP9ggQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=X5WHvA9sogpULfE4r2i6d4Nlo75ArxaFULxDTMx/USdZWipB+wXRQkqXBQOtTO4BVjwu8PmufiM7IPWe5SwiMyeUmMQEGrNZkCrh7DpRTDp2IPC2+wYjSDCYVmi/AXIGa41ARaXyXjdmeitOJUvBtOfS+tFcujeCQkGpMnBErKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFJAlrrJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFJAlrrJ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so3873358a12.0
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 03:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728125290; x=1728730090; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fiu2UA5aRLIJynw/9ADAy5xwXEUbfiBuFhqrfpWXYGQ=;
        b=UFJAlrrJCPmY88+VuEfhq+mH19UtcoL1Lq0do/79hcsDW0DutC0RzA1YBleBk2WL9N
         Se7Tdxw4guQcZ+oJ5fDeuU7WMxjg4RPia1wJVX5h3VONw2gg1aBFFpxHYmaEBU0JkRbC
         +5i9kMGJDnEJ5Czow9VmANQZesmWbgzKeIsQTyqKQrkUgp3RO7QhbBEWwtCjMgGu1bLn
         K/blpPPUr+/SJuVDXjZbb871Ih0g8Waqw9w+4qvjjcS02KKPwYUU8r2yeM8c/AZmQn33
         w2WrcRPEcv8vq0LYyVgnmWJ2fdm7UuAlthDNzUj8jhvw+m1COgZ/ZqFFOLfFNFZ5F8Iq
         izeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728125290; x=1728730090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiu2UA5aRLIJynw/9ADAy5xwXEUbfiBuFhqrfpWXYGQ=;
        b=S6BEeIoEdRdptBIyc8/e4ao1TEmpAy5OFxjC6XnVFzgB+ajP55+N5kzmQBYtWafcx1
         zaWgok4gV9bJEBf7r38IH7zyVws9O5+pFt2T986XspSQ21CPsdLOmCNeKvvFcYm+hBC4
         D51qW1xlYF9eFKqICfuVu8YfCxx9gUZQ7if1tuRE6JRog/KStQc1t6kwApJ2/BU3XveZ
         PsJMkntnXe7/HpUuaCvoyLZqPa1aC1vbpgWyNNXDzlAQHhSF6NdYYH1hXPqq9pHbF3qi
         2jiJPLeUhRXZ1F21HT3gbtzfo+KTOhwSu9Zb8piknjwW3p+QNInjyME8k7E7aYRbpiAA
         iGZA==
X-Gm-Message-State: AOJu0YxaxvMR0hVaKFJbzkea0V0MKrmsgEtqSq1N5pqtRSfFGXW5VksC
	JemvG1U3Bo+EKzkvvRIq0USjhVtXkUZZZsMG27Q3RbRvUzRyux4iGt8fcQ==
X-Google-Smtp-Source: AGHT+IGXM2s9OHvV4q/SXtD7c/haklXFJJSOUoW9rjpORnxxzDpJoHmZPkJ0fyExDE3iN6lfDnXtYA==
X-Received: by 2002:a05:6402:13cd:b0:5c4:a6f:9be7 with SMTP id 4fb4d7f45d1cf-5c8d2e397c1mr5051388a12.8.1728125289704;
        Sat, 05 Oct 2024 03:48:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb4b9sm887788a12.75.2024.10.05.03.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 03:48:09 -0700 (PDT)
Message-Id: <pull.1799.git.git.1728125288562.gitgitgadget@gmail.com>
From: "iamkb28 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 05 Oct 2024 10:48:08 +0000
Subject: [PATCH] Fix typo in README
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
Cc: iamkb28 <iamkb2808@gmail.com>,
    Khushi Bansal <iamkb2808@gmail.com>

From: Khushi Bansal <iamkb2808@gmail.com>

Fix the phrase 'with help of' to 'with the help of' in the README
for better clarity and correctness.

Signed-off-by: Khushi Bansal iamkb2808@gmail.com
---
    Fix typo in README

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1799%2Fiamkb28%2Ffix-typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1799/iamkb28/fix-typo-v1
Pull-Request: https://github.com/git/git/pull/1799

 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 665ce5f5a83..b764115136f 100644
--- a/README.md
+++ b/README.md
@@ -10,7 +10,7 @@ and full access to internals.
 Git is an Open Source project covered by the GNU General Public
 License version 2 (some parts of it are under different licenses,
 compatible with the GPLv2). It was originally written by Linus
-Torvalds with help of a group of hackers around the net.
+Torvalds with the help of a group of hackers around the net.
 
 Please read the file [INSTALL][] for installation instructions.
 

base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
-- 
gitgitgadget
