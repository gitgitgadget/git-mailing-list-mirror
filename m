Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C92F1FF9
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750965130; cv=none; b=PH6jzJC36Yg475Rq8GLJBzc8AEJlcPn/kOLkbmxkqUcobSTgWWlzXRjRW8/PLZuoO5KNes0kz41YMIm+PqU1nT3cMlNsuDbC22HImUwwe/7ype5bjJwux/L5RLgdWr/n97KHxE3AKBXjJ+VzLqylsMUWvL93L/avGiSfcL6o6G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750965130; c=relaxed/simple;
	bh=XTC+AHTwJNvxLGEjc9p2OdGufBK3oBBfYsKI1fFCvog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBUl9I9Gcm5828SNYz+Yf03WBb67keQT5y/+RgrXxAgD71ToN3OoW5nTGd+CqhFJQDhb418SOVJRWbliPe7QQ6Q/EATYqnasX/ZoXlVt/pfAGgAcdgcLyM/CHZzsnCGpvOaLglNuuWloXIUIqU+z20M1+S8R5/dQOSTcJCDn6/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0+gbGFu; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0+gbGFu"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-86d01686196so44238139f.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750965128; x=1751569928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r4YxfuTWeVo5ONPXVO8KJIARHsjDBQJ82zDpyxW2N8=;
        b=O0+gbGFuUaOPXSrukg8/HoVlujlbz3KGevZj68MJtHIFAuwBuT8hFNNPokWVhnfN3v
         etnKW5waOVmKo/6GY0+mwDNT70E13qCsvoPaM4viGk+NtpieVGXKbNnUuxLTdxcmwyQa
         D4sB4tgkqa/m3aE+Fbj0818zUXCpnM8WFQzqo1yID0FvQ7hSvfxJXhk4Vl9mekAWudSj
         dq8cs7WJxESPiOvk6B+3cWVlF6Sh9oGClIjY1HLLQj7LA0uJFd+XDVoZqb8Nj8r1pfff
         rIxEDR0jLHkkPYoak2PR08W6bHn20F1moPLwP7U+OX25gIRacMV+0dgCzoNOczwOW0Y8
         RH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750965128; x=1751569928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2r4YxfuTWeVo5ONPXVO8KJIARHsjDBQJ82zDpyxW2N8=;
        b=DqYA6qzz4I2orptU/xfwdmDHLICFgfUUfLYQhsCVLnO6HsN3wab+wuARKaX6ioNXvF
         KTFpV7Viu5wc529ZUgzJyabIWK5sqpV/us+Uh7cptKKGNcIoaUdSdZM8F5oKrMyh+WVu
         TClQn+WVlLaFlB6bMPFhAICPGveff7enpO2KyZJaKIFm5jRicNswV6Db8pby9bDy3y/T
         rsZ+El1PnTPnRIljl0j/eE1u5RGHTZ4dkr/63VySDYOBm70AqOfBqlNTModL9EFPohMr
         lhgzBAGDcA2TSv9smJYhpVdIF79ZGLRlGMylb/F3iGFCu/tzbjd4liiOd4F4HGWlx+/T
         NcUg==
X-Gm-Message-State: AOJu0Yy31/NrW2X8VaGm7w83vqHsQt7SFDayLaWEbcO5om/tFTRZVGiu
	TdJqSy2jsfJvG12tMzq5WGclydGIen9wNwQUHlpUh6omsOJWDRc05Dv1ZiA0JNbbKOjOB/YjUgy
	F/FapcK8m1uhNR+GDTW9RIR1901LgpMU=
X-Gm-Gg: ASbGncvoLarOtKP4Az+0Dm/wY2ZAO4LW0Jc6i+QQ6FF3jjLrWn8VF9YaJSM7kC1Vya+
	QdQtjrCLt9OUE8vZRrmvV9/yM999douDsUCs4VU0HLkWzQ2frmhbGkUnsx5jcfwjr0Du7Vn53mn
	4F1ZqScSXSao622XRyNmp5M86ElX9cqIA5zJzpvxdbRQ9Sa4b4/x9jkThHP9N/C77b2eGotu0pq
	669QQBmEpgwMiA=
X-Google-Smtp-Source: AGHT+IHCxGwcRSC293qcdLwaqnI1my+/N9EbIUHvq8+dsSjSlKWz9RlXDwh+Hu5nRciPuQ3Zlk0l3kNdnBMmCvnrEho=
X-Received: by 2002:a05:6602:2c90:b0:875:bbf0:8bf with SMTP id
 ca18e2360f4ac-8768859204amr97128139f.5.1750965127737; Thu, 26 Jun 2025
 12:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618151821.528627-1-christian.couder@gmail.com>
 <20250619133630.727274-1-christian.couder@gmail.com> <CABPp-BF6ZjfJ2MSHkhXQwv00=63qG3wLU8ie=_WVxnWTffFpRA@mail.gmail.com>
 <CAP8UFD24LayEi-=PREqbiyC7PeJbYEP1ghOZ+T-ma=DZVaPtSg@mail.gmail.com>
