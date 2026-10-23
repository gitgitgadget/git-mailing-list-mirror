Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792792863;
	b=x/KHWNK2vzZhK8hJpYbmBgy7WATHoSq+bjkcVPYSs2RLcawBab7aFFblekDh/izyukt3
	 BMIkArAfCEcSxZN21R3kwOQ5je+qlouFhHNJIEZzplWUKwG/DSoEaHFFmHkBxl3tNuk5J
	 /UdrcWhpmwEkpz+4yRJKaNdeiEXVVlLIZOw/rW5Iv+CFGn4UCjdMBjwKIZlXpK6CXZYLG
	 EAonTrTIpDFtEyKaWEcJfMtlpHocMDO51FdZ/YXa8y4xKYYvXMylDq1VY47Px0tL/24o3
	 aiaTgSZtLsPGSjQ+a/Y+Og/2d99BY8dTmevojRYJtbZHujehtcle+O8y/+Yz2i55n0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=nJKFbePSGa4fQ6NwrTBWGus5t4ITARCxF21aOQEMChQ=;
	b=jXcLPOMbdZS9g/efLoeLrfJAMk4BlAj/CfD536g+eLsNury0OVe3WTdbs/ql6+NQe4Kl
	 c11NaciHUVQeYdSU22CjFMLeHQ36pjFg/vRmN6VdtPp69A8g9dB1WcReSxZjwmuiqrpf0
	 qK+2Tt9o1o7+PIxntL9qh316bYzlBNhxjMKMmYkRILBOw41AGKo2+RXkJfl3f6Aj0Iro1
	 LSpVqofX6hG/dLn+4vEliQobRq4BPmWVvw5bGzWkCfOJykTfZ7/cNbVcnCyxbttIc/C6L
	 vIaZ4lpJyBnbuA5GeGwia+ZxYh6J0FhDj5u5eujkfOUqQoCBvS5Br9N0LTiZeQc2DNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dvV4x2Qz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CD7606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 22:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14CD7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dvV4x2Qz
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7cb3388613fso922532137.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792792862; cv=none;
        d=google.com; s=arc-20260327;
        b=BR2leLFjJ0WHq035hf8LhQqpllmNCuae4X+Ebm0Ope5MnnY+fmdw53l5tUP1+0kagB
         qheaiau3URdTDtYZpFS7IaTN4bGNrj2mfQZklGO0uxeIvTt0A8Ct6WxAVQuwF1gfIE33
         FqADD9MRjZtsKOMtIS8CAXcbrvyMdgupHt7SC5BVi2T2WbR/LT05/zq/b62f69iQot7+
         AnfHEynu0aBTT15OKd2+GVX2PCwFe/F5kPhKBmDy56HkPCOjcrFr4O/D3jaqcLmTZcNy
         adm1kt4h4XNq2o+X1UpmHmx7K9Gjhq3JiEtSUsI3TuasmRGG8fivDV2Y6TYHMLGZdJM4
         YQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=nJKFbePSGa4fQ6NwrTBWGus5t4ITARCxF21aOQEMChQ=;
        fh=Zi/PcTgeFwYOrOH0Qb2thAOIbcPUsmyXqoBq6d0qCxE=;
        b=JFYaLZ1dgXQhOOgnW0Cxd72JFMbuNcCCsFioWRzHlPIpZ3qI/vkSA8XdUfAeQGUuQ5
         +KbNCy72fRCruxquUIjO/M9VX8/cazWZw3vPMPMRsVGla2Mbl5FKnsYSS4gQ5g6v9eMK
         yFhhsmIkRqe6Rdj6TwJH/j/krGtbgmWwijgvkVvMPFjuMq9xlHe6OwzKlFTikAFl8tdl
         VV5xjqbluE7Ipy7MbiFrf9WZG0AYNOVcd+0BPDe7LfjVdDX/wX8XzHjgGoJgt7phFP3B
         a6ezKi5uke5GoffxE7yDjx9fD44SlIGQehD57dFUQOIjfev4FNW/sC+r3uCQtNlb2UtN
         2Xfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792792862; x=1793397662; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nJKFbePSGa4fQ6NwrTBWGus5t4ITARCxF21aOQEMChQ=;
        b=dvV4x2Qzg3OoiQELz59+ZrYAqHkVKjUG2udzZRPFsQWB6v2L2lPu6r25jJYXGbDN2N
         JWdydLzJH5oae6rKl9kyyBWQtfw3TRo8dp0vluf+fE5JSUFb5QlwdKF4+G0HFGM3nK6w
         JYoQJEDglolynKe6nZs0D3IjOQEgMWl4lqic2lvb5/E06aW2lI3zNQVjMEK4PwGC3Gly
         CLJb4HojwAqC3idzG92J6Izd/NQ+OyVXk07xVPpwjBT9vtusl4/c9fZJKRtqG/DopPGy
         2BujfAMM6xSsabTLeitTNl5OandJ7lim0G0UTOF0IocFYVviYkjIwrq6Y57t5U+tGTFm
         1eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792862; x=1793397662;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJKFbePSGa4fQ6NwrTBWGus5t4ITARCxF21aOQEMChQ=;
        b=hLObjiI+S0n26FBGoKmB+jo//QN4nHm5Qu9DEgrSR0tBqSBE5SfktKSRZH9VNnMm3T
         PnCBSPUgV8iYgo2+Zn/YRKuqPFSj0efJge3K+nddhOGemjY9fcZm4/syCtH5bwqiOW4v
         FNBcfYcmhRsKz0figVD0/W2ICFfHIm/IMtle4B1fQUf78pZ6HRIZtmlNKG2eDi37KR+2
         A+MRFErlgoZR3jCIeJF89qJg/KkEnwQvumCTyD3BMiSUhMaBqa79ZcEf3QgZ/jVAHbJc
         7qyX3s4USeuGE3jMf1TkJHHGHpiO9WkVhWf/01fYHD41sLJVmpsf4PUBO06lJX5oWEoP
         6ABA==
