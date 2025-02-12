Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5391DEFDD
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388596; cv=none; b=Ox1xx2/4aT1WwS2zg7kKWhJ6QPaiJ0ueRnfd6C1GCH3ekUP/NGzCke0USjlx/Pc703mGokUTFmBXm7b5UZkYim+fo4z6APBHDckL9W7nOYhtuBUV0Oib83umi9eCz8CpZI2iR51eZFcW30oE71d+cO/9hZqdK3+4PVxnBjnM+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388596; c=relaxed/simple;
	bh=AbvgQvbK4H8KDJnp5KH9MEOhxwYLp40XaVW1RUtjxXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEKkqc5UG8elLzStbsPjY/zOBFKIqN88FvJOq+2J35ECIs4PbywFxXisdlFi5eZ30EOmAJntLs4cKtcUn6t3r4kv+R+6HCv5AloGAGplKKGU4Mc17hRi268Vk8Lnbf3YyqpYROiwhxONb1r4pH3FNrXHJESPsV1KVKhdY/tsUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKYoWI5N; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKYoWI5N"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f55fbb72bso336845ad.2
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 11:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739388593; x=1739993393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIdAlKeNDmgLA/jX9i5pDYNOUb/oCteStZFghOR2MF0=;
        b=gKYoWI5N72DcCTZ8OpixiagrbfjUICbxcKbYL33TheIOU/eC3LQVnsBaCde6OITTLe
         xN1UwcUh7Z44Q04KnLp4etz/VydhI28UbXrBvaPe56Asipm5oVT4YHxJp1F/77NvvnAr
         7z7BAJnUT23RA6Jye0k8BteRTXwHM4g5zE4hlOnj9obEf0tph6qUHYG1NU+9zIzSCk5g
         O9Nl4SijQCnt7rg7Di7Vlv0ginjXztXj5KTGcopnY5eHWr7k04s6yNjVUNWyqgx8ztsX
         s/DvNsN2aDGCBWujiA41vRgJI79S/xaIYewWOdZHRSKFpR/T+PLB+1ELnNJvUOeQU9a1
         THng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388593; x=1739993393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIdAlKeNDmgLA/jX9i5pDYNOUb/oCteStZFghOR2MF0=;
        b=NC5k22FtG4Ix1ilJEhyVTAFbMEtWvfkov3YrZ7Uvy9fdxKLrZBCHwbqLt2Wabx8G4Q
         RbTGrK36qsFLLywNuGz/bYdr8qVaUidLGoRSCd9lMNQsNH8foW3ylMhziIYD9QXqJ0eB
         pR32bJ61Ghw6USWl3gCguotRdYNOQNhQqJvG4ywsOTT84ysWYAc0B2MT/ztiXJsXK9QE
         HDLwaA2ZOd2sGMoWOzpuZY3edF3TqIj9LRKWjBSR9KHe3n5T97SUSbOcUEgLa+dl0Q9A
         5SvELbQ/18AM32Eex5e+uHuBBdnFHAa5iEt+OPPGI70VrSxMOFetShITqaUUswzzxPT/
         fJTg==
X-Gm-Message-State: AOJu0YzdKjUHByRiBn5Ae3SxpmMn5hpA85uZVQnhZRW0wr8OpZEFbEuG
	4Xj2ouxypSASGbJaSIBJLjjeK1pyCezcGoX/pUN6VaW8OfbyvtIk+377sA==
X-Gm-Gg: ASbGncsfrauqbB3jn7QuG3Xd8aTfZQ7nm1vWTlOWDCza8tOjAJkLb9sC/MyZcZc8WXv
	4c2EpHc1MlEEqxDgFD/8WDScnKIMlssRl34mTxSVFmjDvLo0HxAxGcPVOUSoA43TXhHAUwOHPv2
	qYstpc7eMOLyR+D215ymVOCITUZJ8GNZcJ6+hxcZ8IcxRtVSoK+sgu09LdYnnVI/BkFdKQ6OMKH
	bWCOuD2mTyu9U/tC1SW1zgnscry/1qjQCaVuGnZXIftuaEYBFQ6e5RW52VDb8DDsH2HQ735lnLK
	9e59U+JVTblUFfwMv0jZb90b4Hm+
X-Google-Smtp-Source: AGHT+IEhiBKHkceS3wD0+o3hB9ZD3B0SsQ1DAOG0VDzWLzKrMW5lUn073eh0lZpn7S4fXg4kfL8r7g==
X-Received: by 2002:a17:902:ccc8:b0:215:9894:5679 with SMTP id d9443c01a7336-220d1afb4cdmr10259535ad.0.1739388593335;
        Wed, 12 Feb 2025 11:29:53 -0800 (PST)
Received: from localhost.localdomain ([171.60.232.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce87sm117633245ad.36.2025.02.12.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:29:53 -0800 (PST)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>
Subject: [PATCH 0/1] [GSOC]  Use unsigned type for bit flags in commit-reach.c
Date: Thu, 13 Feb 2025 00:58:39 +0530
Message-ID: <20250212192841.8321-1-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `flags` variable  holds multiple bitwise flags (PARENT1, PARENT2, STALE),these flags are defined using (1u << N), so maybe there will be no issues if it is changed from `int` to `unsigned int`

Moumita (1):
  commit-reach: use unsigned int for flags in paint_down_to_common()

 commit-reach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.48.0

