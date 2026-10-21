Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551840;
	b=koCdg7bsRZ40yH21F7hXYItEQFher1UGrbVCHUCgpjQb7EquQcwBrD7e0Cfk9N/3+gTF
	 IKQytr8zPrQn02RK6Dh59xTZdAjmHvSrSg7k3izuKUR0Mm9zLytO9ZEeMahLQ8LVO37lj
	 h0aBbXV2XEj2BMk3MsnEemmJxQ4Hn3j5W3aak4fFVYUrfkTHvn17ohRYKCR0TXOqq0zIL
	 XMpsBlFPDK9xbMpwS/oh9XB2zS5cC2sTeWUgc/G51dI0y02sdCGqougTERDBhgHUXRCpY
	 jNyjq63QucKaL6L1lMuq2cCo74xwGLZrGOWZ7n700to6eX956YRe6tNyzJI2Fydk4DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=iTcpw+HC3xn+6p/EnTNEp+cl3M1KaV8AMpnc2OAmq64=;
	b=YQzfAM/1/iBNsjRoXyH3XLzMWjKLaHPBeJx8rG8N3+DZiIbPd8x6IBnk38o8vydAdh9i
	 PuRjTykSzV6teWHxxjZJa394eCyG7hZz14AQiwUF+a0VvXYz/GDS4oAIISb0GaON/ax59
	 CetXMMLPTB/UdL3H3FsjG4zro3w++2UMEOqIKWGTeK2NV4jbDsycAiNPeQ3TOlqkz6sMG
	 nnqPJZd67ldQTfw+9mbfMfzvrpxt0guGwYWyHr1fDUDBDo3nfQqWAbt7tPCajpuwVAqjJ
	 UPjkndX3zZf/M8BSNTK5yo3jY5qqRGqLUTmgrzkTKqGIuBTPnNXCN4Dz4Xh3jPgeBJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nortesoftware.dev;
	spf=pass smtp.mailfrom=nortesoftware.dev;
	dkim=pass header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=OvCc3ETh;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260C606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1260C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=OvCc3ETh
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-844a8bf7e25so215663a34.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 20:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nortesoftware.dev; s=google; t=1792551839; x=1793156639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iTcpw+HC3xn+6p/EnTNEp+cl3M1KaV8AMpnc2OAmq64=;
        b=OvCc3ETht5cwjvJ/zfSuhWS0Vho9q3JMcCLIU8OF7RlD0D17Vo9A8ZeX7nXaugrFVR
         JBduRrJrMmqU+H/VmROLCpiJBik6VKvE38Y+g7dqdur3btzsT8Kib3o+JysLax6DIQbI
         zcL5GVdWeH2hYBZ1AlUl+YRnbge7thHpF0DNkqHH/IfUm1dKrNXrZ4XcAgWUrudNMsMe
         D+ES7+66QamOLPCWKTk+ZMGM2VzO1QzPQ9r+dO2z0iWQkT0xrXbC5ZBz+y3biv9WkrfD
         lT4K0JM5U8lAOQiEZlUMrOn5r9O018UMsMsIf7PjY1OUa1ITJrgzXdO2mrznpZ9mPFuV
         4aJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792551839; x=1793156639;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iTcpw+HC3xn+6p/EnTNEp+cl3M1KaV8AMpnc2OAmq64=;
        b=dMupxX3A6m0odV1SAiMhe3EUQ+aqF/yK6o7DHBomkgCpS7G5BGWmH1F/DUZz7Rnbph
         a4LNyc8Cpk2WKtMU5gjJjkdEVQxk2uYl6AHnGvXwZs55Yk9nH0xinm5lrg2zYNHW62yj
         6stGzVqUloPTn10ILXeFK4ddqzpQnnB3lcjEDeNMfk8E9hUHTdAq3Rr6cbx+1yB6/B1b
         WC3uj79yLNUQ+4e7g0IgfVc3vFHyQE9mbk8u+VCCE+DfbQ33AApjhqoFcpdZ5bJxZP0l
         RoE6CXc6GpIasG+6Ja6Q0854vbAa2MHICMaQcMkUmz3I0FTbdawj3j3sIu3oxYd8m7bs
         6uIg==
X-Gm-Message-State: AFq9FYLTgajivsrmJVQUm+b2NLbVJTRvfeE1C5ePVsoq53YO7muC9Wup
	rHrgtq6YjsffybiXTGHsdSNj0/BUvnL3uGRW6MFNH2RhnSS33+OGZ7NrAWK6RLI0Ji8RcxH2vkx
	YE98iZQ==
