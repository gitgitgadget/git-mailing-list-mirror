Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513570;
	b=gJdhkP/mNxPb+HCcW1WlutLJnvlhjowldkuBYdmjTf1YLQdwGag/bFZw2/l0KjlizjBk
	 QW+4dTZrUVGVuCG1LbahQ+3TByDHNRYrqY7SYTTjtPS2k1jNVbkFwcTDCSc6CnUeYvSpF
	 BXtQMn36mJOaCy0RvRdMGg6SpuHzl5D64kkY6Vj5bIUdNgyRQzGMHUCCIKn5BhcegC79u
	 XT9t38gaGbUIQwbGIZnrneLUDwztQwoGr0li0zgfGoHyxhP9MyAh1BfzkvHkDLuJZGH1l
	 GuqVUMiNoDU7QX+eJHvjfppeKKIfJEpxyC1vFnpYz5i0xK8Ha3YY0MYHZNeZfcArTAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O8+icq7/IFXYw66HlMhf1CetesEXfMPHBgAByUPTmQY=;
	b=Njzk0zoE98qeLGy0NucjTz1RSASSrtK81kScuImooDmNQ3z/V+2Gu1cpirWwNXfW+xMe
	 ZXJ1SpArB3KjJlObZIWE5Zh6qPugdV/wpT93xuNPzgmtUalzxZH8e7jmC/NzKFP7G+4x7
	 08mEGgdbnMgyRqh0yVLpFqvtx1rctRsSOzYV3ks52GT/nYfmws+9aj8t19vfuA44RFvkH
	 YyeRX9+1czxLYVN7g8R8byE9qg5/HsztEQ5ngfDun4Np8L9+UJSb+6BYfl14kWJig/b6A
	 50S2JVJp2FnLEbNaXWbswsBT9UuzTVRs5f7JxttzS7R5RdJhkzv+gaMKVyEPJCGPGWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kl4X00J2;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B59606A88D
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26B59606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kl4X00J2
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-37600b0db49so1158959eec.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 11:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513569; x=1795118369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O8+icq7/IFXYw66HlMhf1CetesEXfMPHBgAByUPTmQY=;
        b=kl4X00J2tAC5ZrHIT2NJh4WvNwcSZGyabJGxHulvYIQ6AFIXsPv3RlhnULWAByRo+T
         8GK7+/0l6BGcp6ru2yyjrLGnLLjgCpLrYRbZopA32pzZy1v0FQdcOMGzqJ/LL1snvBYV
         gfSSAFTtwWcESC0rzLwfdLXKPXiR+kp4ZrqI6OzVuA+MwuFuOnPcgv+LEFv4O4inqSzB
         1IZiOWCwEhmIWi0Bh/461Kaj6/O5RajlcXH/ommc6FgK5uKBVEJIUqNSlpw6RHQLkPP2
         PqxF0EhPvYMhI/Ms2Ml1N3pFXQvuOhWTw0jIKee9SvUTiy+DIlYJC7gX2NSsu30I1JRk
         9KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513569; x=1795118369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O8+icq7/IFXYw66HlMhf1CetesEXfMPHBgAByUPTmQY=;
        b=fmzAIYlDseFLANcn2/czpqaXpHXtDu9C3gI4zJ+CfJpZARYiedyf3/sSFI1MGM+Q6Q
         n8K2wAVAFxb2ckrXQByUbvkBTBCp8jkHu9jtapSZg0wG2AHmk5qsNC/s/k+1tuqx3BME
         NGSUx7WKjiIB9kjcaPu1Mi4YgcQI+BgCJdZ2FBYxXf/Nrg0YXeVSsc3bC3SWminAU6yi
         rDjC1qOPlx/6W9xKlB0IgHAIpeVZ4fM5LUy/Z40uWIhWj7BcwiMYkRBgeAkI5QPenJs4
         Hsm17vjH1MUMrTUSX6O0teL7RGGeSiEgAikVRyyGyGZeBFwLrmDQg1alp+5qwkbJ7cmv
         jhTA==
