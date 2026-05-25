Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADD1286AC
	for <git@vger.kernel.org>; Mon, 25 May 2026 03:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779680786; cv=pass; b=K2GUkDuNGxbtHqL1oR9pL4r2f1l2BNXblCi346q3WSe32/ak5JmX2mUxaLzkIGcpZ4W8P2rUQlj1uHxiDtt3hVfMmx7sG8wVmc9n67tKON/IKWBbnG4a70qLY2F7kRsvkjiJEzA3AQ/B0NfU+PDO6k3aWxS5TBRJlVuZH/wZIkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779680786; c=relaxed/simple;
	bh=FgbOdE95bwbiU5FalrCyQLnltLe/q+5cC8hMf5aNZLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlQwM0g4MGgUjePagaEEjZH8c6u4XJggggYzBDxcBMIsbvt6JDqql5qfdUiJScE0WQBCVwYdkLn5Le9MT5sSyknosY0Ncdu2mCihV+x4dpntq2uiIKieTIDe+jQ5U7mCbCnQSxEhh1h/X38d53dreShVA9mMXvTwv1gCh+lK1qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhtMvO8c; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhtMvO8c"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40502e63bso9163605e87.0
        for <git@vger.kernel.org>; Sun, 24 May 2026 20:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779680783; cv=none;
        d=google.com; s=arc-20240605;
        b=RSymWoLB1DQwDDl75+EkiEMkZYcbssloRdqsLc+716X7GXXSCoH9c7Ozgf8szIXIUO
         ej1XvVUzKzYCIDTJS4OO0+oGxv0I/KcJBYVm8tS9TV719O/IepAqZaBgmTOi9njX/cIC
         mk7yoy1E7uXN+A/d2NZ5EpZNvqyio3F6B6dfyGe1qvOQqWEQ6UyBT5Da0z316nLzBKuU
         l32j4LRdceHoJzK3OtfKFeo619tgpZHcxA1Jvr16JBDKPWwz6KNgtSvrqqOgqh1h91rf
         3mtLvc3VAzHqO3IaCE8zaJzIKA+HGycD1PwnnKvRV0QL38YdsRZMih/b9u2Sri3jtnb4
         YJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2tnrCAigyexkd5OyP+G6HLheyR+gpKg9Li8brgUIK8=;
        fh=DTvs/e0z5gY2OfrYvY2ZN9CDB8GcWsvdS+zVZ7ehMrM=;
        b=K4pR/zEEXmS99eWkfHDWKgVtR5Ar7hvlYxonuL6AySxXw9Zz6FGe6J9SjYst6jUuw1
         ucFtX1IV75Fdi/iRhz6E3AOwqUo+UTU+lMy2yXa1+bBTGeE2tJaeE4h4Zf0H8z91Ab6N
         UREz5ig07Cld4OQbQjZRyZJU17QQv8xbJMlwskCrzVEJ4V6qWObxj2PvoZ4wqMOCjdeE
         NPQtxx/TKhmFioAEAWTJZT/s7DivaDjj73woAdq3/y4fDcH/7HA55wBU+QL6WEirKFSg
         0KG3R4/tUwwJN+MFDiAqm8gjeLDbpU/4k56U5nEXI4EhSlabLF+TeTqHOP9pp4VWTWGa
         zaxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779680783; x=1780285583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2tnrCAigyexkd5OyP+G6HLheyR+gpKg9Li8brgUIK8=;
        b=EhtMvO8cyLigdm6mfK6yaCzeK03EJA33C2ZZqShtF9ME/T5wbguuE4wqiPWNpn1oeM
         ccUEDcSDEWTaYxvERYtyL3Ks+skLydzKdvuS4sbBeLthANH0CJ5Rpj2ep3NhW3JJ8YPz
         yvwmP79l6QOkjSyLRedgowRJrrQdqR4ZpVq9mAH0LqLUwxtSPgULcbRz3Z/GZbIWaTGe
         zblZTgRS5cvrDjWQSoEFJeb3TOzocqUowuWOKPEvZMm/twWqPq00dX2f22mxCNTvcS9R
         ntHCnI7oCds7jB42dYSf4F6NUMnn+7NTvZK5toGcKyFjiIjLrQUvEWQIN6MxoWqKWkPx
         id5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779680783; x=1780285583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2tnrCAigyexkd5OyP+G6HLheyR+gpKg9Li8brgUIK8=;
        b=gcr0I1EfdU52KkqTCsl8VgA8JizypmHp1gLBEUM40AiVShtE881O4Aqms4mHAs9hP1
         nHH5ZTsRkWaRhUFOO2zZMngzmDwg3VYscvfZfYwbkqDMkg4Tqd62FckqNme7gtkF+vVn
         MxkK8HBHkruhAH/4SvQk999UjVuwKgedyRFTOn4Ozrjz4C4lEKwczv0JJVj5zJ1kUAGt
         8a3l/rxclk5p+Fe7G/O+H6z64WIu0PHs+m1ymkZBHESgG7jSiZ/rh/HCV4+YtNVsTgp0
         CP5clgle+ox8C3h8qqgjqZPPmRfj6ikJWoMIRlMOE+Vk0Tfh0FbtTYn62BDLmOyWbUzh
         aEig==
