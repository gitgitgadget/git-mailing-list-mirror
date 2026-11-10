Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296220;
	b=geUDUFsHWe6NItpWg8Ci7G6dBXc7HNfZMfMMKtbsB/T+aBXbe3cn0y3Phxv8+sQ8BJ7t
	 zU4OzBc6MPAoZVsbn5MO7UOYpmdCMCCg8MzaJDGjwuG4jmgzIUWYs2Ge2H+PfJ0cZNJF6
	 bzZqpDC6xfA15kQZWwgHoe/jjfdWckeqMviLoLrrB+lSAgfbBbwCCFePqOgoAJ5yowqYm
	 WHH0merj6IHbHd+9UFDHVp9so+rD7H6aJRTo0f+0NbCJaZE8mNHdPiejWCn6iANIGb3tX
	 d+2EV1FWsMmjAaDAvtrFqZMZB5xTWhfKaGBbSK565YZwe4RWwNO+cwnMRIJAuICa7DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=m0Xr69B/iQVskyJ6WaerEsmZtuj077VzZadWU8Cq9gc=;
	b=QONw3CRa9OkRhOhffltJ275T0YMTxaWS9FgS/H/qKllH0zHRaSKvMU4uoFOxJHqp/b5y
	 Y7XPtd5kHs5g+50gAmbv434qalOd5YcQIFHLewt08WGMMIlXbIzSr6ZKogOUP7PrHgDrL
	 6MAqPH2LPgvwkTDp4mNkATYsdu+4Y7erjndO1g7hgoH7kaVEzgk3FuMLtcVPKjBNrNqIb
	 2Ij20aQvcVI9S2Z4Z58uiUmZ4Z/ZbPPHS+jNw6lNlI+YWmAQTkkO//Y9OmconE47yei0q
	 HBOvlgLDOpuBmofmIXl6N9NaXGUrDJ1jBPUwdUy7Qmry7rVJsDRAguhBiE3M6DZD+Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RSrFUMxC;
	arc=none smtp.remote-ip=209.85.160.46
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E8606A337
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E2E8606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RSrFUMxC
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4ad89c49e0dso536953fac.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296219; x=1794901019; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m0Xr69B/iQVskyJ6WaerEsmZtuj077VzZadWU8Cq9gc=;
        b=RSrFUMxCFj/ubjC0EnqJQYuv+nvhKzfPx652cbaor/3TO/HYvnq9hbjMLtdWjYDLjO
         PeLe3ZJjDqY+OoHiuc5PyOJqGBR0I1hB3fpCftjVKIYW91Vcz8+altALdxqApOQHrUpc
         qYxB/C2e9r1BOrDmshpKmt0rUHpm0YbggiMoH7Qsl+gCMY2NqKYsxxY6UyGGKC4GWB29
         s00ZiUnFMD5hL3tJQSNMfodUisIC92VLGY1JaZnpg683KHOIf5N20KM/eKOX1FtKf0fi
         uX8eEHX/NMlt+6Is2WT6SEXkTJmgVUXenLA5+UjtCM7UKDlxgWAnWT/Q/ylWytkTVPql
         eLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296219; x=1794901019;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0Xr69B/iQVskyJ6WaerEsmZtuj077VzZadWU8Cq9gc=;
        b=1KjHkuvtOVRuAw7caO9tIAMrre6J57Yf7RCB2ywZUwLrUf93FQiBUlb1nDpikurxl7
         x5itIaICT8YIcgg/dcvX8qRsmIsCR8ozDyu7vMovRTeqCWPMwI+rK1u440K+ENmXI58a
         E9UEZdSTBa0GTqBKxe3Lvd5DWbI6r3QXGNcYgDlOQIgtQoGRQ8si/scbWi3kHngAzx2S
         Q+t9y++SgHmRyr4EWq78sagcl63IDFmmifKJ62+4/RzYzJC2AJjSwdGoj3uDxnSy0dHz
         2l5zxo9I7OpN51o78Iyh8KXAUOjOkhc6D1VogEzrQ771W37rgX4E3bOvJXDBxdFHcNfj
         Nthw==
X-Gm-Message-State: APuU4Z/KA60djNlsSYvkFhx9b8MTEzUiXQwWVbnmLszxL2OuODiLnh0t
	Rqr6ivmFLrQ0UsYgSMQjEpDbUzcazrlUvBE9lJbG54P13VKcjWu2GzZ8Q5bQ+bzk
X-Gm-Gg: AYBFou3gdW350bQpG2cWCNaeRYk5F6y/QExjpjVYKPR9IIp8MphsqPLza0WyUfBPsDO
	KHPCMNHjoIij0Lwa/3uKlytDECqcQ+Fm9cEowC4IyTXlQ3A42Ob5xNJO7zctahA5Enj//lKYwTA
	Dzbra/xXUUo4RtP4R+K0A+eoZe3BEyGo2Ihx1e8+DPpLfTrEzReRd8jGipuKu0vr0qilxp9gJgH
	wuUxQm/x1rEFD+3w43SNZsYSahLKUoN8d742EQ3032Aui65qTGLinhl6c5JqzWJpC3FFtp340SI
	UcsN0pgrM2iACNt4n+LQd+59ig7ltByBosFF1Bjj2Ftu90orcZmsHVpGt2Z6Qedl8FizTmNtqof
	9msVfsdKeiizJORUgmPDieli4FzpDYNOu74MxcPkXfXLPIuknxdBX1k7f6Z/JTWa0lwiYVBEwP8
	0p5Q2CifWd12AnPUMp94/ViRgmVIQdUixJ967U6+E6dFoq6crk3Y1SfcPCCMjDENTDkCg6O8wfg
	rZ9mJ6PjaDIeThigw851dqA9j6WGFy1eOne/l0af44Pf6lyW/DXAjtV7mUiz5EIU03QbE+gG4kO
	KjQzWtJLIJhUzlmnfbWrRx8zxXRrqPysr6o=
X-Received: by 2002:a05:6871:c91b:b0:457:4470:96e2 with SMTP id 586e51a60fabf-4ae226feea1mr992426fac.12.1794296219398;
        Mon, 09 Nov 2026 23:36:59 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae2302d8a0sm1014665fac.12.2026.11.09.23.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:36:58 -0800 (PST)
Message-Id: <a822cbb84431c3bd5e093ec7d94dfdd6b17b1f96.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:34 +0000
Subject: [PATCH v2 04/15] bundle-uri: handle NULL value for
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

