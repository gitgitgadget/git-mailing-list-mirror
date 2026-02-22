Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BF62D1303
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771791163; cv=pass; b=NE7uo4Ih8ewo2yNfY5EN2oe2W0huRf0tXWIRcu7xidFZxfykcxWyrhP9Ky7vmFlGkRGhARz4R05mSXlV6k4YPhqdtRSDA/wSSDGy7eQJVEzGXAywdU/9If/G/MQz11mmpHPWxzFpn1ytBpcp8j2OFmUKvOblaXLyyKpNWWlmcUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771791163; c=relaxed/simple;
	bh=Zkcva2dcCd67MCJuPssGCd+3GDFF+f1cmLpb+PfPLFg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rijv3+jkSlmh5MPXd+OhBr/0+zqUJfCPGYONmBVlIb+7jhr1kA031IxiqjOYBfSawjI9aB1cNjVvgT/2V2CACabdkbeE7PJLrF5GcIGvgh5ymx/zy7fUYg8AqLPsJGP9eqfP4KzTsA7VRvewZalqgXFE1H3D2Q++gFtgS2519cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAE12+7K; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAE12+7K"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5faddf6db62so2425532137.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 12:12:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771791161; cv=none;
        d=google.com; s=arc-20240605;
        b=DDttpmIfDTgiIip5RbxoQBiCZDt0++bXRL2iouyKUmSlFELC3Dwt8gei+A4HKrM/C9
         qiVjIpbKAA+ujjgKwIvdERsnE931fSZIVTuZad6SrsaVMKG459GS/EQDDcnFLLsPDOuL
         jtvTRzKlQV3pxJLk5qRkXHVSYAHQV7vfaSiAFHblWyZAkHlqSPVY4I0IfoGtGoHwZy6Z
         MhrjSho/DOUKDwTB4235rGbPVzcfFiaEU24fxJ24dp41Ish6usg6RuWqKFsiSFJCYMIl
         EuEC4IOVlj8oBJqw2wto03cKdVX1m5QAUfUEmZ9erQN80/dx/MGjm22Jbfrc3IQDDJxG
         gaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=DEzvqKTaovs+mKB5BR+12DpVA2HiPz1vU7a/5K1tjt0=;
        fh=9OBZSIUZ6McRScT7CuWRdP5dwUzgf8QHVvW9sMrdrjg=;
        b=Qv5K7SbF2g7aFOljTlq7n5KRjUM931yqg3LWVOee2p03TfTKEknqMMOJZhcGnXaLtt
         dhilHGJxBajB+c2TvrX3S6NCCcO8RUFywLZZLzHiJWQO81lHeSqlI5+eybV5wUrx0CQy
         kQoaEzIUSKwRv2qEVVNmOeXKbOgDyLreblt4xvm6Ttcdu9zFvnTcYecDBd/Ad0RpUz/Y
         PNsL7fjfr4JyqZQxZT2+ffM++OitGWHv9zLRh2ELLU8Dq3Gf5A9B+Kgvt/ezXRBSmUtz
         qKEpLUdJ4WRcVNSDpVE6sT8igwMKrrIxt4XJoIhjYYdPLVdDXOPEBOlOZbkPrPmw0ypO
         kUvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771791161; x=1772395961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DEzvqKTaovs+mKB5BR+12DpVA2HiPz1vU7a/5K1tjt0=;
        b=LAE12+7KIJZPMUgAwslvPdURn06R5XYYTvQP3NTBy1bnh2TRiPXfxk528khK4hYIsm
         lrx6bqVIcABTxe5AiOG1v3703EmNdOchmNc11U/hTzo1F3Pjv4mrymQKdD4ZeSD0W+rt
         vKp82moSCUSqV+XS0pvMjPhl5skB+PHiZxg4xGTjWAd45ntNC/YD7Gq6WIpKqeK1czP9
         Xz4WIrm8zlfuDOUCmlPmDQ4X9RnQRGbwACxzEfwx4/58ERrgBv/jexwe47yUtZMy6+sQ
         JVdkNZ9gNvUa71XN4HwqFc9BxTfPaH7XkrDL4onm3zckw0ySFKsfa4b0Yufifkd7O9BE
         MEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771791161; x=1772395961;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEzvqKTaovs+mKB5BR+12DpVA2HiPz1vU7a/5K1tjt0=;
        b=iJNMNsc84p2Vm9A386/7IiHRfPRp8k1M1MVL+B4fTlUcEsLCVsiBz1ONHFoT0foYVW
         8MBqshbX+0oC0k2DF9EYOGDHoupZag+nEhYH2vqbkC540VKN6QmHueoFPbCHc38Ho7Rr
         ycz+YHCvuE3mK3i3eoJrCveGBGcgykc6Vsedg86jU/l4zskjrGPtRabSbhtafRRynp/8
         rJj91oxlDBb8VtUyTi3opLCobGshoX1wUgAFwqAN5MXGLnwTbeZKaEE7wNU+Ekn+srcv
         juMYx5gHn9/cLmtw5SS0x0VmX7wQF6M9Di8c9Fzu/fTvN1AvPMgY/iw3nVEtnA0fxd26
         YFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKZLy7AnWywdLqc8qGCdyR4wNLgGF8J+QqxzYTeOPuyH52ncGDcTzWuB6mDcYZuXwoilE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwtjf49y92ZnZUiW/XwHFsiMpCwGIeAHfcs1Sm+MWo4/G4C2yf
	qS5CYN+fa758mqU/bL9j7Rt4uKIAw0SHHzB+byI3JRDeUtkv5uf2ne/pbmRRRSZ57jLN/roqwgJ
	k1+DpNynMk9b8ufPaDJSR0/jD7HFrL+M=
