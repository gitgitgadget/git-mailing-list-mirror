Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416277;
	b=ca2HzvpAo4vlEJ+H3iCiQJV789INL1Vszb65ZZi7/ow37CwfP53T3hmzoZSKbJV3xEcd
	 q2T7mpAPs5/GbmJyTAGYwXNIhK0vh5lxJTN1F+nZwo/SALkEI4TWmmWIh9li3ABnNbfqT
	 /P1mArChIQBXcQ6b3jAkzs/DCewOvMKKcnxM3RIxViqNCbxMumcEjCctqy+29CBWJ24mI
	 ytNrDZAckagVXA2J1wDHh2s3VUM0UQjVoAgT3Zll811LrbsWMB85D6dJGhbSUCO89ztqF
	 WgzeY6a1/DLSb07KhwNHmoKCjwwYMSr+eiFUm7UVLev+T2e2T350eyuJJVNu7JU3LMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pIg5A4qHvnk2cZs/n1H0okzioB7b/srnZyrD0S3tW3o=;
	b=Ve0ILahjVuzBCQXrt5ypZ/eJvqVALYRCoEtiRgWBUiS5fw6GM7H4JQlkz/4cW9p7qg4b
	 BIDkVgCLkhX+lU/PZ5VpNPi4379vJ1l57haw8bfSfbdfyvMnQd9FmVjfkt4OgfmXXEfLX
	 NO8ydI+kHmzmiDIjtrTUEzfi3ISi3JCFkJGQmlU1PTPuPUI6SJkd03ikBtcQCV37xqIcz
	 fv6Da+3Vqy8HxjDV4h7nvyZi9sKnsu3eMZPnnYt5mwsSl59CAy/B0tn+ZUsA4aFrdi24C
	 EHrHx+GOrE9o6CqS1j624U+NLYCddc6QqLI6XIVJk1IRwbGKadZy7rN4idt0/mDonJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bxh6NVUt;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094B606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 06:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6094B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bxh6NVUt
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so1352964b3a.0
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 22:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416277; x=1796021077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIg5A4qHvnk2cZs/n1H0okzioB7b/srnZyrD0S3tW3o=;
        b=bxh6NVUtkHQEAFkQZq5Jy7ZbQQhUMyYYfCMK6OW5sG1gsFaxDClnpPyJnFFDxdIODH
         ChyH6z9ff9E5UoW2H8zuDk0EfpzcvBkcZlcXnAKHlTRtDYijb8Th+POl1eGPDotrYU9l
         EaGGF2cOdF8Yy8nW9peQCrDeaR1ZA4L78NGy4O8/yvv2HbhcCvaiiTKsEU48ql6MHjf9
         PiaCh5rHDiNNn/7KmL1npiZMBCKigR26iEVNrN7wWlK1eO8v+j5hFFZ2NpFIf63edd9O
         a85Ht7RZdycMrts2n0mMP4V/6MZWBb9R14uQRMCotyveenvj3kab5RM4VYuPiPRKhABV
         +KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416277; x=1796021077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pIg5A4qHvnk2cZs/n1H0okzioB7b/srnZyrD0S3tW3o=;
        b=I5RL3HfMqMdOxzawriwX5c+dFefpAQs+tOWaAZfDFVgbkZgyKRPyJZcEMOGCK6rRI3
         ezqbvIe8wZIkcFODJLJCfM0u2K3yzqcvhMUdtLL3fA7sKF+hE5LJ7pPGIAnHfiqlUELV
         Fh0b+53/9LGQxi//js0gzF/0IUmydFtpOuS1aZk9LC2pcfyRq2/p9KCljreJo7Tf0wkj
         rzeMZbxPyfwTn01XmCELlmD+oEV40oEFLIFccFMQHezYD8we748woy5mjUA5oyxOOymj
         IUL1GAypbXvNX8/wxxEi6wzqADsqapjLNaprKX5QVrQ3GqffYqOIsubWceiyJojoFKTs
         Cvew==
X-Gm-Message-State: APuU4Z/XotjQloibQF9tY+He3fq0Q1QssjD16iG2FT94NiJ2Kd50eTZM
	+vJFD3Su1qnoHDhCTRe5pdMl/wL1PfrmLgW9hvBtiutxLJMrBCodH25O1lw76AG4
