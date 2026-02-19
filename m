Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE30EEBB
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493485; cv=pass; b=bIyHJqAwskL7CFOdo0IkPa5A3LPMRcZj1vJlLmt2/SbnLFKq0hBQgaR3MZ2AWJsx1VTPdkYbM2r/MveC6QNfHxOSRYgOX5s0xxiUM5+dOf5C7A1Wtpu5J7X3gNzTYM2o2RKMNfyGi4aFkvsmr8FdDG/Wm6lIlpolB1V0XPhhlps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493485; c=relaxed/simple;
	bh=99pZAo18tD4iXvfsAm8ogatO+lZRovHxlabZWZp3/RE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UITHpJGk0++c47opiO4WrP9Dc/l++yHQKOt7WFlUDl0f5Gf/nEeuKW6Z7SBbUh68eio7QEIqRfwfkw6LsMXh8XIZDAQiaObVC6HFyu+PYtoe6JtmIzBMPh7C/66ZcL+q7/j606rICITW8nNVUWmKIyfsl3ikZIbCTM5pO35yNWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwlZmahN; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwlZmahN"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-94d5f90c8b6so414248241.3
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 01:31:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771493483; cv=none;
        d=google.com; s=arc-20240605;
        b=YyjKbZokTObbPstID5lg6Q9Xk+2BxOKo+8qpT19fmEL9jRhtoIMyMRFrSGPVq1cp9Y
         cck7KPHK8nUeWfbmdLzUT4ZGgdGP0H0KRznRCh/32xeVOohVWuCQu9O3JUhZoZI375Et
         9AiFkE4y86CVBD1d001GZiAKSxrFX5abwGejGj/xaCQS+qv6W9g9rNMyqijiVO0XdAge
         q2pgsghmOCLrBlDcDQWZL77vy4tqL5BOOJI3yr79mGXoO567NW21JVePW7MgNNp64cO4
         zNpFs7fhGeqISzaO/EW+jpgOQI8mQwGM/JLTjY4W1g/Q3DBKjyiYhy5QvAJ94cWyGR8n
         9fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=m627VwLTPVrPKtyd1bZmzyvTru5TPSniRBMydtdFEV8=;
        fh=dxvGEqlNmVO4B5fnVYtjrQQsWipokEgBxeJVo/cTMSo=;
        b=KEHCZyRvs0gPQbXN7NXX1fVGh6ib00E+ICfkx4z5fQgyLDYBh5rFKmK+7OguYlctB0
         cZYMGirGJ9xXM5t0uYjRbCZdnGLmr1X86klcwpNUMIgfQEO7rKPY8dV0i27QV+KZB2O5
         EesyamYoHNp2WM1mECuGbO1BhXfKNmJmB85WFA8kh/PMDonens2u7iHoihLhIuejsMzn
         PfJ3ie8xaNh0ziKjtEy8Yrc4NqBWg6npVauqat1VF3YLulBDQpMCzu2VPU3XRA+M1MPG
         d8fKXUBV+xKoftHoT71/b/ywyw255yAqKFeYJETIW9qsqTHyqaA1Goa0Ukui05y0Qd8M
         AIJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771493483; x=1772098283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m627VwLTPVrPKtyd1bZmzyvTru5TPSniRBMydtdFEV8=;
        b=WwlZmahNOx8ySqnaelvg46lp/eb79Fvk+D1CdsvwhNINAt9LPVTRKss+T2zdmqFGzR
         DgVU7waTvkLOlCrxf2oCeMlPncLpU/TdtU5HJdqZ6yH0YhgIzr4AeVmyjHeOIkiQQRJc
         mEULQKAjSxXseS99yIGhaBYpEUumz7Hb018OHGCEuNWiTH1zvoWYQWr0tVQqBzMiFuWt
         BZaR2j1CW9bCdhTc3sIMPYgOemndzVd0TgwgB9fNf24CUS05iX7gkJZsDUKVpQhzcyw2
         6jbioW7B1Lmc/SDISBsdpgmycHP7+QNF7XlPB6P1NdJge0PADcqKTZfwTj/BBkZhVx8q
         TQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493483; x=1772098283;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m627VwLTPVrPKtyd1bZmzyvTru5TPSniRBMydtdFEV8=;
        b=oDI2kRTnN7OanH1mMC3Agxo1OUdwTJrwJweLl9i2JrFQwLxRx8JSTIyy2R2cmU6k26
         /W1kQLC1CQqSYzFc+YYg+1rSg+2QYaECPh/gnSp7FFcDovAB/0U7wzJ+h8fxI7u7eyuO
         LtY/+ZU5pm/i8YYVmfP2rTB4EeVSgwSfr0JvrqhM0OTTz5kFFsC5Ja25zn4K+1oYYIBa
         M6/Ba0gqWB9eTiiGGE03fZGAkbb+yfyvcdcq8mKo04HtfmmGRIyx24tWzPSBBc5vDxa6
         0zQ7vyyhW4qc7quNJ2UVJIo2oIMba2hDDYL9SCJ9YqTqBbgmcgLdwQG7fKMEAoLA6xzY
         6v6w==
