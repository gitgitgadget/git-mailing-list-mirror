Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53943D7D90
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089718; cv=pass; b=AA2S5w1vARxypop2mjhZxaFtK6OLdpz0otMPOXvzAHQgAc89zzUl8inbTX5PwkzklvHTXPPTEp6W0Na6HojU/TZe0aWU1VXgE6XA+Owr0M4S7gEhV0YBCFJCJlA0U1PBmGOr32Wfxn4CYJuvnPBbBI9Bl2JBO/OFDzNuoGoK6LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089718; c=relaxed/simple;
	bh=opUcNrTelRUxrRmVxsBHF5ps3jQe0xY1z1Z8WQjcYj4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjRa669Lej3hAWjv7A5hTN8Lg2JjVIR+6kromY7PGJTolsMj8pbi21ytG5X7wN9Z6owoHViu5b1QFYACl7+oMEFQ/t1Gz+QYpiwRHhf6QzvOtRbgbT9p4hnyEc8JgEH7OcJP6dj6Do9ZX56Xw7G1YwD2J2vNVnMRaPm0khR9kaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbfVHHyE; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbfVHHyE"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-6c6507549c3so4670696137.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 04:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781089714; cv=none;
        d=google.com; s=arc-20240605;
        b=gB1gIUtmsDl3+8nx8l5GaW6ZosnqW2pnUOUZEPwNLhUSu99bcseU58jcpYxSPErLjb
         LqYLBPsO1bMM3r8jeBqvH755beZOrdmTK4CKxSgD61b/6txoGPQOxHep4viuzrw+YiAI
         RA595FY5XMShHOhlM9DCecMwRqEVHKAAYZH53+vb0daLKbN3a9ep5cl9TpPZhMh2Kh7V
         Ew/wtOqZC38pnruZ22wz9RMqF/B7th/bM7C6Iw1xZ3U8mqhsQrDWh39Lo0L5525VZk8r
         aJj/dTF1E4mOK/5kJp3lsK3YmKKzlW0gf1FySCA05d01+lzvfmyJ1E/B5haEg3L/7Gsv
         F8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BgGQb2tZNCaoJw55UnFNKUoU7BI4jl4Re7vl4CA/tio=;
        fh=3QWKyY+ogq/0u0yZByDTBS0Ubo92BfsKkqnbcyEf3jQ=;
        b=cijkPVA9hRf7XUoLTeYSzOpVWwHYiN5+YXkXPP/+65WWE4wxom8TLCMqgcDLwBQPQL
         leP3n9l0HSBAk9yqlZK++kp/OmA5EHq3t3G3mOybNJ3hXA4D/jjClUmo3dgxWlXa/i10
         2KvXP+6scwtXYFq8TKBozaNV5OQ9TBKLLr53X4SOP3GLAM+hfujBM/EDzdHMn1uNa6Rc
         T3UGXLKc3IUNyJNT2GGzrPBm0twGs6vpQUax1Gmck0SyHh5dr1+U62pVRZJZAbOjBo7F
         zA2pWhgGpfLI4tmGD414B8pZEO8RCu9Oie983zCxb07+7L6/iqah2uqzxCrznh2Tx0CG
         CIrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781089714; x=1781694514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BgGQb2tZNCaoJw55UnFNKUoU7BI4jl4Re7vl4CA/tio=;
        b=HbfVHHyEewT9yNeHZiLwAqRFAxcQOo8kVZtemlrt8wG4uch3b6hov+L3No2N9rUL9x
         JN6uQftUgNo8SzpN1YbTDtacvbl3XabIYlvxzuRjugFTQLrQ2Kt4psIxSdJfRv79LTmh
         +6qCl+JYttxfOq7Oq8mHbO9MJX1bnsFlwrdLUtp/Twvx97Y6X9GZNp8K3H5QYGx5ZDba
         3n6aO9IGDC8DFew+uSD8yU6N5nyClnhSZrCYQs3ThKkQQ+jv5I3ULhMe0fiVgaCic3pd
         ofCVF9Vxk5WOf85V9bC1SmsAQUG1w/sKCRgixRcm7dcH/I8183Q/peQmpPQhpV6SLWNy
         guVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089714; x=1781694514;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgGQb2tZNCaoJw55UnFNKUoU7BI4jl4Re7vl4CA/tio=;
        b=bYuvObIO8GMdg6lIp5itt2hX/h4mE5JJdGgcWOVybr8kcz48eKTuwpJZoMkRS+McAW
         DaYrPrTMF7w6CCW7z4DwRa8mwyMT6KoPQoJJ8XXleL6LIH0uM9njU+XtiDIhLslrA9LS
         mOro/TXjTARTVWH2EYujZGTLQYmzRzChEm5ns19pFg03uRFwu4jn/5hHVzEnHseNnuhR
         /WmnHDLCSQwLLyyhXYNDaR3MrtQt8Vn4KbG/ioVUvKUBkoz9jknESFOs/YC+le34fjLG
         cgaXipUqtcEgJk14wzOydIZzyNE7leRw1KdamMKYmVjFApTyne8MeMJ6v9KQeidkHZGs
         E6BQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/55cAjyOMJbZLmEoYNpJgNRcicdJN1k1ZUfK4JrQF0JVQ5JfHJU+pu31u5rgLUmnKBeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCl/JpZcowMBxNcwv4401T3Ae/UwFz0FGaIBabvssJjEy18k7
	ebSxAThp5CXNfNg1NxUWsbL/9zfDABzm303CFVPcc6d466Aajryl70mI79Ob9j8EEmaAIMlim7U
	zdsQiigffHbTIsnJ25L7+cpVNsVN741c=
