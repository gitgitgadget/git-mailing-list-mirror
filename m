Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482175;
	b=F7M0R/iM7KlG6fExqFIJ5XTX4UjdQnw1NcZXSCgSzsGqCLLyq0VvpZfB534TgKjFF/AF
	 PUHiUYvxfXGCAY9ywjMVlXY7AuyoRm2RtoS2By7ofdohx5RuP9kVjE92mMSmEhg5ZoQS/
	 WukKb7pFXw4WpV8sweAQAeC8SD+gf/FtmbdJPrOBh8IOp1072iKNii0NDx97cULuNEng7
	 d7BGPUV8a23uqqGZ9APvumliHVWE5ggg7Tq14VqJ1lW9UuEjGik9DY42eoBFgDn7o9leL
	 Gtfz446hQrcbPyzlVQ3Uv3pU14Vw1P/iby+4Z8OVqfpHNGp4HaKs4daSPrdhTlwJLhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=oJSQ52omfKNKTuTmkqXwc/XdQMrA7QcHEjEeHXLu/28=;
	b=sTQbK/20jOl50hK/80mwZ1OXO7wyGfB4Gf7q34ajmOyKsNbmq7+XEiY7o++EAhXeuTU8
	 hSu9w80lJq0OT+Rrxn+a9yyMqcnqaTOnluujLYGfNjQdx2TB5iIU5nbtVwQpkgBVnVtkJ
	 kRH2Xpg1Pvx2LFigoH/1CNaqGvb2tzkRmyRSVF9VYcVwRx4F0s59BG1jS+BA5qbgO/F0P
	 Nxd+pOg0INC5kXkpLkAMRBfAfyEPe2PQXpCLYMfukUIORrVEIL4huBT2SV1vgN46dvH0B
	 Gv6MCZrxw+MxNcC6+a53YE7O88WudWkvnIYBqTdvmHgr5J9mppmPUzLBYw5bMaPq1DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KE15HzwH;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FC606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 01:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF8FC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KE15HzwH
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d65662077cso1997409137.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 17:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795482174; x=1796086974; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oJSQ52omfKNKTuTmkqXwc/XdQMrA7QcHEjEeHXLu/28=;
        b=KE15HzwHxDFV3kZblmc5kKatS5BFPu5f/Mzpeoq1XQi62rfAsxCBKK38Gb9kT8gAeC
         ZAxPpwnMk91O6qpkcY6Nu3MFJiDDqm0WBKLvQp5R+a0iSfb9PArUIlLco4lGnsGPKtIq
         557X0oXNSatyhcB/vcv4TaT4nDDDdR1af3/20OimaSNPlhXAtblgIpUYV8ipVctPFolN
         3BDt72TtGO+3vdSE6rI2Ejl5mG28r736jRWRbNCWzNC8H5KJOJMyB/NcApxv+2+v2IJS
         tQ8CmVu7d0PM4NJd6rWbJbh3qKGIMJMhKiC0cTP2FICWCQ28P1B16osqrO+DWUEeRCHA
         EJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795482174; x=1796086974;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oJSQ52omfKNKTuTmkqXwc/XdQMrA7QcHEjEeHXLu/28=;
        b=wYEAiwgm0t5jAPYodyZRCcV6Zvw8CI5eTFV/CQ8RcluqmD1vX3UNeaU9WMfKavZOyr
         twEkb027Ouzbba2EhVMsq23+jVZE3oPQ8OIku97JD3IWdMZtf47GoBOMNqi2UsAi0HDe
         AUhQxHRlK/0aj5QBnvztFyN59acuyi/kHwx2J1g0eTFxNo8bgrhuoV75wzMwg+UZo4re
         MOE3Iaat6XHoURWJfwF0XezQUiX+UKDhbLIq7S0Sx1R9CARUAY8jXk8yqxGhDdUa+zv0
         UizLuOGe5SGkbeqrW8T3WhFWBdnzgYz/uvpQY+AWSpJRgM4yaKQc1O0j7geXNKPaxwXb
         obNQ==
X-Gm-Message-State: APuU4Z85i7FACI27XwwgOqxf/MZ333F4AR+urO1G+y5LKlQqdCb9y6B7
	G8AQn+Ny3XRdEsNLe2nvWBfYJH/TWPhRvPIJ4z9QhjQQgBEFsYQsKcHHMRXABteP
