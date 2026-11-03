Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695784;
	b=A6hi/DLBMhcxtalecjSdxen2Ckq+qMioD0wJbnrCYD64IuzDdesOX1QNn0IbnyJdC2dP
	 CO1XXc1jVkY8xszrlyC0sMyYCyiDIadpvPFO8EAprGBTxVfW3SXriMFP5/kB50dXM+3ST
	 JUd1Dfuo47G/i1dLYUbzFYil2+QRB3N2SWmOYMn/e0JdqRM5mX+uLJw1JVkHoyy46LsIQ
	 MoLhlwt4yMIBNRmVMBUGjU5fF3xj5iOAygbASf+IQ9VTzBz7bZ+q8Gs2Aux1mFNNWazTm
	 DyfPqChG8sPf5q8QtMNu8wOTAd+37vhcDzCsFTwPBTvKsyiEEZC9jp4BfLjhLtLPn1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EvWJI5kYeBPj6+xTYzzcBEexRxkTeD8GaYZSrVVwF4g=;
	b=mJVpgBI6tAS8yILIzK7AE2e22W4L5Kp/79ri9xxVldVGtPfnudzs9uXFGsA+QRyvrN+B
	 P+ESG5mAIl2gFsUyp5aULwdrNf+qTkEoij6zVcmWdqM9Vp5WNL+ORA95Fz338y2ASY9e4
	 zj9FiO/RSlLTrGleVoMxapArzlBR1Vrlv1rQltYVYbfllaqFmJ10u1jFfZvd0pINT9I/7
	 jmP0t6cnHgNWTFkFv7pLEdQbZ6Nw+m07V/T+qKTDfntxAPwPnKSOvokMcAMqL+NiYWWLu
	 NOtQdLlBvrPGiuMYD8N8DrByhLK/ta7icAJB9anXwQQr2hSm9QlAoH3R0xl+Nfy3QPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QmMuW3ah;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D010606A326
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 08:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D010606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QmMuW3ah
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso5260494a12.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 00:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793695783; x=1794300583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EvWJI5kYeBPj6+xTYzzcBEexRxkTeD8GaYZSrVVwF4g=;
        b=QmMuW3ah7n41Jypo7jjCcBs9PQjaBU1obPx4TJhMPuSLibXcDx7lDtA8MCTkECFywb
         gSmIlvdpGc/DWRjEBOtyyIJ5qwM2+N3BwgN4p9erfkB73KP8ItoC5p8lGK8Jc0z45beo
         W5FkvjDj+D3xYUMoaKK4g9ESHeTaWBfEJsbhY1ke3D8vmcO1u1Ygjp72ThK7bYBqIo2r
         M+/+/qIpMpVuknoBynM+8WyB+X1J6lr2EOJGSbEm5zOASdVBgpKmM9Pf8xbwfvXDskBM
         PMroca5asDLo7KJwkT/lsrmB/ILpdSdRRClm7GkUGJpwrVsw/Bd8/uBYnI8j1jAagHz8
         CEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695783; x=1794300583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EvWJI5kYeBPj6+xTYzzcBEexRxkTeD8GaYZSrVVwF4g=;
        b=1SnrS/Bl5VH6bqaqH7MESlXgaHfDx/eq35HqvrCW8XQj3msMQKCXQ8xPA4y/7ihpKb
         O6ZSnjXJGWiFIElCWsL1w/7AxfJCLKf7b/KRmj8CuJ/TT30QlVImxnwpDb2O8RucURAB
         taqCDpOundNThTq/o7HBmbNhtaIEGFEybiP122KyT4VM4EvYc3YJ0jgDIjDCJw8hpL4r
         JQkvK8LgAASPp48qiFgUk/y53gZcdqElPCbWjyattr91Jq8inSbHUQ66PD7saEd66uhJ
         6QvyUSRmyMZvGL0+KExqTTjE0nqj8SNuX671tOUO6w39U5BZukjRtdTs/1i96p+vSgCF
         7glw==
