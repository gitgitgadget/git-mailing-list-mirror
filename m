Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C31CD39
	for <git@vger.kernel.org>; Mon, 20 May 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716223945; cv=none; b=otd23cH7l9P0IX0sZeiosbNISaa7pc/Q//HDXWZBWR9fQTavWL0xJMIwy2QC8eYDS0JTDEe64itXPVHMhyOU3hAGR2uM4JxHPLJYlge1b6JIUTMpGP4unR0trbKrvVbzNmwdnmGpcaiu+A6CO4z0rf9l4Y98vffal5FirZfsj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716223945; c=relaxed/simple;
	bh=wqMXfvm8aKqXPYetuFD+45rwIXgG1nZi4YNSgmoiTUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsgwSqNNsMR7QYg6MuxTRt5IsXxhD7b8p1dCsX3C1UxbS4FCkydgRSA8rnnRqrQKWMLVW6Cq27rWlxzWhnuuLyxIM1cfTLsq6hYFmLugk+R++dnUNCmf8fyxnmCOF/g0KOEAVKYOq5hE8a5lpttsWfEdE54KguA3RqGdwyYprAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b782287f9so9594296d6.0
        for <git@vger.kernel.org>; Mon, 20 May 2024 09:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716223942; x=1716828742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2dd3mTa2hm5/YMNioaMw9+3xsc8EejCH/3SiUW/fj8=;
        b=gvDQfSTqqF05mYAIjyMnmoYLG7Ojb0X1spuPPKID4IdeXAsEwXmKwdQ+inrZQihiO2
         kS+QNk/y/y80ToU8oaNAz7iNG4SJnfrgJ4q+es2vVKPoPvQ990uieNVPuizabhDbcGPR
         plA7/lcwh20u4oio6KyuF8GVq7Sz+nqE77VcYV/HFfwgGOOu7C8K2+bUX5TwKyUc2yp7
         89VuUCr7RKZj2SzNtbA5mcBjnEArKCdIwPX87Gy0okIy2j7YWuRjXm46o0rY5+i+zniX
         6DQ4Pxj1wQvFdoHsRJlYsskeqrz0x3bV5heuQNCZp4VZ21dqyx46j7SnYfOqigo+EDO4
         A5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCW6p1fE0c0Y25D+RwoDw5+eYQOJJ2D/iQohSOZgHJeaZVCieCFUTtdI+qcnGP/8KoPsZztUEJ5OlOH6F/vzAkODUJpl
X-Gm-Message-State: AOJu0YxvLEHb2yu0huEMFJWfGfF5mpxozFrEIi2hIPztDq/m/WRBJzh2
	4C42sOKSCc5x3YwpS1OU1JFy8kLlFF/ASqZQyGdQLWjijDBT5vP/7VPX9DbHjhVfOVQtUNLgSCT
	BUmXpB545nQQAO5n2v/gYVNLBA6I=
X-Google-Smtp-Source: AGHT+IHiGI8a+4nE3EQAv9TnMlxB4Ft33Sj+oouMf9l4Z0yl2iFhmJCxiRxwDuCDqG4e/tPQD+Ndph27o+N9PJuP19g=
X-Received: by 2002:a05:6214:5345:b0:6a0:b465:6c95 with SMTP id
 6a1803df08f44-6a168140c92mr336124016d6.4.1716223942339; Mon, 20 May 2024
 09:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
 <xmqqseyclaq8.fsf@gitster.g> <503a99f3511559722a3eeef15d31027dfe617fa1.camel@physik.fu-berlin.de>
In-Reply-To: <503a99f3511559722a3eeef15d31027dfe617fa1.camel@physik.fu-berlin.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 20 May 2024 12:52:11 -0400
Message-ID: <CAPig+cQ0eLdFnRjp-aPAzhyNDC5dxfCqKf3i5bqcQ8NviE8LPQ@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: Extend regexp pattern for /proc/cpuinfo on
 Linux SPARC
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Sam James <sam@gentoo.org>, 
	Andreas Larsson <andreas@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 12:48=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Btw, it would be great if this could be extended to support the output fo=
r the
> Alpha architecture as well since the testsuite fails the same way [1]. Th=
e output
> for /proc/cpuinfo looks like this [2]:
>
> (alpha-chroot)root@p100:/# cat /proc/cpuinfo
> cpus detected           : 8
> cpus active             : 4

What would be the correct answer for this case? 4 or 8?
