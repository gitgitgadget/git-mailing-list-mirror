Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B710A3E
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732272847; cv=none; b=CP3KohcxXe73iDFVfiw1R7MV/UO3ITPDW6BCLzSnibx3G3StxlWMd3CMy68EpK7Bw17IMhudY76/FZAE5guaCZUREg3tKJg0LecmGeUzcCB1cIT0mQyPaoWM+6m8Poe1X3jG/5oVm1CYSTjT5bh9ed3jiHBZBefnppowesG5Wgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732272847; c=relaxed/simple;
	bh=L1yekvTvtEnyr3XzatSVNW1Khd/3Z41sJBjE90Q2rXU=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=t0NCdrvKQ77I3VMcOmtpCjIE2lldSwaoP31UUHy0N2WBjWfQt7tnbCPZvqUSKE25PQUIIVPbjkToWnlnYywtre15RvUFCj9pjRuIH4RX07/xJQnQj5KrJDKpbct5uK69HuQ9I34W6uOUeKAOVL1vPc1Rrux3sUQgQQD2AQhAek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=BFcc6zdM; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="BFcc6zdM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=GcPLCLLeaflsdnzExx3y4YtvaoG8gcezQwFyK7uCmgw=;
 b=BFcc6zdMO8kRxPTivrtTwsPRDm8pNHdRn6JecGs4qs7wZ3p7n3AEeRBbfZGuzQiXZZcIx0+jx3ym
   xDnkPRWXegzQTFsMSvB68UaFUtYIQWN5WCe6KVXzfdu7y1DOUClTuluTGqPd6UxcNNdu0gf31hgk
   WkR72MCS6jtnwonj72Piztg1K/i5Zg0ndmVU8gf+aXNjTdiz7UbOOeANcfm/4DLoqhSgl1ZpyV/C
   SO80TfpfMn4XVGUT4afAPzLM4ya0f9qZFx80TOJdtI8ACW1dO/KWO7yd3SPcKpRmFtCxKzXI5e3L
   NBlYuEZWtBxK9KuCfzEmdEHwoicpKz2EPuRfTw==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC007S0MA2CDA0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 10:54:02 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 22 Nov 2024 11:53:33 +0100
Message-id: <D5SNGOK1IKRS.1TY1DL9PJ7MPF@ferdinandy.com>
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
In-reply-to:
 <CAOLa=ZS5yNpZEUqBAUpP-pSbJXk4+=XM6S6e9RY_eSVJEBhqkA@mail.gmail.com>
Reporting-Meta:
 AAH189pV3qTLFsz4H6a4MTJT+0i+50C1kH+1LjRFXlhqwjGykuhcLHEulEIori8/
 dkaLLf3ZZEh5Kb52VaU167zjsaO2s3r2EndDDxm2bbDb2Tr4gKnrJ8XD+1JtVbMJ
 ONLCkbAoqCt5NJmTewnD0BxgmnmRTe5MQFDE42ZazJx2rRKWWZKt24TEjAL1OKrf
 65buKXgNXxhv2vYL5CY9U07NEPyI5KOoWoMY1Q09tuYGIMpKkYcwl/BJaRMZDKCB
 geWhwLsNu27wr4q200GNK5mGhbB//e4CXNJyXh32ent3fBAGCLSAVhWalmqRX1tY
 3nTttP/7hDvhMfztsMpQzbRcHTDSJNIstxFYml8udfWpB+a4QKrqr+yRKko2DJun
 z1d8C64tlw1v6/Do2b5lbc2Os/YrK/5NBH2IPa3FnLEoBs/oo+DSk6ejMxytJPZ2
 nBPKrC4QUqWz4AVGAdEIHZc/FHjXRPOTaQI/RV+lEltcO2KFTdBEZoW2


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
>
>   $ git log --check --pretty=3Dformat:"---% h% s"

I ran this on v15 and it didn't produce any output. I read what --check is =
in
the manpages, although the format is a bit cryptic for me. What does that d=
o
exactly?=20

Anyhow if there was no output for v15 I should be fine, right?

>
>>  	reftable_ref_record_release(&ref);
>>  	return ret;
>> --
>> 2.47.0.298.g52a96ec17b




--=20
bence.ferdinandy.com