X-Gm-Gg: AYBFou2aLxGVvGMi5M7HdipjaaoXKTVT6Zl2wDVU7cr+Ati7mqGLbQvqKQle6sjvYt1
	k6XMYPgfKWcS8K2NdNR4PWwH+5H8WRONiDy3oPlSQw88K5YA8IN1AtyJ5OJ2oqpes/ysr+rYZ4u
	IK0sHf7kyzu6vD1xEGRkAhEX/8DXsiabegF5L4l68YYu03aczbtOsWafZwYXSgU0WddDZr/JaBj
	uczzKN3byoBAzkxDxRjS+B7MSJ1UVmdSITPb1641wcSLXhQXcaknR4Cbo4QXLUai3EYDuEbNwVp
	4nS3yV70qXBE+HIcRtcoXFTP0jD30LAYQoj+vAUzk6yE5g7mUyGQ8Ba4EpY/MrZzt+52z4nUfAk
	WXWfC2IpyLXMUaMs6jHzKS+uaEPoqkB1S0OR5WFyOabCO8KAez4Ev8ECvSdmHRhaYC8IOG6oGdb
	2nD1c4GscmGBCMi0FVGFfIgpwNXGZaGBmBcEVmSx9T27PklbOnDEbPlDBFO+4U9iattNaOLd1Vf
	t5DJtsujaP6qgUSj0tuy5r44fg+zcfM0STNbCRS1eNvTcU1AjQRl95DGXBzYQgq1fAP6Ll7EcYK
	IzOgrNflwHDM0LunW6CUKyKRZBb4c9UHQ9Bjkkp2fD0jsyD8J8SDxJcP+dXV9a9c
X-Received: by 2002:a05:6830:438e:b0:822:b35a:a2d3 with SMTP id 46e09a7af769-84d085019dfmr433292a34.9.1792551838883;
        Tue, 20 Oct 2026 20:03:58 -0700 (PDT)
Received: from debian.localdomain ([189.150.78.131])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbc7d9afcsm1176819a34.6.2026.10.20.20.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 20:03:58 -0700 (PDT)
From: =?UTF-8?q?Christian=20No=C3=A9=20Ramos=20L=C3=B3pez?= <chris@nortesoftware.dev>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] doc: gpg: say which date SSH key lifetimes are checked against
Date: Tue, 20 Oct 2026 23:03:47 -0400
Message-ID: <20261021030347.565306-1-chris@nortesoftware.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
References: <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The description of gpg.ssh.allowedSignersFile says that Git marks a
signature as valid if the signing key was valid at the time of the
signature's creation. An SSH signature does not record when it was
made, though. When verifying a commit or a tag, Git passes the
committer or tagger date to ssh-keygen with -Overify-time, so the
valid-after and valid-before options of a key are checked against a
date that whoever creates the commit or tag can set to any value.

Say which date is used, and that it is not evidence of when the
signature was made. The same holds for the creation time in a GPG
signature, which comes from the signer's clock, so say that too.
Since whoever holds the key chooses the date, also say that a key
lifetime is only safe as long as the key has never leaked.

While at it, fix the spelling of "OpenSSH" in the same paragraph.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Christian Noé Ramos López <chris@nortesoftware.dev>
---
 Documentation/config/gpg.adoc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/gpg.adoc b/Documentation/config/gpg.adoc
index 240e46c05..714dd1457 100644
--- a/Documentation/config/gpg.adoc
+++ b/Documentation/config/gpg.adoc
@@ -70,10 +70,15 @@ A repository that only allows signed commits can store the file
 in the repository itself using a path relative to the top-level of the working tree.
 This way only committers with an already valid key can add or change keys in the keyring.
 +
-Since OpensSSH 8.8 this file allows specifying a key lifetime using valid-after &
-valid-before options. Git will mark signatures as valid if the signing key was
-valid at the time of the signature's creation. This allows users to change a
-signing key without invalidating all previously made signatures.
+Since OpenSSH 8.8 this file allows specifying a key lifetime using valid-after &
+valid-before options. When verifying a commit or a tag, Git checks that lifetime
+against the committer or tagger date recorded in the commit or tag. This allows
+users to change a signing key without invalidating all previously made
+signatures. That date is chosen by whoever creates the commit or tag, so it is
+not evidence of when the signature was made; the same is true of the creation
+time in a GPG signature, which is set by the signer's clock. Relying on a key
+lifetime is therefore only safe as long as the signing key has never leaked;
+once it has, valid-after and valid-before guarantee nothing.
 +
 Using a SSH CA key with the cert-authority option
 (see ssh-keygen(1) "CERTIFICATES") is also valid.

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
2.47.3

