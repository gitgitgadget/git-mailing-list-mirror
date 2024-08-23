Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137713FD72
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401287; cv=none; b=axCzUsBf5Zq8UilH42oFekrDuC8VTZ75fAtuBE02eBi6Y1VEhBR2m7XYRHZetQ4vE7AapemfvuoexcZXbdI4YzsJ9jz25jMFgRko8fdTei3oEIvTb85hXzK9Ac+mf/B6gAkVLoi9vPRIlA9veSqcuaXjdmPzrbD9clDCT8zAo+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401287; c=relaxed/simple;
	bh=wfjopd4Fq5WVfkKb67lF3OyDusyEiBGyxsQNSQ11hWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FLI6kHxyWiV4N7sm9DZjYi3dx+ydUIn9pcGYC58X90J7TdPuNTRw2VlH+AQnK8fMBG224G1ka20uOHQ0Y89/SGP/iioDtc8nFjX96k+KcjrXm2oQmMMbQIFoebdU6qHEW6H2DhyS1DK4XbJVkkCPOtW5kcWjeQZaZLPIp1n10gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZoN+ppL; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZoN+ppL"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20227ba378eso15359855ad.0
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 01:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724401285; x=1725006085; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yoVvgfcOcwvRaCc/KYAfmcGQ7N9KGKF9JJMxsOPjDiE=;
        b=bZoN+ppLTo8Eh0KSQyvUIMrOYJdXs0DU7FoVMixdANjg3V89LqRpuQ/VBK8aTpe6kW
         hQWWPmyPa91Gl6eREkVxvzobB8hyubbzylfO7oqPsm33PBNgkfvGjHAET50B6beFZ6b+
         ALnb6TYd1Qfo7uGpjCZ2EE3QJzr4CkhQVVJdenHz5J0DL2aJW87SfwqBZJQTYsh7HvyG
         50PKxgLhUWUvPAyHZ3q8EwI2OpaAPNrmR14no5VLD2iraj7gUbFuLVKAJ+Ck1sfFUOBO
         nppXmfFec4iRKeBLPwlV9pyZtOZCEFYAaLLgM/QhDWe1fnbmW1qL8CfthT96hvPbRNo5
         0Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724401285; x=1725006085;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoVvgfcOcwvRaCc/KYAfmcGQ7N9KGKF9JJMxsOPjDiE=;
        b=Lb8LLTn7U4NdXz8N7FEdIVVL5ZVUdVKbZeXsIraeGMXQJ7WvEX/pslHmhr82FMvxFm
         m/Jv78hXO90TGhqQ9ytbMCf10yFskDhUkz5oanQHHF+BaKj7yeCDqP5KgdHacxzzKoQk
         oxVMcoUXDmWfO5tNNKAw8/pJPRc6AI0FQeH3Occm3aZUSYoG95jFeScBMhM+YL0/zoSX
         tZ4DkYAqwwHePxOnMgQJhoJLcTaQvOhuSH/9BWltlIy57lxW4dYIUndpBWhSj2ksJt7F
         9SH+GhD81u2wsI69XflYwjCIJXXBQDqnuBUg+bGoJfZuLx70KMKMXR0cA96fCV4hDYhb
         Lm/A==
X-Gm-Message-State: AOJu0YysfQmlb0we2yJDT4piBkPWyJqxj6NK2vM8+LOTYCVlZoTnuzs8
	vLfTrs6WurTw6c7GtBrdfMYo6wmr67GQ2SpkH19v5mlqvurFqVTRSCK/T4I64jk=
X-Google-Smtp-Source: AGHT+IEv2JQEbTKVP7yH8y2dYadaQes98oSbnSKhYLpPqPBvXTJyl0rhaIwqRoYy98BWpreZALFDkQ==
X-Received: by 2002:a17:902:d508:b0:203:8db4:4442 with SMTP id d9443c01a7336-2039e4e84cbmr15939635ad.45.1724401285527;
        Fri, 23 Aug 2024 01:21:25 -0700 (PDT)
Received: from localhost ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae6ebasm23683325ad.240.2024.08.23.01.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:21:25 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Date: Fri, 23 Aug 2024 16:21:08 +0800
Subject: [PATCH v2] doc: replace 3 dash with correct 2 dash in
 git-config(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-fix-doc-regexp-v2-1-e4eafdd60378@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHNGyGYC/03MQQqDMBCF4avIrDsSx9iEroRueofSRYhjElAji
 S2CePeGrrr84L3/gMwpcIZbdUDiT8ghLgV0qcB6szjGMBQDCZJCU4tj2HGIFhM73ldUpIwm0o1
 qFZTTmrgsfsHnq3hMccbNJzb/GWoUCUl1J8W1wwbvkSdjzbL5d37w3rvZhKm2cYbz/AK22BYeo
 wAAAA==
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
 Celeste Liu <CoelacanthusHex@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192;
 i=CoelacanthusHex@gmail.com; h=from:subject:message-id;
 bh=wfjopd4Fq5WVfkKb67lF3OyDusyEiBGyxsQNSQ11hWg=;
 b=owJ4nJvAy8zAJfY4pvNJRPo6U8bTakkMaSfcmjZe7tnxR35jV0bMpsiipYF9K3/1dvcvia/Yf
 OBKg9aye387SlkYxLgYZMUUWcR2Pn29rPTRh2W8JjNg5rAygQxh4OIUgIlM42f4K3TvVNuaVS+C
 E9du4r/WV7csLuD4yfsTb38o9ZA78ufUhs8MfwX7C2cFNRZIHDKZEx9R+n+HXtL8922yfEy/y16
 rbD1iygYAs9JTew==
X-Developer-Key: i=CoelacanthusHex@gmail.com; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

Commit 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
introduced this typo, it uses 3 dash for regexp argument instead of
correct 2 dash.

Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
---
Changes in v2:
- Clarify typo details.
- Remove Fixes tag because Git doesn't use it.
- Link to v1: https://lore.kernel.org/git/20240822172042.54065-1-CoelacanthusHex@gmail.com/
---
 Documentation/git-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 65c645d461..79360328aa 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -130,7 +130,7 @@ OPTIONS
 --all::
 	With `get`, return all values for a multi-valued key.
 
----regexp::
+--regexp::
 	With `get`, interpret the name as a regular expression. Regular
 	expression matching is currently case-sensitive and done against a
 	canonicalized version of the key in which section and variable names

---
base-commit: 3a7362eb9fad0c4838f5cfaa95ed3c51a4c18d93
change-id: 20240823-fix-doc-regexp-727a82281737

Best regards,
-- 
Celeste Liu <CoelacanthusHex@gmail.com>

