Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C630E852
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750369486; cv=none; b=N3fEK2e6JOWtorYlv8uHrYQAt90PF6sCZWNcnChZnEKkoA1aNK5RYeISSRNLNZ5A+qOuZz4VtzxkdaZ357eS4/8+f1ej37pLk+L8qu8v1LHPOhQchUtBmQAq1r455AY3oQs8YGKCKP7WXuutC+fNzNcRWlrn39od7aomIwF7O2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750369486; c=relaxed/simple;
	bh=SyB+bwksYnZo3R0BAZj1ASigb6jTP+H/N110B5iy0tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UgCxj/05VVagV9Xi0H8Vvd0LMYUzBhrfxhO8jSpc2NpEFNhkATGA+cvYYa9fm5kRAHllUZVZ4jurbBdvR4qgf8i0BPxNb0/r061XVbGcLmI1eWYRADpQwZy0X4DV+shMjf81M/zSDwtMqjv+cXhBue4eTxOpTcgalpO5xyB1RVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp/K35Vt; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp/K35Vt"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-872886ed65aso100633139f.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750369483; x=1750974283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arGnD7qRL98Gt7kRiAu/6d/AvihLmFhr167lJeUFn0g=;
        b=Zp/K35Vt3ym9F7kF51isbUasbEVIGGd5Vv6rHiJwD49y4TVtlA1H0FKKeU9mfcecB8
         hbJVu3EOBubdsoSRLt0rYYt/i2dv0hgD9awUATskCp9s6EckgtBLLdhlKjGuj5cNBx4C
         WogD/u/X57/HBE36Gsfs9QxxzIA+7q1HRCLUZfSnbCdScECx1ecr74fed/ymZ6E6Glze
         F8Y7gBMEebpngkFll0wMzpf1Ey6ydXnF34pE7LBelEn6MLxK8DrI5n/4IjB4pOuY75Cv
         lDFss8eICrXb8Sel0qxknylpinkNcJGTnmTWTJ+0vMc1PHheqhsuS1PTy5JzL+oMjw6w
         u0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750369483; x=1750974283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arGnD7qRL98Gt7kRiAu/6d/AvihLmFhr167lJeUFn0g=;
        b=tWl17FiRbqMHc07Mx9BKdx4XHjg2YSFdTGJChFqBhIsQDNQ+KW3CF2M4O6aACDxioY
         uyP2oz9SwTSeTblyhGUkbsaHzFLbni5ot5Bhie51by8udVTlz0Uuw8U8RVRepNTXRfB/
         aFk1MzWwNC5vLznFB1ktxWdGglk8hNBVTOrkKDaXxWw7e3J79fnux3xAdcoi2y+P8RRe
         cVdtD2rbyJ86yIMQBeL2CyXIiW8sP8CYExyffRbpW7/nQh7/8Ev7CsZsZwIK4Tn69pwx
         2mfTdPk3qmGS8A3uTFoA8PL5hsJbqKchLO5Iya/5/8kg3I3qSi2R10CxvAEgcNB0OSAo
         iioA==
X-Gm-Message-State: AOJu0YxqAjWG44N7jCVgCZz98Awt/zvnFRdNcMLrRr7FhIbjlfvqVw3N
	qO388L4BG82M7RJHwEZeGkyxz7BoA/FIwBWTLujy6U6tFmWtxw0nBflr6mWxkKl8iQXDNGmuZo7
	Ar3Y5tZNYPNTX6RmQ06CwsmOLjALTF4s=
X-Gm-Gg: ASbGncv5y+uWHwHKt5HslWG8tNiYd2eExASdNDYS/SbC+1XmvDUO5j04AyBSbHxyIDv
	OmQCVGwQJydMUu2B/+wK1f62t1LlnfcTaq+kH+MlL2mU+4Uao5hZ9MOUSJ3nNswXH66+YX9iWCP
	NHkP998lM0/8/D9Qx+evSorrQhg98obRppCAdWV22OhungXY5U5kKVEG7rkPfJufERlHEUeVSoQ
	QNt
X-Google-Smtp-Source: AGHT+IEjkOhkviqQNWT/1jl1bX8bcvTdR9np35h2QtNGj4vJZU5iiVjEYVshUAvYDLXQhlgwHX63S+8MaFJG1VgAMns=
X-Received: by 2002:a05:6e02:370f:b0:3dd:bb64:d850 with SMTP id
 e9e14a558f8ab-3de38ca4f1cmr4719745ab.11.1750369482657; Thu, 19 Jun 2025
 14:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618151821.528627-1-christian.couder@gmail.com> <20250619133630.727274-1-christian.couder@gmail.com>
