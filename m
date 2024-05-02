Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF61C2AF
	for <git@vger.kernel.org>; Thu,  2 May 2024 05:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714627969; cv=none; b=ZhprbrdUjPZwhHwNx88YZFfw+2QA0qpwlJXQUAYAH80eg5LFN8ouH2X+PsNrokCZ33hPuMmroaOaWvOJR5zB/MEXYznmxYaDIU/ppNDcGmfRkuyq7NwTYgKcDfzUlrmWK8NZmh8WNcATA/qYB7+hnUa1zYAo2qGu/SCsPHILiAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714627969; c=relaxed/simple;
	bh=JvSw0KlRhUF4XzehICOtyn4tW1HayQEz9o0dSW4KwGU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVsMIA8fIMHw4d4ZAGAzN7DXOEUUa+5YXog920wmxaxrEf7HvzR2uD5S2uCwnBhLZXtTZbgiI5FGXLuAN7PjJOb/QmDrXDjNKNZjpJRilCZsfCJWhD41Gm+nqttiSoK0gyHXiynqR1w1yMwUu90Ig5Oybu5sKbnA/JNM1pZ3LIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLv4pZYC; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLv4pZYC"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ee266e2999so2392053a34.2
        for <git@vger.kernel.org>; Wed, 01 May 2024 22:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714627967; x=1715232767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICP+4mSsPqaF48Bn+JKXgQl0TDoffcN9OUMHunRLBvc=;
        b=FLv4pZYCTRP3KzWwhoTA4wkjHpqQ5z5ondmtfdcHCOwBokX1NjnWKWaAVXCmNIJfsW
         X56I8ohh22QAoEPTDbReJk6LQwUFdVXekeozzudj8VzvR7O2mUNOMM6l99kHfspWp+e5
         n7YBqNB9+yuTpj6Zl/HzCUX374PfnpwmlLOi8/DR2dWgwKJXmLvRVfYTW0j4gDdP7JY4
         SA1jtalPLsUm+dhWWOxBDtnFIS9Z50IIn9hA4JsHvzcVwqdOE93IrgAc0rpqq8H7PCH+
         zNS+BDV4PsdvXMO2bNszOIWbmUQp+ZoQJlFeoM/W7q6j+mxfbRcfe7Kf1TyJb6gW4Kdq
         kL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714627967; x=1715232767;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICP+4mSsPqaF48Bn+JKXgQl0TDoffcN9OUMHunRLBvc=;
        b=NPVxfza4HjuLtT/ocXu4eXiAridYBkvxkVyYAd0uPoCyFhx13Rc6dvX7ZiLHbWhkOb
         HY+miYumdcevq6gXcmt+Px6wl5DXlE7Ab1XXYm9KlB2OfjQBA2udDTEVkdUnam/reT8D
         gC0VU2cl1DK3u/Dx/UbDYxYsXK+sffatW0O7xNqOukAHT5TrFQctIeQuE+qhTURIxeS1
         A6M2Sdyo/xYuqVapXItz8njLoLN17ILqvD3SmZffRrnNzgGwhAsVrF7w3rpEMMkrN7Ll
         tfBHaqOB9nvX5hnIxoZxKyK5MZGF0/KKITqUi1zzs44i0SDUuCwV5WaNiWvvZ2gwhI+B
         8CGA==
X-Forwarded-Encrypted: i=1; AJvYcCVsjHd3zXtguc9EuEZ5h7+OnbFdvVSb5UOPDDPSkyUT/mSlQMh7UG0S68mMX6V1gYOvBs3uPB6in3FxxVRK61eTLgfM
X-Gm-Message-State: AOJu0YzrdeWFXpMJT5JudnXTzvWsfj3Xgv/B+SDLEZoDh5bzuiM9BnNb
	w5IgHX/ekjIXvdPoNKI9z8vL+E2tHBRupL6FWyHYnSoDsEaMS4+EZVjOCmymgZnX1kFrdzE+CaU
	WPepA1YnTQeZRQu3ic/0cxCAbLhE=
X-Google-Smtp-Source: AGHT+IF/5e0EeVX+AArvGxgrOejPqGIG1HwmbecqhIzd8IqMjy+mWwhfeC+8zCeo8YuK6upwo+vUHBbD/7UgCGlPtTc=
X-Received: by 2002:a05:6870:7192:b0:23d:21c:6dd6 with SMTP id
 d18-20020a056870719200b0023d021c6dd6mr4542040oah.37.1714627967183; Wed, 01
 May 2024 22:32:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 May 2024 22:32:46 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy18tgmkl.fsf@gitster.g>
