Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54257330B22
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072749; cv=pass; b=RmzkxzR57DR7NfHXzWOXYlj17YuVc9ep+QByLHOTYz6NN14GTirxaS/uAUD4QpofuMaxUQxP6Y5wtJR8HUlj3dqoQK1RL7M54KKrvagfaCMiaH30R5iZpEZEoQbLRGNQImPukK1OVewi9b7zslV2c5Y5Bcm27l2Nvut1hndci4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072749; c=relaxed/simple;
	bh=3MJ5SiAB+/JmNzvWB9Uxw8ikWh9/MaKPlWqlviULBUU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cO6DlVLusNNBuXkQuEfDHcBKgfetBnoM4PUzrKl4ZO1nDN9+YiD9B6Bj51kiuyZjIshYYClKGjQmmYl9QEmxoTyzWZhESU6P/cgRJVMKkT0Y5G9zVM+adMXdaTf69kGBQ7A9tplSYwLnRNEKt0IYEPM6R+L/JX8zaO7tnAneBNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzxI0IEL; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzxI0IEL"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9480c6f8b43so188533241.2
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 01:05:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769072746; cv=none;
        d=google.com; s=arc-20240605;
        b=KRzoDoyhLYJNvRqBX49QKkKwCymatyaSXTS9LOzn8Dbcwf5IshFh0RMP++lfCG0+Sg
         TFlDkwiWTxtTXnzywbjs5ROWay+ZFy9qtAhW5BPOZYE8iUOHtC1/sIGKI9kAqiQYKzm0
         wgCOqBbLRDwBERgFGF8D39YlkckejOu7vSujqfi7zAUfcAAtYjD78xYyzP04BfUpl+wM
         hOQ62gkXnNyt8QJRv/aLB/T0GWPrxoliibxE9Dvp5KV0q7r0HEb7hjrHFIIfcRX//MfF
         gnpS9/L60JJxLllgWUDLwM1NHgUlD7DFYy8dqnJ7Qp7vfOZcP2tpKOYdQCBMFvlR6hH9
         zf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=vc8LxrlXp1TRy8cJVzj2adVuQyrkM/i39URUQkIbqXw=;
        fh=tgTGuaRN1GeKD8B4glk9fdd2/0h556MnuSKCDjvRgyI=;
        b=NFrx5hXnLqq8w9lPeQGjbz820YfePQeOjNKGRLO3y2xDy0RPu5mrPGiMW/57wCWhrT
         VrG8lHBTIwOxX2rZx3bOqc0+Ci2HI6ocsm6ppOQqEB6/gv5cjmGiwtNOTIdl7b/mM7vj
         sGtshEFeXaKjkrYdUxB3dMb833RaaGrheJgyyzdPM/Easha5sd1gXe7PxNPkoocSQsfq
         Zr68o/AodabRsP7Gs5B8VT8zCJjHcGn3g6OxMvXb2gT8cFAL5S6AvI2hu5KpGzlOEfG3
         82fhZFDq27HnjkcEOD0JrEtYcSqGaufgwI4W/mTbxcJFN1PgAHBqxtbWhg1VPwDcBTkT
         aalg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769072746; x=1769677546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vc8LxrlXp1TRy8cJVzj2adVuQyrkM/i39URUQkIbqXw=;
        b=gzxI0IELCjOXtBwqjgt/tjKgIMZ1jQW4yculbzbbPG8OOKIeg9/SAARaa8/O4lFO7c
         SIndhxXYcKOSFHE7Mh+46ZUZg7iUJJMlAqRuuUuo8dc+dAZdSd25M5JBmD2uc7/AbIht
         Z8IBQ+iEB964fv3C/IbtWGKPDj7uMoXt6OFXhSWSR2EJxa7NiK0ZmuCnUbaDTljf1Dkl
         VMhutYLpo7lAG3CFQjYTNhi3x8Y3nTqZyb2ufVuqBvtQ7VaCMdDAsTVuFpiZnFe4RP2n
         zTYMjY814ESXskY4xu0wgUh0R7AbA5QyE0IlIzgXmYG4mxe3D+dDNeSbjy3blB6Ftfcp
         Dd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769072746; x=1769677546;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vc8LxrlXp1TRy8cJVzj2adVuQyrkM/i39URUQkIbqXw=;
        b=fX/OdAzDgRDBNR/IKMMOhBg9cRhkxBID5Lxku09DY5HEr8qF6BFAQiHyoFq1DUDQi5
         WU+C+TibGqoOxIvP4K64cunNCRdXHjtj79/Ij1w0cGRAmZ1RbsbP9NQAHSfKjWiwSrzm
         Z++LiOa17h915ptL5RY/Z/I+rvaqphLrUXtGLjw8qIxJNIpIdzvFbX4hi2upCZEza8Nf
         WtZo2mEI5fzdM+frg+iuFYZhsNBrxbafH4F2VbGaC8+5llTin+YN8Zma7agqAyktmEo/
         pR0NHmnU4Zb6p9Y/iGR5IyJzRQbVJiJ8Yn0bbRl0lDqc+LQqRVm/htXoirKZCF0cayO2
         HUEg==
