Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6022EF66D
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658764; cv=none; b=dam52ftAwILK8sPN/t0x3oJmZ8zoR+CCepL1cPW5Bbhjbe78NKYE0g/i++wA5MtnAgtaR4Wi8EWO40syb/6xPVxtP2MSkXqfr4ZSvJ2oUGK6T+CCLcSAxYfIl4yUaotTCd9aVUeib5Ec/XnAjG51GW3U075vfh8AOXQWElV4bYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658764; c=relaxed/simple;
	bh=4ygT7WsfIJd/H3IKbC4C8mM0S4gVdbhvBJM9ZN7E/oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5utYdMjxSOUSaMANCxM2/mCDgoSEJ49yhupAyxa8Gz7yjOTbqBMBr/EWb3qmDaZA1S4GKS8bMh25LyDedy8uwRtL8tj0HO73pLPqJsWmSMq0brk1Ub/OcNao6zXOvXL56C4OUwxtajfRNvmjYOqMfUt8USSZLcvQbTVlj1KGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHbdg6K5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHbdg6K5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso31651975e9.3
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752658760; x=1753263560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wAfUe2Q1Ec4gkgeVGfeTIjcrHy3Nhoa101v+LnPIVIo=;
        b=IHbdg6K5mf+5oapHe/3vX6GYYhmFdAWGSk9WbeJs8RnXqw4qTzMkIIKjoEYQhZNG38
         RX0ClG/7sOiqLxKEbFnIFNO+bVP+3+R/ldP5uV2rpuMZl9J5j9sijgxNZxqolxR/YkV5
         P/QDPa6MZTt98T07ykBqvedW9pwnRj95lAYUZUR4UqAVHbqLaum6NEYo4+skTPE4TONB
         1xmY4VxkttfGKi6zSwlq06jn4Rjr1wCf2DdAmhCm3yEm48ZhbP8ea/I5R1Ng9kd/ZXIo
         rTqeQMDP2D2p3feeNxaZA1vtdc71QVUp4qTlI7YCHZ8PPGtweLoVVAdjleTpDotrlrtO
         U5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658760; x=1753263560;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAfUe2Q1Ec4gkgeVGfeTIjcrHy3Nhoa101v+LnPIVIo=;
        b=VaaCuJKNrI8EOE6CEgDAkz6uu6oar/y35WtynFAKywXjGCoQpB2wC9ilA8eKFevj+R
         lQ6+llngMXtuPOW79g73XZSOrGyZO1hdnhW19Ju/nUEUH656sYQjqMOjtp6dpwgVRlHY
         Fz1TpE1izxNPmQTj8ZEvWmJQGblnos1PSf1k3jSRadGNbhp4jmoKbyyglaMuaRXFlxg6
         3XjTIWd2Uamft6SK23y8pkMBjKE7ZF2hC4J6n853Q/vyOz0Y6TMu45V+UNaGm+CzTHVN
         lBrx+oY8mvAQkUIduuEMgwEOHdgMtTgkkXxLFEUle/PgDeOF9MrYHUPmueW6BFza6PFT
         oFhg==
X-Gm-Message-State: AOJu0YzTJRabskJ6yYuVlAvvSpTpbiFpuySLsrEnYzyuBsOuRxR853wt
	pMrupLT6LmZRVT23OetVbIkARe6HXXNCR5SE9owxeYW5ss0phdpMOckvoxE7gA==
X-Gm-Gg: ASbGncu9YI86xjBU8ny7EZbt8mudrbxBj9fklOe6Z3mLAgJmtoi4ilrfBnfUvInhZdf
	GE45Q1FasZ/VXMR0NG1pVL6efpxEeyrHEt89ayPYNqjh5A92CV/UkV460il+7oE7qH90DYUH/du
	BiB5dWC6mW8FgWvDerTYcatFExAyzGNpuwubsCwbcpZgVJQDkakJGyscG1deyz7cfqEfrKxe/8D
	trgaHdlorRS1k1cWACTdQ+G3huGGPS5Uhc5OH7v1FeZLxsEztJpwZBcaet/i39cnbYTfRSSV3Sb
	kYCAzJ2HesebvjwUPZzgRkp1qiCi5b+Sx0RcJFemVceoDXXEapqPAbbULX24D5FqYjAIV8mh/UP
	xwograDrhupNCPbfXYRFwmNKD9NiZvZjOZ4pLEgaHi1c4
X-Google-Smtp-Source: AGHT+IE6r15JEioJmXmwdhHAjSWiZUYav/7oliGZLnusK5LxSF63D2K5SYQrFNEWBXW8hitkfiBaWw==
X-Received: by 2002:a05:600c:c4a5:b0:456:e1f:4dc4 with SMTP id 5b1f17b1804b1-4562e390d79mr19954395e9.15.1752658760293;
        Wed, 16 Jul 2025 02:39:20 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802ae4sm15592015e9.13.2025.07.16.02.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:39:19 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Brian M . Carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 0/3] C99: declare bool experiment a success
Date: Wed, 16 Jul 2025 10:38:27 +0100
Message-ID: <cover.1752658700.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

We've had a test balloon for C99's bool type since 8277dbe987
(git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
2023-12-16). As it has been over 18 months since this was added and
there have been no complaints let's declare it a success and convert
the return type our other string predicates to match.

Thanks to peff for spotting yet another typo - I've updated the commit
message for patch 1 accordingly.

Base-Commit: a30f80fde927d70950b3b4d1820813480968fb0d
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fuse-c99-bool%2Fv3
View-Changes-At: https://github.com/phillipwood/git/compare/a30f80fde...80e5cd3b9
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/use-c99-bool/v3


Phillip Wood (3):
  CodingGuidelines: allow the use of bool
  git-compat-util: convert string predicates to return bool
  strbuf: convert predicates to return bool

 Documentation/CodingGuidelines |  3 +++
 git-compat-util.h              | 12 ++++++------
 strbuf.c                       | 28 ++++++++++++++--------------
 strbuf.h                       | 12 ++++++------
 4 files changed, 29 insertions(+), 26 deletions(-)

Range-diff against v2:
1:  352f80c49b7 ! 1:  3ff7ae61f45 CodingGuildlines: allow the use of bool
    @@ Metadata
     Author: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Commit message ##
    -    CodingGuildlines: allow the use of bool
    +    CodingGuidelines: allow the use of bool
     
         We have had a test balloon for C99's bool type since 8277dbe987
         (git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
2:  0b2402e11cc = 2:  26c3f48ac6c git-compat-util: convert string predicates to return bool
3:  66968714739 = 3:  80e5cd3b9df strbuf: convert predicates to return bool
-- 
2.49.0.897.gfad3eb7d210

