Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A7848875F
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879730; cv=none; b=Ccd0W6JOFSUUC+Kb+PkuOmZOHxxCqV4H6yrPj1XdKEQk9HMdADZZBE8+v7L8D2MZR9Lcca8lsygEYAg+ka9B4LMX4x1xz6IiU7foMxIGkbgTLeuhJGp8TyQvUCvYGI5g9CWHnbP+qYkWunV0ZejNath9U+uYwzeY1P03CDrpfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879730; c=relaxed/simple;
	bh=wU5q8ySqe1/Zxv//nwHiFRkkTQmf5xRWNfdmxr5HwgA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=qMEkkyya0AOJZoCpl3k4eKlBJ1E4WEHyH5Q7WH1h1zsIVEu6QliffkWhesCgbk6plUXpoQV0UDKdVS6LWSx2895mSzHyA6/ppNCVjLx5aqMJqV4zLBDKZ/p0/aWngXELBrt6lokU3Osc8IwdWmVgQLsUNYBk5DX3oEFOHPTBqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNffZmGw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNffZmGw"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso2438545e9.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 14:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785879727; x=1786484527; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z2xakS9Uc9TcH1RDDsecsjiy6LRM9oWJEAqhe1GDVfI=;
        b=PNffZmGwiY+l+YIn3QV5Mip1YTsqWD6grahySgj3KoOKLW0tohFuFFbHpkXmbCkQG4
         YzZ04KkP/eMhnRDPIlTVGJd4ZOXryFCJl7MKQ6xRjzE3zhvt4iZbayCJ18usCuWsqnVD
         al89VL1iuvjC/8tpp3SaLGdt0WJLVRLERvT0aqxlzfL4O//aItNG4DMgdSEVr25TTdeC
         XWSDUsZtz4hwSNR2oLu409pwqRWKA9/lq2hAKmTTvG3pkPDZ5ONV5cl4dlJ/HltWfmBo
         shrWvC/zP2l/t6+ML6z7tWOnD36iBQ0vIs30G1/MWsmsNtUDIDdgomPoGwuGCiijiway
         mSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785879727; x=1786484527;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z2xakS9Uc9TcH1RDDsecsjiy6LRM9oWJEAqhe1GDVfI=;
        b=YDZ7v9w8VkM8BW9YVVl5zoKyJWbf+4rK4K+P18csCxssW0CUhyW3MfuskGhx+x4dKh
         XYaSdGdQH/Zvdv49/rPr3eooebqj5FL3whxnVUcEGgbFEVe2P5hp5ZyDPr4txJA9elr7
         EO9Pcnhhci/pFERWgKBJFQ/qDGi77q1ZNkDQG7OiT7n09HB1BRHnduXQKAUQY+iDJu3Z
         33B5euaYnBUbW09WZqphurjmfMxYi1Hlt4E6bycSKWlyoB0HCUwJHlg1Jx3eeYoFPUew
         M0lrhJlRKmf46W5z8A8WirE7Jlsedq/JUxsgbKwOcpjFTS+7l/8oDakUb4hhj6pIZeEK
         NMsw==
X-Gm-Message-State: AOJu0YyW3Z1H58xAsuiU3+lY35LWvOFb0317IRU8u4TrxF4I03OOZWVL
	B7kiZWSdV4nnE5pvIsISwhesEndS+6ceDPFHrUgh7T9TsAUJC2by8Kmf
