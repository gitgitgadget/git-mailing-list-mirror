Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0361B6528
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955050; cv=none; b=ZaD7P5WkB3R9yP9YneynV412sW2Eq6GyzP50vzYHCtDZbvWPWgpAcC6NrVLSTQs3DwouhsS0NE74ly+iihpOjmai3NNiQXkhetEY1P/b/0ebLGteXz3DoJMY3QStdgoxe+griS8p4KDgWN/DJewjuqZCZ+7XjJq+lCw4E2ePQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955050; c=relaxed/simple;
	bh=gSrbWrZsocZ7/4n2HcOV6QXpU2not6uTZ2h06SEqkqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlpWr6U8RyreUJND23BT2EijScx8Ad4uncPesTeoyoWzySsWe3Nx0XrrzajS/pxtLS2pfkU8azl8/yfU2JmV3DCwp6pYPsXAjCzEh2vd20nJgCRPmglsIZAH7qUxk0ndZfDi/H4nUeYAn+Ah+kVkgOTHuAWakagE5MOPOqfqNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44fe4b1dd19so1009111cf.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 11:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724955047; x=1725559847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSrbWrZsocZ7/4n2HcOV6QXpU2not6uTZ2h06SEqkqY=;
        b=m5g4WF5gTTg0vdibvrHw1GXOT/jGcuOKWynBkXmQQ0HhB64+Mi9qQ4kC+rUEmIZMtA
         fdTXMCqBQJfHQbLi5kp27bidJYjjdNaiBt8TkMX8+zh6ueTJl5e0jUii9beCA8CNl0hl
         5GAuwug0iYFBezkx3nlcriI+NQDQXK5ejKnN7AqGgYdzXN1av188AbMlae/445w9/oYJ
         ZZUPt2l0Xfv+3TbvN+NKJswxoSv+Wy4IwzHMKOyqfx2poUdlKCJloVwRnRKIIbp0LBFk
         vS8c3VqvRjAIUXpT0dUEkalPKq7A+9HVjBpoOu6B78xKeKAKiae3ncfnE6IBhNfm6Yrc
         GI4g==
X-Forwarded-Encrypted: i=1; AJvYcCU0zrDG5A6XiTQ9e5sa3KezuRmCI61DfMJdWfgR5o4bWqZgvEiFUiNIEQJmuG25JpdMs0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YykSGaT2cRapPnbX4sUUc3us8/vsLgC2WXZQhwMpfruvxosMdmr
	Sf+aNFowHNkFvfoSamLwoDyK22hgu90qusfi4JljMOPJ9DhpwgSgNTZHeC9R26bWHdWFRtp1Kyu
	DZ86G4JzliRVrtlYkmgu0ostDcho=
X-Google-Smtp-Source: AGHT+IHpoS9QewW3ErhM68iXdxmR+Wac7wEMSIHLj4ie0oTsRJmtYygA1ffMFalT94A/ob822Nh9zjmNTs4dGnYsf/c=
X-Received: by 2002:a05:6214:2481:b0:6b7:7832:2211 with SMTP id
 6a1803df08f44-6c33e614be4mr23952316d6.3.1724955047462; Thu, 29 Aug 2024
 11:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240829091625.41297-2-ericsunshine@charter.net> <ZtBHbftK7vdTEz93@tanuki> <20240829170712.GA405209@coredump.intra.peff.net>
In-Reply-To: <20240829170712.GA405209@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Aug 2024 14:10:36 -0400
Message-ID: <CAPig+cSWoQ8pkdy3gyRQFUwoQ5ZytK9HjobHd3EJxdFRJhDWxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] chainlint: make error messages self-explanatory
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:07=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Thu, Aug 29, 2024 at 12:03:33PM +0200, Patrick Steinhardt wrote:
> > I find the resulting error messages a bit confusing: to me it reads as
> > if "ERR" is missing the ampersands. Is it actually useful to have the
> > ERR prefix in the first place? We do not output anything but errors, so
> > it feels somewhat redundant.
>
> I wonder if coloring "ERR" differently, or perhaps even adding a colon,
> like "ERR: ", would make it stand out more.

I considered both of these ideas. Coloring "ERR" was dismissed almost
immediately due to the (admittedly tiny) bit of extra complexity and
the minimal color palette available (and since I couldn't trust myself
to not waste an inordinate amount of time trying to arrive at the
perfect color combination).

My first draft did place a colon after "ERR", but it seemed
unnecessarily noisy, so I dropped it. However, I don't feel overly
strongly about it and can add it back if people think it would be
helpful.

> FWIW, I find the existing error messages pretty readable, but that is
> probably a sign that my mind has been poisoned by using chainlint too
> much already. ;)

Goal achieved.
