Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61E2459EA
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770639907; cv=pass; b=l/E0uS2yo/W7/vtNuvEIxC7kn2IlGYUeMwjkTv8YM072QRCOJxSgB7nPv7PRmragyT6OVNINSEbNeuLi6017699zYXXObLe3ZPtjcBMQUIkpybHMYNMmRM+fZxcxiXO2eW8VRHSSgriD7ln2ReACUwyLlU6bfVm15nlqDQWbQTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770639907; c=relaxed/simple;
	bh=AIgM7ft7Ok2Hj8UYyLwyCmT7uDcC1oBe33z88pa073I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOll28iNisck0Yxq3eCHj7QEatFn7hgqmDcHLC4yK0SiWGablWTiUhzzftDaID90Sv0iw7QBK6NA9jTGjy6vRlC6q5UfB73akqnBU6mTNl4X5Hoti+xsym72Fqv0Z1jb30p44Cw/GU9Lghe/Ximpcqck8UUbUW3GZCJy2Il+PgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv2WXRmQ; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv2WXRmQ"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56635de8acfso823190e0c.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 04:25:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770639905; cv=none;
        d=google.com; s=arc-20240605;
        b=OJnulXmaWlaK9/GMEdOcrnkYJzqGbwpAfpczth5nQOWu7x5aj6szfRmXWHnx1SgKD0
         zW62iGVtEIzT0Lb2B1vzjtdV1Q42m/h5cIU5sVWhPRSdMv/YZb3nbPIzBOaAPeTMrvKX
         ROOG1jF19xn1xhrqAl6mnBy8IJRxtsmAUEZ3C2PENerEF5Fgxu5xLpUdB6GKuowGGMge
         2Sz8A3c6NfpbDFPjN4XqtW4dIuEfTBpL3BlRhDkVrpXABr8Of8rAsRffUMKpoYyqak+1
         KDQME66hI9zEAjIYX6qglAAuC6IjqFn0r3dVkFRIAuX+f9vMYOrAQBmnXeMehb9Hq6xE
         aHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=u/Ajp37OQkdoTANG+/suCwFrFRUd8S2B/QWZspFFTiA=;
        fh=FhCDfeFbmycHGzY7HbKUSS8ZI4XWOfgXn11u3NYB6YQ=;
        b=COlQoxTC+ZPxs33vXyTrfFfGpDE+0s6mKPAexgg8d/Z1TN9Ck8nErKca4cTs0ijfem
         veUxNr4Xd5fV2idNL9HXHgaDcehq9X9ruLUom520Qf2MyfYZ4YIRnowF8M0OUQZVdcL+
         OTgaTtaWhayQuiTTiI/la3YHLzgq1weWJUB7nL/phHqTJP1JAcRG8Esd029iJSMcjtsj
         1b9xa/q6PjE9SSj0p/IM8qa4ifCN5rcC+OWPoQWH31Nk6v3oWZyhHjXHWLDqDO+VFspi
         ChlzpG91Aqjv4hZNugO/d2gjC9i/vIYuhKJ19du6lkrpYSuA3bLkHK/bednUzBVniOJY
         5JVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770639905; x=1771244705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u/Ajp37OQkdoTANG+/suCwFrFRUd8S2B/QWZspFFTiA=;
        b=gv2WXRmQUuT/Dv8o61IXU2wSK552vTDLQXzOxhcZSSiVXGenHqSioITJbzNF3k2ghw
         sQhax3FPTnkZk3vxMxBxy4/fXhhtgiMcCG1Y2SJWhzjsqnX97JdljW8ESCg/e77/0nHU
         wP8IHUu8VjMhVse+XcEN5SaAu7plHSl3puMWd5nE6NzS4aRZdnUALY6zRR+1MEfQRCCG
         cVHwVHY3os/uFK9c50ZMf0AlYLLShku+dN6UnZ03Qrez3WepYd9e0H/PQVBEHxH11E53
         ZEvRW0NsTOdYIZbiEdQ7qSu8OD2d7EPSC1CifCkpqWJd7P/QvKwj0G4sfrgzXVEqfuyo
         A2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770639905; x=1771244705;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/Ajp37OQkdoTANG+/suCwFrFRUd8S2B/QWZspFFTiA=;
        b=UegEiZtHZejMlSX7vt5uCt38kt6MV2HlPlp8eGWNQOode3yWBjQ6oshR3alpQBL26v
         YEeXHiOdrYHTEVEg6lhlyUmicK6/fM/cz4/jZJYLl41pDvT/y/gZPBoWJBPxoHRUcTIV
         7juCC5oihtMh8ElXa2k0N2zDoiRJZWBQwDKfpIR9uYw0gF9b2VRFlZjGtR025RdoGprX
         DDs4yW7gqKv0FMOIsdjXCB7VBvBioI5Ou3eGKFtdW1iTtkaEFbLX837Epa5h5BelxslW
         6Y4pQpSOlKnXXrbLj2QVG1rkFpg51bKWMYWcJsRxrTzN2/zmPuHMalRDwanQPGZcBwnV
         Cd3Q==
X-Gm-Message-State: AOJu0YwN+TFK/f4/z7+MXui+qY8u1q9PkLh7DmfTi6XNf7B02mi8lMpa
	91yno+CZPIyMj25G8LFYE4A80JpZpAyRG2MOJ521seT76PFWeRcCtNC7Aejm3jnbANFz0sqTVZ/
	0aNwXbn4ju1Ch9u3/MqfAx5/zfc8yhts=
