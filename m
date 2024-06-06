Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02611BDEF
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707729; cv=none; b=Nh3nRPVe6WuUgx6t5zRXirYobt67moNHOqlOdLG7mlLpKvh00rSYvHN2yKPL3GQUZ1WHb9tS5FZE79MbqNmRCERRo1yZLuiuSspzPqkoo33Jcy9iYNUJaLgBHydy75gfsU+VGpCuvPrK+bPVxUHAPXa8ATNScKsGAnHA0fv188c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707729; c=relaxed/simple;
	bh=gVc22meywbOTgz4X8K1xH7IulgRNEDaNnU7ChosC90k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m88Bo+RMQhWjEOIwFGIkWrJ5ckjeX4OP5zWoP+A6cbKBIffE68gGpxCJHFa+k3oJFi9zSx+/4TkGsHm2DpJM97cAeUBCaFIa5iH+a62dDNSicXquy38KvKzbNPiiYws7bPL2ISBCh7xssnS1KmRIphvtICKMi8dO2TwP1pEHCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwFabQ0Q; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwFabQ0Q"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6aed0c26108so1768326d6.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 14:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717707727; x=1718312527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF8WVSwKd9xBGFGZ3MMiXvXf8jAxtoJbl71DIHFKwrg=;
        b=RwFabQ0QwCqBtrv2HZG23HprBhFkWpD/VM7bwfoCFSyHVT43g4AlyUkCi3JY3aXZrE
         bnXTGzYFFu9alKoFoOdR9yJr21Y0qyHCOqIFFrtNKfP2gE2T7ZZ3kaZtMTZhlKOFkOmh
         QMpJeaiiRPZo/ulNS6Ql2+JzLwJKv4DMJXgbKmv/1OMF7ufGyDYi0xZX77pPEH5kdn8g
         Nz0i6LmYscSaWlryCTqg9rXlMliIe5uZQ67i189hyB51kvNBo3U9qzZfKXpPFzjMK9RJ
         AcydJ75m2N0Es0QaTgE3QuUhJXNHypEHuIIHASqi2sOUo4z3/g6IddGrGsHVCGfETCtx
         DdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717707727; x=1718312527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aF8WVSwKd9xBGFGZ3MMiXvXf8jAxtoJbl71DIHFKwrg=;
        b=IhiKCJZWXm4TURwoJ5b+URunDuPnVjAdKRfuHdm/arwolJEMpwiHRkQZAOdO7e5tqr
         9SboXanTbb2DT/fUDqcIf9p8x7rayhxhJS0NUwhEkt6K2YRfiv92L8XIMDXflLQQYlLs
         4xXu6o0DST1vfP6MUq+tfioi6eYA8udXy6/TreIIjs70LcTsZQE6KNG5mowZGz3p6qiH
         3PyC1rB15PZAyQ79vhXHPSf33hpRjPg4FW+GeGlMwzDTpbTTW71BjQMbUMdBVM/OUuLB
         gM4e19XZ8Up+J+tr45ULBkjqXkAE/cilRGl4O48urEeyAiphVCl8ocC/bTkHn4vuzeet
         2mRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMYxQIKatuyJI0xPbJL9AubFe5m5c1viPETktSjiGjCOXSSekWaBeU6ZAHb+uJiRlRbJrko+6EQG3aIGF6vnqMZsHE
X-Gm-Message-State: AOJu0Yy7DLczlI4qI0SizHrxZTlVP6rek1cZuxf5aO72vl2aD3ZuwhJJ
	7ZbFMPImKcDhRwRCw5S56YwC7mt9DpZk3xQ0gD+dvCIKJtWQ7PdCyjDY8Q==
X-Google-Smtp-Source: AGHT+IFnteBbYOv4SDDZiD/gMQmNHNrs9toNhT0wb0erCxGKyOoQpeXYMMAgaCuLaAJ8w6T7jVCL7Q==
X-Received: by 2002:a05:620a:4714:b0:790:a874:161 with SMTP id af79cd13be357-7953c6bf1c3mr53207585a.2.1717707726566;
        Thu, 06 Jun 2024 14:02:06 -0700 (PDT)
Received: from [10.37.129.2] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795332df9b0sm94315585a.126.2024.06.06.14.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2024 14:02:06 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King <peff@peff.net>,
 Patrick Steinhardt <ps@pks.im>,
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
Date: Thu, 06 Jun 2024 17:02:05 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <F64F4F3A-EF82-4281-8A75-0DDC8FA65D4B@gmail.com>
In-Reply-To: <xmqq34pqlyou.fsf@gitster.g>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
 <011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
 <xmqq34pqlyou.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On 6 Jun 2024, at 14:21, Junio C Hamano wrote:

> ADMINISTRIVIA.  Check the address you place on the CC: line.  What
> we can see for this message at
>
> https://lore.kernel.org/git/011c10f488610b0a795a843bff66723477783761.17=
17694801.git.gitgitgadget@gmail.com/raw
>
> looks like this.
>
>     Cc: "Phillip Wood [ ]" <phillip.wood123@gmail.com>,
>         Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
>         "Jeff King [ ]" <peff@peff.net>,
>         "Patrick Steinhardt [ ]" <ps@pks.im>,
>         "=3D?UTF-8?Q?Jean-No=3DC3=3DABl?=3D Avila [ ]" <avila.jn@gmail.=
com>,
>         John Cai <johncai86@gmail.com>,
>         John Cai <johncai86@gmail.com>
>
> I fixed them manually, but it wasn't pleasant.  I think we saw a
> similar breakage earlier coming via GGG, but I do not recall the
> details of how to cause such breakages (iow, what to avoid repeating
> this).

oof, apologies. Didn't notice that. I'll be more mindful about the cc lin=
e.

>
> Anyway.
>
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  29 files changed, 64 insertions(+), 52 deletions(-)
>
> Wow, the blast radius of this thing is rather big.  Among these
> existing callers of refs_resolve_ref_unsafe(), how many of them
> will benefit from being able to pass a non NULL parameter at the end
> of the series, and more importantly, in the future to take advantage
> of the new feature possibly with a separate series?
>
> I am assuming that this will benefit only a selected few and the
> callers that would want to take advantage of the new feature will
> remain low.  Have you considered renaming refs_resolve_ref_unsafe()
> to a new name (say, refs_resolve_ref_unsafe_with_referent()) and
> implement the new feature (which is only triggered when the new
> parameter gets a non NULL value), make refs_resolve_ref_unsafe() a
> very thin wrapper that passes NULL to the new thing?
>
> That way, you do not have to touch those existing callers that will
> never benefit from the new capability in the future.  You won't risk
> conflicting with in flight topics semantically, either.
>
> Or will they also benefit from the new feature in the future?
>
> Offhand, I do not know how a caller like this ...
>
>> diff --git a/add-interactive.c b/add-interactive.c
>> index b5d6cd689a1..041d30cf2b3 100644
>> --- a/add-interactive.c
>> +++ b/add-interactive.c
>> @@ -533,7 +533,7 @@ static int get_modified_files(struct repository *r=
,
>>  {
>>  	struct object_id head_oid;
>>  	int is_initial =3D !refs_resolve_ref_unsafe(get_main_ref_store(the_r=
epository),
>> -						  "HEAD", RESOLVE_REF_READING,
>> +						  "HEAD", NULL, RESOLVE_REF_READING,
>>  						  &head_oid, NULL);
>>  	struct collection_status s =3D { 0 };
>>  	int i;
>
> ... would be helped.

Good point. I was sensing the same thing as I made all the callsite chang=
es so
this feedback makes it clear what we should do.

>
> Thanks.
