Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C1129A77
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472047; cv=none; b=lnvUns2flK/pOly7U2o048QKSqakYdI0kQ3I8MoyKKQmbiTYLg493NBVOVuHOUQQUqCLBB9WuXwS+5bEOo8lH78AYXLb7Rz2szIFQ3Vss0+2SrvC5rfbQEsngwJDCl6wNBXxae4p6OatNBlm38xiIvhjb2aptd8YcWjvYeSzMGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472047; c=relaxed/simple;
	bh=xfRGy8Z90yzjRSkjRpscyOAYSkA2q2p1q1KJnGIRi7I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 Cc:Content-Type; b=Q7WppXabn97CSr3TP3AC5xYy3jqwQ7a1H6XdCYwor2ecrZlBmIFIHyrIhf0krGTrnhrR+FMNrx4IA7g8yzLkVMONcu+03dqLt16UOIrWATH29C7MydBkKafB5TQvIjYjooXs4wsPbQQLBlaGqbtuDfbRk8p9Tsb8FImc5MwqEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXXGFw+X; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXXGFw+X"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-23d1c4c14ceso172291fac.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714472045; x=1715076845; darn=vger.kernel.org;
        h=cc:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfRGy8Z90yzjRSkjRpscyOAYSkA2q2p1q1KJnGIRi7I=;
        b=KXXGFw+XeErprzsv09qUfb23TKZWnOOz5jagYrhj6jWubw3xRwMOhR+RnYKfcHls5O
         eQP6ttaUx8Z/WBnomLlVtl6XafyOtUUJM1//nRblxZt+dHv5urdnQxYKo6V/gLnsANJI
         5P+7rSGWp5SXBrqYhC+3cx93giX5VweisGTTq2QQoQumwThfy7H6Fwb7NkhPb2r4aX9f
         AiQlMXrXCc2AO+voFYiPXUR8H58wwxWolAZIXLRZueXLw4QcxL9zf3XQB2C25fQRdyS5
         /ghL4ZV6CQrCc7Qu2u5A/cfEEtwTrSahF87zihZ0PL+KefL2qRhj3wQEi3pj6Ad3D5wa
         48vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472045; x=1715076845;
        h=cc:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfRGy8Z90yzjRSkjRpscyOAYSkA2q2p1q1KJnGIRi7I=;
        b=PEWewt1ErcqB0ul86l08URgUbbUpVh5UJHxxlLaJNM3uemSHszbJOD4bWJp62yoWQw
         sS4+F8RyCrvya/bx9bN2+x+1kUPnIDkKIhNthgPSNLQ/1/PHw8FaKqHYbdaMu154acJ2
         smaBRQl4+CFUnP4F+a724HBlPcQ5yQMnWGferVr0aK73yAH3t+7bOnYj8wOjwu+WY5Nb
         CQLEu4IPv7fZC6zAQbmKCUMHjePSY1eSfUVTyOiIEL25OZYMCj5xeYQtxK0C+kRPw7n1
         o2ypeOrBk7lg7WS3a20ZdMiXGcDAL+Gsxj75Ar8sYOUYL7+iV8hvIo2mIyrX4gORd8Si
         tBzg==
X-Forwarded-Encrypted: i=1; AJvYcCV7rxZIe1gPr8j2iVp8LRNQh0HBW9lRnyb4x1D4Q5ISlE8PJDS1TzRQwexY2xudQ2KsY4Z3IdZvEVCg3Q3oY/xmwXHk
X-Gm-Message-State: AOJu0YyySkPwSqKaY6viHGFL0C3DC+q/w+hZFkKPYXrR/uwkfrLbSOCT
	ztmg1sZ3nKRMRX7Q5ZwtqBS+gKv1aoqX4eOHxT7xscXwyAm9D0/+agUkcifXLO71fkR+4FeaZpZ
	FEfdnrkWPxaI3GCBfEo7+PdpA/kY=
X-Received: by 2002:a05:6870:47a0:b0:22e:de09:6eb5 with SMTP id
 c32-20020a05687047a000b0022ede096eb5mt15196084oaq.14.1714472044761; Tue, 30
 Apr 2024 03:14:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Apr 2024 03:14:03 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240426152449.228860-1-knayak@gitlab.com>
