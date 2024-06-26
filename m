Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8716631D
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400599; cv=none; b=EPwStj8N4XfS1GD7vMJOmUhxZb1Z7IdSIwhABJVXIhKHw2xr3G/gsfSGd53eriLfAUd5dGcCaCxr13AtfzB60V9HS0KYvhq5/4s3u/zOh60bk1tCB0i6CNxlTw//oQ/IXFeu97Y1Th1ZY7NL62HFEgEL3AQo8dQDDRVKyEXWIHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400599; c=relaxed/simple;
	bh=ROWBS70W1KxLhyhMH/4J0ANZEnFjoZxDK6QrWB5Cfak=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmV534RFAyLazwdS6qhyovnNGiXuJHxN5jhgwcW1PhyIb0BB2YS2SAeYVNgBiPGBLVUtudP18ExSVaiAjoYwCuSMZKYRuHkHxBhD5LoQlz88toE7r/XPv1WHAl/5AqzgMn99rpjDFFthSRiYT5QxEvVNFaHkuuLd/SBH7lreybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGmNZSLW; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGmNZSLW"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25d57957b37so321959fac.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 04:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719400597; x=1720005397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gobVs7CxWnVTDjLPjemjfUllxxOB4XtSiDGciS9G5r0=;
        b=cGmNZSLWrNOZt3u55S+ivWJYp+dcqT8EKwTC1GSaW0v2omQ0VGh1ELQ5QULNWbp8oW
         5XuJ5zMWtatZME8qu0WQK7jX9u479QBt8I42ctcDsWcsLpEcDVL9XJoqxa7p+jnEg8FZ
         aV/mXDls4E5vYhM7OWBiCTWHwemjLmsbug8Wx/dNZG8XcLzqVY7vXQyv44Tmnxs38xUX
         PNXTRNK13wnJ8ORM0FQYxmEtKlZQo+3EZngq5b8l/ykXh+ejGEoVWOxPApCUg8V9TB+R
         TH0UM0oZK4Dvj9wZREvt183D3Im4p/50YhPa1LCx9Qjkg8D6barApxNwJnnfdJpQmLoD
         abig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719400597; x=1720005397;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gobVs7CxWnVTDjLPjemjfUllxxOB4XtSiDGciS9G5r0=;
        b=c3f2CiEbS31DXIzUMxD0RrwwlHVX2Uv1PGpz6holfuik7OEJDk2Cwwt1Dy8DuT3csM
         v7f8lVUJtD4Oo7O/0wRoS1A76ZF5QNAVIp1sAj92jqJtm/YpGAytXzpIF4xrRYQQh3Vv
         peD43fPtvLPhNq8ENpde64crzVXTKTNsStJjCZdNSsRAGZypTKDaqOFRDwA4u3p6F/Dk
         1WQP6Tc2rBWr0/X60XZj5FwPQI9Cao9oUAFF5+Q1QgAE4FD6nzMgqMNvUVMN43BfKszb
         y+7KAcOdZa2MrDgr3QKwQMPwKPqtrlxJgV/G9eRr0M4HY80G11GrOyfdvXu4gJRj5mpu
         yrTA==
X-Forwarded-Encrypted: i=1; AJvYcCVM6RswWJNhqhs12hT7gwKlACN46em68yVw14VAClb670oSso8RYZWmn1ZOd6gEqdrwwdc9QNtYf4UsN4TWLSty4k9/
X-Gm-Message-State: AOJu0YySRNFqEAYHGNlk8AfEdkbUvtQqrnx1HNuz1P/Cd3LqagfKSEi7
	PFOUpkLJnNgJeERmSQUIM/Kv/EpmEd95fyaOPTrV65ep/qgdlL4EhsGlOP8gV4iuRl/m1ZVXRjo
	rLXYiHqefgxzfU7/4WZSYGmnni5U=
X-Google-Smtp-Source: AGHT+IEhZRC6NYzeFAyGxZ/4MbAPBObyBUjfeYVFA6mWKfkGBs1DNsqzFGgDiSaD5VFQmAKpaZ+D0l6bqYBkTzOrlZo=
X-Received: by 2002:a05:6870:a40a:b0:259:86ae:bd22 with SMTP id
 586e51a60fabf-25d06c1b572mr11448960fac.13.1719400597492; Wed, 26 Jun 2024
 04:16:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Jun 2024 07:16:35 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy16t6m8u.fsf@gitster.g>
