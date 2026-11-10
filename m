Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290608;
	b=H7CDlS4rLE4jpOvF90OohwFjUxAKey7R3FWRfO6NUfe06EDMgmedbt6PNgGvqlAk6oN4
	 k5flkfkvpNaWtLAgVTb7OGOKwvTWYcg1UyH6uJ/qI09jG82V3a7LxkTpZ9VXq8hpneSk2
	 F3HEaWivyInbJ26cD/AQh+La+n5N9+rW5t/VWoKRFd5/fJGOSNUEqing2gScJ9SRIM1Xq
	 YEsKo6++sbRmYF22QcjBJ+1OUiVe1FCEXLN/klLvytE7UjATgCwtV4EnlIT3a0qMGpWwt
	 4w6sNT1DEaYzijOSVzvPZYcoHuQ4Bb+/8O6opHELE2JOckYIn7jpsm6Q9Y0HWbU5bpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=y034xMzFZiQITaR0zRyBsOqWyAt4j7uNy9eyKG4T3r0=;
	b=GpSUgJd62tMdz38Hf81kIDvNvEYd3mIpAhU97KAbPQr8sVgj3+4XA5QI0LyMfi16dtN8
	 iaquGAM3Rx7xY0xmjt8XRaH2wyNwBDkZ+EjART937wXxym4VUOVWjtaUmyJe7ziVwaSVh
	 Dr71qlzgugUJ0FGj9FlJS1CiNL1E3/utCSWH8W9XqKgtmRK4Ng8U2tswRWD4TQw2OAfXx
	 sdaSDH8NOsA5LIGQm0095BuQc+ZsuBqO2gKPYG0m78idWi1xx5fXn5CzkpA8gw4F8NX4m
	 dnyqdcq0CcI7StCmSBrv1EXTkfS/2NaLqOBnPX84gRT4QUTg6t1B7aBYHxKdxnFHgcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOgxy4Dc;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18E606A321
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 06:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B18E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nOgxy4Dc
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4ad89c49e0dso521597fac.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 22:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794290607; x=1794895407; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y034xMzFZiQITaR0zRyBsOqWyAt4j7uNy9eyKG4T3r0=;
        b=nOgxy4DcU9OUnj+YzOl/5ZINPUCNGwIN79Hxor1TACYOzRTfalfhk2ZB5MUhk5L6As
         z+2Hs/U8mecwkDg6CRk2oWRBGSyi8tBdn9XNoIHYoCRvyy/rTSBawJNTzxzDeoj0BLga
         IQGGwKTtYJzYcW2I2+0lSTpIkdLoVOOEGA/VYO/VaSGfYjjGkeNlWuDGYu+BhptKFACH
         PuRTCK6jZ7KUhHBeAEGl+dFxKbFD3N356T+T6PcxZitMxG+pHfwCGTCPw8ZWLlCF8y6r
         LbQjOidG25Cwy8r5lfmvdGs4I/vwKSKOxrKyX9AAPwiQ7sX4qkfxWkUNyLt8cGhG2gLq
         vvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794290607; x=1794895407;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y034xMzFZiQITaR0zRyBsOqWyAt4j7uNy9eyKG4T3r0=;
        b=aINYWXoKfFV0LDbaF97K58KKhAn3QcSCBrulxMI3isbLBHbN5QxQL/OGLKWQY5yK7A
         NGn29lJP16edG7Y357NgEulUVNXiAh5ImwebusaTOzVgk0iL6PuSonsmz+HwnbIOmh8z
         ZRvo9AfZpisWQ9d3kdaFhICTD1bkXa5DputzcgHKsygf5tD02DXHkKloAF3N6TlUIXDf
         +Q5JaeF//8gaY+a37yeDlqq9nNdz2loPTHLsDca0dJICfxZt/JYaYsW9NFDHlwIRWNNd
         hFzfFzPmgq1a0cnnLpl8aLpiobmeifJS1bOo+lEMDbLCDK9Tlysoe+3urkVZTuLl2W9q
         koMw==
