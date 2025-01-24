Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE37E573
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737714668; cv=none; b=gnGuRva2ZOyHVknRWdUnrIJVLqF3WCxV6O+AofAEe45LbQGvlWul5/0NtMaqAZXw53eREY6Fm2+em8FMx0oOw7b12SabYqon1HoUvOKhsTXijA9yED4N4GoW4fteCsWpQQwgisdYxEkROJfM67dNrJvu4T/xUJrlp+7rza8GsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737714668; c=relaxed/simple;
	bh=w+FJpIQ+oggcEV/Iq0qAcuaFGrYqNql/TzkCuBGdX8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5LIcjh/1eukf8rozU6VOHmNQbGYCM5oglT5X7bMyZ551zFYjK1QPmij0avBGiM55baaowgeIRXH38Ik/dGa60hnKdoeOwcDRJKtWGoRwW1o2FMF/Vb3sTFvGzIbDQ6XNHd6UfMJhtG9vHJ6Gk5Qqs976fo3VGgzv9Eqc5Lom7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d8fe74cc9aso2314896d6.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 02:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737714665; x=1738319465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UGhEAjty5G8PQkhE3Ee41NiHJxmKA/IIT63n/OhD9I=;
        b=FreKZpVx0mfnjfDZsz9nv6UohLQT+BZgFim68UbV369NFEQpbIU+SrQBz2OXJMBje5
         Gxr3mFzRqSZOyGexlfQzxB8AlYDRV6JkxUi0hdY4UZw1rS2gEJhUww9fzCCZZiv1q4Go
         qLCf5TZQ5iNsyBqSMXMdrlHNXSp17HOEZoYwuPx0TWwTK8rxIGIPvZlZTfZgW2xclrz8
         YZvbhL9tcJ/6CXBPFXCIekHE/1DoLHrXFHswk6LjzExfLYcy/Mx2lc/jZceF73DvWgHN
         c0NM9Xsjp7TWu4RUGTeRawnkvuomXhL/NjSnL2PiLpFjYynwy+I5fS32vp7A0uAggEc1
         a5dg==
X-Forwarded-Encrypted: i=1; AJvYcCULrksAnhUzNebvjxBPWm66tuFpRXmj9OM9odZohY/dgadaWl4y1uaHLuJ/OE6cMxGe4co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zs5NBqC83Ja7pYn6mue4J4rTkRFUQALZ5fDD6ThooI73jvWp
	Hp4LKfsJu15Ce3CHpwxzqtte6s6GPNd05Iddq9P2hA3WkavU7sH5CRy5vcq+QUtKHhx7Ks1IhBY
	gfluSgs3LT00wCVhWuw26YojorHQqMwBF
X-Gm-Gg: ASbGnctqj3YxdN5RxjzTgep7b3ulcO03/jxhmS56kDhtr9es4vNJT13r3CnNhP3Rq1k
	P24mDdM/9/YzcSgpOK9Hg4n4n9nSaso+/JKSHTyX5jPC9WkPRpygc+0uh8ySHnQVKfn8A77uk/0
	STf66gdMnwoU9iA51hHlk=
X-Google-Smtp-Source: AGHT+IHqX9FzRfZF/It57zMrlTlBWYM/LyKdVz51cfIS6gsbd3Sw+MnutdKQ4gAnq1vokrG5jI6HNi4iLwuqCImGy5E=
X-Received: by 2002:a05:6214:2389:b0:6d8:e6be:50fc with SMTP id
 6a1803df08f44-6e1b21d0231mr154871206d6.6.1737714665194; Fri, 24 Jan 2025
 02:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111202628.0e5894e4@leda.eworm.net> <20250112165125.130400-1-bence@ferdinandy.com>
 <Z5Mrk02wMdABtrVZ@pks.im>
In-Reply-To: <Z5Mrk02wMdABtrVZ@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 24 Jan 2025 05:30:54 -0500
X-Gm-Features: AWEUYZnGGKQGPtmrRpSurvgrd7_t9wdBn9xkjHmiPm5lMbqLzGPc5g31-13Ve4A
Message-ID: <CAPig+cTE4ELybkuemQu_FT5BzqaKnVPYYA3dUOA64b7E_v=6PA@mail.gmail.com>
Subject: Re: [PATCH] fetch set_head: fix non-mirror remotes in bare repositories
To: Patrick Steinhardt <ps@pks.im>
Cc: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org, 
	Christian Hesse <mail@eworm.de>, Christian Hesse <list@eworm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 12:56=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> On Sun, Jan 12, 2025 at 05:51:22PM +0100, Bence Ferdinandy wrote:
> > +test_expect_success "fetch test remote HEAD in bare repository" '
> > +     cd "$D" &&
> > +     git init --bare barerepo &&
> > +     cd barerepo &&
>
> The `cd` needs to happen in a subshell. ALso, the same comment here
> regarding whether we want to have `test_when_finished` to clean up
> state.

By way of explanation regarding `cd` in a subshell, see [*].

[*]: https://lore.kernel.org/git/CAPig+cRsAPp1APNJ7W337UNtunETr+Lnn-RcGrAXE=
FUhN1APyA@mail.gmail.com/