X-Gm-Gg: AZFdTZdSIvxxbNmvysJpO5Hy0c/kaecEblURnPzZ5QaExy7EIR4QzmdAj9sv6QUn/RL
	FW6ELdk1wnzMHXZJl8JbGMPNHVyDRmpA6/XCCpqTPcdR0R7Gk6buf6uzfUdkFfGpOLN18viAjnr
	wdXTYNFnQsaF3/4nO5CoL80xabraEGi48j4vfXgyY5GOaRREHn1xxnO/oOJH8ccdkre2RMZx+0G
	UjbiPdECYOuKfhJRUrGJ8p8+O7meeyOxajNTEO190FXfgC73bXQHnmW20A7mlycdwkMOkoc3B0a
	7EOUawix1haj9g3o5n3KjmYs+EPJjzA3e5pIRdkc6yvPvPAcWTrYQ4a2DC0TiOoH8EQlxDcNW6t
	eYmXjSL8mUMBQJpwBaA7DV2VVFwzWOEglhz/ajsdOPym54lXe+1hovvDm+XsbgbZXeMM71QQ+Bq
	PS6bItFwrF5NOuYJE2Bf8V9e9yxucTu5hqwaTeJZcw2UiuX5wAoNYGFfR8PN/C3NX7RwJcj6izH
	d8OLhpcWrZVaIrw17985kY0GfUdeXPjMJUTIFc47QpTNLtxbMQMaJlak3HH0GOp2yGtFGJuOCZY
	f6y5sFZ38BCMhl/s0Unw6Jl2NVkeU43AyDmTJusClNT8X9yQ0pPuyXdcQ5U4/T5psQCtWL3KUSy
	2Wjm5sUjS5wtz48TIHWUv
X-Received: by 2002:a05:6a21:d83:b0:3e2:b400:2b04 with SMTP id adf61e73a8af0-4014db58a09mr9868875637.45.1795416276687;
        Sun, 22 Nov 2026 22:44:36 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1e2f3sm4798671b3a.54.2026.11.22.22.44.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 22:44:36 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 3/3] bundle-uri: do not die on unresolvable relative URIs
Date: Mon, 23 Nov 2026 12:14:22 +0530
Message-ID: <ce37d9588d833d306df3cc9d0e656e09c32e6b44.1795415793.git.aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1795415793.git.aniketgupta3001@gmail.com>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com> <cover.1795415793.git.aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bundle list, either advertised by a server or given to "git clone
--bundle-uri", may contain relative URIs. They are resolved with
relative_url(), which calls die() when there are more "../" components
than the base can absorb, so one bad entry aborts the whole clone.

Resolve them with relative_url_gently() instead. When that fails,
bundle_list_update() reports the problem as an error and stops
parsing the list, leaving the bundle without a URI.

What happens then depends on where the list came from. For a list
advertised by a server, the bundles before the bad entry are still
used and the ones after it are not. A list given to "--bundle-uri" is
read from a file and rejected as a whole. In both cases the clone
carries on and fetches what is missing from the remote.

This resolves the TODO in t5750, so update the test to match.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 bundle-uri.c                | 10 +++++++++-
 t/t5750-bundle-uri-parse.sh | 15 +++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 9797eaed9a..d2a33b930f 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -209,9 +209,17 @@ static int bundle_list_update(const char *key, const char *value,
 	strbuf_release(&id);
 
 	if (!strcmp(subkey, "uri")) {
+		struct strbuf err = STRBUF_INIT;
+
 		if (bundle->uri)
 			return -1;
-		bundle->uri = relative_url(list->baseURI, value, NULL);
+		bundle->uri = relative_url_gently(list->baseURI, value, NULL,
+						  &err);
+		if (!bundle->uri) {
+			error("%s", err.buf);
+			strbuf_release(&err);
+			return -1;
+		}
 		return 0;
 	}
 
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 70ae94c4d0..8abf8f31ae 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -68,17 +68,16 @@ test_expect_success 'bundle_uri_parse_line(): relative URIs and parent paths' '
 		uri = <uri>/bundle.bdl
 	[bundle "two"]
 		uri = bundle.bdl
-	[bundle "three"]
-		uri = <uri>/../bundle.bdl
 	EOF
 
-	# TODO: We would prefer if parsing a bundle list would not cause
-	# a die() and instead would give a warning and allow the rest of
-	# a Git command to continue. This test_must_fail is necessary for
-	# now until the interface for relative_url() allows for reporting
-	# an error instead of die()ing.
+	cat >err.expect <<-\EOF &&
+	error: cannot strip one component off url '\''<uri>'\''
+	error: bad line: '\''bundle.three.uri=../../bundle.bdl'\''
+	EOF
+
 	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
-	test_grep "fatal: cannot strip one component off url" err
+	test_cmp err.expect err &&
+	test_cmp_config_output expect actual
 '
 
 test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty key or value' '
-- 
2.54.0 (Apple Git-157)

