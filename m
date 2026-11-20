Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193320;
	b=C5Yi8zl6eO6craYrmQaO069o5yy3zTqxeWNLzartePtILhIp7JMPj9eIvi5OA6B5//o+
	 WK1rxQuTBqexFe7vxOUR9Rtnw2WdZK81TtgwMGDhQajer/eUugtuwOJpJIQyb/yGtv9lm
	 4NX5CkMRFrKr/1ef0W6e/Q14FOnIBgZm4CZyM37VkkvGOsymb9qIH4WaQnOMbRypFjnRJ
	 8HFJsmoQu9RognIE2r8xPLoDSJQfXEOrqT+9afsiT0ZOr50snX23IQAiQwsLbDQ5kgtCo
	 iQ+8YbONnv8EqBY3Bt18L/ZyuUSwZIT1M90PCurzKesdr9tyk2ile89cRJvSuYy5hGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YM6QxTA1X0VRN5ygatxAdxIKvore7tBLTIvA0jnvPug=;
	b=5gERvmoVaAngxzFoVQHqc586Z+pRimu2q7FI8LomYUCBcmusn4ypismL6KZUAO8Tq+xq
	 j0RCaBBw/Az7C4Sq7T08D9ZxdqgO0sU/UnIir+nf09t30T7ExX0ZdSvWg/ejYL0o443ba
	 DYWKJWsRzCRtY3YNnqBrn/0dXCiQTIvciXoO8CWy2lM8zV/9n156awB2Mjj+bE36Ae4YY
	 JVp5INeUFRlBTHrhjPOo40nXqMq43uwQTATutSSZdBngnItZMACl7xnii/HyVIpH+Ary4
	 gbRDR98/hqeuJlF1o9r34T+6bfzqQImwfeUwTNyOJIKJI1RRgDkRVPTDUtW4P/Ndz9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPlYeNba;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1F606A33A
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8F1F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPlYeNba
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso769396f8f.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193318; x=1795798118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YM6QxTA1X0VRN5ygatxAdxIKvore7tBLTIvA0jnvPug=;
        b=ZPlYeNbalb4XRgd5IWUTBiJcuosXIb9PpJYjaqnKTIzCbhVun073/vyIGgB9gnQZeO
         MAW8xVp2HlY3C8vZoqjnUsfGr4T766yfOgJChu5714uHNLMUBGqY/8k9JI0Q8QQKKcsp
         skHe2qtUYKOLpFwvP19IQvMCIu2cNFQr6Qz840dyHlw1HYLbAyMmoWNygsNY2ahpKrDR
         nbwQ8/Wo7ynpOVqYHauEodfekDnzWP8x7AffBCJf7M3ZcBK7YA9Kq4ZOyQeFjwpz4pkO
         VUdnKz3WiSP1zeeJicjTLS1kgVJI3qPCnGoaWEeetCv3bsyglPoyYsqDNN8D/FNgoKGb
         f1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193318; x=1795798118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YM6QxTA1X0VRN5ygatxAdxIKvore7tBLTIvA0jnvPug=;
        b=IX89v+4PMCCF88U+unAbp6u0UaJX9VS+3rLjRvE9mPbaH6e8PtxO2VUyuzdqF+RWVh
         jGoycjcmQIwO5OpzOKLPVTv42RUTn7Y3F3BCzre9gHZxoseEdbo0MQBLCewz+2/HcOjJ
         y0RULN/gaoTVB0dLMM3tLW/dcrWxwjprgGcer6Yz+q2a0nehxEpd0jRH94VqDwWllmIc
         h+/XIeSdpCYGwhDpbhIK1mQ8rcXgh6nDgic5kmmC2Y4lYqGMxkRGgvLVIzygtDmjmdgp
         F0RvJcfm8EoeSFk2px9Is8DZJ83eYkYZ0WevuyuRgvQBLui/5CPz+gyJTYfBco8niSuE
         tVcw==
X-Gm-Message-State: APuU4Z9HdhV9hZZxAT/Um6gNZd1uHE8OLwffnB8XXflM8kK2jsCdIi23
	p/nFlpyFEXVs7Cfnc5Vd3e1QIhXyA0QvxYngwTqzE4JtgAMLm9yIuj446TTVQg==
