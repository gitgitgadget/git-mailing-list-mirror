Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC21137C2E
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215889; cv=none; b=AVKSV1G12xEPuf+wQSGpSdVM+fWIHwBzjItSXNsUB02G15Q+iCkjY1jRyTdc6xvwNqwsFV+VXJE4DbnL+WRb0BVbBFZXo6cchhoSTpm53ryITXL6TSA5OYOaH/N/cNGaaPJowQicAJ4HDR86uumE1mKMCTrrgVnQcbjU0+QLxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215889; c=relaxed/simple;
	bh=BTTRQSuEfUTilgkDhPM8juh3Abvt9a/w1DaLJ8PoRoA=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=bDduXdKT32DbPt/JOkzwXHSWTqU0bio/y800ZhVY77v70AhQqH0xvjywXN1qPdZr6lSU2nGv8H8fx46/sY7ADzm9ust9QRvMu4EUGGRGuXufoMSPro2lkeEuCyHS3RMfA8QeFeZGO2f6Q3CNHSuyJS1so0qTrNhrS5J5BIV2egc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdCz9MfD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdCz9MfD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso85567485e9.0
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 12:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706215886; x=1706820686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WuSqF4TaIRoNxAz1JBd1E7Ix2TJGDnjoO4lYSEdap5Y=;
        b=AdCz9MfDNzYbPDDjX5Ic8gn0SNpAveUjs1ETxYi+0jTBOdOuvzIYSlu1neBQKh/qJc
         iEirdWudfN6rtk/6Bs/VmhpBfWeB57oJIWylBzDHa9gZvAVMO4p76XA6xAMPgBgyNuLB
         WuCCGeExJDxw1NrLrnMzUb3xonAo+NCLBmPM5+I/c+QHSMuyBy0nVrjupPsLUFCJCbPk
         fi+tZHggsYtyhf2rTvI4x/6RAzE7TMBonaDjUtCNZvJQFKATd0gIyhDauBFqXF52ax1h
         2H/eckPsrTg6qYbcnkOP6YKRLCrfrsQ1N5yQkLAuqtGgD9YDHWZ7o3q6YpACtZkd0oNa
         lJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215886; x=1706820686;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuSqF4TaIRoNxAz1JBd1E7Ix2TJGDnjoO4lYSEdap5Y=;
        b=Am8IVNPBYH9qAiWx6UJl98pYQMs35xoSVLk/WA/iB3ipW6QeS9F+vG7Ws/b+9mBo+K
         qhXWx1fiZn2+v+UOUKJEXRHb8UxMJwkZj9FCC0IODgAf3ssCJHB8aeNdjMC96RMMMGyu
         sQfn76bUKRP11VG15SKj3ZauHYSFhWJhk1meWFem0Km37B4fINzSmVn/0d9TT+XxcX0w
         Pnjr78RTWrZ72s7mPSSizDHtxMkjXOeyAl71dPxUr88aDw2KpReHT681TOeW/3TVfpAX
         tqWozVahJvjHoGVo87ffzWVAGemdcZ3asoRcDYrHb/8J2hrAKMtUVcXiixakQMfWPRiC
         Ebew==
X-Gm-Message-State: AOJu0YyaEl6sYlQM/GtSqtdTAW8s5mZVGtKSasNTAOnrkkW0TPaWiB9g
	Vqh/08McYAcnR2szcDZek1SON/ItjHRrQA4QuPy78hoJcNJnYpDc99jpeDwU
X-Google-Smtp-Source: AGHT+IGVBv7E2kb4CAt7hs6m+/eXEUg+6HysXCi5YZRsQly8UDuzFjcEgYa0Lev7uMv0JxtmgQFEnA==
X-Received: by 2002:a05:600c:2103:b0:40e:75d5:c24f with SMTP id u3-20020a05600c210300b0040e75d5c24fmr99922wml.372.1706215885913;
        Thu, 25 Jan 2024 12:51:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay41-20020a05600c1e2900b0040ed4efcc24sm580146wmb.23.2024.01.25.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:51:25 -0800 (PST)
Message-ID: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Jan 2024 20:51:22 +0000
Subject: [PATCH 0/2] index-pack: fsck honor checks
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
Cc: John Cai <johncai86@gmail.com>

git-index-pack has a --strict mode that can take an optional argument to
provide a list of fsck issues to change their severity. --fsck-objects does
not have such a utility, which would be useful if one would like to be more
lenient or strict on data integrity in a repository.

Like --strict, Allow --fsck-objects to also take a list of fsck msgs to
change the severity.

John Cai (2):
  index-pack: test and document --strict=<msg>
  index-pack: --fsck-objects to take an optional argument for fsck msgs

 Documentation/git-index-pack.txt | 19 +++++++++++----
 builtin/index-pack.c             |  5 ++--
 t/t5300-pack-object.sh           | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 6 deletions(-)


base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1658%2Fjohn-cai%2Fjc%2Findex-pack-fsck-honor-checks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1658/john-cai/jc/index-pack-fsck-honor-checks-v1
Pull-Request: https://github.com/git/git/pull/1658
-- 
gitgitgadget
