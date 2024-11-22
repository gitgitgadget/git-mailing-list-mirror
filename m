Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841A158848
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274886; cv=none; b=pp9ydVbZHswzdztyy/i6PiTIEMYKP4YabJt9dFywWeCoZRJctFJABqh1W0CQwlRji2zipTYXDx7eIDc5PRIyQU5PGL+O76eBUyaqTsjZe+RQVfgVfnkCJh3w6F/ScX2s1yLthBZUIrQKg5MC4W+Ylf+gcTF1tLu1rEYbf5qWHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274886; c=relaxed/simple;
	bh=jp7ZqCxXMEGI02XqEVumlaD3lxVskUn2YgH/QO+c+FY=;
	h=MIME-version:Content-type:Date:Message-id:Cc:To:From:Subject:
	 References:In-reply-to; b=APYE7gwoQ6pcVNXk+6SkmzQipGyWJLGJpLjxHlT/LKXkjTQ1T1qmwripi5FH5PlJnxiJaHbLm9U0qqlj3ZOxGcFY110eeE0vgEtH4dzJdCwYT9ZRIl37/U/fZ0/ygI9+kYE3Xhxq+DPQ/rzeRMyN/5tWzp6HNV1/8X7yqDAadqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=LzI4CIfq; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="LzI4CIfq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=BvYH67a/EfEJnuMXxWCfJo2ISq5OBresBdvpU+K6ZRA=;
 b=LzI4CIfq/aRXkxRDByMXK5aA3oJqDn0lOyk5YhLTq1NyJ7gg2pRmS4/DJMJImhu2YKnCzfLrl9wV
   txGjdDU/C8GPu7p8yH79kEJH6oxmNMH8IgmVcbk7oanEPJiiMDrJNf/DkE4FH9U6jp4K3xo7AYun
   cKRMVYZ2Yl683xch6IKOqEu0tUq6udqdnP0zF7U7BhBRvHhZtF2XJ8IMWeTfvXYQweAf0OJIkRjJ
   eUiMamFHA4ijOi9sKzXJacOmufIMzEAx6S3+FRwM+FNyOkJk+mkFba+i5rBUeXG+SRQlspN8LBzx
   o0DdbILORb4Gl6D1nzWmS9n9AXZe3GFTsSPQZA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC0070PNUQCDF0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 11:28:02 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 22 Nov 2024 12:27:41 +0100
Message-id: <D5SO6T9H97TG.32WME5GYFLYXM@ferdinandy.com>
Cc: <phillip.wood@dunelm.org.uk>, =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Patrick Steinhardt" <ps@pks.im>
To: "karthik nayak" <karthik.188@gmail.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v14 03/10] refs: standardize output of
 refs_read_symbolic_ref
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241121225757.3877852-4-bence@ferdinandy.com>
 <CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
In-reply-to:
 <CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
Reporting-Meta:
 AAHPmg53zA5rWzJswmd0gUM+aW2QZ5S71jt8DkyZjMJTtCE6MlFfLVcEzwuGFcay
 04gdTC0WXFhQikV0a2yZXprH+DS0/QWikdiLfoR2MG/yrB8vySpYxP6ZiY8i+qw4
 J7MQ1JQDt6aZawq/H858H1LnyRRDRaPaAtk0wyQsExJ2ttmw71b6YKUT8BSjPWaM
 SmQ0QAM/jqfb25Xnc7BovknW/D0W8k2k29ajel3zET0Tfq6ks8JN/G6uds6SdaZO
 mFfJwLObFImzzMZKvt+PSz7jSiByucC/s/QNtbt6+IzE+VJoQl/KLP4x2UyTSyk/
 kXETH12PwYFcdSzfSm5O8HfEzbjDeWAR5ktC/C8Q1xPO26yNWmdq3S0Q9d7Y/dwh
 jZIQRywNVle2/SpOI2AmslCzLwpxzRzzhxoLw57AFIPyp85XNCwfQjR42qMwbm7f
 MxuuKeihNe0JGL6E1i2CWXd3VhWazZmi176Doga8fhaZIyXb+wHFxy+U


On Fri Nov 22, 2024 at 11:37, karthik nayak <karthik.188@gmail.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
> [snip]
>
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index 38eb14d591..1809e3426a 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -830,10 +830,12 @@ static int reftable_be_read_symbolic_ref(struct re=
f_store *ref_store,
>>  		return ret;
>>
>>  	ret =3D reftable_stack_read_ref(stack, refname, &ref);
>> -	if (ret =3D=3D 0 && ref.value_type =3D=3D REFTABLE_REF_SYMREF)
>> +        if (ret)
>> +                ret =3D -1;
>> +        else if (ref.value_type =3D=3D REFTABLE_REF_SYMREF)
>>  		strbuf_addstr(referent, ref.value.symref);
>> -	else
>> -		ret =3D -1;
>> +        else
>> +                ret =3D NOT_A_SYMREF;
>>
>
> I was building my series on top of this, and noticed whitespace issues
> here. A simple way to check your series is to run:

Found it, thanks for catching, I had tabs and whitespaces mixed.=20

git log --check didn't find a problem with that though.=20

>
>>  	reftable_ref_record_release(&ref);
>>  	return ret;
>> --
>> 2.47.0.298.g52a96ec17b




--=20
bence.ferdinandy.com

