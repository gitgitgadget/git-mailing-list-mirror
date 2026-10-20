Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792523407;
	b=FlXK9TuMJ80SOZWV34Pd/yYTPzCE9YkyDgMkzG6XW75AayC3ia0FJv9S7Xsy1Ntk0rSI
	 T6NCOqntvHQIdD/kxXBuS0LtAGcw9e8oAz5sFY4zJQHPqbziF+Gj9diqYgH+IZFa4H+H8
	 5spo9JHR3ttGBm1MDrWNh0Dshz6Jc98wZ9sPKjEuP5M5HzB6y3jA22W74dGkSJJw9LXKn
	 wQQYZeDBGvGEj4mPBraLOa5FzaLRBQOYNxVOPICLxMgZ3xFqGUrKty/RyvgqQDjrroo80
	 yMHKCuNfl1zMfUzBB//XQpxgY+kRnbmb6yqOgMV2DwE1waJQsJny4bPxDVOnPdCUFzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=UPv50rKt2klgSCG5GYDqr/HDfja1qIrEI6oyQimJUXo=;
	b=1NBPWTC7HMnx6zwfkmA28OtFDKFgT+z5DeqcYZ0OTIQhmbOiXn7UfMCmaoZOxW/E50NB
	 y+CRuSTeeNgudGFLo6o1cZiayj23/bJ7fyNHvSm3er68aRvIMk3vDQQPbcANOocIf1yhc
	 dhJ2Anjdk4pST/PcY9ddc5f3AUOFlhGg4CtF5RCVRt8380AJ3UAIz4XFF0Se+APiiAhpo
	 C9BXiD7iW2eBOKJytHuSPt8IoxU88aZwdtDUSL7spRMxbuNLRQWprPxpexDqugFkw4IPk
	 SKELP0dGr4bxsSB0uVUl8zghk9C7F+wluiROo8zKiNVjYX7vjoUkMKdhTdHzzXC3IqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=afYaQJwB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB208606A31F
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB208606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=afYaQJwB
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-98fea7e52b7so1934911241.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792523405; cv=none;
        d=google.com; s=arc-20260327;
        b=YdKuLDVpcw/2U1TNuWDK/Ha6pwNoA6DNXzZDwkb9gd67vaErLVw4TlI5erHa48Kc2x
         btGW8A1RNI7JKFk3+yrq/ckp6stFdjQi4KGbzS893KxP13QrRBAWL0gsVi8oDtmWWgOr
         o5wbWzO/qeFh0rMpcmCA5qQ9hJ0XYsSvWaQKQjGJh2/GfQgL1SIiELYdl8u4xlpVy1Dc
         Vh6+Bo8MXdJ9yovgTT+xMWTJpH3tRv/QK8Wv0yT13UWdBT0ptmX2GlLoUOpSIYQB7smv
         NrMiY9dBG2Omj9MWJNM+sE9SpNbhV3K6Rya6Cz19klpEROUEvWYbWS7EaJ558PBLdxdk
         MmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=UPv50rKt2klgSCG5GYDqr/HDfja1qIrEI6oyQimJUXo=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=XeQYir01xRWdTipwY3eSDAMeNzaqju+T4aYNGvVgWvQgP3kHMAuk2ARIK0XzISVnFd
         9OQ1xWmEzGibyNOTBBQ2ETjUWY+Cc5bldixJ20LUqKaJRdau7xjdfH1YxJrVaV5Fe6yf
         ID9DOoTdz88lMWhafqNw7qhJlnXZXHFbNNSyN3x9dmWR+A89CWLMIyTjs7qAvvAit97I
         Xl0bcuvnvYuLaPHJftVWYZCvUPHa+k0jr8QOHCXl/Qt1McUOFBrgk7qo6MZbR4stg4u+
         oe2LJgHmzK9SOovh517YYqFhUNXFR8TTKsYNHLX5NlfjSoadmhDL/Y87N3yEi12hbzlp
         sR2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792523405; x=1793128205; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPv50rKt2klgSCG5GYDqr/HDfja1qIrEI6oyQimJUXo=;
        b=afYaQJwBq+g3jf9hkAIMdhRI+cmGhJfdcer6Oka8iVgBB+QgEqDlPIFtwZj+PzO9Aq
         aDwU7lRlg28a4qBJxj8v5ZTHTj6RvckJrzz5QXZCdbggIKOtRQQ4eUHKBXdTI8meuxvS
         CrWLxEtnJAtIAiqDIuzg9ZvhPncnrEh6fSRLBmIcIHHWbCSEUl2lbIn2nuzGOFzXDRXB
         +47yuUl77c2stbXqR92y96LQsrlSVPmkQzDDoVslw43UlgmvcL9bgAz8RMj8yt1YpXv2
         3+ok/mflbSsn2oXMgFwrEtq/ZiGKcorY2KNmV/1woKfLL8VckmGBOfheROF8z27pesv2
         gtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523405; x=1793128205;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPv50rKt2klgSCG5GYDqr/HDfja1qIrEI6oyQimJUXo=;
        b=IiO9gc5S9+Qf3QEjGG7vRbbNe7rSowmbApUZTh5dEMZfeDwjFpy5eT+FmMezu3q7aX
         rgnIJVj83Djq6mzeuJvZ/BsQiLIiU8Rxp1xVvK30zJwlFS6wQb6c+NK28MRx86aMv4e4
         zqfYTngJ/p5SFKzupphU71QUmp4r0K0ut20TltdKrtvBMWOfO/wKLlPOegHecbz7+d8a
         LmH3urZ7LcwUYen2KU7rMOVbUcA9a6lLyRpdsufFdJgfMJreTkJRXGBIrvU7oadz2E6z
         87JjOoQeHVhJ5PumSdWX0ML4WA+q+IgNPi+IwSs/P1tlzbN6wpdt8T+Gf++4dv77Gh6Z
         a4xA==
