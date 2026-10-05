Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5288D43B49D
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192797; cv=pass; b=dQkRaPp+d3b5i/zMsYCZSqCslsCdRYo4aHxkZo0I8y8dg4pcFQoNEqgGQT6zvMkh1tMTYew8Y/Jl2hMCsi9jbQvghnyPQcSta86Ql7ZUxg4CoWzGtg2s1Npki2p2i28GOxwob3rffANPVjTXfFlsGok/d23efH60UwC4FPQpw9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192797; c=relaxed/simple;
	bh=YpjLILkTBRVqPzvdjcV80bx3AXZzVbW9+OdarcaJ/lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nBz5k/2Phk7oYWLaAKrCXT63YQ04rJT4Xls/L6gbPhvtpusJ4q/Xo4Iaccs/GUMu+Lv5c4tpm61WEIce8vQIm9D9WO/w0GBi1As7cqIyd593ZmOfBM8BsmWUPXfbVSRYKx4p7Q24IOKhyABblQ+Yg7sIEdXyX7U3LqKCXcKl7Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGSgA2gv; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGSgA2gv"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so2146024a12.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 02:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791192787; cv=none;
        d=google.com; s=arc-20260327;
        b=lzHuGkvyiJEyyMNuiK4mzWBuY2fLtrRLb9/DI7uUWFqLc1tn4fH773JUGnnRsXuKRK
         SJf8odhtMAi/WswR4Ibsk6xfIzZrjJgf2miMLlEgO96IidjZf4twGMpAlQ7bL6B3okq8
         fLQyynK29f8XScC5zITULfJ5VuMDu/xo7Yhn62w7r6d8IZheKgq6i88cXnp+x8cPctEc
         r/a8wGcSJjH2wKAKGhNuDETDMwQEh2HTi1Fx5/fqjp2P17mjkVjQ7OD77t7oZ9okTLxY
         bqC4e5O98IVSBa+L2ieix1K+j1JYPsAhvq8zq8l3BiOxmCrsFjDXUnFSs1FfzmkVMK1O
         kCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EOUcI/HHXOJTNHgplKhjY5rHSxrHY9BIfxDflzJ6DcY=;
        fh=r84HmxcgUx94S6vr4jI7NZ3hAlWGkEdA5opQnWCeoGk=;
        b=AfOZgTAMhRO4MucTmSYbfT0rQW6yBA5YRQB2AR9GRHYSYJTEHhldGg5bAKPwgQzeu7
         1aRv2LrZkchBsctlC1CWv8zDbBgCPQXoCNhytkA+Qb+qt6WyXjgd3zeQ6qzJ9ydBhWQr
         /z/3zyK3TVTvuL2fWZW1vtXpREA/LQFe76ShE4ubZV6WF9nE8SJEvT2gAPngo9TI5ghc
         prkE4Kt9W6X3I/ZKhxOXzxGt0npgYlbwPjU3vT/4xdFvyaN2mC42QclHtYPohff/o0Us
         PyER0F0Oe6zTEisLfu0uI/Bx+uKgHlelaOQCfFubzMyItE8yZa73xcA9Or8N5g4Jg3du
         cChg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791192787; x=1791797587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EOUcI/HHXOJTNHgplKhjY5rHSxrHY9BIfxDflzJ6DcY=;
        b=kGSgA2gvMFDN80gH1Qeu25xKjRzrTsV3P16Rm44+0zlS/dB5pmZmYortKjTlLi2SUk
         PtAn+x639EAhwak/+GN1tSFBVnWa8M3wsiOJ+dYs4KksY0aF+/fFcuMvK0xUlNlC2O97
         Cf6ROEcRAr3aP7m8mK4FCVshp5Ah8j2RFcPWKG6OOIanDjvQIUtLIE/ZSCaHCwfsk5Wt
         3L/N+Yec8V+iC3YF8rSfDmP7XqaC9u8H0ufRkfEgOnT8j62PSKZD2Gq6KkQDk2vHy512
         VHfejS3m9lAqhpfhNw/oAnczDzAJyK68TyAE23EGmkNW7PL15bPallZKm33+75zAtPfX
         N0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791192787; x=1791797587;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EOUcI/HHXOJTNHgplKhjY5rHSxrHY9BIfxDflzJ6DcY=;
        b=Pd7p/wiPwaeBZOojQDrshGUjaqBsXLdsvfltpn6g4f+lnv7E7DnF/UxY2VvXPuA5hk
         EU23tJ4JIJD9YNbHIRzCuCeeyPCtWRrwZXw08poLnnYwmyUw6FJZpZnKdJ1reCMyhxI/
         e0DUakplvU88c+wphdBG+3d95kvidNyrLq2R+df1k4f7m0NuKTnZyQCu4F2cCCZK3o3C
         Q8jaKpxvyOCnsK+okk6spSN2slx1w+/9gzFahRAik7oBN9+dodrAXw7Ww/QY7AosY6aU
         0eatlS1Yv9CH+fjHzPpwlMs7BAbouWGvcmNqCCwbgAKG/N0hA3nlAYDkHT6QVWCGeMnu
         qJ4A==
