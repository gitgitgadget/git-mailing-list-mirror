Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57140859
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662248; cv=none; b=TXP9rLqVKWUjXmVobsLkgmHvsD31bRQtEYxe2hPnGgrCNt9+3P3bOZEe8YkgN7cDLpYeU01hJXh3Sfb+p80WI246Efy8d01ryPv1Xs2BOcvEZZD46dqNvEiQdJQ/BmHkNhOofK6k3ePNauAzeYbBya4BO9aq24dTQJdpdqiVNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662248; c=relaxed/simple;
	bh=/KF+KnwdCzcJJsYXDsHD7eVo8639iLIX1H788RMNcr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4VjGYOwtuX0KdBuE5negSio6krW5T5u2ficMKtE00jEnpMLQ93IC+eWpmDRBjrzOcUDT0nKz9qThSM4Kd4yAAkOWCXeSriu/7MzS3IxqLN8E52wqbYtFwJOIKJcUmQOhPkoHQOiNk1MPdfrvDLCZYiZoICK9AoaTbjLdivQ9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUUeTlnl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUUeTlnl"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513e6777af4so2291673e87.2
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711662245; x=1712267045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UdJK9uh2SsqZc471mC643DXdTYbhBWy1FokAfqMmIE4=;
        b=JUUeTlnlJ4+r3LA8SovjjBwTUO5oM1p7ayzgcXH2VN3UICFQ1TqKwA3juUzfYARTmV
         nFsxXOJsTr+MU2587ApCzDiUHHX/rxjnc4eRB38haR4WZQSQtYKbkCz49WNbuEfLQyg+
         lAmNewJvVv01CpvlqgwenpEpRT/oT7665RIlsCmeq+snqpZjDve7tRp2fi4cCxB0EQUP
         ymCeI/7UX+MrmgqZmYiwcirZ61V3QP9k92v6FTFWmxck8SggKTwENLK1qTYary5bMh7J
         v2ieWqLLtbJXcbwdXT3z+NCrmEhEGqM8/FCGR5f0K1fI4lXQKymXxwp430J1N2piMymG
         DHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711662245; x=1712267045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdJK9uh2SsqZc471mC643DXdTYbhBWy1FokAfqMmIE4=;
        b=e8HYkiwgEQq/baq4Njpbo0SStA8xo+dJJ8eDt6mfIkSbCLg3wpvoY82tqWhP7i1KWb
         rah1tBwO8bS1JZGMD3JVwUxNPxz6e8FxR47+TV7OUvNytZw2B6vDZia1PSS9FkDO28oP
         6zEpom6uql8En3kDmPR9sBhs/WIUDBwK2z2MgqywusdsPcyK9X0OWKrqoM3zIWE4uklB
         +W8nK50j1AR4QOci32pDkJq90cagcTqNLizwsKQpwdlMFXw1ANYYlZaE64Lu5ARFPAyB
         HiJCMey4eP9LAsNIXmQvL6Sg9t4CfAvvbCe8iueGzgG+5f7szYENmNvOcaHl3sOW6c4A
         xlUw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Nu0AFEHXaj72Lbca8prf/wzIa0SJJ/Ianv+uSTSTpLVtYNlpoCCzEVmJoeRS0LTnEEttvXu054NWhZ/YYv/N/EV7
X-Gm-Message-State: AOJu0Yw+j4mlfdcbg8fJHpYOkHbLZ+WBiGtKKPj+I0eYK9yVTlkleVR/
	WWnY1V9k26oUGrjqKy7vkIbiKZPy8CnpEvfsw1AK8UwC5+w0cWPMwRO//C77VgMUqBPkJlzMc1f
	QGLajDGbi4axzmk+otfo5WvPw/djPbCm6
X-Google-Smtp-Source: AGHT+IFBFj1TUOojQYZZT1OIeHZgK2z4zDrFIG1Kmk9TYF7DJWwSrdrb6ajpUJF5oMlMczF+JyAk0y33g0JdYRK6nbU=
X-Received: by 2002:ac2:5196:0:b0:515:c9cf:7245 with SMTP id
 u22-20020ac25196000000b00515c9cf7245mr576310lfi.38.1711662245099; Thu, 28 Mar
 2024 14:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
 <xmqqo7ayuwpi.fsf@gitster.g> <a9cffbe4aadd319760635ca6d5b4f465@manjaro.org>
 <xmqq1q7uusin.fsf@gitster.g> <1b81a013dd0faccdc24fe018fd740755@manjaro.org>
 <CAHfn=+tsrgAyUUqUkq4TpXcABr7=ZcH+cna+vwALJqZ3H8LxFA@mail.gmail.com>
 <26f8d21dfd53d699804485b0f8c6abe1@manjaro.org> <CAHfn=+s5_hvV1osP1HFjWs4wxRfr9YUW-9=WkXbgSp-8sPZ-Qg@mail.gmail.com>
 <de182310842ea3ff04c171a271587ca1@manjaro.org> <xmqqr0fut7di.fsf@gitster.g> <fc4ede3ecffd33811adca702493c8763@manjaro.org>
In-Reply-To: <fc4ede3ecffd33811adca702493c8763@manjaro.org>
From: Eugenio Bargiacchi <svalorzen@gmail.com>
Date: Thu, 28 Mar 2024 22:43:53 +0100
Message-ID: <CAHfn=+uXhAW+7YG6R6BAeTOcWdrGQjUwGYCT6QJ3u9d9TwaySg@mail.gmail.com>
Subject: Re: Better visual separation of hunks in `git add -p`
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It seems to me that the two options are orthogonal: allowing the user
to add an arbitrary prefix is not a block for allowing the user to
clear the screen or vice-versa. If anything, the arbitrary prefix
seems the more general flag to me as it at least offers a way (however
unportable) to perform a clear. So saying that if we do not allow the
user to clear the screen then it is not fine to add arbitrary prefixes
seems strange.

On Thu, 28 Mar 2024 at 22:19, Dragan Simic <dsimic@manjaro.org> wrote:
>
> On 2024-03-28 21:43, Junio C Hamano wrote:
> > Dragan Simic <dsimic@manjaro.org> writes:
> >
> >> Of course, users could pick the right escape sequences for their
> >> terminals, but as you already noted, the same configurations could
> >> end up being used on different terminals.  For example, even SSHing
> >> into a machine using a different SSH client could lead to a mess.
> >
> > There is a separate discussion of conditional configuration based on
> > environment variable settings, e.g.
> >
> >     [includeIf "env:TERM:vt100"]
> >       path = ~/.git-config-bits/vt100
> >
> > where the named file might have
> >
> >     [prompt] prefix = "\033[H\033[J"
> >
> > so it is certainly doable.
> >
> > It is a different story if doing so is sensible, of course.
>
> Quite frankly, I think that would be like opening a can of worms.
> In other words, if we end up implementing support for the "add -P"
> prefix, allowing the users to do whatever they want with the prefixes
> would surely be fine, but only if we implement "add -P" at the same
> time, to already provide a reliable and simple way for clearing the
> screen.
