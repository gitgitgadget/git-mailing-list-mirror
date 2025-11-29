Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B783126C7
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440924; cv=none; b=NKFz6aEpvKgQnBbT55YpnjIknpsVd14hXtL9hs0EMC/YjwdJOCx/2LXeEkTk8qLJRYCk5oDGMknDx9fAi804FjjLfBBQLfcyqLm4H0HRAV8uyfs11ukGOQCPMJjjOK7zukl10nQLJFJ/u65dhcpAQgZE0QX5g7S5fuV2/t0FRG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440924; c=relaxed/simple;
	bh=O6EElKeKhS/+ysBMW1WfpuWyFSwKhNdEdQuMPUOF9X8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=a5JWOUyltpDMyeeO3LIwTYB6eSaO2hqUwwiUqoKCbqoLDKkZ7eKnpLsLb4gnicTFA9Anf2h0CQtCACjsB2fhWLJB69JhZEEA0Vt+OuxteQwrWwjEC6OrElO7rQXsoUHGAgSBEOH5XVqSZSSTL1t1KuLRVFOBcNk1UMLp/9z3bdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewaJzQPb; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewaJzQPb"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b25dd7ab33so174935285a.1
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440920; x=1765045720; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v95A+ZphT0efPuJgA2huEtwXQ34whmACedkSr3ysbY=;
        b=ewaJzQPbptv0o+fwUjH3OZGfIJhUWE55LDQ2eZGz+pGi2USG6/KZqsXi0/rPQwf+Ba
         FkowSelOPrIBWymbdky+YlLB9z40Y8cFM6NKzaWnVVmthZdt2gju2agc7wrpR+uGuKRz
         ZjvxoA25+P2nbzUb7V6L8+IAEELe34fQftoZ50YNaM1kNS6Eg3/aO7AyJuTf/A4rYcnK
         rU7YG9jkT9sq6aHPdY9BcspkmofGXtctj+8tBEzXENJHFFx8LD55N4WUA0969eCkvSSJ
         Tr05ojBGvRuhZTtHCo8Y+br0Ufi37QLff+IRHLduJXGF0zsRKPov4ki7JD6gx58ZIA69
         mHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440920; x=1765045720;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1v95A+ZphT0efPuJgA2huEtwXQ34whmACedkSr3ysbY=;
        b=KgfIaljdkG8rIeqQo8K9HwAB7IWcKu9yiXEzX5ZBZHtc+QBRJDRnQr4kyGtENRTCws
         aBB1Jhk7K7rwhJ6drqCntZ9LKpnoODms/O/8dTFobh7MKjJo4aUjQL6PYG1TGiE/VhNU
         FrQG9YvmhWi7GZzUeX4EL2pMROAkkFnh6a2d2ZRGkepY2kph3EaEmmq+mxBOCu/xXGtm
         vHN+gUvBW2tPFZoLT3R8kCzh7U50xIoOkGvZ/9+YsU3VsoeN3X8b2H31dDH3MLxkNsB/
         YtNmd2PNOWH3TCkN9OR4TG1JLGfeomVJBjk2/5V+yP0iS9fm+LT520O7Pam/ZGsox/5u
         yxaQ==
X-Gm-Message-State: AOJu0YwIMvIrF07okyDqO/9cSiDZa7jPpMwOdN8zE8tLDUpFQVFFxKEK
	cg+Y4PiBAjxr0BZdp3xxDKl4MV3p0f1ODoV0PNvi0Oi1SySQePW43jE3tPKHdA==
X-Gm-Gg: ASbGncskcRCoKUS1b2bb3sHi6Ym2pG0oHfcHkXCp+gC5FAp/euB4UIQ+6UTQHpZPwV6
	2Rg1Vsd4WJiVnZaaQra0NL6Y4exaB3o5WUfzyZFygvdZyg77N9P1kqfnj7jV9wRpd+XYrlpKyDs
	L7YChg3vYF5cuSgrk8zymRB0ivP1g/kBllrOpJigkkIXms4m/OGJHNJWwW/FNKrefAqL+ITcFb/
	VhSCpcCkjEiTj0oc2NfnWu7IPA1Ed3cRT+6KAQHOu2daHZZoH+a96NLZfNVZxEKcQHaGTNm0fqL
	63ZDSWhmqyZ2rA0lewmQCqIz6Pnq5fTJo5O+EgXnpKxNpTVPTwT9r31snuDXVC6c2N55wSfFPrh
	U8ZbY3+BhmqZB05CyGnCmVhx/TneZ0K5X33Emt1JmrnMTg9PHtrlOx2smjNiLTUmwQwXSYUAsj7
	YiH90FnPGwuXYq
X-Google-Smtp-Source: AGHT+IHjDtNwTGdk7sQNxtvvGscDNGFZsxHQ7Nl1qmJXJGV5yk9SI3hVgMApGX6igBO7ComLv5/ajg==
X-Received: by 2002:a05:620a:3188:b0:8b2:a0cd:90f1 with SMTP id af79cd13be357-8b4ebdad2d8mr3029378685a.61.1764440919942;
        Sat, 29 Nov 2025 10:28:39 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b529993ca7sm547239885a.9.2025.11.29.10.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:28:39 -0800 (PST)
Message-Id: <930828c6936c526a91059dda40960508bc6b80f0.1764440906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 18:28:24 +0000
Subject: [PATCH 08/10] t1305: skip symlink tests that do not apply to Windows
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

In Git for Windows, the gitdir is canonicalized so that even when the
gitdir is specified via a symbolic link, the `gitdir:` conditional
include will only match the real directory path.

Unfortunately, t1305 codifies a different behavior in two test cases,
which are hereby skipped on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1305-config-include.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 8ff2b0c232..6e51f892f3 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -286,7 +286,7 @@ test_expect_success SYMLINKS 'conditional include, relative path with symlinks'
 	)
 '
 
-test_expect_success SYMLINKS 'conditional include, gitdir matching symlink' '
+test_expect_success SYMLINKS,!MINGW 'conditional include, gitdir matching symlink' '
 	ln -s foo bar &&
 	(
 		cd bar &&
@@ -298,7 +298,7 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink' '
 	)
 '
 
-test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icase' '
+test_expect_success SYMLINKS,!MINGW 'conditional include, gitdir matching symlink, icase' '
 	(
 		cd bar &&
 		echo "[includeIf \"gitdir/i:BAR/\"]path=bar8" >>.git/config &&
-- 
gitgitgadget

