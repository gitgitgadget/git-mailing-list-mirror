Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B47C39CD16
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785365610; cv=pass; b=krCXbdd1svBNlPLm4IZQ1fGcIDxlKxgePUJgthrwbv27YA2Hk7tVPXW+cRb5Om345CjfAYPbY9DPvzwNQP6JvO9WJddNoX3op6VnEpO3pateh6BwjpwaU8iZW5uziSpOmeQUw+ZRzVh2av7tMeU7IcsdDlVZuzOuz/RlDm7/VuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785365610; c=relaxed/simple;
	bh=XpcI9AMiRpbJKuTG3vs+/m/zywRkDspAQ4GiCXKCM3k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MN//Uv4gUTdmeR2vnulRf0eK2a9LKu9L9MbYf758tCJvy14gFhhvZyacVwaRQ3OFUeOoPrNSz20EUNrqfvOrcrSwmjckpwEuxMjYEx7ZwePVLZlgzPojZCA1epeVT0Y9BSM+/UxImhPUTGDRAXEby+vysMDheDPILC1NT2shCZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+v3Q9zk; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+v3Q9zk"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5bfc5b77c02so1178979e0c.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785365608; cv=none;
        d=google.com; s=arc-20260327;
        b=SW+A45RpJ0h8ttBknEBRvgVow9Get2mFjzpiAoAYmusBG14clqDr6Wf0twRsv3BF3b
         eGbKALHIJ5GdNxOHzLCs/I/jf+5ACYJOFd5cuWFxHYfDHl8cIpzRH3nWZlcUi6cttWu2
         APhwPQzfl0cx46OcTdkPYrHNVLymAUveuZmKA8z6wkRqVQQ86KpNSKYMDFKAyDLfRJ7h
         5EKnY/hBLcp4uyzBPS9+XkOwAXEajw6+majiz+65Z8Mw41Vej9ogcXy6dD0M7scF+Czl
         LDb4DeLLB6DVX+KzeJVA8LEKmc4nauWsK15/45BqD0PnqFbhnE81mIjO+XFypBdlfZfv
         plWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Yt+Ptc7RsVGg00TrJYKUI21P3Uki+aornqMflhd250c=;
        fh=QGSSBcWau1DHqKuGXB2XfadJ4O3k9PAK0nrYGP3rhM8=;
        b=TSQ5weblmEKAzHBQUrEXDklyh7S3DUnm8fZ0fuEkKmvuJ/TlgFTWiylaUoFz2623Cj
         C3jHeIyhzsD3LpCBdZmCg8RghNwXbPFG4c5fTv2tW62E4UX+CHDuPqbE78IeCxDxxQWE
         /j90Grlz4pA1kSG4SyGvBXlCNh/gBFJZAPn+f7IZGdS2UvXe4Bb06KuLHv25YiZJ7BvY
         bEW59RkIluqAX7HHdS6ZPm//Aajzgpq2dgKMjnR5w3saMkwRT1XTSflYMsSXi0Vcn1BZ
         2zyR4PLoOVcbT7/TV9vqaUTPF0wyvadBGbV2qjKvxqqQb3KDM8bBDfQ/TcrrcPwHB0tU
         7ZLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785365608; x=1785970408; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yt+Ptc7RsVGg00TrJYKUI21P3Uki+aornqMflhd250c=;
        b=V+v3Q9zkvVRX/5ifrJJzwky7tnpwLNPf25dKSMmLs88ZemnFdfVCe41Te5uMuN1gKG
         QIT6avC3RfYHPiI6hAmufkAWSYeHHd8OGPMLjHtaivKWPboSzoPcGxjelH2Qfib25pc2
         dwSk0F/84fabboXyP2JSP3M+1VPWPSsOsbUngVNppB+rbRykl00YGPeqRuB683XZSHk4
         eqtBqoEkCdkOa45/drIiileokNdWabj2pasr7R14C272JQ1dkf6mmpyTsavgZXGmLeD9
         owDe1ORGwAAeAQZepXThtUuI4ldpArxnF9Y9mBwIOL2G/QF2nqRnVqiLFEtTg8bM8J5P
         pBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785365608; x=1785970408;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yt+Ptc7RsVGg00TrJYKUI21P3Uki+aornqMflhd250c=;
        b=AAFew1kqqI4ORhsk2YEH607Et77Riq3f4izr3BuJYbdKGXHKxSRtePiKFsQbxt80vT
         E9xBHiCUPecT4bHG2XjsM6/sx0Dx+HmXsfSYoy3+NINkFgswySG9yt4G63AugU3276ja
         qvSc7RV1jiF8TkqYkq73NxU/ZVOqKUQ+0B+LA+V8hKRMktU4IKXDO5QM93OSfmxeNlBA
         +QGSB11s2Zwb1R4MNH4awSrxha8ntRqrGGjOf5vLxtCcLEDGSfMtIeewVRebiJeMY984
         0MTPA0xWtl1W4H5n1SKzVJ/qTvaaLE2IFJjM4KhPP0v0RRL2uCd7seTecoqfmdf/TiO8
         q17A==
