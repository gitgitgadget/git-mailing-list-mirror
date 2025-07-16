Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F632F0C5F
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658765; cv=none; b=HDrChTgaws3pSt0l7X4Q+iWlcT4Ve7cVfC3FtA/SpqP+I1zSEj73LGoMO4yHWx/EpAzORrRrcv83jhQ4OUvbL3vHIrsgefO1XmqjR1RGeOEgT+AuBCWo+d3RO5OR+KMEyyyDRDhLthAVOCZ8z1Xi5+mw+2bs328F7b6lnWTb3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658765; c=relaxed/simple;
	bh=a6KaXBTremdGWUtYAAD8ddJc7lr+xBd71GezDTs+zCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQowPaixBnhmAO1RucayU8MVZlTXHR0i1zoannOGDX5znuZpyt2Ulm2B5lfvUBrnvPuIDu8yul3NMUWkDeRdfGauMzqlk0lTbSNzMvpu+/iEm5HZuL9GQ4lJcHd9rdO4sGovQPwlUAhSe9jO05O77h8a+3F6895nwBX0cyGdhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QE+smZF6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE+smZF6"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a54690d369so5153825f8f.3
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 02:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752658762; x=1753263562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RID4KGBlDrKiiaezDhkDFV6vZnEma+TKoXvlSeyv0EY=;
        b=QE+smZF62tG31JuMsKZW+huHTgiqqaWiZqlparJIQQ0SQSZ+itxYW+joohdu92p8y4
         IB872I5AyfZpOMD8qK2ZQYZy+XlEayi+twOLDfa93DEfhj7O/0hnWWO5c/FUglun5O5D
         tRiApvCp5KqAKbgyXo0DuSeaXSZUWsTzCi5jpCZjx3mkL7hIMq4oOfvn0fH6WGIghU5N
         Zu2YapnRxdwaJbFmBKAK9LSGLnNqpdn5iedeU0rwMoEFr3F8SfXJt5awBcUoXPf797uL
         27KIgdd/ZIW8YOCA+ljovP/lVOH3IJH2AQ9AoSXU7KcgowdRjcjXlEgFm8ivYVJcAjjw
         zVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658762; x=1753263562;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RID4KGBlDrKiiaezDhkDFV6vZnEma+TKoXvlSeyv0EY=;
        b=mxRQ4l2wL6oYOA0V1KrdnZOk11cpxZYb5KlPCVD6geDClDHrBgNAILRMO4kwK8TPfd
         5WvP3UP8WYyA4+xA3A6nNpC4lYXaviY90n1P7v4ZvXrv/tITjalsizrlZ7GkZlz0usS1
         iTHYas24hk8NZFY+Ns/gcy9qC/V/aVndivfgBs/dmub7ncFETISqCXYm4XQqXfpbXnOf
         PD9+HWpr4dTnFNd5VjAYtfrgESEXNnG7YOPH8b2FXX9sX3o3KD5RhiHFMI3FShkCjOJl
         kBFWeWNp6Cwe2Fc5tS8z91GRb67CaMdBO5SrrpJtpCfZbEraHI4L9H3atdxx3ohI1yoG
         IgRw==
X-Gm-Message-State: AOJu0YzBwadiWrgKiwrrjV/71EudgI8eSq7wxUUVxWopmitIbOARCGIY
	xh9vh63XGZW0R8idy1SZZ92W9LeYrHUT1SmZoVACscmJAgEhdoNGwrlvyKA0Lg==
X-Gm-Gg: ASbGnctFcRlkS8CuczyZXiclu8WaV0KRYU5jV+4VdLil7XaZu4qG1Z73F8KUl/GAA+n
	GTGhFMVxTsYWOYGKMrW3Tm066wFJomWNdRoiPA2DkE6OV8YSOlLc+OkkpVprSWUb4Wfzj/bAJt2
	mqAAHe6pxv1z5Wh5dI+HwCd6kHqNbzUpNTWTFBtl5ZncCbKkt1XfzCJhqfkxd43A7ZAsfP3nOGs
	MGON2WUbh6suMnv3dRDx/IjEdYniqIeYg4YrX2If+23CGTRu7tksiy1YxegbMQMHANiDW5/xA9T
	qOQ46OCy7w6HDaRqNQKP5LMcqrScz1QvY3t5MrxoJGItS0/AWTUJavO959DRYma9RNAllnsHpE/
	4nWnS6JNjIMe/jmX08rQWkmiota4+EwfoNhZ4lFmcf9gE
X-Google-Smtp-Source: AGHT+IG5MjEhaB2FdCnS8ddfMmKwwE112rFPyvm4HzK7h/PJgTstppeX0ULaov//9g0YvjgTfBnCEQ==
X-Received: by 2002:a05:6000:2c08:b0:3a4:fbd9:58e6 with SMTP id ffacd0b85a97d-3b60e517ff8mr1345664f8f.50.1752658761463;
        Wed, 16 Jul 2025 02:39:21 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802ae4sm15592015e9.13.2025.07.16.02.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:39:21 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Brian M . Carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/3] CodingGuidelines: allow the use of bool
Date: Wed, 16 Jul 2025 10:38:28 +0100
Message-ID: <3ff7ae61f45c87de5a5304b45809994bd862d945.1752658700.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1752658700.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <cover.1752658700.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

We have had a test balloon for C99's bool type since 8277dbe987
(git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
2023-12-16). As we've had it over 18 months without any complaints
let's declare it a success.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/CodingGuidelines | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 6350949f2ef..528b42d1dd1 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -298,6 +298,9 @@ For C programs:
    . since late 2021 with 44ba10d6, we have had variables declared in
      the for loop "for (int i = 0; i < 10; i++)".
 
+   . since late 2023 with 8277dbe987 we have been using the bool type
+     from <stdbool.h>.
+
    New C99 features that we cannot use yet:
 
    . %z and %zu as a printf() argument for a size_t (the %z being for
-- 
2.49.0.897.gfad3eb7d210