X-Gm-Message-State: AFq9FYKsSVL02JNd0xipDLYIa4Ajn9lY/IPqCktBUErYqoLZQcyYh+XN
	2raYeHxN1Z1+4BsHQI6eUKbfDQW6UWYOhMFfUrusdW9jL1sWsUioq9eQ+Oj9mysCP84=
X-Gm-Gg: AYBFou1wdLLc7GsNuw5W3gu/lHaeDBOLZbDvYZSdtyuN9zApf1iF9yIrpEQYUXrzlmP
	/cCG4XrUTjgIXgOxaYjaF0ObvCQ7BC1MIX0zO88PEcOOVk7S5Qn44+sPaU3MHVz1TVGRmlA0xAU
	BOEOj7tBLplOiaxpNs0hSr/eI688dW/Tg/5ySo7qwOsptqkROlfizYf0ey4uHXzAIIKAxT5NbB9
	TpEqBlljGL5mSdrPm3gwl5657mD/Mj6bbqyR1/bURmugQDbsUcBxthVk9MzE16qIn4tL03xVkFQ
	6eH/cZqw9f0K/J8QjirHidixGtRzMGIlpJJpiXco1SxMBY9qgXjkoGpezil4pJ5Z/1381v/LvvB
	9acIJl1bEhzJLAbUZzJSUyky27L9XwMXVo8l+Zv3z+yJSXuSyl7gH6tjwpVtsF6cHHuUsu3boME
	f1czpCSK0A1GDqRx1JFQJDU2ltlHJIVfNbEZlzA9AaMRAgHP68Fx9RiXaqaLy02vq+un7rc5sOn
	PE+EpER75U59r+vnfu4b7sU8wLOVeK5obQiF/KklbIVtm3dWoRuZXySWScTCaDMTtn93eMAN1tY
	nsi5Qzu63EE2vnZ65LvLYdVBGeZSmv791hZ+Gami+O+9RtScbh8/NFQLtfMXccc2Lo/1b6WIAfY
	rqWotbSv7peUmRjK4rbdPXfkmuV+LuyaB0FBpdSF583dsg1vxhwoDSWsy33vxjB9NryYcrwQdcA
	/2Q6Rn/9mp1Toxa2r3dURaCAtFQHvlWymahF1TVGXXedgbCc2jPQ==
X-Received: by 2002:a17:907:868d:b0:c49:df8f:3c79 with SMTP id a640c23a62f3a-c4ca7a6ea48mr1075552366b.34.1793695782639;
        Tue, 03 Nov 2026 00:49:42 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cec15a904sm64611766b.70.2026.11.03.00.49.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 00:49:42 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v2 0/2] notes-utils: stop using the_repository
Date: Tue,  3 Nov 2026 09:49:28 +0100
Message-ID: <20261103084930.15532-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031104526.46711-1-okhuomonajayi54@gmail.com>
References: <20261031104526.46711-1-okhuomonajayi54@gmail.com>
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

This series removes the_repository from notes-utils.c.

Changes since v1:
- Add patch 2, which passes a repository to
  init_copy_notes_for_rewrite() and drops USE_THE_REPOSITORY_VARIABLE
  from notes-utils.c, as Patrick suggested. v1 stopped one step short
  of that.

The callers in builtin/am.c and builtin/notes.c pass the_repository,
as those files still use it everywhere. copy() in builtin/notes.c
does receive a repo that could be passed down instead, if that is
preferred.

Thanks, Patrick, for the review.

Okhuomon Ajayi (2):
  notes-utils: use the passed repository for notes refs
  notes-utils: pass the repository to init_copy_notes_for_rewrite()

 builtin/am.c    |  2 +-
 builtin/notes.c |  2 +-
 notes-utils.c   | 11 +++++------
 notes-utils.h   |  3 ++-
 sequencer.c     |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.56.0

