Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380131B824
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578912; cv=pass; b=dTBnDCQvMVeNDRGs3hBeYfwuLexRDUIMcFC6ycV8f3D6jo/4ml0QFdyO5ytAFo0qMhgcdkSrNn9MJ4kd7+Jeopfmxyp0WnhuntHPYeu4o1VEJIAUZe8XnFPIG9mF32SFbp/gB737VGVk/v1XoFNLVdCFSrHHF4BqFo4Pb/dXhjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578912; c=relaxed/simple;
	bh=rKjdLHqAYHHPJLoeh5RtSaRUBJIkRnQ6mNwvgpDh+as=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXOccQXPC5kKnA9Y1i0902oBK4YCc2ge7br3LQxJwjeyKSS9oBL+JVoctA0RarxmicopLnC58T9svdI1BQNhv1Vl/BqW+mK7inLIqBxK1TmTVfR7b7cbgvtvuF5n8EsxdG3cm3z+857R+YJWrbjkKA0WzRxiBvIYV2n6NSCTB70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPHoUgAO; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPHoUgAO"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5fdf6ad2517so1238427137.2
        for <git@vger.kernel.org>; Fri, 20 Feb 2026 01:15:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771578910; cv=none;
        d=google.com; s=arc-20240605;
        b=CrxlQBtJPYwWrstFn86MlscZOooj49fxiii2q0UzlgvCkM0P3F+1FncXkh+AhIV2ul
         AoWdAKQIDuZhgrzDFdm1GndZXtO7SqjE9/W2NuuE6Xu3enK1wUy+xAE3hjJ+oMwQXUi2
         m95DMzqzhcXO8klksu5MxsREzeY3/hMUO+8Slw1D6Ad8Q1i1pAb6APwhv1RcnKGEcotT
         w23I5TFZO+Yy67EcdJkXm+2Ice4PXu1u80F50HPNnARhJXIsAw+SoQgKJ6j3KMOGvNWc
         80X1Efj7MIDHYZbYS6SlmVsJ3LgCUtEhUYgOCPjg4+2OejhW58Uw6otMpIWkqKMnaq+9
         Y40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Z9/J8w9sgjsVhoL/9AlCYCyIP8Ka2c9u5fdI/CNrChk=;
        fh=CKannokU/QIGCzmRFZw2adWb+7uKitSIzDQ9xD/uq9c=;
        b=ZZbdOE7GNV6hVcdJAVpBnb6kdULysWLae3NF07Yk3DEmRV+kftdZVb7u1KHxf2Z6Kk
         V3MfmP3nohaVnOOV9+0r1NNTQXAbHn6RggQKgguGMoX/FPib472aCnW03iB7JjyD5kKJ
         lxmqQAM18eD9TUt+UO+an0sjBZ/H1F6R9MrDNFjM+wHXO1uvOYjLABW2r3sSppB78IAH
         Pm3FAZ1PjUht6G9tcjOaeiGAITYwm0NC1iUQXUZChC5DXyEIEBPchnEL8wXvSbpaIezm
         xs5CpvJK9gPJdji08vr+op8vrmV5Lf2egsqOkHIe7cV7CbZAYb+u5PNOTcDS/ch+s4GH
         dD/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771578910; x=1772183710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9/J8w9sgjsVhoL/9AlCYCyIP8Ka2c9u5fdI/CNrChk=;
        b=VPHoUgAOKqU+LEwrdc5gVA3hByrx6GVomNDWv78P2NRDmGHjusu/gv0plfnjJdylhB
         e16RViTJt/ICroGI9xNtsIrcGyqKCq2q3h+f6+w6pALwuGwXzHMFZALpgd7dUJ5OUU2N
         EjnvjZm4P4js4hQkutforrKdGLwNyIROwWSf6aNmf2isw1OGT6/fwBcODrRY9u3//9lA
         0S/eXG88Ulz/Numy9RXN/3FxSLSdOuabWoaSv7CcGWLRE6peKvfgW3nrkEJp0fmrhqlm
         Bp7scyiY5QtPCLwjpfQk4Cf2GuXsAPcTcq1ZqbvgVd+Ty3arKNJMBUMKVPpUExL3ecaW
         gwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771578910; x=1772183710;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9/J8w9sgjsVhoL/9AlCYCyIP8Ka2c9u5fdI/CNrChk=;
        b=UEsYzQkCLtMOgmVzFMDjNcd0zCCqHelx1hX4ZYEzYXIyhGJse/gsYRNplyuZFBArZx
         8/bLp6z/tu8eJX5ejAFXmugC+q3jMTkTy7viSebWgcc4sezEwNUPXVM5uoBQvQChxMSP
         4yVwuhUfjXTf61rztFAhWRoUfUWACmT1YatPbEXRoFdeII4jyB9XgcebXIc6N1/8Ime7
         WnGaoOAw4CLHO2y+TBPWZb3VogEZcfxtYQw8l2Z1IoJtEp3gERo6wb7aJpABnQ83kJW5
         htojlunovHicJCD26e9TA5GADEhtKZXInMXLs5JzZgJuq8qDs5LKheYUsewDGMccXHFM
         B7Hg==
