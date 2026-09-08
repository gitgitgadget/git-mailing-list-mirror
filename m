Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986AD59575C
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887523; cv=pass; b=BWEnt/GZ0qrOr9mAhGbbj10uAcK+wJ2VPidR9OSV18z9FUPBDyhIndxaI+aXsVZXoZljz/oOxkdm1eJo+Y490eLmvA8EfYoJ+t3o1cJnLFkx1F781Snm8bH43/soyh0HvfT7o7ZXaV9zWwL/fcx4bqSG6L//fkozfdefnaHIeFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887523; c=relaxed/simple;
	bh=lYh6pBf8ago/JI+B8rT0os1qeJdwTiDtVd5dcHpnmkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcchYaReQychli8dcs0V+sEMcIHYKmZ67hvwLXOASnMbYzybM44/83fgtJFiP7vBDDYWbjImk3oHVrEy/lkPMAPC52XFp7Gf8XZ77e8nO3Q6bNrGSu0mhljNQ+7KU5whi6LL4RXnwbnYpECEn71vyKAZZrMv+P445QmML1Zlmeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4/Va8d0; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4/Va8d0"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6bc7a8b4802so1195876eaf.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 10:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788887520; cv=none;
        d=google.com; s=arc-20260327;
        b=M/0F4rMvhW6Cv+14Lsxd7hXlPYvoOxjwI332fMAjAsVehDuqlxRnfIpuOh1/tDz2DI
         rQGpleRcUjW40Of8k98t4eGYaRRqxckaQgDEYv0i2zZcdEKCdv3P7hYQ3iV2fr/MsZXk
         OdXHtA2M574AEVvS2XZlPuzs/yq0M8jubNfQRO281UctXjG9v74RMwVQQh5bu/7Zc1V1
         SrKE281rJ2bjYqae/1HxncbA92wkGW6r+ANvnFb+uHF4D4FNcXhRP2TLQ6NqRX7yaZac
         AtTBOCiirH6Nqsxa2nxmbOwOy/3YqITRlgwQpT7MDLa1TgfTP7M9s2i0ZrOLuH19frth
         GOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4q8YooNvtMqpIFiAqs1UMcByByFAKsHcWPZeuNVxe2k=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=SPX066wOZbtGhFiSyWef3+xRytVdip1GzS7+qly14cQuvI/txyadRRfLZMnMBgM+aC
         MtjiNVzdJMqfiamC5Xo3ECI3HYznLsGPcGvbP1fE6KsjyYreVJV8Ja6TDy5bjDE2Z28e
         FPbuD2TeQRejIBZXifGt7ci2/2Rqw2xilVACTGhtNRL+6y/L187eqUph1/cFU00+Sdch
         t4Xybgc6GxnpuUTTZw0GVmAnIiQn92IddF8XASqzAIGXk1RfuGvW+MPttU6xvqqQ/mqt
         NMPdvd4KULyy4CTeT2kfNUgB6mCV1lcOwtSUwo41yD2nuM4tsBQCPoNjZZAMCtvpyBuM
         Kz3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788887520; x=1789492320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4q8YooNvtMqpIFiAqs1UMcByByFAKsHcWPZeuNVxe2k=;
        b=s4/Va8d0DU4QmOglvagFR/lRrVAONX8jlTp79Y6Ui0X+NmE5gJcRWtmIgXOqgB9Gzh
         ZThYB64yZM39Srpu78eVR2VMNg2Dwt0Yw0tuFIFjDmdQ1zP4p1TBGh19bUT4pVzfNaZv
         krfr2vI9cpvoF48TS1furndCD9zAB7+wHhnywtIEVkKUQl+gf75VIWzDjacMbJVzYRUM
         UTFN8vlr8tXSbI6gGQO+8cRqWrlhTleG7Qwpr03NGLDyi4GfD8L4ER0nBc0xWSZF1seB
         QAcfPp87ULbwFnv2gLZHIgoZaxGtwSUJ4A2dYUhqkn/6qxkSTmz9L+tfNB5UZDtcMJ7G
         Z1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887520; x=1789492320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4q8YooNvtMqpIFiAqs1UMcByByFAKsHcWPZeuNVxe2k=;
        b=bzLPFo2e3peRq9kgx++Lqx0UlCwj7TSQHNBqb4+0fILcscCd0b9/yU4lNIZNnOnVIn
         lLJnj+z9LC5Lt7r2hHI/mvR6+po/l8AUjA5BixU91mV5U1/3J7mgXAD0BD1laW6+TaJx
         WLOTKh4CB+hdE0vod2/t+9ju4dFvCbVo9P62PbiyF0ifO+T3nw1wYQ8wOJeoJ2mx3CHa
         z/qSH0Gg9dvRWhFs59DVD/gXYUND8tkoFPkZVB6uPmCvuA5b7P/5XTVrkWU9yfrEMbIW
         5p7A5XNcKoHIL0KHMcOw+GIhZfQyO8A9EKrTT3JLcA1seunl29hB6MBODM5SOw25XmTZ
         jrjg==
