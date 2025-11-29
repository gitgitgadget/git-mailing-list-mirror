Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F13126A8
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440918; cv=none; b=jT22imB0EmvipsJkhHe/wrttcRUdxWO7//zyag0Ow7rBDyUxiT6DJdKAUl0pMyDVZMHdo1M5rm28HBs6vZzsIroPNvUSpZ+7AybUnRpvVirI5Yv5GeJ1D6veYD8Qu3IwCCf0mAYspgtM6SJQjU0JIX0mIKjOMGOJGXz1cDlEHfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440918; c=relaxed/simple;
	bh=4ikaidTQUswM7Vl1vRvk9Z7Tn6vFM8tIAzH/uuuXmn8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HbLONlFB2UsXgYejlo60kKpvHLlEiq7Ax6gdiAOP1BtR8lMFb+SBriDY2K8w0ZdkxD3DCxucopN90ltwgXbFLMaXLDwiGvICyD0bkYc59Z7NqUpvkS2FdTc3tBCDd7dglVU6mmwL1uKw+0LOR17X7Wg/eSb+jdUoyzz+GuzRAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jII7DBIu; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jII7DBIu"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b2148ca40eso338510685a.1
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440915; x=1765045715; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhYLIqJQiI29ooMc1E4iqbRn8GunyFNz3LunG6Shb0c=;
        b=jII7DBIuDYQPDXO+FUH6hxM6hoY1y/xB5MfluBj39P6Xv1hd6IBIiEPLO+Kb95k76M
         K3VAthzl9nD1Sw4HQGskeNxYidqDCP5v1DGkbd8lZV7kbWqFLSMw6Vo9rgsfi4Qd/a3g
         aLJHWsUd41nofKN/1lCJkBGEzyj8mHDPZ5lWr6QBDOXRx+wuBdhiEz21dLh8BZKjpWUQ
         9yHCduxp3DXPaIWiEOiik1g+1UsfNaA+Spd/65RqG50IH/r43WosjLM0zWc/Vxxc7icw
         4AOT0Mqh+rzt6rMpgui8Uk2MbrJrQeBdXQWk8aTovp37VhG6Po/relwRqUIay3fQR3dj
         sVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440915; x=1765045715;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhYLIqJQiI29ooMc1E4iqbRn8GunyFNz3LunG6Shb0c=;
        b=g5AUVqCWO/SAzsCkLKjg2eMdJA4sezbMHfrARFUYb/yI25eQW7eJnLbvyKG+FSXSgf
         SL50wXIpb3Q8lj5aqO+thAk6V09GbdL2VAIRKuQviz0W8rbuFVrlXV6P7j9GG20tI9Ri
         0XKl+UwyFGFx+SMWcbqUv3aPexBvjCLp9XErKtnrcbJLJB7Jr9EzGTcNP1SxK5I/7jha
         feqHru3yQiODnMb/zEB9WCxTikHGbHi68GHTNd1XwPwIQDGn7MKEXkBPP2UEJr4cRH6Y
         3M9aFuYNs2IRgtzM6obsWt4iYN4IDVTydDFp0Mvq8qjLTfP8hF+imFkCZES0tmedUKxK
         3WMw==
X-Gm-Message-State: AOJu0YwkudH0OkFM4w+i/K27d2H2/qGb6oOONZuFPCzblKaxfm/f26ma
	5xooxfUWjVQdOEgD19Yap8+rvMBkb5kFe50kkoSbcnnD7WeYaUMHD+UT0XIO2A==
X-Gm-Gg: ASbGncuSAGP2oXMxgsK6TVoIeevvreTfyjMedjFqqR/BJpMUjcY2ad1EAsaFa5OFsgS
	elUaJAYpmGG2JXB2QO+64p2VnnUTEmps9xWP7mVphJgEUQ+7sSumBMN60gR6VqA0G5lo1hEiMj/
	JVo49ELGRfdZOlCkHt5IiB5OQ+kPYLjm4btfKtWWaLN1K6bfqEpbd/88ZLJniIWXK//dajR7IE3
	2u5FAjBTqLFMAdEYofiJ31CcJl2rhRxS7nAR7arxZ9JGSO6lvQuq66GpgJK6Kh1ym4nigsa5aay
	w4z1m7E85AsSoDDCcPYil7wlABNC/ZmApMsPB0+zRQC7f0QgI6FglmzXGU1v/0cm3RNCJRvgvba
	sqa7EsDAirXweoTd9dGKt0DElRvuWR4QyrD/LTADpiyHbNdlhkxG5gmFdmDThdHaD1HepaDcOVT
	kPOvG2/Q4s71v8
X-Google-Smtp-Source: AGHT+IGGjXIhXTpJKy2u7TFZe3v0CtusBgxpxSYjzov+GHTn/wAT+B+O3lq6ka8T1FF1slxPWTBTVg==
X-Received: by 2002:a05:620a:4113:b0:8b2:d256:d064 with SMTP id af79cd13be357-8b33d4795bamr4286231085a.41.1764440915307;
        Sat, 29 Nov 2025 10:28:35 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b529994c8fsm548347785a.6.2025.11.29.10.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:28:34 -0800 (PST)
Message-Id: <c59a5f24789cff55819caf92d828256f2291b3ff.1764440906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 18:28:21 +0000
Subject: [PATCH 05/10] t0301: another fix for Windows compatibility
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

Just like 0fdcfa2f9f5 (t0301: fixes for windows compatibility,
2021-09-14) explained, we should not call `mkdir -m<mode>` in the test
suite because that would fail on Windows (because Windows has a much
more powerful permission system that cannot be mapped into the simpler
user/group/other read/write/execute model).

There was one forgotten instance of this which was hidden by a `SYMLINK`
prerequisite. Currently, this prevents this test case from being
executed on Windows, but with the upcoming support for symbolic links,
it would become a problem.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0301-credential-cache.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index dc30289f75..6f7cfd9e33 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -123,7 +123,8 @@ test_expect_success SYMLINKS 'use user socket if user directory is a symlink to
 		rmdir \"\$HOME/dir/\" &&
 		rm \"\$HOME/.git-credential-cache\"
 	" &&
-	mkdir -p -m 700 "$HOME/dir/" &&
+	mkdir -p "$HOME/dir/" &&
+	chmod 700 "$HOME/dir/" &&
 	ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
 	check approve cache <<-\EOF &&
 	protocol=https
-- 
gitgitgadget

