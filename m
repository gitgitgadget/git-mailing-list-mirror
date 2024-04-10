Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23902523A
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712719802; cv=none; b=C0Nzyhv9voApNbJgi80vNe9xdTkdzAqcpLbOEVFRCAfj4qRH6zfvSh5nvleRyKUSYCO///QNyqgVyZ87riXDJWoZShUpFD37HMjoEJmT5yti7loDKKIru4Ini+fOJhR7dN6AnT0v/L+MMB97c1J+VB2kTgzDRrHOC5neiqWTAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712719802; c=relaxed/simple;
	bh=HyNJi/XzeMgI9BYy8/Gd/dU0UwXJhOBjq11l311Wucs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POHRXfbq3z/mFJbrXYEt5zmCA6JVHC2s6KPSVviag84DpKju+0JQT1HYHJIwdGI96A5mnhhT/6DkL7jXCvfvIMv7wFNMLh/08sbG/JHlfuY5o1o9rGR+G+0MjYZacjRHdOAfqNV0zq9iHVP4mjb3sFiZXFNy5T/xiXnLOHwHo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b224e025dso10499976d6.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 20:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712719799; x=1713324599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFJAJ1XBoxpKWqChLtnNm556gdI1VLdsEUpOxIldugU=;
        b=vVpudTCrZArPruI2E0cVHNCkGkXWQ46t3oBzzFKYWf3rPHtXOoQF8WYkSR9ZJe2lKc
         U+9rdk+WruLabMLrLLbfsU+w0HI8fnFiI4zxHH4cjphP1jhOggxjj+EfO2FFBFQ9UVK+
         KbDN9dnqHI2VFtIEXdSxalK2ZBK/7xcupGuHMQ+4hL/x+SXt7NihOrOUL7uLm2e3m/XK
         9Knw7Dw17Ec4eOn0toMyHCVsOBEKmO5WRKs2fSC9f9BMWdvkQi+cGFvvaG7jQrQFvjdT
         w0FbmWyju7S1nnziA5DFcFl8Hn94l2lvikRAZWvyEqdCsU5BpmW0wDtIgdxfktIQqUs/
         I6Tw==
X-Gm-Message-State: AOJu0YzJ8bf3YvVjGx2nE+COYKI6ltIbpvl1UjNzA60jzvaOlnmFKnM1
	/DdT3tFhlobCCKgZZ8QFc+83mtlYj2mDJNZUp3+3lo4nYOYF12k1kxHlIlGiPjdQrATUF6hCsZB
	ZDzPZVR1rfvmCIKYKV9vyZS+ppmI=
X-Google-Smtp-Source: AGHT+IHKHk0kmqa6bAA7atDSpiFWXUsR4nEcWnUX7uSMw4mREvMUUbFgNd+/oBL6zr1AeJG2e9CEBHIQpYrwWGI9Mdw=
X-Received: by 2002:ad4:5b8b:0:b0:696:7d37:1a6b with SMTP id
 11-20020ad45b8b000000b006967d371a6bmr1794308qvp.56.1712719799056; Tue, 09 Apr
 2024 20:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23a4298eababe54ca4b43d7b675b858605d20ec5.1712374021.git.congdanhqx@gmail.com>
 <20240410032812.30476-1-congdanhqx@gmail.com>
In-Reply-To: <20240410032812.30476-1-congdanhqx@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 9 Apr 2024 23:29:48 -0400
Message-ID: <CAPig+cSX0VzG7bRzh6XPg-cAauXanMo27yk9yERD3dsOi6bsFw@mail.gmail.com>
Subject: Re: [PATCH v2] t9604: Fix test for musl libc and new Debian
To: =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:28=E2=80=AFPM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4=
ng Danh
<congdanhqx@gmail.com> wrote:
> CST6CDT and the like are POSIX timezone, with no rule for transition.
> And POSIX doesn't enforce how to interpret the rule if it's omited.
> Some libc (e.g. glibc) resorted back to IANA (formerly Olson) db rules
> for those timezones.  Some libc (e.g. FreeBSD) uses a fixed rule.
> Other libc (e.g. musl) interpret that as no transition at all [1].

s/omited/omitted/

> In addition, distributions (notoriously Debian-derived, which uses IANA
> db for CST6CDT and the like) started to split "legacy" timezones
> like CST6CDT, EST5EDT into `tzdata-legacy', which will not be installed
> by default [2].
>
> In those cases, t9604 will run into failure.
>
> Let's switch to POSIX timezone with rules to change timezone.
>
> 1: http://mm.icann.org/pipermail/tz/2024-March/058751.html
> 2: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1043250
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>