X-Gm-Message-State: AFuF++l9LXBKkxNfwFjGe15uCAD2KH3zLUgjZwPkaLTsv0HxTZ2bXLGd
	6PP+bOt81cDLGGi+L2N3itr7AiJHmM5GlQAEoBG6KqhDWml88Fg6iaXx7BlFpM20/rr2RcoNLWW
	ivEJmplKCzalD9Avaj0i+i3sbBZG9iPk=
X-Gm-Gg: AYBFou0VsoLgmzks6mZvPJl9t69YDEcs2wlHNMP/52sgjykzBGKnQpt7AJz2rzyOxK+
	58zsXpQ6IgMeZ3oVGG+QbrB/dCzp+Vm3cQyl+1Nd7aJzHT4rYNZ4cdC9UFt7VRoMrzd6NljIUxH
	FKSWreu7G8gMDtUG+JH3HurV+o1UhKSp8F+cncD8mq9f3LRPlTMzzVit6qgUEAqCIVG2tJ4BTMy
	t+6ccH/utKgKZtM+SgGimwjFk+jnZL9fHvhKKlcXprqtUWOinUCDKkRyO751jWK7JiIpSGkBvAL
	GcjlfBDV2j/ONMlrLgC0CbMPW0Hw/QCekwapsb7WQIz8J244bcHXDKckNgMzSJq0QHZugxPLViY
	yX/eb9MvBt9DJM0D0sziHtSn+hsUzoJsDpWy9C80ALAyHDeSVNycDrxGsXBXfu0SMZG/BvRUBPu
	q1fHA9WXXvgYWkssDzRd0sLxPB/DHR
X-Received: by 2002:a05:6820:1508:b0:6b7:83c5:fdf8 with SMTP id
 006d021491bc7-6b783c673f9mr15764812eaf.57.1788887520040; Tue, 08 Sep 2026
 10:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807135511.1818458-1-christian.couder@gmail.com>
 <20260813154748.2378747-2-christian.couder@gmail.com> <xmqqjypsoami.fsf@gitster.g>
In-Reply-To: <xmqqjypsoami.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Sep 2026 19:11:48 +0200
X-Gm-Features: AcwNN1UvLhT-eyi4ZquB4euX8yFbmBtuNMd7I-6admzJ-pjCcTqScLtQ3VoiYe8
Message-ID: <CAP8UFD3DUAYpBpfcrub6CPJ0AHFvJGEi52=eXYwrBT+YXpu7PA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] promisor-remote: factor out lazy_fetch_objects()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 7:49=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> Perhaps writing it this way would make it easier to tell what is
> going on.  We try the preferred ones first, and then fall back to
> the other ones.
>
>         return (try_promisor_remotes(..., true) ||
>                 try_promisor_remotes(..., false));

Yes, this is used in v3.

> But more importantly, I wonder if keeping the list of missing object
> names in memory will later turn out to be problematic in real-life
> applications.  Without knowing much about how the current code for
> bulk dehydrating promisor objects is structured, I expected an API
> that looks more like:
>
>  - bulk_download_begin(): performs the early part of
>    fetch_objects(), sets up connections to the promisor remote(s),
>    and calls start_command() on the child process.
>
>  - bulk_download_this(): after calling the _begin() function above,
>    it runs around and collects missing objects that it needs to do
>    its work.  For each such missing object it discovers, this
>    function is called, which sends the object name down the
>    '--stdin' file descriptor.
>
>  - bulk_download_done(): tells the child process that we are done
>    feeding object names.
>
> but that is not what I am seeing.  I guess the current arrangement
> cannot be avoided, because we are going to fetch from more than one
> promisor remote.  Under such constraints, the way to deal with a
> massive number of missing objects will not be "streaming" like I
> imagined above, but needs to be done differently, like spooling to a
> file or something silly like that.
>
> In any case, except that this avoids checking the environment
> variable multiple times, I can see that it is a no-op refactoring of
> the existing code.

Yeah, I prefer to avoid working on a big refactoring in this area
until we have evidence showing that there is a bottleneck here.

> Nice and cleanly done.

Thanks.
