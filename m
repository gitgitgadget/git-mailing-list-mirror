Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7511170F
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721098786; cv=none; b=rBy4zKDhqC9YNUMrht+ZP0LrAHdIeDnCbpFNp6y8luSVxAKdLgkfojMIbpWQDerDog63w5guna3EAu1gcCjxyr9v4+s5X4wNpj3JWINFvQOA3E8kNn7SndwIoyAA5CIT3MCeVnqel3Obv4IIV1+yzMba/0LDdTJBoW2+u2dL1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721098786; c=relaxed/simple;
	bh=EpOdS+5c22BuGoOcSyqt2lvP8krqIaUkcR4LWQe/SWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZOO7nMqqSB6HAZNdwIA7zOtTV2u0tlobcShE80lgsPkksjj3skdsN67QuS73VH9tjWTpso4As7a3lkXNXzuJAo+VR8bCf0fOPi8fwvfRBrqiogdjqrKAfRD8nR3uF4l90lPlu0ZRTXO/Et0aGKjYB1L5MZ8B/gHO/O1XvDKbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhkPuH5C; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhkPuH5C"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-64b05fab14eso47417417b3.2
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 19:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721098784; x=1721703584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpOdS+5c22BuGoOcSyqt2lvP8krqIaUkcR4LWQe/SWE=;
        b=EhkPuH5CtDtYt4kaO932RVDUftKfqBdpnStPxeKWATHVfbQ+lSTKcM3GlE0L4/g6B9
         3UHye0UjlZoiG/VohecOmmloGLrTQ8yEinnkKgtLMklch8aNlJsFts+dxEUb9nPzEH2i
         lXeLr3/6MGRZ58L7mcFajnF3bzGYki7+7BqPy8vO5mPDzK9fR+HG2YHoRyXSDl3o10EJ
         y0AckyzryjTszj+bSm6PPeOhIZeu7oYsErxHcfbHzOAnXhytnwFaiODJOIYOHMHvCLtj
         4fCtajgk6jpsne7JoYizjWWlIyH3MSiwWdUbWbc24JjRs3UEtVKvvj0q9RHhCVl8Ml+Y
         TXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721098784; x=1721703584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpOdS+5c22BuGoOcSyqt2lvP8krqIaUkcR4LWQe/SWE=;
        b=m1kM27AN/gcPdel3dIT1YMgexMhyHjbj8BOqUk9H1SV3zRv0Bl/78/ejIVxp0CBpAB
         ef/urMpuxI8hiNguJveYnKZA7biR/djFpmXwZsuvl7+hL0xChb/xgWnFFwc3bzb37ai5
         3bXEXqAv2CGHdQp5h/ni5aVg34okloBG8020MUXpsjGOzyxHR6NEwW8BXzOTSCMxsVt8
         xw8Y/KbwgRFEY6o398RuTwMhjGVaeyKgoAWuYNTJULrwwdundJCgL9OzJCZKjbrOzhc4
         0R/ZZhsLwoxki7fCjlnK0mPDDbWROg5YqoV8HpoUg5+gM8ENML60mso1hhbGQt25vBgF
         OMrw==
X-Forwarded-Encrypted: i=1; AJvYcCVYtoRq/Hp45gR/7EJIX4jLHbXBBdtrJrjU/HRbUIhPLxDc5r4x2uNSNH1A/+v2mep7+WNlkrA8IBLqdBO3r+9KrMkD
X-Gm-Message-State: AOJu0YzjY+2HXVNmfKDot/qw/YVSbg20ZuJZb+5VHio13OFg+IR73Vj7
	gI3lwe9DSGZzG5/moPbOFDJe6vvctyZ4eIdjTzZbQxuxrIlpsp5pq9QZtHZkPSu1oZjkxwPcIPV
	kfHwqk0/621G5Eo20nVRDnyoINLk=
X-Google-Smtp-Source: AGHT+IGMYzeoMOGmeo4loeFFxo29/xCoHqrq/iZjxS8OBFza9kS4qJCdwkc5XaVcgt6DWfV8fk9JjbfOOGIYiHh7Ey0=
X-Received: by 2002:a05:690c:4b86:b0:627:24d0:5037 with SMTP id
 00721157ae682-6637e34217bmr13103587b3.0.1721098783971; Mon, 15 Jul 2024
 19:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240628190503.67389-6-eric.peijian@gmail.com> <CAOLa=ZRH7=Uj77Wd4WQW=KR8ppKw6nXZRH7pNZpHBPz4HhX8MQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZRH7=Uj77Wd4WQW=KR8ppKw6nXZRH7pNZpHBPz4HhX8MQ@mail.gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Mon, 15 Jul 2024 22:59:32 -0400
Message-ID: <CAN2LT1A2c6M21GtEhnBN_bNYOW7csKOgK9fK4-f1HKPa-Vb28w@mail.gmail.com>
Subject: Re: [PATCH 5/6] cat-file: add declaration of variable i inside its
 for loop
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 6:16=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> Eric Ju <eric.peijian@gmail.com> writes:
>
> > Some code declares variable i and only uses it
> > in a for loop, not in any other logic outside the loop.
> >
> > Change the declaration of i to be inside the for loop for readability.
> >
>
> If we're doing this anyways, we could replace the 'int' with 'size_t'
> too.
>

Thank you. Fixed in V2

> [snip]
