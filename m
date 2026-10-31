Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793423318;
	b=qxbDhIokqzjlBKM+sFZbW4Vh9B8YWnEMxK3xL3U5vDCqrSnq8OdcR+l2ojr9iktXO9bt
	 lkauudcbF/z+VKrhdw/GUFt676IsfrRjacmhCDw2igwTjV97by3Wh4YDyoB6Me8IlfhfU
	 Y/Fk93r5FvTGWcUAkI2wtAOBVJDM8wgrpO4Mj1KkeoYnkxMx9/XzrCwMYpocaP6yCO9id
	 0a/5VBInqLEWjVIJybgShRYHEk8IN6PPBofJ0gUyuNHnirCyW89UlV31zEitQSrGxwizK
	 BdSAiW3Y5HANtqp/eiuKY3A8HhYs+V8QUFAcMYVfzpbXbfdLTHa5+ZxZ3/zXSr3Fu6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793423318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LC1P3mzhN8kEPfx2DJgaUs0OH2k73PE/AqqW8ChCMvg=;
	b=Yq4kHRw2X2WIu973hp1QK5wL9e2QYXEh3JepM05AUUQbmH4B8813x7BQUFCSq+rDu4vr
	 +YBLAXhLmDtePMCCp8PgYcAI8vXHRq78auL//PfvWBQT6vnuhYHCzkkq1YLW4QKKzehkY
	 3H9HpUUQVNuWEwh6/GR8AYGEUTrRAiaiLQjL9KGNQBEqkK1pZKEMSFp4BjJTZCNZBDaU6
	 mykGA+UtGCYd004Er345h79Ol7E05lOfV0V6jFYSIPVryJkCeaShclEE4Nc6qklIb5kHt
	 bhFQ6kUejvpVQl6O7qE1nFh7ra1hGYNo0vmF+31tXCh3PirYUVtTrb1H4jP57lcRU+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="S/epuzz+";
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8B606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 05:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EF8B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S/epuzz+
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso919004a91.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 22:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793423318; x=1794028118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LC1P3mzhN8kEPfx2DJgaUs0OH2k73PE/AqqW8ChCMvg=;
        b=S/epuzz+zYMC1J2QsUu0HG7wcjUWNwU0l+E1ZFNSWC+PBMhR8ny3dzreHlwJROTkLf
         97wrs3Hc29bRn/bnPLUteLfL6ggmgLLtyvq8v51tt2zqXAbgOYWc5nwDzppN/IcD2ImL
         SYICLntXVe0xZml7ExZv6JGhiEar2w/xdwPT7rV7BgLx3qvAOoHSg9iCCbHpB1klLzXP
         KKnXvtLU8YeVmdryubnjAJnM+IgUFKy5rlThdC7P6oPmrZqnphVZxSLz7yyTwc8nu0qM
         RucT6GBvTgkRJ/dPRlBgMiBU8eBI/nKQqpMGfFpVH1Y0m3/msNKmt1Mp+NaRCqIgtgvj
         RUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793423318; x=1794028118;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LC1P3mzhN8kEPfx2DJgaUs0OH2k73PE/AqqW8ChCMvg=;
        b=N08HqX8RRz7G7GCNCD8JdXULYxI/y0hVPqBaRh3hmVcJsu+c9snxvFT7JlV5M6ANxp
         bKV8lVPxfgK0CaYCTSIgj8D+sslk0+IdkRjCbTjBLf+giACRHNT5sqXVsxlyFyD1PPKj
         GzR//H5AghwAUObxvytf+dRuV66ZBp+NMIO+5lj2AiWoAQaulNahAazsKNXVopLI9ys7
         K3eI6QEEXnFKJ0QUAUmERSfr6yzm1Js2sk6KQrUmG5phdrICVIBuyFeWWWo5Uitk+ruq
         JCAX5R/+t5OBT3m0UgYR5FNG6YahUQIogoBdN+pVwwzfK0Q/2yWuXLpUk/WISIJJWYVP
         /k4Q==
X-Forwarded-Encrypted: i=1; AKwUvBx5K5Ckf2+0X3YjjIHqISO0hrOJcYyBK5gglyq2BoaVq3FnJEtNj/Oqqzx6DRUNgYxmXqs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQ5AK4afSCCOETgc1KUuWTVPR3Z0tMu/E7+q9oRKkrjEPgptUj
	sILl2DJ6yi5ztYg1KNp4H/zLWzsUycpZQRfMQQLWHnBSW0EE8EtrNe31zLUPBehx
X-Gm-Gg: AYBFou2F75jHSJgeXrrweqbdzCC+Y8+1XBXA+eU+ocaIsZ6/h+YgHdnjlIOH71QUiJI
	UBMLlL7WS3EwDGyWW5I5rEG9jgMurvKlnRo8PWpXBeC8fduF0eFaOmQ4rQlb09HQ9wt2KXRnlkG
	eF2X443eYTn/LFNEe1lmqycqVq/c6rA9XZioXSU/NxY7q41vLxZ48TXY62oNBKBKUOXPolX8wlC
	wBjQyjZnPK6D8z2dhBRyZLnvNcHFMRWreQkoPudwrVpsUlkuN7A2pf/xQpkHHSVfXAwrLXXre9N
	OgKs0RP66u3VjBLtKoOhlmYYHxU886XYK+ekj/4wR62E/G4z79ONr5rNGalrKyNUjSQv6A8I/rY
	yW96ZARmLmedcJxvLneQT1F3TGmZ+vsxiQ+xBxQyyDwVjuQ/OcFoG24T05joPJJqELr9G9korf6
	vM/1nXwb/KS5LOmq3df/dEwzHYTLBennklVTyEfRqcJ6lnzL43trNSppgBLoHxP/jbZZOK3ePhy
	mliYlQwJv6vCjn+dXQO3pF7lqeanXSfdwvYVto787rHAtb4HsValoVzdUN/7NP3xczVk5lbQaT3
	rx7saGkQYNA=
