Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F38B31812F
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114186; cv=pass; b=q1nU8zPSQBW4Tu3oXcWZJR663wwihcCVeWtk6oDZD4lYvVoqC5Ty/CqrnsM9Kosfndl7KxoPyt7US5bxpSF/n0aY9AfqQzgyuJS1Ql7m0u1TRVkreTzl+9L9KxkixjK1+Tu9g0h/6dUOcc7T/sGguRNfPfVyLYrCJhBWxwJed3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114186; c=relaxed/simple;
	bh=+87IevbjIsPLP9+5ln1Hv9YbbEq+z693nLFi17v0CiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zan4XeYJHHEI1rUkHiBu9ZsFFfzS40PeOd0hRf+ScF540pszW+tWeW2AbAWQbgdTNEe9i7LYC5z+CiWIpYiWz02+rrZD1SAs+IAHmLwpElTMnnEmcUrBCASS8ASgGB7CF76+dLKUXzhuW3u/V2pAtrv3CYYSgVJbPFeoEUwnxJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNS7Poz8; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNS7Poz8"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-124afd03fd1so8051369c88.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 02:23:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770114184; cv=none;
        d=google.com; s=arc-20240605;
        b=VgX+UBZ3QU0JEVgnw/zru1HBEAFWVG0g04cmh5i8GNlD/UyMupwq/3eggc2Dk2JkT1
         iDub4aCkNPiVqIOzn38XUhs7dvRVqxuOFgPFjdgyYA59PR7a7/ZKaZgecg50qy7bG1ij
         Hdd4TTpS9RDmX2bkO33RZ2UIz4dlaAzQoYo/C/gP/a+nnD6I1pSc1sNcACUNAdN5vlbO
         zlgKRvFRErmuPL7zHKpVqDg8b+B2bkHI7FYcGzmrQT/QawnSNVxNhfVlm5rzdgK/5rhJ
         riBRz0p4LJpKLSOuyBvIyrCEkBcFfLwZO4H6EE/mla9FKUZnniaLAOpf6gahcE2XZiYL
         TocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+87IevbjIsPLP9+5ln1Hv9YbbEq+z693nLFi17v0CiM=;
        fh=PDV3F6nQTWdTADIGVaiQ2XExtmkqO5nNGftqjraMlNk=;
        b=SPqtxfYKqhBf29wSZgfbJW1wNn1mczDEYjDAnNwlaIzzCgcKrP+WM3eZuF5sQpXxZn
         /Z4sl4w/MA4Wb0LGvv26YbGz0lY63HR6ZvYrVmvByDv3QQkYvgvLheERsdJRiq7sQYYf
         91/e0AwNvKodNsIu9WlTfRpSudmz5Ah1KW+noTQgR7jsjorieJGfOI0Bp7sB4zHJUqbt
         +mQaWC+OW5CFXnhxz2g7rZkd4FMQzmRkI+xOoV6iBfQTH2vFD/0xlonjzp3zCfbAo8bn
         4pXixoUBLUyXggplZHOzHSZE2KpaxLcxWjcsK7n+k5UgIgLr5NWnBZyVbY0PueOupzws
         rUtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770114184; x=1770718984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+87IevbjIsPLP9+5ln1Hv9YbbEq+z693nLFi17v0CiM=;
        b=nNS7Poz8uisaEp+xa5zhW2MWu4ug/v5HtO/LZbh9YOAr7ShbSXy3AHH48gO6UQeo/y
         lbjyZU5E1Fva/fiikFYZCjP0dDC9E/+13sroDqdNflhh98ZmvnWqoHdLuC9pQhabfFoe
         bsyv+0WIb+mhx9HNL+4P/QvdEo89x0VMDLfzHSgVAACc/RrIauIx2nd349If2Res41sp
         vTg82YNQ/ImBop367EmYA+eYnCxIWk/RtWWdRw2OuMRiKzznKbGoDMzfB7hr3fkkovC/
         7b62LKByGbGFDPYl7NV/GjkF6PHPVLlp62rS/1mmTE5dyQiRj5QN5Z+gUGGhMvJM0nR3
         R4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770114184; x=1770718984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+87IevbjIsPLP9+5ln1Hv9YbbEq+z693nLFi17v0CiM=;
        b=PXvNl00458JaXTxXZMQSrprL/te80e9tzG+n+OLoHJAJYU7vf++gWARzlN3S/1S/Yv
         e+RkpNMO0BWFR2WYhIXIfx3LKW7w22+FMbpO++dFK2kkZNGOBmtmh+JnV1L/vZVk4tpJ
         57XoBcSuvPZZKl2gGQSvwCo0XJFMeDXryazzGLjMMr62cDVHUOTW+y97KJX9jV9u6DGc
         0bHnsdcrlbwJ39PCkp6NOHmAZ6VcjAmHbKCwJnRBqMHP9Ufc4zwiu/CZYrVv7WZONY4b
         pnPwUW7lUBMAzDKxajLfMUDX8YELmkWQULj7EEUjcwOQGgz8zeXG6/2/ME6u07t2N12Q
         Z+Rw==