X-Gm-Message-State: AFq9FYJZKDzIlLQRvsKAdG96+pJLLJ0rpK4xVUxoTUpzcfjkwhS96w5X
	dymGCJu0g0MqXHQptDcjg8nc5PGMtAqyut8w0x8k++wBob1B2Vago3TyhlrDxd+bDN+cORnw7af
	0xb7MoqSuRYeX40eVbwatNIfrhV+pldM=
X-Gm-Gg: AYBFou0jFRXrut1kMY2lSa+VJxskyPY6S9K5FX70XSNgyst/yzfGJrmLgy1dvp3FSmi
	e2XdSwVi4POlw3F+YIWby6gVBblSRnOeXtXmoNzZ0lNBM/sFQ22skgiCunPQ5GWbuanbDCV+w/N
	YCLL5o4nzFYwVxhUexew0Xs/og6TTCN8yYcR1P59VhWiqQ/o9qWZfCFDX/PdfpLMpzprUbaCDnG
	XQGxSWs/5224me5IYOyR65lZ+9y0B05d3lot36+C42QTcgxr0b43F1JPHSVMjafWidADlbCkV8j
	YxnROLPyJMpMgUIbEQ+etOXGPMISKO24ImmFmOfg/SUvZ6nyW1TPvFYdDdsPMt1X+hHCOe/cWvy
	kuizUAGW3Ipz33jwxHDuTFPdveqiZ1TKlRXH81zsXVVve6xotddpK82T4rX3mR83iSMjxknkuwO
	mAvMZs5SLNsA5YMnZTsSBFQrHfX6xUwdHFFmiJHyTZ8ScL4Q==
X-Received: by 2002:a05:6102:5708:b0:7b2:f3ff:6b34 with SMTP id
 ada2fe7eead31-7ce5ca75b82mr226592137.1.1792792861975; Fri, 23 Oct 2026
 15:01:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 15:01:01 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 15:01:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <attMR_XBdfkO3SHx@pks.im>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261022-799-shallow-fetch-with-tags-v4-1-8a1c9ef399ed@gmail.com>
 <atsBbPi_EuhRdNmo@pks.im> <CAOLa=ZTe6zeapUBwF2cS=w_gDQzm08RJkezD-jm9aV=7j1u6KA@mail.gmail.com>
 <attMR_XBdfkO3SHx@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 23 Oct 2026 15:01:01 -0700
X-Gm-Features: AclHuK_mcW0S85CtVs-DP5yyUMFGccwLdYn2O_-zazEwo5Pl93XfkDAo4L9l9AY
Message-ID: <CAOLa=ZSnhGwBevejqv1Nzw92q6tt6zMDM528qFb7xqY1-6mxrg@mail.gmail.com>
Subject: Re: [PATCH v4] fetch: advertise fetched refs when backfilling tags
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	=?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000b1c434065e891df5"

