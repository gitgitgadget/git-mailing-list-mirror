Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E12199384
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737528468; cv=none; b=Ezk7CeQYdNioaIAEU+oNH5/m7Hsqei/Qv6VCJzlMJ3n+xvgXYs+mQW5B0yZZZlj4PuFrRCCoJfWciQ1tB/T3NA+L9GsO7kocz/9PmnFhSHKlEAmDOi7TTaLXjSAdrlJUz59IV3zmWJoQB7WY53wBoY4Cc91dnHJflUkN0fpVxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737528468; c=relaxed/simple;
	bh=kZJY82beJqTWJNLR7ATBfBfZbu9heqYRpdodPjsOqNo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jc30criBzCmpGrbCBZe9mPYtGczc+AsKSfw2axNeODyOkhbbYrLjy6agmXTnJgq0myO0tssi0eFTUaplH9mt7yNijISmOT3oL5/ezfqeO6hx6+vHgsiGtwux/9/DIECMw7eFVTC+QY/KWT2Ng4zb29nRjTQJagS5SIoG7jVfSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m62cJ4zA; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m62cJ4zA"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-85b92397fe2so1302447241.3
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 22:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737528465; x=1738133265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxNx6Avvq02MIwls/DiagypqozLpfsk7s9DKZVJIW+w=;
        b=m62cJ4zAxvKi1aArUwRJ8X4RRCuZ7oknXXxihyxbXAMhg9gyWPhICnLartoKKEOrHM
         JRVZNN06KHOuScnos+LDccr8+ZZHtSlvGszcIHFerqny4sHE8f4BFqDwDxBTRdt4imAX
         z6uj0bsX0wwebR7uKhlrCS2rixOcpAE1tlcCelm60hHfUQ1Wyjo1a9cHTOMLkd7cJ/DP
         /JmpD8HwTBNoI+7RfHwt9yQYx1t/JROhOvASs6wgjSk8x8THjpbtMv4jVpC8CkwOVmWA
         ddgqbTGQx8bxsSP7L3pcedhbU6dYLVK6CvT0MuJMrHI/TOyEhA/VLUMvJ2aCiSrXcAni
         G6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737528465; x=1738133265;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxNx6Avvq02MIwls/DiagypqozLpfsk7s9DKZVJIW+w=;
        b=vnSU9+tg0hI1mlKHwsHdqaP7q964Geofc25DyD/qJwoQeoz2mLRedHpQ++PLlBTSZE
         qTpSeIVxkrzG4I/qeHkFzs+SjFBKTECYGEV5pdeBrM9JVaOB49rpBkbx/Lg8/xtk9USA
         TMKsXYXhQ89GvPKA69qAhaHkchAwqnMUPpAhqwslhyudixtIn1sEiY2nLga8MS2c69hD
         34fkxbYkUyxW8AjMxTdF+K1g4l3XyRe7YracrrONPYe3WdmzIQ4fF0v+V9flNqOZb74S
         mEQtPmqHwAlTqLqbDZfxvcB1q6hT7DhO1ALbOqWwEm2fVigx83O8JY5CdzBhEAPT7IQJ
         wifw==
X-Gm-Message-State: AOJu0YyTsrWQ7Vd1t1jMGIFNguBJsqO0W/G10RcxHG+89rFIHhaZG9yl
	XtcApB7dTDoLkP6gWnFnfFk4dFRUoJAmiufHKDbl4qTIVp9NGF4dK62RUnvBkZFulm9MAggV/xg
	yCPcga1yCpdOGkJ88gOSkq2gebr95AjBk
X-Gm-Gg: ASbGnctrOqwhW/H5nJc/afNBtRDELWRvNBxxAyWbMBdfEuSoaRfTl2ihf9W4Hqj4wWc
	eRgJmkk7ARLAurzCDhKbMiduF5sLnqIeX6meYu2EXkMBCbgyD5Iq4
X-Google-Smtp-Source: AGHT+IH3MA4CT9GHVM/5HdZTkARYF/eU4HK4GNQPLDtysi8GG4z30Bcc6mh6ByFKaOPmsJEh6amgWPuRmkjuGIZ3NAo=
X-Received: by 2002:a05:6102:3ec2:b0:4b2:5d63:ff72 with SMTP id
 ada2fe7eead31-4b690be8625mr15862348137.13.1737528465463; Tue, 21 Jan 2025
 22:47:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jan 2025 22:47:43 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250121215235.GA2753621@coredump.intra.peff.net>
References: <CACwGqKixQEGau8CZuLwJx02F4h8hxrf9e_7N1tHMU=Wvy8ViyQ@mail.gmail.com>
 <20250121215235.GA2753621@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Jan 2025 22:47:43 -0800