X-Gm-Message-State: APuU4Z900JTp1hUi8fbQakonjvmfDTbHJfUJSowgvGaBnzko8+5zPfhu
	VgwCOlgNy35fSPDFmkXOJCTHZKFrJZkaFN3DE+tRKQHuhde4AybiyUp+SbETpUYC
X-Gm-Gg: AYBFou1Z/QCTfYx44gofLz8VuxPZzDvCAz88H5q3WXIYUyVRWSvGkFDEesiBNcu4HZN
	WHdDgWC/xpNA7T6HQEpqQ7uyXtr4xtvHzSvoSfy/sB7t+tDbwzot6MJRiVpdOE/NeOM3iWoyflu
	+leJFia3oTbUGMz02iZhtVEHtVlweuKBh9NAiulLw5u0ffCS5kpfks08EuhyYfQ1KolnOFEHNwS
	MFYOEs1QFoTvgvwqwN0BjFSJIuGi3wtdof1JmXF4ZMwiwCE4jdqNnK6rkmKUVVluFkwFPZZ1x4o
	o1PplYqdaxJSeQ/iGV6vM8XnLIoOlh/zK7ezY8F3EFIfXPClEGWqNNXSf26LDjTYoM+v/7Yvu5/
	FNPl5b5p9GE0aaxyec0bvKP7CJz8bT1nAAOLG2p21MseLsG14yCvXWndAi5OdjXn3UjvhgG2ndE
	GjUEpaJqWGRB1sXwoOlhvgU9DK2RPkSeM4Yedo6El37/w+D0hi/ejXe5/FjFiBeJc/5EsYDXCu8
	BPvUenoSR3lH6jL5I0rhIIm2XsqkZ6ge9u6AoZJmWyLmAc7l0fV0tZQ49qGPxxOwz+E1TeqdozE
	I8L+XLq7eu3AKTH7UQ9JSL34qkgL2klU7mb9rniTCWygS377Tb/CUCMlbSamN0qBotiKlpMDTCo
	sobgK19PEDDr0jNkYiclCda1Hn8E41xxFMg4gVlbQvVxDKSILBSllvR1NqUOcP66G60YPbmGs5v
	3RY+6HwqlF/cCnzrGmPzGBUa8Q26dSj4nc9ughTQCpgufBWHIVakK6cH6x9ocswAGp9IWzyxU/K
	DsnFUw=
X-Received: by 2002:a05:7300:aca4:b0:358:c5c9:2661 with SMTP id 5a478bee46e88-3796676acd5mr224873eec.10.1794513569266;
        Thu, 12 Nov 2026 11:59:29 -0800 (PST)
Received: from christian--20230123--2G7D3.nvidia.com ([216.228.127.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316fdsm640395eec.5.2026.11.12.11.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:59:28 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/3] doc: gitprotocol-v2: send the promisor-remote reply with fetch
Date: Thu, 12 Nov 2026 20:59:02 +0100
Message-ID: <20261112195858.53788-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.471.g1891de46f7.dirty
In-Reply-To: <20261112195858.53788-5-christian.couder@gmail.com>
References: <20261112195858.53788-5-christian.couder@gmail.com>
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

Until a previous commit, a client sent its `promisor-remote=...` reply
only with the `ls-refs` and `bundle-uri` protocol commands.

Let's clearly document that the client should send that reply with the
`fetch` command request too.

Reported-by: Matt Cote <mcote@nvidia.com>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/gitprotocol-v2.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index dd52fd8110..b8732173cd 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -879,6 +879,12 @@ In this case, or if the client doesn't want to use any promisor remote
 the server advertised, the client shouldn't advertise the
 "promisor-remote" capability at all in its reply.
 
+As protocol v2 is stateless (see the "Capabilities" section above),
+the client should send this reply with the `fetch` command request,
+even if it has already sent it with an earlier command request, like
+`ls-refs`. Note that when only some object IDs are fetched, the client
+might not send any `ls-refs` command request at all.
+
 On the server side, the "promisor.advertise" and "promisor.sendFields"
 configuration options can be used to control what it advertises. On
 the client side, the "promisor.acceptFromServer" and
-- 
2.56.0

