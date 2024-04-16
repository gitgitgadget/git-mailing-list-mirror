Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0F42A89
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265313; cv=none; b=q1tP9r+PEPV/3ek1Giv7mTFbicfT1xGuoJUaquIj0XxWHPD1aiDPQTLr6+LVqhDwrVHzaRfHbgDFthJo3Y0ePcsNkkZpzNHquTSfn72nKMxJEplPc24qf2E0qRK5pJ1uXgbBeAlllX/GOeXjNEVj/J7XZrynSYhMbc7FPdvcpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265313; c=relaxed/simple;
	bh=Xjx5hFWpZYOg+zBxaCdFvpTqYIvwAUU8FFK5lr85Scw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKifg0IA3pSfgsMkd1Qo26Escz6UaRec2/HC24eZ/VFywX86DJeTKxB8Ld7jcS7aOrqWhxWFYwDwwBiYzdIbhckw+uLUWaCRmsAtuN7xSRA2k1e3xZKaSpKfb3jk4NZrGGNX5UhfoYJicueFe4qYN7ZeqK27tV0K7+IDb/+2Nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7yJiw9i; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7yJiw9i"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso537648466b.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713265306; x=1713870106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJ/EKWiGQYCjMyRyaLc17IgnAUNIkzbIe8xS83lMsNU=;
        b=h7yJiw9i3hxQYaOaYk1jr6XDEPRAOq0lxzlkh0FyhfHjAwxWN6MhImCbMmoANO5rvz
         gQ2WB0pYMQw70i1oKExNdcX1aRPIezlzEnq0RehHZoseiOzPfZxd7dOFxcGZhFA36K66
         Oe10wqQHrv4HuXwSyROH4sZvluKaw1iCHYKKM1np/8BfEhFkUwKuuo0hCiQ2SuMI4QDE
         ocPzpaYV/QLzds6cqfKsjjIHpQ4jKFZDLHONIPAHetkKChsUwIzxOO+gWBENZWpf/sdk
         z1t2oiBgAsI6r2zWhJzTolu4oabLcYPl8sjChLf/KY+T81nwjp8FROZsTAWr2G5xLM7o
         YWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713265306; x=1713870106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJ/EKWiGQYCjMyRyaLc17IgnAUNIkzbIe8xS83lMsNU=;
        b=EwyenqhDKxhUtZFjDAL6+OK6tucn7/0fqm9MgkJ7d6bcbi2JHQK6C5Wa5U27dFnabH
         nqJ7StPAfa/+ucJam/1/zNm+drvRjwqTV7dAdY9cCKI7c+SvlPOLIxkyzS0N409GExbe
         SuvuHq7+O5Yu8moEKeSeN3xaNsYlUzS+9erSzSLdnHauUNJexgSo3tCSwkv6c/Gh5fxv
         GzobNJszW+EduMpEhkIbbRJOEVzAHLdpW5z+wSeOJ8QNEtnvHQmuMZT9p5LwZbTiecrQ
         3qX2qYFTUqfJJHrKZVS5KiYOpgHv56qA7mh0WO/zR4biLQpbCHrHsrCOR/3J0fe83j2r
         wRTw==
X-Forwarded-Encrypted: i=1; AJvYcCW2bF1PGJN/Ah3tdV/GFtehV85DJywJbiI9/wK3BrGMYSE2KznyzJ+8tKF2DUrHUBeNw6AKI38vwrkas4j8LpH+2YKZ
X-Gm-Message-State: AOJu0Yy3+dGsN6I6kRWWLJazlEALY2y925OVXZPshjzak39PIlhbyq6x
	fcKahjepiTvd/FCo7AYvqXhH1JOYhENo/jE9COsDEhO8NhhM4XJ+2IPdxI6trIKxk3PwVq7Klzi
	cXEiA+sfepLV8kd8V+lXb2JK87Xjxmg==
X-Google-Smtp-Source: AGHT+IGatUviPHCAKhZnKrCrCPr4KpAHA2376Zd3svbAiH500vu91bI+qztSQVS39CNnNfMlIB8psCtLpcLmTycAB/w=
X-Received: by 2002:a17:907:3da3:b0:a51:b463:6b62 with SMTP id
 he35-20020a1709073da300b00a51b4636b62mr10872795ejc.55.1713265306124; Tue, 16
 Apr 2024 04:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se>
 <xmqqh6gni1ur.fsf@gitster.g> <5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se>
 <xmqq7chif1pu.fsf@gitster.g> <20240401023225.GA2639800@coredump.intra.peff.net>
In-Reply-To: <20240401023225.GA2639800@coredump.intra.peff.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 16 Apr 2024 13:01:34 +0200
Message-ID: <CAP8UFD0W7PUHTg2NwuVkQJik2+HqTDF6KRZZ8tA_dW7-YZtsbQ@mail.gmail.com>
Subject: Re: [PATCH v2] bisect: Honor log.date
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org, 
	"Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 4:32=E2=80=AFAM Jeff King <peff@peff.net> wrote:

> I guess that commit is what brought me into the cc. I have not been
> following this topic too closely, but generally I'm in favor of using
> "git show". I even suggested it back then, but I think Christian
> preferred not using an external process if we could avoid it.
>
> The thread from 2019 is here:
>
>   http://lore.kernel.org/git/20190222061949.GA9875@sigill.intra.peff.net
>
> which links to the earlier discussion about "git show":
>
>   https://lore.kernel.org/git/CAP8UFD3QhTUj+j3vBGrm0sTQ2dSOLS-m2_PwFj6DZS=
4VZHKRTQ@mail.gmail.com/
>
> IMHO this config thing is a good example of the strength of the separate
> "show" process. If our goal is to trigger all the niceties of "git
> show", it is tricky to catch them all. The revision machinery is pretty
> reusable, but there's no easy way to figure out which config affects
> git-show and so on. Of course if we had a way to invoke git-show
> in-process that would work, but I suspect there are unexpected corner
> cases that might trigger.

Sorry for not following the topic closely and for replying to this so
late, but I think that by now we should have some kind of guidelines
about when forking a new process is Ok and when it's not.

It seems to me that there was already some amount of back and forth on
this topic when bisect and other shell commands were ported to C a
long time ago. There weren't clearly written guidelines, but it seems
to me that at that time we thought that forking a new process was
generally bad, especially for performance reasons, but also because
they showed a bad example and didn't go in the right direction. It
seems to me that people who reviewed code that ported some commands to
C sometimes asked contributors to not fork processes, and efforts were
made by contributors, like GSoC or Outreachy contributors I mentored,
to go in this direction. At one point there was even a microproject
about replacing code that forked a process with function calls.

These days there are also talks and patches around about libification
and about passing around a "repository" variable and other such
variables, so that C code does not need to fork processes to be able
to work more broadly, for example in submodules. And again it seems to
me that such changes (adding code which starts a new process to
replace code which doesn't) doesn't go in the same direction as the
libification and similar goals.
