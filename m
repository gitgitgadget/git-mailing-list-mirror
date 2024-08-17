Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC50184E
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853721; cv=none; b=gExdceeFgLWoZDbMTj3NHFw9oyVB+t3h1Thmc3WIpnO4DmDm3yQenXbT6Bi6FCUyRD/tqHaJgAjwE8F0OtNcoq7xRV9UJ+BOZKafAxgvgX1pCOaHJNE0sHk6Z63wUORe9q86e9YN/YjIT9O/XScAHO333Nplv+SsKlJyYi5HcgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853721; c=relaxed/simple;
	bh=07UKURzUDA4iERd4002VxfTXuBQkeV6LKo64XKqj/EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=J/cUjzagu2hMyNiQ+asBlspIOhYSPCzWbGVJGXe3D3JZ3hegnv9+HU4U7I+XmueJsOEVVmD+p1WTqcwp6n6XDRP6NUuUKwNgbLIiN3pzTy1FtYA4fSM7LH3qSrliTgc88L3tUflEvXD6ZBx3VO7nqL4FG+pOYCG3ON2jxFJT+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf7a2035d9so16937036d6.1
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723853718; x=1724458518;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4p3utd5+UYqmIFGENlSORggp64ED5X+2sf8xp/kAyk=;
        b=U2fAX7unlImW9x20yin4dPm0QtqlnTtw0l8fl4Gz+K7lL8SrZGATgzVJ3Gb/o2RvRv
         NTTqaKM7FcPmdXAbuEZTL27VzdJJD+DxVP9T4GVYIINfu7UC94ya0CvtEScdPeW+459Y
         6CAzsY9U8OEsxSzAyepEyZaH/9ZGw5stRVgFs98nBsb6TKYtBR6UcOEGi1OLzjIWU8rE
         TNCwBE1fpy/MZaB3+4huWpj2zgzJql4peyJ+jR3MsS/ybm9aIU2SGbNyS2BMc7CtONoK
         5Ai+lLOqB0ryuuwheYjzVPTjgEbLSLdIIavWzb+xvnCZucDZOT0ihbA/CPu23lNB4PD1
         B7OA==
X-Forwarded-Encrypted: i=1; AJvYcCXIqR8z/YxA7619rc8eh/xPnsBIC74IUIR0Om2ypwyTP3eyUiSJ9gtQMDd/CoMwo8R1BMEokRmOaIU/bUXTcssmUp7t
X-Gm-Message-State: AOJu0YzzjRV0dYfE0KaxFKirQWCyufFOJ2TnRcHZ/4Kn/Fug1ZDDMS0l
	adv5UYJenTp7tlw1S8EqCF2P2w2WZ2/56y+nWiYjJ25ZJCwLuSOfcxViiswudA7XLTcHJ497Plp
	j81w/cAe61ly6vf6D152KtSgw4F0=
X-Google-Smtp-Source: AGHT+IF/UT/Le58t1Cc8Iy+A5rGCugzx5iG1txgsifGfXVHXsOPTwmvFzlPnM2/Em2pHJTijlUePtq5cKECbweuqBNQ=
X-Received: by 2002:a0c:f40d:0:b0:6b5:2f57:1a63 with SMTP id
 6a1803df08f44-6bf7d5b11c0mr75338436d6.21.1723853718431; Fri, 16 Aug 2024
 17:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com> <cover.1723242556.git.steadmon@google.com>
 <Zrdn6QcnfmZhyEqJ@zx2c4.com> <6398d60387a6607398e4b8731363572e@manjaro.org>
 <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
 <xmqq5xs688cz.fsf@gitster.g> <CAPig+cSVNqBPjV3_41f6Ag2X4+-q4HidEo0D=1UaMG-Kv7pa5Q@mail.gmail.com>
 <k4cokm5xtwazlv44ys2uzmrfufubbq7tcmcwzasuccog3zcojf@4ftvda4nfqxj>
 <Zr86bF3y_YMZx0CQ@tanuki> <Zr_G59cz9HwtYUk3@tapette.crustytoothpaste.net>
In-Reply-To: <Zr_G59cz9HwtYUk3@tapette.crustytoothpaste.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 16 Aug 2024 20:15:07 -0400
Message-ID: <CAPig+cTYd_AbzKeXUnbY1cW75xzHC7n4u-5pD0Q6ss8TdX7NEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Patrick Steinhardt <ps@pks.im>, 
	Josh Steadmon <steadmon@google.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, git@vger.kernel.org, calvinwan@google.com, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 5:38=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2024-08-16 at 11:39:24, Patrick Steinhardt wrote:
> > That to me raises an important question: who is the one fixing breakage=
?
> > Hypothetically speaking, if I continue with my refactoring spree to dro=
p
> > `the_repository`, do I also have to fix the Rust bindings that I break
> > as a consequence?

I share Patrick's concern, and it's one of the reasons I posed the
question in the first place about why these Rust bindings are being
proposed for Git's "contrib/" rather than as a standalone project.

> If we're testing it in CI, then you are responsible for not breaking it,
> even if you don't use it, just as I am responsible for not breaking
> Windows, even though I don't use that platform.  That's typically been
> the policy here and elsewhere.

This is an apples-and-oranges comparison, isn't it? Although the
majority of Git developers may be Unix folk, Git itself has a
reasonably large Windows user population, so breaking it on Windows
carries some potentially real consequences (i.e. hurting the immediate
user community). On the other hand, the Rust bindings under discussion
are (1) as yet effectively hypothetical, (2) will almost certainly be
relied upon by a tiny number of other projects, and (3) impact only
developers, not users, of Git-related tooling.

As such, it seems far too early to be placing the onus on *all* Git
developers to have to worry about the Rust bindings. If, at some point
in the future, the Rust bindings gain significance or become
indispensable to the Git project itself, then the onus might well be
warranted, but at this early stage, it seems unreasonable. A more
friendly approach to the overall Git developer community would be for
those interested in the Rust bindings to maintain them. (The case with
the CMake project files is similar. In the end, the people interested
in utilizing them took on the responsibility of maintaining them.)
