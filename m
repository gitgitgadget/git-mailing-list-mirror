Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437388;
	b=v4k7n+m9usHmjzC5RaHzzpAf73cXzpqCERy+be3qtCMJXO7SNT2snsu5zYmGUm1z4Mqo
	 IH7NaPSQRjX/a9FajJwhLvnA8z9IPmmgsDg6jIcLpaAGJ65/rS3QIYcSpQ4wDNBcnUe+m
	 +3OD/StHnzEmjg6j6RfFyu1drZF0ytmPkRYfKlk87+G4Bj8iYr5ZsCf92lpsiUPQujxr1
	 vKc9slanK4GTsGH++5PVDtK/cbmpPG9KQx5Wx3v35KDhrcv6GsdvVCyhJApmQ1d/YpcvO
	 PZehk2Y82TDx7p1IRTM6Id4Y9R7KJ49z2UKCgJMe+m/TT0CKRRFeoITaZpLunhVB8AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=bEob/lfVBWFRkd1Z03qGDL+K2WgGDaVfnNiumMRBXHw=;
	b=MnkxhkOOOoRL4MmYzGdU1HMydvCLwP/EanIY+YQWwkPdp6ESXeDL6uMwSDxMRffXrRFA
	 IO62XOaTYBAUPcHA/EGkSA0ElyFPEDQ1ua99e1PuBIV1+RbMS2pLnaltDfpJY7+ibykBQ
	 Bneph1uMmPRK3OtqwG7LbUZjbuQtTu+eCUQiNd0P9kED85RUgasWKkxvXhZH3WKD4T+/T
	 QgBJojH8UI9SeCyQE7Csq9K55idgWxLwF47ZSy1qt+e7UNYjZ/Lcb7+QQ1jXwZXUV5yV0
	 drdmeeX+OKREwiTu1+JTgOp30UWzS+UVsK7SkWKUNA1GnN+1/jUcaFIJx8XXF1utUYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbbiCaUZ;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1D606B03A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04A1D606B03A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbbiCaUZ
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-843cf077f10so4521230a34.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437387; x=1795042187; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bEob/lfVBWFRkd1Z03qGDL+K2WgGDaVfnNiumMRBXHw=;
        b=TbbiCaUZMO2ktywN96SNPA5rWXstq4jMm/5+sbcFvfiGGnFsv387JBFx0wjoHsHEJu
         VLzUh0zTc9Qbp386Fmj99hV7qvWKYHOGgzXnMcFrWEzIu80ezNW4vAqqhXmye3qwpBvR
         P4jwx+rx8rErxSDgOjpH2wnYTnn8cF7Rl8pEVGPq2UWnhh+O0IW9vEcXmAd7xX+OtiGO
         TXLtKRzPanr0v8d8R9X4LWkq6zJuCMzZ4VwsitP/resph+MsKXq6t6xts/kHllQTwk7O
         dR2OkNLbZ17teORc+b4fhKxDPIB3qCT3mMevZ5XTqUgJserhpscMk02ceSEsjW3RRInH
         bjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437387; x=1795042187;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bEob/lfVBWFRkd1Z03qGDL+K2WgGDaVfnNiumMRBXHw=;
        b=d9lfwBvwahbsT3QLOmMUJegEC492KJfoBz0WzLzn0NMK2wdZ7PqI9/E7M3V//Wh34d
         7q0CX/Y6OcxwNQz/hXohMBkN0ZfhloInNepY1tXqmxBw8xs0w3G20miby97xLCmDmFF8
         hFBKvn868D7zu8wxzpRsZqxzErlx5twCAtM5wMUcDSAg6WkzkSqbLujiLklrX0AfAfGP
         FuLtNLfCmwl1zmEwSELUeqWYSVqmbxAB5TWYD/gOCqCDUX8azAtJTd7J9WcqldSyJEV1
         aKJJjxUNYncN66G1Po1gPDHMZmcPHSHyu/qS50kAVcNBE+bQAeo7NJBnYgo9MopdwZ/8
         m4FQ==
X-Gm-Message-State: APuU4Z9C7R1f3QQeH1LfOyDTImGxxykk1Q4+/gqjMA0DG7vl7BUgo8bo
	pkXbKIU/ukjAzgndEoSma4VO1mnC5VDyNw/FF4/5JM5TdoctWlx5kUaC3w42GEGW
X-Gm-Gg: AYBFou1JoGCLWQmilhVLD0RVFI437UDHc78X4lHXACQ64wQg9SrwrghO2OD7eg4+WH5
	YGSCO3OQyeSSGyRYdB90evOUvIKMpfocVV7LLUY9EE3vUEO8AaWGKIOcjMrm1mZmT9kLRaSoMCA
	9Wj5d9Q3BRjOaq6OLwipcg+9YwuI942URjnsSjVw52cad/Mv87z/0FgKac8II6bflgDS3pQ5lOF
	D1n4DRnWLHGQExawBzvphZQcKXP63STBjbLa3qnxfa3dy+kU+P5NyqCkhCKtS1XWf7/jPo4g32c
	hpq15iUdeVNSYfsEwV3wwK7lDaubQiAh6yNeP1QyVtj13GUcb+BbV3GtEcZYVr90sh+8KE/XeDO
	RGBXuFrsCzOEEXu9tvmNfwAVWte/tNG/5FmTHee97sL/wuWsz1h6/NkxauJrz9+1cT8UDNFxR2v
	FSLUlo2bZo0UQXxwI4x4molYYLhjH828HemKUaQY/cjJIgNuBgT3w6wyKOOJED0ooWnAV2fP5pm
	GwNGLCipNOGbgfJ4xHHKdYhOFBAJN554+pK2CV0gGJSOa6Z6XU6afHsl3woJ3+PACPJI+ROUslJ
	cC7NlfL8Mq6lQld5GMRyVWw2whkOv3946Mk=
X-Received: by 2002:a05:6820:4606:b0:6cd:3ffc:ad02 with SMTP id 006d021491bc7-719179ea83bmr2149500eaf.82.1794437386977;
        Wed, 11 Nov 2026 14:49:46 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a94588d4sm5179193eaf.6.2026.11.11.14.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:45 -0800 (PST)
Message-Id: <474aebd572dad8af4820fe5ac13d9c22ec3ac9fd.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:14 +0000
Subject: [PATCH v3 14/15] bundle-uri: handle NULL values in bundle lists
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