In-Reply-To: <20250619133630.727274-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 19 Jun 2025 14:44:30 -0700
X-Gm-Features: AX0GCFveoZEO9F4wQoCHG64R7KQ-gVdnfKPE3yrI4S9F3pVk8RP_aY-gd8FtA7w
Message-ID: <CABPp-BF6ZjfJ2MSHkhXQwv00=63qG3wLU8ie=_WVxnWTffFpRA@mail.gmail.com>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 6:36=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> A recent commit, d9cb0e6ff8 (fast-export, fast-import: add support for
> signed-commits, 2025-03-10), added support for signed commits to
> fast-export and fast-import.
>
> When a signed commit is processed, fast-export can output either
> "gpgsig sha1" or "gpgsig sha256" depending on whether the signed
> commit uses the SHA-1 or SHA-256 Git object format.
>
> However, this implementation has a number of limitations:
>
>   - the output format was not properly described in the documentation,

Thanks for working on fixing this.

>   - the output format is not very informative as it doesn't even say
>     if the signature is an OpenPGP, an SSH, or an X509 signature,

Why would it need to say what type of signature it is?  Don't the
ascii armor lines have e.g. "----BEGIN PGP SIGNATURE----" and "----END
PGP SIGNATURE----" around it, which fast-import can read as well as
fast-export?  Is the idea that we strip those lines and now need to
replace the information we lost?

>   - the implementation doesn't support having both one signature on
>     the SHA-1 object and one on the SHA-256 object.

Not sure I understand this; more questions around this later.

