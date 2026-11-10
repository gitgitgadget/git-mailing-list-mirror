Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296244;
	b=oJ1/teIBHRO5TVm249UBnt575eFgwEwwg4JC6y/xWfPSt/f7dFN5aLgQQ2hp02ZvilAc
	 Jcf09Xk5gRtO2WABf4T7bCECcVtqcEsN1R6J6x70dcEdH1fKGCicm06cbHbtXWlWkaiHb
	 MBaNKqP80LLL4bZAF9ARARBBhkSAU/UKJTqVWVFMnHkVbPyRQUD0L59PsPjkw7Mbrxo+V
	 ZEizo5wTHA9ffogROCCA1FKin24Xk0RUfsAwFiwYAJRk+dLgFJ8W2ptroEPLApGrrnA/Z
	 hHr9AxD4aJbzCIcpN+uzaCm6XUgo59LKTDGQiUgTgv7NWu2Ff7Hycnb0QeHyzCWdJOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=bEob/lfVBWFRkd1Z03qGDL+K2WgGDaVfnNiumMRBXHw=;
	b=zegadqxQoRhwFbYwGaD8IqN0rB+IWxTvh37bSfrYD1kV1fdsjwwJxXLY82t+3LatKzSL
	 A5ypQMubTxl+gKC8MFA+OWVPLRwagG+t2ehe7yOms84psYQKGjzkGpaDxowK/EoqN6uaU
	 GmxoKUxos6rF8Nxv7qGO/foykTQSEhn2Tpci0oMrL6XcXverAGg8zqofYmB5V9MkYmlCT
	 FKAEtYoN/0br9euZwq3GYoXJCwRMX4XxDGlfevizmxpV4fF5pZBfscf7jC1j1MBxkwKsf
	 y89jSuH65u796U51L2DXlxY0yAxCw/U4kduxs7cKnW0k29OyxnbNq3Uc8G5rdlurJzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oJ+rbS0r;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE260A6F7C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20AE260A6F7C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oJ+rbS0r
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-714d57774d8so1053528eaf.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296243; x=1794901043; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bEob/lfVBWFRkd1Z03qGDL+K2WgGDaVfnNiumMRBXHw=;
        b=oJ+rbS0rMb3enDLhtjtA5VpkjU0VSSQ2qCNGKJ7x2oiOnDLD79p+3x/1+3S34EeNAo
         cyKoPSUsMGI69b2M4X8QLNKMk+pbRBwp5ALngj9Y6eiGqoZh4c2IvuR/5s1BVdEy3r0Y
         LpJjpVIYfsUwlUPP9k3P32zoHRc61jYZd2TvUu9dj4UM+Btz1R8qWXNTWHbn0zhdJzWr
         Eij0RwgMpWJ///KByZ6Eadyd+hRmD3BCfl3RZa4+28nop4nVXF+vbIOusngXPgxlK0R3
         nquSmY/Bu3Q/kqaoR6HfQkQGNNij8UNbtbnJMhG8V6ffklCsGU1pcRJVavE5qIgFxarD
         Dbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296243; x=1794901043;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bEob/lfVBWFRkd1Z03qGDL+K2WgGDaVfnNiumMRBXHw=;
        b=1tRFYZvCO3i+QnlEsWGpABMFzCrsNpLhHCPpQMYcrAVMWtgygeF1SgZKMwhY+UNvIi
         ckEn4a3/y/M3Omf/28+2FFhNf1wnM4sJqB0Z4V2LVYm3nPEmceqSTliPWRMjwhmYXopz
         1J318VqHQlwM6SBPe0UIfWS5gF+hh0OX5fIno+F/LPgYJZn0fzj/syjMnoSoIKzidDyo
         D9drkiJ8sQJXCxp1UX4u50puouzTjb1nZ51c6WiDGTmuZVL7uey0yoxFUyvDYwMNA9Ck
         sXt6vYay38lURxpOjn/FWl33ifD0MehXj2Fx5UOh9miNjplMNhPvK2I2ueZsREzgJVLY
         da4g==
X-Gm-Message-State: APuU4Z/kvQxMTymwbwTzHPbVAZE6dk+TYYz7CqE/V64/4QQRwP81OKNW
	PStI9W+ZzzIzJOwY4KBRKcWznC6ESXax5L/SUHD9ZH72/NGlypSnjOeGlvLeqBjf
