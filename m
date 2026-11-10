Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335975;
	b=IherSn9DSgUP8FLK0IxeWmQbtIMwyrLju/fQZ2kbIyQaxjssa99ThAc2h6V0OyZD6bjl
	 X0y6UwkeF8ZxbR4MAvowuBlriq0lL+a+tEms3nt30/QMC4kwtYrlN+aUOPi3B1pVsHMp0
	 ITldVuwLDpl85MN9EEyUfCcODudWbs4JsxWyHtaVMN4snVRWyAv2sUT9Sqt9nxkfrUakM
	 jFO3hESni0Lz9ePQ+lZuZ9kkUcX+2kV9Ta0W67eLxeCyfCvwNYuVZJ+3VeVnMSvFc2Bl4
	 dEJaoItxEX65cNDlOwKN+Gt0hwjENRehiSXerJ+2ehgzj/6yfOMXmbNSU0CJ5CTsPeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=XKqfxmSszHzbTCNmAdD3LIViPDn5cGF9dYSrvxc8SDk=;
	b=OOOZy/Jjo6NML+bcuGEWCcuD4XZpnfHFCFjrKvJEvYBQz1T5OZMAnbLAjdVR55qVeBKC
	 uh7OIz/9PKGkYv270eKKzNG2dDMdkUWxGVoBZPkrP1LfHdma5RGmhJ4HY9fs5fkWlX2eu
	 JNoe83XU/bPuJ+XpuVtS4ei7DdX149U2dSHhTcXSiBx154H9flqp9HAyPIcvEtolMGRlS
	 Ex8DVERjfrcqXmiaqpN+5xOkymFIZ7KzDkGkXcjONtmpI6B8AU4aAgIQnBc5YdCglZoLe
	 AEAfGWqXREcCRzNDgOsoYZLsBKpVX0x3+CHyhBTqdRWcW2c/nQvzosUkUZoclAgGjkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RX5j0Wia;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A360A2609
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 18:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A6A360A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RX5j0Wia
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a3c08d6928so4102360c88.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 10:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794335974; x=1794940774; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XKqfxmSszHzbTCNmAdD3LIViPDn5cGF9dYSrvxc8SDk=;
        b=RX5j0WiaMOhbkv+4Hts1KCg6voE8Y5OEGtAR0ldhAiaTJIg8hI5kymJAoqaIXD2FA+
         T4cskh3gZ0PP288AAnx9hF7yioccD2m8o57gGYPtn3abb2jZ5QDl7tEJV94/uSqVyQpk
         mvh7OJviXXbDpCabdTtSeNan23d1txq9Z/5ph7QYQxvpWMlJzetfUufJzyU6h35i0DEF
         xfa8AuOmsnHhrli092N5+mi5L8kxit0M6SpfzJAwcbk1B5P5Hr3mj8svPaB2yWP19bNO
         XKqTx3zFYrWbZ6TG+fLIoAefeObVgR5kzjh0KY/m6FLblY/XezHbH1iZru7UXBqTFpaG
         1XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335974; x=1794940774;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XKqfxmSszHzbTCNmAdD3LIViPDn5cGF9dYSrvxc8SDk=;
        b=SMWizkZhqZfK9+8ZzSVxmUpJmycEtDlkahfTr6pd5wlL8xHr23qmaf8E0BYpKe7zux
         q/sCaj+VY9vGPyH5X0fuUWev3zAdWCKRpGIjIynz1zRN8RVcPWo8FEhjJ4uw7/UDpuZI
         amljBSkPOiqbhD6zUVCVb2JWn3B8LBnh6zDgTWKQly9pUJ1j8cIWZ+5mcC9uXi4kMCLL
         uWcLa2MTVql4y3PzswIINJPSxOmR+qJnBenML0nxQ5RupKrAPyMik4a5mRPxvv+je+V4
         VKwsn7Va76tzFdnV2+goIxkIxq74srVuJFvjOsB942I3mTfbf5b6k8/f3KMjeQ5FssqM
         rk3w==
X-Gm-Message-State: APuU4Z96LLCmqkRVnbW8nqVQM6pYeZbNAOVBvoTQihomGvN3lbB8UeW2
	vNBan69Dybd9pQLXRXyzrBRhCyOEVQUeVDtyQIpxz8zqdSIYl5VyOsckD29oHm+T
X-Gm-Gg: AYBFou35y+RqZxQqlOAJbL2CArV6CN2qIqxOhVBD3aA2ZuitEMylfiZG/Nwg14uM6tD
	KbPUZkK3amtPsj0TsT3v8J3P4vkrH28ZgivfCWOP6KpIGlsHRQRkxtMy4dC0M9yHTseVirizAJZ
	mDWKNBA4LX9I2Rs2GRvNgrfZQ9GbCZLx6IDrp8C90b30uQcGMGiC+5o/UZ2YfVB6/haRyZWeKZZ
	cP2AGllEqvMUTb22817nAwLFkj1cWkNFwr4Dcb7P7jDt1fUtsYebNne2DhXJv3j38Wjjot5O/Nu
	dABKwDM7coa3MOhLOeKGU9XKJIXaW/PDM4XAGpPoY4ZgUImQ5peCtA4aUllpt8+8aDu8ZEvoBUN
	AaE7Y+9+3IunRal82TOB6dF8/NQYsgO6CpxvZmBQ3x49Mf6+J41ocRzMALbiTYJhXrTRvKYPoZ0
	7RqEqo/EfKpJQ0NZsppFVIMjA9SjzeAcmUsekRo2ytC9wr5pgZQAqFJVIvL2PAK7c/A5UT0xAmv
	KMijD/kbB5nkEyj2inmKlfe1sz0a8/ybRrZUo47fK9eVa6cikMEaMEDvMJ764FcIqXNWaerHTq2
	dgr6TAEmYFTkE+/cH5jyG0MIk/xhIY4Cpnrxv6iXONs8JU+UJgj8
X-Received: by 2002:a05:7022:3a86:b0:154:fa0b:6df1 with SMTP id a92af1059eb24-1b3b6032ca2mr4670332c88.37.1794335973766;
        Tue, 10 Nov 2026 10:39:33 -0800 (PST)
Received: from [127.0.0.1] ([20.171.32.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm8711516c88.9.2026.11.10.10.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:39:33 -0800 (PST)
Message-Id: <398b54f00a1278f22fef456384c6c4ebd1a1f576.1794335969.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2305.v3.git.1794335969.gitgitgadget@gmail.com>
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
	<pull.2305.v3.git.1794335969.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 18:39:29 +0000
Subject: [PATCH v3 2/2] archive: remove USE_THE_REPOSITORY_VARIABLE from
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

Refactor archive-tar.c, archive-zip.c, archive.c, and supporting files
to clean up archiver initialization functions and header dependencies.

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
