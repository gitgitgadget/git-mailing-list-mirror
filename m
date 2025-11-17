Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB9930CDAA
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409090; cv=none; b=sYCLFrGKx8hgSaBCk84gZkfV1ky452Dc7dGm6rZ9LRrW+TDvYEsec6q22ENtVAzVaISaXgenYrwRrjNjGNsR/02f3Q9Q7ArKQLSP1ihgJNMKal97uaCJpYjg7LsviwH4iejSpunsuN51xXGwsc8MMF37Kk0ZjtHcPuEiRVUx4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409090; c=relaxed/simple;
	bh=XTZalkKDbHxqivHvJtE8ZYxR4nsR4Pg7U5FQ2+02HIo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=htCtA7prC4BiAlZ/deGwHozJ2QN4qaYfqEmZ0pPc43LYQw9HTcM0NyC7PFyXURHba9cmZWMY3r5+E+k7aiDfkfxIXBvBYjvTw7EvvqVJwOxS8pc4tjLlcr6FBU3MFK+0m4YT5Vnf62uJDjWJ582nnpSZeenH1b7HL52CHIjf5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsmtsO5u; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsmtsO5u"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295548467c7so55353795ad.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 11:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763409088; x=1764013888; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=owyEqYbWqqcxD/X71fpQKe/hHE/3hqehDW7ZiFxtcak=;
        b=PsmtsO5uo1ALkOw7gKheBS43krFMZKyDAmC9+gXcaXTfzMj0oLcWIB8jlqHFtAL9jP
         OdoNQ3Qn4T3S4q+VIF7l7/1eltG0GHDmqThr8B217gu8t4zhKdWpLnLa9b+O7eirAwlT
         D0gP/wg8YW+m0unsGRh12XYYFq2IsE4wF6dYntysb/nMKlsWnLuPrV2Hnfs4TR6pyuja
         EIZ9uMJG0245lPa7RfNKCWkB/iA8+nhnDa090CBfLS5z6mwMZrnRrJrP744ZGdYjryEf
         weT2MzFreLGNl2zEllXLWfSSS0NqMIB0Lb1KXkRPkziDj3IBAwiy9D+OUpxJdvcBYR7y
         sURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763409088; x=1764013888;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owyEqYbWqqcxD/X71fpQKe/hHE/3hqehDW7ZiFxtcak=;
        b=HgWy0R5ORBJCgEJ3Y6CSblRQx6FlExgkF1OGE8OQp3EA+MN4iMkGSzhNPVHBlLya7T
         vwdugjvQbO/ezEKa8iKjRAN0kWWcKxYMZ6QC4tPcdemXy/yRXZMblGowTdH2iKco2GsC
         TCRvBqSZwquiHuahiP6u781S1qcCgvpMBBMuiOSCEc/zQmP04aFVvMg9prdVorY7lGbb
         5dOwzJZ4CQT2QdgYwo6alMLPH2NO9goSVV+jb2KtJA3vfy5kwQzagmd/LQc8ZeSwLHAl
         MmHYCCWMAO/HkRoHamp1S+TOijNcfzwuzvd99o+s2CEOKOVPfXNpfu8Uu3zdU5FyNHON
         62FA==
X-Gm-Message-State: AOJu0YybQBGBXRzdkXFjXIF2KoXB8qRcnQf/oN9wFgb0HrioP52v5oVb
	RMcb7KUJ8cGfm6IwWy/GiTckhlKEy4Nv/jMF1Mfhqu0eEZKmHT/mvUP7kWdj0w==
X-Gm-Gg: ASbGncv9JLa4AckpyBPMHoHAuIUIhN/9W8bxG9onqNhv47m3rb00xjxKdj9xvV3J/6Y
	qx251HsJ8avDZ2T84XY+n2J2vUUCMHeW3lrha7TIsRHpfs2kzITacRPxO279aP97PT2UN1btoKE
	b5I53uMNvPT1x/DNSXYrTNPBRfOIklRh46VvX4j81pGS1l3ILfKtnaTpiEFRJ7i2ciMQ0LLGDxA
	RrmhjokhvAjxyjAiAYmLSBIAXaQNwpJP6aFcxsuHNTn7GtBBgtN6yCc5TPabEp24427rMLvTXuZ
	rF41PvEmZks5yV0XEHw49pU14S4122rXZ53YA0KZEnt7fRNTdFIe/aLbv0OP//+a289zzSsk9Du
	utiibA9PUOLy6I9lbJM7KCiGeoAIq0M7alOPffBtPCcUXrAA8s4bxJSLusTvEakMrYI9/Beua+O
	pxebasQllYIrDN6DX5SzAhWYWw
X-Google-Smtp-Source: AGHT+IFgwHqMxSo8v70o5uJURVfhX0zr8fwS8wWFBXO6eBW+BDcInZjYpyH5zYC7RZXS9BkS8AK4vw==
X-Received: by 2002:a17:903:2449:b0:295:7b89:cb8f with SMTP id d9443c01a7336-2986a5ed370mr166275725ad.0.1763409087576;
        Mon, 17 Nov 2025 11:51:27 -0800 (PST)
Received: from [127.0.0.1] ([20.168.110.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36f61bea9sm12810449a12.14.2025.11.17.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 11:51:27 -0800 (PST)
Message-Id: <pull.2004.git.1763409086322.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 19:51:26 +0000
Subject: [PATCH] make strip: include `scalar`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Scalar was made a canonical part of Git in 7b5c93c6c68 (scalar:
include in standard Git build & installation, 2022-09-02), it was added
to all relevant Makefile targets except for the `strip` target.

Let's correct that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    make strip: include scalar
    
    This is something I noticed while working on aligning Git for Windows
    better with MSYS2.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2004%2Fdscho%2Finclude-scalar-in-the-strip-Makefile-target-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2004/dscho/include-scalar-in-the-strip-Makefile-target-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2004

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7e0f77e298..62f7f7bf56 100644
--- a/Makefile
+++ b/Makefile
@@ -2565,7 +2565,7 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
 
 shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 
-strip: $(PROGRAMS) git$X
+strip: $(PROGRAMS) git$X scalar$X
 	$(STRIP) $(STRIP_OPTS) $^
 
 ### Target-specific flags and dependencies

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
gitgitgadget