X-Forwarded-Encrypted: i=1; AKwUvBwnKMC3NXZEDs8dQh2t1IEl3flQTuOpdWZ/uQcec/69/TxgEAz2U78uNUF4SlUgGBQAhck=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEPU+mVsvvCitGL5AO+umvKxsEPjXaWqY6qWiXHA2L/5uhJp+7
	yGCPvUrGIs4syCXpqilnNEDYPaqLY8v8S3ybkBiZ3xMQ+kyGdZonud5rqE+23qrlt5fyi6uOPSZ
	wz6eOUjTmqB/DPZx8jd9eZYtI4+vcS8O6eYts8nXh7DIrir4=
X-Gm-Gg: AYBFou1hLBqlnfZIhCUgAwKWtqZsTUCJz92Vusmni84EqPwEV9t7ZYWYMoEFOzC7xXa
	JIeAqE6Z/CuZjpFjpGyCk9ZlT+5eUZfB4FmNnzDoWB/jct5r3Y8LTagEFEJ5A3YQhYaJh7zQnmC
	QnaQ4a5NFGSTI5l38ISN+Vg8JzkrgkFr+3Aj7UT9yIy9ky0nqN8xSSUbsHU/o+b9K8E8QJpBh5h
	f96DnQYnKRawudoai8JTdHYGQNmiJTFOkg96VCrK0VD/xKTmOMMUenJ6wG62fpJp/BUkoIF7Rim
	W1asmrQvSCTQRFqRO4vlic7vVR55pU5kw+IukuB1I/1ARw3ZEjia9oFlDHZaQ+Ft+QGfUTc/GXg
	h4UoEPq2ivPU=
X-Received: by 2002:a05:6402:4487:b0:6aa:f14f:5577 with SMTP id
 4fb4d7f45d1cf-6afad904f07mr6772190a12.23.1791192786824; Mon, 05 Oct 2026
 02:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002081846.25144-1-scott@gitbutler.net> <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
In-Reply-To: <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
From: Scott Chacon <schacon@gmail.com>
Date: Mon, 5 Oct 2026 11:32:54 +0200
X-Gm-Features: AclHuK8ND6qEwDYEBrWJTdoyFV2tV8HAruuxT5IjELGEDToaMiDYV8U_dL0DqJc
Message-ID: <CAP2yMaKF4CRvtfTQDVe51SqEm_DnoVOmED5kcUSg7UvLkBp4Xg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and tags
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Scott Chacon <scott@gitbutler.net>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey all,

There are basically two things to respond to here and that I feel the
list should consider before 3.0.

One is this specific proposal of an independent content hash in a
signed header, which I find interesting and potentially helpful
regarding SHA-1 issues, but not necessarily fundamental.

The other is if the default object store for 3.0 should be sha256 or sha1.

On Fri, Oct 2, 2026 at 9:06=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-10-02 at 08:18:42, Scott Chacon wrote:
> > I'm concerned about the ecosystem impact of moving the `git init` defau=
lt
> > hashing function to SHA-256 in 3.0. I have suggested that it may be mor=
e
> > feasible with similar benefits to add the ability to inject an independ=
ently
> > calculated and verifiable tree content sha into signed objects instead.
>
> I don't think this is a good idea.  There are lots of reasons it's not,
> but the simplest one is that Git requires collision resistance because
> it is impossible to store two different colliding blobs.  We don't have
> any such blobs yet, but I fully expect SHA-1 to become as weak as MD5,
> in which case there will be a large number of items that cannot be
> stored in a Git repository.  Even if you don't want to store those
> blobs, there are many people, such as security researchers, who _do_
> want to store those blobs and that requires a SHA-256 repository.  Your
> approach does nothing to address that problem.

