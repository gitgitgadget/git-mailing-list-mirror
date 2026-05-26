Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92F3C2B9B
	for <git@vger.kernel.org>; Tue, 26 May 2026 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830957; cv=none; b=BzJ3KRYzlDIbTTOqxW1vHvQemovhqSBoXDQk1cHP9hvrimjGcUssYtkwMwIRSzEksQZ7N57WJnhv59q20B7abrlNKV2QBGoAsvBgcnmGQSKDINaGKSQi8FBh6ZkoqoU6ApwO02IZCdDm8KnyaatXGXeyAUFKyzVAa2K78h/gDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830957; c=relaxed/simple;
	bh=gsSQm6UV6EkfTvLSfBqG0L/yOtOIaEOoOX9KWtKvgkw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=VcihuAk56Y1llOTj8qxVTlq035jm9fkaixdfg9Rj/q/utGLrHiuqQujpwuGKITyVBqinDfDhEW+KycjmXXeHZGodroT/ORLNkQNoJN4VpRLwJsWUnJT7V/qwpRTGL9dsJe428cQc/OmRAypHWB4xW7jGzVt3olgbePsRh4tVUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbJ17eQx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbJ17eQx"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7b37d84a6b3so102618917b3.2
        for <git@vger.kernel.org>; Tue, 26 May 2026 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779830954; x=1780435754; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsSQm6UV6EkfTvLSfBqG0L/yOtOIaEOoOX9KWtKvgkw=;
        b=cbJ17eQxRpx/aLjWsKfNgNa7Os+S4D0jsRxOJbiJhnNLcDzVgUmwhtJao+7QLRUmeA
         mkjJ0jUB/tA5v7psNQ+QY4o7E+deFxTY3+AnGEtA2cFr9PAYTKyKoQsxYSD1TMVd2njZ
         w70tcS6H+lWZnAtSZAF3NXZR3BhAfprjA8zVHntNvSmibu/nvFobcj0LxFEezyHyDj6I
         zIs1AggD9JvbqphuWEiWXjATbuDlDk/+YRvYL0cZ6p/92t/XvGOggQYtZ7j4wYFH3KHK
         bw0SdUcOSyb0ljXZPkPLYXIqMKicnHynJKlsOwt+jVE3vGLNrNaVLODc7SDaQVaqZBfs
         AQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779830954; x=1780435754;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gsSQm6UV6EkfTvLSfBqG0L/yOtOIaEOoOX9KWtKvgkw=;
        b=DGJunqDGKYzsweoYf68LrVnfMQ8ksNuQSQVzyD8h/bZLfSLXmtUhhlkuerjYymLufk
         QxBU5jBcaXu/tEvbC8B/TMpiPV93brgdrckSxvHIoDPJX5sXZgiHnwI3nwBxyqVOSRWZ
         ysrnQRxU1YeC2xL8VC2bn7IMYZGvL0J94M+8qT5odDU2eno+e9Lnopq243EbwKy0Xk9Z
         gmJOeSyeoo54H4LN6qiGn+ALILS+R1HQgMxOmXgdcGTbqQqu3BqPvhxdWKk3+mdLZVpL
         om0QCwz73yyIWKPdB6UHp8gLlmrSLUvgNQ0kox8s8n4mxyDHVPywWRANnNqLfIB0ju92
         jvuQ==
X-Forwarded-Encrypted: i=1; AFNElJ91+R+F9M2+b7S855FkIdU2/QgSlDcG9aF8hpISGwwVgQuMMHNiFwn+US2IAEcTLZhvvIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd5vlGb0t42s8wONVPudmU+afipK56s0RMbUgQEteLR5Jh30tx
	kP0cTtRS5WIvzWfnKqaZ82VVFqSgfJXzf2IGx+8vjhv6R3c/azVJxyONU6iF8A==
X-Gm-Gg: Acq92OEAxnx85GrBOJyzEqEr5Tt0PrkgDp8Bj5ZOQcKNAH9tTcQTZMJA76/b9R3V3VJ
	EIACpGsDe9pS5An0dHkd5WlGNtzgk4jzcqMgOG8a2X+7FUnPy8iPn6HeQLXh0gjgQJq7ce+AKAe
	qxvay43V9HWorU+mdBZvQHyr6I3xQSV3I8lRd7/Fm3aS3uUIeB3NHvHnX1F8c/z7yzd8q9fXwlJ
	rOLDozS2ttx6NSRe/oGZ2dCa3MWEHOp/ekr6zZqa/FWSctpzy+fkPX9PNfBzYHC7BHVeTVSeAIa
	9JFXLZtUfyVJ/OO4WT0gD0n097Rq0J1AXnv6EuqPKMJ9RpogTHryvl9H8P1xlmyUKWwnq66kPDh
	s1vezxyTLPO5WfanQ0Rge34gs9ig//r0IpDUg2FXqBvJJNhgvqzLu1rtiPT3sec4vfX7o0TznXr
	L9Kn4V7UPBz8Z9e1io6exYvA1BMCvGlKKcbrf9nKcKEpSnOaPa78zcIHsTaFZnGNVR5buCGG3FL
	ReiDLdrOmvJ4G7D96ZnUUPBJ+kzrs85b9GUQLRiXclKisK9K0/U0kW1
X-Received: by 2002:a05:690c:650d:b0:7b2:dad2:5dfc with SMTP id 00721157ae682-7d3337e7ef9mr223998697b3.6.1779830953738;
        Tue, 26 May 2026 14:29:13 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:f59e:7784:8709:5b6f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c8398e6sm66223547b3.49.2026.05.26.14.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:29:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: git mv after the fact
Date: Tue, 26 May 2026 17:29:02 -0400
Message-Id: <85D5E150-BD78-4FC5-83DC-10DEBAC6EA4B@gmail.com>
References: <CAPx1Gvd9+z0th9whCbcA60_bWproPp+kwp3qDmhQOe4G=0=E6A@mail.gmail.com>
Cc: Frieder Hannenheim <mail@fhannenheim.net>, git@vger.kernel.org
In-Reply-To: <CAPx1Gvd9+z0th9whCbcA60_bWproPp+kwp3qDmhQOe4G=0=E6A@mail.gmail.com>
To: Chris Torek <chris.torek@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 26 mai 2026 =C3=A0 12:46, Chris Torek <chris.torek@gmail.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFOn Tue, May 26, 2026 at 6:18=E2=80=AFAM Frieder Hannenheim <mail@=
fhannenheim.net> wrote:
>> I'd like to propose a new flag for git mv, that updates the index
>> like git mv normally would but does not move the file. ...
>=20
> You may already know this, but technically no flag is needed:
> you can just "git add" the new name and "git rm" the old one,
> with the same effect.

Or indeed, =C2=AB git add old new =C2=BB should also work, I think.

> A flag for "git mv" would be convenient (and slightly more
> efficient, not in terms of storage but in terms of CPU time
> spent discovering that the contents under the new name
> already exist in the object database). But Git will discover
> the rename on its own in the usual way regardless of how
> you get to that point.
>=20
> Chris
