Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4422D9EB
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758407144; cv=none; b=YhPJ2lW/f3ShP93pEG/fg1IJeAltKHyYkxhNfZieOqnmWshah8Bx329EjyMqoEN5Y4ZtVKkpp4vL+fmwZGErYxYl2QvYqdloBUuzBzw0YC/jv5OKi5QCcUijJbcxfqxWVjxCBhlb48Cs9omOOFdFEC2f6Q7aXd1lG7Bj+61Qygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758407144; c=relaxed/simple;
	bh=lc6VwaxO/uZ3PrwBAcctzLwTh7U6+3iLxdID2KJ9O8A=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=rDfoWYAWKYHuNrbOqBkeEWLykKQmOtOb5n1PxXA5PCVd1/Xa3T9i+hI/Rrj2OboIb+ddrmsXmHr4ORaxhMCIjLVy94+nirkm5in0AFzMuD3vzd+j7ZQiSEz8p/7X5Zcmg1EVCmxJ+FtpguCYt9LRMFnKVY6HIpUyMSmWHo6Kf+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZgLJZPU; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZgLJZPU"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so2132881276.1
        for <git@vger.kernel.org>; Sat, 20 Sep 2025 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758407142; x=1759011942; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1oUWsBZm4enqG5Erjb8PSBytnL1cM4godkbxw8jtMQ=;
        b=kZgLJZPUEBXK07kSorj7UkSo0qCYWBxntRkLHeB2HuQSP1maadoJwV6QD17bbRoc7C
         cUKtWuMLn2p+6HHykQSUqt5VgElYLQVBiastQndEDf45G7fITT9vOuQ37gUC4etVeGyQ
         /qZ382vTKmCFKIOE6YpQ2TcmIkNtB4sXIGj2oujVO88cf6oJVfJT0LJqBlhNTCF0J/SN
         yLwRJHijTyLpkaSgEdTtU6ZJS/OszDqiCOABHq7TMYnREEYkcYEBTs9hXKOEzEo0EX8Q
         tPUYY+dXe1jiiphqQDRjQN1gL7gICLmLNHb70Ebl9QUvfUw/9QRIvVG3I7N3Awho1f5F
         tlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758407142; x=1759011942;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1oUWsBZm4enqG5Erjb8PSBytnL1cM4godkbxw8jtMQ=;
        b=PxDdFJffOSOdvfD75Sz2dLTx7VLVumAqEzVqD85dBQo7Uy3oTwp+Hp6E1s0I58uqiz
         sHHNGtozs5oV3M4swqlkwN2QfyQQ2i+5EX/ZnvIa/aG092qae80RVJMdEDq2CELavBKJ
         i1bGMPTZD3ct4H5AREBWM0MDlD+0IXLEzoMd3WL0V17BrdvHXTKLEqrBa0KMc3lE7PEN
         z7nYCbWM68mXL3pLy9scLtBdQmuo4CUcpW9QqGf/OUVz9QVbaiD/KvUm3+R48pEsDGGK
         WRuv02PLpraIVt9NEvtG1D4sUTCry9DMSXZI86om6rao2+9P7uG+Rgn1nfFQ81RVC3Em
         DX4w==
X-Forwarded-Encrypted: i=1; AJvYcCWNRkfidacTaBWP8JBNc2GngrC2pltIHKLXo91Dvv9cYv/b5lZSTcf7Sxl1+R9QS13ja7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE0Ah2eXPQCeVFJDZQoaXF+5MyhL3rT1tD12beGn0YZf6Vekga
	z2ywW2XnIA2rR4HJtcB01pL92nLHX7kB6u/Nuf8TEkc1EvNAjK2VhLJOIsEW9/fV
X-Gm-Gg: ASbGncvpdLPlm0jjrh4csd49MYX6YX/bTMvxqNUweef/PrrLC0msKaOG3/zUV+Sp9Kc
	4A0p9d3ecuqmTMsmWf8B8/q5BQX4DN+Nu9jIUqKuHN3HWlgTSm60rJwhbEApyYyF9bhcMpbjjjv
	lCBsfcg4T3a/lSdlyfRF6q2ki1P5Jk6GgXkunbzk2oiemqpOfFfQtrIDESPpQDZH0tEMMuBOdEI
	/seYOIU28miD8oQ/QspKEKEQzz1DWfaNPFesXJjWr4ID8bnPcShUDYCT7InWRfsnqat+Jh0TiLH
	7H1sn9Koy3OMnk3c6oYHG2LhhQ4bf+ZlOkmU+P0PNmkHUZJCN0Zk5/Lm7DTQWnIMBF1QD/y1Urq
	fI1ancUghpPwghY1Ryh/uRlEpRgb2k7H2A97XYAHSublezNyVJj9JCvuhejvMnw==
X-Google-Smtp-Source: AGHT+IEGbvMAcFzBC7qAmJiGcDnGhB2x19QYIYAqRAo+vB4G6J0U3WIfB6SuishOY2GzdDyl/4Ij9g==
X-Received: by 2002:a05:690c:688f:b0:737:4561:34ef with SMTP id 00721157ae682-73d25bf1fe1mr65326777b3.15.1758407141951;
        Sat, 20 Sep 2025 15:25:41 -0700 (PDT)
Received: from smtpclient.apple (69-77-149-20.skybest.com. [69.77.149.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739718adb9csm23318927b3.58.2025.09.20.15.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 15:25:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 01/10] xdiff: delete static forward declarations in xprepare
Date: Sat, 20 Sep 2025 18:25:30 -0400
Message-Id: <7323B02B-4273-4952-83EC-CD467A2365B5@gmail.com>
References: <20250920184638.GA1010995@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
In-Reply-To: <20250920184638.GA1010995@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: iPhone Mail (21F90)


> Le 20 sept. 2025 =C3=A0 14:46, Jeff King <peff@peff.net> a =C3=A9crit :
>=20
> =EF=BB=BFOn Sat, Sep 20, 2025 at 01:46:19PM -0400, Ben Knoble wrote:
>=20
>>>> Best-viewed-with: --color-moved
>>>=20
>>> Two comments.
>>>=20
>>> - This is a bit unusual to see in the trailer.
>>=20
>> This was (loosely!) my suggestion, and I think Peff has once or twice
>> done something similar.
>=20
> I don't think I've ever used a trailer like that, but I do sometimes
> mention it in prose. I'll sometimes put it in comments below the "---"
> line, though.
>=20
> -Peff

Silly memory. Sorry :)


> PS I sometimes find:
>=20
>     git log --format=3D'%(trailers:only,keyonly)' |
>     sort | uniq -c | sort -rn
>=20
>   amusing to look through for this sort of thing.
