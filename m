Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393045038
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769765537; cv=pass; b=o9sap6tYA4UuFqpsNGPMXeDnHBj5tIaeCvQ2wDxDBDZyobqN0lhGZ2YkYS1YJc4/S0EVgCpKoI/9gqnawbCLbvCUPQhapCK56zXvD1fG4oEMAIIbfL/BETVrlbc8HgK6PLhvrBl9QEiGt51hSU5QOVIuULVL/A11cx3cLn+zwC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769765537; c=relaxed/simple;
	bh=ai2MajC+BMDSs4UwemMEXwXgTt/T4DsY4iIxkWPfcfI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPvB0VB5oI5BAURXwwf67buOLyQ+vOBHvvHI4T8Rl6jwg0f4/MELikxtKrAaB+MKc+m441PJisqG6BEU5PEbS13OLnJKrvS/n0AsZh3TMF+PnPD/uHFRJ0EJu+Grw3tK/1+Qvjzenem/cShFAsl8q7pFrID1F0FvWcACmB8ZyN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/aRuJxj; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/aRuJxj"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ef5c04151dso650037137.3
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 01:32:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769765535; cv=none;
        d=google.com; s=arc-20240605;
        b=KgYHLihDO17TUz+H7uymarJZdMr+Leod5srzxl0uxJEMjk2vvnYA5dsjfEJihGR0Lz
         2vC7Y0WrYInT6cbRnOLabSEpyuYzDaoEKsmbmkY6KqRp55vSVSsCmFLAXDxi8gceFRr2
         FUouSdOqDUzYrEkNxlBdKLMqdXJ9dV4YuMW78yZnDQmmrV25TCPhJXk8pAp7ETUum7ba
         iC4AxaivD+oElTEoVU1VdK1X3o13JqBYC7jj9AAHddoAIEySjxXaRY+J5B54iLDZ/vjJ
         HFxY1AQXlDGO0ygn/kRAxnx0OYUhjZ3Bs5MGNZM9WioljbE99wdqhTjcbmUoHEtQBqr5
         MshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ai2MajC+BMDSs4UwemMEXwXgTt/T4DsY4iIxkWPfcfI=;
        fh=TIwovCq7pF92pgE4YU4Plx0sIIS79OSzHN6zDbM+Sb4=;
        b=KW9ey4i2dSRaGYmvbUiQSkYkOShKXPP5raK6sqec4NNRGW0M2kcmJ72dI/v/AjzBje
         Lf7dIGCyzN4PY0OCVOP76qzFduRm4AtJaO2m5KkyP8OusZweaXtEg6N++o0YzLm0OVWF
         Spnz7gRoXfKKAfuhQFuwGVcjYevlCKa2F1uzaNSCbnT1ZdQBJslpUnw3IdfrsqooNKFw
         SUIcffOJoX17kwIHsp1WY3tluF2lKG0Yjb+kigT0aRd4wY2t2MUdwh3oHHL/GggblH9X
         hSE3G9tYnmVcN5HS25SafV5TZr7ljPteS9247Liaw5QiFrofmETfxoYXNVfX3RyCfoGm
         Fg+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769765535; x=1770370335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ai2MajC+BMDSs4UwemMEXwXgTt/T4DsY4iIxkWPfcfI=;
        b=Z/aRuJxjIW1UkK9XZ6OVgvUvdTgBXU+3AjyJtgH4Kd1bXanSlfM4Ugs3rHJoqUoES1
         dF4u+z7MiZicnornQmLMBH5SCAnfg7uoIH/3aW2n4k1ixLsXZT965C6OBHd5vucP1q+R
         BA61a50bMQOw5q8rMD/OO0YqNFwljf4BQyq3sE83g8yU/zVHv31f+kM+5BhlqpHsXauZ
         IIATvi/oQyplKWvfJfIPupWtuIPyUr0y0akFVf7hnAS3CfKxJBfBb1A32x+faWZbBrxE
         +2/365/1Z5FMWVCf0BXsP4YmgmuhHDmNbKTei+7L5mYiNF9k9JBwi1Mf/EkuLX+T8uqb
         unjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769765535; x=1770370335;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ai2MajC+BMDSs4UwemMEXwXgTt/T4DsY4iIxkWPfcfI=;
        b=sBeUD9j/ecYSKaIlIlZvGewZ2ZDPsjfW8YA+5EX0DzKXKfIX4Akd0+MnTXu6y1IsFi
         WXf2O2UPvu40ZuMia2G0IMgLFO1dPwVce13R4beJJcBIj+KpYKkbhTZs+Idi7/rwmpmL
         QYjM8g6xFA4msoOVTiCjtb2j1UrO5I2+Rn1K3Js0dHu2xq18MfECGf1hKXj9fArxJpIj
         94oSWqyqZoJlpYybeQOTMdnASssP+gGrf5tqRjEw55HLd55OAKmRsazwhYdCgEOck+Vs
         ecuKha8wq2JYyomSTwpvPYT2lIwyItYq9z/H2q37ej6miNtO6aNmLdYJjCQMzRvDYQZw
         lA+Q==