X-Gm-Gg: AZuq6aKOy8i3kdtvF7aTHO7kARb269+06Ug4ePCtMsaKefmztk9y+7OUKhb14z8anIz
	k9rlJEaqV0bMkBNzmpr9HQCewMYCpGev7ls2vr5spJs+s4uUfC1ib6Fc++I14wx+0M+/4QTBmxu
	daw56TedpPqoEqKiNXNdkX4hxaqI+Sphymc6RSg1l1gueZffZqvTyvop1hkqAXX0hito/Nf0lDU
	PnV2h4wRLzzDGtAGVNieB/m/m01yQUkhllbsROe/R9aWnijpO1kR672LTlaHcWSUYT6cqLmnhoo
	a6h5oDNna8iVo297p1IVf1/J5QrK/6rpmJkzqpCsevIHOJkTJz0=
X-Received: by 2002:a05:6102:d8f:b0:5f5:884d:b78d with SMTP id
 ada2fe7eead31-5feb3046406mr3303523137.25.1771791161477; Sun, 22 Feb 2026
 12:12:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Feb 2026 12:12:40 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Feb 2026 12:12:40 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <875x7rfn1j.fsf@iotcl.com>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
 <20260219-kn-alternate-ref-dir-v7-4-16f27860dbdf@gmail.com> <875x7rfn1j.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 22 Feb 2026 12:12:40 -0800
X-Gm-Features: AaiRm50Mbd-ChxHmJKMySWptjFn2HLQZPeLuM78e-2HU5_mCPas0g5JDtTbgEpY
Message-ID: <CAOLa=ZS3smkTXERsZjiGMh5-K2t7OUpyMtRoagvwQm=Ab9VENw@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] refs: receive and use the reference storage payload
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000cbece0064b6f46f7"

--000000000000cbece0064b6f46f7
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index c7d2a6e50b..9a635f4e6c 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -666,4 +667,17 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>>  					  unsigned int initial_transaction,
>>  					  struct strbuf *err);
>>
>> +/*
>> + * Given a gitdir and the reference storage payload provided, retrieve the
>> + * 'refdir' and 'ref_common_dir'. The former is where references should be
>> + * stored for the current worktree, the latter is the common reference
>> + * directory if working with a linked worktree. If working with the main
>> + * worktree, both values will be the same.
>> + *
>> + * This is used by backends that store store files in the repository directly.
>
> s/store store/store/
>
> Also, shouldn't it be this?
>
> * This is used by backends that store references in the repository directly.
>
> --
> Cheers,
> Toon

I mean, it also stores the files themselves in the repository, but yours
is clearer, will change!

--000000000000cbece0064b6f46f7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fe91fc440f65651a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tYll6Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1FOQy85UTAxc1k1K3Y3U1JqaE9uUE5XSFdCbGtUWQpRMFNGUmxwR0Rl
OStJS2p0aVhZMlB4elBxRWJqb1hmK1dsdHQ4KzFKbUFCTzhYNktxekxQSm5hanZPU2piZjU3Ckh4
L2VPb2dKbG9ZOWU4WEVoVnJFaTdDK2hHckVkMGlDRE15aTBFa3F0UDlmbklVRy9Nb0RnTnMxT2Er
YTlDdSsKRVVzTDFzSlI1N3BTR2ZRREljNmJEUUEyajYvdVhZSnJMSGlJMUprTzBFUVFSTkNraXhv
SVZPa2xKSmwvWXMvUgpNZ3FnamVrQU82TVpYSHJJOFIza0xxL2F3YTlGcXpaQ2YyTkI2N1N6QUtn
SlYrUG92OEkvT1hoR0NUNTFXY2k0Ck1BcjZuRmdVRTZWTXFTb3FEUk5oVytWYmF3bEhtcDRBa1hK
dzdoN3VoaHNmc3hxcHVJNkFzNXl3YzkzWlJDei8KNjM5Y29GM3FLaC9xQ2RLV2pMWDBtYktFeits
d3hER2dDeXN1Uk5DWFBEL0tQQkZ1OGJIUWQwTFRpVFdUM1hobApJMEJhVGtndDBtZnlZK1AwZFlm
UGUxWFFqQWJ4YXJLbm5rcDdha2NZTHcrZFBZdmZ2VEFyZlkwR3cvSFJKRysrCjhaVHM0Wkh0czMx
NURiNHRmYmJIMDBjYWs5WGNlaU9kSm5BVzZCQT0KPVVDekkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cbece0064b6f46f7--
