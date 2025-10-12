Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD925A354
	for <git@vger.kernel.org>; Sun, 12 Oct 2025 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760294474; cv=none; b=D8nfop2gm/6P3NGPxXBr2o15n/OdWEbBgdml0micjOy2ibAl7gWdXZsUfw7ROnLPiKoxuI8C1RRSibmFpUmeOnq39fowvDP/tK1zIbW8MQupi/YbsLJqhJaaUbELVjkB0uY5e8CJv2mTPYJQjIV8B7p+5Hc+mcFSS7PYO5Wi7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760294474; c=relaxed/simple;
	bh=SR9sIgzn2WVl3FSupacPEfdZzwMVQVGf/UIlaf1g86s=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=BN+7OfufQiL3GFmFbV7du0dGC/ERI8ZomNpdqsdDmqZQ4EU6jZhWU1Urf+mj0asgUMmodUaxL8AP6c1T29mSTZvQ6dYFLHfDHCfEF+JrPzpSuUcBHPLBsxbWpgUo1W88I4bqmEhxBXI+upFN6t7bPC/grcumW5MhzbCkFOqGK3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqEyQkOA; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqEyQkOA"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d71bcab69so32170427b3.0
        for <git@vger.kernel.org>; Sun, 12 Oct 2025 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760294471; x=1760899271; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/mMEmelW5ph+eRqu5CsipGgUUKl34adAxLbzLKyeLY=;
        b=GqEyQkOAbR9RT7UfUiMH9U+ksN0kUOq0qUCWAhepY+wFeWTCj7W45u7IFONO+E5TKs
         aMamLbrBo56qDdQWIVdhGOiDhPQWIoXtXMHw9Yq0veNuMnMUTR4Fi7vC4BWOlcQT/vSa
         rPrm3GKqyKk4DpLGJkXL5FfqzVbtUvgiNj1BDqw9TC3V03NjCGHNJPF8uB3T0nhQBZKN
         9K1YtxgsoJBWV/SvCSgSKETOEmeU0JYOtxCVDcocqb1nmnvIxLidYP/i8yRgQcLVyReC
         2iPJp+z2keSONh2nqIyn8QXZ5OLoCWYo59k5gO8hSmWf9CzzMggkoEyk2Y8/PtvwYRpK
         rStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760294471; x=1760899271;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/mMEmelW5ph+eRqu5CsipGgUUKl34adAxLbzLKyeLY=;
        b=lztc4MTfzKvP1A2jGxuYy1+XuOXYgj6xYIRGJFqYJ4yEFPtBoNDDY78B9/MQ+JSGKg
         QcBd+vRWlqomOaf/+Zrb3WGNzN3RCvTMCNaDcyk1E3FfJJbuCf17UMwJyLXCRozVhgSV
         J/QjC37a5dFQiJHZbae3q4EWA5J0mKNTqXA3xOXzBef0Q3xqRpO1/YcejxvqocE+MRdr
         lFrzwEzb2qtWwgBVhDrixl+AgT1gGU3ULYlqNX8Fiq7WWAB6HQFMuk5LX0wRfu1wvs+a
         2GN0vFNiLg1nkaWm4Ua1xlVrC8frOe9BMgA6lXnd02wg7wFs7ILJQ0A1FNlcOgXSt1Rm
         mCkg==
X-Gm-Message-State: AOJu0Yz1263bDnXCze4V0y/zDGCEoAKJf6gOXVVzadWfUY225pWdm3hn
	iqJ6LyMkx3H8K4tm2i7wnejNldiEyI/TdXfYz7fvKu2qY18tic/yDXov
X-Gm-Gg: ASbGncuUL2kaau87rVMYKqv5Ia6xaXT2qO3tBnb1JucYZRjZv3j9mh47ww06M08N2Jp
	GnOco6i4X7kaiQn8F0O7lw01/NRDVjqdWt9DrcIe53zG86Lz/3+H6fBOjXkML5UEpryApFM4n3+
	4txWsdaZXt6a8q22wEAnsGvnwtojBvuJfDXslbbqbd6UyBw8uz8PbawDQuRV67AxbL/mqKNliLW
	WhrXEH5gvw+fiHZtd2G8kgvCq65d6oJfG7APzjbQzdCN3lBpt9dWa1lkU+rS8PifV7/kW3GJ9wK
	9wtM09EbiIQY0HDZUgJZsM7SNHADclL71U8g1d79DGP19Z03dOdc9VZAH+tKgpCcO8uCU2Jz7q6
	DCwZ+5Eg2oNgMeDg6p7QddbD1mEYpqgiWgH3eo6jdGec5arAmUbCxvOjtA37J7OfdKQXs79X5Hw
	UDUFVt/5HkiPcG/kdITg8n
X-Google-Smtp-Source: AGHT+IEVATyR9PP649om99RgogmcuXCSWVb092A2R4p4DI/QjMfKE/zNL2KAnat5CvyafaCkAFekzw==
X-Received: by 2002:a53:dcc2:0:b0:632:eae9:5cfb with SMTP id 956f58d0204a3-63ccb8e0aadmr13668583d50.29.1760294471559;
        Sun, 12 Oct 2025 11:41:11 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:2564:71f1:92af:6548])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-781113c0a30sm16657687b3.23.2025.10.12.11.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 11:41:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: What's cooking in git.git (Oct 2025, #04; Fri, 10)
Date: Sun, 12 Oct 2025 14:02:42 -0400
Message-Id: <A05E06D4-D27B-4A3E-87E5-26FF6AD8E23D@gmail.com>
References: <xmqqa51x7449.fsf@gitster.g>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
In-Reply-To: <xmqqa51x7449.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 11 oct. 2025 =C3=A0 13:14, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble@gmail.com> writes:
>=20
>>> On Fri, Oct 10, 2025 at 8:00=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
>>> --------------------------------------------------
>>> [New Topics]
>>>=20
>>> * dk/stash-apply-index (2025-10-06) 1 commit
>>> - doc: explain the impact of stash.index on --autostash options
>>>=20
>>> Doc update.
>>>=20
>>> Will merge to 'next'.
>>> source: <d4a277b6b0695d86636562f4c07efae17f9249f9.1759755379.git.ben.kno=
ble+github@gmail.com>
>>=20
>> I think Kristoffer had some feedback about the message=E2=80=94if changes=
 need
>> made, my understanding is that happens prior to "next" ?
>>=20
>> I'll send a reply there shortly, at any rate.
>=20
> OK, will wait (I am not sure what needs updated, though).
>=20
>=20
>>> * jc/optional-path (2025-09-28) 4 commits
>>>  (merged to 'next' on 2025-10-08 at a1e8af9952)
>>> + parseopt: values of pathname type can be prefixed with :(optional)
>>> + config: values of pathname type can be prefixed with :(optional)
>>> + t7500: fix GIT_EDITOR shell snippet
>>> + t7500: make each piece more independent
>>>=20
>>> Configuration variables that take a pathname as a value
>>> (e.g. blame.ignorerevsfile) can be marked as optional by prefixing
>>> ":(optoinal)" before its value.
>>>=20
>>> Will merge to 'master'.
>>> source: <cover.1759094936.git.ben.knoble+github@gmail.com>
>>=20
>> As I mentioned in <1D9EE7CD-800B-4B70-8D98-79B0C2FB8DBA@gmail.com>, I
>> think we might want a slight reroll for some tests and to use the
>> correct functions in a few places.
>=20
> If you want to change anything, can you do it with incremental
> patches on top?  Thanks.

Sure.=20=