X-Gm-Message-State: AOJu0YwHDI497amdEyEgQvBXLpGY1xsi4VdAQrVipX9LY3iv+VLsERZI
	VLAUKwszHAo3sSjtvqF8FQ3r46hIb43BH7nwidDgXiyEGpTihvWe8VRsIqVen7WDAOmASYZE/Pd
	gnVtianOdFBbxtA6fmFlBq5cWQWs4Wac=
X-Gm-Gg: AZuq6aLttsh7AmF7FO5+brM0mtqYQfT0LMs0V2+z8YoLDglznVcEHkfyxRKbCR2Aks5
	PLAaGwev2APFENvuWIIrNKjSwad3h6d/qghWMsNDFxfctSXMrvMH7mIT3YAlA9rEEFdJZKUSOHQ
	7aaWeRtukB0bKtYaKuAPuhHKt0zX1zX/guFwu0gd3aDxnG6c/8bGP53QOb5KnKnzdmEktfflip1
	IzOcCMwYjhkWG+W9vbR89e1WsbPUQwY39ZaKrp50WZwuq0uU0vpryWBGHk9+wvSUSOLpGPz3R/S
	kk8HRsw3oYlJwczxxw/0YGsRmSCOLrBAbhDBjJEPtDXKVL7uy7rk
X-Received: by 2002:a05:6102:3f43:b0:5f5:256d:c0cd with SMTP id
 ada2fe7eead31-5fe7fd0af22mr2626920137.34.1771493483158; Thu, 19 Feb 2026
 01:31:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Feb 2026 01:31:21 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Feb 2026 01:31:21 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87o6lmceup.fsf@iotcl.com>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-4-86a82c77cf59@gmail.com>
 <aZQXpb7RMW83eGxe@pks.im> <CAOLa=ZQwrOGpZfVtfTfPFhnkJ_qnEhv8mxO3Ot7nQXusbkJkYw@mail.gmail.com>
 <87o6lmceup.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Feb 2026 01:31:21 -0800
X-Gm-Features: AaiRm53aTDppt_mFKcNs9__MGgVc4If5RFXRFllJLR2mqaFanStwcDmk40l1oxs
Message-ID: <CAOLa=ZQqbppCi12jUdCBQAggAEPZvLz3oB0Wp6+VMv4Tb4znbw@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] refs: move out stub modification to generic layer
To: Toon Claes <toon@iotcl.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000c94414064b29f77e"

--000000000000c94414064b29f77e
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> On Sat, Feb 14, 2026 at 11:34:17PM +0100, Karthik Nayak wrote:
>>>> When creating the reftable reference backend on disk, we create stubs to
>>>> ensure that the directory can be recognized as a Git repository. This is
>>>> done by calling `refs_create_refdir_stubs()`. Move this to the generic
>>>> layer as this is needed for all backends excluding from the files
>>>> backends. In an upcoming commit, we'll also need to extend this logic to
>>>> create stubs when using alternate reference directories.
>>>>
>>>> Similarly, move the logic for deletion of stubs to the generic layer.
>>>> The files backend recursively calls the remove function of the
>>>> 'packed-backend', here skip calling the generic function since that
>>>> would try to delete stubs.
>>>
>>> Tiniest nit: it might make sense to reorder patches a bit so that the
>>> creation of `refs_create_refdir_stubs()` and this patch here sit next to
>>> each other.
>>>
>>
>> I think that would be nice, let me do that.
>
> Thanks, I was thinking the same, but I wasn't going to comment on that.
> Happy to see you've agreed on this already.
>
>>> What's missing a bit in the commit message is the motivation. What does
>>> this step enable us to do that we couldn't do before?
>>>
>>
>> I did add a line
>>
>>   In an upcoming commit, we'll also need to extend this logic to create
>>   stubs when using alternate reference directories.
>>
>> I'll expand a little on that.
>
> <3
>
>>>> diff --git a/refs.c b/refs.c
>>>> index 11d028232b..a24602c9bf 100644
>>>> --- a/refs.c
>>>> +++ b/refs.c
>>>> @@ -2190,12 +2190,59 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
>>>>  /* backend functions */
>>>>  int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *err)
>>>>  {
>>>> -	return refs->be->create_on_disk(refs, flags, err);
>>>> +	int ret = refs->be->create_on_disk(refs, flags, err);
>>>> +
>>>> +	if (!ret &&
>>>> +	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
>>>> +		struct strbuf msg = STRBUF_INIT;
>>>> +
>>>> +		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
>>>> +		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
>>>> +		strbuf_release(&msg);
>>>> +	}
>>>> +
>>>> +	return ret;
>>>>  }
>>>
>>> This makes me wonder: if we called `refs_create_refdir_stubs()` before
>>> we call `->create_on_disk()`, could we even do it for the "files"
>>> backend? Just a thought though.
>>>
>>
>> Well, there is some nuance there
>>
>> 1. 'refs/heads', 'refs/tags' is not created for linked worktrees.
>
> I'm a little bit confused what you mean here? Would it be a problem if
> it *is* created?
>