X-Gm-Message-State: AOJu0YzMzqewOEDsomIXl+/oNmX9dB6NprfQHnkrWEoj7+cvRyOcsrrf
	HIg1q/qt0JCTYadqNbuoH9Mq0x0KGqYdjZKhDeN6yVQ37T3qYKMZIF/3RGbIVve3DyXUqV9gznr
	s+dGkmplcT8i0SnIWOX/6IxE92oOMqzQ=
X-Gm-Gg: AZuq6aLHkkWAzVtmy8SeB21zLBE41QqnQ6XfmihL2WlPhza2kim+YKaEnezciK2V+az
	ECa4pvEI+2Ce4QCDwByyVTKJBxQKlbCWu1AVlFUhIDbEKX+mBQ+MqMwkXwcYyMPMLoUbpFdEVnO
	D8vL1ys/V50NpMb345NN+Ena/voLfp2BIPPK6VkfA0vQ82SlwNAWURjBUuw+7WH6C5V1hcPo/pD
	j8aPIaOl5Yj9rbmgQeBePpXKRYnmsWWEaqfRK/UlbSQKWLkJNCy9ax8fdnP/0EpwwK6iwXYiMit
	nHQWF++FfvuM2A/diVcNQqg/V7/Y
X-Received: by 2002:a05:6102:1626:b0:5f5:4d9b:bd67 with SMTP id
 ada2fe7eead31-5f8e2549310mr601411137.6.1769765535286; Fri, 30 Jan 2026
 01:32:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Jan 2026 04:32:14 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Jan 2026 04:32:14 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD29LtG2dRRB4f6mZAHNGqDmDxUV4ULYw3w3OYg15ZBBYg@mail.gmail.com>
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com> <CAP8UFD0kEATc6sU4r2pVq9k2X737Tk+_VXrxXx8K=M6=ciL=vQ@mail.gmail.com>
 <BAD29E01-C358-456F-8E31-058AC0AED0C8@gmail.com> <CAP8UFD29LtG2dRRB4f6mZAHNGqDmDxUV4ULYw3w3OYg15ZBBYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Jan 2026 04:32:14 -0500
X-Gm-Features: AZwV_QjrD1DK-SxhnRZbT010FEuHOC0zYE9saB2UtQKsEDUvI7Dw13Z479M7X3c
Message-ID: <CAOLa=ZTK-PdJAYfDVPW3qLN+nBCe71Q=E8xohJzbFK=EH8sNkA@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Christian Couder <christian.couder@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Meet Soni <meetsoni3017@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Bello Olamide <belkid98@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>, Eric Ju <eric.peijian@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000001121fc064997a62a"