X-Gm-Message-State: AOJu0YysHXOJ1vnDhJy0hDQglq+gbpthtQ4LGC7G9gJG+zDysPSwP38T
	jUMYpIKWawaOWn1W03aqbypjNKcA8StigcppI3wqo+lEj9RTTLFQYFclJfYO7tD80PBe4G0vjpx
	U6bHBdj6MSyL2RTzo5yHGPdysJbHcOmw=
X-Gm-Gg: AZuq6aJtSCUBZJ4DhmQCxgcaNY5cRgqczQ8UXzZEmJQQm1HUqIhPwNWCrRv/rbLAr+F
	w/2ObIjEkk8uWNntSUizR/QuMsi1vyMY1UFj2xkS0wrFSY1T//NziC71LjwC9spTYQGDjd5aBoT
	9gP1JfPv9p39Pa99rQKlr5QEWvEE4wIerErEK+mQ1Wr2eBnS9Q2khkVO7z+kthGQxUNBOIgQZrj
	2vc5iMNSvHR7ynfc+tIZbWYl3Lv7oljWW+AUaAcgAdZyg6cA8ZCfmPhafH9PI/TWt3GNLAqhkPg
	C7nWX8qkRE3xls8KDc0IPFheBkDudQYmeHoz3zUVUSrWDrmSwOMi3YJW
X-Received: by 2002:a05:7022:628b:b0:119:e56b:91d1 with SMTP id
 a92af1059eb24-125c0f7df73mr5434603c88.2.1770114184211; Tue, 03 Feb 2026
 02:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com> <CAP8UFD0kEATc6sU4r2pVq9k2X737Tk+_VXrxXx8K=M6=ciL=vQ@mail.gmail.com>
 <BAD29E01-C358-456F-8E31-058AC0AED0C8@gmail.com> <CAP8UFD29LtG2dRRB4f6mZAHNGqDmDxUV4ULYw3w3OYg15ZBBYg@mail.gmail.com>
 <21D9FA76-F382-483E-817F-C3947C939D16@gmail.com> <CAP8UFD0qtn_1VAA1SiAMjGVF7Qv9qC1GdDmsbkK1xvq=SFxTaQ@mail.gmail.com>
 <CAP8UFD07yEVibYL-DwmRj4AQtdbE600LwQDR3Nf5j9FxnQ+mnQ@mail.gmail.com>
In-Reply-To: <CAP8UFD07yEVibYL-DwmRj4AQtdbE600LwQDR3Nf5j9FxnQ+mnQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 3 Feb 2026 11:22:52 +0100
X-Gm-Features: AZwV_QiYZQIa5-OOZEbGvAWsXtNsuhIwVyE2dwsad3cSeTv8NtQxPifQUrgH1a0
Message-ID: <CAP8UFD3Bf9y-sKfFXBXmq54MQ7AAgJ+5B5O0Yak==s2vUUXruw@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	karthik nayak <karthik.188@gmail.com>
Cc: git <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Meet Soni <meetsoni3017@gmail.com>, 
	Bello Olamide <belkid98@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Eric Ju <eric.peijian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 11:08=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Feb 3, 2026 at 10:37=E2=80=AFAM Christian Couder
> <christian.couder@gmail.com> wrote:
>
> > Otherwise everyone who said they were interested in (co-)mentoring
> > should be listed as a potential mentor of each of these projects.
>
> Lucas, Justin, Siddharth, Ayush and Chandra,
>
> I have also invited you as "Mentor" into the Git org on the GSoC
> website. Let me know if you haven't received the invite or if you have
> issues with it.
>
> Kaartic, and Karthik,
>
> You should still be Org Admin and Mentor respectively for the Git org
> on the GSoC website.
>
> I have removed everyone else, but please let me know if you still want
> to participate.

I have also applied for the Git project as a GSoC 2026 Organization as
the deadline was today at 18:00 UTC.