X-Forwarded-Encrypted: i=1; AJvYcCX4moxcJKJ/aTSpyXmYViGf9UgEiOGFhMHHwu4Zd21cYItZ04bPy3fLi0VImvQo8KvmiNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+1tPacdFFi0PzkSXpB2myFWEP4DGzLgFBoc7vmisTLpg91t8
	OgDjC5c781sp1MbYYdrQVqBHU8PKud5dAJKgIuLxL0EJeqGxajPMRLN/Ttk9et91W0zC5lWwRyl
	4JSHvHSDSOem6lQ/D2wb4LpXu98vZNFk=
X-Gm-Gg: AZuq6aIGYgvfKEFZEv+Z0+wui3bczninayWF9VgJISFPO0j30E+AuUWw9sn+OTxVPM5
	j3shkvbqGAYJa+b8Zb2VFBoYZXo+F/5Kz0TqXPrzhORHO3OFamVhvlmzybcowGJnG/3HQ05pWPi
	ns2G3w042fNCroQPBWp0WHaN55Ctkw9pvJNIIa3zY0LVUpx2d1k5Mo0Fr0lMpHOZOQ/szpsLRfC
	3b0G+nprIRI/OG31R03+ExI+KQN0Nq9o57Qt4urzhXzG8Upw8MoIciCDmZEqGZLJUbCIRjdO7W1
	/Inj3GrpjcE3PbvXLxJQYIGMtQhp
X-Received: by 2002:a05:6102:3584:b0:5ee:a1e5:6504 with SMTP id
 ada2fe7eead31-5f1a558f790mr5931264137.36.1769072746066; Thu, 22 Jan 2026
 01:05:46 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 01:05:44 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Jan 2026 01:05:44 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <67808128-5f41-4ae5-b224-a76048cd82c8@gmail.com>
References: <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-0-e0edb29acbef@gmail.com>
 <20260120-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v3-6-e0edb29acbef@gmail.com>
 <67808128-5f41-4ae5-b224-a76048cd82c8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Jan 2026 01:05:44 -0800
X-Gm-Features: AZwV_QgYhybtUiPV5gW0Ciw7zlrzhnNmWSDEDhZ-UTPpiyVhyGjgGuHiMsREnls
Message-ID: <CAOLa=ZRO1gH_pdo6Z1xpx5N5u=Unfhq7wyV8EHUiB0zp1+AhJw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] fetch: delay user information post committing of transaction
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, newren@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000009c9d720648f65825"

--0000000000009c9d720648f65825
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 20/01/2026 09:59, Karthik Nayak wrote:
>
>> +struct ref_update_display_info {
>> +	bool failed;
>> +	char success_code;
>> +	char fail_code;
>> +	const char *summary;
>> +	const char *fail_detail;
>> +	const char *success_detail;
>> +	const char *ref;
>> +	const char *remote;
>> +	struct object_id old_oid;
>> +	struct object_id new_oid;
>> +};
>
> I was expecting that we'd pass around a struct like
>
> struct ref_update_display_info_array {
> 	size_t alloc, nr;
> 	ref_update_display_info *info;
> };
>
> rather than passing a pointer, count pair as separate parameters. That
> would also allow us to use ALLOC_GROW() rather than reallocating the
> array each time we append to it which is rather inefficient.
>
> Thanks
>
> Phillip
>

That's fair, I was considering an array and didn't see the need, but
using 'ALLOC_GROW()' does make it simpler, plus we'd totally remove the
need for the double pointer. Will change. Thanks!

--0000000000009c9d720648f65825
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 99a96f2ef3061040_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1seDZHY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menFLQy85cmFUTzlzK2tCcytiN1BBQ0RGWXlzUkFhaQp4WjQyMThJUXFT
YTlFL1V3dXc2bUY1ZzhoaDg0S3ViZ2xVVlJ1ZTF4dXlKVUtzd1N5RzVGemQrYVh0cEVJeVplCjZZ
UTI4TTNucXEzM1ZrRlhGc3dscnFpOEpFS1l4eUpBRytnTmR2a3NteStvSm93ZXBlZ0VJeTl0Q284
VG9tUWUKcWwza1B1ZERLNGFMRmlhVHVLZVk2cVFTc1pQd0dtd2pCemV4MUJIemdsbEptN0FlUUds
OHZFN1Z5OGdKSk1UWgpkZVlaWVExQmFYZzNMUU1ROWE4aGJvV2licDcvaVBDcmNQZ0tGOXZFbVh2
T1ZwK1JZZnN3S2FHblR5TEkwcG9yCmRhZEMyWmRDVWZIYllWeG9ueGVVeksvak04VW51ZWhsR2hD
UEhLZTBBb3F3Mkp1Q3RPbklvK213Z1QraTJtU1cKMFhDM2lRcUIzU1oyQ05CV3JnT3FHMnJpZERv
YVdnMU1CLytxdThWTDVIRmNZSENNVHR0MysvdHFFbTJJMFV4cApJOU44WklUakltNUJmUzRDTGtv
RW1zeFZCcWZZcGVibmhPV0RhSEFSZ3Z5RGFBSEVZMEFtK05waWFNRElCMVAxCjF3QkZTb0I4bjNS
R0pNSkMzYlJDelVnNld6UXpzRUtaUUZnd3lZTT0KPTZrclYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009c9d720648f65825--
