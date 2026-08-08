Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1139B497
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219671; cv=pass; b=phDfr+pBVQjA8dYG6B+2OcKbyF83X85DcpKItrGsvJiIoD7IsZLwUVfKgrp8OY3OGjWd5Yk3tyyoR4afzDFfiH10BV0SD9PI8MnVso5D3nnDHNINsA4eTaXSFeNvkulRTdsPaVt1DkByKdXcvGgtba4y64yhCaO1tYwkfhQ4A58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219671; c=relaxed/simple;
	bh=5bseMfmYZxaEfgJ0xzsi+bSpCN6EvfU+dufnF5nh24g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pq02ILaa+9abRjS2Q0LvPUYrUeGcC1Y651vuyD1A6rZCSk+pBwkbl1v8rBcxgnUhu9SmnBQpijSI3LsILiy/JoTCzceaTuxoGNh3RvYzerlttTz4qRrN2CYJgIL2YpikKnOC3AlRrXjR0l2iseHoHijpiVacOBgu8y6bFBEvxDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTf1e6Xq; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTf1e6Xq"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cfff5f88dbso10526775ad.3
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 13:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786219669; cv=none;
        d=google.com; s=arc-20260327;
        b=CVKY6Go0L2ipLAk8s7NwkaooXZtpwRkQz7wly7JtSXsprbI8EHYl8nq779Pyj2Xy22
         x29QH2GOiyHG6UEffda75jiwXxIesHta485X1vtGb7mFCmIJfuEh3xpmET+NGNhgINzX
         7r+gx/jw3p2/9yXay+/d4o8fIaNlY7S7FKDF8cDXMYv1ZLpIw4o3Ql8nzMgu/LEorAq5
         CdpyZAEVDBHuIIaJhUI3m6ZA/1PZgtNe5vFeI75jfQ21iLBxR5j8VYbGxdkDbwrZuicY
         O0ZR3pCu0VdkFt2AD5kvPhNAKh0+0Tw2hAYPqaG0FgwOaM3CK67wdAJsciK1WjuECdcv
         42BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lMLZP5Je+hGJBf+MzWi9eMx/6ECbd+wY/borUPYhHd8=;
        fh=HlHiiRPQ4xmXAzlgUsido7M6L2x0NwnIflVn+FLZwEk=;
        b=cbBOX4RPQwuCH323Jsqgy4vRxqb3amy/OQJldfDXpZYRhaghOTEW1hKy9LrXU3y7Oh
         N6j+JkcdRtSb8QURslUzfNgmkArRWeJ3Q8gFHpjzaKPuRuP81lqldySgTDA2jNF6FH5R
         w9aTzqUthTMPBBNhWs02aXbGLVcz2f4ctgaVydino8cC9QYPH38pveWmX2T3CtVszkoL
         enh1HmRj6VrEWHYFNKNd7m6DkhFZdmGn8pWHaOjx5x/EIyKFcXSbSv0Pv7symIeU34Aq
         DZduGDGF+bE0p3NT8qF2mhQ9RGEvWZWlD+0YNArP4CGg0tQmccDMJ5ZzyHyK0dBRxl6B
         iDNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786219669; x=1786824469; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lMLZP5Je+hGJBf+MzWi9eMx/6ECbd+wY/borUPYhHd8=;
        b=ZTf1e6Xq1eCsqaVHu96yJT0n6O9RDEk2OinFWl5ClaE2xeLxNvWoNkaK31/PY5zVJb
         hMkFZgAqgBDkqfNu9xYLXzFMX/5vtg8I3nFlqLQdqMoLDqS/bP65SiLnJ/RpzheXs7S/
         5qAmg/99be2Ggl0SLft/LRKukbALzGA292q0qpOS3urCdoyVLcyZocYrXeMyFdEtdeXZ
         M/i1LMbqT4pR8UZTh6a1B8vUpaV0AQx3BtzPaQpv6++Z4mm9LxK5Z+vVhYhyW5DvgL1U
         8ak8K5/VgxnlWG9w8hXx+1h+oRbikY62gWpKowhpxtdJeDp2k3C183jogiSoHdBV+jQM
         lDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786219669; x=1786824469;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lMLZP5Je+hGJBf+MzWi9eMx/6ECbd+wY/borUPYhHd8=;
        b=DnuLsTDLVLz2JdZiw8tieMX92phgiclkNoSPxGyRoFlyMkFfr5TPZIN6idszNZlLOc
         8mMtX0QuKEO2depwOEjb+H4fGrUmORN4BRBee2f80ICwAUOh2r+JwlBlWzAL9jg2uGgn
         WsxT9oEn6UCjl2N3xsa8l9X7acUAgzEyW8Qd5CyXmGkxjcn22g1LYM3iWOHldfQWt7DK
         +2R6znDeREx8ImIea2YhTjSYZhRJbFyj+v5gfg/Siq2OyJ9Hd9u3crYJ9tbHQ64KWtdF
         eAbTE1ZsVylfmvoTQnpXYo6LogxEgtFqj+OJrpl99iIuQzzMQ2olPStHzqW3P2n4Tos7
         Y3Vw==
