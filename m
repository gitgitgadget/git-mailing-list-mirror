Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3F1FC7FB
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450542; cv=none; b=XOHokZlktLmpqeMpxD3Y9lpZdVLPNqvHPIZRSBL96MTMOoc2u+zOFucnlruWczPEWt9O2RS6BGUi3ZJsKjy/2TuXzG1UrOX2/R3DwhA66AJxzQPoB0N0HqIVR0Ip/KEwYpCrTLRxMEkRuFFoPHZcR5D61XbWzb6oF0w7yhZSQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450542; c=relaxed/simple;
	bh=NCsxj7OPgY0HzUBIj6nsMHjquXI6YUBtgmE7CmS/DMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2tiGgxiSW2gwt4lXAyWKFK5oN8RpOGsfhVZ5rb7F6PgzEreGvxY2CTR40WScHEUZxHsFhDVgLBOIpzZxd3d3Kfla/Q/D2duyL3tsTWx/frbFvHF4TuY1uigHeF3EMXMHqtjjTtsKCrCAtieb5y76ZpLUpj8TfxQnDNz9bj+nT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=nqqB9Jbs; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="nqqB9Jbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769450536; x=1770055336; i=l.s.r@web.de;
	bh=xZPajoHtiH4LWHtDj6Bh0OdkutC2AyUe/iaw7s22b3Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nqqB9JbsN3FQ8Rmg23wSqR4tKu1yW4iuYTnxfxmHf3ii/7ogHEt+UD5B44v9q2eY
	 pHs9kuLK0PlpBrNQeogKnuzkCyLsGsRgUdQgN03pP3y2cSUnYRzLddDmlFIUcM+DP
	 XfLMlcUMpEVOcmdS+WnNfbuvV2NZKAi9sfZuSMqMskwa21JyFrrnrg1whpEkuBKOU
	 flv6TZg6j3UZ/kdXj5RJjCGu+m2LZB9B2iSeRQPOK7aqAJPg40Ws0qxUx7ZRIVq3x
	 E7Kawfu9EbUsbxRZuT6NvjuBPvRhHARE5dCxzqOMkINjqZG1MOM7SUOOenbnFApDy
	 k74UvK8KvN0IAyQpwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9IOZ-1ve7n647wF-009i1k; Mon, 26
 Jan 2026 19:02:16 +0100