X-Gm-Message-State: AOJu0Yw5LeRNZSPXsDFGPbFHtEDbVdWPIvWDuoavaWWGKtci5/kaX3wB
	PhIpxylLGWepkdCWznJ3jgLv+5kK0m8fFjkUIbmnNuvAffvM+WmiadEPwtkRSzu3XLJ9SHMdwS6
	v46BC30498ljGBpBnhtPed2e/CQ9DvGynUCdZTrg=
X-Gm-Gg: Acq92OFq7M7tyN1KReQUfJNZc3REag/UI1D2Yd68VG48sFxE2opJXBWF4TCxiETDaKP
	bBcS5JREHzHQEsFzmGNs2DkH5OaJa5yjCQvKAOIn0paeZLJQZiMTj/bFEW1RTNwCXwLkVifxG1y
	LBqb/UaWMBBxAt3mQp/0fZ68KH4YzuuITJgL1yRQ9SEop3ySLk1uqjd84szEJwBMIwdcWPW95rU
	lCDp+PVQDWcyM4sYbbK0t8yKXY2zTHfwpm7vdAgl9KM3WXPah5S9KjXjkRzfFFO+LoTaDesE758
	WFHshZby
X-Received: by 2002:a05:6512:6cf:b0:5aa:126c:1c7 with SMTP id
 2adb3069b0e04-5aa3234d63bmr3572760e87.4.1779680783083; Sun, 24 May 2026
 20:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <089615C1-6526-4ADC-926A-6A232F330DA2@light-speed.de>
In-Reply-To: <089615C1-6526-4ADC-926A-6A232F330DA2@light-speed.de>
From: Chris Torek <chris.torek@gmail.com>
Date: Sun, 24 May 2026 20:46:11 -0700
X-Gm-Features: AVHnY4JVTMc4hSqTAwR_Ff6r6eAqZNYjmdWRsvCr6atDRdZWBqrvj4WodTrLhuw
Message-ID: <CAPx1Gvco73KBWpP=h3r+Y3QQAYnFKoooBRjTeDGxEmFfm0JcmQ@mail.gmail.com>
Subject: Re: How does git track history overwrites?
To: =?UTF-8?B?SmVucyBUcsO2Z2Vy?= <jens.troeger@light-speed.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 4:44=E2=80=AFPM Jens Tr=C3=B6ger <jens.troeger@ligh=
t-speed.de> wrote:
> I=E2=80=99m looking for details and some clarification on a `git fetch` b=
ehavior I observed, but can=E2=80=99t quite explain. ...

This isn't really specific to "git fetch" at all, except for the
usage of FETCH_HEAD.