X-Gm-Message-State: AFq9FYLC0n4Cx4ABWgWCGQYo3nVih13WLAZNLVNSoHkRKf8AiAs9hXSn
	JNfV7USySGgP2D2tzqS+qtpPaDpDtv4rGcS8/mWPJdbG9Y/RVX0wd9ImFknoejdu0yK70OSmxRF
	qrFmO/wN0zX7NnonH6RvWvtCoAz6cbq5yag==
X-Gm-Gg: AYBFou26Y0mlmNPnyiXYb7QRsPa5y1Q/upO3VwpV0eE3rVG/RLyB8fmm6Q6NOEF+vrj
	qAXWE9HqDwwHfXMZiQMVgGUw3gy2efBFhTsfotV5XMpsK+/0G/5orJ5y39t+d+tDlu+exuVU05e
	HKLVH+2GOGi+ES+5nP9OEaN2qY6zV7g0HHdWKRPTW8wkwGI5RuXs7NL8jYdFIMppQhAbn18gpkb
	TV6PCxGkoobHM9Hv63nPQTwgyZ5whM/HaNJ/9/v55EFgWkO6uTJ/CdOq9iYUlTl52rY7/YkkgLK
	S/JQbXijc5PtUEFKzW5Ste55IcCeSau64QgDDJ4h1U2E0kAouVUjvUHDOGxPMCkzxbgxXnzZUX0
	o6taYA/R2Ssqea//Sw46oAzMRLgjyKEhV3GCwS8dzEHfNAA==
X-Received: by 2002:a05:6102:d87:b0:7b2:43df:ca51 with SMTP id
 ada2fe7eead31-7cc926e0d85mr45342137.27.1792523405441; Tue, 20 Oct 2026
 12:10:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 15:10:04 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 15:10:04 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <atcrRWX2-S9374Sy@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
 <20261019-b4-pks-odb-extension-v1-4-143a5963b77f@pks.im> <CAOLa=ZQ1E5sg05++KCXgbM9+=4=vFeCHU-5iMbNEGRuS-8+aPg@mail.gmail.com>
 <atcrRWX2-S9374Sy@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 15:10:04 -0400