My approach was not meant to address that problem, partially because I
believe it to be an incredibly niche problem. For security researchers
or people over-interpreting NIST guidelines to mean "use at all"
rather than "use for signatures", then SHA256 is clearly already a way
to initiate a Git repository and can be used that way. They can do so
today - making sha256 the default in 3.0 does not help or hinder them.

I don't mean to say we should remove different hash algorithms from
Git, but that the _default_ should not bifurcate the entire community
so that security researchers are slightly happier in still mostly
theoretical situations.

Even if Git were based on MD5 content hashing, nearly everyone using
it in nearly every normal scenario would probably be just fine. We can
sign something that is not based on that hashing function (the basis
of this series), but overall, the social trust mechanisms of pull
sources are the predominant security layer, independent of hashing
function.

It's important to differentiate this, since it's being conflated.
Using SHA-1 for signatures is clearly problematic. Using SHA-1 as the
content-addressing hash for it's Merkle DAG is not. The way Git uses
SHA-1 primarily does not rely on a hash function being collision-free;
it relies on a hash function being one-way, which SHA-1 is perfectly
good for and always will be.

The only real issue is that it _also_ uses that hash for signature
integrity, which means we can solve the main issue simply by not
_also_ using it for signature integrity.

> Consequently, we need to make the problem better as soon as possible and
> that means moving away from SHA-1.  TLS, OpenPGP, and other major
> ecosystems have already made this transition and we're very far behind
> the times.  The Canadian government already recommends users to have
> moved away from SHA-1 and the U.S. government will no longer allow SHA-1
> for any purpose as of 2030.  I want to be clear that 4 years in the
> large business and government sector is nothing.

I feel like this is arguably overstated. This is conflating "any
purpose" with "applying cryptographic protection" / digital
signatures. Part of the point of this series was to ensure that
signing would be based on SHA-256 and could in theory make signatures
on Git objects compliant with these NIST-style mandates while still
using SHA-1 for the more basic odb content-addressing work.

In other words, I don't believe that these governments and businesses
ban SHA-1 _for any purpose_. They ban it for the use of cryptographic
protection and I'm saying that a simpler approach to solving that
problem is to re-seperate content addressing hashes from protective
signature hashes.

TLS, OpenPGP, etc all mostly stopped using SHA-1 for signatures, sure,
but that's because providing security is essentially all those
projects do. Governments still let you use modern browsers and
websockets, even though SHA-1 is used in that protocol, specifically
because it doesn't depend on any security properties of SHA-1.

This series is likewise proposing an alternative, non-SHA-1 based
signing and content verification method along with an argument that
maybe seperating those concerns is simpler and less
backwards-incompatible.

> I'll also add that the design we have is the design we've had for many
> years and there has been ample opportunity to propose alternative
> designs.  The plan for Git 3.0 is around the March timeframe and making
> substantial changes now is far too late.

First of all, if you include the compat work, which imho is incredibly
important to this transition being feasible, "the design that we have"
is not even completed yet and is slightly different every time I hear
it. As recently as 8 months ago, you yourself stated "We don't believe
anyone is getting useful use out of the interoperability code in its
current state" [1] and I can verify that this is still the case -
interop is currently completely unusable.

The point of my tree-sha256 series is to actually massively simplify
the work remaining and user experience impact. I'm saying "don't make
it the default", which means that the entire ecosystem doesn't need to
Y2K everything for the next 5 months. Even in Git core, there are
still _substantial_ changes to make for the compat stuff, if I'm not
mistaken. If pack index v3 isn't in core now, do you think it's going
to be in libgit2 and gix and JGit and whatever by March? Not even the
stuff that landed here 6 years ago is in JGit today.

As for the late hour comment, I've felt that this "flag day" hard cut
has been a rather impractical approach to this problem for a while now
and I have mentioned it to several of you in person in the past.
However, I thought maybe some clever solution would come up over the
last two years, but seeing Emily's talk at Git Merge, this close to
the proposed cutover, convinced me that it's going to be a usability
nightmare for everyone. And as above stated, I'm not convinced that
this is anywhere near valuable enough of an outcome for the cost and
difficulty associated.

I also think that a lot of other people would agree, if they had an
idea that this was coming. I believe that many, many users will be
surprised and confused by this when it hits. It turns out that not
very many people read the mailing list.

