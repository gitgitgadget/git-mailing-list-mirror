Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C033955F1
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468366; cv=none; b=IwOpG45g3yuOxOOP8eiPo8OfBhrC32cNwVCQmQ1NOFUoydJnJESiG6P2509S7ubPtn+/0FDxneZ/yZuDF6VmanbX4RbwbkSEE4v7tdVbNvetH16QPrh2P5rN6z68yG7MhJ8Z1x1HDXpj9X73Bt53gnB9w+1f+drUWdMR4on1JIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468366; c=relaxed/simple;
	bh=TvobM/yVA16ij1ECDG8RwzfzcMr3TvoVPyR2p6lwt50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4Ynfz7SuE7lOj8u7Q4tf3ZmbBorelUp34ylGsF6QMrNEcOBJb+TfgHDoM5niw6BPBVCyttVPi8NkFMxUES6Dc0mH9Bmd8T7JzGcgeqNccqWqG0i9aMmje4BOiHgjwgmeTN39/60tS7bsCgSLUQFOkvwHM4EHLEdQIH1hgyBdlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNzC4qu8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNzC4qu8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d6f9e2f681so3102005ad.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788468360; x=1789073160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2oGOok6vEUPHG3vlx6XJw58LiCjM7XOzzpWE6cggG6U=;
        b=VNzC4qu8FQf3K1tP1YhDITwBBiX3X68W0ItzXEuZww1mELfpuvj1efkNHlCc4yxW8/
         T30xPS5rrXKjwsX6/x8utpu/D6lXfo0ZJ8g62mvuSvq8BrGIEDD2tFsj+OtjaXTLKU49
         FGTHiWpINwl28zUwDn2RBEHloOnOG6YzCSLzDgDvgo6SAXrevM1NR30XC+fpcxpPM99Q
         esi8YwdynfDdR14JIHTpkr3SJqfLWLgwKn+O/iI0UGdIo4g88UpONWsZEhB2xQHcqZbB
         FS5IjEogMhoVNongTJXviC0+5HCyiWdBe/G5Psa0CWhGF9W6OM/PlmjxGcAQkB310rkB
         SGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788468360; x=1789073160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2oGOok6vEUPHG3vlx6XJw58LiCjM7XOzzpWE6cggG6U=;
        b=UnnxsTjDkyrz9m2iU/HlZGL2O2mR8q5NK95QJMER0lLZnXKr5r67PYDAWtT0CeiTOR
         3ge+1K0m1iSydUD6MkYAsqCZjROiMcJA50O/xBOg86Z6nJHmX3QrCfhABKyKROAYMUhT
         aPPbPWxyk86Vz5plgsbJ9apL8n1MSQTagUp9UTMtdWUnoge8U4pysV0OR70i6sYRD1uS
         nRMwmU6DPI2GMZYRdtz5433nQq3PgZZlG8Axs0a52t6o49ULAVf4GcWAmBxAKXrFV1Xb
         ELIgsN4IVezIHe9ioMi9wIWejW4utEKHTg2t+41Hji2rWoP3j9KNokYiptUp0EVeD07A
         Lhtw==
X-Gm-Message-State: AFuF++mVExoBejajUyBQztl66UnAhUlVM3p343GqdTmrPRO2up5GxiWx
	weqgSEmu/LU1jiHPyCdWnA9KvcwddeuhQLrneuoCc2BcJTsINDoaPD9XtRFRFg==
X-Gm-Gg: AYBFou3MdEvumjSu2hAQIyfmb6rlkXF9vTw0jU6TBudSTLxsMafl9BheS84T+yLZ7M+
	i9Mq0NdP+4hTJZsjMsNY1Fbm3uQvGSOmbsnPlyKhZuQF3Q2MJRqTuvI8T1mV3sAs1UIF19DDwIo
	0dMUNnbujrjok0CNCV1DSqVDDjGktvyMC42Dr24Hl49xqpK4b2Akzip+MWYVOalbscKTnM7Kp7w
	6eFwAQs8tmul3rhPgl+j9vrPkjfKHS/WQ9JgXDZlNcDIl8b/tTM1KLDsMC/0cNdjFOWgp8+iKP0
	HnkkXXi/3MRFA/fbvuj5Xdhv+XAvae2MVs5RC5+Jgl4b4eYurLOM5ej5CBOY++e4OE/YdA2Bs1l
	2MnUtYakueks+FlnLQodegZZ/5i0nyBZG7gJBQ5W+AdCBKJRj3cRq04LJ5q7sR6CEHRDhzluUc9
	Sl2jXV1W9aHyBatakVT04B05GCFx5SBrG7l1Df7QvLZ6OcEvKOMly8QzvwgQtsrvgpTq4LA0WZK
	ljAiE4IgqFTS2xE0C0HE08lApNNYeXgkvRVpehs+n9moKfr0NoESwdRixCo8qOLeqAoJ8G6OUi1
	PvWswGnBRtFHnGOR4EnDrK+s
X-Received: by 2002:a17:903:1ae3:b0:2d9:54:fc69 with SMTP id d9443c01a7336-2db1247f4d0mr25242655ad.7.1788468360171;
        Thu, 03 Sep 2026 13:46:00 -0700 (PDT)
Received: from localhost ([125.17.164.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c15besm929815ad.61.2026.09.03.13.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:45:59 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	toon@iotcl.com,
	ps@pks.im,
	karthik.188@gmail.com,
	justin@parity.io,
	peff@peff.net,
	phillip.wood123@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 0/1] rev-list: add --missing-only option to filter output
Date: Fri,  4 Sep 2026 02:15:50 +0530
Message-ID: <20260903204551.65592-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901185100.33948-1-siddharthasthana31@gmail.com>
References: <20260901185100.33948-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v2 added --missing-only as a filter next to --missing=print /
--missing=print-info. Junio asked how the missing list is used, so
this v3 only updates the log message.

It is a one-shot walk. Gitaly uses --missing=print when packing a
quarantine and treats '?' lines as objects that must already be in
the main repo. Tests do the same (is this blob still missing).
--missing-only is that list without the prefix, not a fetch loop.

Based on 1630431f32 (The 21st batch, 2026-08-31).

Changes from v2:
- Stronger motivation in the commit message (Junio).
- Link to v2:
  https://lore.kernel.org/git/20260901185100.33948-1-siddharthasthana31@gmail.com/

Thanks,
Siddharth

---
Siddharth Asthana (1):
  rev-list: add --missing-only option to filter output

 Documentation/rev-list-options.adoc | 13 ++++++++
 builtin/rev-list.c                  | 42 ++++++++++++++++++++++---
 t/t6022-rev-list-missing.sh         | 49 +++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 5 deletions(-)

Range-diff versus v2:

1:  3c89e6bc38 ! 1:  c751ff41a4 rev-list: add --missing-only option to filter output
    @@ Commit message
     
           git rev-list --objects --all --missing=print | perl -ne 'print if s/^[?]//'
     
    +    This is for a one-shot walk, not a fetch loop. Callers already have
    +    --missing=print and strip the leading '?'. Gitaly does that when packing
    +    a quarantine: '?' lines are objects that must already exist in the main
    +    repo. Tests do the same (is this blob still missing). --missing-only is
    +    just that list without the prefix.
    +
         Add --missing-only. Use it with --missing=print or --missing=print-info
         to print only missing objects. --missing= still picks the format;
         --missing-only only filters. The leading '?' is omitted. With

base-commit: 1630431f326e15fcde608827b5ff38422528eb59