To really understand this properly, we need to understand
the root of a seeming contradiction:

1. Once saved in Git, no commit (in fact, no internal object of any sort)
   can ever be changed.
2. And yet, "git rebase" and force-push operations seem to rewrite
   history.

How can commits be immutable and yet rewrite-able? The trick here
lies in how we (humans) *find* commits.

Inside a Git repository, the "true name" of any commit (or indeed
any internal object) is its raw hash ID, such as your example of
dda8db18cfc68df532abf33b185ecd12d5b7b326. The hash ID (or
"object ID", though right now there are only two forms, a SHA1
hash or a SHA256 hash) is specific to that one object once it is
created, and forever more can never be used for any other object.
It will always mean that original object, as long as that object
exists.

Thus, as long as that commit exists, it's *that* commit, with *that*
ID, and no other.

But we (humans) don't *use* hash IDs. They're too cumbersome.
So Git provides us with the ability to translate a name to an ID:

> It seems that sha dda8db1 (tag 1.20.0 previously pointed at it)

The *name* refs/tags/1.20.0 used to produce the above ID.

> was replaced ... with fda7769 (tag 1.20.0 now points at it)

Some human directed Git to forcibly replace the hash ID associated
with the tag, in some repository or repositories.

(As the manuals note, this kind of forcible replacement of tags is
often a bad idea. It's usually better, once the tag has escaped the
confinement of a single repository anyway, to just admit that you
goofed up and make a new tag.)

If you use raw hash IDs, you can never be bitten by this kind of
tag replacement, but of course that's a bad idea for different
(and presumably obvious) reasons. I couldn't possibly name the
hash ID without using cut-and-paste here. I can *type* "1.20.0"
repeatedly without error though.

(There are additional considerations, having to do with how Git
cleans up unwanted leftover junk, via git gc / git maintenance. In
particular Git uses the human-readable names to figure out which
objects are useful, and which are unwanted junk. So you have to
identify *some* commits with names, or they'll eventually get
garbage-collected.)

[At this point, you ran git fetch with a raw hash ID, and:]

>   From https://github.com/adamchainz/blacken-docs
>   * branch dda8db18cfc68df532abf33b185ecd12d5b7b326 -> FETCH_HEAD

When git fetch obtains something from another different Git repository,
the new things have the same IDs in both repositories. Normally we do
this by *name* (branch or tag name), but for historical reasons, the fetch
operation deposits a hash ID (often along with additional information)
 in the file `.git/FETCH_HEAD`. This file then works as a pseudo-name
for the branch, tag, or commit(s) thus obtained:

> And then:
>
>   /tmp/bla > git checkout FETCH_HEAD
>   Note: switching to 'FETCH_HEAD=E2=80=99

This gives you a "detached HEAD" state, using the hash ID stored in
.git/FETCH_HEAD. That hash ID will be overwritten (thus lost) by the
*next* git fetch, so you're expected to save it in some more-permanent
name if you want it to stick around.

The key difference between a branch name and a tag name is that
branch names are *expected* to map to different hash IDs over time,
with updates adding new commits to the branch causing the branch
name to remember the latest commit's ID. Each commit in turn
remembers the IDs of its parent commit or commits, so knowing
the *last* one suffices to allow Git to find *every* one.

Rewriting history with rebase consists of copying old (presumably
bad) commits to new (presumably good/better) ones, whose backwards
links to each previous commit chain through the new-and-improved
commits until you reach the point where the rewrite joins existing
history. Then we update the branch name to remember the latest
of the new-and-improved commits, and it *seems* that we've changed
history. The old history is still in there, and will stick around for quite
a while (at least a month by default, in standard clones) "just in case".

Tag names are not supposed to move, and whether someone else's tag
update to their clone changes your own clone's tags is something
you can control to some extent. It's not a good idea to depend on
other people's clones to follow tag changes, but it's also not a
good idea to depend on your own or other people's clones *not* to
follow such changes, since both behaviors are possible.

Chris
