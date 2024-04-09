Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44A213D89D
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679362; cv=none; b=nyhf3QvDWYEyJMHtQ3JpRFCUNCUZr3gkCelVo7qBibzoia6HouHft4auWgxjgFDlijICPfgxDeQOWFvZY9WKDoeSfMPiIXplf6L82Eh3twTd+GZ23IU2O0+Fms20dw3UE/yv2J7zc5E8e8eBWNHGMIuT5r3xHkcupaNViVcf7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679362; c=relaxed/simple;
	bh=ofESFTMtdOmsT1EMXRgJFpz5hi1sfoHiNeAQng47MGg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNkHMqcntghKo+tFz9GwO4dEBnNuZd0JVH9RsflGc52OXu41yHe90WoMbg7bKCiKElgjLOnC9Ed7n5GNTlULCsjnPgr6QIhWqECVPryZHJpJ4RLekkz+uyQO2kaIDI4/ynQVTKoBl/eFLxURyfT0GmySxtGopANgh9/4BYwDuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep/7T/3A; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep/7T/3A"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22efc6b8dc5so2163194fac.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712679360; x=1713284160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDmfVXULmZqzq0GK0dWqb+hVJWD0dZhxI/RBVNxZ2Og=;
        b=Ep/7T/3At9CrrtjqK0aLVZbs0LCNKXWyEymodF+MAT6EpOqFTEklkF9f5ghxfoCii2
         wTHivq4nTJcKrtONG6Pl3PFN/mbA9ql+EjZOz6NzJlZ8g21JynlHgoGJJWkSN1/UFxpM
         sUTH4KCc2z9BjU4KNHz6xRDcwlD9MDv+yYk2m9iIv5hNwhkIXU/kDo66M2vh9PxEsiTr
         AkcKVmMAqaARo6eP8aTUjV/IWA2r2Hn+pSseiGSWzLb96OZtxwjnAv+79ZDSsP7cVWgX
         0IuM+P78AoRdO1aQ67qQXTYM4qGv9KY9EBoK4uxJt3+0Id9ysslfcYyUOrYsXmbDSAZj
         q4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679360; x=1713284160;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDmfVXULmZqzq0GK0dWqb+hVJWD0dZhxI/RBVNxZ2Og=;
        b=Kzt4r9PQAN/zsGYvOpivJxdMry/CgMzG/cf0WlF+FNgI40mpNdajLUzG/zHeyaX1TJ
         lOhm4AInjctOHTfUuT7JG94Du/+tOusy+QQnClw9P+1u0/I2awJGD7mJ9q+PLuZDcBO/
         jVZzBTiotsVstOw9iqwdBBe87Q6B8hajZTJkOzPb2oycHU20MAlT/SelJcypuN/2fUoh
         MXGZ0eWY4F8ODyQar3iLApmuxWlR/yF1maQ7mAnoDPRyjIlJHbGBHe3OFUvY5iBfC9SK
         vdqe+hoCXqmbl/OKG7Hdvi9Jz8dOwFkNS/vJYMxkX248rOeyAZRmn2+sUswHi2YftKHa
         6McA==
X-Forwarded-Encrypted: i=1; AJvYcCXghh0mGSUuujm5OSMe16TuDfAJXTzSym2sg5km4shW7VnPoSGiVXajpTLL1GeFhkEU9rKR4nGtRdfvoFFeGSkwLZRA
X-Gm-Message-State: AOJu0Ywase/2mK8STq68yNoHG8zWIhOhKLJd0iaS4Pbn1JSk+K5kff/j
	10AkWxO13KDWMExoVM0d9ng4vQr5c7/HDHiHxdN9bS9FSzq7cVaKrpctDwoJdlrnbYqRQotH7X5
	aZhgSYiny2Qqd1QFBbEe9gd4oJrc=
X-Google-Smtp-Source: AGHT+IFzoy3HV8nlJ10EWv9/u2kr1rph0GcjjgjgcXWPnOxMPrS21yVZRRNZBBtTvUk/0C6kU83EvFuGmkZw98ZY9RY=
X-Received: by 2002:a05:6871:81f:b0:22e:e286:8a3a with SMTP id
 q31-20020a056871081f00b0022ee2868a3amr87180oap.0.1712679359888; Tue, 09 Apr
 2024 09:15:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Apr 2024 09:15:59 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZhUsrolJ0_HOH1eU@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240330224623.579457-8-knayak@gitlab.com>
 <xmqqy19yf40l.fsf@gitster.g> <CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
 <xmqqplvadmeq.fsf@gitster.g> <xmqqle5xeun1.fsf@gitster.g> <Zgv4H66NmLZ_o1IC@tanuki>
 <xmqqil0z7m5y.fsf@gitster.g> <ZhUsrolJ0_HOH1eU@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 9 Apr 2024 09:15:59 -0700