In-Reply-To: <CAP8UFD24LayEi-=PREqbiyC7PeJbYEP1ghOZ+T-ma=DZVaPtSg@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 26 Jun 2025 12:11:56 -0700
X-Gm-Features: Ac12FXyqBhVK5iF6SmmetMdLKYq9gElvTXlbkAXJ1Nz_d1auFUWLzzveWT5ZN48
Message-ID: <CABPp-BE8b8Ju3zaB04DzQJoSKwNkHcHTw8q95ux_bb4hOpboBg@mail.gmail.com>
Subject: Re: [PATCH v4] fast-(import|export): improve on commit signature
 output format
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 9:12=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Jun 19, 2025 at 11:44=E2=80=AFPM Elijah Newren <newren@gmail.com>=
 wrote:
> >
> > On Thu, Jun 19, 2025 at 6:36=E2=80=AFAM Christian Couder
> > <christian.couder@gmail.com> wrote:
>
> > > However, this implementation has a number of limitations:
> > >
> > >   - the output format was not properly described in the documentation=
,
> >
> > Thanks for working on fixing this.
> >
> > >   - the output format is not very informative as it doesn't even say
> > >     if the signature is an OpenPGP, an SSH, or an X509 signature,
> >
> > Why would it need to say what type of signature it is?  Don't the
> > ascii armor lines have e.g. "----BEGIN PGP SIGNATURE----" and "----END
> > PGP SIGNATURE----" around it, which fast-import can read as well as
> > fast-export?  Is the idea that we strip those lines and now need to
> > replace the information we lost?
>
> In https://lore.kernel.org/git/aAq1nvcPRlIPal5l@tapette.crustytoothpaste.=
net/
> brian said:
>
> "These should be separate fields: one for the hash algorithm and one for
> the protocol.  Alternatively, we can just keep the hash algorithm field
> and parse the protocol by reading the first line, which will differ for
> different protocols."
>
> It would have been nice if you had then said that you prefer not to
> have the protocol.
>
> My opinion was that it was better for tools processing fast-export
> output to have the protocol as they have to parse the "gppsig ..."
> line anyway. So it should be easier for them than to parse the ascii
> armor lines.
>
> > >   - the implementation doesn't support having both one signature on
> > >     the SHA-1 object and one on the SHA-256 object.
> >
> > Not sure I understand this; more questions around this later.
>
> In https://lore.kernel.org/git/aD4i7YhUnT5Kgew-@tapette.crustytoothpaste.=
net/
> brian said:
>
> "Actually, what I was saying is that we should have one for the hash
> algorithm that is used in the Git object.  I don't care about the hash
> algorithm used in OpenPGP, X.509, or OpenSSH (that is, whether it's
> signed with SHA-512 or SHA-256), but we can have multiple signatures in
> a single commit such that there's both a SHA-1 signature and a SHA-256
> signature."
>
> so I implemented the possibility that there's both a SHA-1 signature
> and a SHA-256 signature in a single commit.
>
> If you disagreed with what brian suggested, it would have been nice to
> reply to brian then.

Sorry about that.  I hadn't read the whole thread; further, I was
previously trying to avoid the details of signatures beyond the basics
and hoping to leave those details to others, but between v2 and some
words you had in this version plus deciding to just take a closer look
while on vacation (as I was last week), I decided to try to look a bit
closer.

Turns out, though, that despite my attempts to read a bit more
documentation and code in the project, I still had a fundamental
misunderstanding last week when I was responding.  I had been assuming
that the gpgsig headers would appear on sha1-commits and gpgsig-sha256
headers would appear on sha256 commits.  I didn't understand that both
types of headers can appear on both types of commits (so that, for
example, gpgsig-sha256 would be use the sha256-commit as the source
and sign that data but write the result to a sha1-commit). I talked
with brian this morning to ask a few questions and he clarified this
for me.

(Side note: It might be nice to clarify this in
Documentation/technical/hash-function-transition.adoc; that document
did not dispel this confusion when I read it last week.)

> > > Let's improve on these limitations by improving fast-export and
> > > fast-import so that:
> > >
> > >   - both one signature on the SHA-1 object and one on the SHA-256
> > >     object can be exported and imported,

And the part I didn't understand the first time around is that e.g.
the SHA-1 commit can include both the signatures on the SHA-1 object
and on the SHA-256 object.  (Similarly, the SHA-256 commit can include
both signatures as well.)

> > >   - if there is more than one signature on the SHA-1 object or on
> > >     the SHA-256 object, a warning is emitted,

