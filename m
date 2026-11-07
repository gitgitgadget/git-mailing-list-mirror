Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040995;
	b=dZuYiMY8G1DyP9u5OJTWcSoR/LIwytVA1DvTLY9ToSOzkFpzel3WQ9JU0HeWooAl3Bos
	 PRBpHDES6I/FW9zNUzcLR4v9BcyZQN8VbMBmDoLscRuG055A8hj7QZxhw81lIXeEVYfys
	 rbXILu+5ayuQnXGzWjooeUiWP1Kbp75EoidgOX9uf4Sx1/YFKTgIw1x9HkNFPHtofeKZ4
	 ywZjCJs45baOOwO5Iglogm7wAB3xAanZbNvGniat1pI6KUphmzYOuw07FSSDfkvTMmv/5
	 zkCIv7wtzXCJQ1NX8LWW8VT2j1JCiJ/Ac7wBWtSN7CyIK7Tex+KLgkyYF8onSNxoCcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=E8faZZ5ptQoCmppBy05ePLwNLRxZ37AYXhxH+RAyWsw=;
	b=HNYfrblheNVWMFYI6ABMTeyShq4ljyAt0pNmI1hGMzU4cB5HbqeG3i6zr0UsVEwIM9w3
	 fRM91CwxRpLPyqBLOznzdNjZDG9AKE3GW/5x5lAtidPPPPEexzolWXkKCbCBBP4tNoXTA
	 6T4QvXtRjti6OtwNq3A8S8+cmJQmitAxjqKbrk8+VztnOv7UpFRSnCDyaA7DqqzzWXSTT
	 mqOKITzmi19FMbiDcK7nbP3zTeUhdDoJcPDmZ2S/ScAJ/VV4TtwQRMHVVmw5wFZM4PlkI
	 T3EVRnT4PZVAD+bfSBT8z5xWNAyZjiCPZLyLFyvRdSJWqaq+f2yrOiMeqStKdgU9MFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aHIPQvAO;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235B606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9235B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aHIPQvAO
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso655303a91.2
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040995; x=1794645795; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E8faZZ5ptQoCmppBy05ePLwNLRxZ37AYXhxH+RAyWsw=;
        b=aHIPQvAOkThMIVE1Y1qcIiSwv8mkaBHVmcmCiJevvqDRZoPMqkGB+JK6POZxarCgau
         CgFMfrZ8UyaeEDyQsrqSYHQBqSxReqSzMcT8MHG2r7cyn43iHEBpm7x9uK28jwyZt2GU
         4krpI92pnorcN6nAvSYSGeWxpxWtOXz/Ac2OUkaPTe6oUEpqTEn7YCLfUHO5j2DYEN4o
         jWsWzdv9m2DnA0wballuC5+/dhryAlcr3qa10tA1FnVXg8e5o9FDdHDE0CDy/fgYCLeq
         2lfvq2OH9J9pbLsyoIjE9J8F6NyVqXm4jveXUJ70isM56kS667zaWLU9YAiXugsOOqef
         HUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040995; x=1794645795;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E8faZZ5ptQoCmppBy05ePLwNLRxZ37AYXhxH+RAyWsw=;
        b=oXbfmhnK7lpxdu04fsgBFA5lwF90AAs31TSFDaZGzRxyLYirjFtQ6c8N/E3RhhvA0u
         LrCjRGwjMdS2VUU33g4CQVvluJVPmWQ45YVwMUMRoY0rr5TkLFRbCuMCuFXKbbFp4dnJ
         MpNJldoAVoxmjsRsfo+5yOnm1Da7wlRGbf9Nvym4AGoLVw7VOZANMqLutrviobQAErYq
         0jdCGaUkmKqx+gC6uztL/GuA9npjZiPvoOJhfL35cMX8zzmvdMLJhMuX4eKc0fN03jWj
         nL2TMpGT3gV22YDgkdNCgKbfDPPzsu2tmfRyMKDktMq6EPsv/lSVymJfhfxP0rOo6Wea
         l3JA==
X-Gm-Message-State: APuU4Z9XjFVBguboXVCDj9GDC63vjOxkaTxygHkfvpbQkSTyS8EM1cue
	mCZN0tQm/1Mth0fdVYnNiG0bkqCaifWyhaNHTSLIYZ84phtvL/L3vQUhPwDzBQ==
X-Gm-Gg: AYBFou2tMUfJn5Am90qPGcKJgOJsi4eHcAlS6Yefz465pXzmMZKOX9IF5audK0miRrV
	MColyrFunYxpHOT3v8fa4HDM9azwD6rnGC0+omXF7RXDnbyjjtlJz8W5tjQ3ImheOMyvCXxxl0k
	g0rAeVDx0zASkFqe/h2fjmJ25pzKirEc56PAH3/zvOFv86RMgv9hY7hee5/kUc2v4d8KWwhB+CD
	gSWRDQqTjGFfB2oRqrwSD5Gli//bdXDT6Q1t6PSbb/5DEH3BWrw7E3XFOIbeNbc5MGX77IxkLet
	eZL8GwJ0mG07nXQdqkk+rKZiom4ymjrWGrTVzZJKAExC3f+MCS8+YbeUJXkkZf6vbSePkB1FObt
	t8t9neB2KwVjHS1parvn0XbaXN/ZJhZiiBFIJHzThbUCF6EMynFdrMM4s9q3zKFIReahEu8IiH2
	6Ab90yHLnabcW90VEZyCRWNfPzu724hCmP8Re0EjBJhyANafV5R67FFrJEeKk/rjehiEZOI2GhH
	fDBxB+INjXfzIWoJB1gPesJpZC5zO20mZslNWWNSmyHzO3OQ8+i+gbAfs2K/XQDlN60rHXk5LYy
	TFQyJFefNIO3USIHr9rvcjLWiQwH3qcoLg==
X-Received: by 2002:a17:90a:d60c:b0:3ac:6e91:3f22 with SMTP id 98e67ed59e1d1-3b0db72c4d0mr4267655a91.52.1794040994882;
        Sat, 07 Nov 2026 00:43:14 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058d2fa3sm2594937a91.13.2026.11.07.00.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:43:13 -0800 (PST)
Message-Id: <ce4c190ea2ff1a1fee77582f98b023c87e7dee41.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:46 +0000
Subject: [PATCH 14/15] bundle-uri: handle NULL values in bundle lists
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
index 7de17634cf..8c8d17bd2c 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -165,6 +165,8 @@ static int bundle_list_update(const char *key, const char *value,
 		}
 
 		if (!strcmp(subkey, "mode")) {
+			if (!value)
+				return config_error_nonbool(key);
 			if (!strcmp(value, "all"))
 				list->mode = BUNDLE_MODE_ALL;
 			else if (!strcmp(value, "any"))
@@ -176,6 +178,9 @@ static int bundle_list_update(const char *key, const char *value,
 
 		if (!strcmp(subkey, "heuristic")) {
 			int i;
+
+			if (!value)
+				return config_error_nonbool(key);
 			for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
 				if (heuristics[i].heuristic &&
 				    heuristics[i].name &&
@@ -210,6 +215,8 @@ static int bundle_list_update(const char *key, const char *value,
 	strbuf_release(&id);
 
 	if (!strcmp(subkey, "uri")) {
+		if (!value)
+			return config_error_nonbool(key);
 		if (bundle->uri)
 			return -1;
 		bundle->uri = relative_url(list->baseURI, value, NULL);
@@ -217,6 +224,8 @@ static int bundle_list_update(const char *key, const char *value,
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