X-Gm-Message-State: APuU4Z8yPR4+vcBduUcPv1o4Yl7o3/kvqfhEwwanlnr7mu5JRWaMXRpH
	M5jkXErmRM468EbOKG7wPjjLmabsNwXDPcgqzarScIS0xY42fcc35ZfcE8gF1n+H
X-Gm-Gg: AYBFou2/NKCsb0F2NAW7KA1zSSz5SV1NTCXu3WJDeb+GCgb6v8mbp/Tb+NFoBLZ/mGn
	MQlZ26Tfyzd0KBxx9/K1LKQtist4PV7TESeVDLuCPDH5CChaxbj62PUTc9HZCDEqP+/R7Jr2Lbq
	qMZTvxvhb4Jt0ZqLB/mNLD5u38fRRMAljA8vnLPoZBNH1SSdcV7khjMl/vyUkXS8wKLFkOU2fwm
	+8FrjOUKz37J56YUzIh5AJ0prFPCZiZ/I6o5Rgp17bGEwlzEuvX2ZH8BXD60ircKeve2WelH2lJ
	nbhtdoDWVkwTKjC7X55xcXQAgA1RKk3PzNxA6bduzl0aytgHE23cZE544rF59bQaAJIA42oJyc0
	wv8fA2xGJcAVrJ5fdQtYzps23zBeW/DbQM94a+mDaCSQWMZfKH+APUPL+qnmIY+DMNmuNXmSSzU
	D6G8ga4Dq9j4O6muJPw5CrB1VwV5LS3a2fawQO8JPwMq20xb31PRsnYrceYd3HCs2vwvBOwtUhu
	3F3xQ7lj+ctF6iZrjfoT/hx64PrI/PpjHrZyDLK/9nuFi05C4coo28yU+xLHaic+nLnTGthTapC
	hhRWc1Cmmav2DKvD2R32C8AAojf0Bk0=
X-Received: by 2002:a05:6870:1e87:b0:4a2:58d4:6284 with SMTP id 586e51a60fabf-4ae226feec0mr1124631fac.21.1794290607367;
        Mon, 09 Nov 2026 22:03:27 -0800 (PST)
Received: from [127.0.0.1] ([20.83.54.120])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae23095c5csm971596fac.16.2026.11.09.22.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:03:25 -0800 (PST)
Message-Id: <3d8d9a9261a1f4fcb883ab9afd236f254a494430.1794290598.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2305.v2.git.1794290598.gitgitgadget@gmail.com>
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
	<pull.2305.v2.git.1794290598.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 06:03:18 +0000
Subject: [PATCH v2 2/2] archive: remove USE_THE_REPOSITORY_VARIABLE from
 archival modules
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
Cc: Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

Refactor archival modules (archive-tar.c, archive-zip.c, archive.c,
builtin/archive.c, builtin/upload-archive.c, and diagnose.c) to accept
and pass explicit struct repository * pointers instead of relying on
global repository state.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
 archive-tar.c     | 5 ++---
 builtin/archive.c | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index a1c66024d4..642a3ddfc3 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
@@ -337,7 +336,7 @@ static void write_global_extended_header(struct archiver_args *args)
 	if (oid)
 		strbuf_append_ext_header(&ext_header, "comment",
 					 oid_to_hex(oid),
-					 the_hash_algo->hexsz);
+					 args->repo->hash_algo->hexsz);
 	if (args->time > USTAR_MAX_MTIME) {
 		strbuf_append_ext_header_uint(&ext_header, "mtime",
 					      args->time);
@@ -529,13 +528,13 @@ static struct archiver tar_archiver = {
 void init_tar_archiver(void)
 {
 	int i;
+	repo_config(the_repository, git_tar_config, NULL);
 	register_archiver(&tar_archiver);
 
 	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tgz.remote", "true", NULL);
 	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tar.gz.remote", "true", NULL);
-	repo_config(the_repository, git_tar_config, NULL);
 	for (i = 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
 		if (tar_filters[i]->filter_command)
diff --git a/builtin/archive.c b/builtin/archive.c
index 3c1288a123..8b7d56f8cb 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
 #include "gettext.h"
-- 
gitgitgadget
