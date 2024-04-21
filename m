Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1531B5AA
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726904; cv=none; b=KR/UiVuN3UtMA+600f92CinX9TIfBsIxHJDgIRv/Ua6MUGDh8TNnbAh2IVibvlV7Jb5ACKR1/PzS3ng2qmPxRi7HZ6QjweKUNCCUOKjvXP4WOjSEI4XCGiGlpGdqqOsM2XGql/1gUy7a5YR0uh76zJg4nr/8GWjh5z1q7bvJZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726904; c=relaxed/simple;
	bh=IX5X81iAxG6heOqfcG/84mGPeiRcBMuqh019aDpx5bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0coLjrC5LhMMp79RE2m0iduqmowQgAgGCYuUgZHhJs1cJC3IvKbsK6rnhXjVuD7/3NeGvN/1iXB6nDOLaEtf3mW4PWNvXRj+kDWfWaqZ0+6FzekzcPd7aPSGCVApMO+JiVqGpGvOi51gfr30iV6rVW9Zx8hw5u+wuextX9DMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=b/MhpGPn; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="b/MhpGPn"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343d1003106so3003757f8f.1
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1713726900; x=1714331700; darn=vger.kernel.org;
        h=content-transfer-encoding:parse-options:mime-version:message-id
         :date:subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLRdslq9ly96p2Q/q+xvPZbxO3840bB7Y6JB2Ta6YwE=;
        b=b/MhpGPn4mhDjJuOWEGOebfHfKV3oaIMqfHrcjqoqQU395PbraIVhUXDRGWhOa21tC
         92QT7sUus54554CXVlufEOjFedQj5pdyUWayZ2nJzv4fkDRvtwK0Q9dK0qUlMoeON9It
         3SpZ/wr40/6AqKCjdP/RojoVCGqKyUNPNnozsBc35WMupL7fecbVD8sTRdAQR4qJ+zus
         3rhiwCYZwqacUU4aPkWeyrUWCvyoSuJ2csmuYYYhfNEprY+dU3H9nCN4vQztcTHe19PB
         DFMBq9RQhgQTug5r+hkRk9pQbgTrv8SyGS4t/8/SDauPnq8lF7yh1uXu7DqIh28j7Yor
         qZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713726900; x=1714331700;
        h=content-transfer-encoding:parse-options:mime-version:message-id
         :date:subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLRdslq9ly96p2Q/q+xvPZbxO3840bB7Y6JB2Ta6YwE=;
        b=QZXxok2ct+xfwKjF+13Utw9VSICCSDKGQgGp4JcQCDNmtZ2mDlEGNL7i/PA5XZyJVQ
         TGZ5/BNCkzoDT3ItaNPB6uXrwNvBqzwCOl4muHD5u58AIJT2dfLr8+5FWVGBMG16Pq/4
         JQaeOWtib3XQib89J/Hctxc87TzQQcqMK044sKv8tvRkY3H5I3s07n/91NzHOSm680FT
         7mo2fa55VZAEsdJrqq1W7+WgaFtgfvTgeyfs0BtpZbnHHlj4/5JKpyMD8ec0VOIgCxjA
         x0Fyc5YJ1Uatu2bqnMGQPxk4SeXyrTyrAPj+9oBwCcPKRfXamybTgMEy969CJMHPWgaW
         HJBQ==
X-Gm-Message-State: AOJu0YzqUidrWgzlQeTM5QaQD9c3Qc6DsGZFFZfSHx2simPf3GB3C8vw
	hZ+FLoygH4IInnESIYsGQlQdiMidymxY0kfZXxNryIz7ZUYjjqpJhIZ8C61zr3iS3ily922//BJ
	4Vc8=
X-Google-Smtp-Source: AGHT+IE2BODTm6CRBVrpW6YTz2DGz8zacKq2JwtEy6sykBqblfrC42MPQctKN+eGntI5Bf4GbboSIA==
X-Received: by 2002:adf:a4d8:0:b0:34a:3fcb:a564 with SMTP id h24-20020adfa4d8000000b0034a3fcba564mr6718794wrb.31.1713726900008;
        Sun, 21 Apr 2024 12:15:00 -0700 (PDT)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.154])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906091500b00a5216df5d25sm4826659ejd.3.2024.04.21.12.14.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Apr 2024 12:14:59 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [[PATCH] [RESUBMIT 2nd] Consistency for substitution hints (i18n) 0/1] 
Date: Sun, 21 Apr 2024 21:14:56 +0200
Message-ID: <20240421191458.5411-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
parse-options: use localized substitution hints
Content-Transfer-Encoding: 8bit

Hopefully this is the 3rd time and I will do it right

i18n: as translators choose substitution hints applicable
to their writing system, expose the ones in parse-options
for completeness

Alexander Shopov (1):
  parse-options: use localized substitution hints

 parse-options.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.44.0

