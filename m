Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D425D911
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684512; cv=none; b=E1DMKPAXoaUJYN+Kdf22fRf8QuA/LqpVXCyIHzZC9h/PqBCIs8vVEZldCCXJ5/VpTLpAinEnHLmCNGWtVfR3P4GqXFNGy/PydZ15Wq8ZG7FV9i4F4tROOpQB6VNWKxbZ7Ahfi3Cn2Rb8FsxsWUqhqELq/uhXV45qp9OQImoOGmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684512; c=relaxed/simple;
	bh=X33yoy2uWEARdDMyXepo0ZF8QQE0VLZX3JKS/HKt0fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxygXuaEYmeyBwI8yPWQAol5rFm/MeYf3RWSpQwN3yeBHoHk0+ywzDufvpPciWXB4JXkOd199K7X56Ar2bblj7M8E97au0K/5w30pq7p1An/BvKZdoWDC9H9Y99yfgabbRsBMlXQW+YEZpgo1pNkRYGVicD0uNDDKPg1H9voGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfNBk4WO; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfNBk4WO"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d2acdea3acso4117055ab.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 11:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740684510; x=1741289310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm8uZb74X/wKVPb1wvtTS+53rxd1f4w+XjbAL+iIsIY=;
        b=EfNBk4WOdcQT56Wvp0iq3dwALdvvNpU2KZRdM8XSHAU2oJ53nGQ0liUZ5rUoCTmyMi
         dEcNmQyvFzzOH5MWMl+nWXGjtyGZUvVxpCrgC8fZvje9FvLKh22rH2VvI4XqCnoNkA7G
         S8wEnedkP4oAE6iMbVbz5AOzjPB7tbMJrYMQc5/CD4wIFVR1O/3FdSocA1r1iD3qU+6L
         cwK7PuYjsg18f2N39zsSeWQBETarZcn234JJ3uluBMUkIcifb7ISPBoJViHQYWSu3r88
         V6o2EbEsNfYhlZWzX7t7xRuWPTSxdStCzLnsnSOowjX+YK/YELPWcQt6atQB7r7MxeFV
         nkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684510; x=1741289310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nm8uZb74X/wKVPb1wvtTS+53rxd1f4w+XjbAL+iIsIY=;
        b=icPzSTkM4p6jc7QA1EKbab1FLVO0PGmK4uaiPoHD4WjdBzLIXvXofqrfHx4gC/ys9a
         bYMi6CDsbxFjzILdTiQk7faDj6qEX0IDlvQpWkwRk/qFso8f/h+H012ewB+sZIn37f0O
         FcRI2cIVayiHOvgv7KsnUFrpK+xdrE/mWQYqKvYByymKI0oId11aMOfi/2c7fJ7kmRuR
         FfKjV/UCaDha+uoch0UCpkt32rPFr9SWxvhUH9+E+vt5kQjHq3qeYiVtZLR3wTNYPv9s
         YeRdg/HN9xEq1zFaKxuDLBUVFbACaJBYG/54enIWcUIZpNoBvUdXL19UU14PyB9+zHA3
         XpAg==
X-Gm-Message-State: AOJu0YwMS+OYX9P/5SufIs70bOdkphFq7khx0UBvYrHfl5djmO5IVf5n
	MXOH/gDT8xp9lmoLsIHmOr+9PlNNVB/8JhjG/NWQN7/lvOdNW1M6PPOILCi7bJWsUx5q9UB/HlZ
	7h5b4e2TDtKpa+uDBfmHldoyyk80=
X-Gm-Gg: ASbGncsBmxKo2PJU8j1CnV7w9tG/OxeIA9svInTn+uOnLA8mlZ0nOn/KqfEzSUg7Gf5
	e/RPLSNuImWTSZ8kxuBHy3M0ZCJ1VKmRi9wJDxF3SY/NV9HAhrKu0r0lh06vwjx/Yl0iQKAS10U
	jGTimpI2A6aKIiXOVWlzo/n9rqldV+qhNa9O5j8611
X-Google-Smtp-Source: AGHT+IEHYgjw+xoBK4t4C6aD9jFT8ahObdpj60zxK5JM/VTjDaWnyM0o//v2vO6I6zXswwy417RxBZ98fdKmbsC0kcw=
X-Received: by 2002:a05:6e02:214e:b0:3d3:e470:6d5 with SMTP id
 e9e14a558f8ab-3d3e6e70825mr5159455ab.13.1740684509939; Thu, 27 Feb 2025
 11:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740680964.git.me@ttaylorr.com>
In-Reply-To: <cover.1740680964.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 27 Feb 2025 11:28:18 -0800
X-Gm-Features: AQ5f1JoLp95sFfYjHAcirz4IoUwGCHDc4sY7edXBVzS3UjQE1NE5aRO2OcPK5V4
Message-ID: <CABPp-BEK3T28iqDFxbMHa7GVrythYs+ze7wCZ5Q-LDjOmquiVQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pack-objects: freshen objects with multi-cruft packs
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:29=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> This short series contains a fix for a bug I noticed while rolling out
> multi-cruft packs (via 'git repack --max-cruft-size') within GitHub's
> infrastructure.
>
> The series is structured as follows:
>
>  - The first patch simplifies how 'repack' aggregates cruft packs
>    together when their size is below the '--max-cruft-size' or
>    '--max-pack-size' threshold. This simplification changes behavior
>    slightly, but not in a meaningful way. It occurred to me while
>    writing the second patch.
>
>  - The second patch describes and fixes the main bug. The gist here is
>    that objects which are (a) unreachable, (b) exist in a cruft pack
>    being retained, and (c) were freshened to have a more recent mtime
>    than any existing cruft copy are unable to be freshened.
>
> The fix pursued in the second patch changes the rules around when we
> want to retain an object via builtin/pack-objects.c::want_found_object()
> when at least one cruft pack will survive the repack.
>
> Previously the rule was to discard any object which appears in any
> surviving pack, regardless of mtime. The rule now is to only discard an
> object if it appears in either (a) a non-cruft pack which will survive
> the repack, or (b) a cruft pack whose mtime for that object is older
> than the one we are trying to pack.

I think in (b) you got the meaning reversed, and instead mean s/older
than/at least as new as/ ?

> I think that this is the right behavior, but admittedly putting this
> series together hurt my brain trying to think through all of the cases.
> I'm fairly confident in the testing here as I remember it being fairly
> exhaustive of all interesting cases. But I'd appreciate a sanity check
> from others that they too are convinced this is the right approach.
>
> Thanks in advance for your review!
>
> Taylor Blau (2):
>   builtin/repack.c: simplify cruft pack aggregation
>   builtin/pack-objects.c: freshen objects from existing cruft packs
>
>  builtin/pack-objects.c  | 118 ++++++++++++++++++++++++++++++++++------
>  builtin/repack.c        |  38 +------------
>  packfile.c              |   3 +-
>  packfile.h              |   2 +
>  t/t7704-repack-cruft.sh | 106 ++++++++++++++++++++++--------------
>  5 files changed, 171 insertions(+), 96 deletions(-)

Code changes look good to me, but I had some wording suggestions in a
few places for commit messages and comments.  (Sorry for missing some
of those in my preliminary review before you sent this series to the
list.)
