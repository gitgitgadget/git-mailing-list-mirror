Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032518DF9D
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379262; cv=none; b=bM2XMx4BV5b3p4griSdvYXjhMWFZhjmVQrHlXnLyHyf8pquDiyq0JhJ/135uGks3ydyla9dcy9IBb3wepk2JsDOAFvRygJMIspe2K6vVjM1vfiN6jkXYILhuzNkrF44QwduWo+DyaJj1jMQPQRjB71Pc+OR4nIxYfwFjm8R3qR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379262; c=relaxed/simple;
	bh=BTHTjEEeVtzHyiBPs0FROq8AMpwbZIjNmkMZAXDFAOg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SUe43innLgRuEnstuo4MevDIOt4DfECy9brcqA2auvP7/o0WS2ekrgnL4Ahq0TXcS+uJhkm68jMLIVg9cPy2bOMAaRnbQhXJNwvmMmRZk/SU9qvWlWLP5O26I1HkYyLQrdoV2ZGflbp5NARvFZfq60dPcJXY1DV7GvnAIs8lwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46UMemY43139919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 22:40:48 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Emily Shaffer'" <nasamuffin@google.com>
Cc: <git@vger.kernel.org>, "'Taylor Blau'" <me@ttaylorr.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" <avarab@gmail.com>
References: <20240730175448.1727373-1-emilyshaffer@google.com>	<xmqq7cd2bs0q.fsf@gitster.g>	<CAJoAoZn57LMCz9dmU3u+2HS1urOcoY1HQA6axh0cWoGchS_KFA@mail.gmail.com> <xmqqttg6a7zj.fsf@gitster.g>
In-Reply-To: <xmqqttg6a7zj.fsf@gitster.g>
Subject: RE: [PATCH v4] Documentation: add platform support policy
Date: Tue, 30 Jul 2024 18:40:42 -0400
Organization: Nexbridge Inc.
Message-ID: <000001dae2d1$85ce8f40$916badc0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI5Js9r9iVOCp5l2xZx/NcDi+YSZAMJj/R0ASQc/PcB/BckgrEh/xhQ
Content-Language: en-ca

On Tuesday, July 30, 2024 5:25 PM, Junio C Hamano wrote:
>Emily Shaffer <nasamuffin@google.com> writes:
>
>>> > +Note that this document is about maintaining existing support for
>>> > +a platform that has generally worked in the past; for adding
>>> > +support to a platform which doesn't generally work with Git, the
>>> > +stakeholders for that platform are expected to do the bulk of =
that
>>> > +work themselves. We will consider such patches if they don't make
>>> > +life harder for other supported platforms, and you may well find =
a
>>> > +contributor interested in working on that support, but the Git =
community as a
>whole doesn't feel an obligation to perform such work.
>>>
>>> The part after "... and you may well find" reads a bit muddy.  I
>>> couldn't tell if it is talking about the initial port, or continued
>>> support, or both.
>>> ...
>> I like that message, but what I was trying to say with that sentence
>> was "if you get lucky, some volunteer might want to help you with the
>> initial port".
>
>FWIW, I do not quite like that message; I agree that it would be good =
to tell them
>that they may not entirely be on their own, if they ask nicely, but no =
promises ;-).
>
>> It seems worth at least pointing out that that would be the =
exception,
>> not the rule, but I probably already do that well enough with the
>> previous sentence ("the platform stakeholders are expected to do the
>> bulk of the work"). Let me reword the last sentence, then:
>>
>> "We will consider patches that port a new platform if they don't make
>> life harder for other support platforms or for Git contributors. Some
>> Git contributors may volunteer to help with the initial or continued
>> support, but that is not a given. Support work which is too intrusive
>> or difficult for the project to maintain may still not be accepted."
>
>OK, at least that clarifies the point I was puzzled about.

Pulling in a paragraph from earlier on:

> >This is hard to understand and I wonder if we can clarify.  I get =
what you want to
> >say: suppose we rely on library X that is getting regular feature and =
security updates
> >in reasonable cadence, say every 6 months there is an upstream =
release of library X,
> >but a niche platform has ported the library only once long time ago, =
and hasn't
> >updated it ever since.  Now the Git project may consider helping a =
port to such a
> >platform if the initial port of library X was 8 years ago, but will =
not if it was 12 years
> >ago.

This is a tough one. If a library is actively maintained and subject to =
security fixes, OS providers
like the NonStop team will, as a general practice, provide security =
fixes. It might not be as frequent
as I would personally like, but a 12 year old library with security =
holes would not really survive
to be a problem. Others, where stability is well established, let's say =
iconv (a bad example, I
know), will not get the attention to have it fixed until there is a =
customer reported issue (or
me stomping up and down a lot). I think that the 8 vs. 12 year =
difference is fairly arbitrary
and might not be appropriate.

In some situations, if functionality is provided by an existing library, =
and is augmented, the
platform maintainer could provide another compatibility component to =
supply the capabilities.
It would be a strain, and in some cases impractical, but might be =
possible.

I think a bigger issue is where there are dependencies introduced that =
are either not
generally portable or depend on infrastructure that is also not =
portable. There is a long list
of projects that are all interrelated and specific to the Linux space - =
all of which scare me
as adding any of those would exclude git from platforms where those are =
not possible to
port. Rust and GO, which have difficult-to-port code generators are two =
(Rust itself is
problematic as one needs consent from the Rust maintainers to even add a =
platform, if you
read deeply enough into the "porting" documentation). Products that must =
use gcc or
clang with unavoidable syntax features that are not supported by ANSI C =
compilers and
libraries are also things that keep me up at night because there really =
is no way to work
around those. In some cases, some JSON and YAML libraries ended up =
having to be forked
and are now (not happily but) maintained by my team - not a git issue.

Ultimately, my goal as a platform maintainer is to be able to sleep at =
night without
worrying that git support will be completely turned off by a feature =
that uses some
incompatible library as part of the git core. Git LFS has had to be put =
aside because of
the GO dependency, but because LFS is not core git, it is survivable. I =
think that if such
incompatibilities are introduced, there should be a mechanism to isolate =
them, and
exclude them from the git core.

Please remember that git is now a central component to a vast number of =
organizations
that depend on it for serving features to customers. To be blunt, it is =
not 2007 anymore,
and git exists almost everywhere of significance. That point needs to be =
stressed. The
pervasiveness of git has dramatically increased over the past 5 years, =
more than I think
most people realized. On NonStop, 5 years ago, there was perhaps <10% =
participation.
If you look now, the number has gone up, probably to somewhere around =
60-70%. We
cannot ignore that - I sincerely hope not anyway. There are even =
companies that will
look at your GitHub footprint exclusively as your definitive resume for =
hiring purposes - I
actually think that is really interesting and do not want to put that at =
risk either (although
admittedly entirely beside the point of this thread).

With Respect,
Randall