> Let's improve on these limitations by improving fast-export and
> fast-import so that:
>
>   - both one signature on the SHA-1 object and one on the SHA-256
>     object can be exported and imported,
>   - if there is more than one signature on the SHA-1 object or on
>     the SHA-256 object, a warning is emitted,
>   - the output format is "gpgsig <git-hash-algo> <signature-format>",
>     where <git-hash-algo> is the Git object format as before, and
>     <signature-format> is the signature type ("openpgp", "x509",
>     "ssh" or "unknown",
>   - the output is properly documented.

Perhaps this was discussed in an earlier round, but if so I either
forgot or missed it.  What value does <git-hash-algo> and
<signature-format> provide?  How are they intended to be used?

Is the <signature-format> merely self-inflicted pain from stripping
the ascii armor lines?  If so, would it make more sense to just
include those armor lines as-is in the fast-export stream and let
fast-import process it?  Then we wouldn't have to introduce all the
outputting and parsing of this new <signature-format> field and worry
about the new special "unknown" status.

Is the <git-hash-algo> due to the fact that we have separate `gpgsig`
and `gpgsig-sha256` commit headers and we want to use that information
to avoid writing these headers to the wrong-sized objects (and/or to
avoid checking whether the signature is valid on the wrong-sized
objects)?  If so, could that be spelled out in the docs as well,
especially since it appears that the intent of these headers is left
unimplemented due to not changing fast-import to do anything with
them?

And if <git-hash-algo>'s purpose is to ensure they are only used when
writing same-sized object as what was exported, then...isn't that a
bug?  This series was started because people wanted to be able to do
things like keeping signature even when they are no longer valid or
resigning commits that have a no longer commit signature (among other
uses), but that would mean that if someone exports a sha1 repository
and imports it as sha256, we don't want to ignore the fact that the
sha1 commit was signed for those usecases.

If, however, the <git-hash-algo>'s purpose is merely as a performance
optimization that fast-import can employ in the cases where it checks
for signatures being valid, so it can avoid checking when it know the
hash size isn't even the same, then it could make sense.

But, short of that performance optimization, it's unclear to me
whether we'd lose anything by simply exporting "gpgsig <contents of
signature header from original object, including the armor lines>",
and dropping the <git-hash-algo> and <signature-format> lines
entirely.  Am I missing something?  (I may well be; I don't know much
about signing stuff beyond the very basics, and don't mess with signed
commits or tags much myself.)

[...]
> There are no tests in this v4 and in v3 with both a SHA-1 and a
> SHA-256 signature on the same commit though, as I am not sure yet how
> to best generate a commit with such signatures. Suggestions welcome!

If no suggestions are forthcoming, it feels odd to implement this with
no tests.  Would it make sense to leave it out until we know how to
test it?  (More questions on this below...)

[...]
> diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-=
export.adoc
> index 43bbb4f63c..64198f2186 100644
> --- a/Documentation/git-fast-export.adoc
> +++ b/Documentation/git-fast-export.adoc
> @@ -50,6 +50,23 @@ resulting tag will have an invalid signature.
>         is the same as how earlier versions of this command without
>         this option behaved.
>  +
> +When exported, a signature starts with:
> ++
> +gpgsig <git-hash-algo> <signature-format>
> ++
> +where <git-hash-algo> is the Git object hash so either "sha1" or
> +"sha256", and <signature-format> is the signature type, so "openpgp",
> +"x509", "ssh" or "unknown".
> ++
> +For example, an OpenPGP signature on a SHA-1 commit starts with
> +`gpgsig sha1 openpgp`, while an SSH signature on a SHA-256 commit
> +starts with `gpgsig sha256 ssh`.

I had a number of comments/questions on this above already.

> ++
> +Currently for a given commit, at most one signature for the SHA-1
> +object and one signature for the SHA-256 object are exported, each
> +with their respective <git-hash-algo> identifier.

Wait..does this mean fast-export is obligated to walk over both all
sha1 commits and all "equivalent" sha256 commits when exporting a
repo?  I thought most operations on the repo would walk over only one
or the other; walking over both seems to be against the spirit of the
"fast" in "fast-export".  Am I missing something?  (Possibly related
question: Does "git log" bother walking over both, or does it only
walk over one?)  Even if this really is wanted by some users,
shouldn't they manually request it rather than making exports slow for
everyone else by default?

> +A warning is
> +emitted for each additional signature found.

Why?  This seems odd to me.  Why not merely export them all, and let
fast-import throw warnings or errors if it sees more than one and is
not yet prepared to handle multiple signatures?

> ++
>  NOTE: This is highly experimental and the format of the data stream may
>  change in the future without compatibility guarantees.
>
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-=
import.adoc
> index 250d866652..db5e5c8da5 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -445,7 +445,7 @@ one).
>         original-oid?
>         ('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
>         'committer' (SP <name>)? SP LT <email> GT SP <when> LF
> -       ('gpgsig' SP <alg> LF data)?
> +       ('gpgsig' SP <algo> SP <format> LF data)?
>         ('encoding' SP <encoding> LF)?
>         data
>         ('from' SP <commit-ish> LF)?
> @@ -518,13 +518,32 @@ their syntax.
>  ^^^^^^^^
>
>  The optional `gpgsig` command is used to include a PGP/GPG signature
> -that signs the commit data.
> +or other cryptographic signature that signs the commit data.

Good catch.

>
> -Here <alg> specifies which hashing algorithm is used for this
> -signature, either `sha1` or `sha256`.
> +....
> +       'gpgsig' SP <git-hash-algo> SP <signature-format> LF
> +       data
> +....
> +
> +The `gpgsig` command takes two arguments:
> +
> +* `<git-hash-algo>` specifies which Git object format this signature
> +  applies to, either `sha1` or `sha256`.
> +
> +* `<signature-format>` specifies the type of signature, such as
> +  `openpgp`, `x509`, `ssh`, or `unknown`.
> +
> +A commit may have at most one signature for the SHA-1 object format
> +(stored in the "gpgsig" header) and one for the SHA-256 object format
> +(stored in the "gpgsig-sha256" header).

Why?  Does this mean hg-fast-export or hg-fast-import (or a
jj-fast-export or jj-fast-import) wouldn't be allowed to specify
multiple signatures?  The fast-export and fast-import streams are
often used for interoperation with other VCSes, but as far as I can
tell, you're encoding a restriction on what's allowed that isn't an
actual problem for git but just a not-yet-implemented state.  If I've
understood correctly that the restriction is merely due to the current
implementation, perhaps the wording could be changed to not list it as
an encoding restriction, but as a current fast-import limitation?

Also, I'm slightly uncomfortable with "the SHA-1 object format" and
"the SHA-256 object format" because of the fact that these tools are
used for interoperability with similarly-named tools from other VCSes.
I think it'd be better to just treat them equally as "here was/were
some signature(s) on the object in the original repo; importers can
choose what to do with them".

> +
> +See below for a detailed description of the `data` command which
> +contains the raw signature data.
> +
> +Signatures are not yet checked in the current implementation though.

...but what does happen with those signatures?  Dropped?  Kept as-is?
Can we just spell this out a bit more clearly?  e.g.

"Signatures are not checked in the current implementation; they are
used as-is, which may mean the signatures are invalid in the imported
repository."

> -NOTE: This is highly experimental and the format of the data stream may
> -change in the future without compatibility guarantees.
> +NOTE: This is highly experimental and the format of the `gpgsig`
> +command may change in the future without compatibility guarantees.

Good clarification.


I briefly skimmed the implementation and test files, and didn't see
any problems...but I think it probably makes more sense to get aligned
on the goals of the format and how these fields are meant to be used
before diving into those details closer.

Thanks for working on this topic.
