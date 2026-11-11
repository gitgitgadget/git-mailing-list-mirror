Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437370;
	b=W5T8TRL84R1L7P9qiFv7rlEnym+hxJz8mm0Bbl4Y6uU5gU3SMLHDftz7fKS7ajxi3SdL
	 RmP/lpcgLIOdtGIS67CdPyNPUtE54yIfi88Aexw6OGzoZhuUhgm87qEnlmJbHI659O35L
	 kMf4nSXOHm6xlCyE+gADuShvQ0OPC2f38VCqsO1Ws0SKmN3HXByXtdILLFrsZMqOrPDjt
	 PRyBdhRX3bHb+CWkjnP7GgggE1Mw/puWlPBqGBVd5FKAt3LkQSjAUSiStqa2hVjhBIbbh
	 EAbxnRQkiyQ3z+1G6d1wu+6HNj/+9axBRTnTr1NYNK13GPP3m0uO3FYaGVMNoxPQAUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=kFk++mZfDrYWd+9wX0t0+S06AEyinXzSsqh4WWzWXYk=;
	b=Xivs8q48VBReXzO0032rLieuKOUmbGPOszvztyr7eI2w0EZezFu1rWfKRUFw3IO4OiFl
	 1hiTJ40RtySKtB1A3DS7q3JlsvWKQr39HhaB9//Z2FxVtrDTe1eIeNZDpjyKvuIsTsp36
	 8sZiyE1Eqyo7ivlg8zRJVPScHVwHEyvwMtcsEgZDNdBP3oEeNY+yOQ3el7FkfHzu8xHNC
	 VUp8vGNLLwWNJoQ9wBPiBmPKsLvIJldxRK7zizruszQ/Q5Ec5a4gzIH1xadblZoyvXsPG
	 D6TKXMq0A+xsNwthUZGgxgakqkdO/7Ze/7NqpVzpV4jPA7h4kxKTAUFlC6GgcWgk4HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e+L6MFGZ;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FC4606B01E
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19FC4606B01E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e+L6MFGZ
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-717034b331dso2204821eaf.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437369; x=1795042169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kFk++mZfDrYWd+9wX0t0+S06AEyinXzSsqh4WWzWXYk=;
        b=e+L6MFGZGq50ZgNPjDa1ukOVRdfVusNXXB7Br79zC1TZex5l/n84wYzVVv6nYBPiQr
         7p/VnmblyH84VAUVu2Tu0lSGbsVZFk6YDk26PyDlcRi/QbEuhO1Siz5OVPUx6g0i+cys
         iLB0yxD6m16NVMqNK/YhaYBNE2vdDMLy0+gL+EsiLSFx7KfxjkkgZmEWweDPQ3RSYnE4
         aw7l3cfEjxtZeBrMBAB8gp2KzvHF5mSfBOAYa/w/gmT7NljT2ywPPyoM6zzs6CuSSPOB
         pozNBpkSCm44Mcu31MfvXUCrjZNAuo/SCG+bGtpDyyRgQ+pnfwED/xgrIT4nEg2C7iyf
         5W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437369; x=1795042169;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kFk++mZfDrYWd+9wX0t0+S06AEyinXzSsqh4WWzWXYk=;
        b=e8n2o8kVC8lJr13QaHzJDeCiz+NqmH17BqR0y4UPRZU62wuvdR/Th/fSM0LeMJv+/b
         bAKbJovnbsCJNi2hcqwqIWJGt5ICy0kp5oNxdJhBQf6349Dyit+zblyhhW25gcOl/Ypa
         hRxmejpWnrCuLWU56iHCzoyBdzGJ49RVKVHhBWh//cCs4ZYEX+ohNFKvd7jlUTs5TydR
         Aj46GOn0k+ymoHJh99mIRb8Rj667gCeRz7gX3v25np2XMtV5JpsKO0+EIG5pWcRvUtDO
         7aeXy9/qq+iKMvJ3m3KMedPjBLXYW2tT720rdmbIqyNhKwG9yVhUFyQZt0cnPENBloZx
         FHuw==
