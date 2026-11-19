Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110538;
	b=WAANYwQhbPl2g4nESGV0pgNFJHl1HgV4eMJqiv89fZzMn/UILkjaffftTIqVQXy0PvPJ
	 we1WAPmf7eB8i6E7iqvdlwBoWIuWuZ7MKjgm48qIOFVCAv8qFaEeeOG/wtDZn2EdwYg5m
	 VKJaUy7SAHON6wTW9jlSJeEWBFibHMeYyL0gZN5HiwIZjyIJROvbZyS1FKlAnL4+NIgto
	 jP91Mj2lA9c7LTjrtPo/yG8ubKPP1GtDJ80DfHfXI1kcmHf5C1ogNyjrWUdUFrson1Xg0
	 0cQMDetyPqdzxij2xhT5vWdypWWSFXgYjSHqNLpsZS/KB6ACw8oL/Sm5E0DlKuxNVsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jwlg61NUOc4xs8l+sLUkgCxBzgtDSjPT6mOzXwoXKWE=;
	b=Zcd46AjQWe1CWnzZizw/gsoLUp+VBLftBkVxKS+2gK6wsk083P5q2nwpJ9jzubaCfgBX
	 meH5Vxx/4S/eT27Bk12uXX2DfFFqzmrqUmaQJ4ZM7MW/OLCyUmXSmbNonGBVnW3ZXGSEj
	 ofDedLKze8FonP1+cHfdb9iMhhpi2u8BMGrOMtQKLR2abRlMb3rkdabBUfKCFvEzAod9X
	 Wdq7wd/i5eW9C6odoVYobg2WskJdDUrW/wPfZYK7FO0G7s4RTHvT91Qnewn1AK3LRjhQx
	 mSAdavVr4gC7PoO5usLr3R1O50pv0uFkqgYb1KmapF63AMBUmXr+VBq3YS/z3DWI47w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q+GToDPh;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794E60A2601
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 17:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C794E60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q+GToDPh
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso19837315e9.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 09:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795110536; x=1795715336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jwlg61NUOc4xs8l+sLUkgCxBzgtDSjPT6mOzXwoXKWE=;
        b=q+GToDPh54FghhcMKsV9lON+4TT+xrrPThTtKU+0uXAz/mtbWl/0Lgm9mD/QmhOWTU
         M5TM0/a0lqRGoq58NSC6zQ5dCMj1PgYs/CPK98ig/W11RstKXDaq8pm3GzT4+eZQ7gb6
         BB6hUN1r7uIR/hlBWa4e2xcZY0dUr678rALjUlhxwI1sbETpdgOFMZbYTCARSEP04f83
         IueNFX5D++oqI0w/MGPf1690FrZ45TvoULcxl9L9bsYM2qLtllAoaZYjhzblfskBMiC/
         JyM1y1mV6Tn8mDWGBWMsjp9pNobSxTOb6ka/XfizKIeO2vV4q3OcjQTDPj/KJ4+0SqG2
         x7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110536; x=1795715336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jwlg61NUOc4xs8l+sLUkgCxBzgtDSjPT6mOzXwoXKWE=;
        b=dH+9YhAkWqJ0tZldEnHcf0qLz1SzEblfQeO0lhabKCgysvT86Dx0jkTK1v5a9tYX4r
         sy5+KXK6pnYBOCcrc/wkmhe5THYUDxFkr+yYnivLm82U/AjR+RdUvtbtCtyP38IKt4AR
         iOfp5eECash7LpeVyzwOmzwSmN9Dxq5oNpoPmQo2yVdf99uBu/ETx2xum5LpuC11908Y
         3nTVI2iZbFy0YKfPIJLeVOiwQW3WezUayFHjE0O9+Jvedt3hUu0fgkeoVXgxv7yOsZGa
         xqHTtU8Bo6qobW1MdGb5eKRrJ9GGY3JveJmvkey8vKoq6dyJo5XY0Qycmw8han+7xt7a
         Jitg==
X-Gm-Message-State: APuU4Z/kHF1Ell24S5XhKjYZQq+6iBQCxbTTWYk1uQpe3bh2pp49hfGr
	tod7/xmALhtahmPGz/480EjyCfV1rXTCjKYd3ec+0dbDbhWUJYQ5U06xEw6IXQ==
X-Gm-Gg: AYBFou1X7WJMU5AaBPsEBy6nHnebbZDoFmWk7MKGNJQulc0KOKdGzm+Y8g4hszMLyU2
	Eg5Aa0/7qsKM12ctuthSNMWgXgasN5qzatFyEYDCIVlRKUMv6djvNk+RynCNI78gdxYZucOod93
	+o1W+zwe9d+Mei8J6h7kr/7Keaqk6inRbN7TnWABtLqCGo+LVI45TAyznWdsMod6dK7caVnsZ8b
	qhwD6TmX6Mq6HGUb8yVjjB9ZUW9hiDhbyIo5VSt/eQALdv7a9t8K0cfWLouonNbBS08ZixCuq4h
	Cia6Xq7ajDCyKuUZurn815z+42Nx6Kms1+hO52IpEwUgOL4OvPSYoSwE/ZHmTjZCy4g1V6C+pTr
	gGfsc8DPIib6CiMGRFpINV09DWr4r+80ycZrmD12h9bliNF6UPQts/ugxC/4EqGLMRSYzJaKYpc
	sE6ftEkeP2CLtaAqu412uA6NJpIzkExBxG2rm6zfatkDmZeL4elKFYORIB75d+oRZV8zPB+bXK5
	S6/LBil5NcFAIy6bN+bHH8NvgcKjswINQV14KDEKxL8+QL9T359pRsF/xW8J4mZUOcTjMwBaWmf
	OTGbmnvj3ST2egVtsRw2dOogZztftxaERQOAZv8IqB/64G8XwY5bRCjcV2iOKLFh
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3b3 with SMTP id 5b1f17b1804b1-4bb8881eea5mr5786055e9.27.1795110536004;
        Thu, 19 Nov 2026 09:48:56 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84cc09b1sm45969445e9.0.2026.11.19.09.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:48:55 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristofer Karlsson <krka@spotify.com>,
	Han Xin <hanxin.hx@alibaba-inc.com>,
	Han Xin <chiyutianyi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: Re: [PATCH v2 1/4] unpack-objects: use size_t for object sizes
Date: Thu, 19 Nov 2026 18:48:53 +0100
Message-ID: <20261119174853.829455-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <av7LcjLcTocYH8b-@pks.im>
References: <cover.1793446357.git.gitter.spiros@gmail.com> <cover.1794984184.git.gitter.spiros@gmail.com> <b2c3d349a4ac73da7e1d066ac43754d3e6939b9f.1794984184.git.gitter.spiros@gmail.com> <av2pBh7vLj5DVDha@pks.im> <20261119060524.775205-1-gitter.spiros@gmail.com> <av7LcjLcTocYH8b-@pks.im>
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

On Thu, Nov 19, 2026 at 11:12:02AM +0100, Patrick Steinhardt wrote:
> Do we maybe just want to hold off the whole series until the dependency
> lands?

OK, I'll resend the series when needed. Thanks,
Elia
