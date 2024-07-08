Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5414E2DF
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458707; cv=none; b=Aw5vsBM9Uvs7Yb3eHq+fpoy8MyweAJF/godYbqoOxXkQ73luFviaSDhgIfwiVCXSjavoD5QDuS7sDLpqhW5YVy8VTZY97I2NdmJ141Lt2lnT2/C8YLk9lvFuqbOHAqUbpSDygHOYr7wAxZ8PLZQBQ1pXUU5mUsMd2PfdS1x/nEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458707; c=relaxed/simple;
	bh=gTn79Y22Mc/ui5r0wMkwlVJRM9OaZCd/uEOV0epf2b4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MealJyLq6mqsfsjQpLwWH/wp6ayanFAirysqT8tCKqdv4UXX0IdExl0nhSylklGIAJSUyzK/EJjI5sn8tLcQuOLTGC/iv7wRcOBj1UyKkqNiu+Ln42HxisJduJXPDC6fapuu+XM+BidcnfGJKpIhNWhkN/uSnhn30RekWxcnWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heh1OFck; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heh1OFck"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c9cc681ee4so2360892b6e.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720458705; x=1721063505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTn79Y22Mc/ui5r0wMkwlVJRM9OaZCd/uEOV0epf2b4=;
        b=heh1OFckWD29yWCPavwSXQAUbSfxwRkbYQvEy3EhXsaAlof8iO/+j7wiPb5uH3ACTC
         zwMI2hS63Kr6RLgnhp52jH1jS5/d6Op5Krf2i/Ddt72cmMwJzoWCkohdW3tvSYFYhOZw
         gSN1TMggLuA2QFgayZOJoc8hbC+AjH8ega+v7ftD8kB1jpIqn6AfXc8N5ez9Zan2BtzE
         svyJfV47bG4i01hna0suV2raA6BhDWZ3iIsxPfujju46q7+eWXZ8HIeQiRrYY7L8xEQz
         VfVVsMDnvBMyQdQ3SsPXEpdi6q4+xb51DvQ4QdTfUxTytHj9ieHXjckvkSr8yAIFyQOS
         Dm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720458705; x=1721063505;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTn79Y22Mc/ui5r0wMkwlVJRM9OaZCd/uEOV0epf2b4=;
        b=dlxZXUbPSOIWsAwL94Lew40YNBDFtun4or+1fZ2j3hVpnccXJmgvgfNjlfwh8uLnVN
         nWg1JlWZNDs95ivcRRDUa1ArSTZJCOTOxJdfm2E2E3XBdaw3a/ZZRdWT7AIsaDEG2apj
         crbRM2KrMI0mb+QV7xVKhHJd5uXN1ciC5u7tE2E8gjPh/21rdpn6+k1gSfvNijsY9beu
         ywbhbPkJK78KdwQDEPnYI4uxX5pp7bpVHUYNEAIrMXxsrN4uMEZ1KOlLcPawy75lH71N
         NKNUj5eNHbTcegxjrlskAD5zjfhDRKXkjwBz+/M5TFJkiTuWcnhmaAHMcQeP54NEhRpT
         RckA==
X-Gm-Message-State: AOJu0Yxa5vx9k3z/DHZcUwBAnMB9vjZMQIO0IFJmKkzgvfIMrbSqp9ei
	f7Mw6WLjUSMnpDVD/8AiaPi0PxHH6kFe/Z4GZSI3/iuCXeDSk/y4gH1tiw3bwBOu5LueiCrJjyg
	0rYXF9U7zgX8aJncw7xh1DdzrX5l9jXIn
X-Google-Smtp-Source: AGHT+IHLn/omtN1Bq+VfEteHhinPQJDX8bvqyQs2hFCOm2oVyNh1NQovHpnMDS0j3G/IOA/P5VFXoG6ZcvGQqhacZbY=
X-Received: by 2002:a05:6870:ec8a:b0:25e:29fa:41e7 with SMTP id
 586e51a60fabf-25eae755275mr14677fac.5.1720458704676; Mon, 08 Jul 2024
 10:11:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 10:11:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Zov_PaaxF1Mbp_dP@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux> <ZovrFCzRg06pq5eI@ArchLinux>
 <CAOLa=ZRPaiHK+NezigXEyWceriHZ7rb6msR51zcit9X=8rHFyQ@mail.gmail.com> <Zov_PaaxF1Mbp_dP@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jul 2024 10:11:43 -0700
Message-ID: <CAOLa=ZR5mGOVsf8RSKxvQkT-9Ndm40CNuSEOY3Pbeu-2F0uqew@mail.gmail.com>
Subject: Re: [GSoC][PATCH v8 2/9] fsck: add a unified interface for reporting
 fsck messages
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000f1800d061cbf8126"

