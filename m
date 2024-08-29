Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8E24B28
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954512; cv=none; b=CtZeGZX9wbV4XsV5y/HvbIp/hNUdtytuleI23cToaZ5nqLOiR8jTFzjNXjt3MO6a1EeG0wgVJlgmApI286UBw62SD8gUih0w4sTS1s8GpAnuc4SBLSjDcjpYfJVzBKErfpbrsXNlxwU4afuigjZbE68yOaBtZyd5TumlNJZLRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954512; c=relaxed/simple;
	bh=0vo/pD7qF7lVLtWVWF87PBJueTpWthLb26aVzfcdzFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnFYlK3Z8vsTmFFd5mD1RGz6Z6LQ5h1s2VsdmDZws7+gUhwUibqvGZpyzb/fxvSLb9dBPwa25ckz0EcWb0q+kb2r8jIGQnruj9bdxxL8mCeEZV5OyMmIGpBVOu1d6LAOID+OBdF3599PUT6EvwOLVsvhRaQLSx9PPDtNQBpk2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5de3d2a4ac3so96545eaf.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 11:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724954509; x=1725559309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bm65Wxv7PfpBfVfh7Sp0jFhIJrtSjLO0MCrwEe0CF6E=;
        b=S2ztGDcwJO4y98GBVCv8uQEFJj2oNe++7+hs5/AUITwhWnyfzj0UHo+ER+dlyYJ2Gp
         9Lk+nV7DB+hmOC+ZramMrCae/2h8SSJ5V/zQgxuRpVa7bEKIEcfbK3FqMFp7LnspoMly
         FItf8u5R5yH9VDbKDVtbh09csAl4oyZhKt5ZjHca8kCJzzbAh3ZdvqX7HuzWckY3frdy
         Ey2W3zBGTZ9L8Kano5EsqKacUVPw1HN/tNIVmNoZuBF5xpAohRKxoDcAjs0ow2TkmGh2
         ZB4qZ54IPcQ0JQ5WL2GDvI2Vr3zIHhZh8ZXWQTQJWSoivaPVvJcI0x9DJ0u6foN0Dux6
         tP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNArWWsAbLkXnRWWVKzoEXBE/fUUThQJt9diH7aJMSNiscDUPxbewnDSP/tQmbcsZbgyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWZLOMUCyISGF3fTXSxua0F5uNAwCP5VDbtUlH/Etqzherg861
	DzOblSGHrpk87Cd5oFWRP1LvFRD7koyzShJMpYjW5vc93x8OH0jz3xPu4NPlTHEHnaSED2lwJfT
	lfb/D3fpeuESNgKRMwMWTUlnZ8NU=
X-Google-Smtp-Source: AGHT+IGV0Gl36xJTFAUxUbvKfCPAuTITQHrC8rBlDyL3Q7XfVWqWZ1pn9sQuSKJBKItDClI+qVuu5Dvom9ybRilIVnk=
X-Received: by 2002:a05:6358:3988:b0:1ac:ee25:ea01 with SMTP id
 e5c5f4694b2df-1b603c1425dmr250725555d.2.1724954509322; Thu, 29 Aug 2024
 11:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240829091625.41297-2-ericsunshine@charter.net> <ZtBHbftK7vdTEz93@tanuki>
In-Reply-To: <ZtBHbftK7vdTEz93@tanuki>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Aug 2024 14:01:37 -0400
Message-ID: <CAPig+cRnEkS2CbAtao8vGki1tsMGmJ992eDn3rnrtPZYnMvk8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] chainlint: make error messages self-explanatory
To: Patrick Steinhardt <ps@pks.im>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 6:03=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> On Thu, Aug 29, 2024 at 05:16:24AM -0400, Eric Sunshine wrote:
> > -             push(@{$self->{parser}->{problems}}, ['UNCLOSED-HEREDOC',=
 $tag]);
> > +             push(@{$self->{parser}->{problems}}, ['HEREDOC', $tag]);
> >               $$b =3D~ /(?:\G|\n).*\z/gc; # consume rest of input
> >               my $body =3D substr($$b, $start, pos($$b) - $start);
> >               $self->{lineno} +=3D () =3D $body =3D~ /\n/sg;
>
> I was wondering why this is being changed here, as I found the old name
> to be easier to understand. Then I saw further down that you essentially
> use those as identifiers for the actual problem.

Peff chose[1] the longer "UNCLOSED-HEREDOC" over the (perhaps too)
terse "HERE" I had chosen[2], however, now that this is an internal
detail of the script -- not part of the user-facing output -- such
verbosity is unneeded. As programmers, just as we choose shorter
variable names (say, "i" instead of "record_index" in a for-loop), I
find "HEREDOC" easier to read in a code context than the longer
"UNCLOSED-HEREDOC", hence this (admittedly unnecessary) change.

[1]: https://lore.kernel.org/git/20230330193031.GC27989@coredump.intra.peff=
.net/
[2]: https://lore.kernel.org/git/CAPig+cQiOGrDSUc34jHEBp87Rx-dnXNcPcF76bu0S=
JoOzD+1hw@mail.gmail.com/

> Is there a specific reason why we now have the separate translation
> step? Couldn't we instead push the translated message here, directly?

I considered that but, although this instance is a simple "push"
operation, some heuristics scan and modify the `problems` array by
looking for and removing specific items. There are numerous instances
in (older) scripts similar to this:

    if condition not satisified
    then
        echo it did not work...
        echo failed!
        return 1
    fi

which prints an error message and then explicitly signals failure with
`return 1` (or `exit 1` or `false`) as the final command in an `if`
branch or `case` arm. In these cases, the tests don't bother
maintaining the &&-chain between `echo` and the explicit "test failed"
indicator.

As chainlint processes the token stream, it correctly pushes "AMP"
annotations onto the `problems` array for each of the `echo` lines,
but when it encounters the explicit `return 1`, the heuristic kicks in
and notices that the broken &&-chain leading up to `return 1` is
immaterial since the construct is manually signaling failure, thus the
&&-chain breakage is legitimate and safe. Requiring test authors to
add "&&" to each such line would just be making busy-work for them.
Hence, the heuristic actively removes the preceding "AMP" annotations
from `problems`. For the removal, it's easier to search `problems` for
a simple token such as "AMP" than to search for a user-facing message
such as "ERR missing '?!'".

> > -8    bar=3D$((42 + 1)) ?!AMP?!
> > +8    bar=3D$((42 + 1)) ?!ERR missing '&&'?!
>
> I find the resulting error messages a bit confusing: to me it reads as
> if "ERR" is missing the ampersands. Is it actually useful to have the
> ERR prefix in the first place? We do not output anything but errors, so
> it feels somewhat redundant.

As you mentioned in your review of [2/2], the "ERR" prefix serves as a
useful target for searches in a terminal.

Regarding possible confusion, my first draft placed a colon after the
prefix, i.e.:

    ERR: missing '&&'

but it seemed unnecessarily noisy, so I dropped the colon since:

    ERR missing '&&'

seemed clear enough. However, I don't feel too strongly about it and
can add the colon back if people think it would make the message
clearer.