X-Gm-Gg: AZuq6aKNOeBlBVQ/ts7fGoG79G1kCtf6ImG+X7/TnvNFzC/kB8w4szTX72dUURD2rj0
	262Mh3Wt+XS2GsM3Y9+Qb3XvK3LOpmcLIC3LA3h4UdD4DrQjQOL4qtdL5+1u3vUtsUeid6o/yxU
	49OJiRQllhEZ05tyVzSfd3re7v3j1MDW7dL244Vun+n/RUpK6bgD5jmeTX384LTmgnNA/eSBbUv
	A3DAyGqGZf+uowD6YzmtMu53pZq3snC0xki45E+baj+8h+Md5aAIEuiHHcAgXg5bTTcaSXJbxrS
	RaFRK7C+k21Yk3gondiMq31krIw2/A==
X-Received: by 2002:a05:6122:513:b0:566:341b:4deb with SMTP id
 71dfb90a1353d-56705fd7b36mr2507511e0c.12.1770639905594; Mon, 09 Feb 2026
 04:25:05 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 04:25:04 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 04:25:04 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aYX7sYaTp6cArMxA@pks.im>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
 <20260202-kn-alternate-ref-dir-v4-1-3b30430411e3@gmail.com> <aYX7sYaTp6cArMxA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Feb 2026 04:25:04 -0800
X-Gm-Features: AZwV_Qi_DEBaUS3q-NOL8SvDJ-nqVvM6rmL8q2nJLqWIk5yDoQGCG0dgNvPrgis
Message-ID: <CAOLa=ZSpGXd0W9-1S5r5iDrifu4eeh=YTOf+OB27TH73cZ8iog@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] refs: allow reference location in refstorage config
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000099604d064a633a26"

--00000000000099604d064a633a26
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 02, 2026 at 01:26:30PM +0100, Karthik Nayak wrote:
>> The 'extensions.refStorage' config is used to specify the reference
>> backend for a given repository. Both the 'files' and 'reftable' backends
>> utilize the $GIT_DIR as the reference folder by default in
>> `get_main_ref_store()`.
>>
>> Since the reference backends are pluggable, this means that they should
>
> s/should/could/ I guess. It's not like they are broken currently, we
> rather want more.
>

Yeah, that's fair.

>> diff --git a/repository.h b/repository.h
>> index 6063c4b846..c648dab196 100644
>> --- a/repository.h
>> +++ b/repository.h
>> @@ -150,6 +150,8 @@ struct repository {
>>
>>  	/* Repository's reference storage format, as serialized on disk. */
>>  	enum ref_storage_format ref_storage_format;
>> +	/* Reference storage information as needed for the backend. */
>
> Nit: it would be nice to document whether this only contains the
> additional data after the schema, or whether it's the whole
> "files:///dir" string.
>

Will add some more information here.

> Another nit: ideally, the step to pass through the payload to the
> backends came before this patch so that we could already make them fail
> in case they are passed a value they don't understand. Otherwise, a user
> could now pass "reftable://foobar", and the "foobar" part would be
> silently ignored without any kind of warning or error.
>
> Other than that this patch looks good to me.
>
> Patrick

That's a good point, I hadn't considered, this should be simple enough
to do, so let me put that together.

Karthik

--00000000000099604d064a633a26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 547f262d17e37114_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tSjBoNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3ZGQy80cGFjVllmZVRjcTN2clI2T1VXck9VeUN5MwpxN1BwMVRYTjUw
Q0FpOFY0UlFCRUNOaHRieVJEY2FXTjNyTG56S0dsUkIxTmdabnFtN3NVOTU4Y2xMOTlXc2Z6CkpL
QmFsVjNpVVRDaEI4N3RnRXZMSlpZQ0tYRU4yellNTDdDcTZkMEZkT2VZVEp1RGNQeVlTc21WN0wv
QzZvLzEKRXZCVGl4dm5qeU1td2FWdXJ1OExHeElIR05xL3Z3OUlFd2xucWw0K01BaERRcjBnTlhh
eVF5bjF1ZzRDUUdxZwovYngxWDMrMFE1eGw4QVpyN2RmVXRZb1lYSnNSUGJDNm9GZGx6bERTMDhP
MTJ6RkpxR0RpSXVmeTc2UE10OU1WCnMxSlVNalcvK05ZRElJbGxadDhWUGN4Q3o3S1MxeVRxYWVP
ZVFCWjZjd1UzVEJ6NkdoVDJTc3lQemx4bHVsbnAKbXZpanJGSUdJdjhDTmYrYnZIUU5hNlFkZ3Zy
VU0rcHd2Y1FWK3J4TkpWS1ROM20zSHozSmMvSUdmUnMrSGFpSQpEWDg4QjFXWUs1b0FTa0ZEMWF4
S0wrT1MydG0yY21pZVg5bmR0M2FocXpkOUp5dWZwZTlQQ08vNC8vZVg0eFdBCkdrR1ppMnhNeFJ2
bmdXZG1sMDRDOVNOZHNaditBY05oOUlKTTArOD0KPThwRU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000099604d064a633a26--
