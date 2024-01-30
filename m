Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20167E84
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648002; cv=none; b=NbZtMiaZkbWEEq66Sd/9iuSkyo1RKMDNId27UlsQkwkG6WXthqPP/StMWe/kQll8ugbblAh2v2LJ1q8Ifc2goSROdMarug/zFuUiy35SoQmjKIt1LjQunMxaSXfzkQnHNh9Eie/3V1EDoy8IqQtrTT6IDJ00awgLmAVnqk1wqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648002; c=relaxed/simple;
	bh=8x+SRZOM+M2J/wYt12qW3av2IWUfGnsLqbZkF6jGzVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc+oQke442oKkTqLVga8oFNr2Fg3ylZtPWgjA31Q57NiXh5XLYRRo+Yw1I8/GUQSNdtzYwOmYyRqhpTxpLyX/XOilz785P0a0yXTWPSo1gR+ntW3eq7kI3IP3dlpJk+cBabAQ5+0eweFV3Brx2y4qJoT3vx4e1Ch3pL6R5D5Nws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c4673eff5so21945546d6.1
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 12:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706647999; x=1707252799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6VsSir8fQIJPWEzchQl3qQqdP21gFUeUpiQUuquoCg=;
        b=lsbVrw31v9NjNUu02ZPMoLgyvBnyU9S9xaHNN6oj7MBpQR5AOq3tghk3JfqH/ANSxd
         Zlsk7f9r6esaR7gAABPzsWfANfFkhILf56GfsmZZTUZfWzK1WnmLhYuTUxfE19uCFALw
         2MvryHExSvuL6s+hm2dCqBWTyVHovBGu/8PII78TQMq/1gjHONKIHGWFYwddep+vP4tb
         +jM28Z0qhedd6tPde2tzMHHb3BvxP7rLA+bLRUegHPLZL6vcs0wWlMJslmyPJ8VZkk6u
         KDpaSaTyoB75sGxBjkk0/jjMe86ULdfxoJSNoVNl3Y/pJ9F4dNtr89NiMvPxsneVvDcJ
         S8kA==
X-Gm-Message-State: AOJu0YwGnpmX/8XUCzC24QAkLCbebxv3FYWoi6+1+o+wHftKfSRUfc3Z
	IoKqAh2j2GtmWCjoGgVG2vDHtHJYQGuyNsxghjT0liLnyvYSds3Iygg956NuZfinYdUjf/g6w5k
	RRRfpuJyluDTxlGK96lzthnWjhJ0=
X-Google-Smtp-Source: AGHT+IGx9d6C8zoSyvMt5dCBr18aAdYgPq3+FgBixx/de4nB7JqdP9yr+Q0pgntoQzaDhr8os37M6kPJHhFdbcY6wPk=
X-Received: by 2002:a05:6214:ca8:b0:680:f8d2:c828 with SMTP id
 s8-20020a0562140ca800b00680f8d2c828mr10104701qvs.16.1706647999591; Tue, 30
 Jan 2024 12:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv87aabk3.fsf@gitster.g>
In-Reply-To: <xmqqv87aabk3.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 30 Jan 2024 15:53:08 -0500
Message-ID: <CAPig+cSmSjifRXsotTrdjjFsh0N4w+BzbZXKffPyn_rpirBVUw@mail.gmail.com>
Subject: Re: [PATCH] t0091: allow test in a repository without tags
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 2:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> The beginning of the [System Info] section, which should match the
> "git version --build-options" output, may not identify our version
> as "git version 2.whatever".  When build in a repository cloned

s/build/built/

> without tags, for example, "git version unknown.g00000000" can be a
> legit version string.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
