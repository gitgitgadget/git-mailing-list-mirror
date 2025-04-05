Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8941186331
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743871536; cv=none; b=sIo3pmIRATopSgotvT2FoxHgfmeMWwmmQphvp7zBmxClOfond+dx7y+FQpuT+SefPDnTQUUOyfwD/j4YULd/thUPRAuepz9xImp8HMd8UhoFsztrxNDu1/I5iMTuq2doAyn4O7RMSTf8SIzXRMGAclguJqx/dSs0i4Q+D9TOZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743871536; c=relaxed/simple;
	bh=6t7uQvnlE70uSPiVrfrE1Ic/oaUcobQzwTI/yMKWxoM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LEAgMqb9clwR0amdFUfY6BQQ7bqveG6H5+vvXBkRc/d+Hsh41lTpLNf1OUPPVAMVmtuFEQPTULSV/9+2aY9dhtU6peDf6OVufS+PdqgqCeEDH3H+J2T2EJeMjs+QIrca5k2HBXtT2wrcFA89bZXEOwvNqtnBHW8CHqiIY8VgBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTEMPfF7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTEMPfF7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22928d629faso30411465ad.3
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743871535; x=1744476335; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FyS/dbInvSadQpalZB493jhvdkhMjWc3Dk/VT+tB9c=;
        b=ZTEMPfF7Kd4l6MBRRRvNUoxRv1gzXvGSrbYw5CPAkqGzGAdZrip5m6jtrCmeUYT6Kn
         4Rs+7ANVEg8xhaed/CLR/AzNl/bp5QygWXrLO/Bd31xc26DBbeVyNs8Ym0bPx8bm/VgX
         3EqUUAXi5/iZtzNCpThbqoEFDZ0gPTR7FVWlMVYDAKPHh7f6GDVJ4us3VMRkCdLxYl71
         H/T4ArG2pEMX4MZ0wiyORhM0UlhKNWmxrtRROIIQKE7nl8b5BX6xubd2TRSYutFUyEp1
         G4oRPotk2IPTBQXIppP1OVuTq6MD0gr0d1qiIc0ZCw8wPOP2RYxQpr/QcMO+NXKnE7sR
         gmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743871535; x=1744476335;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5FyS/dbInvSadQpalZB493jhvdkhMjWc3Dk/VT+tB9c=;
        b=Z1lq42iD4mIg3TtnYGEfg0uPFcNwZyg6rGIfibf0Q1OUZ5/1V+U3LU0oWwUH4hzD9s
         xy6LAFibXxxbE5xDDZmvXhCHNFgN6JX28hTblBOwfshA/uLFM4F/KMq/WIDa7IIXVPzE
         SGLGh4yBTmKhy3vgi9tokkZfMKXOChqBq388dLojTklLZl1MrRzl8fTtp3Z7eBZd3OcR
         qbs65W1ZqdlF/VOfvuoLFrpHaSlFnp5/pYmqOLwTUcuA+VaK/+y2a4BztdSfhxSzAaNP
         GGyoiPY45D02iUsKGc883wd+KrY+tOwE6BWGw4YyNXtwfIJAwi9zW07G22Z0XYDdjJNr
         sRZA==
X-Gm-Message-State: AOJu0YzBrlAiGvSUkmeD/gOaUp2BT3ZiK2Oi84/h6vRuxVnrNyY+Mfrk
	1SnzHB9vRl731+wwT/jrur2nFvul9Zo7+0+IvQiyBx1icj10oi9c0Frf9Q==
X-Gm-Gg: ASbGncsg6NLB+DUbewR4lmwnQNMYaFaICqctC0C83K6OruxCZlvKcp1t81Wu4ug/wRb
	o3S1ZkPlpvf3TCJYZgUIlW9PMZ/oWRP/Qv++9TF3er62VeOSFseNmblkRCGsawNHT3jtdLsQRAb
	dkJRSSr38aq7dVdNvGiSmnzXrOF0kBwro9LazOGGpNKiYoYq6M8Z0ZJ72bQ6e6aRKR/+dutKI3b
	AE2l0AdJ/cxgWzwuiDZ0niG/KxhieNvPVirzgLYuPtRBakD8oSuWddX+fPEhhWXurDKBiEDlWhm
	JJfDDaBxaTEEQYq4FQRmSODeZNS8Js7SPyPSc03SFnaR7aIaJAJQkrKmpmjpxi4SC/pWiX8ixTa
	Lj2Sj8Yy73vWtD1/UWg==
X-Google-Smtp-Source: AGHT+IF4ls3CtAqwbrKBjANGbTw16rbQa1gT6gn240GMtEPN69gTE9lT7goN3tfl0mCCBWeosOw74A==
X-Received: by 2002:a17:902:f690:b0:220:c34c:5760 with SMTP id d9443c01a7336-22a8a8e4508mr90093225ad.51.1743871534650;
        Sat, 05 Apr 2025 09:45:34 -0700 (PDT)
Received: from ?IPV6:2400:1f00:2:cc93:949d:973c:1dab:4995? ([2400:1f00:2:cc93:949d:973c:1dab:4995])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ada20sm51975855ad.46.2025.04.05.09.45.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 09:45:34 -0700 (PDT)
Message-ID: <2c547567-2b72-476c-9fc5-71cac050fa15@gmail.com>
Date: Sat, 5 Apr 2025 22:15:32 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Arnav Bhate <bhatearnav@gmail.com>
Subject: [GSoC PATCH] environment.h: remove unused variables
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

packed_git_window_size and packed_git_limit are not used anywhere in
the codebase. A search found that all references were removed in
d284713bae (config: make `packed_git_(limit|window_size)` non-global
variables, 2024-12-03), except the ones in this file, as they were moved
to struct repo_settings.

Remove packed_git_window_size and packed_git_limit from environment.h.

Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
---
 environment.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/environment.h b/environment.h
index 45e690f203..cf6fc04e70 100644
--- a/environment.h
+++ b/environment.h
@@ -152,8 +152,6 @@ extern char *apply_default_ignorewhitespace;
 extern char *git_attributes_file;
 extern int zlib_compression_level;
 extern int pack_compression_level;
-extern size_t packed_git_window_size;
-extern size_t packed_git_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
 extern int max_allowed_tree_depth;
-- 
2.49.0