--0000000000001121fc064997a62a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> Hi,
>
> On Wed, Jan 28, 2026 at 9:28=E2=80=AFPM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>
>> Just a gentle nudge for the project ideas. The deadline to apply for GSo=
C is Feb 3 18:00 UTC. We need the ideas page ready a couple of days before =
it at least.
>
> Thanks for the nudge!
>
>> Feel free to chime in to suggest ideas that would be achievable by someo=
ne new-ish to the community. If you're doubtful whether an idea would be re=
levant for GSoC, feel free to share the same and we can discuss it.
>
> Here are ideas I came up with:

Thanks Chris for leading this effort!

>
> 1) Continue the current work on removing global variables.
>
> 2) Finish, and then maybe improve, some work Eric Ju started a long
> time ago on `git cat-file`.
>
> 3) Improve git-backfill, or maybe a different command, so it can
> remove large local blobs when they are available on a promisor remote
> (for clients who want to get back disk space).
>
> 4) Implement some kind of fetch order when more than 1 promisor remote
> is configured (this order could be passed from servers to clients
> through the promisor-remote protocol to make sure the fetches happen
> in the optimal order).
>
> 5) Make the promisor-remote protocol useful when the server wants to
> advertise "better-connected" remotes (not just remotes the server
> uses) as Junio suggested some time ago (see
> Documentation/gitprotocol-v2.adoc).
>
> 6) Improve `git repo info` so it can show more information than now.
>
> 7) Improve `git repo structure` so it can show more stats than now.
>
> 8) Improve fast-export/fast-import and maybe git-repo-filter regarding
> commit and/or tag signatures. This might conflict with GitLab people
> (including me) possibly working on that soon though.
>
> I would be willing to mentor any of them, but I don't have much
> knowledge on `git repo`, so I think it makes more sense for me to
> avoid 6) and 7).

I'd be willing to mentor any of the projects listed. I have a little
context in all of these, but that's a good reason to understand more :)

Maybe we can also decide how many projects we are willing to mentor this
year?

Karthik

--0000000000001121fc064997a62a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6383697db72ef3bb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sOGVwY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1melhOQy80NHVqL2Y5cDlBTzA2SVFzODN1YS9WL1BESwpnT2V1MEdINnFS
NXcyUzFpVGRGbXhkZCtEL3VReCt1YnArTkxFaVIwdy9sZWV5VkwvVEQ3bDZGeVU3Y3dyVjZECnZE
MlBEQkE0azVVdk5xdlVQaWZTTzBXbmN0OHIzQjE0YUNJdkQ5M3hqU0owTFg2M2hhbDcreXhjbEJW
S1NGamsKenBuQmtSaHY1aVFKM3gyTHdCejRySURXNzdzV25ncFR6L1RlL1FWMWFKcFNjemI1a2hQ
ZXRwR1ZkeGtBVFEzcwp3MDUzb0FFYjNnWk5yUVNjelRaelJQUTZIclBvaDVKY0IxdVpFZmZlQjVF
WHMramhKa2VWRjlpSE5icWMycDhrCktNZFRnK1VIbjlReXZpZVorT0k1eGZMc3IwVENKUGo3MDV5
YkpuTmQ0dytmYXk0TnVEbXEzWEhSOXB0enZOdWQKd2pmR3lTZVhoQzZ0NnEySC9EZFd1Z3FSSTFw
dC9Ka0NtbjNEQ1QxZHozWVR0L1lBSG5wWjQ1SVBkTDFOdXlXNgpIcFQzemZlSS9BUzN3UVhYNlUz
bndoQUgralhCaGR1TzZNNDRXNW1Fd0JCcW1SZXNVS1laSC9wODNxWWpjajdoCk4veXdTSjdRdnEx
ejVtVUZYclNROVh5eEpRZ1pCSGZ6TzRIeUx0MD0KPTBaV1EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001121fc064997a62a--