Shouldn't be a problem, but I'd rather not create something which isn't
needed.

>> 2. 'HEAD' is only created lazily, not in `create_on_disk()`.
>
> Okay, seems like a valid argument to me. You don't want to have
> `refs/HEAD` created with `ref: refs/heads/.invalid`?
>

We could override it when the actual HEAD ref is created.

>> Also the intent is totally different, the stubs are for backward
>> compatibility. So I think its better to let that logic stay within the
>> files-backend.
>
> That's mainly because you named the function like this, but it doesn't
> have to be named like that.
>

Not really... The difference being that the files backend creates these
files/folders among others since it needs it for its operation.

The other backends create the bare minimum files and folder stubs
because we need to stay backward compatible and ensure the Git folder is
still treated.

I didn't want to mix up that because we could decide to change things in
the files backend, but we can't change how the stubs are created. But I
do agree that we could potentially combine this and allow the files
backend to override it. I don't think I want to get into that in this
patch series.

>>> For symmetry it would be nice to not have an early return here, but also
>>> format the condition for this block in the same way as we have it for
>>> `ref_store_create_on_disk()`.
>>>
>>> Patrick
>>
>> Yeah sure, we can do that here, in the last commit, we'll have to modify
>> that anyway back to something like this. But it definitely would be
>> easier to review this commit. Will add.
>
> :+1:
>
> --
> Cheers,
> Toon

--000000000000c94414064b29f77e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9edf6af26e846f04_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVzJHZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK052Qy80MUdaVmZVMm8ydWt6VE5Bcm5vYWFaa2dhawpEeTNkVm1iNEps
SHlCNG13TVBqSWZKdEZGZFg4S2N3Y2FHTTU5b2J6eHJUVCtvd2dPcjAxTkd2amhUV05ISHRxCk5r
dHNaNmZuaVdFQWpVL0d3UDI0TVdjbEtoVUtiM2IxM01oVUV5bTI1aUtzNlgyVGlXOGZjWm9Xek5u
U3M0Y1gKL0Jla29iRkZOaUIvYktFNkIyK1VvQVlkUDNMTVdPbkZjZk1lekZEUklxaHJxSlRhaGo0
NXpISFhVaTBVcGc1bApVK2hoandQZ045WkdDblR1MXFRWFZWMUhuZmxGT3lYSy83bFhLM3Rxb0hv
anJtWWs5N0RLbk93WlAvZWhDODV6CkpFcHBWamhyMHQwcnVPdHNXZENzZFMxVHkyZ3pORzY2eVZR
M0RTbk9LaXI5RHl0akMzbmFGT0I1eW1nRGZwYzAKSWk1ZmtoM1RmSWhFUlBDZGF5b0puOFMwaS95
eVRreU4yVllxQVU3YlIyUHloMWVFL3IrRmFRYjB1b1lSbVZHdQp2MHNBSnJmOFc1QWpqbHRhcmtN
Yk9ZYXU1ZFhidW1TZkcraHpFZ1ltTmFQSVNlbkxFTnlqV2IzenAwOUdXdllCClcwVlRiak93QWQ3
aHhrZUFuVWdTY2tyWWxuakxHU2NXZzFlZE5RWT0KPXMzdFEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c94414064b29f77e--