X-Gm-Gg: AZFdTZfNdQJa8M/oD6V9Lxm+dV/HPmjZFEEJWMjdYrReqibsRAlPDdYa42FedZ+MNLt
	cttJOiNZc/j+hn3gg9wvzcnQUepDjvjlaeQ2cMf9ttKLREHELkoF/dQ2cTyaJgbKxqBuZbF8nTi
	FVYxW1pZaiyYhRJxJAcF6QJcye6MvDeocZ9fd6xISe5hQcZBVx0hrNJtZAR/j3p1xhnOT8M1piv
	H+TzT6567wMoKyZmatQZJ+ae/CH9NhCTqgIZpHB1W0itwahJZbCcrd7ckWsl6PKu6UXSqzXRJMj
	ox72rNdJInsU9WpX9hkRhRGHNn1I8tysNfW8QX9HdPPL9anEr6WFIAeovJGLyV3RV4qljntuR33
	LPGE/4pUjIeFJW1z3V5L3qfm8RYpfeznV+HN5bcIUaGk5lDFuji0YV0QW1YHhYAk1ptwHV7ekMC
	6y0wjUgq+Ey6v8IpDRICut3o+taZgc/1qTJKMUq4uf30ITyXORZPNoyExQkt10q8MqJcdAU/weH
	RE0dvDDXsQmibtv8XjJg82t7YrZ8tNoHMTbBIj7628W78RLhSQShMeFerxmFx+WdzcilWtGVRs3
	xIjdyZpaRVXWpTA2Lg0W+dF6xis13mtahDiZGG7M71h9JQvppXXTXalSDSierOZ2V7qJcgYg6ZZ
	EpRaXvxDf53ZA8igngae9L/U3gVeFaUcz7pKf0lJA2VbFhS1VgmnnPEMHmtjOWxTPvALR3bmuRf
	62FjWWjncMeEYEQ162apnlS96BsW2251zok4M5OT5jjwoUPeowfBySx+3XZeFK
X-Received: by 2002:a05:6000:4a0e:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-4abb7787c05mr8036332f8f.50.1795193318200;
        Fri, 20 Nov 2026 08:48:38 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm6232752f8f.22.2026.11.20.08.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:37 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 2/8] connect: send session-id with ls-refs and bundle-uri
Date: Fri, 20 Nov 2026 17:48:15 +0100
Message-ID: <20261120164812.707946-12-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.596.g78bef52d5b.dirty
In-Reply-To: <20261120164812.707946-10-christian.couder@gmail.com>
References: <20261112195858.53788-5-christian.couder@gmail.com>
 <20261120164812.707946-10-christian.couder@gmail.com>
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

1e905bbc00 (fetch-pack: advertise session ID in capabilities,
2020-11-11) only added session-id to fetch-pack and doesn't say why it
was left out elsewhere. According to our "gitprotocol-v2.adoc"
documentation, the goal of session IDs is to identify the process
across multiple requests, so there is no reason to not send it with
every request.

Let's then also send session-id in the `ls-refs` and `bundle-uri`
requests which go through send_capabilities().

Note that this only changes behavior when `transfer.advertiseSID` is
set, which is not the default.

Also note that over file:// and ssh:// one upload-pack process handles
both `ls-refs` and `fetch`, so the server now logs the client's
session-id twice per process, but this is harmless.

Let's add tests in t5705 to check that the server receives the
client's session-id when only `ls-refs` is sent (with `git ls-remote`)
and when only `bundle-uri` is sent (with `test-tool bundle-uri
ls-remote`), as the existing tests there only use `fetch`, which
already sent it.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 connect.c                             |  6 ++++++
 t/t5705-session-id-in-capabilities.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/connect.c b/connect.c
index 5f73fd9e7e..40cd279290 100644
--- a/connect.c
+++ b/connect.c
@@ -505,10 +505,16 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 {
 	const char *hash_name;
 	const char *promisor_remote_info;
+	int advertise_sid = 0;
+
+	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
 	if (server_supports_v2("agent"))
 		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
 
+	if (advertise_sid && server_supports_v2("session-id"))
+		packet_write_fmt(fd_out, "session-id=%s", trace2_session_id());
+
 	if (server_feature_v2("object-format", &hash_name)) {
 		int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo == GIT_HASH_UNKNOWN)
diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
index ef0db57d1f..9b35c62629 100755
--- a/t/t5705-session-id-in-capabilities.sh
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -84,4 +84,30 @@ do
 	'
 done
 
+test_expect_success 'session IDs advertised (ls-remote v2)' '
+	test_when_finished "rm -rf local tr2-server-events" &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	git -c protocol.version=2 -C local ls-remote \
+		--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
+		origin &&
+	test_grep \"key\":\"client-sid\" tr2-server-events
+'
+
+test_expect_success 'session IDs advertised (bundle-uri v2)' '
+	test_when_finished "rm -f trace tr2-events" &&
+	test_config -C "$REPO" uploadpack.advertiseBundleURIs true &&
+	test_config_global transfer.advertiseSID true &&
+	test_config_global transfer.bundleURI true &&
+
+	# Only the server logs "client-sid", so the client and the
+	# server can share the same trace2 event file.
+	GIT_TRACE_PACKET="$(pwd)/trace" GIT_TRACE2_EVENT="$(pwd)/tr2-events" \
+	test-tool bundle-uri ls-remote "file://$REPO" &&
+
+	# Only the "bundle-uri" command is sent
+	test_grep "> command=bundle-uri" trace &&
+	test_grep ! "> command=ls-refs" trace &&
+	test_grep \"key\":\"client-sid\" tr2-events
+'
+
 test_done
-- 
2.56.0