X-Gm-Features: AWEUYZkzqXLTNh0D1t0EL9FR72j2vTRE4Wbqj5k3ZPtFAzoS-UWv8p5aah0JHxc
Message-ID: <CAOLa=ZQt8GFPpqnzVLNw0EfPOWDi8hZC0QOpNytRwDxYYDW0Ng@mail.gmail.com>
Subject: Re: `git update-ref` fails to set reflog old_oid in 2.48
To: Jeff King <peff@peff.net>, Nika Layzell <nika@thelayzells.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f8bf6c062c45de3b"

--000000000000f8bf6c062c45de3b
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:
>
> On Tue, Jan 21, 2025 at 03:40:06PM -0500, Nika Layzell wrote:
>
>> In git 2.48.1, the `git update-ref` subcommand no longer correctly
>> updates the reflog in some cases. Specifically, it appears that the
>> `old_oid` field will not be updated when modifying a branch referenced
>> by another symbolic ref (e.g. HEAD). This doesn't break the `git
>> reflog` subcommand, but does break references like `HEAD@{1}`, which
>> appear to read the `old_oid` field.
>>
>> STR (in a fresh directory):
>> ```
>> git init -b main
>> git commit --allow-empty -m "A"
>> git commit --allow-empty -m "B"
>> git update-ref -m "reason" refs/heads/main HEAD~ HEAD
>> ```
>> [...]
>> The `old_oid` field is empty (all zeroes). This is only the case in
>> derived reflogs (in this case .git/logs/HEAD). The reflog for
>> refs/heads/main appears to be updated correctly.
>
> Thanks for an easy reproduction recipe. Looks like it bisects to
> 297c09eabb (refs: allow multiple reflog entries for the same refname,
> 2024-12-16). Author cc'd.
>
> Just looking at the diff, the early return from lock_ref_for_update()
> seems suspicious to me. Doing this:
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8953d1c6d3..1c0e24a855 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2611,9 +2611,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>
>  	update->backend_data = lock;
>
> -	if (update->flags & REF_LOG_ONLY)
> -		goto out;
> -
>  	if (update->type & REF_ISSYMREF) {
>  		if (update->flags & REF_NO_DEREF) {
>  			/*
>
> makes the problem go away, and doesn't fail any tests. But that is just
> me poking at it without understanding why those lines were there in the
> first place.
>

The reason for that addition was that there was assumed the flow of
`lock_ref_for_update()` for reflog only updates was to capture the lock
only [1]. But this is wrong since this misses the old_oid population. As
such your fix should do the trick. Thanks!

[1]: https://lore.kernel.org/git/CAOLa=ZQqQTEquJ0e5rG168-CVADR8K-uYma7Z8yiDCptyPgBQg@mail.gmail.com/

> -Peff

--000000000000f8bf6c062c45de3b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6f4a2dec1dbe2875_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lUWxJNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md2pqQy8wYkl2VDloTk4yYnRQYkk4RCtTVzdWNHQ1bApKdlpRTWdxdzVX
S0M0Q3VMZXBrQmdpbzBBZC8xcm9qQmtGVUFISURvbXJaL2E4S3pTNEw0TFV5YUN0SW1vaXo1CmdB
Z3JCZzVYVVBuQ1JrVDlkZkx1cHhMTnBKYTBVMGk1YWpRUytlalg3emtCSW9KZ08wVHc3a1dxQnFv
Ni9JclcKejJ0Y2dNQ3hFZXBBSEJYelJKN1NRR0tyNlZUN0V3czZkSzFEUDB1d2VOcHRJUi9iWnlm
V2hHREo4aWRzakF5OApmd1Myd0dzWTdVNTNNTUF0MEVYZWFLTWdZL0F2dFhBeTBOb2Y2Sm9GZlVz
Vmxjc2lHV0NERzNjSy9LQ3ZyZXA5CnNIY3FObjg4aFk3UURVWjFTemFTamFONUwrR0ZFMkFtL0Zv
NndlblFnZ0wyT1gyUVU1RWQwakU1SlVXcko0WDQKS3c4UzRuTEdSZ3VCTXg3V1ErYzlqQ2s3SUFI
TUZzdjgvclRRY2pGa1cvZWZqMkdPeWRPRTNuK2d5QjR0K2RheApVTjhqSkdIb0VhUDBUQktnc01y
dW9BT2FvYzdpTTFKcFJtaDRJWm5FK2tLTHpxL29nQ2NXTUNENmYzQjdYd2JPClErV2NINEw1bTh1
dVExS1JxMEFXRXVhZGN0ajR6TEdrcXhyd1laYz0KPURPU3AKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f8bf6c062c45de3b--
