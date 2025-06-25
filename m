Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1225B30D
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856167; cv=none; b=OoJvWO5ay1dYrkCQI7w4Y782BOwEp67xJ69eMrAX/GWZWETbDyXsDobrNdreDCIc3vPdah7Zt406Uqk9suA5Q2V+UUq/wx8SsJqfY30pxCHCSpoRG9rpzmo+zxSMoq6M/u2/6iKjGcpL23Cm0UgGXS9Q6UBX0FgLZ0tBdsag1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856167; c=relaxed/simple;
	bh=x/k6IKpc2lzENTfkIzkVSQz7ENHFXVFBRoUHHPiYPxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rwb66yGrdBsqvLQjqz043Jsdb4QlI+2cMrcNqsZPBPFrEMLE9z6e0JFSSUA5k3G42X8t4s8WwNPnP0wjrPA3UFAXcXd6xpnGeehc4mdQUmSon2NyLeJ+k6ELVV/2p3PBj5TNNVIg+8wc3rayA6TuWTj7+Kfi73qz++ProSdEyDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3Cv8qNG; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3Cv8qNG"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-23649faf69fso66825845ad.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750856166; x=1751460966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYly4Eskv7yFmfFX/k5QnX3VV5Ti635K7fCVPqCS18Y=;
        b=D3Cv8qNG+ayLLnb2OQ9xzpleIpQ1YlXph7Asmg7Bi1DS+8XNwdAmgUJBq4LG7CvTiI
         JSpZtKY3h7N2z8NdjcZuXpx2nG8QHbrtXADmahDm0PNUpH2pThLZNa48RlYL2Xh+tlWg
         vakFX3b68+PWZ2o1x5NQ8oFA7PndkKNGY+PHukECISF2HMX1+pyhtwtah7Dm0z91THHJ
         N0gmLqujfHoXUogevrLkZWwQsXywtDZHa93tBttT2/V57zy/PW+Jp2mViJWNEYnGtUVd
         ml1ZZ1d2/AFwZb1+JG7OeEWvu3LLsoebBd/C1crI9YuIk7ysSvsk0JeRD55cWhg6k3jr
         ASqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750856166; x=1751460966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYly4Eskv7yFmfFX/k5QnX3VV5Ti635K7fCVPqCS18Y=;
        b=Z0FjbHjmJ4eLdMKhIyHYHiRsnfPyX6om0qq8KbkdEbtgZrYHKnlfYFU1MJdTfe1gwT
         mzA0ICHg9RqJGtngfsZMoffGRDLSbYu9oIjUqJOEHsKzYQr7beSDvyNFkweXGoBuDN0k
         KDOV+9XxlJy1StRckWcOgUJhqvmLN9ErkEFwGJDo+wRCmuZK9AVbOiEHqv6VWWtMsPAF
         19RAd5DpQaMV1gIxFVgvD604weormU7JmiCndhidRt3/smAevQr7x5QHuL8defCDHih9
         5TlwcdHzjiagFGQU3afPp/4O/GTYky8JSN5cZlfUhVfzeOuPCTPI/jndOoQrOxp8dKvl
         mZtw==
X-Gm-Message-State: AOJu0Yzs0d6IUuOggycICCCZfcZckG4zxGxpUsj5R3NOVAy+VQW+TmU3
	mBhxZ97xsidPIWs/yX1Tfk95HZJgv5qLT+l3d8Ejo2uc6HY4ugo9XVAaztWJhWjXVdo=
X-Gm-Gg: ASbGnctdAR641vnnSPmotRiA5ewgo72QsiX1z/WMQSvQ7Rp9acsdzoHbFeYbHKgwvJJ
	32bhHU6g/IbS2gT3Rfso1MD7aR+JUS1+oFZN9k95ryP7e8+NzoGPXFwMHj95KYrluogsCK3zUf2
	IJKS2zapPreH01pgJC5y/Q4N129mPdxmPOt5U5FMMQJ9f/r1QXziXy7TtsMmv23XlEY+kgzEv3D
	VFPtn6eYYxuDKV5b6b4WcdDOppOE4BZVcOGM1YyKMgZZNkm3RNUB7cSjMziq1JvmAww3NbGzXRP
	N4ddUNIRyLUHeuZAAh8ATsVUAaqoPCEDEj3daBJ/flaBXDceKr5e0d9VEzuu1igLN66U
X-Google-Smtp-Source: AGHT+IFAvfLRpAL6mqQ0NkE4Bo2hqZTO5ueEuwe2RTBMqPcfjFviT8mnePFm3MsHjxuTffwel9ILbA==
X-Received: by 2002:a17:903:3acb:b0:235:e942:cb9e with SMTP id d9443c01a7336-23823f95760mr47634595ad.9.1750856165285;
        Wed, 25 Jun 2025 05:56:05 -0700 (PDT)
Received: from r760 ([188.253.126.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8391494sm136312145ad.1.2025.06.25.05.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:56:04 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
	Junio C Hamano <gitster@pobox.com>,
	Kai Koponen <kaikoponen@google.com>
Subject: [PATCH 0/2] bloom: use bloom filter given multiple pathspec
Date: Wed, 25 Jun 2025 20:55:39 +0800
Message-ID: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.108.g6ae0c543ae
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git won't use bloom filter for multiple pathspec, which makes the command
  git log -- file1 file2
significantly slower than
  git log -- file1 && git log -- file2

This issue is raised by Kai Koponen at
  https://lore.kernel.org/git/CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com/

To fix this, revs->bloom_keys[] needs to become an array of bloom_keys[],
one for each literal pathspec element. For convenience, first commit
creates a new struct bloom_keyvec to hold all bloom keys for a single
pathspec. The second commit add for loop to check if any pathspec's keyvec
is contained in a commit's bloom filter, along with code that initialize
destory and test multiple pathspec bloom keyvecs.

With this change, testing on Kai's example shows that
  git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 -- src/clean.bash src/Make.dist
runs as fast as
  git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 -- src/Make.dist && \
  git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 -- src/clean.bash

Lidong Yan (2):
  bloom: replace struct bloom_key * with struct bloom_keyvec
  bloom: enable multiple pathspec bloom keys

 bloom.c              |  47 +++++++++++++++++
 bloom.h              |  14 +++++
 revision.c           | 121 ++++++++++++++++++++++++-------------------
 revision.h           |   5 +-
 t/t4216-log-bloom.sh |  10 ++--
 5 files changed, 137 insertions(+), 60 deletions(-)

-- 
2.50.0.108.g6ae0c543ae

