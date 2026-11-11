Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437365;
	b=upMEH3sa9363JS9udg4Na0zRrlCkaEuKEsKLwH9TZDnShDY8NMTkJUoQn5z6gHlUtKq9
	 njya6n5pxdvsLcDjaLzGJNxuoEHnG2Vw+52S622eMCAdTwpugnzdUf/+BUWDbTnljO1Bt
	 VhBFH82oXsmO04eCN7MbB6paLH5F3trYbAcLpnlNL58bNeuwjnPpHhVGk8y/t2bgP5O0V
	 TjwB49RSai6fWpNA26qLRCFp84+1+CoVZyvp9cSUafC9foE+laGDqC+oH4JVOyyt5l+Ed
	 ZVZPKT9xFCXtZk8MmyYJQ8EdOH2R7PTP9pVPEEO17u+xtZkrT+WPTklSLU1cBwSOn8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=m0Xr69B/iQVskyJ6WaerEsmZtuj077VzZadWU8Cq9gc=;
	b=TdSLQRc97ldkbPrzy+ZriaHFHwzpGIQAOzl95Lz89ovTF6ZK9TG9MQ938pFiGi7FY7ag
	 vdNWQnlrx9daXGrYr3eflulU05vyYeTsmthAY/baAWau/ICqHLfdcOkI2VQKh96eWKyv5
	 Yw70ZUfSY6ytt2LHP3IXDTUhAoXuo2vYQoxfusXoZySIhhIlaa+5JIstHbrnQPjFFQWBc
	 gYMRR/RP5EVekThWNYPfyj5/v2hxZBxd7zhiVr4twqB8vC+mp7ilEBKqvWHEmcOVUCZNx
	 ePlMvSLEeszkzCx8K+E9oTfBdTBuHUwnbkrNTW6ezoUe/NWkQQXxY3Ktf/lOpp6n1Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+U8l2Mg;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79408606B005
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79408606B005
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z+U8l2Mg
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-85c1135c286so2480945a34.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437364; x=1795042164; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m0Xr69B/iQVskyJ6WaerEsmZtuj077VzZadWU8Cq9gc=;
        b=Z+U8l2MgWIc2EL/reokmHjlXmKtsP+hk1U5n7Wn4/F8yHnVA0VKhEA/DESC7SDUXs6
         LSRdPTm+M/1eJEzbkELgSHRM4vK5uKA7usNT/o9fZocyJZxsd9roycOABtMyTL3nUJbJ
         fYSmtWj+wJ/N+Rt1JtMf95heA9DNybNJ+1F3NrGt075GeCNbYw+hxcEA9XCpnKxhZvdG
         HKzSa+QMv+4uNI+4qmhp3Ke3e7y8dGOKBLMRn0UORrPdt4NMT9LXpbfpYrtbcD6npA4s
         1WV3KEt6u+iHzk26on1dIO9fKSHI807C4madLF+MFrK6zAHzLkFZiVqkg7qmBspM4r1j
         oOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437364; x=1795042164;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0Xr69B/iQVskyJ6WaerEsmZtuj077VzZadWU8Cq9gc=;
        b=tola1VBHvfUbfp301N715Bhed6m2NqglN7iGqtlPPQ59Vtqj0aBO/6LpTBSC8yVNYo
         PQ9lPxku81uDGtmMbSFzGWM0wXJ5gMgjhE8wvO+ZRqgl74EF9BxXI/a2PtzPJlqEFSYV
         N6iAVRpCZNoGLG9MtHiAZ0CGc6giqdneeZNqa6Z0SZ5WP1cMJKYok0rLuQhJexW+ZBeR
         zuBChq5E4Uy/CqB3VYlKRs64dZaLQK6SDE8FXTVI5zOdjJ2Xkh7D8iD6HEqyHGab18rS
         8kD1QYWBlym/v1860MITXpPpuH7NPPdONwJj7FT49Wmn1088TlZaDbfF9dC1KZZc3uax
         fBdA==
X-Gm-Message-State: APuU4Z81DXLuTBjjRMZyea+Wv3/W/USzwo/DalClXSyEb9+BICfiaoYN
	p19zLYXFfInrn/7Sr6RlxTZ8Bht4WPyCOR4S37/Cf/u/PWmgEtOmlPkOu4mAtsrr