Message-ID: <CAOLa=ZSmDZcM473c2dNB0FTv79Vrh92YRTnVR74jOfzX1naNRA@mail.gmail.com>
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dc5b240615ac3cf7"

--000000000000dc5b240615ac3cf7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Apr 02, 2024 at 09:40:41AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > because they have been supported by Git all along. It simply makes our
>> > lifes easier when we don't have to special-case creations and deletions
>> > in any way.
>> >
>> > So I'd really not want those to go away or become deprecated.
>>
>> That is a good input.
>>
>> Do you have anything to add as a counter-proposal?  The "I do not
>> care what was there before" update mode does make it necessary to
>> have a "zero" value for symrefs that can be distinguishable from
>> not having a value at all.
>>
>> Thanks.
>
> Sorry for taking this long to answer your question.
>
> I might have missed it while scanning through this thread, but why
> exactly is the zero OID not a good enough placeholder here to say that
> the ref must not exist? A symref cannot point to a ref named after the
> zero OID anyway.
>
> In my opinion, "update-symref" with an old-value must be able to accept
> both object IDs and symrefs as old value. Like this it would be possible
> to update a proper ref to a symref in a race-free way. So you can say:
>
>     git update-ref SYMREF refs/heads/main 19981daefd7c147444462739375462b49412ce33
>
> To update "SYRMEF" to "refs/heads/main", but only in case it currently
> is a proper ref that points to 19981daefd7c147444462739375462b49412ce33.
> Similarly...
>
>     git update-ref SYMREF refs/heads/main refs/heads/master
>
> would update "SYMREF" to "refs/heads/main", but only if it currently
> points to the symref "refs/heads/master". And by extension I think that
> the zero OID should retain its established meaning of "This ref must not
> exist":
>
>     git update-ref SYMREF refs/heads/main 0000000000000000000000000000000000000000
>
> This would only update "SYMREF" to "refs/heads/main" if it does not yet
> exist.
>

This is definitely nicer experience for the user. From looking at the
other commands, {verify, create, delete} I can only see this applying to
`symref-update`. Making the syntax for update something like:

    symref-update SP <ref> SP <new-ref> [SP (<old-oid> | <old-rev>)] LF

I think this makes sense to me, will incorporate this and send the next
version in the next few days.

On a side-note: This would also mean that we should somehow support
moving from symrefs to a regular ref via a transaction, so that means we
should allow

    update SP <ref> SP <new-oid> [SP (<old-oid> | <old-rev>)] LF

too, but I'm not going to tackle that in my patches.

--000000000000dc5b240615ac3cf7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 93ab62e696c155af_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZVmFid1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDg3Qy85d3pBNzdKeG54L1lkZjROYmFzV3Z2M2NpZApvNDdzbks5cCtF
L05tb05LTFIzL3grcVFUR1BFV252bHdGbURaT1dZSjlBRmlXQ2l2d3pRdGo1N2NNUFJlNjcvCkp3
Rno0dFhDNHJTbGEvYkowdEo2MXZnWVhJaWRDYnhvZkFva2dqeUNSemJXVXQ2TjRJRFR5aEcvYVhB
UlBDa2UKTUhSczJvdU9DZWpKMmtTUmdRTmpYemVmMWt0Ujk2NzJuVHhKWmVvZk1VbDhaOVU2SEFz
eFI1RzFPM0IycUxNcApIRERqaHJLLzZHQ1hxMmoyR2UyTDR1bk1pMXR5ajhSdytianJoTllqN1B4
dTR0WFBDTE82Y25tTzJaYkZ6LzRPCklHRUlXcTJPTzNPS05SR0hHS2Q1TUZibmIzcUVKYVhENFN4
WXFrMFhneVNGVGZoNTQ2VTdBWTd3UGZkN2g0UTcKVndYazdwTWJTU2JZQXZhZXAzejNyMDJDTFlK
SUlBRTM2YUpMVzkvNEczSjJ2TnU0TFdwQ1BNRlNVNnlQQ0I3Ygp1VXUrQThkWEhzdGFadENxVHJ4
MHphYlRzMWlDNlg1akJlOFdZdlhqWStkam9sY3d1dUVjZERlVEsxeFIxNFhwCnQxOVNXNHhUTlEz
SXZBcjN0bENqWFJFQkgvMU51ZGVpNFoxZmhTYz0KPUdQWSsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dc5b240615ac3cf7--