X-Gm-Message-State: APuU4Z8VUa6gItRVazBswUhNuh+VTxmv0zWi07fzSSgRR4QqEWAgyo33
	zzIa2QWyQKXWDKVFQ3huz18cjgcNqw7GUoB3jdKAwZ6R+mGHX5AYENeBw7SMV0X2
X-Gm-Gg: AYBFou2Fp0QAROymkNtJZuUL5gUChRCymcr0oO2RtIQ9FPDJCWLZxC3H8Un2jaKdxRZ
	HCxRsgmhOHMQ6L/oq8ej7TGN5xXRFm3n9fVTAZwiWriYfA9+R+kC9y0rj3yqBNR1x6mBsee/e6C
	by96rRCCjutMi8iM0v28wDkd6kD51ln+xV4hiiPS5AToOnKB/pU6mFFAxzIACsXfD7enNGr9bpx
	Ew2G+pCTllLpDgnq/qZ8sfACGitoQJ4TGwPk0+2/6vCDyXg/Dt+QWCwgdMqu0iohnGJdmJxD1KS
	s5Bgw2ppI1IadoSlqI14fETN95gj9+DZnQrSec78hCkxltrPK6BQZFntjO5Gp6HlezmHucJl71j
	z6WHosySUDxuaaAI1PbY1HpmacCiYDpMYtO6uq9TsUd/er7URe3kMyjHUZkWSyDIoRHtDLj+176
	UeHUo8grM9CM5csngyLxezWQZC3txdE+YzOJ1zJLvH+SpPFvqP8wcRnbu9+cSctmtA9eUcaiiEi
	zgccx5iQzUHfgUt5udaFQbd2Ax/a1+hSWUpHsNtVzoL3al2RkkWQaPo4V8tQKqebY5cOeptE1ht
	yGP3N3i7Cwoc7pacz4Y9py1ylReZs7FyHjE=
X-Received: by 2002:a05:6820:4a8f:b0:6b7:8415:d790 with SMTP id 006d021491bc7-71917976e01mr2088723eaf.59.1794437368975;
        Wed, 11 Nov 2026 14:49:28 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a9458d1dsm4572573eaf.7.2026.11.11.14.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:27 -0800 (PST)
Message-Id: <339590cd4b8b0611f4b7ec55889238d13e2bee3b.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:06 +0000
Subject: [PATCH v3 06/15] remote: handle NULL value for remote.<name>.tagOpt
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A remote.<name>.tagOpt without a value makes "git fetch",
"git remote" and "git status" segfault: handle_config() passes the
NULL value to strcmp().

The setting takes "--no-tags" or "--tags", and any other value is
ignored. Ignore a missing value too, but warn about it.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Assisted-by: Claude Fable 5.1
Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 remote.c          | 4 ++++
 t/t5505-remote.sh | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/remote.c b/remote.c
index 49ee2ea318..d3164fee69 100644
--- a/remote.c
+++ b/remote.c
@@ -556,6 +556,10 @@ static int handle_config(const char *key, const char *value,
 		else
 			error(_("more than one uploadpack given, using the first"));
 	} else if (!strcmp(subkey, "tagopt")) {
+		if (!value) {
+			warning(_("missing value for '%s'"), key);
+			return 0;
+		}
 		if (!strcmp(value, "--no-tags"))
 			remote->fetch_tags = -1;
 		else if (!strcmp(value, "--tags"))
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5fbfcb0848..8b4c7006ec 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -90,6 +90,13 @@ test_expect_success 'remote information for the origin' '
 	)
 '
 
+test_expect_success 'tagOpt without a value only warns' '
+	git -C test -c remote.origin.tagOpt remote >actual 2>err &&
+	echo origin >expect &&
+	test_cmp expect actual &&
+	test_grep "missing value for .remote.origin.tagopt." err
+'
+
 test_expect_success 'add another remote' '
 	(
 		cd test &&
-- 
gitgitgadget