X-Gm-Gg: Acq92OFNBvU+CN3VbjKVPi+YilEXcPvGXJess1DDRFqK4GzgwqxPmibshkj1C24Y5z8
	8OetdnkEwvMkGSubA4T5KmMVOZjAXEGnGDl9MnKoWczjcn4Mnk6Lho1MMP/k7i7LrXVEEVD+YO1
	VvB8rdD6XIcmufsvDKl8mtkzIEUUBRzIPaVuKn751Yf1IoIlYHLhwrX36sUc2CyClBGKvBBiQQ8
	4v87DToy/07uIC/QzwnWCyDuEj9mBIVH0g6QY8duVhw6XZaAK8v2qBdwQXOqIhnnhW+yY8pi3rt
	/NbRz5hLJD+Oy2VQfgylSTUzP2RhOK8QuV2b2xBd0RTd96wXh2//+w0cUScdPCPE3qJ+9qzLBvE
	Ia8xEmjWT
X-Received: by 2002:a05:6102:6a8c:b0:650:94b2:b214 with SMTP id
 ada2fe7eead31-7003a93041emr9146083137.12.1781089714338; Wed, 10 Jun 2026
 04:08:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 07:08:33 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jun 2026 07:08:33 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260608-pks-b4-v3-1-f5e497d10c56@pks.im>
References: <20260608-pks-b4-v3-0-f5e497d10c56@pks.im> <20260608-pks-b4-v3-1-f5e497d10c56@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jun 2026 07:08:33 -0400
X-Gm-Features: AVVi8CdhmKzZpZkTnogwFylY-hQD80ziGUoFqbGVb9Mh6T-symif8_UcfKePmvM
Message-ID: <CAOLa=ZQE-kkpSX=pP2A6SXdbp_O6AHzRmbUDOtKCsvz2Yz66Ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] MyFirstContribution: recommend shallow threading
 of cover letters
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, Weijie Yuan <wy@wyuan.org>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="000000000000bc8f410653e44383"

--000000000000bc8f410653e44383
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The "MyFirstContribution" document recommends the use of deep threading
> of cover letters: every cover letter of subsequent iterations shall be
> linked to the cover letter of the preceding version. The result of this
> is that eventually, threads with many versions are getting nested so
> deep that it becomes hard to follow.
>
> Adapt the recommendation to instead propose shallow threading of cover
> letters: instead of linking the cover letter to the previous cover
> letter, the user is supposed to always link it to the first cover
> letter. This still makes it easy to follow the iterations, but has the
> benefit of nesting to a much shallower level.