--000000000000f1800d061cbf8126
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Mon, Jul 08, 2024 at 10:36:38AM -0400, Karthik Nayak wrote:
>> shejialuo <shejialuo@gmail.com> writes:
>>
>> > The static function "report" provided by "fsck.c" aims at checking fsck
>> > error type and calling the callback "error_func" to report the message.
>> > However, "report" function is only related to object database which
>> > cannot be reused for refs. In order to provide a unified interface which
>> > can report either objects or refs, create a new function "vfsck_report"
>> > by adding "checked_ref_name" parameter following the "report" prototype.
>> > Instead of using "...", provide "va_list" to allow more flexibility.
>> >
>> > Like "report", the "vfsck_report" function will use "error_func"
>> > registered in "fsck_options" to report customized messages. Change
>> > "error_func" prototype to align with the new "vfsck_report".
>> >
>> > Then, change "report" function to use "vfsck_report" to report objects
>> > related messages. Add a new function called "fsck_refs_report" to use
>> > "vfsck_report" to report refs related messages.
>> >
>>
>> Not sure I really understand why we need to do this. Why can't we simply
>> add `const char *checked_ref_name` to the existing 'report' and
>> propagate this also to 'error_func'. Why do we need all this parallel
>> flows?
>>
>
> Yes, we could just add a parameter "const char *checked_ref_name" to the
> existing "report". This may seem the simplest way to do. However, it
> will also introduce some trouble below:
>
> 1. "report" function should be exported to the outside, we need to
> rename it to "fsck_report". Well, we need to change a lot of code here.
> And we MUST do this, because "report" is a general name. When exporting
> to the outside, it's not proper.
>

agreed.

> 2. When we add a new parameter in "report", for all the "report" calls,
> we need to pass this new parameter with NULL.
>

agreed too.

> Use this way, we could do not change "report" function prototype and the
> corresponding calls. Most importantly, we could let the caller feel
> transparent. Using "report", caller can just ignore "checked_ref_name".
> Also for "fsck_refs_report", we could ignore some UNUSED parameters.
>
> So I think this design is more elegant than just adding a new parameter
> in the existing "report" function.
>

I understand what you're saying, I also checked and can see that there
are 60 references to the `report()` function. So perhaps there is some
merit in keeping it as is and adding a new 'report_refs()'.

>> Apart from that, what does 'v' in 'vfsck_report' signify?
>>
>
> Because I use "va_list" parameter, I want to emphasis on this. And this
> provides flexibility that we could add a "fsck_report" function later.
> There are many codes in git code base using this way. I just followed
> this.
>

I see. Makes sense.

>> Perhaps it is also because this commit is doing a lot of things and we
>> could have simplified it into smaller commits?
>>
>
> Actually, this commit is very clear. I just want to provide a unified
> function "vfsck_report" here. And let the "report" use this function and
> "fsck_refs_report" function use this.
>
> So I don't know whether we should split this commit into multiple
> commits. They are just tied together.

--000000000000f1800d061cbf8126
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 49a1d924d9fc1930_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTUhjMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1MwQy93Smp0dkhGQWFEMTRaSXZJb2pOcEU1MzFnZwpxZkt3dnRMQVg3
dDhkeXdRa3hhSlBMcGo3QjFyWXJWUHE2dHA3OTgzNHRBWUg3OWxLdm96Sjc4VjZzdkVDNUNWCkdB
Mk05TlRXZEZCNHhvRGhLRjJkRVBubXBUdTczWlhLK1JxSUZkOXQxY1BBQ0ZZdTFEZWtMVVd1R1Vp
TzlNQ0IKOFJSdk9FNDV5NlcrOWFMSE5wTkszNnFscldZbVFGc1NST1VySStKajdyaTNndDZRaTdx
aFBwVmMzSXc2UmNWTApOQzBHSlVmUDhxYW5aOWRjYmdsNzZJWFBXNGIyWGRVcXhucWJTRkNZNWFr
eTdGR1E4OHhPYWpQd0JibDFaVlhJCjVYRWRZcUQ5T3RoQjZ1bzJ4ZkdxejlhVDJXV2xGM3h4WjE4
R21tN282RWRQVmFxYk9zdjl3cnVveFVlbXdyR08KbTJWQ01HSzA0cXRZNjExa2dFc2NDaVBhN0lz
cW5jVFYyT0JyTGVYZU5LNmR3UnE1cDg5M2ZHUDl1T242RTBJZwpMQXFjNVlpYUErNEZ4TFMxVTFw
Mk03c21zeGJ3cVVYUXVVYnlKK292UW9mSzdNRVN0Nmp0STBqK2EvN1FKNFF1CnFPUzRDc0xZSnF0
azkvc0w0QllHRjN2STBOdi9lakZJWUtWMGU3bz0KPWp6SEMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f1800d061cbf8126--