X-Forwarded-Encrypted: i=1; AHgh+Rqo5HtcFLEgyzGnkGQT/chnegekCWgRTYbITfPote423XPqR1q1ncdRi79KD/qm+8/YQN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdmSRg3zWjLp9RqXWrxp7YHustk+3tNg3Ph6qbZh2IrOZtI5Wv
	JfQirbEqhwG/OzNVXSnuO3MKHdLfuXSnvKbmCFD1LT4jogDPt4D8b5fdoM2cffU465nhGheXil2
	IgYEBDk0Kxv2/cYEnX9TXppBqb7knNv1sA4Au
X-Gm-Gg: AR+sD12uGDCFRdEe7ckoCUEQZBxPWhgmwFgUkeRRAqTJrfvD3oFBWmbHgGLhEY772iY
	Q2Nnm6km6hiuHwKfjIC84yc4ByUbzXxzJylBKzDFGuVS+LXGCQ0cdCHM8s3Bo1amwC6iFBl3+qV
	rdifNyJnBjl2bjt5znV6nQkQWOBeC0XKoEHtm+1Q9scYFTCluL9lcdPf6X58NJ0DrngR4v444XL
	a5/qB89yi8CAgLkP6fi2MAJ2MuH894sl51dYRvXOO8VgbNmDQlg4dfVIFLDEGVDBe5llezPuRHH
	EnXtQMmK1F6EBIJd9hM1vM+GhazDOCKLSVROynB9DNiO9YokjDbrzraShEKtoHiFB8NWwox57r+
	mrS2GUMiqX36bKr6MLOQXyFOwWGsHkSqkcQ==
X-Received: by 2002:a05:6102:3f52:b0:737:e816:b26f with SMTP id
 ada2fe7eead31-7574e3cf31dmr111944137.10.1785365608049; Wed, 29 Jul 2026
 15:53:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 17:53:27 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 17:53:27 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZQbf2vdYOkFBHQ2Kkk=Yc0uSZXEPy+FQPyzp9C8=sUFEQ@mail.gmail.com>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
 <20260725-objecttype-support-v1-2-2d4ca3bbabf1@gmail.com> <CAOLa=ZQbf2vdYOkFBHQ2Kkk=Yc0uSZXEPy+FQPyzp9C8=sUFEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 17:53:27 -0500
X-Gm-Features: AUfX_mw9yygq2cJ2B2E-dZ-kkAsTX_FkMm_pDIbxMSHOiP6snG_kV26QPErtI9s
Message-ID: <CAOLa=ZSdh8EeikBfTn58sNpfSQ=M2VwE5eA25c2ckQYhx6wjBQ@mail.gmail.com>
Subject: Re: [PATCH GSoC 2/5] fetch-object-info: parse type from server response
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000dcca980657c7d2b1"

--000000000000dcca980657c7d2b1
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

>> @@ -148,6 +154,10 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>>  			    object_info_values.items[0].string,
>>  			    object_info_values.items[size_index + 1].string);
>>
>> +		if (type_index >= 0)
>> +			*object_info_data[i].typep =
>> +				type_from_string(object_info_values.items[type_index + 1].string);
>> +
>
> For size, passing the value as a number makes sense, since the value
> represents the field directly.
>
> For type however, we're passing in a value, while the actual field is a
> string. We rely on `type_from_string()` to make that translation for us,
> which internatlly depends on `object_type_strings[]`. What if there is a
> mismatch between the server and the client? Shouldn't we be sending in
> the string itself?
>
>>  		string_list_clear(&object_info_values, 0);
>>  	}
>>  	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
>>
>> --
>> 2.54.0

Ah! We do send in the string itself, all good here :)

--000000000000dcca980657c7d2b1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a46d8c254a47c6e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wcWhHVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM216Qy80cDdSY2x0NDBJOGVibitqTUY1Vml4ei9xaQpEQTNvMC9BeXRk
MHhaWWRyeTVFaEtSUW1kZTZObk0yWnZMN2xuclJvclVqTUJjTFk5Sm1HaHZmbVVyTkNqMDN6CklU
eVpBcStiWERNKzZta2dXTzlEeTNxeGxEbVBUYkVXd3ZoTEtka1UwUVFObEdSQWd4dHNEeUVRdWZq
NTlIMlAKNk52TEhOSUo0dTZBODN5VUhCemJrTGE4UjhKblhSbXFvbVFra2J0OFVROXFkTW15UEFs
U0ZwWjY5bXNGMFVndgoza3ZIRkEwQWxNaGJITlVKbHB6MGhvZndnc2xsMStUNEoyTWk4eUM4bXMw
TFNYSGJ4MFhhOVkza0ZQUnJ2Z0xsCnpZYjg1bitUWUJzQUhqMkt4OEVSWWh0ZndsODRUR2lxamNi
TytMR3VpK3lEcmZ0NUg2QlpuOTN4UFcwTFRyaFgKcUtZU2pNbXhUeXRlY1FsbWNUM3cvdU9LL3do
TCtsOW9waXRRcU9FMkxvKzZ4enhvclFBeXhEeWZUMVdNR0c5bgp5VGVsRHhKK0MvVlZwZGhlRXN5
d3hweDZyL3NRNHFxUURmaFpGR2pBRHU2WGd1M1l2RXhIemdLVUpXZURoYk9kCmtCakRVTTE5Y2JE
MEd2RXNQd3JuWnNENkJWYkQ3cldKRWNZQ0RKYz0KPXR6dEsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dcca980657c7d2b1--