X-Received: by 2002:a17:90b:2745:b0:3a4:b0a1:c7ed with SMTP id 98e67ed59e1d1-3ae89776d99mr3647135a91.13.1793423317518;
        Fri, 30 Oct 2026 22:08:37 -0700 (PDT)
Received: from fedora ([2601:646:8081:1c1b::577a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae881c5624sm2869783a91.4.2026.10.30.22.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 22:08:36 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] t5702: be more resilient to env quoting
In-Reply-To: <20261031020318.tLesiElF@teonanacatl.net>
References: <20261031002550.GA626623@coredump.intra.peff.net>
	<20261031020318.tLesiElF@teonanacatl.net>
Date: Fri, 30 Oct 2026 22:08:35 -0700
Message-ID: <87jymy5uek.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Todd Zullinger <tmz@pobox.com> writes:

> Jeff King wrote:
>> A few tests in t5702 check whether we specify the v2 protocol via the
>> GIT_PROTOCOL environment variable. They do this by redirecting the
>> output of "env" into a file and grepping it. But our exact pattern
>> depends on how env quotes its output. GNU coreutils 9.10 will output
>> this:
>>=20
>>   GIT_PROTOCOL=3Dversion=3D2
>>=20
>> but version 9.12 will output this:
>>=20
>>   GIT_PROTOCOL=3D'version=3D2'
>>=20
>> It doesn't quote every variable, but the presence of "=3D" now triggers
>> it. We could loosen our regex to accommodate both versions, but there's
>> a simpler fix. We only care about the value of one variable, so we can
>> just print it using the shell invoked for the server-side command.
>
> Per the coreutils-9.12 NEWS=C2=B9, it now honors "the
> QUOTING_STYLE environment variable, defaulting to
> shell-escape style."
>
> Not that I think we should keep the env parsing; as you note
> there are some pros to replacing it anyway.  But if we want
> to use env somewhere else, we can set QUOTING_STYLE=3Dliteral
> to get the unquoted values too.
>
> =C2=B9 https://github.com/coreutils/coreutils/blob/v9.12/NEWS#L118-L121
>
>   I'd link to the main Savannah cgit or gitweb, but those
>   are currently down, thanks to AI scraper bots. :(

Nice catch on the NEWS entry. Sorry to you both for the extra work. I am
at least partly to blame for those changes.

In coreutils-9.12, we made 'env' and 'printenv' quote their output. This
was to make the output more robust in the case of whitespace, special
characters, and in particular, newlines in environment variables.
Specifically, any program that parses the output of 'env', without -0,
will certainly mistake environment variables with newlines in them as
multiple environment variables. See the following example of the output
before coreutils-9.12:

    $ env -i env --version | head -n 1
    env (GNU coreutils) 9.10
    $ env -i env VAR1=3Dreal$'\n'VAR2=3Dfake
    VAR1=3Dreal
    VAR2=3Dfake

Compared to the output of 9.12:

    $ env -i ~/.local/bin/env --version | head -n1
    env (GNU coreutils) 9.12.163-9e804
    $ env -i ~/.local/bin/env VAR1=3Dreal$'\n'VAR2=3Dfake
    VAR1=3D'real'$'\n''VAR2=3Dfake'

In previous instances, we only quoted when emitting text to a terminal,
e.g., with the quoting performed by 'ls':

    $ touch a$'\n'b
    $ /bin/ls .
    'a'$'\n''b'
    $ /bin/ls . | cat
    a
    b

However, we saw benefit in not doing that in this case. One could use
'env' in a shell script, redirect it to a file, and eval it later, for
example. We thought this would be okay, since we did not find any
instances in Debian code search where this would have caused problems.

Evidently, that search was not thorough enough, and various places ran
into issues [1] [2]. That code, in some cases, does have the problem I
mentioned previously, where it could mistake parts of the values in
environment variables as separate variables. However, we obviously do
not want to break things that have worked forever, and the quoting was
causing more problems than the uncommon issue that it was trying to
prevent.

As a result, we changed the behavior to quote only when standard output
is a terminal. E.g., here is the output from my current build from the
master branch:

    $ env -i src/env VAR1=3Dreal$'\n'VAR2=3Dfake
    VAR1=3D'real'$'\n''VAR2=3Dfake'
    $ env -i src/env VAR1=3Dreal$'\n'VAR2=3Dfake | cat
    VAR1=3Dreal
    VAR2=3Dfake

In all of the cases that I have seen where the 9.12 behavior caused
problems, quoting only when standard output is a terminal would have
avoided all of them.

P=C3=A1draig Brady and I reached out to various distributions that tend to
update quickly about that patch [3], in hopes of preventing their users
from needing to debug applications/libraries which they may or may not
even be aware use 'env' in a way that this change breaks. I had
forgotten to submit a Debian bug report, but reported it today to the
Debian maintainers, who have applied it now [4]. I'm too familiar with
Debian packaging, but it appears that 9.12-0.3 should be available with
the patch [5].

Note that some distributions may have also picked up the patch adding
the --quoting-style option [6] (I think Slackware did, not sure if
anyone else did). But that hasn't been in a release yet, so you probably
don't want to use it.

Sorry again for the extra work of having to investigate that behavior
change.

Collin

[1] https://github.com/coreutils/coreutils/issues/355
[2] https://bugs.kde.org/525805
[3] https://github.com/coreutils/coreutils/commit/782a1e5bc2090212273bb731d=
ceee2cc2a071e54
[4] https://bugs.debian.org/1152651
[5] https://packages.debian.org/sid/coreutils