Should we also modify 'Documentation/SubmittingPatches'? Which states:

  All subsequent versions of a patch series and other related patches
  should be grouped into their own e-mail thread to help readers find
  all parts of the series.  To that end, send them as replies to either
  an additional "cover letter" message (see below), the first patch, or
  the respective preceding patch. Here is a
  link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
  how to submit updated versions of a patch series.

Personally, I find it a bit awkward when new versions are sent as a new
separate thread, especially when the subject is changed over versions.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/MyFirstContribution.adoc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index b9fdefce02..984b7f5aa8 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -790,7 +790,7 @@ We can note a few things:
>    v3", etc. in place of "PATCH". For example, "[PATCH v2 1/3]" would be the first of
>    three patches in the second iteration. Each iteration is sent with a new cover
>    letter (like "[PATCH v2 0/3]" above), itself a reply to the cover letter of the
> -  previous iteration (more on that below).
> +  first iteration (more on that below).
>
>  NOTE: A single-patch topic is sent with "[PATCH]", "[PATCH v2]", etc. without
>  _i_/_n_ numbering (in the above thread overview, no single-patch topic appears,
> @@ -1214,7 +1214,7 @@ between your last version and now, if it's something significant. You do not
>  need the exact same body in your second cover letter; focus on explaining to
>  reviewers the changes you've made that may not be as visible.
>
> -You will also need to go and find the Message-ID of your previous cover letter.
> +You will also need to go and find the Message-ID of your first cover letter.
>  You can either note it when you send the first series, from the output of `git
>  send-email`, or you can look it up on the
>  https://lore.kernel.org/git[mailing list]. Find your cover letter in the
> @@ -1227,8 +1227,8 @@ Message-ID: <foo.12345.author@example.com>
>
>  Your Message-ID is `<foo.12345.author@example.com>`. This example will be used
>  below as well; make sure to replace it with the correct Message-ID for your
> -**previous cover letter** - that is, if you're sending v2, use the Message-ID
> -from v1; if you're sending v3, use the Message-ID from v2.
> +**first cover letter** - that is, for any subsequent version that you send,
> +always use the Message-ID from v1.
>
>  While you're looking at the email, you should also note who is CC'd, as it's
>  common practice in the mailing list to keep all CCs on a thread. You can add
>
> --
> 2.54.0.1136.gdb2ca164c4.dirty

The patch looks good.

--000000000000bc8f410653e44383
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 55ae3385c0abc4a4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vcFJhOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWVCREFDTlBKVnF4TkM1YlJZdVVCYTJVREJFME5IdwpvZlh6YmR4dlh3
NmJxOHhtUUxlcXVHZGVOYnl4MTJDa0RRM1JQT21sNnN1SENUWERrcEEyVWkwUGp1TXdOdStuClZZ
b2l4MHJrUmk3aXVvaHZlMDZxZk10aEVnUENkT0d0N2h1R1FQQTZCUlhXdW1Ga08reStzRm9xU2Vz
VE94cTIKaHR0dDdPVTZVMEN5T2wrWEdPSXFVLzQyWHhOZU5rT0tEcVl4Q3l1RXlsUXJxaDdZYjl5
a05XWEFXdi9nc1lxcQpFSlJ5aEozeFYxNVlvaVRIK2VwQzBicGZ3S2dyVlpEMkJOcnhpUHFpcFk2
Rm8wMWExVEs1SFNvZmhIbmFvMlZSCjREQ3IrdmZEZjNZSHM2SW0zdlZCTzRFUjZaV3E0NG5DVWtx
RjJYYmxrMFZTYUVZMzdMU0pPcndrMjZSN0dabm4KOHF3OVJwVzFKSHVNL0RrY1A3RjNxQXF0RFJ6
MUIra0kzejFXL0NrQVA1ZHJVRXRSZE9qdk1wZ3MvTDcyMmJYUQpXdm5XK0FWcTZYTFlkQUJMVW1m
MS9DQWJYNmtaUkFZSUpPQ01JQXRiN2VHZDQ4MEhRR0V0NUk2RllSVGIzYm5sClV6VGY5WFl4UkNq
ZEFObCtIYmFIb1V1dlg2dkhhUVF5OEJwdFR5Zz0KPVd6VHIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bc8f410653e44383--