Message-ID: <add7c86f-9d5e-4136-8c3d-a04df523487b@web.de>
Date: Mon, 26 Jan 2026 19:02:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] odb: drop gaps in object info flag values
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
 <20260126-b4-pks-read-object-info-flags-v1-3-e682a003b17c@pks.im>
 <xmqqa4y0jop7.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqa4y0jop7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gv4OkHJfvKT3qvTSaLc8apaAXQ/BOYFELFjTAcBMxiXPuauu9u6
 XzrUTWnqyV2DCbZodMZRXX9M5O/0IXvkDGgr30K2Qsysd2yWhPVmq260x0IUW6uNBDUraC7
 8eEe7OfsKuJ0Isk5ZbEBCBWPaG1q9ZpxuhSnnfALNxmlffPGA2793pD1LVgWHxS8aQ+23X1
 s6zH84iFVCZHSZYoqmGUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IQduuaCpMhQ=;xdIgN2U9poWZ+GJsXSAUzVvn3AU
 s3/nUPUJXdZ4iYRTTtC/4VUio81TJehnsA6a8Ju7zMq4j4sI3cx9lkj5UeRM1VC16gIYdN6yz
 z1qJ7f9h6jssKHFCuGybNPexrgJTXO1tsXZ11keehi1uYf/KaUAB7F4QlYdiQbEJPE00zaEE6
 Fz6Wh4qcxdQkkQ7Lw8rSOtlHaHawUq5+fBaU4JgO+oQnPWk3EDMe8v5YfXNDiNhG80m+jn7XV
 OJbYsmnvoMEXI6fzqdNJ5gIThL4cwBrWVNxFehE8XUINLlizCXcnLN8qckGH+fCTPnXM3S0PJ
 bsA1ahjrUDYBBiuGmqD1YckU4y0NathXlivDr0xNb6wEYjopKJ+pWa9e8YI1dr3tOmA1gb3qS
 VIOcGlEd+5SDqnoofTwcOSe+YmD6j1JGGmCWnoeWMmLD5CVBk5oe3BAFucZ/kELVlZsK0vCoM
 rlpp7+PfUFYTCU0B7vVoJ6ee8e/Myr5oJX4AWLomGR63Mz5iInC+jMzeJu5i9IUo0og3cU6C7
 FmyG1bZHZvmHVLaa7I891QQyKqEY+Uj0Wz6GuAkvxSJJSHRKYXVAUxCcrHzbzQVa/j5j4eTYx
 ATEZlxhyl/9g+8DW4mB7tIwq1AMGniURHxQcjHDBhhZHrIU+l/kOjJDMkZRlSjCKPoe4c0hDr
 /B8BiDHMrLwSfREYJRDw1TvTzQgs3h2yuiAqVzW/OjQ5GXMQ1895mqMP1GD2DY2zVpO5d8HON
 LsHA5VdX03KiRVJyK3tDzWcziF0j4Z+2V4/gdGGV6O7NWKD71bKOOM5B9ly97UFo5CWg3eaq8
 ZLYQoACCnbWe9PNoaKzXRcE95Sz+k/3o+oJJ1+Z/uyHx3yBSfY96KPx+8W3iSQMvgQROdytvv
 K7E/egYEDLwzpyXF7QTEjFowZHJPr0grnHVl5IPPs5VOFzYs1RnNWLlDlBPNRq5Zk7kOWBYzo
 CCNoUoEBTHgV7/dOIN2865oI/qFs0npVZsFbZ9blHS8jr8Sgqvt3kiEWDibRd3zP7ZZ11/mKJ
 UO3iP54aAghy7ELIEP1KtrCanK6XWL+G/AFvPPSkshtGlj5gSFNuKktTAEHoq6BKOOFdjR3MT
 jj4nwZefBjzEveRtuiWI48OVCxT3nZ6dgNdTnSFJlOC/N7rvinh+Y6vzubyhpZ9AXZWTjnKjo
 bfQ/CBG46+rtnKbFHDX5mHaIxmEq2ZpJVZhgm4KqRGDs0IO2fctpBgoYZ4xIDJ116a2+Pvyc8
 n1absFTnJx6hbyAWKny9rpAM0TZz2NLfIOYHSi5rKd6n/9XlJCDTNrQgShSyNm5vIzsaoeV2F
 kWy56hEFRVXMcmKpR+b+9vN2liN2pwSRDSWdgHCWLIwnIzJ4GP6QJddK4JabsFVkTNMKYuXfS
 pWQPnk2bfT/Qbg13otkdHqeUDpi9AKE+rPDonnANG7RzW5jzdfc8j0uDgtBxoX7dlkliGWsiT
 2zcgzq6T+t/h572E49QcLGgQ3e7gkYgDkWcM6Q1ESIxSdxnRVAApM4xlgdWMiFvVj4vlpEKJa
 MHxyZEYebbGfnm6QbRqLBlfKtofAKvoujgOXYCjeata3lfvsKtQsoY15qbSs5ia3ZxSNWPnMd
 CWLOCviLHkX2v8xpeknrwlSatDtI7NwJ3DGP36/E7OrthreQDo0Kl8jxRgNZ2SUwuozxdUeVK
 8CoQNwEreZbK8yXPr4KGqDC7KQjNkQ76vihOy96omI0evusPDWfjFKXKrlx7Bz6RDXhcBgFor
 j+U69574K+jJvmvUfYp3XUTH5+2P++CNJbJjxFADfHGpHO2Kl0kV0FAtfF2aC5t/SiEKicpTo
 EWUJ857r5QHT8mpr823ZJwCDScMIelI8dl8njAIkTYaQNkE/rKeFPwE6RmURcEqCqLMHsQbKD
 A+XmpmWN4xgFWNBRr2c8+tDB9fndV9X0Vay0KgEHNwG2t178bDOtDunzZtF9Ihq25ESuwNYPb
 /v1If1x2WjWU1YbB2LTcu/bFAyqOvr1sztS6d35MTXfKMs+MPXTo9Oj0cVUoxsEyqYUFTw5qW
 7y+nlE+cle5C8wySqjDpXMr60NdyTsVXJ8AoYPTbkNtKe80DE1cbjdZ2ZiCM4sWzLkQllhTXq
 Kqr/c8uLgjO1pSijDbYk4T12HDfRC6QwvYjnmoCxFUBhS37aCUdha37H8WATd2pkF1KDMiSCY
 Ag96x3GzyDkhd297SnM7VRmBHy4cTy7G/+8IqxYLLjGdY2ZB4TmkZr97ILjT9ZclLrhInqlfp
 In6jcQzInSXTcqe2cwCjpWZoKrgeoKmGL4a4hxnmvqhQn1r+VAGrfr9t1mmhLZ+NRxTJoy4g7
 A9lzaLZLHiaVywmeoQFaig8EckWuNkcIDMTic3BSYEdgBJJF82w/FfKDPbT+j3i0lwg+WzNPE
 G9wv7LArsvFBQJ8BLTGW7sKIkr9/7kmgJBOk5PisSqYEhEKqT78gYqZkx/XmnVyvRaeUkDPfD
 grDz5JRD/SOdH3C58anmAFCyCOWtBtpPtGv8UB8Z6Dos/KdflMmyBDzSNax7mh4PAxJBMemfa
 k/ohxKnbzB9uKjykJ5wiPdek+vYB6YtrLxn/h4XqqF6LDc1IWM6rmhMdeQ0g0LzZ9W6x51cSB
 bY96cibeqPB64N7eRhJHbt4AaN9scBOR7/Jh9w/at3n3QWUx2+tTPysI5wfc/BafyomRxXjKL
 sIimQelUYiZqFbnbT9Lph9nu6T28WhsYf99d1cWmu3Gjhj0ZGdf0blOtT/x7LkfLVRVpgkMTX
 KqrNnZACCSJGLPILpuBxCnJr5ugbY6QRpMe170lSXf79nuQz8l2GPLdFQsP0SKHRMuvyxR3wB
 vv8IeKnSIcu3Ov3W71/3RASYHF9pAHcQKCMOO43EXR6SW6csjGHZ4JPu7XMdBT8lmlJcJQyTj
 jV2to7sPrIaqomj0+GP6L1rK5xmPLTsxIXV8zh9p28G/S1JrV0XoHmG9DyH6sqwBH2O0zsJiA
 goJa8RUsr6LI7hpMv80RCbWP3MWi5IZJKnkJZLihjIakObfjE7xzpoSrwuOzsbtY2fynIa8XC
 WOZp8b3kRQlci4xDCwOqz0N+Ts2cnRv4tsa11aN9XO1M4SGPpyn36FoLHD/839LurjFcnjlhh
 VTmxP1YHyhKXZf0OKYnOT4Nlx8Zpv1COSBUolWNDU/N6b/ebqQOmg2hjjJF1wEbBlOLwtPgE7
 1hO3w9CmCK8zKqHSC+yLgj6SRBmZy1DuB5N1B0NcOIxtV8eBTzUJHX8dVZtqQNpf2ik4BN+lo
 ra8tk1X6YK9Z6yQ3dXBFRYJ0X3FCN3qqF6lR78HRaILc3kngtnuHMDNebPpRxVQ59cpFAJfnJ
 /YGkl0a4DJMUXxAvYmHLkccCOwQ+aX1SWNM796GcVmuYg7iNS+gsQbhNKIhrUqhNir5MFY0Xv
 jOSvThZe1FijNCytZbjrtbX+NQf2+kgX2FG2FkrTmz2A+TXtGKo3rTXFkg69xUOXVe5x2K21d
 wvAlHWuEzRYrIfvnW2e+W30MohXIjkPuq+FRyGp3uXYcMEnwa6wxpikvUrtG2FkyQuzOLKvlx
 OQbCUX+lq4SKpgSkhsu1DN1huX8DOXMtPBpMwLaLiu6L/bDhdE6CnOPb9tXOsA41IDZrdmDjS
 8Pi7SesW5mXV0aF8JFelDerjlntqSPMVFRBK87GUE1S4gXNvG1xe4mwaY6UIolbyiDWUgaHGm
 RNH6+wZP7VQGBtGxnpWWDQUtgKyW4vIf6qqcyyl1JmIL9hEaVKW5DTlZDZ3fHnDHhk/llLsMv
 xyz8dit8nn+p+GVR0y+9FV99S/kDMBdEqxp79891SEXDcj5Tb1GfIalljgIg/00y4xt5Jn19A
 2qxZyYj3tSde5iqnPAAu4UuhNyjzbISNP71gekU18OQ/VuUVWfeMDD3JV2vos9tFHVw/ZFw/3
 gOgIgbrylEwbIv9hWv1tlIsGziibPxmAyDqkQ30yHsvStWIhtwT5Ezi2jUlukRB0WWirnrIK+
 2c0GbmBhUz+fs1ZvgNU0HU4y2E/HRl7RpxKIRpVberGRUIcL1m9NTArPEI2oL3LTUbJBCbsAb
 w3Y4pWDV5NUfEmqyiy06zjqTt73yxuPWkpJB9QSGaoLJYHB0wUNDiRaxQFebQfv8AifocNmb9
 Eig4Vz9KFLvW+MJqmTLWsf0GPnGfIEzfPGPrV9FinpW/r9NYqfHgW6qKnu0zf9QhePyI5WxyS
 G2kBJ3K62fGTXzzkxnybQJ2/DSDUqfxcZ6+K7YT+6EQgx8iS+ntrnTQZaWbnfP+UMkexwv6tO
 vBBs2A+E7JogT8XHQo0LBzmgJl0VlKkKcUkra1Qk/VOWgA40NuInXHgHVzVs0G1cGCpXKIFGH
 SSkqb1AV5VNJiSs4UTkTlpwl4ABUCKrxPoPxNhL+yw2aLVOHCLg+WfG1FoxL4QBLH8YPWL5XS
 69NOwjEMxpmIN5QrWE4FfLgZfVNhhROnW+sFG6J6Uylw82zPJclKkxQhP0M4yDPIlU6GxcRXy
 Cq0aiPm8w8MeDTLoCkVbve31BXIjQHEt/gsvWxX3W4V5gJj8ecesRDEknlw2OxIwpYbJOrs5M
 iC6CoLQfFoB6cKUBcCW08D5yidqHbvYzYgFYN7vzaRWKHZoQN54lCM8iBAFuGvzabLJccOcT0
 34q7Dkj6MIATRZOsbpRqA/xKR2bnqp2lywOf2G6LGPu1Q7E936faqrczV8AYCatzX4dnd/Zut
 xKiJ27B62wV/fwHVCkJ4vUoPeZ1iAiwFzj/Qo/VnHKOuFJ647duwATrsjzsPGKoP2apu5fCol
 rFpX2LCO1P27Tz/zjMGBK4dwNWS6gbK/nFYdZuUekIZP1MWVhBUPK7m3svJlD79kbQcNx3cX6
 Zh0G5L/p0WdniumZ6uuDAw53nzasFzjCchQBjwroBEAb5BeIpz2BF0p49osGSnlVQBPMo95Tp
 g5OlCHRFh/tRFUG/1FVckLUtB6wm6/3M5ATsTA4KDAMS8hufjm8Sczze6crKvY9uE9T1D862y
 0Pd/Ci8zPFjsgJaQFoQMg421lMajPtEDrWEc0undyCp0ED0fE01i6AqpbstRtDcG4W9AAQkA7
 aMidiO1jzad2VHS6mzvRtn2pNJari3pJ13/AOsXtOEo6ZiYIbNCqQuKVtpv8t+ehVqIUtXkvN
 uw/BXRPYZXvSzLwMTJCXfXkfW2i5/8XJJ2i/CYmKCCoVBqYrOZqcbVqqPdllg0GF9wSbY9blo
 olEruoa9QEK/6DpOUtldDQBJqPNZi+Bm10at4V1C13lJumO4Yxg==