> Every major forge has support
> for SHA-256, whether publicly or in preview,

Nobody has access to this for GitHub, which is where almost all usage
is and where the kinks could theoretically have been ironed out. If
3.0 comes out in March, there will have been no time for anyone to
give feedback or make substantial changes before everyone is forced
into real usage of this highly incompatible change.

So Bitbucket doesn't, Gerrit doesn't, GitHub doesn't in any practical
sense (I'm curious if anyone on even this mailing list has access to
it's "preview"). GitLab has it under "experimental". I'm hesitant to
agree that Codeberg or whatever constitutes "every major forge".

If anything, this is one of my biggest problems with this breaking
change proposal - it has not been tested in a real way by nearly
_anyone_, nor are major parts of the transistion plan
(compatObjectFormat, pack index v3, fetch/push compatibility, compat
sig verification, etc) fully implemented even a few months out from
the cutover.

As one small but interesting example, I'm honestly fascinated that
there is only now a thread here about the GitHub specific usability
issues [2] with mixed odb repos (between several GitHub-y people,
nonetheless) that hasn't been previously considered (the "limbo"
idea). This is the kind of thing (among many others, I'm sure) that
would come up if people had time to use this at all before a default
switch.

> and no forge has support
> for this design, nor do I anticipate it seeing a lot of traction,
> especially since we explicitly rejected the kind of half-transition
> you're proposing for security and other reasons.

One of the nice things about the design of this particular series is
that no forge support is needed. It would work today.

The new tag/commit header fscks fine and is transferred fine. You
can't rebase signatures anyhow, so dropped headers aren't an issue
(like commit-ids sometimes are). Verification is trusted locally and
if `verify-commit` and `verify-tag` learn this header too, I'm unclear
what "forge support" you think would be needed. New clients add the
new, more secure header, new clients verify it properly, old clients
fall back gracefully.

> Git 3.0 and the
> requirement for SHA-256 were discussed at Git Merge 2024 in Berlin and
> discussion has happened on the list quite a bit since then, so it
> shouldn't be a surprise to anyone.

Yes, my objection is late-ish, but again, it's because I'm not
satisfied with the transition plan or implementation and I assumed it
would have had more time to have some real world usage before the
cutover.

Furthermore, that's just from someone who has actually been there for
many of these discussions. There are a lot of discussions on the list
that will be a surprise to _users_.

Do you have any idea how many custom scripts (various kinds of hooks,
CI scripts, etc) around the world are going to explode on all new
repositories because they have `/^[0-9a-f]{40}$/` hard coded
somewhere? It will be the first time most users have any idea that Git
3.0 creates repos with a different structure - errors like that or
"fatal: the receiving end does not support this repository's hash
algorithm", or Eclipse simply not working, or a hundred other little
issues, will flood unsuspecting Git users. Furthermore, in many cases
it will be _very_ difficult to figure out why exactly this is
happening on some repos and not others.

So yes, it will surprise many, many people.

> The thing you really want is the interoperability work, which can
> automatically rewrite repositories from one hash algorithm to another
> during a clone or fetch operation.  Yes, it isn't quite that simple for
> submodules, but if you recursively clone the repository and all its
> submodules, it should be possible to rewrite it in place, although that
> hasn't been written yet.  That work has not yet been sent upstream
> because some of it was written at $DAYJOB, which requires that we use
> Outlook and we all know that Outlook corrupts patches.  However, there
> is some intention for another company to handle the polishing and
> sending, so it should be available sooner or later.

I think that well thought through, fully implemented and thoroughly
tested interop work is fundamental and neccesary to a change in the
default object format, yes. I find it confusing, especially for a
project so backwards compatibility focused, that this is not a more
widely held viewpoint.

You don't have to accept a version of this series or it's approach
(though I do believe that some simpler signing strategy change
fundamentally solves the main cryptographic security issues, including
NIST-y gov issues), but if nothing else, I would encourage the group
to ship 3.0 without the SHA-256 default and let it be used more widely
on an opt-in basis, let tools and forges work out the compat issues
and have time to get fixes and modifications upstream, and if it's
still a pressing issue, change the default in 4.0 or whatever.

Thanks,
Scott

[1] https://lore.kernel.org/git/20260207200446.2837699-2-sandals@crustytoot=
hpaste.net/
[2] https://lore.kernel.org/git/20261002224400.GA834158@coredump.intra.peff=
.net/
