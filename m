Received: from mail.hq6.me (hq6.me [104.236.142.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD520E32F
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 04:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.236.142.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225711; cv=none; b=rL9EDmLacpvobJ7sbXmKwYG3WCmNq4cYWKM6PuDj8+LUKQbO+sIJUDMUG8QKAfAQCFJc29ibNBp9Z82M3IruzZw6kwA8OQkS+TcQQ4okjKrGhVQUSL8RIYVTPZDeuk+aQOTcXl0mC/lS5re7ZlhbSccoawxsr6WmAGaKdidfqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225711; c=relaxed/simple;
	bh=HcV8vFl4LVAHaMp56VlQI53I55JrWQmKkKzkPyrYW7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gvr/eRg55TpRyrZ5pGv2wtY3W8tox7MV38vrhcSZSRrCJcObk8QmzFjZtK53aYJ+13rQXt/ici4HOBtusUxSgK4oJj57IIeh9lf2zzEwNA/O1q3gY1OPVEIztBFV+JO8QHPRM4SR8Pa+j9Dv2BK2NptR+Rabrqjp8YysQSS+25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me; spf=pass smtp.mailfrom=hq6.me; dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b=HOsT2ePb; arc=none smtp.client-ip=104.236.142.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hq6.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hq6.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hq6.me header.i=@hq6.me header.b="HOsT2ePb"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hq6.me (Postfix) with ESMTPSA id D4E281209C0
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 21:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hq6.me; s=mail;
	t=1729225708; bh=HcV8vFl4LVAHaMp56VlQI53I55JrWQmKkKzkPyrYW7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HOsT2ePbjQDhQ4Yi7ZiAo/mQyKvVpXHxM3D4qRLHVz8T2vR/xtRrUKLbnrTYYi4J6
	 nH+0zY0tCqQ6P+gfM4hfxKRcywlS6y9gQoeXj5YNKBA4rPZ2CBXUzR8B4Rsn5hmf1Z
	 td7Y/ZfCJsTW6xZ4XOQOKnB10G1KX6Iu22P7tn2HXyKC6F3BNXqh/yAJrmGbY6E5qT
	 uoX2AyrR0V/qJFbMxJaEOzgtjKXOyB56aKvnNH+MopwtkKZu+Op/0RJAKkiCVOytcT
	 /RroU6QHBKtdCF7bZjWg5TpwRw+SF3x82PUcfzhOEiWQveLzBdAcYwjKGb0j7bnak/
	 mZdsPM8GcKzqA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-288a6df82ebso230807fac.2
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 21:28:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YzmP6xjC4Dlx75kMe03nd98nrrx4aYWKY+6+2rjUjQsx67SkLc7
	+JDllEg7n6FScuSaC5/g/CK2GbIzqJ24aMoF641Kcyl3kF/LlMWL1x13KcK/hdITauQxL0WyZ2z
	njslkYXovf6wLKTrJkgJfwENWRNM=
X-Google-Smtp-Source: AGHT+IHJvyagu/mSicdgqGCKIf/oT7PWY+7JayeVIM1Z4/PM/GHiXGv2sulCIEBEoTWQrvbL8uc+IXFARLKmt9tXq1s=
X-Received: by 2002:a05:6870:1694:b0:278:ad0:b934 with SMTP id
 586e51a60fabf-2892c54e6f0mr256288fac.10.1729225708181; Thu, 17 Oct 2024
 21:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO8bsPASzxoEwiYd7ABf4YZuyTexFnf2B2DXap6xsA6d98DAAw@mail.gmail.com>
 <20241018042246.GA2408674@coredump.intra.peff.net>
In-Reply-To: <20241018042246.GA2408674@coredump.intra.peff.net>
From: Henry Qin <root@hq6.me>
Date: Thu, 17 Oct 2024 21:28:02 -0700
X-Gmail-Original-Message-ID: <CAO8bsPDEjDiiB9_ueBzDgLWt3GEcR4T=tYR2GXVAnfsoNxn-HA@mail.gmail.com>
Message-ID: <CAO8bsPDEjDiiB9_ueBzDgLWt3GEcR4T=tYR2GXVAnfsoNxn-HA@mail.gmail.com>
Subject: Re: Why is git log on large repos slower when outputting to tty?
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

Thanks for your reply!
This was actually discussed in the comment thread on SO as well.
Yes, I do have 15618 refs in that repo, and turning off decoration
indeed fixed the performance issue!

Thanks,
~Henry

On Thu, Oct 17, 2024 at 9:23=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Thu, Oct 17, 2024 at 10:46:17AM -0700, Henry Qin wrote:
>
> > Details in my Stackoverflow question:
> >
> > https://stackoverflow.com/questions/79099095/why-is-git-log-significant=
ly-slower-when-outputting-to-a-tty
>
> My first thought was "decorations", and indeed somebody gave that answer
> in the stack overflow thread. The default for log.decorate is "auto",
> which will turn them on when output is to a tty. You can set it to
> "false" to disable it.
>
> As for why decorations are slow: it is necessarily going to be at least
> linear in the number of refs, since we have to build the reverse mapping
> up front. Do you have a lot of refs? What does "git for-each-ref | wc
> -l" say?
>
> -Peff