References: <20240625133534.223579-1-abhijeet.nkt@gmail.com>
 <xmqq34p1813n.fsf@gitster.g> <xmqqy16t6m8u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Jun 2024 07:16:35 -0400
Message-ID: <CAOLa=ZTPm9CjMMyQ+nr8vLCSnEhnQMZwcMyu+7qbNKzo3ymM9w@mail.gmail.com>
Subject: Re: [PATCH v3] describe: refresh the index when 'broken' flag is used
To: Junio C Hamano <gitster@pobox.com>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>, git@vger.kernel.org, 
	Paul Millar <paul.millar@desy.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000d73482061bc925e2"

--000000000000d73482061bc925e2
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> (#leftoverbit)
>>
>> Outside the scope of this patch, I'd prefer to see somebody makes
>> sure that it is truly equivalent to prepare a separate and new
>> struct child_process for each run_command() call and to reuse the
>> same struct child_process after calling child_process_clear() each
>> time.  It is unclear if they are equivalent in general, even though
>> in this particular case I think we should be OK.
>>
>> There _might_ be other things in the child_process structure that
>> need to be reset to the initial state before it can be reused, but
>> are not cleared by child_process_clear().  .git_cmd and other flags
>> as well as in/out/err file descriptors do not seem to be cleared,
>> and other callers of run_command() may even be depending on the
>> current behaviour that they are kept.
>
> Ahh, the reuse of the same struct came directly from Karthik's
> review on the second iteration.  I guess Karthik volunteered himself
> into this #leftoverbit task?  I am not convinced that
>

Hehe. I'll take it up!

>  (1) the selective clearing done by current child_process_clear() is
>      the best thing we can do to make child_process reusable, and
>
>  (2) among the current callers, there is nobody that depends on the
>      state left by the previous use of child_process in another
>      run_command() call that is left uncleared by child_process_clear().
>
> If (1) is false, then reusing child_process structure is not quite
> safe, and if (2) is false, updating child_process_clear() to really
> clear everything will first need to adjust some callers.
>
> Thanks.
>

I think it would be best to write some unit tests to capture the current
behavior and based on the findings and as you suggested, we can decide
the path forward.

Karthik

--000000000000d73482061bc925e2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 50dfd6ba845f8c23_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNytKRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menZpQy85cHh6S1hXYWFQM2JxOThvd0FIMUdKU1pUZwpvMlJCUlV0NUZy
aHBDS1FlTWhlOVdjc216SmlITVAvUnowbkFmUm1pOVYxU2l4UVlIbW5CekR6MVJEVi9DbzhYClZL
RW1ObzFKT3liMzYrdW9Nbmt6OE4velJWZXFkYlJ1SDMvMFZFTWxDc2xNamdueXJ6TWRUOVZSOXJz
L3N3M3AKLzVTUStxTzdJNkZzSUtHdlJJaDhmMEJ3MG5CZXduK214eWhXS0FXTVF5Q3JoeXNCZ2to
QkRRRXVRc2ZFYWxOQQozNktwM3VmbkFwWkxHWVdWUjIrb3YwTGFad3pLU25oZytzdktDOVB5R2JV
ZWtXc1RleG1oUmdRV091bkZZcGJCCmR6NDgzYi9tVG15VjV2Z1I2WHdWQXVySmhYNTdkcDB5TEdF
cEpoWnZ6ZnJrT0Y3SDNVU0hMVVM0cjFXeGloWDgKRnIvNDNFQWRjSXJ6RFk5RnVGajFtUDJYVURG
OGk3dmh1OFBBT1h4TEFtSmgxN1dsVWVFL3JNRldMRUo4d1BnSApXVFJGU050NThDSU13Y25KRTlR
TVhTeVhJWjVJaG9jZi9wQ1ArL2RjMmF2MHQybThNTmtzY0Y5S0llOG5Mb0dYCnBiT1RINUZvQ2l1
M2U2ZVBaMTlpY0x0T2g5RVh1Y0dEZC83LzB5dz0KPXlpeHMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d73482061bc925e2--
