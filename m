Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9138F4F1
	for <git@vger.kernel.org>; Sat,  6 Sep 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757168332; cv=none; b=Eg0sHLrIDEIsRv4B1zdEfmbaiC5B0wwCv63dTH5Kdzuw9fqPwLfD9jXSd4J+b3A6E4l0PGtc5CCXfXxu6BE8dMWfMGzTS2tFNzfHVLYNOj6slzLT1zGpJNdW9K44UFQ8bd1h6tCf2AoTxoSx7/887obeabsDWcZiqgGHSVuuovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757168332; c=relaxed/simple;
	bh=4KwlsDB+ZiMosbK3hCWs57E5kUxJaxi66FE2KBAG5sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaIJ2+hHIjpVZhlur7RlYVyz9zLNfjGEXecHRH9q+nMopubhlrH4zW01TStKQYBpecmp2afOaYJoH2rdRXbmnqJMI7WuWPpsm9JmRXaWG02R8sdVYC9VN1N7xPJ3e0oi5LNz3tJEMvwVzUulKorN7VBXgQStNd6Ei6mQQ3yclbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9PS+U6s; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9PS+U6s"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso2747388a12.1
        for <git@vger.kernel.org>; Sat, 06 Sep 2025 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757168330; x=1757773130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2LDP64iIS1Kkim6feM0/4SgOB8UdpFATFoskzyVYTQk=;
        b=F9PS+U6ss2JazyUdM0Fm4QjXJ6bxCO5o6AbLKGqB2AscdI56GalVMfWJSQ/8aNBn6B
         t9ufz29NBLerOCqiGu7frkIBP1Ydrdvw0cgWZDkkkw4d9FZE1QgAf3NEnKul7sKGSAcG
         FRNwvxXLxvb1nuHnPhKFL/eOYWZPLRru3jo/XRnAQVe7PbExhq63hw6/XTQOWki6WrL8
         8w8kGyM1fvktfwIbSjNtezGtqRHlAPEbTDmAiaoIMyW3F3bxSrn2hvCz0jqd/LCpY6Mq
         2yvFk8EKyaxXVpTD3LXs20t+vtLkpHO6zkvBI7JCDcCiik+UFR4HgBB/l5Pe+GI3gMbK
         ipiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757168330; x=1757773130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LDP64iIS1Kkim6feM0/4SgOB8UdpFATFoskzyVYTQk=;
        b=hcCDQqV6TYk9ObAGxLAaEYHarx1RlgW3/1RGInCngrnr0yiOsXuWz0WvoS3Jic70tT
         a8BoghsdcrY3oAYQPaYVuzpfN1S8xbiwVgZBUAh6ac7xN7+Cttm3zzEb5sny3n62cMn5
         SWQMI8wE/I1mjbSkDy40bHwf+bCg+Y35ICnY1kaV9peXW+REGD186wpN0+OZwkGKtPf4
         rA90Ga86BGUHfqKE+XPk4zYJ4KLPxGC6UeQWqBSifcCqVPogqkOmmll3vyqz3pngenqF
         rrGdi6coXQECDL8VuS2YNjy5uOtGK3oIWSHouJczcbmMd/cg/bsMJ4f3ZL6mV96P3SrE
         nSiQ==
X-Gm-Message-State: AOJu0YxCenKuw5h96zizWRpAvdorppRyinKUV2NqIsYDjbnkl731J4S5
	HM3HpVUSfv86obEdn7nFWJTEs7I7PzUl0hWb5r6STna4vWnWIxSGjyPcccIcnj1i
X-Gm-Gg: ASbGncuvtRtjVgPc+Vyxvvild37+YT68jZVdElCPnNtUFCvQ8kA931aMRoafZW20TaC
	/vo5AQqlX3X4XRNLcqIRyn80NBxywfwnCIg2wLVgQR6Mh9XcpW1dCe4Xslze9G4cRAlKbeNbEL9
	ez+I6d6vGNDKli7YLraI86VhzBGx/dIjnhk25hvON9ZezX+wz3UoKLjBJB6o6ZFjp3uw/IYQTTU
	nodfk4poj/kAHx8bgNL64Zf93QM6zDyIJQuCT631T9kYmftdEvyxkn8AdGSMFhReXsh8baPQ8By
	/dj39YtTUL+XMD9Lag0KLIiV4TIyHj7w9sDTW86mhMxb/hr+teUQciE35T6bc9mzPgesUQR+Cf8
	c59Htg6anYC796z4OniW6zZJFVhYi206/Diwyo9vdGYR4fb/U50wUqITxfv7ECPP6hyiMGnqCKo
	Sl94X1uw5yN2KU84PeEBbf2rxS
X-Google-Smtp-Source: AGHT+IEyOD5GfgJw2RnYg+lDlCuRk7gwT7/LT6qSGZwPmjy5CX5XsYbgPxjTVBn3cS1+fh1DOTzqDA==
X-Received: by 2002:a17:902:f70f:b0:240:92f9:7b85 with SMTP id d9443c01a7336-251678f1facmr29266775ad.0.1757168329821;
        Sat, 06 Sep 2025 07:18:49 -0700 (PDT)
Received: from localhost.localdomain ([115.99.211.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24d4d0fc0acsm44626725ad.69.2025.09.06.07.18.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Sep 2025 07:18:49 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: git@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
Subject: Running out of inodes on an NFS which stores repos
Date: Sat,  6 Sep 2025 19:46:12 +0530
Message-ID: <20250906141711.64419-1-five231003@gmail.com>
X-Mailer: git-send-email 2.47.0.289.g160783314d.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,
At my $(DAYJOB), we have an NFS which stores different git repos.
Due to how git stores objects, we have started to run out of inodes on
the NFS as the number of repos coming into the NFS increased.

These git repos come from another service and there are typically
thousands of them each day. It is important to note that we only store
the .git dir and expose a url which is configured as the remote by
default to read and write into this repo.

All of these are small repos; usually not many files and not many
commits too - I'd say ~5 commits on average.

Historically, when we ran out of inodes, we had implemented a few
strategies where we used to repack the objects or archive the older
repos and move them into another store and bring them back into this
NFS and unarchive the repo.

However, none of these totally mitigated the issue and we still run
into issue as the traffic increases. As a last resort,  we increased
the disk size even though there was ton of free space left - just
for increasing the number of inodes.

We can't delete any of these repos, no matter how old, because they are
valuable data.

I was wondering if there was some other strategy that we could implement
here as this seems like a problem that people might often run into. It
would really help to here your thoughts or if you could point me to
anywhere else.

Thanks
