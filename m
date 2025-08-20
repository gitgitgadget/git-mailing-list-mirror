Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6C10F2
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709572; cv=none; b=En2f2YTzbJJrVwYxDhQtgGJ72Y+ZZOpgIaPtDgxcLpMcC11s2Q26Q4WDc7kE0SczfozVLgGaexeV4x/iFRzqJIeMWMyxqnnAo/orBEwNCLgInjVXPLXAuPrIqZBFooPTl+JKBZ9IhxvvPVDigGB8T3v/19gIbFZrNIoJ6zTOn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709572; c=relaxed/simple;
	bh=5j1V5WyzXyuGD3rqqYgJvbrL9j2Oq1raRk+3WHYNf7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rk40UNoLEk5OQMM3etrreMbjTMvLvkwlFbJwil3bLBAfj/QnZ970sNh1QJagPIvvqDjroOdF0szSCAjyQLLUD0piOzGJKgVBMm9/emH6T1G6iSYfqbVTDbVKSN2kUcL9MPjEeLzujHmQVK84qzg5NdJecVGDH1i78yXx1tlPl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=donorschoose.org; spf=pass smtp.mailfrom=donorschoose.org; dkim=pass (1024-bit key) header.d=donorschoose.org header.i=@donorschoose.org header.b=2oOAvJxg; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=donorschoose.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=donorschoose.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=donorschoose.org header.i=@donorschoose.org header.b="2oOAvJxg"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55ce528a0f5so21696e87.3
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=donorschoose.org; s=google; t=1755709567; x=1756314367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pWCTC4f2gVXzEgF8asDDlzsYJ9box3Mx+UaHsICiQg=;
        b=2oOAvJxgqAF5EwV72Uejvg4BMA2LOLCDrSBHssc4/ugeq1J34hLwAgGQzKulaLhI0+
         I6UbCruHwP4snDYLDExycJhssfbqhb2Ov4NEED4hl6mCqrHLJedaYVGBftm81GJYPhwa
         yjfvgDe9nLyJee6ijewxOq5yoNVk9qogtrch8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755709567; x=1756314367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pWCTC4f2gVXzEgF8asDDlzsYJ9box3Mx+UaHsICiQg=;
        b=skdl9d3gzuqXHhAIaAZ9Lt74vJ6Hpr4QiYlpt35hK3SDcplLsIzXPVbEOTfcgSUWcM
         Qh0KSfPjAUEpSIFWZff/KySnYBHy/IkqWvexac4G8NaJQKLi8gL9a6aI1bDjwOgkjptT
         IogLP8o46VSn2G7s3PwkusD2F1Q10s0rOER4fU9a3iQfkKnlMBQov6t20q2q7TvSWHNd
         i4SK0a6UwwUeXBU58tLl/SmAPSw+EqRoBPu7IPdIKJ1S+cd/m8x+taHkL6u0Br5l1MV2
         9xh1+W81+D69oAOXAGHBR44xNaUIHbjnSVroYjsP+LTr8yuk39pfNLP9Dcz0JEXx302g
         JOhA==
X-Forwarded-Encrypted: i=1; AJvYcCXKupj5THmRzWbxViVn1JScLZiKEKbQ54EsSWorXmyRjgB1lQsUeEBujKEaizdV1l9+CFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzThxmhUYckc8i5z0oDka3Mo0r/zFIXaOl2Lsy9hDk9IZwVffui
	sgHw0H/7j5Uvbd2Y2M7Hag0cSs0Ej2oUNG/GP7r7fH5UhPYC0/PREinrseBoq+FwHtePdQRsz2a
	CZnVvcwHbN3sylCicLmDe23froYCq6p4upMkqrxN1
X-Gm-Gg: ASbGnctrNGVx9uNZm01n+rDNX4jTRAMWgOQIW/8A05DGfavlxB8JqGqe87ac+JeJfMM
	V4kw+YKZ5AL/kQcb6r04YKocZ/NZDTRqdZdxd6G75KMZcoSmLOBmXmJ+vI/dYpcBP2MQseajZhj
	dUBuWv9gAsuDgXvRJJ/jSkN9zJF2JE+Tqm122WSUpfGktvt42x/+R+HQvOqulihPluW3mrOObwb
	AuTGH6V
X-Google-Smtp-Source: AGHT+IEhLG2IyUxtsLm5oh3fW9NYCZ8dnLx8EUdo32oOrJSc5WgX2GZbdj9i+lKxfeOxMxoAbmKoT+9HyqUlGrbop0g=
X-Received: by 2002:a05:6512:2113:b0:55b:8328:d2b6 with SMTP id
 2adb3069b0e04-55e06b96194mr782298e87.37.1755709565972; Wed, 20 Aug 2025
 10:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com>
 <011801dc114b$f38bb130$daa31390$@nexbridge.com> <37da14fb-fead-448b-b6a0-853c9fbea653@app.fastmail.com>
 <xmqqfrdmaqg4.fsf@gitster.g>
In-Reply-To: <xmqqfrdmaqg4.fsf@gitster.g>
From: Chris Judkins-Fisher <chris.judkins-fisher@donorschoose.org>
Date: Wed, 20 Aug 2025 12:05:54 -0500
X-Gm-Features: Ac12FXy21WQtSqa7b38Avq2fWsxf9mbk8RKTykF-8lSZeRrXwkocFQU4gP9-xT4
Message-ID: <CAAn3O_2iHVt5TctvwLLSXm5Nw2wS8e9Xk0is1=k=-qRS=gHVMQ@mail.gmail.com>
Subject: Re: git whatchanged
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, rsbecker <rsbecker@nexbridge.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What I actually type is "git wh<tab>". That does result in less typing
for me than "git log --raw" would. For now I've added the following
alias, which takes precedence over the full "whatchanged" completion:
whatchange =3D "log --raw"


On Wed, Aug 20, 2025 at 11:49=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
> > On Tue, Aug 19, 2025, at 22:57, rsbecker@nexbridge.com wrote:
> >> On August 19, 2025 1:51 PM, Chris Judkins-Fisher wrote:
> >>>I still use git whatchanged
> >>
> >> I did too. However, now that git log --since has basically the same
> >> functionality,
> >> Perhaps setting up a git alias might do the trick for you:
> >>
> >> git config --global alias.whatchanged 'log'
> >>
> >> so
> >>
> >> git whatchanged --since=3D"2 week"
> >>
> >> or something like that should continue to work after the command is
> >> removed.
> >
> > You can=E2=80=99t alias core commands.  So this will fail in the report=
ed way
> > before Git 3.0.  Then from that point out it will work as an alias.
>
> Not quite.
>
>   $ git -c alias.whatchanged=3D'!echo bar' \
>         whatchanged --i-still-use-this -2 --oneline
>   7c10e48e81 describe: pass commit to describe_commit()
>   :100644 100644 72b2e1162c 04df89d56b M        builtin/describe.c
>   8cfd4ac215 describe: handle blob traversal with no commits
>   :100644 100644 f7bea3c8c5 72b2e1162c M        builtin/describe.c
>   :100755 100755 feec57bcbc 2c70cc561a M        t/t6120-describe.sh
>
> Your alias with the same name as a real command is silently ignored,
> and when the real command disappears, it will start working.
>
> Having said that, as "log --raw" is even shorter to type than
> "whatchanged", these people are really better off without such an
> alias.
