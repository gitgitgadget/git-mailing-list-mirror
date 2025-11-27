Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730D29BD8E
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205853; cv=none; b=G4WrT6ZyWnQX7olG6aSuNMoZpuV12ojDF/DBtm2SyK191Rt2uZoXjgjIdNQhp+4PxpZmERYdNCqD/9dEH0fP0K+q8dGTmFB9qamIOXmiQni9MjOXh+AJgIbF5dHHX5WZHlnxFdz+/HDEK2rd3rEdYDnG2w3nHiXPNHz03vIbtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205853; c=relaxed/simple;
	bh=aQh/GyCUGysBmE+zq4EP5tTFK3PeSGmgwCKCC6QR8/I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CCgYsm5B0zhTb3kurMn9aytETZsH3Alp7DNg45zyQeD0LUJFIP5z28wSGbMg0BgM+H/gsb3KGzw2WKnK0mLoaMnZi7u/Y3CYaukGDo8yKfDqFDY/GXaNI6znByneJRPQHisXiMG3eGCGkWyW2wpSEVpgV/hFStCIhRSGfg+WeP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7LHBgwO; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7LHBgwO"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4331d3eea61so1956995ab.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205851; x=1764810651; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHYGYtGhlKiTGUbngosB9bKwne5mzbqiWeKl6U6Ghwg=;
        b=f7LHBgwO7+V3yqhpDBcGUl5ubPbbbgUY71XmebPliG+ECxKCjU8K8HEBBryXlQL6QX
         3lTOpMiLEe5E+PLjZ1d/YZ6GSfmXd8+5xR6ERHRQOd6TIOY06iXYfS4JBJpa+3wvRZ6w
         cqbIMIlGoSgrLPzajzSWdbOariiIlY0AkfS2BFqnfdxMigoBqu8lgLnDKSwiMAmhd7EM
         RaLI2KxNjnoNU1HeIxDprp8N+VffZ4LaOk2WWwJ2nO0XKmrCSndYoRxygugi0UdXPqoV
         swWtLCiv6SEk1RuBKb+1fMNrPHbxR0D7t99E3qdVVmv6AlOnxg7mzivLoH3xZuPAd/i/
         vbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205851; x=1764810651;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHYGYtGhlKiTGUbngosB9bKwne5mzbqiWeKl6U6Ghwg=;
        b=N7pPt0yQZRjTEXe86V/V5Q1gHx8tUr4YuSi/ODtfOtPVnCsOS+CINEsbboF1TLXhQB
         qJ9u2ZbFPUwprODPTCsCyEfUkCYrrdihV2Q6K34nPt3PHEiglIOUjRycj+wSD7Z0x4AK
         xmrYSboGnwptO1TPeXPwnk4ijRGKFD1sVL8zffgM3FCmnZ2YEuuRAwQMUvb7pO2oz1Mb
         iC6T8iUdTs8ErL5KZ6rt9APCTO1lMs6LwdCHzThbOLjC6vBKm+sCAZJFdCwuZYlBP6Hd
         9T5LLPYb2KkWEunMX6SPdr7IHl840OdYCjtrucU9gZmfCukQVtGQSel2zytyIsI5c22L
         UsyA==
X-Gm-Message-State: AOJu0YwS8aiT8WVPejhyJZnmcgFsRCnGbJSFNhyF4eELJDcqIaT2ELSG
	d/cPEF5iY7MmrYP0d3aii8awhw8GsYo/2Th8BVtZj8h/WS1xz08o/wtiuet6dQ==
X-Gm-Gg: ASbGnctJvAbhAGsLL1D8woKr0nuYpXD+C/6AqSb2Ef+hMl/RYHXLGCw5EEfcT7oIvI/
	n0BUJ7pvQ9O3D6CGg8eqxBGWemq+kB6KeedlWicSHGRnxZELTgjwRf1WjcWQOkFeWbro5zhZqoX
	B7eNomzLtqLC+qXP1ZOQZ5T47/O+i124yacsr54lkUcdQyZ5+/Q0DnC5o0ElZb5FBDidNmBwWC+
	EZ3/dBLY4oWXF1Sprb4cNiIEAPdzv3jxr2DlxTWzgf6s745TuGtbTeNmwgp05iJSrA7cNTGQOWO
	JnCRxgt1/eWbRM0uZamlv0l8zVMb9zyJhj/9NZbJhJPA6lVRCNUtlFJ+AfRbCo+JTwK7T3YP6Uu
	dscesUqK5vCvxGWRaeWguelu9blB8kb1M4IxUrPvj9vvz0vHasJByIXeBBiwuLm1k/TXHSd3YZF
	AnaJ0aJGBDhoME1A==
X-Google-Smtp-Source: AGHT+IGvr9K73RIXUy/2DeBwcQBNRfFiyKMJ92eqLW7s1e9MYMi/sq/yPHmhS2doFf06Z9imrvO9xg==
X-Received: by 2002:a05:6e02:214e:b0:433:6f20:32cc with SMTP id e9e14a558f8ab-435dd065a57mr66507955ab.16.1764205850911;
        Wed, 26 Nov 2025 17:10:50 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-436a52e7706sm882305ab.6.2025.11.26.17.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:50 -0800 (PST)
Message-Id: <8649a6c0f6633c13fa1c0ae2ff05889043d1d8b7.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:31 +0000
Subject: [PATCH 09/13] varint.h: unsigned char -> uint8_t
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 varint.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/varint.h b/varint.h
index eb401935bd..a618a4b1ce 100644
--- a/varint.h
+++ b/varint.h
@@ -1,7 +1,7 @@
 #ifndef VARINT_H
 #define VARINT_H
 
-uint8_t encode_varint(uint64_t, unsigned char *);
-uint64_t decode_varint(const unsigned char **);
+uint8_t encode_varint(uint64_t, uint8_t *);
+uint64_t decode_varint(const uint8_t **);
 
 #endif /* VARINT_H */
-- 
gitgitgadget

