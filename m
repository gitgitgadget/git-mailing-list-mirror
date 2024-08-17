Received: from sonic308-1.consmr.mail.bf2.yahoo.com (sonic308-1.consmr.mail.bf2.yahoo.com [74.6.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF48514600F
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723889254; cv=none; b=LY8dCBlpuIpnVcoKkQ1yY+9xNlrsM1nhJ4YSJtkDs2DF73c0ar2dKoui0AD9gtxfG6imA1lXbGH4QusCCSdS7Hxkh1bMG7qK6wvi3bDOBx8+6r7fkYVm2atCTOPoJJ3Z3vjko4/oo2cCII2mfN3HOnfvUy9KlSrl5RqKXwIZmAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723889254; c=relaxed/simple;
	bh=6O0LT2UFcvCR5cJJIPLxwtNfWn7+RRyUyfQNwiF2jQc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DN4JuZ4AFof4TfGCN2UPwWRjLYh4LhdtP7439YHcProMd//+B13O6nWQXLnFKdnRCswWF1pdtMags4oH82v7qBBQwQV/F4X9YGd9muCbWhFxJObEezUoV7jClmgobP6exSQTeNXCsz5H9fjoy5ik0DBhDRkAAuYMHLWRA12w9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PDLRoVqc; arc=none smtp.client-ip=74.6.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PDLRoVqc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723889246; bh=6O0LT2UFcvCR5cJJIPLxwtNfWn7+RRyUyfQNwiF2jQc=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=PDLRoVqcuxRz6vxE+hIRuLAF0mGdiYDS5cr9rwnw9Px82+QALziIjwm4rGb+9Z3CEmke/J3YXH/G0Yo19jhaEIY0Rlze6BCdfFEdZ8jTHgGiLbQmJAg2LL4Tsh5/nnGUO7Z0P/5A06Uqr6HoDRbg+J1gwf81kRMbwmNzQxalAlBNSHxps7xS4/oIlFhAkavXycB3FPzbR1OmjwUUdunoLsWdAjaT8MZOnugLyq/e1lqX6w8beglrvOa5agDDyqNUhMM7QKfKm5lK+F8M0Ja+OzWvGSfwWmpocUo9ShW3vdX3VoHhREx+6UA2gyUFv9xOAwovNrd8RxvRp0qu1i4tPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723889246; bh=nTlGEQVTxckPwNoWE3ovXpfZYxyf8GXx6v2UY/FtbCG=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=mwM/JavubzsxMPcH/Vo5dPXzeeMFnApHSvQC23gbF/otsRXS3J4FbDA0Di5twG1RrVajM1hOwfneLcfJBVIixtB6C4nNWit7D453ue4lt/ovdn7hUCTlsqXBpSrQIUrZN2VCjxuUdzPKyKpCRimT/W5OmtZLRqnPUMchbhyLqNf14deFxsmOX+F/RfkQjfFMsvjZ5QsgodKBPod5Eg/pI+55zcZf2sgVMiSIPXGjvxZSqCY0nmA5CdpL99cFZwJgDTLpg7LFfLd0I1El8RWMwbeQ0nL1+4c++mHgcUBFcMEEGB/t4GdwNGb0bMMbaLnudtm3xQ5V4Q3RoznLfghu5g==
X-YMail-OSG: XPAndW8VM1ldrv.iqT3sIm0yfRaglWkqzRYiu8DTHPp08XZIxpMX99rT6t01k48
 7s3aH9Up4TTYT3DVwITguQDMWJNZhe3MGVCpEXvpO5K4I4bye4ooB8t3Il_pjNXnmgW9qJ18EJ_6
 iIXvj.8shT0HHKRNCRu.Z2q341CLz9RBdE.k7h6IQl2Dps._WRlQrVs6qfph6RZaHphANYiktupu
 MYtI7mh319JCnlqoQ0TWDmCmYCJK739jFRjo4ygRR8.Om6yWJ2JSm6oAqeSA2WICTygdMsTKWbNc
 nDe2dd4.qkAdFakBvpUfLpHj5fKU0jPKKtqfSRi6Y2A6BneKDWelu6Aju3McfpCo1Xs0CBYNVfeo
 FT4CV47jfrMK_3bDwEgprFuLhZLTYqQS90TiJO.3iouW3H4XPbdXUNrGq2U9HtZ0uX4ywErTJolZ
 eAm1lDJMfE_9M0BKKTYM4zZq_bsCxtNSmaIPMUoHSY5AiC3qgpJw6Uo5blHUmaRPBdhb..pFjQUx
 LYQKGT5cSyBueztmT8HKxctm0MaWrovaKhZsKieW3vupoIDD.1E93FBeM7_D60e4YQuVfPI6BHXG
 MI_bmP6oUbCvx_BZr3SBKRgXbN5fdKQkld7zG9MYcUjBZ2aDf6k1xFQwPbQRL0r2o_iv1wL_1uRi
 x.C6I1SdEm9.KKe5lIwdQEw_J9_dZzldnzyg2L5VtoTvssHF0Q2EzQ0I_vEdXMiSX4PYDpKajh1U
 tbhxQvWPtWcm.r_cojbjx0h0hQP62Gj.y6kkh0zKU3qML3_i7Ox3yVbgxFWkZoaMVh7UFlMGp03x
 9vVnpIfeDaiZD9ttKgOLjBo754k.KVKZ5gRycjw4RNj3ENfDg3G1Pdib33pIiDvq8YuWN7k9v0OJ
 w8GRhwOFY4A5Vwxlm8hOeQM__dsJ2tYH7bnhgh4YBrI_sWtGJs.e_SpUyXfiJTsce3DhHDTtMl9k
 yLkL_R1.Y0z4v5TjtglVO0v.SS4oskXKHsI7XOkEAV6w2eyeIxmqk74NKprtmQgdu_mL5W8IbEAj
 foaH5TE15eq_7YTlatYAa6IbQI4Me3hR0MuP9829WKLH8Hhh5yjN82_S3Wl6aCJKw6krIhZhAzuH
 PTW5qeCZVBPMGPdw1Or9IVYTUcnV3bnNAHRPhDunh_xyCBZrfIaVwBvajs0rmktduBffUgD0O6dm
 19jR5RE6xEpRg1AT3pmqbbM3o78CWFTIv3qV69.PCDK97kRiY.Ga3docypvu_OYad0DkB6BE8dM.
 o8xBc52vZEtof3SNrX8pVml9_Cv793RwTBEuM9FO4L3ua6_LE31rQ7SR6v_QDtLfk6euqi8bAsP_
 Oepi1hfGZrXJ55ch_FsOC5SMuxdQorJnWjaiiGa_PMDkWsaR4FGzQKamMCBbTZfSgE.XnQ5CiRa2
 5BRxD9xrkm9fJu1x.VA32iMe28vtVXunGFCmOh6a63obD6_8hk1e6rfmLCZ7SXcw.qeE3lWAQptU
 z7YBb0HXmqXcH.yPGgpymZEMfDXzXbqDcDZIqUex1dXCH743.6GsoJxZGKAZIJnORXbLTWagVXtk
 it2f02qqRK3LuGifxDzgGKl72fL7Mypu9VKfW19LArDQaCZpSTF9.oQhMO9XvS_qCGth4NM7qWm.
 FuiVHT_cONzVzjzG8Bk8BsWuL2xzN6InFP2J5dviOINhzahSGAVSA7MVJWo98h89UClMCGWgFZ37
 zE2Cmc4SexTKhxXzqF88ycVFSjK7ESLXfg77ZBJAy4JFeDyY2x05mkInwPhVZNpLru9eaDH6fLgB
 ia3vCgLFeGP5Ru6bCVM9hZHqLUzbSNQkTKecIfwaPPuETcgU4L7wgcgcRhG4n2dUK.v3DpAVD8mQ
 xXTi0.SbFZ6IzdfKeZdmiKpeQ6PWIeFbyeL1Hu0r_zDFXJEPgB5mM4kgqy8H25Tqbp1J9sE41g_J
 N4yKJvQvrIxKn_2kfL1i2MFkslps51VhUoj8edyxgXF4qFs2XgHADXWUD5Q0pR1_PpBSaSijYjyv
 ztBqFjvRKwAIUqVlGW2Gonzhm3M3G.1AXAtFGjlzDkPd20ZoyBKDQBqPJKzsYu0XokhrKJzMZdHC
 akUSwQUDE5HcfNRIB1Y7ZobdAU70bt0OGL0B5Q5RDb3Eletr4T3ojfxtZVbU8Y3OpdoQAxPukwna
 jc6GJ2MyHAUt1eTFKi4WS6OX6tOnmx46D0Ay6qsgSrvpu915xtdhbhs0_HeO0CSRFKo0qQvgfBLe
 MaKJdn5RnNCEBjNeN_kJQeBBgxqOwjRaZnjl5YXmeLg--
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 9311e475-0b26-41f6-87e1-b754a349c605
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Sat, 17 Aug 2024 10:07:26 +0000
Date: Sat, 17 Aug 2024 10:07:06 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
	"Junio C. Hamano" <gitster@pobox.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>
Message-ID: <12028161.4698975.1723889226498@mail.yahoo.com>
In-Reply-To: <CAPig+cQVHVoDFD484dxu2gOuvzVHj9-78pyTnCo2-uy6=N5P-g@mail.gmail.com>
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com> <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com> <3a41ad889cc33a1fc0414b8f14af6438b49c88ee.1723886761.git.gitgitgadget@gmail.com> <CAPig+cQVHVoDFD484dxu2gOuvzVHj9-78pyTnCo2-uy6=N5P-g@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] git-prompt: add some missing quotes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22544 YMailNorrin

 On Saturday, August 17, 2024 at 12:38:23 PM GMT+3, Eric Sunshine <sunshine=
@sunshineco.com> wrote:
> On Sat, Aug 17, 2024 at 5:26=E2=80=AFAM Avi Halachmi (:avih) via GitGitGa=
dget
>> Listing some portability guideline here for future reference.
>
>> s/guideline/guidelines/

Right.

>> I'm leaving it to someone else to decide whether to include
>> it in the file itself, place is as a new file, or not.
>
> perhaps: s/is as/it as/

Indeed.

>> "Simple command" (POSIX term) is assignment[s] and/or command [args].
>> Examples:
>> ...
>
> This new explanation in v3 is a helpful addition.

Thanks.

>> The arguments to "local" do look like assignments, but they're not
>> the assignment part of a simple command. they're at the command part.
>
> either: s/they're/They're/
> or: s/. they're/; they're/

Indeed. Thanks for the comments.

> I doubt that any of the above extremely minor commit message botches
> is worth a reroll.

I'm not the one to judge that, but I'm OK to push as many new versions
as deemed required/preferred. For now I'm waiting for someone to say
whether I should do that or not... and if yes - when.

I was trying to wait few days for more comments on v2 (perhaps
like yours), but I noticed that v2 was already was just integrated
into "seen", so I posted v3 to address the existing comments on v2.

This is my 1st patch to "git", so still finding my feet with the
procedures.

avih