References: <20240426152449.228860-1-knayak@gitlab.com> <20240501202229.2695774-1-knayak@gitlab.com>
 <20240501202229.2695774-4-knayak@gitlab.com> <xmqqy18tgmkl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 1 May 2024 22:32:46 -0700
Message-ID: <CAOLa=ZQrjYRq14KYsGASD+ua5fNNQCjnO0JbL4W7RTbXc1veJg@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] refs: support symrefs in 'reference-transaction' hook
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000e80910061771ee47"

--000000000000e80910061771ee47
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +		if (update->flags & REF_HAVE_OLD && update->old_target)
>
> Although the precedence rule does not require it,
>
> 		if ((update->flags & REF_HAVE_OLD) && update_old_target)
>
> is probably easier to read.
>

Will add.

>> +			strbuf_addf(&buf, "ref:%s ", update->old_target);
>> +		else
>> +			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));
>
> So the promise this code assumes is that .old_target member is
> non-NULL if and only if the ref originally is a symbolic ref?
>

Yes, for old_target this is correct. new_target could be set for a ref
to convert it to a symbolic ref.

> And if the "we do not care what the original value is, whether it is
> a normal ref or a symbolic one" case, .old_oid would be all '\0' and
> REF_HAVE_OLD bit is not set?
>

Yup that's accurate.

> If we can write it like so:
>
> 	if (!(update->flags & REF_HAVE_OLD))
> 		strbuf_addf(&buf, "%s ", oid_to_hex(null_oid()));
> 	else if (update->old_target)
> 		strbuf_addf(&buf, "ref:%s ", update->old_target);
> 	else
> 		strbuf_addf(&buf, "ref:%s ", oid_to_hex(update->old_oid));
>
> it may make the intent of the code a lot more clear.  If we are
> operating in "!HAVE_OLD" mode, we show 0{40}.  Otherwise, old_target
> is non-NULL when the thing is symbolic, and if old_target is NULL,
> it is not symbolic and has its own value.
>
> The same comment applies to the other side.
>

I see how it makes it clearer, but I think the intent with the existing
code was clear too. I'll add this change to my local for the next
version.

>> +		if (update->flags & REF_HAVE_NEW && update->new_target)
>> +			strbuf_addf(&buf, "ref:%s ", update->new_target);
>> +		else
>> +			strbuf_addf(&buf, "%s ", oid_to_hex(&update->new_oid));
>
>
>> +		strbuf_addf(&buf, "%s\n", update->refname);
>>
>>  		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
>>  			if (errno != EPIPE) {

--000000000000e80910061771ee47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3a8a85b4a46b6eb3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZekpYd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNm9IQy85a2U5U2taUzc0YTNvOWN4eHkvYUxxWitTOAp6bGtIU3EyWit3
RldRd0JvbUwvOGxNTjE5OUtBUXdEa3Jic2VReitqUEg4TytoVExSLzlmNG5aT3hIQUpCUnZvCktw
Y2hjMXhHeENaRGp1cXBBSGR6V2g4NTBzQ2NudktNYlNRbWVwZ0hRVGsydm56MThWQmFhYUNlbWtS
REVIcjMKQmgrYlIyZ3dlYU01NE4rUGkybkJ5OHJmejcyZm10QjBIZENla1FFSWFadWpVaFVpS1k3
eVdnVFVPWHViZ0RIVQpHU2pFVFJYTlg1OHh0MFRXZFpoMnY0UU9QYzBBSzE1SUNqV2EvNUxHNnpV
VkhuNGFLeU5TNHpsWUc2dkJLeGFHClV3U0t6ZnQxZmV3QlV4ek5JWFFxV0NLcVozMDl3dDhsRmVk
UkNmTEE4WFJyRmJUaG5kZEJVQnR4MGFxL0p5bE4KT3RDWmlGUzlHYkxOTW55RDZTekdnK0pVZ1pK
NW5XS0J6VURpZHZ1L1dCQUNtRWk0RnU2MkV6OTJma0d3MEV6YgpKK1AxbWM2dlVobG15andCcXdQ
ZjVRaTVSZ1B0WjAvRUx1b2Uyc3krZ25sbXArREdHK1J4RHl3ZWR2SnBoNGtnCjdpUU40dUtjWUNJ
STFYVmQrUHZnSldSWXNaMzQ5bStPakNLOExUMD0KPVgyWmsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e80910061771ee47--
