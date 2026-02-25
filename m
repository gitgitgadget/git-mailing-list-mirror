Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5902D249E
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050641; cv=none; b=X5yaraMxZVA+8OMMaABbpNE979jgFc3vtPKpPfLt9157Ni626KaddY3CrYBakie7kJNAjNGR/HR2niv3ro0+HN7tfRpJ2cDiyS1luh6q0TvWE8e5eSBkRyGkenNwhZBa7ZQ+WbV3X3hsCkpcyVBY+mxVIXpJfxq2FtgvguPNnb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050641; c=relaxed/simple;
	bh=kZCKYWKyg9DS8EoHsGaWFGh2Wl0poRQmQmTdw+w1+EA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Pu5c8YaXEtr5HjIOihrCJRb6xNXKIROQZ7dYbWUP5flqtGEnzK4gnlcTuI2YiVt6kvDF43Vt6NOGvWd8CXfH9uoXziPXKLx6hAqz8s9k9h3bH5e1rrkC0raOze+bdoK5a9dvYpRBB5rIcmMEry0GlQ4sgDEkIXI4McRYGJqyhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AStYxtOS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AStYxtOS"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506251815a3so68993451cf.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 12:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772050639; x=1772655439; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=AStYxtOSvBWtBe3DKAepLgHMgg/Yu77rF4l+BAafknBrpjXKKF6DCWNREzcsea/gVe
         K2BDyh4wiVw5UJ1l3mkW69NkmbnYclDqle5U1fY29+hTK7Ygp34wdxx+w/81PcDLAWwP
         OK97tMd0AlvOjJcSEgrvUUYiCSonjCU2/8ZTdnjsKsgl5MWEfpia1ni/nfGnHekc7vgh
         IsfEtFhG5gwfphXGtFP6fVB7IAj/TCNfbi2Mf9BDRZtsAVpBurVch/NJKXx0PGe7m2vB
         qf/b3BJXfIWkcqxRU/XO2BnJtHpzmgqW+eXBJYpu5Y9FNenWHpcRxIoR31E96qi2KJG7
         6lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050639; x=1772655439;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UmuwVlSNcYGN0z2yoU7zYYEc5mUkisvlkjXgXsRAv7A=;
        b=mBnWfAs8XHWJkKR1id3gJsOdfygwIiPqX8XPjnfoPU1JeYqtEoDsY2avAk29RJ64sV
         a7+WDETlmMOhZ9TOrc83VyGfyHrz9gewUu9DvCowYynvvM9Rjh+2t33RNCsWYbQR13N1
         Jr5Sem2PdWRXZ+jycX/Uj/27QKCN/Lazxq32dYUxfedo1wmijYvFOAP+xVelvBHN1HEj
         qxmAEfqJtYETvD9sICQOONIFkSsQVyTs8M3XpTtMYKvkp5KczP39AvAdBsSI2lK6ntkr
         aaLZOyW/19PL60jojssLnCRxxCcsdr6qxZmDXAVVKGIH/Upiy4Ag3CNdp+A/GPI06ov1
         EUQA==
X-Gm-Message-State: AOJu0Yydg31mIU1PjhmvdPQ6YC0YxGnRs1eIwf3yB8IfETi/n+ODcP8L
	Figcutt6HBQhtEPHavAJ4cj6Yo49idXN8EAS5VkocZiHMOV4G2ox4y70tiyuFA==
X-Gm-Gg: ATEYQzxS6PaLTsjcYcYzVbx2TcIcV7CpinpHrENrFjT+KHOF1qD+s/b8h2iOO+ZYQHh
	VQ5oSV86XlEbZqHQ5p/NeZhPFpaT9pYbmt1rbNPtgz2SZmCmgUXZ9Q5+1+JQ9yGZHoxwcDx326J
	Sa/V4nSaN02ADFxvAFWV9SU5cwvRDpjWTMIuhPX88Xy9iuXouVf6GBIFdT8f61Z8bSe3LbNdGxL
	TRCQpdaxWsiHxUG3TYZ6vyewgfPpZRB/vPun4Ug+cfKNBD2LEiqNcN/NypQdj3/FRtJCWpIx8qO
	kInPCUrmxZapKXdz0HTOkyRYwXoXXkKAMM1PiWAPzbjLBW2ZPBlWs5GUHoeGoErd3OMpp0S1fNv
	gtunPT8WjzSFoJjK3rH5oyEmrPlWnD4xUxxH3Aq4ebnWbVRkeOnhFkNcE8kzlXxztf0qSdBTz+B
	tJAJoNUesToO176UVGcMOvaK1kbA==
X-Received: by 2002:a05:622a:1b8b:b0:505:e4ea:ffa6 with SMTP id d75a77b69052e-5070bcb249dmr241237541cf.54.1772050638723;
        Wed, 25 Feb 2026 12:17:18 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899a71b28d0sm55543536d6.49.2026.02.25.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:17:18 -0800 (PST)
Message-Id: <4d4dec8fa161926e6f6ac822aff0db35353705eb.1772050636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 20:17:07 +0000
Subject: [PATCH v6 01/10] fsmonitor: fix khash memory leak in do_handle_client
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The `shown` kh_str_t was freed with kh_release_str() at a point in
the code only reachable in the non-trivial response path.  When the
client receives a trivial response, the code jumps to the `cleanup`
label, skipping the kh_release_str() call entirely and leaking the
hash table.

Fix this by initializing `shown` to NULL and moving the cleanup to the
`cleanup` label using kh_destroy_str(), which is safe to call on NULL.
This ensures the hash table is freed regardless of which code path is
taken.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 242c594646..bc4571938c 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -671,7 +671,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	const struct fsmonitor_batch *batch;
 	struct fsmonitor_batch *remainder = NULL;
 	intmax_t count = 0, duplicates = 0;
-	kh_str_t *shown;
+	kh_str_t *shown = NULL;
 	int hash_ret;
 	int do_trivial = 0;
 	int do_flush = 0;
@@ -909,8 +909,6 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 		total_response_len += payload.len;
 	}
 
-	kh_release_str(shown);
-
 	pthread_mutex_lock(&state->main_lock);
 
 	if (token_data->client_ref_count > 0)
@@ -954,6 +952,7 @@ static int do_handle_client(struct fsmonitor_daemon_state *state,
 	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
 
 cleanup:
+	kh_destroy_str(shown);
 	strbuf_release(&response_token);
 	strbuf_release(&requested_token_id);
 	strbuf_release(&payload);
-- 
gitgitgadget

