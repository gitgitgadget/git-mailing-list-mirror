Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F814B950
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394019; cv=none; b=b2PaTXeTHnDPWe1KhhMPBONbvw6cXSNUwTWMbGhTYd5QlTG3PU/xxvVULT7BfkBywJFLVqlP2Y7CTIBc+kbhmWymekrVg3q8GxMb/vDEzrRvlgwmWq7exspFLghyR4TVyIC6lQZ72+fLGlmAGU7P38KCQrH99P9RpmAzGHL0xr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394019; c=relaxed/simple;
	bh=Rvs70VC2cKBsq77jl0+g6IxdzU8MakXBOYxjYEnMkNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yka960MfxOAyA8xUyvPtolv7j1UHOsACZa4KhC+7f6JBTqgzb2k1TRm9ih46BX5vUjQFIBPNaUnulnJZTFWuqaNKPWP/ioI/uDc7oN9IND6gI5tA0pipvrwhsfo84kBfbyezAduGQzRc3Pi2g/9QLZufg87kqEwbD2OJGdnOkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE3pjUHB; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE3pjUHB"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85e15dc801aso54672539f.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742394017; x=1742998817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCcoTq+YFkbDXDqW+lIuMlQ/giUbWY3+657FQWI6UTY=;
        b=AE3pjUHBAhMAk/fi3bW1XNHcr08zEktDrvsSwazJ4hVMQOrBcQ4jSk+w6iYvw19/sz
         6wlLZqlTlCovFPeMI58TCMKPgnA7Mypo7W0uKo9V5ImZgz7zujEU6dDPvo60d9qBmeTd
         Hiw+JyLfN6Gul6ZTmuRPA4SiAva0DLfK1e8eLX0A6mcwR5EjkKG9CVjtORYD4OgvpnTz
         GgXxBk431YxgBT3IZA1+fcyGIxRyZhWqZ46xum45g9WOqDoCeuUD5YfQUEbBEvbC4aq+
         x7ZOeKlNo+udmq2GnLNOoyd/haXgZjB50S0tKsd69/Gd1lAB1C/ctWfwupWd33TybUU6
         GOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742394017; x=1742998817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCcoTq+YFkbDXDqW+lIuMlQ/giUbWY3+657FQWI6UTY=;
        b=I3YyX6vVOOuri5GvfScbSoRuZkOU4kmhDDxHzkEUrAdT9KyeZxsP2pwzvmaiVMyLDO
         o+El9SD5zeqBdZN20GZz+N9blpAVke662C+wcyxYkXspwNPVAuAIFsAg7AiLIm9EEyWv
         IlIs75lHY0rsrKPGVFpxcoPp+Vnja/4HuWRg4Vir+wObL6lFwGEf4AhHl1EAONwfNRMI
         49n0R1iig+eneSupkYqeS08nWZW1j8Qraco38Y2IkCsz8Wu7YpKe5DT8vXsuU7zNI1Bm
         umoHCBfa4A7KnKTisnKeX/R/3jOmisG7bwFeg/M+Sll1UjUxp6r2TsVY1Tv2sd9lfO5L
         L1fw==
X-Gm-Message-State: AOJu0Yzxl9Dk8TO9Qob8iiEWJe9T7l2vfnXFqhvwKeSQ3x8By8wUIBia
	uc/AHeOzGHgboH0H808DkGm06x0nQeiSRkeQPYH/NT8XIW/CqouMzGLiSgBld6/dQK44rg3ZXTv
	aS4bb9XhpNPyn/lhte71d3LQyVpk=
X-Gm-Gg: ASbGncvG2VBJX8EpKvn+Qrl338G2fTpP9leXlkq9uS5CnYvvbcSfFk0EBtaQLelPfkW
	lsUVpCcCM5NvGKyDbbjrpv0/JxJIEhGlfAlv1eccknEDf3LXWLoSOqg2/rpfDxe7EM7h23X6fmK
	hbdxIKXiyBl0+O7Nz/pOfHaCC07i56
X-Google-Smtp-Source: AGHT+IGho2IJ5CSCYNFbX+uyX1iLQtA+u8Ufjsrc8NthTkBTcAoLKEVV0R611LIlLir9gsIRmspcH6vQ08XUNkheYq0=
X-Received: by 2002:a05:6e02:3b83:b0:3d2:aa73:7b65 with SMTP id
 e9e14a558f8ab-3d586b403bamr28525465ab.6.1742394016646; Wed, 19 Mar 2025
 07:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742252411.git.me@ttaylorr.com> <0aa8aa65c130fd62d38b4944c1ce2a97451b0064.1742252411.git.me@ttaylorr.com>
In-Reply-To: <0aa8aa65c130fd62d38b4944c1ce2a97451b0064.1742252411.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 07:20:05 -0700
X-Gm-Features: AQ5f1JqNdtaFyZpSqvKV1dmN32DXHpbjA_Eiwt1jAV4W59zdMk3OiNxBkVlq1BE
Message-ID: <CABPp-BF1ivo2+tR0-KnU-KF6omtswp-ZMWiBgWPmmgOaRu8RhQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] t/t5329-pack-objects-cruft.sh: evict 'repack'-related tests
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 4:00=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> The cruft pack feature has two primary test scripts which exercise
> various parts of it, which are:
>
>   - t5329-pack-objects-cruft.sh
>   - t7704-repack-cruft.sh
>
> The former is designed to test low-level pack generation mechanics at
> the 'git pack-objects --cruft'-level, which is plumbing. The latter, on
> the other hand, is designed to test the user-facing behavior through
> 'git repack --cruft', which is porcelain (under the "ancillary
> manipulators" sub-section).
>
> At some point a handful of tests which should have been added to the
> latter script were instead written to the former. This isn't a huge
> deal, but rectifying it is straightforward. Move a handful of
> 'repack'-related tests out of t5329 and into their rightful home in
> t7704.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/t5329-pack-objects-cruft.sh | 250 ----------------------------------
>  t/t7704-repack-cruft.sh       | 250 ++++++++++++++++++++++++++++++++++
>  2 files changed, 250 insertions(+), 250 deletions(-)

A quick view with --color-moved makes it easy to verify that the tests
simply moved.
