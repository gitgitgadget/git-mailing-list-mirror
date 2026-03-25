Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB3318BA6
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464137; cv=pass; b=mIHZz6BrTsoawvNrOM6yRFKOd40tVojmbWG0GrwtCxMkN5g+G7vKzAFYr4Im33ppYK5Aa+v0WDM/e0MCkA0hZIrdbAOOvgEz8Dm6p832tzgQhzqvDayMEpicgIPpAqvIhEww3TnOkogfJpSE1cBZ4DE/P70z2fEwxl1XG00pIwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464137; c=relaxed/simple;
	bh=HZINWQZ2BmB7RAtihvuDKlLi5Ubtcsu2whbFZcwGC1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roGFpesfZYOkHOXkV7OB8KVt4lkBTHNCW+dJ0ePsNJMGfjybWbtZPxpMK4vC6Cyh3lUL5S88RXU11gTiDYM5Zk3xiWP9k08x/RvSyF0PbJ/N/AKavcOkDpEXcF1Xe2aeg7VwAPy+VmBikU5IcI37m1JggZGwb6Qcoti8rRUbr+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnvi8un8; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnvi8un8"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-604d532cfc5so66603137.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 11:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774464135; cv=none;
        d=google.com; s=arc-20240605;
        b=Fsyf0CUc6HwtP7RIE7I1rj7NJUbyrUUIyiP9K03lKqbjlgDkiH1VxSU0TD+0jtfGBc
         vdA5w8VjlSBl54sFn+4LPHB+r2AJVJEjrUYXac6YxpfxebqfIuvMcI0sDxH5Q5aAN277
         c9CQKKzgsUNSp6wjSgf87OZud6wyK2cVNzyP7pDM9uAV+zPAwpkkFH7gwswfjoC6rVY9
         1pYKCnoWSo4z8bZ7sFdVYqhfo4prOjSBH6ZBzYATJpSMY7YfqOftjWJtcyyPyO+DgiiR
         QZAKPLzxM77rfeMeZR/0OZipQCBfgX3NM5dcVx3n+v0I/xiwD6UG+iuLVnMVhsvVzIue
         8gdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4qbjdkhPsmuIjyQFKicsE3fsFuBYt1JDhK7UIWSP2Iw=;
        fh=l9w/CK7gb8pPgxsIND20cpOgEiDBd+vkaJjFjHCeOFg=;
        b=lPaggQ7eeTvFuaz6Xc19eR6ib2jyO4B1JLqalpcbVVmt5BehiG38F/vd+PlxxV8VPp
         uMj0qDc8Jhn2S1tkx80xbO41dhpEeIYaYoJeoQUVA25Z0VnbEQsRL63qI8mg2mQloPHS
         OG9G2XJd49UPuF4iHnUbPPHfYlOffeH/i3BJfzg4B8aJw7JMMEkWZlwD1GfD2KWOhE2S
         TV1ZFT7QTiM5he5VhHWDAO1lVeH6Eq0OVdRH8rkpEkl2lBcq5bN4C8Wzj1kXkc+OrYwc
         815YCQJaAmcmi2Vv5Z1gJXvRd9g7WfZfXC0FAx29Sn7t1dZnOESpl/eCnd9UyHWbwW8f
         urUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464135; x=1775068935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qbjdkhPsmuIjyQFKicsE3fsFuBYt1JDhK7UIWSP2Iw=;
        b=dnvi8un8oRsTCyL0HF4om5sk6SGywB4WEbI57pFxUEiGHe7wTWV0X6DLahKt6MaaBH
         KwWNtT99ilpylk9J9mXcsd0q8Pvd8cH9g66G+mNdBKpefTDJv8cozMf5nlinq2Ttn95P
         Hb+VqanKi2XXNKh0kvm5Aw1DtoXVgMF82+3lmN6iiDBRYflrmCxG5r09qRHce4pzMXLA
         IXJnnUkJv8vyE4AW98ZvvBcrbY8k4mNFXgsKDH4VeA/RTv4OuPSKrvCGq/XxA3jdIQBL
         11WHKbBwVsV1GEpgIyGJMBF7o5W8TGK6f9ECV4PsAVK3P4///24rO4iC5ejnLxLhawoH
         7ARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464135; x=1775068935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4qbjdkhPsmuIjyQFKicsE3fsFuBYt1JDhK7UIWSP2Iw=;
        b=YgjinMBFsTO/WGxiTGMUJa9jaP3Jj7YQJr3gO/XB61M5lriDBJsCKs64aK8OCo9o2f
         gXl8p5GhLfbghAfuH9d2D5uI9fCtDW6hscKJDkGjDh81s8viJrQk+ZJhsH1rCTaKmoIE
         PxVEsIs8fmRXDrd5p5Ta+K3A1/0OoGDuODaxNnvOpsD3/EfKtb61PsknVZDrdaFIQX1x
         lEFbFxoFObmZQzwatYGA6tCIPHJhk/IImFR/vQrGFc980jhOk8gtzAMWeIdxC1jRTngT
         xC6YpyWFCiVisg26JpAQhDLhMoZLmydZII5+NQ4BbrbbJHOOl3YYGhhG6G0d9hF/NX9n
         Iabw==
X-Gm-Message-State: AOJu0YxejWWTzdj1q91Mt7tRI7s3g3hmwTP7RBpAkuEuDjy+VzY8O5um
	dXwvMxR1ZWgq+VtLg0L1iwTKSQcU99xqYe5kbBG1dBEvkhrFPn302rejC9Lx4dYfHh7AxroML4B
	S9i82lEhTu5Q5Z6ibwBZ6mP8Grefozt4=
X-Gm-Gg: ATEYQzxx8qKPkhQ7IyjKd2fs2G9SDkwaQRQoO+i/kBkoUgomrGyHWeDsEJs0NdxL9tS
	WcBsP/1E0qFq9D0qb+ZP9P09sg/ukEuarDBP7iyiQn7uOJ78rcXV6FfKPWhXGd1VhjW8BnT4/Ry
	sEK32uGK/nD9v7vvF+/nt5jeNslbDRfL4LiviCfm2AclRJaSgcvNw4a1DA+iHvXchrUo935+lIm
	jzK6bSEBBpmaO+btAoGvQP7S8nwQ5MaxlFjKG+iRzCsdhrYsQt0fNmZNlh1gqcJJgjLbBwaqqdX
	7PvV6jp3uFxPmZw7al2RlGE0/BWtGe907YD09P4x
X-Received: by 2002:a05:6102:26c9:b0:603:273f:3570 with SMTP id
 ada2fe7eead31-60385f6e8dbmr2641431137.15.1774464135342; Wed, 25 Mar 2026
 11:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
 <20260318204028.1010487-1-usmanakinyemi202@gmail.com> <20260318204028.1010487-3-usmanakinyemi202@gmail.com>
 <xmqqzf43lplf.fsf@gitster.g>
In-Reply-To: <xmqqzf43lplf.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 26 Mar 2026 00:12:03 +0530
X-Gm-Features: AQROBzBZ9ERJ1755hfZ6bsPTWbNfbOgwQPQW2jmpIp06afTrG7tbVST8Ho0P4pY
Message-ID: <CAPSxiM_0RBUUOiCk8qLiY1GCKHqjbp1dgzEXEznQKxvQdFNgPg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] push: support pushing to a remote group
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, me@ttaylorr.com, 
	phillip.wood123@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 10:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>     "int i =3D 0" -> "size_t i =3D 0"
Thanks for the review. I am sending a new version that addresses all these.
