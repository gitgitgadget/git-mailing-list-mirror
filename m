Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A2A1F4180
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652595; cv=none; b=b3DoJZS+0SSzvFh8Iw/yVAlrHjiVNn0gI4IG6rGwZZm/qCNOdy6030A7qEIuhw0upuVT46/f4kODU5z9Pv1LxgOncnAfqMwa3zSwERXufb21hDa7bKsF7S+5ol+RDleTonUwxdMV684ts8glnJ4JxhEK1IhbWmPaz63yN1Urpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652595; c=relaxed/simple;
	bh=4vAT1cVTR0AGm4f1DOE9f8UzCZvlGt/Mmm0BLf7liDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoXORP3XQo06AtkTHlMlALnYwX1NDkeYFVxj0UyQsdn0Z5EyP8L3PfpO7BNX7fu5LRmuS9zdkiK8e6WP4lzfw2Y8CRJQ1IWE3i92lUGLk9rW1nCJFvhAK5ezQD0vYKEUSeEWY/9KGZaqYJRezg4+iA5dmG/qhX+dK2qGLuV2JL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEyJyEWx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEyJyEWx"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7f651586be1so183568b3a.1
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 14:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767652593; x=1768257393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r85V7MraxvRGn1JUP8GS5FPtyUT5WpNtwbk50zr8YJg=;
        b=eEyJyEWxu7DA7vY3tOYorOS0vCQt0iCOYQyf08+iiPBT7+tMghiHGYueElwVdCfaev
         +rr3LH4D5gNs1bzHfAABr7QDWYuJXV6pLzGymv7ESanFI4MBvlFnZdKHqDcNAwuaw/4H
         4ChI3ogkFlz4BUqi4vPwDvtLaYXlB76CQ6nt4uJGahYvP0EuRaYE7fYxNpE7GNbopFMO
         yT15V5sNS/UknsHH7q0HlO8yFXauGuzaVvQCvTSqkE+5TJAgq/ASE0YlXr9NcOZ1RpF7
         zJK/k0EYjxKRzELXrcfgUEjEAc6cMpxxSuV6HjUJ55sLGHq6+/HrdNKtqGMcexNrBgem
         h9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767652593; x=1768257393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r85V7MraxvRGn1JUP8GS5FPtyUT5WpNtwbk50zr8YJg=;
        b=pJA33nRytg8egtFef3Lxt/Z4p8oGfk4inumtGXoCGFYC3o8QGNRwSvBqVcLWC9fdY/
         I3aDnccbLF7J/wfTwZLhX5SQObStJgQeUQpLUqLV8m90Ogib/m547lTwE/iNIgXEoswP
         BznIEnml0R7xdtn8eFynDGViZE+00AWLTWnBByDtCVDEHRq2tX8a88p9A0bmCIc0ywNU
         nYRi1PfCN8kRdM6p+SDFnhFQEZFVRXv0LnuEGZvxEVRtbWG6u2vLgvqHAOIScT5Ik3fX
         xYinQV7ser7fQ+gBAihdUGmBS1zpPOxZ+0+Gw/H0x5YsJAZ5F7jbcgyhWSjjVPYZWyht
         pLuA==
X-Gm-Message-State: AOJu0Yx+AtWL9Dm3RFxyLR3cXNVu/VaPMG/ezb2Ao1YvkM5lOkJ2MDae
	8Jejv7li0bWAZftdqmB+gOmUa4iRZi6bPLgPFjatN6DiVVhMajRF0s9oG/+PqXKCEOdtfVrvm9v
	wW7r+si56it3HAliErzflt/WfGpGXcrpFhrPb
X-Gm-Gg: AY/fxX5K1tm4fOFwYCCnpmon2NFA/5Ij7pl9GatsZCbS2CUkQ06RQ5eH4g3yFwXPgUI
	4gCf8vTfsi5l4kVe9NgNmuYl1Ug5cV/Ty/e9AZDX1ml1Zei4FomOqZbBsvUIMIRLmR1Dhn6O29d
	YaejeVTJQ+4GH2QpiV1aSydFM8YQH/PVx9nroeUEeYELCFqpCRhp8KnR+KLlmVyDNbFrtmWB6O/
	2Ev9wWU5zYJusBQtr4lOIOcZNo84zHHqDWbagEDHRg+FT4eNMjlzcHDLyceMTOfJh9kbx8fAdNN
	hj7DqWQ=
X-Google-Smtp-Source: AGHT+IHJSecnH1Seabxocmf4NJLRvS9+kRWzG+dx73qnc4Yrzmh2XLQKI/MeSxF3ycQneQRRdgfGH+h8pfJorzKATeY=
X-Received: by 2002:a05:6a20:ce49:b0:35d:8881:e6a3 with SMTP id
 adf61e73a8af0-38982a7e9d8mr526141637.10.1767652593108; Mon, 05 Jan 2026
 14:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHwyqnWwJuD4T9tuCArW5eY=rPCHKT71LroRRx-aYfDGwr8E9g@mail.gmail.com>
 <CALnO6CB7-w0tNMiYn5=SCBow637vRRrKRj_9k1h1DS4crJaVtQ@mail.gmail.com>
