Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0777626FA6C
	for <git@vger.kernel.org>; Fri,  9 May 2025 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776335; cv=none; b=QIrPb7mG7KSY+ekv98+yY7ed2dTmFfxX3HZV1Z/Z2YLOZRHAWaZAPlOlfHCelCwrmhQA53vXddTjAQUPTfNRWSHzAetzEu2pEmtsHPvnVioI8saMorFLgbrbtHJTYaCPWo4Om47vVdmUfMT5A5zvsWJ2VXklHhawqIT1cZgYeOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776335; c=relaxed/simple;
	bh=i2M6tq9rQdHe8jeRRSi8O/ZoIKKd4KamDRYEZb1i+RI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iOVUXGPN7ErA4kIYuGp7t43PyCKwkEY/+rptpFn/KHeoF3Gli8dqqPA+pyjQqiF/D7gYAI8NkbzUgzZF3WP/6PhFE0jtezriZx2EdL1uljC5IWkErT8Dt/NWYTqhb43Z0PONhSmJBGjmzpWMXXUuuZE97F+J+6pkQxR6NSJW56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpgz10t1746776306tf23cf5c6
X-QQ-Originating-IP: E456WH+0x6gRGRRkLSmZOAg2wiTZbrCfFaiz0gB/iVM=
Received: from smtpclient.apple ( [36.152.24.174])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 May 2025 15:38:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1019446017007566406
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2] REFTABLE_REALLOC_ARRAY: remove this unsafe yet unused
 macro
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aB2l_WaBFyz5POld@pks.im>
Date: Fri, 9 May 2025 15:38:14 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <02E0C9C6-3A1A-480C-834A-BB30C3170C78@smail.nju.edu.cn>
References: <pull.1955.git.git.1746711583166.gitgitgadget@gmail.com>
 <pull.1955.v2.git.git.1746756263207.gitgitgadget@gmail.com>
 <aB2l_WaBFyz5POld@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OKKHiI6c9SH3GF3RBxO7w2wD4SLwsf1T7s2GsSsehKKVJgzhQYOkFe+w
	8/1wXpZWTQ9uuzW0CcOPt9oi+ejJJ1CjPxY+Ci4uNzmdFlKE5wm7LE9VGoO4RVhATxH1h5r
	whKUJ7b+znBwy7lPnjL11SWpJNs+KW4b2C1dZaZp0QdZTKVkoSOK/ezC19xpEmC7lqnP3oO
	+DwozNmk2vOOCfGwA+PEH8c2wD6i/M/9E9eiR56MzRJT8MH0XfumauolBH1VXUsRxHm2f3J
	DCL/3Ur3dLcWToyZin663Mwat1Ig5SKow28EnyQj56zq62DW/XI0BpjOLRzeogfEH2bQNhV
	jrf7t+J+fBJ2/HWoobmfneqHFPv5b/FV0kJGtVhQDNbF4zuhASNyvWBPuIqS/YpBWOUyhxP
	ZFP/GOpc5ZeTxzVot/ZkUDSCeNLqbJ8lLbR0jP8NiMEWxJYyipjMV8+NE1cVP5bCH92posL
	5x4E3zDiBkN4u/FLn6hayQgCNrwGY5bgVQUT1MA5F8mAw5hGQH5cnN5Uy9rvZb4AlK2yfRy
	rzBKaFYg6dx8zguGnKwo0QKIes6jJqtYKIPU2flrRCn4AI2VfSsNhwU/KNfx7RT2CoMqPhH
	s5rBv/XzQ3Ya8GoB/6Xkm7Gy1FwfI5XUdf8d8ZleN/m72/XMp1Gaqqqak0qVDULeuiiyfGg
	iU5AiudT1luP/U+0Io/6/q3HzIFy2jnoyBMZJ1rrhS0WkDFvo8X7ctrWo4EsRuogplvN61/
	8A3/uTZLL+cCtQMNwxI407RYRZJ4GmxNDYg/Imymbr953+TAopzCAggG6FHTlQzNVVJveTk
	Z2vXWSfRaEzFdjkGk8TUdy6LiXVwD1PV/ols0L5uHvUDErVmBjrJhXK598Ajyslm43g9Rdj
	pPQaJENTH/QIrS5vidpl5o2gsTDMixgTFnyZ2tjIzAUfpB5eweW3g4tScGRwC3wnRPJ+cXM
	z+ZbCpudS13tgQ7yIcHSoaZ3E/tpyriMpuoVXNC5uhFv7X7vpKrYV6LvRL0WvFQB7d2XKn9
	D8ndyWb4nuSfqbMrDX85uxdiJ5B3e8o0LqvRdZfw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B45=E6=9C=889=E6=97=A5 14:51=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, May 09, 2025 at 02:04:22AM +0000, Lidong Yan via GitGitGadget =
wrote:
>> diff --git a/reftable/basics.h b/reftable/basics.h
>> index d8888c12629..667feffd935 100644
>> --- a/reftable/basics.h
>> +++ b/reftable/basics.h
>> @@ -199,16 +199,8 @@ static inline int reftable_alloc_size(size_t =
nelem, size_t elsize, size_t *out)
>> (x) =3D reftable_malloc(alloc_size); \
>> } \
>> } while (0)
>> -#define REFTABLE_CALLOC_ARRAY(x, alloc) (x) =3D =
reftable_calloc((alloc), sizeof(*(x)))
>> -#define REFTABLE_REALLOC_ARRAY(x, alloc) do { \
>> - size_t alloc_size; \
>> - if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < 0) { =
\
>> - errno =3D ENOMEM; \
>> - (x) =3D NULL; \
>> - } else { \
>> - (x) =3D reftable_realloc((x), alloc_size); \
>> - } \
>> - } while (0)
>> +#define REFTABLE_CALLOC_ARRAY(x, alloc) \
>> + (x) =3D reftable_calloc((alloc), sizeof(*(x)))
>=20
> Let's avoid reformatting unrelated macros. But other than that I fully
> agree -- we should remove stuff that we don't use in the first place.
>=20
> Thanks!
>=20
> Patrick
>=20

Ok, I will restore REFTABLE_CALLOC_ARRAY in the next patch.=
