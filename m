Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2A3F20E3
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786144360; cv=none; b=UfN9u111IdemduC7tsWO3cnO5RMY38iTAU2oSVV604D5DtUKz3/06np2nfRYyXm8B7gBxPZTPzQrQP2N4cDUOx7ciXwb9Gs52ktWUXQvj67KvgElkHXKkh7TOn0SUyaVDC+pay7/YbuFNiUl6QcMxD3vwo0XlpHm36WJd1T1Smo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786144360; c=relaxed/simple;
	bh=/Glqs54phj6p39aMQ36ItJ1IUDIHYEqtJBW/mrvMU38=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=soUEWnkJhfPOA9Bd/WZ/auUN0bMnvAR3CrPmoe8coXDwV/8NO1+OCWmeHCZJRV1jPF7fJfN4s8rNKZ4D8sYy5v9o72VHwIbwDjNrDUaJEPP9AmpcIkaEXh+TB31Nhcesjw45xvicqvOI3AprY9P8oM8FmHOB5q4QK2mw85Zs7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImjfHgDe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImjfHgDe"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495437bb891so505645e9.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 16:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786144357; x=1786749157; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/Glqs54phj6p39aMQ36ItJ1IUDIHYEqtJBW/mrvMU38=;
        b=ImjfHgDeM2jiyzvCnn1R4Y4ysf64fURavhQjGzOkgqMkgHVs/mXIVFAnIg1WXipiRS
         qvtY2GMcvtn3Zy5U0pBuEadjAkz192J+vpm/H3Tg7/9HQIQCtay7CjHeiqM98lexOObg
         JBR4TJKvIgBtSQOEDs1QINmjMJyDgsBOGH6e0Yqw6/a/h+tBA7d05/yk54EDXuja07vm
         KKl/4sawHrZShQE+5dn03HUj4aiKu307K82NP+hj7ZVTaTN5ZrlyK5dj758IYJy/56sq
         fSAiVO+DrJ2No06FJ99n2z1vSBleDrmxAGD5ylQ8dhyzS6mkDH2f/OCGfliFeorCaePf
         ak9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786144357; x=1786749157;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Glqs54phj6p39aMQ36ItJ1IUDIHYEqtJBW/mrvMU38=;
        b=K3TsoyJWsr3xSRG5YfmghDVPd5mTzTALCDTaD4a/4MPBno2afxJKvBjp+JCgD94gmv
         Hs0Ssttn7nRRJOpvp+VQmqiz35rE8C9OE3XYiJTqPOdae1KymxnhtYZmwzTKDN7rOj9R
         IF0pdCDa0FAEescVqcNMpIKX4TQ+45VY7khFQSRMjK2YlBPV4ZVaf+uhP1RXz/oohCQF
         aOjcLJbgrEdjQTfpXcTwZB4A0PVnGXS//Gt8Xg7lrkD1oCldwSUkS/S0US/sf/UdDzYY
         FJhZWlaOmwclEdUQ4RjFoLOOj67npaNqZQdaSGO+0Pzdd4LTflKc+FUN7JH3ys0LMLa8
         b7Wg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4DGGhoITLKgPV0VZbuGNs6NXcW6BgqI++FOok5a0+WUx3DKdcRO/D1F4q6FqlTEs8wNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCP4pCY1e3pixJ9xSJsOBoY2e2IaJM2WN4YxGqnKtTX/0OlrIe
	AiIpGEKPzw6KQFG6U+T4jbK2w3tLzYrnJpxl6ZJHucSeb9wQ1h0IRW5E
X-Gm-Gg: AR+sD11ERZY7I+dSKnQmGF96Ji/Yygm1b+vYiXwHJq/2qMDjZIFU2wnW5RNe6fX56bH
	R7Xa2rnVWcX976VqIAWTMTi1uNPbq5nbc1KU1eEPWopCg4spZ2rXltRe/g3ULhNUzRBShm5Jp+5
	15u856cboUrKzphFmXuQxg5ieBL5sBip7XdVxIjoUTRa++XkvWAO7l/MUA5K17xxm5sKfEeKnQs
	ASaYCQBm+2PJ+/b93iyWhPrmzMqRmxDOOphFYiu1TMgKiBlFinFjWyAlhDEQfYc/GGw0BM15g16
	g2H0ulH1skaXRgQYzTp/lb0gSBGSTM/kTGPpBOwaVNiJc+NgsPV3reE618u5JdHeT9mcPlRdZdK
	+xNHIq6IuRXeCPzD8UzFRgOKxmdkVG0waOcOo3xYyYCdm92dN3Y3LFFQsTTIGzbKS68CEqVYydr
	rznw0fgLbFbjktihGMX7g0xK9sCWc+v3hFeCSy60/ZamoZ21RqZiyW9GRnXpy0XrV8mK3ooTuyo
	aiSjHbbpprFRb0BHb6p2PPjUjc68Q95aWmge68NlwmYJiyqES3aXEWCSGKFE9pnlKN67aO4xY0k
	ynVT16dRuh1Pe2/1TyNz07b3HwRUpF1E0oFjSMMOyszvZ/YBZJxXnsA2sLjMBvq9qw2ofX0FOO7
	nVVYJOPPDmoIDDX+sOaYE8YxCP0Rv5b4vMeqR46cdXGF3/luTcng=
X-Received: by 2002:a05:600c:230b:b0:493:e543:1dd9 with SMTP id 5b1f17b1804b1-499624b9b47mr16503395e9.9.1786144357131;
        Fri, 07 Aug 2026 16:12:37 -0700 (PDT)
Received: from localhost (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800215078asm9110059f8f.12.2026.08.07.16.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 16:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 08 Aug 2026 01:12:34 +0200
Message-Id: <DKJ3BWNUXGK0.H44F57AAI1U7@gmail.com>
Cc: <chandrapratap3519@gmail.com>, <karthik.188@gmail.com>,
 <gitster@pobox.com>, <peff@peff.net>
Subject: Re: [PATCH GSoC v5 00/10] cat-file: extend remote-object-info to
 support %(objecttype)
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
In-Reply-To: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>

I just realised I posted the wrong CI, and this v5 fails static analysis.

I=E2=80=99ll send v6 with the fix.

Apologies,
Pablo