X-Gm-Message-State: AOJu0YwHD75AIwawwQHoC60YjlFz/iHGAzk1Azr4u3MzTavc5fbdR0d9
	nuzMgQb0dEi8paR5do7+w5xQnkzvC7o1Tf9bD+T9IGaTC5fO7GsQ41psjzgBKwgtNYFxC+WTwZN
	TDFlVyi6yGD5gND39gOFPKLHwqwqhBimDijsx
X-Gm-Gg: AZuq6aIkPxlBsA8GhjYG/MfK9Q1kH+GzDkDvdHXasbanxCjzcEqa4qI58xGzMWzxLOy
	me2vGgPCDLdJmrcHyQd5Sq4OLkYy4i+xmHKjvKkdp5UtithLu6CoQzeIQAd6TkpjXI9r6zG57MQ
	kK5i9d6HQjg168MD9ZPA2gLrgRob6tsy/Xja469TYIK+2vjZlaA5/tNzB3rGYssPr21mV+5NzJa
	9s0rNH+AUN474w69de8Ma27WP2mlrdfrC3pd04aPzejEtAG1oXTkLukdyyGWmytRo36svEfTrMN
	K/4Bw27HNcEilAdkobGBEYts4SwJGQeq9lohPV0Mqg==
X-Received: by 2002:a05:6102:32cd:b0:5db:efcb:72 with SMTP id
 ada2fe7eead31-5fe2ad39b83mr8700200137.6.1771578910042; Fri, 20 Feb 2026
 01:15:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 01:15:08 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Feb 2026 01:15:08 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aZct2M3sbQSduK2q@pks.im>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
 <20260219-kn-alternate-ref-dir-v7-6-16f27860dbdf@gmail.com> <aZct2M3sbQSduK2q@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Feb 2026 01:15:08 -0800
X-Gm-Features: AaiRm51KZOe8enOENgtgHEr_48c4OW8iKIdLPQEpluYOawSsLa1_abqiFcqhr7Y
Message-ID: <CAOLa=ZTKa6uvpPG7S+kkLpzey36J9zBjzV2sneFxcmzMmPyzHw@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, toon@iotcl.com, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: multipart/mixed; boundary="000000000000a01370064b3ddb51"

--000000000000a01370064b3ddb51
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

>> -test_expect_success 'URI is invalid' '
>> +# Verify that the expected files are present in the gitdir and the refsdir.
>> +# Usage: verify_files_exist <gitdir> <refdir>
>> +#   <gitdir> is the path for the gitdir.
>> +#   <refdir> is the path for the refdir.
>> +verify_files_exist() {
>> +	gitdir=$1 &&
>> +	refdir=$2 &&
>> +
>> +	# verify that the stubs were added to the $GITDIR.
>> +	cat $gitdir/refs/heads >actual &&
>> +	echo "repository uses alternate refs storage" >expect &&
>> +	test_cmp expect actual &&
>
> Tiny nit, not worth addressing on its own: we could simply `test_cmp
> expect "$gitdir/refs/heads", without the need to copy that file first.
>

Indeed. I'll make this change locally, but hold off on re-rolling for
now.

>> +	cat $gitdir/HEAD >actual &&
>> +	echo "ref: refs/heads/.invalid" >expect &&
>> +	test_cmp expect actual
>
> Same here, no need to copy the file around.
>
> Other than that I'm happy with this patch series now, thanks!
>
> Patrick

I'm also quite happy with how its turned out. Thanks for the continuous
reviews.

Karthik

--000000000000a01370064b3ddb51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e4829a120729dce5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tWUpoc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL2cvQy80N0ZQUWxROXgvV0V5Vzd3VnBTZzdDUjZFTgpKZFE0cVBlcDgx
clN6RE41TW5nWmhRdXVIOGhqbFhYR05GNFRlanZET0ttcHRScFFOL0NIRTlDVU13R0J6bEViCkxO
L1psMDJjM1JUZDlOa3ZNbDNySEc5amN5UWxDSGcxSnA5U2UzOGRDUDZ4YlpGNkVxTFVKTDNXKzU4
MW9oMGkKcTIzTWtCOFl3eDhCVS8rc2cyeU9UQ3paWFRlUjhPN1hkRXk1NVMrbTlGNWJIbTA4aFZP
aG1NOEhoWWJobHdMaApnQUltTlREYXRGQXY0VncxN1RrV1JpTWRPSEREcDdiL2VLTzNDditVZlcy
dzB1YTJCN3Z3UE1YNDg4eFZ2SWxCCmppRGtXdk5MeThnOEhqaWpUSWJ5NHJIcUUwSmtEMjEyZUlz
YlhHTHdQYndIaHV5YlNCeTVOaHRqTFdqZGZMbFUKNDFnb09mRTNQRTV4dHVNaGx2OGFCUHV6c21C
QXhSMWJZV0xKZVB2QlR3WDE2YlcyYWszOHFER2k0SWpuU0dIYQpRVHQxeWphbVEwNmpFMTJ4N1lD
RVE0RGJXZUlmN2hNZjhacEtDSmJaZmZidWVTMmRYN1lxQjlndERDWElEd3pGCkhMc3R1QUhtWklz
V0svS0dtYmhQMG42bjl4SUxPVXR2MDdpbWUzQT0KPUdhY2YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a01370064b3ddb51--
