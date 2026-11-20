Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193329;
	b=FDN3JuS9wFoHu+VPsscFROnU2p82kb1VzgEMu+Ic2myC3oKwtbexuoe42ig0T0gD/4G/
	 vMyWeDZBYHBeY+Q5kMG0z/ZIymAImLgcgUj1VDnhEA9AmSryeNfZJe7tLL99qkE9Q7jkA
	 BXps7JLrqkDXiEPdqRzXm2QJdjADsnIEh1YJpI1esZLE+t/+K+b3zxfPqQCm3mSagNoZm
	 0/FxhkOpo5PtleQtQWi558Gvf1MefbRsbFZoHJjFNhszyxLh1ImTbrTRDk9SaQLLZ8i4g
	 9LKQ04f30XsfuK7TEerXz030uoUzs100ikIXkboPXla2iID2FJ5eq0gzayLzVG78kgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WESkEHdhlpnd5+Vf5ubVIvYN5Pd2X5BnBRSHGQXNxeg=;
	b=FDCUy0Lf7Owt5265/9gRELbcgXLdaFO+LGOjFbecYQI5Uzii/EYIRwfAYw2W/QFEmWUM
	 pbpCoRSSFkKgI1nvtX8gzdHefWtGVpldMPD4ex+scgBmv0Ne06bfm44vYLaL+EQKHsEsU
	 WHHytMe0atZx54V8gV0OI9r5qLgjtrtLPXf64DtT2XDZbb0X3CC3icmsutxP+G6tkzkcW
	 yxGuNey/fVE4iLIg9NFidXxSu2dXD6weLQCXhtkB5e6sN9xWCzVYrmQVSoaeq/uud7pGU
	 izHHXqbiuTdocnNNUGSIDdoSYIIGl9KKRgNfwd+4wo5tcBTJhsifdoe3KyfFkzSwneA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jzI/2xfd";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540960A2609
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0540960A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jzI/2xfd
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-49412eb1474so668541f8f.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193326; x=1795798126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WESkEHdhlpnd5+Vf5ubVIvYN5Pd2X5BnBRSHGQXNxeg=;
        b=jzI/2xfdeCTg6dVCVTZUmA6o3KtwbV7MQd43F8IPzuDL3pF1AEE5jctuo+fFCz0y3J
         g1qkd97cQ78wxwZklY2n3eCkerITRyGNLmitc3W8VAtQCaWVv+ETZY94E4LBepLUC4cX
         QhgbW+qWPfZ0scs4cI2PH5w93XypUkLKUe2D2ObAeB0FM8zYqXPrmndfSo4McVAkiVnM
         9xVysfpc3xNoJCcUNGMt2KvC2uAulnmnws2SgRaGhgGbA0USZhOctdpcZI6V/rfMZaSQ
         DsPcKLaKjSAYGmld1ZM0tGxVSuXrG8tLgYRHPNL0pc4HpQNWpBTd6Tqgua/+eQn4Df3b
         BQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193326; x=1795798126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WESkEHdhlpnd5+Vf5ubVIvYN5Pd2X5BnBRSHGQXNxeg=;
        b=anLhge972jjP5b2waFvn0XylUwU9VPCzp91Q/UKKGBGRQbpmwMOZr/zv2+qLcl756/
         Qap/puuOcA6t8UYx8Nu2zG5rJNslEjjwtJpEl4ppEilbBRPNSMLocfsTZQ2aoyzu1oFP
         N0FpdoJIj88jfpyWQ9UoUwMCjUT0MXyndXTua0ppYt/f3LLXkz0VS+83WWwltWHnh7yT
         Fz9fL1mpe4GiOXhVnzeaL3QOpYgK9eflRJgJxZnG2XlIaEMLr/GhsLarqjhi3DFWfCoy
         IttW22vrOOZIbbk8SvG/8rQP/crR2SY08cnFIXPg7zfB/fcC1wfCEyJvjWGWI9hOT3Q9
         MJRA==