X-Gm-Gg: AR+sD11CSzAUVOASawGtNVheSbv7YGpRkl1HMZyNFgVbQWQwEOT7v2mSoO3qDSQJgBM
	DhpWU9oGJjXoeXmAwwo6krZwfPz2dIkMeHlGuCeEgMbb8ZjfpIDrFxDqmTSiScObbPfp8sPVrxZ
	7qhJh5ArIp+UdGfmnPo5DjdZvSsQaf1Rx/pKJ9+nfdyOxR9IpFiclALqANXCInMjiF/Ji/zHfAQ
	qNNA1p4CgpwtSgaGDNHHBCWo0L6Ym5gy7jZlbcPIdiaSyn5YqAVz3okDl6DwyLNQUhEuVAqRP76
	jvuOUukmzwXVVJkqznTwneQ4VFsJz9HYg1nQiU85VVTzg7poJHydl9wv7D853MBJnAXLJTpZqDO
	wbRAIfSc03zgMgq1SUVqK4oakwXLvu+gYpMK5NDKdjAWQrdnTiEPildE0MvxGIbFA94VmuOJyB4
	ey6TAzWQ8MLXOwkmtSmaFCt2UTvryqacwdCVHlopv2RZSNapF3v8esMbE4dhGuEz0Aw88G3VVK2
	glCSXTmAWqsm+QRc/81VrNqI+J6gnLMnnP0g1sK/ugU4q0Q1R0wY/OERlcOsZPfh95MCHtbdWj4
	ObXy+HjDR7EuRT6NgCl23y8s52M0MEU5xPWmU+83/9kiP6LX4SGIgigxLWYL1SjPLN84CUbYYw8
	/sX9hSniTaEI=
X-Received: by 2002:a05:600c:3b0a:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-4994e71d7b0mr14694905e9.5.1785879726519;
        Tue, 04 Aug 2026 14:42:06 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e03589asm28421625e9.9.2026.08.04.14.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 14:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 23:42:04 +0200
Message-Id: <DKGHIZDB5W00.QN7C3PZ77K7B@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, <chandrapratap3519@gmail.com>,
 <karthik.188@gmail.com>, <peff@peff.net>
Subject: Re: [PATCH GSoC v4 4/9] fetch-object-info: use dedicated struct for
 the results
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
 <20260804-objecttype-support-v4-4-31511b0231be@gmail.com>
 <xmqqh5l9txg6.fsf@gitster.g>
In-Reply-To: <xmqqh5l9txg6.fsf@gitster.g>

On Tue Aug 4, 2026 at 10:58 PM CEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>>  builtin/cat-file.c  | 59 +++++++++-----------------------------
>>  fetch-object-info.c | 81 ++++++++++++++++++++++++++--------------------=
-------
>>  fetch-object-info.h | 27 +++++++++++++-----
>>  object-file.c       | 10 -------
>>  odb.h               |  3 --
>>  transport.c         |  3 +-
>>  transport.h         |  5 ++--
>>  7 files changed, 77 insertions(+), 111 deletions(-)
>
> We lost ~30 lines mostly thanks to losing an intermediate structure
> and need to flip pointer members in it to point at heap allocated
> locations?

Yes, also contributes that the logic that filtered the allow-list is
dropped, and compared to the previous version, no type logic is in
this patch.

>
>> -struct protocol_placeholder_entry {
>> -	const char *option;
>> -	const char *atom;
>> -};
>> -
>> -static const struct protocol_placeholder_entry remote_atom_map[] =3D {
>> -	{"size", "objectsize"},
>> -	{"type", "objecttype"},
>> -	/*
>> -	 * Add new protocol options here. Even if the server doesn't support
>> -	 * them the allow_list will drop them if the server doesn't advertise
>> -	 * them.
>> -	 */
>> -};
>
> Hmph, it would not make any difference in the final result, as we
> are losing protocol_placeholder_entry and this list of atoms, but
> I am somewhat confused.   Why we already had "type" here, even
> though we are adding support for it much later in the series (and
> unlike the previous iteration, this iteration did not do the
> ask/want_type thing in the previous step)?

The list was designed so even if new placeholder were added, it would be
idemp. because nothing would happen until a server did advertise that
attribute; that's why there's no change in behavior.

It was there because it was interesting for the tests. A known
placeholder but unsupported in the server still outputs an empty string
(this would be the case of: new client vs old server).

This way we had tested:

  unknown + unsupported as %(deltabase) is.
  known + unsupported as %(objecttype) was. (that's why it's on the list)
  knwon + supported as %(objectsize) is.

Using object_info and the list made sense because object_info already had
a type field, so listing type cost nothing. Now that we have to dedicate
an array per attribute it would mean carrying a types array that nobody
fills, so I preferred to drop it here and implement type fully later.

Hope this makes sense,
Pablo