X-Gm-Gg: AZFdTZdwBQ+oTo9lnNghp7GKfYgeIa5zcSM37R+HzTUoAO73hNd1l7D0h8zuFewBDqU
	/1Phj0PY31uX4IQyw2SVLYWnabxV7tACTG9PNbUL+xS9+M0m6KKljgAAs1D6Vl1JzRzbdAdhQsl
	SoMgkBYyrrbGz/9fLEKxVVipxAvzbAFgIumXLweQsCvCydQRIV9wby0FF3l0gXDx8CUAjZuwQ+l
	nZAsJ+sYc+UZdQePU7Ax+n6TDacHOwHQpk44Z4/xep74hiYoMOTTcTqhLNLHxTRVgULrF3ylIsD
	x7iOw6dtfJdE6z99/li4nETx7A2MDlj2FYfJ5kIXDZMpvBz6u9dDDtfv/NAz3VI5leHC/HsXWmO
	yKqbvAlcfaP2lEyK56ptIfIHrZ4qWl3uFmnjTg3sDoJcfdl27FJCUGbNMphOSNTfGd/1q7R6l9L
	RGvdqHuM6up7zX5OomZOEvnz8mBJPjOQTkQLGhi13IieVGE5n1nYF1zG34B/PO/3YBED7se3DXX
	kuQzxVq/SfQCUtIoELEGjhteDIFv/DVNC753peFCv28atKF6ag/5w/+GoQH0rEvWOJS42RvwD0t
	AjMW56Nl5RgkAVvmmPQwk25OINyhUtF3
X-Received: by 2002:a05:6102:374d:b0:7cc:971a:61ee with SMTP id ada2fe7eead31-7d7393ff678mr7238314137.10.1795482173802;
        Mon, 23 Nov 2026 17:02:53 -0800 (PST)
Received: from [127.0.0.1] ([20.119.95.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921645f50f3sm16987246d6.24.2026.11.23.17.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:02:53 -0800 (PST)
Message-Id: <pull.2507.git.git.1795482172751.gitgitgadget@gmail.com>
From: "Daniel Scherzer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 01:02:52 +0000
Subject: [PATCH] reftable: document first ref block start for version 2
 headers
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
Cc: Daniel Scherzer <daniel.e.scherzer@gmail.com>,
    Daniel Scherzer <daniel.e.scherzer@gmail.com>

From: Daniel Scherzer <daniel.e.scherzer@gmail.com>

The existing documentation assumed that headers were always 24 bytes, which
is no longer the case following the introduction of version 2 headers,
which are 28 bytes. Update the "First ref block" section of the reftable
documentation to indicate that the offset for the start of the first ref
block depends on the version of the file header.

Signed-off-by: Daniel Scherzer <daniel.e.scherzer@gmail.com>
---
    reftable: document first ref block start for version 2 headers

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2507%2FDanielEScherzer%2Freftable-version-2-header-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2507/DanielEScherzer/reftable-version-2-header-v1
Pull-Request: https://github.com/git/git/pull/2507

 Documentation/technical/reftable.adoc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/reftable.adoc b/Documentation/technical/reftable.adoc
index dd0b37c4e3..b277c4afe2 100644
--- a/Documentation/technical/reftable.adoc
+++ b/Documentation/technical/reftable.adoc
@@ -256,11 +256,12 @@ First ref block
 ^^^^^^^^^^^^^^^
 
 The first ref block shares the same block as the file header, and is 24
-bytes smaller than all other blocks in the file. The first block
-immediately begins after the file header, at position 24.
+bytes smaller than all other blocks in the file for version 1 headers, and
+28 bytes smaller than all other blocks in the file for version 2 headers.
+The first block immediately begins after the file header, at position 24 or 28.
 
 If the first block is a log block (a log-only file), its block header
-begins immediately at position 24.
+begins immediately at position 24 or 28.
 
 Ref block format
 ^^^^^^^^^^^^^^^^

base-commit: 77904e546de3bd940621092ecec47a88d0cede5d
-- 
gitgitgadget