X-Gm-Message-State: APuU4Z//tjPmpEDKiFvOy469he48uY2iDuiaOuh21edUEt8YOAp/1h4i
	LcJwgaVVX+s0HV0dos9ehn1kEh/OuHbpa9EPuboSHSM/0aaaUZwfHtSYAEV3XA==
X-Gm-Gg: AZFdTZcXFrLnFHAtgMv7GD5t/7luVrU7YFpyKeoTYIO+v05+Rf3rj3IcqUqdGPx/JEb
	ztdLY/RLmSqsuTKiISneCLb6RyO6nW9YdBItPRfgT9fXPW5fQlew68gN8z8mQHdtuLF4EJ163mC
	4VDfq7Br9DT0s6Atquof9DjzQzF5KwGDWLfbuPCvJQXyBWP4PWxGBcZGQ+CpN5XIi+Gaaw57TBb
	fm7pLNzFbF0Gj0L8P6D35yuEtv2KCGGygjrRw140nQucw9onXCg2ElsA7DhJ31GJ5rE6WTQBF9X
	GQRUsGzf/LOx4Ogz/2lnzaWIlAorJ3E19Iy6M4SkHqiDKQHHu9PA9tfPbLtr1gt+EINjLWuYn3z
	e3qjMLGZiMxL/vIhGNWUKl6V/0ynqchK3CbbJmhoCHKGckFdonvFHXCUAck7IQOW1fGv/91ehJO
	iSKSyBxtDvksolRGAi6ypBZ9MQBLG3TnTv9h94TgR6op8DPvQJqUl/AI4Rzn71/U9AGyseElz4+
	8Lu9iJLCxLSi8xky//0/T8tmDjeMK+99v1EJYhHFQO/yy3my9DGAl5CsBE5zF+ndbphigewtuTD
	OuZs8I3A6n/VuuT3BvzAHIwW3WZ+8l9xyKhN99XTkRagakcjcoSic7DO6b5ZnJP+2mnNQt1RDqT
	MuStcbQCzmSKqDlgq23snTziBv5O1K/zM0spwjmUtuMMPDBvveClT09fjuRC7I3hNtmhKxaMMgT
	7SLxNu2uGmlT8n/InnMJlviEu3zpfthG8WDBuhvH4=
X-Received: by 2002:a05:6000:2310:b0:4a2:ee0f:4fa3 with SMTP id ffacd0b85a97d-4abad6a4224mr8787124f8f.8.1795193326269;
        Fri, 20 Nov 2026 08:48:46 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f281sm6232752f8f.22.2026.11.20.08.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:48:45 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matt Cote <mcote@nvidia.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 8/8] doc: gitprotocol-v2: send the promisor-remote reply with fetch
Date: Fri, 20 Nov 2026 17:48:21 +0100
Message-ID: <20261120164812.707946-18-christian.couder@gmail.com>
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

Until a previous commit, a client sent its `promisor-remote=...` reply
only with the `ls-refs` and `bundle-uri` protocol commands.

Let's clearly document that the client should send that reply with each
`fetch` command request asking for a pack too, as protocol v2 is
stateless.

The `fetch` requests sent only for negotiation, like with `git fetch
--negotiate-only`, don't ask for a pack, so they don't need that reply.

Reported-by: Matt Cote <mcote@nvidia.com>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/gitprotocol-v2.adoc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index dd52fd8110..d70d7ab19b 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -879,6 +879,13 @@ In this case, or if the client doesn't want to use any promisor remote
 the server advertised, the client shouldn't advertise the
 "promisor-remote" capability at all in its reply.
 
+As protocol v2 is stateless (see the "Capabilities" section above),
+the client should send this reply with each `fetch` command request
+asking for a pack, even if it has already sent it with an earlier
+command request, like `ls-refs` or `bundle-uri`. Note that when only
+some object IDs are fetched, the client might not send any `ls-refs`
+command request at all.
+
 On the server side, the "promisor.advertise" and "promisor.sendFields"
 configuration options can be used to control what it advertises. On
 the client side, the "promisor.acceptFromServer" and
-- 
2.56.0