X-Gm-Features: AclHuK_I3dua_KYPoQBkvDzOMx-1_Crnw8IZZB_Bfrma_gB_FYlTH4uJC2LSe1o
Message-ID: <CAOLa=ZSTt1vcqOtKAfRJMvpkXsJgHbDP-jedOLPkTZGY+HFeMA@mail.gmail.com>
Subject: Re: [PATCH 4/7] builtin: expose the object storage format
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d56a25065e4a603c"

--000000000000d56a25065e4a603c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 19, 2026 at 02:40:31PM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
>> > index cb8c1e7292..d2dc9b7a69 100644
>> > --- a/Documentation/git-repo.adoc
>> > +++ b/Documentation/git-repo.adoc
>> > @@ -105,6 +105,12 @@ values that they return:
>> >  `object.format`::
>> >  	The object format (hash algorithm) used in the repository.
>> >
>> > +`objects.storageFormat`::
>> > +	The object storage format used in the repository, as configured via
>> > +	`extensions.objectStorage`. The valid values are:
>> > ++
>>
>> The nuance between `object` above and `objects` here is too little and
>> can be confusing. But there's nothing we can really do here.
>
> Yeah, I'm not a fan of this, either. It used to be even worse than that,
> because we had "references.format" which was giving us information about
> the backend that our refs use. And that's why I recently sent the patch
> series to rename "ref format" to "ref storage format", so that we can
> avoid this conflict here.
>
> It's still not perfect to have both "object.format" and
> "objects.storageFormat". I was wondering whether we also want to rename
> "object.format" to "objects.format" to at least have the prefix match.
> But I shied away from that.
>

But then you'd have to also rename the config options for the same no?
I'd leave that out of this series.

[snip]

--000000000000d56a25065e4a603c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f1f2cf49b949a402_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yWHZJb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md2owQy80ekJSUWg3Z09QUlZtdnYxMW1SN3FwZ1lUWgpsTFBITms3bGF4
S0p2VVlPZHg4bS85TDliQkI5eHJBcGVkMmJSUTNhYVdUOGRtM1NPdlZRZXAzYlJvSm50TVJ6Ck42
ZWRWYkpDenRVQXpkNnQrTTVERStJUllVdllCVG1BYXlmVEQ1Mnd1TmFVMjZqTkQzT1lIbG5UY2xl
R3R1VmkKWmhZY08vMUtsK1RkTVYzd2JIZU82M0YzYzhtYjlDU1ZQY2doRnhKSDNNNG9mTGFXTDhY
M05NQ0NjNVRIZ2dEQgo2Vkk0NVpBMnVFb0pLOUhuQWI0UkRQY0tJZkZGU2grWjZYZnFrSjh2aWpL
MVNENzErRDFDT29kYTZzN3RpY2FNCmRmRmRhZzVjSnlOYUdmU3BvMWpTQ21TQXpsZE5iWENEMVU2
V1RqUzkxWis2dDhLbWZwMG01dVJ5WStFV3lOa2QKdlk5Nlo3MVBHdVhwSjZ4WU4rSmFDWm9KS3RS
bWNBNTJBbzZCVis4S0k2bWFqN2pCWk1ucHhtYUpGODVOd2xkUApPL2NOTUx4c2V5Ukg2bkNDWTAr
UFZFTXU3MFhyU25TUGhsbFZRZkdzZGxLZkdaT2gxWGllaDNzc0R0LzhBcXhoCjVOemJwSEVlMHVB
R3J4N3F2R05venVxYzlZanp3QVk4MHRhNGlQaz0KPXJGTSsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d56a25065e4a603c--
