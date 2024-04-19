Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2447F
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 00:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485727; cv=none; b=eChOCzI03NYJU6b2zHCDVbhzQNvrdyfhaeOQX4oVoP0wonkB4sjEOnrwP1o0Ny9hcq/GpvxYH+lyLPRtb/3HazkmbVaChObvVyYy8uS5nZX4To23c78l8GHPq25PhafKlwXVuhWv984mabWSyH0fyiy9XM05vJytdpnuXYD0wBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485727; c=relaxed/simple;
	bh=ttrYOJaNud14srtPULiqMjtJKVb0Cz8ezNSozDoI6YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR4XsKEVMzSGIad1tP/WuC5NmxwEqCEV4l2s7iNqLJKHkoWWDULtmgLynGfmiJgFknrXcQPrnvvGCmuhgpw34RdUGM35iyP56hRQi1MzJyxss+bVcFdWX1tJFDnYyh3JaSGKxWizeXd2FR/XwGh5luvWblxKmsf09TDi/Sv4sPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b50b8239fso15215626d6.0
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 17:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713485724; x=1714090524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHWbgd27RenND1ztW4dPLHLk4T7+y5ilY4vlV8ljfZk=;
        b=DuwxuRCOmcOJgL256bJPzlDynF5m1ZOFOP2ppb6Wu7PmqYxydUJmgXg8mdPNKdkfV2
         t2DKqsKTO2HRY/zE9XVA02zJLpFE6K4kygiPREKRvOxf4f93vURPB42shvdx83hT52qQ
         7sBwlOKu2+jJh0uYBjMTq8ePswLn58v7J6FNe4nUT3oyXhfUAPH8FF2QTk+jO9TU7jqy
         7npo6/I8rL1aNcPXLzlunr75d70kTkumOli3jz+YU4DN7c0kDeXIf4YQjnMtvNkrfRbo
         eL5Yzn+sMvzdy1AaOIOzfoLxbBCTwDdRoL5oNCPXKTyy+fW5N1joijHjNxW+mVyQCNUU
         5wJA==
X-Forwarded-Encrypted: i=1; AJvYcCUOelk/zdf5sOvqlMw5lsOMcaxqm3f6LF9hbgOSHfolshpqGsSKxgooCPlWlVtK/dYR+SdUxOYleoxvMdr2Lyq3qFs/
X-Gm-Message-State: AOJu0YzVAkHBgcMNC/O4qGGyGSPfKw7MQpxnF3O+lMfWbGmCdNEtHfT9
	tar8ohEiN6q7b/xKcKaVM/TDErFB0r/d10Ig2iTEOobOhjmou2TYtzXLDZUOX6QnU4JKEL9G/e0
	jvIwNoIyaSJ9XBtskT9THj5ku/17xe89p
X-Google-Smtp-Source: AGHT+IERKWPpaeYIZjdPRfhOpQrxkRrO1mLBmx3JecI9VTXqt8wLqAX9JW0Ca3ufjth9MyHgCD1P+1wRyIi58F8c0Ik=
X-Received: by 2002:a0c:c20e:0:b0:69b:70d8:c753 with SMTP id
 l14-20020a0cc20e000000b0069b70d8c753mr1625676qvh.6.1713485722989; Thu, 18 Apr
 2024 17:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713324598.git.dsimic@manjaro.org> <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com> <xmqq7cgwau1v.fsf@gitster.g>
 <c2cb9268c29ae4a5cac34383b7443763@manjaro.org> <xmqqle5b66sr.fsf@gitster.g>
 <19d5f3d4c99fc1da24c80ac2a9ee8bf8@manjaro.org> <84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org>
 <xmqq5xwepafi.fsf@gitster.g>
In-Reply-To: <xmqq5xwepafi.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 18 Apr 2024 20:15:11 -0400
Message-ID: <CAPig+cT9A9N=zGZDXuB+c17L8hZ-h5zvZgD5W-8VYqiM9QaBew@mail.gmail.com>
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
To: Junio C Hamano <gitster@pobox.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 6:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> > How about introducing "--label=3D<string>" as the new option,...
>
> I still think --rfc=3DWIP is a lot more natural and easier to
> understand, and it is just the matter of how you introduce it.
> I'll show you how in a separate patch later.
>
> The problem I see with an overly generic word like "label" is that
> it would mislead readers to say "--label=3Dimportant" and expect it to
> appear on an extra e-mail header, not as a part of "Subject:".
>
> But we can do this to get the ball rolling, without bikeshedding
> what option name to use.  Until we find a good name, users can
> use --rfc=3DWIP and when we do find a good name, it can be added
> as a synonym, possibly deprecating --rfc, and if we never agree
> on a good name, that is fine as well.

I remain skeptical that adding such an option is necessary, even
though I made a similar suggestion earlier in this discussion as an
alternative to `--resend`. I'm especially skeptical since the existing
`--subject-prefix` covers this use-case already (i.e.
`--subject-prefix=3D"RESEND PATCH"`). It's dead simple to use and
doesn't require any magical incantations with corresponding complex
implementation such as the proposed `--label=3DRESEND$` which renders as
"[PATCH RESEND]" instead of "[RESEND PATCH]"; `--subject-prefix`
already handles this without any need for magic.

I do understand and am sympathetic to the desire to reduce the typing
load (hence, the original `--resend` proposal), but I have difficulty
believing that `git format-patch` is so commonly used throughout the
day that the time saved by typing `--resend` over
`--subject-prefix=3D"RESEND PATCH"` warrants the extra implementation,
documentation, and testing baggage. Likewise, I don't see the value in
`--label=3DWIP` (or `--rfc=3DWIP` or whatever) over the existing more
general `--subject-prefix`.

If reducing the typing load is the primary concern, then a very simple
middle-ground would be to give `--subject-prefix` a short alias (i.e.
`-S`). It's true that `-S "RESEND PATCH"` doesn't reduce the typing
load as much as `--resend` does over `--subject-prefix=3D"RESEND
PATCH"`, but it seems a reasonable alternative which doesn't
significantly increase implementation, documentation, and testing
costs.