On 1/26/26 5:58 PM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
>> +enum object_info_flags {
>> +	/* Invoke lookup_replace_object() on the given hash. */
>> +	OBJECT_INFO_LOOKUP_REPLACE =3D (1 << 0),
>> +
>> +	/* Do not reprepare object sources when the first lookup has failed. =
*/
>> +	OBJECT_INFO_QUICK =3D (1 << 1),
>> +
>> +	/*
>> +	 * Do not attempt to fetch the object if missing (even if fetch_is_mi=
ssing is
>> +	 * nonzero).
>> +	 */
>> +	OBJECT_INFO_SKIP_FETCH_OBJECT =3D (1 << 2),
>> +
>> +	/* Die if object corruption (not just an object being missing) was de=
tected. */
>> +	OBJECT_INFO_DIE_IF_CORRUPT =3D (1 << 3),
>> =20
>> -/* Die if object corruption (not just an object being missing) was det=
ected. */
>> -#define OBJECT_INFO_DIE_IF_CORRUPT 32
>> +	/*
>> +	 * This is meant for bulk prefetching of missing blobs in a partial
>> +	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK=
.
>> +	 */
>> +	OBJECT_INFO_FOR_PREFETCH =3D (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_=
INFO_QUICK),
>> +};
>> =20
>>  /*
>>   * Read object info from the object database and populate the `object_=
info`
>=20
> I wonder if this series can be restructured a bit to demonstrate the
> benefit of moving to enum a bit more prominently.  For example, even
> at the end of the three patches, odb_read_object_info_extended()
> still takes an "unsigned flags" parameter, but it is meant to take
> this new enum, isn't it?  If we do the "#define to enum" conversion
> (without renumbering) first, then "unsigned to enum", would it, with
> appropriate compiler warning flags, already reveal the existing bugs
> that happened to be working OK as potential problems?  And with that,
> fixes in 1/3 and 2/3 would demonstrate why #define to enum" is worth
> doing very well.  And after all that, we can renumber the enums in a
> separate and final step.
With -Wenum-conversion you can get GCC to report implicit conversions
between different enum types (like in the backfill case), but I don't
see a way to warn about conversions from int (the fsck case).

https://stackoverflow.com/questions/4669454/how-to-make-gcc-warn-about-pas=
sing-wrong-enum-to-a-function
suggests using -Wenum-compare and macros to sneak in a comparison, but
that doesn't seem to catch more than -Wenum-conversion, which doesn't
need any macros.

https://godbolt.org/z/Whvc7Mf1n

Perhaps sparse can do that?

Ren=C3=A9