References: <20240423212818.574123-1-knayak@gitlab.com> <20240426152449.228860-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Apr 2024 03:14:03 -0700
Message-ID: <CAOLa=ZSNYs17bM9v3r4s4Mvy6zvdFFvrx=j_JWoaKbPWtuGssw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] add symref-* commands to 'git-update-ref --stdin'
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com, 
	ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000388a7306174da128"

--000000000000388a7306174da128
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The 'git-update-ref(1)' command allows transactional reference updates.
> But currently only supports regular reference updates. Meaning, if one
> wants to update HEAD (symbolic ref) in a transaction, there is no tool
> to do so.
>
> One option to obtain transactional updates for the HEAD ref is to
> manually create the HEAD.lock file and commit. This is intrusive, where
> the user needs to mimic internal git behavior. Also, this only works
> when using the files backend.
>
> At GitLab, we've been using the manual process till date, to allow users
> to set and change their default branch. But with the introduction of
> reftables as a reference backend, this becomes a necessity to be solved
> within git.
>
> This patch series goes about introducing a set of commands
> symref-{create,verify,delete,update} to work with symrefs complimenting
> the existing commands for the regular refs in the '--stdin' mode of
> 'git-update-ref'.
>
> The 'symref-verify' command can be used to verify if a symref exists and
> its existing value.
>
> The 'symref-create' command can be used to create a new symref.
>
> The 'symref-delete' command can be used to delete an existing symref while
> optionally checking its existing value.
>
> The 'symref-update' command can be used to update a symref, create a symref,
> delete a symref or even convert an existing regular ref to a symref. Wherein
> like the regular 'update' command, the zero OID can be used to create/delete
> a symref.
>
> While this series adds the commands and the required ground work, it only
> is accessile within the '--stdin' mode of 'git-update-ref'. However, it makes
> it easy to extend it further to the command line too, which will be present
> in a follow up series.
>

Also, I'll be pushing a new version with reduced scope soon. The idea
being that we can review/merge the part which adds the symref support to
the refs library first and then we can have a followup for exposing the
same to the users via git-update-ref. This should make it also easier
for reviewers.

[snip]

--000000000000388a7306174da128
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6105192c10c1932e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1Zd3hHVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN29sREFDTlJvcXFSVnVHU1kwWWhwbEkxSWhORzMxQgoxSFJJUWI1U3hM
OG0yMEhNdDdCK2F3QWVzUXFYblV5TEIrTW5YRlcwd3NCVmgydTlMUk5vdFJKR0ROMjlyc1BLCnVI
bXE0NGloYVBsSUtFV0J1T1dsWXBtcXBiM1Z2SisyR3ZPNU96TmdGYW1XekFQUklHRGtSdGc2SHZG
L2FhckkKeWtCQW9NZm9CQlROZkhLQXVLV2tpV2E5cUJsd1FrOC92N3dVa1VJTmJaUDJnOEhJNC8w
dUdhbWVwVmFGMW8zMQplcTh3T1VaOXl5VkxOMkNoV0VZbDVQTHhhV2tTOHl1djJHTCt4ZXY1cldS
MGF2YmRwTnF3MmRDRE9QdkVrYmpvCjNZdzVQZVBobDVMZ0o2dThSeUNwY3VsSUp6eWRWSjFWRHY5
Um11N0srQlp2OHZPU0M2WlJWdmx5TjArektreEwKSVlvdG14VVlNcjFLODlGK3QwRDZkZWtKbUNC
bks1VWFCZ2lVdlVXTjdzbkMwZGJOMXJGTHdhUnZmb0ZZZCtRagpLblhVLzh1MEZHYi8zSUxBallL
SnBvVkNvaWs1MXRWSXY3L1lSSndpZGUwMmYrYnpScUREbWFYT000MFZTUjZzCisxY3dMZ2JEaEsx
czYxZU55cVZqdXlsYUhzRDBBN0VHVDQ1Y2lRdz0KPVVmKysKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000388a7306174da128--