--000000000000b1c434065e891df5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 23, 2026 at 03:58:11AM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > on thu, oct 22, 2026 at 11:00:16pm +0200, karthik nayak wrote:
>> >> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> >> index b2decc6cfd..9867e8c2ef 100644
>> >> --- a/builtin/fetch.c
>> >> +++ b/builtin/fetch.c
>> >> @@ -1697,9 +1699,30 @@ static int backfill_tags(struct display_state *display_state,
>> >>  	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
>> >>  	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>> >>  	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
>> >> +
>> >> +	/*
>> >> +	 * References fetched before the tag backfill aren't yet committed
>> >> +	 * to disk, so negotiation cannot discover them. Advertise them to
>> >> +	 * the server, so that it does not re-send objects we already have.
>> >> +	 */
>> >> +	if (fetched_tips && fetched_tips->nr && transport->smart_options) {
>> >> +		struct oid_array **include_tips =
>> >> +			&transport->smart_options->negotiation_include_tips;
>> >> +		if (!*include_tips)
>> >> +			*include_tips = to_free = xcalloc(1, sizeof(**include_tips));
>> >> +		for (size_t i = 0; i < fetched_tips->nr; i++)
>> >> +			oid_array_append(*include_tips, &fetched_tips->oid[i]);
>> >> +	}
>> >
>> > Curious. Why don't we have `struct oid_array` as a local variable and
>> > then simply `transport->smart_options->negotiation_include_tips =
>> > &extra_tips`?
>> >
>>
>> Because `transport->smart_options->negotiation_include_tips` may already
>> be set when this function is called, so we only free it when we are the
>> exclusive setters of the field.
>
> Ah, okay. But if it was set already, what does it contain? And is it
> okay that we essentially leak the fetched tips to our callers now if it
> was set?
>
> Patrick

So it is set when the user uses the '--negotiation-include' option and
provides their own tips.

When I wrote this code, I didn't include the free'ing that you see here.
But it triggered the leak sanitizer for 't5509-fetch-push-namespaces'. I
assumed it was due to my code and added this logic, without digging too
much into why my path specifically triggered it.

So, the transport does free the `negotiation_include_tips`, but only for
transports which supports smart_options. Meaning, we should only add the
tips for transports with smart options. As the other route doesn't use
it and as such doesn't free the array.

Thanks for the pushback, I'll fix it up in the next version.

--000000000000b1c434065e891df5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 74d97527d57a48be_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yYjJSc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmVMQy8wVGFOcWQ4eUU4bGpENXR0M0IvWENLWXBXSgpZZXJ1L3pxZ0di
TDZIa05VTXdrRk5XYUlFemlpcDQ2S2RWVGtKRWVGUytyaGFydVJtOGcrNUVqd0Q2Nm5FTFE1Cnc2
c0h3NTFpMHE2NHNMK0pzSWF1S2ZBcENoUUE1aXVqWW1LT01TOFZHeG5lM0l3MkxTd2RvODlMYWdU
ZnVnM3gKYW1vVTdwK2E0Y3dPaFpTbmdmVmFSeCtWOTlCYlErU1RHNEJVWmV1UWpDaDFRQ0kyL0o5
aHJ3eTl1NXFlcG5xUQpNS3pnK1V6bW1SWnpDMGlIc1poU3YvQUI3OEZCczlQbWdHSklmNjJYRTZy
V0szM0tpd0QvZ0svK09OTkdwdkwrClpYSWVESFVQSTdVVCtsL0g0aktlZjV0WHlsaEJ2Q2lkdnlC
Qzdic2FjTFl0NnhqSnczQVR0MmM5NHNsUUFJSkIKaGg1NUZnYTZUVnZ1TS9UT3hpY1JYbGlPczhh
blJmQjJGTS93V3dZeHBSajdIWFFKMTdOTnJuL0t0b1VENUZvNgplazNUZnhYcmNJMHM1ZE5CVmsw
OTg3ZGFWR3dReUtTckVwTGI5WVVXTTU5ejgxcDIzUjZIVk1Zck9UWjNWS3hqCnErWUMzVlpYdEcv
clhleS9LbXlnckdSRGVKK2FrNE8yMmdoWW5aZz0KPXI2OGMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b1c434065e891df5--
