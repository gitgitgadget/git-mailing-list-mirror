Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3DA361651
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521996; cv=none; b=iJWO003LtvB0wRkTO7UuKqHQJEbmPUwTwu82qQmCPRK+e9zZcqDLufGDtnFD1jErb+K2R73dlLvmeTmwNaFGqb1405B+w1MwluIS9+j+f4xoN6faTMEEwOvFoqBIrPCkIm4DvmKqPkzRS98yboc+uZRQQrkskivM65+zFqp+qh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521996; c=relaxed/simple;
	bh=PKlbZiNSZ19WD2liOGgGBBl2JNalTwFjsuDrEt2MQD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsD+Vf8MUguASSOpcRBrzipzqyEZivQsHzue5qi4RRTV91W0u2A8D5sKvJ8EF8UabBgRyXNDhLht2NCzxowDcDnvo4imwRabKff0nJQfJDDd1/mIYd594ulbG8hwKf4w0G/+DIV1WcgyZWkdOov2+KCpxLc2SLo2dMGo+s26k78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fahldieck.de; spf=pass smtp.mailfrom=fahldieck.de; dkim=pass (2048-bit key) header.d=fahldieck.de header.i=@fahldieck.de header.b=UXAILevZ; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fahldieck.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fahldieck.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fahldieck.de header.i=@fahldieck.de header.b="UXAILevZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fahldieck.de; s=blu9537877; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description;
	bh=PKlbZiNSZ19WD2liOGgGBBl2JNalTwFjsuDrEt2MQD0=; b=UXAILevZbaEX3qBBHLJQ1tBjbP
	sVbpipC6AkpyeOvGDgYgdUu2DTZLWc/wBJsv92/6nc0Q6LGN67NNBU2bcbE7Lm6wJ+z18n+0v88KH
	UGTinEzSAx4LL2vTUkr4v+a5tjAPotjYsRb3qGoAQYh6bDRgmuc3edcrs7Dng34TbyXp0Xe9QkXSk
	7gl1oKWcAx5OiA9+hoxL7Mm30ibjPDuPOo1ICG23T6qWxZh1x/8q723cuZd5DX5kOzAMx4KuMPic9
	TcCie6qaKCkD9X976I5E0JOYkV6+QaxwtTZj8XVmH29iok3pQZ5xjdGdIBYhSAZqIfUk0WGpUg8BQ
	tK7cuyrA==;
Received: from [209.85.128.174] (helo=mail-yw1-f174.google.com)
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nils@fahldieck.de>)
	id 1wprpf-00EYBZ-Vm
	for git@vger.kernel.org;
	Fri, 31 Jul 2026 20:19:44 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ed000b507so12713137b3.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 11:19:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Roy3rcUadJpEOOF0ooXKSpWdVzYnBHSrWmYCBgNrPjC5CyRpAArzNjG5OBNVydxtlcTzYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB7Hkp8KFNiXaBCfUrofpgd8BRf/4UpMnEhKLEyXgCFZ4VJ4Ow
	AjgBP6VgebqKnwR8UZrGp83mprm24FeO8+b42+uEyuTWXk5wGqd5lIFxbRPgwQP5FnFSYxjHS6Z
	2qVn4eu1NlgvYPbp0Svcnk1MXaZc9Z54=
X-Received: by 2002:a05:690c:278a:b0:81c:b865:2231 with SMTP id
 00721157ae682-81fd4bf88ecmr11345357b3.33.1785521982656; Fri, 31 Jul 2026
 11:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6fojkds.fsf@gitster.g> <336EEC18-98D3-4068-8C5C-476749959814@gmail.com>
In-Reply-To: <336EEC18-98D3-4068-8C5C-476749959814@gmail.com>
From: Nils Fahldieck <nils@fahldieck.de>
Date: Fri, 31 Jul 2026 20:19:06 +0200
X-Gmail-Original-Message-ID: <CAAdFe9z7hE1Av=d4u6vUmvJjaDD0JXJpHb9UVd7oEiMpFV0PQg@mail.gmail.com>
X-Gm-Features: AUfX_mwPWqx_jWzCF4k69ctIxyPupLw9dmyLwPX4vA7I79P73lqQxBV2shShGxM
Message-ID: <CAAdFe9z7hE1Av=d4u6vUmvJjaDD0JXJpHb9UVd7oEiMpFV0PQg@mail.gmail.com>
Subject: Re: [BUG] git config --global: doc and behaviour disagree when
 ~/.gitconfig and XDG config file coexist
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Nils Fahldieck <nils@fahldieck.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Con-Id: 301193
X-Con-U: 0-nils

Hey there!

> Agreed based on recent thread <20260720113402.0dc16abe@frustcomp.hnjs.hom=
e.arpa> (subject =C2=AB git config: unintuitive behavior with - -global and=
 - -no-includes =C2=BB in case I have mis-transcribed the message ID, a nec=
essity to maintain plain-text mail from my mobile phone, ahem).

Thank you very much for the other thread, I have read and understand
the origin of `--global` way better now. This understanding reinforced
a PR that I raised for the git-get helper binary. The origin of my
problem is git-get's configuration, which reads its config via `git
config --global key` instead of `git config --get key`. This is the PR
for reference: https://github.com/grdl/git-get/pull/45

> > So, "when the file does not exist or even if the file exists is not
> > readble, then it is not used and the other file is used instead"
> > would probably be technically more correct, but I am not sure if
> > such a change has much value (unless you are trying to be very
> > pedantic).
>
> My thoughts as well. A readable 0-byte file is not a counterexample to th=
e docs; if such a file is readable then it exists, and is used as documente=
d, no?

I agree and do not want to be pedantic about the implementation. I
just tried to understand the code and added that to the report.

I still see a discrepancy between `git config --get` and `git config
--global`, though. As a user it would make sense that if we have both
`~/.gitconfig` and `~/.config/git/config` only one file is read and
written in every case. Or in other words, with your explained expected
behaviour, `git config --get` should not return a value. It is
off-putting that some commands read both files where some do not. I am
happy to understand the reasoning a little bit better, though. Maybe I
have a missing connection in my head.

Anyway, I still feel that the documentation must be updated (at least)
since Git is executing differently to it. I am happy to provide a
patch for it. I just need to read up about how I contribute it for Git
itself and the git-scm.com website including all i18n versions. Any
hints are appreciated, my starting point would be
https://git-scm.com/community though.

Best
Nils
