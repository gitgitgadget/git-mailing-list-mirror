Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795275846;
	b=rBZujmpW2/qy0ccHLVR3KAq5yBf2LxnkJZd6cE67xIvh/qc4WE9PT/cyYn9UdMpSvaaN
	 xNJmnAxONlD6Nz49SiTmdt99dDXeQDtXlbjoLJlF6DgVEXVETdRjqaTci8iEmcHK6ei0n
	 NwF8AC2m2vG/A9Mcb4vRdNpDwhEMZnCR+kFFHIWBTnY19ryBBdF/q64usvftHC/+pKh8R
	 vbAxF9TITmRB3w6+BaUdmcHTZDH5958M2lz5ecUvbJZcNcP/wV8k+628e3WTxuy6ufcOw
	 9FTEhUlPUmWqZBq5EAAfTmUFv1RAVoAsez7CIj0O8QEF6MEQbQ4nMzwI/1ssYghxKWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795275846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=K/CqWDI+HsyZQAgXrio/tPYz1Y0L1GXEygZ+j5Am1qk=;
	b=BoXTwvZZxQN6B2otWDBOPuESDZS/aBm/XIYpv2in8g44OghBOuV6ALt+7I4fYfBNzYzn
	 q5U+0pDBlFdmzAuahpu0TvC/OscVvP4nl3KiqPlRaroGKTWWDpjkij/oZYfhRNvaFnEBx
	 eN8t4djPkSCTxXMqjhlupSQSFrwxvIGTBe2m5fnbTX5N0cksKjUiFJ/m2tLvVHiTFAzC4
	 /+Wyb5xRNdJvHsIGuCsDYvzL92VHSqx8N9L7zCLekUirZpd0ok3AVfnxEnQ3kRqsV+Ll0
	 /TCnhMvD3wDOwf+XTBJANmtdWmC9Keg0WwqoyMCk2937OzBhQdAB9yifLrdHljDTRPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SqizkkWp;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4EA606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 15:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E4EA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SqizkkWp
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f03920c4a0so12033975ad.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 07:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795275846; x=1795880646; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K/CqWDI+HsyZQAgXrio/tPYz1Y0L1GXEygZ+j5Am1qk=;
        b=SqizkkWp4COQk3WMZUNa0SDCcyvFHDhcZBKbd4C3c6PQNcrLd2J1flnERxXPYXA+L5
         FWvzaUzxflO8I5ksRrHMvHuIkWxopDiAPUtee1xAi8ORpZPRnP7UiSsDmypkdP6BTM6S
         dtfar+qpIDRtCmGnMfa3cuLnWFhfmDftGpZcysxefzhUJH8E6x7hA5MKAoOvvkKraBW4
         VgOTCU1cW6D1j03IcVsqcS/GhA9ixIJYXVG6QjesVLUG9irgyBhm3LKxUscdSGhgbpqC
         +sYGu6tXfEmCigeUFAgjyW3uFQUgY6ozr8J6h/f03iT++Mv7p0mgFiwdT7JRHNID8awA
         3MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795275846; x=1795880646;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K/CqWDI+HsyZQAgXrio/tPYz1Y0L1GXEygZ+j5Am1qk=;
        b=fpHev194+ab2nLn+HzgU/SYwjESbQ/RFDGMAQQIWMEBmmtydHyIO0XI2WjGKQ6HnKW
         IGSEpTQQPOLbbcjI/YeBFUvldjVm15rruS4xD0OrGkwb79LKNqwR40RygOXOZXDulWmh
         8ar+gVuI9lnitVcKX21vFw4gwqWvEtpGtHedMSL9dwiVDHVgubBaeC8biMnPisXMkdbu
         iK/fNfu44oWJKqp8LO9XDLnbLubP0XGlxZRNdNDtSpEjkkT5VED+JonrslJpMdCjRjsj
         +ETwWyDwcrhYaqa3RCf+asCKqt4bMzC/VcVwO6Xy00WBQvaOrQ91VT5zb4hz1xq5soUJ
         +4zg==
X-Gm-Message-State: APuU4Z+tpx1zuQGknzvaWMlON036ZE3Xe10KP534qzuUG8JjxJf1SWtj
	WN0z0Oay8rlCVqfRq8QALks3DHD0Kab7N/chiSYDg43gpXjTx3di8kjt1JvzPVhV
X-Gm-Gg: AZFdTZcl+aQeJOrVbYpeGv4T3tPIymt1gnhbXsPUTyUeZLRnpV1RD8RTwqnBPI4Ua+B
	jgqfM7dlwMDMPYCJWMuyUWNqahSHn7/1PzIEG/tRARpAuzA8O5KsiQnxPd2U+vBbXKwAlH0tw5Q
	s70UJ9auCmOT9AaZR4wUqqC5h7AAMkHx/FbrFRptqeDQYscjFo2EAv028Np7TKUvzfFZ2ZzEEJ+
	smlgUy7HFc/KdUtXp+FnU969dXV5tetDoiEuteRA6McrGcKapUeRadyw5Z0HTsj0/AS/btw6wLs
	YyoFtyCId7fmt9QAhCIFnXSNTgW0ypS1Emyn82p67I4ukOz7jb6Brs6PRVNbk2H3OtQlowPmRbr
	jaCK59+y4eSLEXlCTzjL29oEbLcU3LUR3rpOuLK6QYMmrhzE5k8G2Ps+ofShU8WqxgsLBjBAgsr
	8BifSivgxSBonNT4eQcqQ17bFJU04dTDkx465vldZHSgWlzVuVEdHAweekpNFoz2hE7K++XRiRz
	TKeLyWQXw68ArcWnhrReMPanO2yAtQVFmTvV+OdxIQqNOXPiE5Bo3KgO0DrImE9E2/IaRavRVsn
	a5eFRFxj/kzs/TBBaw9povwflT7p0X0=
X-Received: by 2002:a17:902:db08:b0:2e9:5ed2:c394 with SMTP id d9443c01a7336-2f03f1ba92amr66662815ad.44.1795275845671;
        Sat, 21 Nov 2026 07:44:05 -0800 (PST)
Received: from [127.0.0.1] ([4.246.119.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04a49cfffsm20438795ad.46.2026.11.21.07.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 07:44:04 -0800 (PST)
Message-Id: <pull.2497.git.git.1795275842564.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 15:44:02 +0000
Subject: [PATCH] lazyload: fix typo in comment
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

Fix a typo on line 11 of compat/win32/lazyload.h, inside a comment.
That comment shows an example of function usage, without a closing
parentheses:

return error("Could not find CreateHardLinkW() function";

There isn't any closing ')'.

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    lazyload: fix typo in comment

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2497%2FOphirBleicher%2Ffix-typo-lazyload-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2497/OphirBleicher/fix-typo-lazyload-v1
Pull-Request: https://github.com/git/git/pull/2497

 compat/win32/lazyload.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
index f2bb96c89c..d348a89f9b 100644
--- a/compat/win32/lazyload.h
+++ b/compat/win32/lazyload.h
@@ -8,7 +8,7 @@
  *                     LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
  *
  *   if (!INIT_PROC_ADDR(CreateHardLinkW))
- *           return error("Could not find CreateHardLinkW() function";
+ *           return error("Could not find CreateHardLinkW() function");
  *
  *   if (!CreateHardLinkW(source, target, NULL))
  *           return error("could not create hardlink from %S to %S",

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