X-Gm-Message-State: AOJu0YyUx1cF/qVfHcDtDygyvusVKyJHTFd8AhGysFh0LIeCkMKeia/0
	JMFlm04q0E8mm9M34dDd2xp/SvuaIxbXCeSMEzftMLWhtsjmwBd3nuNMwDUpg8z1t+W4xpmU2V/
	op8gmlq9Orm3dTU7D30lU36YEDHuDRC8=
X-Gm-Gg: AR+sD12W3tQgQvV3+fTtdDQqRE9Qnvb634eRMs35Fbs1WCOQkzW/TjMUkPUx08BEIwx
	A3ySZDEuMVDap5cuH6lC5TQC3k7w57FbS+NUv+Ke3H7L0arN4XWFkqpAluAOQfhgbFEabY9b3kO
	lMcKrmDm/8y7Pd5vEavhSQBsO9z6XOWFRsMhjrWBo/741xinq0qAmXF0VdwLwBvjh6GVaz8EdDC
	DWFCr9Qxss3zC3NxsXBCLpEm/Lo+U7wTj6eKwzE/uK+ngIbO4egiYNigeGwJ5FziyTjloB5egbp
	lKxTV4/IigfDch4db5c3sH8Wu8Wc4Kq+Y2J3N5VdBSE3dzJICN+CqYy4anhNxT6NC1vk45mghUN
	nOO2iNGKgKox+h3xg0EyT0o/K59lGYPxCo+lsNdDs6cwsardvBjEV8ddbfhm3k634
X-Received: by 2002:a05:6a20:6a1e:b0:3b4:7e2d:a3c2 with SMTP id
 adf61e73a8af0-3cb85ec567bmr29974839637.18.1786219669154; Sat, 08 Aug 2026
 13:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
 <20260806112202.75067-1-r.siddharth.shrimali@gmail.com> <xmqqpkzuhoyr.fsf@gitster.g>
 <CAGWgyh9sDrHb2nXw+mmgQg4-x_H-_mLcwtpAt7QFYHydWNDg+w@mail.gmail.com> <xmqqbjbdejrd.fsf@gitster.g>
In-Reply-To: <xmqqbjbdejrd.fsf@gitster.g>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sun, 9 Aug 2026 01:37:12 +0530
X-Gm-Features: AUfX_my6RmCKoEowgCjnKvjyN543kX-5N17plWPFbMqv9feeWqzYdcwbNw31jeU
Message-ID: <CAGWgyh8YDULkNMFsyTmdrm+7mkj2rCvLu=BL7j1DkA0+B65s6Q@mail.gmail.com>
Subject: Re: [GSoC PATCH v3 0/7] repack: add --drop-filtered to reclaim space
 in partial clones
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, ttaylorr@openai.com, me@ttaylorr.com, ps@pks.im, 
	johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Aug 2026 at 02:22, Junio C Hamano <gitster@pobox.com> wrote:
> Please do not limit yourself to "all three".  Do not expect
> reviewers to be exhaustive.  You are expected to be.
>
> IOW, do not just run a selected few tests.  Run the full testsuite,
> and then some more, like making a trial merge to 'next' and to
> 'seen' and run full testsuite on the results.
>
> Thanks.

sure, thanks for the advice!! :)
i'll run the full suite and trial-merge onto 'next' and 'seen' before
v4.

Thanks,
Siddharth Shrimali
