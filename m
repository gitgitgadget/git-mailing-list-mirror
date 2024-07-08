Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CE1CD23
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469222; cv=none; b=nf2pN3NExANuUknR8aFOsOFFwrYrJi4LFnpyxzBcMx85jBGv5IrbS01OPqufZjhFxPvQnQrBgOCA/g0VBSuE8bLmpiBdcsIWw7s26SiFSdDjAKhvb/n6nz40eLQ/tSH44Qa38SnRzU2CymvpgX3LwRKsCe3T2Nq9X/sRVTT+q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469222; c=relaxed/simple;
	bh=0EYH2fCyVzz0bnsNm3ToBNJigMU0LiZT1q4TMZQ/LL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5aypgTu15ipK/OeWsAvyYwPqhQkD1dFiLHUPWEVzsBcp0az8UqM3o6QP0JBzk8JeRRPcWT0b5dSCzI8iRNdYMxr0Se8+zvBoY7/AhY/CJWiva0wfbMa192JBs8Un3RxXsmqWYwM8MgmYM+kyBbGyJJNvSmsgbRokPO9xAbX8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b61bb5f6c0so1418676d6.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 13:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469219; x=1721074019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EYH2fCyVzz0bnsNm3ToBNJigMU0LiZT1q4TMZQ/LL8=;
        b=gxnrSm+rLdkCSsFW8C9IS9KjYelKD8OUUvh6CbfL9as5SFYfK+lRLk2ddOgjaA6YNR
         DRhwyv/by+10Huwv3ON2mkKOp6JGaG+o60ql7mQLJqh6vsDvSg1dALKiOsRtPzHKx/47
         VHCNSpp80bJYlInVE9IFKjZQ3oIi9A91zAUhpcN+FtyHiMIDRmN1uVGGLAzSX7SbhKEe
         zUKVyG/bdXihPUKst1Vie0I8p5oyTfL/2QfBKv25VkRsq7k5C2I87XrpPq/zvi7LgQ3g
         G6uQgWZujqFqo97W7ODBuEy4Q5n3awIQmO/QL6qLE6skEgWMQkQw8m1FvNokREjowbF+
         TjwA==
X-Forwarded-Encrypted: i=1; AJvYcCX8f9shfVbqONHAMTOlOudBvdsnqPzW0ECBSB18Ni5Iw7unmMnL45kAV1Fo0byPQKh6xUOiZ/wNxd5tHCE1Wwjbo2dW
X-Gm-Message-State: AOJu0Yz7vX6tyRtnWtOD/si6X9KpeJR+V1Requ0xGUQlv7P4aeUX72Ja
	TOaGDVrDrxHjn+Dnu1/y+y65h8NTZRt9ROuPD0Tq6luzx8ChxU+PpcHbSLPhn2BDFnwUQb+IE9V
	fLdwM9eO1FNa17Vz2IYxiS+oNkI8=
X-Google-Smtp-Source: AGHT+IGGP/LdlLjfajHwge2QJWJ6KM2C+28h8jkzclgKtKlHNe406YxyWV1AQwOOFPd+1KfKmqsDCiL+o9+cvu7PFeI=
X-Received: by 2002:ad4:5aad:0:b0:6b5:e377:384 with SMTP id
 6a1803df08f44-6b61bca3885mr11100606d6.14.1720469218981; Mon, 08 Jul 2024
 13:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701220815.GA20293@coredump.intra.peff.net>
 <20240702235034.88219-1-ericsunshine@charter.net> <20240706060143.GD698153@coredump.intra.peff.net>
 <CAPig+cRUOSHuNezZfVUT43JGT5BWA3LTbQvKCkD37DxXn=L6Jg@mail.gmail.com> <20240708090530.GC819809@coredump.intra.peff.net>
In-Reply-To: <20240708090530.GC819809@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 8 Jul 2024 16:06:47 -0400
Message-ID: <CAPig+cTFZuU7zM7poqk4HeK09zn8bFrO37eUZiaGmeJ0yecpiw@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: recognize test bodies defined via heredoc
To: Jeff King <peff@peff.net>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:05=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Sun, Jul 07, 2024 at 11:40:19PM -0400, Eric Sunshine wrote:
> > (3) We tend to be quite consistent about naming our heredoc tag (i.e.
> > "EOF", "EOT"), so a latched body in the parser's %heredocs hash is
> > very likely to get overwritten, thus the hash is probably not going to
> > eat up a lot of memory. Given the entire test suite, I'd be quite
> > surprised if any one parser ever latches more than three heredoc
> > bodies at a time, and the vast majority of parsers are likely latching
> > zero or one heredoc body.

One thing we may want to measure is how much extra time we're wasting
for the (very) common case of latching heredoc bodies only to then
ignore them. In particular, we may want to add a flag to ShellParser
telling it whether or not to latch heredoc bodies, and enable that
flag in subclass ScriptParser, but leave it disabled in subclass
TestParser since only ScriptParser currently cares about the heredoc
body.

> > (4) I couldn't really think of a correct spot to reset %heredocs.
>
> All of that makes sense to me, especially (4). :)
>
> > That said, after reading your message, I did try implementing an
> > approach in which the heredoc body gets attached to the `<<` or `<<-`
> > token. That way, a heredoc body would be cleaned along with its
> > associated lexer token. However, the implementation got too ugly and
> > increased cognitive load too much for my liking, so I abandoned it.
>
> OK, thanks for trying. I do think sticking it into the token stream
> would make sense, but if the implementation got tricky, it is probably
> not worth the effort. We can always revisit it later if we find some
> reason that it would be useful to do it that way.

In the long run, I think we probably want to build a full parse tree,
attach relevant information (such as a heredoc body) to each node, and
then walk the tree, rather than trying to perform on-the-fly lints and
other operations on the token stream as is currently the case.

This encapsulation would not only solve the problem of releasing
related resources (such as releasing the heredoc body when the `<<` or
`<<-` node is released), but it would also make it possible to perform
other lints I've had in mind. For instance, a while ago, I added (but
did not submit) a lint to check for `cd` outside of a subshell. After
implementing that, I realized that the cd-outside-subshell lint would
be useful, not just within test bodies, but also at the script level
itself. However, because actual linting functionality resides entirely
in TestParser, I wasn't able to reuse the code for detecting
cd-outside-subshell at the script level, and ended up having to write
duplicate linting code in ScriptParser. If, on the other hand, the
linting code was just handed a parse tree, then it wouldn't matter if
that parse tree came from parsing a test body or parsing a script.

All (or most) of the checks in t/check-non-portable-shell.pl could
also be incorporated into chainlint.pl (though that makes the name
"chainlint.pl" even more of an anachronism than it already is since it
outgrew "chain linting" when it starting checking for missing `||
return`, if not before then.)
