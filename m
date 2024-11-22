Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A810A3E
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732272958; cv=none; b=uvBAOFvfKUjA9l6BcTPaQGBnL6oANfcmA0rDWSQZHPuFYOTJjoX70vE3M1w3nuelLGNfIsurCRFVeLOC1bO3wMt1LARzzQJOljVhptz3PajA3UUE+4XAfgmR2maG5WJrDSHLTiSQ7AncdeR8KMdgGyVVnl/H4awg06mTOYq9M5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732272958; c=relaxed/simple;
	bh=NcAC5OS6SNHCdWBxB8qqzVheUC4Yx0CXRkDkUyLuptE=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=lZYBJFp/J+f03uo3ZS9ZzFPGl7LVTdynSW+oWRtSNTAdPQiCVOMgkGz/boniPoSZPHyrO7CLkWbwJ3QBQndrKPvTuXHQdCuHB8bYQAJbggG7WfWqjbgsuHU6WPVGH1JCWjW1cdbswwIf0KMMHJ3hD/wXx+Lm+B60nd9O1QsN4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=IRT4fv4k; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="IRT4fv4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=EUv6iSYc95pzEkN9BnYeuEHMz8DHmnlIB2Dt/r0DIAw=;
 b=IRT4fv4kt5riK9MLLMMAkbN/lwxUeet0lVrm7+dG4NqYqdCpPMx3XF9xfvjAK2OdbyRRXnxzkmcl
   +ZBtMlFGxlGZjcO3iAR9Hc78fiEhrJ+/bukVUvI6QLedtTwUCRGYG1E26LOBb1OLWNoCufti6/NZ
   XYtPDACKAIAlHoicRwDs7AuMEuHaqZTbbuKzt7AOqb7LIz3J08M7wGj8a46VvsoiMf7XiKif9BKK
   IZ/d+BJpZ9FfE3rEpKZXxspbGeaeEHE4PjWFQE6DDwRELKdik5kYZuTkYmaotmarLbnVdUbh4uKP
   erf+Il6mudgGGqNy7y0JmZMbjfRI/5Xg1l8WJQ==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC00H35MD6DHC0@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 10:55:54 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 22 Nov 2024 11:55:29 +0100
Message-id: <D5SNI5WC9IB5.10RIQJ256K4DS@ferdinandy.com>
Subject: Re: [PATCH v14 03/10] refs: standardize output of
 refs_read_symbolic_ref
Cc: <phillip.wood@dunelm.org.uk>, =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Patrick Steinhardt" <ps@pks.im>
To: "karthik nayak" <karthik.188@gmail.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241121225757.3877852-4-bence@ferdinandy.com>
 <CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
 <D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
In-reply-to: <D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
Reporting-Meta:
 AAH189pV3qTLFsz4H6a4MTJT+0i+50C1kH+1LjRFXlhqwjGykuhcLHEulEIori8/
 dkaLLf3ZZEh5Kb52VaWI67zjsaO2s3r2Enec4wSPWuRLMpOepl31t9QV6TqrEMEi
 QZUuO3d1Yn1/Wlf2N7PDdm1xY+JWQqiAfeH6jcOc97wbvfNmDq7tysJPQu4o+uoX
 SmYPjQFDgya4bmu1idUpGKY9BhIvgzdm37CePez3L4nR8j+LM1ICD4iCKmFrkee2
 3Rn7ZAfGxPi24I4XMHeUhAFXM1wZUxi5Y/7s+DNEMtttYeKxDIu628/zlWPQCGhK
 C2AzWSPwz6tFUnRvf0Yj4PxqCSW579+g79jUzrBj4XfYQfIGfy0HgtD0gGGcIK4N
 qWEHn6TdQleNnrWcHZLlg1BaUh3fT0h5L6IN2ZUKF1R9VkD5GpX5UaZ3XAbYiLpm
 ns3UlBanxYrNp62lv6M9DLUJMYWbKag6tPqYvFxpALcCmWM8YWN6cd81


On Fri Nov 22, 2024 at 11:53, Bence Ferdinandy <bence@ferdinandy.com> wrote=
:
>
> On Fri Nov 22, 2024 at 11:37, karthik nayak <karthik.188@gmail.com> wrote=
:
>> Bence Ferdinandy <bence@ferdinandy.com> writes:
>>
>> [snip]
>>
>>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>>> index 38eb14d591..1809e3426a 100644
>>> --- a/refs/reftable-backend.c
>>> +++ b/refs/reftable-backend.c
>>> @@ -830,10 +830,12 @@ static int reftable_be_read_symbolic_ref(struct r=
ef_store *ref_store,
>>>  		return ret;
>>>
>>>  	ret =3D reftable_stack_read_ref(stack, refname, &ref);
>>> -	if (ret =3D=3D 0 && ref.value_type =3D=3D REFTABLE_REF_SYMREF)
>>> +        if (ret)
>>> +                ret =3D -1;
>>> +        else if (ref.value_type =3D=3D REFTABLE_REF_SYMREF)
>>>  		strbuf_addstr(referent, ref.value.symref);
>>> -	else
>>> -		ret =3D -1;
>>> +        else
>>> +                ret =3D NOT_A_SYMREF;
>>>
>>
>> I was building my series on top of this, and noticed whitespace issues
>> here. A simple way to check your series is to run:
>>
>>   $ git log --check --pretty=3Dformat:"---% h% s"
>
> I ran this on v15 and it didn't produce any output. I read what --check i=
s in
> the manpages, although the format is a bit cryptic for me. What does that=
 do
> exactly?=20
>
> Anyhow if there was no output for v15 I should be fine, right?

But then again: this patch is exactly like v14 so I'm not so sure about tha=
t ...



--=20
bence.ferdinandy.com