This is now ambiguous to me.  more than one signature using the SHA-1
as source for signing, or more than one signature recorded within the
SHA-1 commit?  I think you mean the former.

> > >   - the output format is "gpgsig <git-hash-algo> <signature-format>",
> > >     where <git-hash-algo> is the Git object format as before, and
> > >     <signature-format> is the signature type ("openpgp", "x509",
> > >     "ssh" or "unknown",
> > >   - the output is properly documented.
> >
> > Perhaps this was discussed in an earlier round, but if so I either
> > forgot or missed it.  What value does <git-hash-algo> and
> > <signature-format> provide?  How are they intended to be used?
>
> My opinion on this is that in cases like this we might not always know
> what could be useful for tools or users in general, so it might be
> better to provide more information that can be easily discarded if not
> useful rather than not enough information.
>
> brian seemed to say that <git-hash-algo> and <signature-format> are
> important so I just prefered to have both, especially as they are not
> costly to get.

So, with my new understanding, <git-hash-algo> is necessary because if
you only had the gpg signature on a commit object, you don't know what
it was a signature of -- it might be a signature of that commit
object, or it might be a signature of it's "compatibility" object
created with a different git hashing algorithm.  So, fast-import --
regardless of whether it is writing into a sha1 repo or a sha256 repo
-- won't be able to know how to check the validity of the gpg
signature unless it knows whether to check the signature of the sha1
commit or the sha256 commit.  And if the repository that fast-import
is writing to isn't writing compatibility objects for interoperation
at all, then it won't be able to check any compatibility signatures at
all; it'll only be able to check signatures of the actual object it
wants to write.

> > Is the <signature-format> merely self-inflicted pain from stripping
> > the ascii armor lines?  If so, would it make more sense to just
> > include those armor lines as-is in the fast-export stream and let
> > fast-import process it?
>
> The ascii armor lines are kept in the fast-export stream, but
> fast-export's ouput is supposed to be processed somehow sometimes
> before being fed back to fast-import, so I think we should make it
> easy for tools or people processing the output to get signature
> information.

Ah, just for convenience of the importer/processor; fair enough.

> > Is the <git-hash-algo> due to the fact that we have separate `gpgsig`
> > and `gpgsig-sha256` commit headers and we want to use that information
> > to avoid writing these headers to the wrong-sized objects (and/or to
> > avoid checking whether the signature is valid on the wrong-sized
> > objects)?
>
> Yeah, I think it could help with that, but brian might better answer that=
.

I think the answer is actually no, this isn't at all what these are
about.  These are about knowing how to check the validity of the
signatures, because the signatures aren't necessarily associated with
the object they were read from; they could be a signature of its
compatibility object instead.

> > If so, could that be spelled out in the docs as well,
> > especially since it appears that the intent of these headers is left
> > unimplemented due to not changing fast-import to do anything with
> > them?
>
> fast-import puts back the `gpgsig` or `gpgsig-sha256` headers
> depending on <git-hash-algo>, so it's useful at least for that. I will
> improve the docs about it.
>
> > And if <git-hash-algo>'s purpose is to ensure they are only used when
> > writing same-sized object as what was exported, then...isn't that a
> > bug?
>
> I am not sure I understand what would be the bug.

It's not relevant given my misunderstanding, but to explain what I was
thinking last week (note that the first two bullets are my mistake):

  * gpgsig headers only occur on sha1 commits and are the signatures
of the sha1 commit sans the gpgsig header
  * gpgsig-sha256 headers are similar with respect to sha256 commits
  * we were using <git-hash-algo> as an optimization to only sign
commits in fast-import if the repository we were writing to was using
the same hash function as the repo we were writing from

In such a case, that'd be a bug for anyone that wanted a
'resign-commits-that-were-previously-signed-if-the-signature-becomes-invali=
d'.
Although a signature of a sha256 commit clearly won't verify if we
exported a sha256 repo and imported it as a sha1 repo and tried to
verify that signature using a sha1 commit, that doesn't mean we should
just ignore the fact that the sha256 commit had a signature.  The user
clearly expressed the intent to resign any commits that had a
signature before but where the signature is no longer valid.

> > This series was started because people wanted to be able to do
> > things like keeping signature even when they are no longer valid or
> > resigning commits that have a no longer commit signature (among other
> > uses), but that would mean that if someone exports a sha1 repository
> > and imports it as sha256, we don't want to ignore the fact that the
> > sha1 commit was signed for those usecases.
> >
> > If, however, the <git-hash-algo>'s purpose is merely as a performance
> > optimization that fast-import can employ in the cases where it checks
> > for signatures being valid, so it can avoid checking when it know the
> > hash size isn't even the same, then it could make sense.
>
> I think it could be used for that, but I'd like brian's opinion about thi=
s.

No, I was just wrong; it can't be used as such a performance
optimization.  A signature of a sha256 commit stored in a sha1 commit
(or a signature of a sha1 commit stored in a sha256 commit) isn't
accidental, it's part of the intentional design of the hash-function
transition.

But, it might mean that the rules for what to do with signatures in
fast-import need to be more complex than what I previously
wrote...which I'll comment on a bit below.

> > Wait..does this mean fast-export is obligated to walk over both all
> > sha1 commits and all "equivalent" sha256 commits when exporting a
> > repo?  I thought most operations on the repo would walk over only one
> > or the other; walking over both seems to be against the spirit of the
> > "fast" in "fast-export".  Am I missing something?  (Possibly related
> > question: Does "git log" bother walking over both, or does it only
> > walk over one?)  Even if this really is wanted by some users,
> > shouldn't they manually request it rather than making exports slow for
> > everyone else by default?
>
> No fast-export doesn't walk over both the sha1 commits and all
> "equivalent" sha256 commits, it can just process at most 2 signatures
> for a given commit, one with the `gpgsig` header and one with the
> `gpgsig-sha256` header. I will try to reword the doc to make it
> clearer.

Right, but fast-import might need to *write* both sha1 commits and
sha256 commits (or at least write one of them and keep a mapping
between the two in memory) in order to correctly verify and process
both gpgsig headers...or at least, it will be unable to verify
signatures of compatibility objects if people do not have the
appropriate extensions.compatObjectFormat config setting set within
the repository they are importing to.

This actually expands the usecases I mentioned previously a bit.
Those usecases were:

(A) Make fast-export include signatures, and make fast-import include
them unconditionally (even if invalid)
(B) Similar to (A), but make *fast-import* check them and either error
out or drop them if they become invalid
(C) Simliar to (B), but make *fast-import* re-sign the commit if they
become invalid
(D) Similar to (A), but make *fast-import* re-sign the commit even if
the signature would have been valid

Cases (B) and (C) might either need special care or need to bifurcate
into additional options given that we can have two signatures on a
commit.  "Validity of gpg signature stored in the commit" now becomes
"Validity of gpg signatureS stored in the commit".  Whereas before we
only considered the cases of "no valid signatures" and "all valid
signatures", we also need to worry about the case where one signature
is valid and the other is either known to be invalid or simply cannot
be checked because this repo isn't set up to write compatibility
objects.

> > > +A warning is
> > > +emitted for each additional signature found.
> >
> > Why?  This seems odd to me.  Why not merely export them all, and let
> > fast-import throw warnings or errors if it sees more than one and is
> > not yet prepared to handle multiple signatures?
>
> I am not against implementing both export and import support for any
> number of signatures, but it seems that Git in general doesn't support
> more than one `gpgsig` and one `gpgsig-sha256` signature well, and
> that's also what brian suggested supporting. It's also better than
> just 1 signature max which is the current state.
[...]
> > If I've
> > understood correctly that the restriction is merely due to the current
> > implementation, perhaps the wording could be changed to not list it as
> > an encoding restriction, but as a current fast-import limitation?
>
> If that current fast-import limitation was lifted, we should probably
> still say that additional signatures might not be very well supported
> by Git in general.

Ah!  I thought you were saying that fast-import specifically didn't
have good support for more than one signature (and I was assuming the
rest of Git did) and were using that as the reason to avoid handling
more than 1.

Sorry about that, I'm following you on this point now.

> > Also, I'm slightly uncomfortable with "the SHA-1 object format" and
> > "the SHA-256 object format" because of the fact that these tools are
> > used for interoperability with similarly-named tools from other VCSes.
> > I think it'd be better to just treat them equally as "here was/were
> > some signature(s) on the object in the original repo; importers can
> > choose what to do with them".
>
> I don't think giving that information prevents tools from other VCSes
> from doing what they want with the signatures.

Yeah, sorry, this was fallout from my misunderstanding about commits
having signatures from their compatibility object.  That's just kind
of fundamental to this hash-function transition, so ignore what I
wrote here.

> [...]
>
> > I briefly skimmed the implementation and test files, and didn't see
> > any problems...but I think it probably makes more sense to get aligned
> > on the goals of the format and how these fields are meant to be used
> > before diving into those details closer.
>
> Yeah, I would have been happy if we could have been aligned with the
> goals of the format and the fields earlier, but better late than
> never.

I think the proposal for the fields in this version make sense now,
but it might have been easier to get alignment if (1) we could get
real testcases of the multiple signature case, and (2) we could see
the actual code for fast-import to deal with the signatures (trying to
guess the needs of the importer and the meanings of the fields we
export is supposed to be is harder when their usage has been left
unimplemented).  That said, I also understand you wanting to avoid
implementing too much and throwing things away if we disagreed on
early decisions.

Anyway, I'm on board with these new fields and their purpose, though
I'm still curious if we start diverging when we run across surprises
as we dig further into the implementation.