X-Gm-Gg: AYBFou0nlQQh11ajFpVkLx12mplsB1diC7H1WRKl9vT/9BLFoGA7sH10mhVpOln0klx
	pra9hJj3fG0m0Vhu2KFbYFQiTaTKd7sC6oZNv6BRYseUrD869RdOCRm7qul4uYEOvie2vSb5j6F
	p2tse7DvHPnXaiDA4pXpZByeoUOVBpqK2vAsC2kQz2MA2IfU1Fh7NXHbN4bVJV0awDZPgwlkK0P
	DQIeY1xWMR8RqsU2VzQY4RTAirOxXFKaOCESqP/fFiO6WcZb2f169/d+qYGVZbnX3hM5uf27GV2
	qXR9WnK4I8eiWPamDRTK+512SWjNb8o2j/mySMZezUx4DMg7rC9m10c7m1Cs1h1sOKvVlSumLLG
	uMZpYNaWqKxn6rQ7IBISQgAKWTRITNX+97361PWpv15DymUSCfUyjO/yUaezJphuxGH0eg5ZCnO
	UI19h/iUm2jKs01KNjsvkcm5UawE6PIYM/CcWODm6zk/Dc9lS2LPBynHIlwRzoHdEOjMkNMu4nd
	wc2NUpBAtQS7RCfSzy3JAZ/okIF19iznaRFCh7HaUz4oiWBpDiiNO2nlWGIqrRFNIhLQqChbcrk
	JnGM0T9k7rQm8zqy1x+ResUOBIpnLP019C8=
X-Received: by 2002:a05:6830:6511:b0:82f:5733:ffbd with SMTP id 46e09a7af769-860f262c48amr3836101a34.1.1794437364458;
        Wed, 11 Nov 2026 14:49:24 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb5f7f7sm5297964a34.5.2026.11.11.14.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:23 -0800 (PST)
Message-Id: <8773aaef0b80125a2d7b50110c8da7b02362090f.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:04 +0000
Subject: [PATCH v3 04/15] bundle-uri: handle NULL value for
 fetch.bundleCreationToken
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

A fetch.bundleCreationToken without a value makes "git fetch" and
"git clone --bundle-uri" segfault when the bundle list uses the
creationToken heuristic: fetch_bundles_by_token() passes the NULL
value to sscanf().

The function already treats a token that does not parse as 0, as if
no bundles had been fetched before, so it downloads them and then
stores the new token. Treat a missing value the same way.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 bundle-uri.c                |  3 ++-
 t/t5558-clone-bundle-uri.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 9797eaed9a..67a717e857 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -572,7 +572,8 @@ static int fetch_bundles_by_token(struct repository *r,
 	if (!repo_config_get_value(r,
 				   "fetch.bundlecreationtoken",
 				   &creationTokenStr)) {
-		if (sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) != 1)
+		if (!creationTokenStr ||
+		    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) != 1)
 			maxCreationToken = 0;
 		if (bundles.items[0]->creationToken <= maxCreationToken) {
 			free(bundles.items);
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index f81f1f8db7..e86ed7d30c 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -346,6 +346,26 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 	test_grep ! "refs/bundles/heads/" refs
 '
 
+test_expect_success 'fetch treats fetch.bundleCreationToken without a value as 0' '
+	test_when_finished "rm -rf token-without-value" &&
+	cat >bundle-list <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = file://$(pwd)/clone-from/bundle-1.bundle
+		creationToken = 1
+	EOF
+
+	git clone --no-local clone-from token-without-value &&
+	git -C token-without-value \
+		-c fetch.bundleURI="file://$(pwd)/bundle-list" \
+		-c fetch.bundleCreationToken fetch origin &&
+	test_cmp_config -C token-without-value 1 fetch.bundlecreationtoken
+'
+
 test_expect_success 'negotiation: bundle with part of wanted commits' '
 	test_when_finished "rm -f trace*.txt" &&
 	GIT_TRACE_PACKET="$(pwd)/trace-packet.txt" \
-- 
gitgitgadget