In-Reply-To: <CALnO6CB7-w0tNMiYn5=SCBow637vRRrKRj_9k1h1DS4crJaVtQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 5 Jan 2026 17:36:22 -0500
X-Gm-Features: AQt7F2ow6wUksFQtTWKiHmc9GMVLzCZX2j-3db9vkVs26z8CDglQP7TPNA3NeU4
Message-ID: <CALnO6CAUSU-Pq_r-WYm3o0to6H8MdqiYOuoKaRfL1PTt30VaoQ@mail.gmail.com>
Subject: Re: Triangular workflows
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 5:19=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com>=
 wrote:
>
> On Thu, Jan 1, 2026 at 2:43=E2=80=AFPM Harald Nordgren <haraldnordgren@gm=
ail.com> wrote:
> >
> > Hi Ben!
> >
> > Did you ever get to this? And does it match what I do in the tests for =
PATCH v10:
> >
> > ```
> > git config remote.pushDefault origin
> > git branch --set-upstream-to upstream/main
> > ```
> >
> >
> > Harald
>
> Yeah, that's definitely part of it for me. I've been meaning to write
> this down elsewhere for a while, but here's what my setup for
> triangular workflows looks like.
>
> First, there are typically 2 remotes (but not always!). In the
> examples, I'll use "origin" (the place I usually cloned from first,
> the most official version of the code, etc.; also the place I pull
> from) and "benknoble" (the place I push to). The setup works just fine
> with a single origin, though.
>
> Next, I globally configure
>
>     push.default =3D current
>     pull.rebase =3D true
>     branch.autoSetupRebase =3D always
>
> The first works with other settings to make the @{push} ref work (and
> to make "git push" work without arguments). I really like the @{push}
> ref, and I'm not aware of any other way to enable it.
>
> Then, when setting up a repository I configure remotes and make sure
> to configure
>
>     remote.pushDefault =3D benknoble
>
> (if there is such a remote).
>
> The next step is usually starting a branch:
>
>     git switch -c branch origin # or origin/main, or whatever
>
> With the above settings, I immediately have
> - branch@{upstream} (@{u}) -> origin/=E2=80=A6
> - branch@{push} (@{push}) -> benknoble/branch (or origin/branch,
> depending on the case)

Premature send :/

Anyway, after working for a bit, I can use "git pull" to synchronize
with upstream via rebasing (since it's WIP, I don't mind, though for
Git I have to remember to --keep-base anytime I rebase). Ditto for
"git rebase" without a fetch, or when squashing ("git rs" =3D "git
rebase --autosquash"). When I want to send out a new version, I "git
push" (or "pf", an alias for "push --force-with-lease"; additionally
I've already configured push.useForceIfIncludes =3D true); I typically
first take a range-diff as described in my other mail (alias: rdup
does "git range-diff @{upstream} @{push} @" and rdupc does "git rdup |
copy-range-diff").

The last piece of the puzzle for me are "interrogation commands": like
"git status", where am I wrt to all these branches? I use 2

- "git sbup" is my alias for "git show-branch HEAD HEAD@{upstream} HEAD@{pu=
sh}"
- "git div" is described at [1], but it draws a graph between my HEAD
and either upstream or push, depending on whether I've already pushed
out the current version (the newest version [2] is a bit smarter than
the original post describes). The graph uses cherry-mark and some
other options so I can decide how to handle divergence: do I need to
integrate someone else's changes? From which branch? How? I also use
this a lot to look between a new release candidate and a past release
at work to make sure we're not missing any patches that might have
gone in on the last release branch but not into the latest candidate.
And with repositories that commit accepted patches to the trunk, I
know I can delete my branch when "git div" shows all "=3D", even though
Git refuses without "--force" (for good and clear reasons, just a
note).

Anyway, my workflow for this all came about because I wanted to "git
pull" and "git push" (and "git rebase") without arguments and still be
able to sync from upstream while sending to another place for PR-style
review.

The only downside so far is that "git div" in git.git can show too
much information due to all the topic branch merges. Adding
--first-parent helps, but the --boundary commits still make a mess for
trying to view things. But in repositories that commit accepted
patches directly to the main branch, it works great. (If anyone has a
version of "show me the graph of divergence" that doesn't turn into a
spider web when looking at git.git, LMK. A good test case is the
recent je/doc-reset topic. I have a remote "broken-out" pointing at
gitster/git on GitHub, and "git div broken-out/je/doc-reset
origin/master" is difficult to read after the first few lines. But if
you rebase it atop the latest master, it's very easy to see what's
going on.)

[1]: https://benknoble.github.io/blog/2024/11/15/useful-utilities/#git
[2]: https://github.com/benknoble/Dotfiles/blob/master/links/bin/git-div

--=20
D. Ben Knoble