X-Gm-Gg: AYBFou1ZV6ulFlQf45lHILqCs5w7LEuN0UNe/Y6JE1z1J3mlacGUZ/4jjmx8yDG6VaO
	0wY0nOIgvZJYqqN84cmb5h9+wUPsgrMrnVkh+1w8hvjwI9lHg+ANk38y+6Jvi9+R8k4jOBtAnzj
	li6y4+H/p5sHPNlt/pPSMtNwfdnEEBbbIbxyKWSsVCQKi37PMl5+UczwCeEGjXRJxcLM4pSpqvO
	3Tz6fZGzspP3Iz/GoVCblaKKq4WjImZDpFEd7s1iXzguKTyVmPrhXrElfxOLj+7AhoJCqe7Sdcw
	WeeJkwu9yYb4fXApN1POGc/V9feVhwfsvH+88X1pfE3x+gaXGdAPhHdjuF7yVhqoqDwkyPKIcxX
	lbDZHiAz8i06WPxQM40Q3wdhKa8cJL1EBgPiyEn8HMMJWXNcgHIauZ02XjQoRK4YQPYbjo3KBGv
	UyDRQl0RbIs3DndsFb8OkUHOaycoknZE+OyK5p97xiRnSDGAQRUY02u5qGSFIox7VBY1mx/PfxC
	9hK/OMPrmi7sTmjK1cMabo6/pba836qDOKnQGQBkzkO6eB+mqcSSQL0SCiuDcm+P8HPOmw7q7Nb
	FVeAhOf6p1Gcp3pyzOElOjSjAk+c2jphLz8=
X-Received: by 2002:a05:6820:7616:b0:715:24e6:9528 with SMTP id 006d021491bc7-718a7ebf34fmr613748eaf.89.1794296242975;
        Mon, 09 Nov 2026 23:37:22 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a9a459f1sm1149432eaf.9.2026.11.09.23.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:37:21 -0800 (PST)
Message-Id: <fb9e63541bd42aff0fb8b51ba79781e0d80e8531.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:44 +0000
Subject: [PATCH v2 14/15] bundle-uri: handle NULL values in bundle lists
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

A bundle list that gives bundle.mode, bundle.heuristic,
bundle.<id>.uri or bundle.<id>.creationToken without a value makes
"git clone --bundle-uri" and "git fetch" segfault:
bundle_list_update() passes the NULL value to strcmp(), relative_url()
or sscanf(). Such a list can also come from a server, through a
bundle URI that it advertises.

Reject a missing value with config_error_nonbool(). That makes the
list invalid, as an unknown mode or a second uri already does, and
the clone or fetch goes on without the bundles.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 bundle-uri.c                |  9 +++++++++
 t/t5750-bundle-uri-parse.sh | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index 67a717e857..41c817eefb 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -164,6 +164,8 @@ static int bundle_list_update(const char *key, const char *value,
 		}
 
 		if (!strcmp(subkey, "mode")) {
+			if (!value)
+				return config_error_nonbool(key);
 			if (!strcmp(value, "all"))
 				list->mode = BUNDLE_MODE_ALL;
 			else if (!strcmp(value, "any"))
@@ -175,6 +177,9 @@ static int bundle_list_update(const char *key, const char *value,
 
 		if (!strcmp(subkey, "heuristic")) {
 			int i;
+
+			if (!value)
+				return config_error_nonbool(key);
 			for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
 				if (heuristics[i].heuristic &&
 				    heuristics[i].name &&
@@ -209,6 +214,8 @@ static int bundle_list_update(const char *key, const char *value,
 	strbuf_release(&id);
 
 	if (!strcmp(subkey, "uri")) {
+		if (!value)
+			return config_error_nonbool(key);
 		if (bundle->uri)
 			return -1;
 		bundle->uri = relative_url(list->baseURI, value, NULL);
@@ -216,6 +223,8 @@ static int bundle_list_update(const char *key, const char *value,
 	}
 
 	if (!strcmp(subkey, "creationtoken")) {
+		if (!value)
+			return config_error_nonbool(key);
 		if (sscanf(value, "%"PRIu64, &bundle->creationToken) != 1)
 			warning(_("could not parse bundle list key %s with value '%s'"),
 				"creationToken", value);
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 70ae94c4d0..a91c1b428d 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -312,4 +312,20 @@ test_expect_success 'parse config format: bundle with url instead of uri' '
 	test_grep "bundle '\''typo'\'' has no uri" err
 '
 
+test_expect_success 'parse config format edge cases: keys without a value' '
+	for key in mode heuristic
+	do
+		printf "[bundle]\n\tversion = 1\n\t%s\n" "$key" >input &&
+		test_must_fail test-tool bundle-uri parse-config input 2>err &&
+		test_grep "missing value for .bundle.$key." err || return 1
+	done &&
+	for key in uri creationtoken
+	do
+		printf "[bundle]\n\tversion = 1\n\tmode = all\n[bundle \"one\"]\n\t%s\n" \
+			"$key" >input &&
+		test_must_fail test-tool bundle-uri parse-config input 2>err &&
+		test_grep "missing value for .bundle.one.$key." err || return 1
+	done
+'
+
 test_done
-- 
gitgitgadget

