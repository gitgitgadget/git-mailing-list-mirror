Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC5B672
	for <git@vger.kernel.org>; Sat,  2 May 2026 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777709234; cv=pass; b=rslF/6ocnUOti0wl9IugE3J9R6PYNZzZpOxQaJ5l5YgdYySpFEphF4QIZFECpTCjNkBvGSjvgC9wo0RqFFpCGfoyDkycf8GwOjScN1vdsqWc97yTwUr1u1uXsNT6cmQEJ3Ol7MUCnG3jqOQioPJj8NokNRbmmVKb16mELie7MdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777709234; c=relaxed/simple;
	bh=j7LZYlpX+K/JUs60jb82ReWdDYir5zHQqyvHu2D0ifc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhrbd/D8JVk1E1ntP8c9dQCq4OhAAt+AmAm8mToUjymDCflzzOKXesJY3kfmIsn+tDxaahkAEKGmTD+dflyPe9WEp4RDZE5S5gFL3b+nYlFlVX7u9RtDu7ZL9r4cbFWEE9lOFyUNIt3eaWuO/MWP7KPvcmakHHUtSGYDAghjaLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBuXSSdw; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBuXSSdw"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a3cee3a271so2575893e87.3
        for <git@vger.kernel.org>; Sat, 02 May 2026 01:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777709231; cv=none;
        d=google.com; s=arc-20240605;
        b=VfTQihi5DT1CrE0Evt1IUDe2oqyB2g9QI1AwZW1etnH4EBJwOrtCRb3WB8IbA3nHFb
         ToEeyltu1kyUKgUzKWljA5FWY60X6IZORIzPm2AGrug5U2AsoIAVglmeo+QLpSOfTEvW
         0kbQ3rP8cgWEaVO4bXRLm2pSHRDCGVBs94j6NG4pLtl3dBo8TNIFDu2uZLyHOZa+aQiK
         4DO8faMLFYL6UYoWiboZFupu2usGUgUR2N7pydiE6/tOWpwDhPNrgWaBhQx+eb2Xwioy
         drVmUCz31ptYFtRhzQy+AuvExTIFl7xINoBVa4vXq9PRftQm2M0O2hhPu3r3B30FTbv4
         OYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j7LZYlpX+K/JUs60jb82ReWdDYir5zHQqyvHu2D0ifc=;
        fh=pj8FQu6OcHGsLgPiPTsQfIjck4Pmv8ApJiqw60wYFVk=;
        b=hWJSlLTOD0YNJ5/ckMe2JXbYt9GB1U9mycNkebthEOl1Xj17T4o6d3i1pEPWhC2xX2
         CZCv5zCfMdhZD1yRDn1In57z6DjvQuOQOMs/qAoPTtNiaTD8VetWR9fG/sBgaa1xF3nd
         zF47qS2lQHF0fzqCzIb/ipS09SOCoGdB9nqJ0uBd1zr0hwp/HWj4e1xGmfRP6NY64DVJ
         YktQrt1c9Fzcto5uFv299TCyuHS90ss4ZwYO4PBfpd7bNd9WtyfSXV8BOrOoWjhbwXDr
         Ytv6kwUj2CLk9nquR3Ga/OVXBYMEiNth5npB89UEkjJiVNhtHve3sH93dVfMnscBuUzh
         Q+Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777709231; x=1778314031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7LZYlpX+K/JUs60jb82ReWdDYir5zHQqyvHu2D0ifc=;
        b=SBuXSSdwWkSEt++997eeJoOrbF3ET7j7Tbt9+UJI6RW0BijIOmszyc6ByAEO93p9g2
         riSRL2PRhm13u/dTz6Kyz0YjRhKXZVGqGBdzREGfXobvzQ5jqFzmb73JF/SW94MtUjYX
         hOoQ6xJCwljyjnAOIjd1E/LdFkaKwxcVPdYvwF7q4QwK1HoFWRvSAwMNlmOopiD7OrOF
         wlYQiouW+UfodOR2prkUZ8zJfzjjs0OtnSHdcFcYcTjumExWFZEyW5fAj8wCxWslfm/P
         BgDcPIhmI8cN+S65Xjkvu7a2qFqAgNIAbU3xiZgo6d6Wq15JtjuqtM9q7n3GRnPvVcho
         8hsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777709231; x=1778314031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j7LZYlpX+K/JUs60jb82ReWdDYir5zHQqyvHu2D0ifc=;
        b=UKIl/sW+gFsqtzoVZSKSlewGP6qELpk5KBDbhpNaw+f2KZ4pXQWiOpIPEldoZIn4y9
         oKgf+PfoIKoaOiAglswyrGE0OVodG/4fbRtIozesVs3NFVTR06dLlDRzL2u0iTa3ecVj
         uSWIfLjixR5mVopsQwC+UWgciwYyx5xNZi8TwgWFSDa40BJc4HRH+yf8mO/xO/Yra6n4
         4g/pFXaD+neUhD9+afCDwLDFxXs/Ceqsiag6I25ZqSJNLAzR3ZUc+TjCC7qRjnCs7xID
         z1/IBJYwUy8uljTsuiyiCwqo+VLT49DTw0R3CYyBGMHe7FbUBsVvlhMdCJG+ffvlCGjq
         cP2A==
X-Gm-Message-State: AOJu0YyRQBoxxB7GFH15CzQDABCrtrS/ZQGCGzZhyi1phXIkWFzgLTE/
	JNulPFdeTSxxdghRseX/fGjpJCcDRuo6tYQzkfVBrwiCeuqOE6hmqEys42E/Zj/2clCk5K3HhgD
	igwNtQBMLHE/2uuqbEQWAGXGNneX87YUS+iVgTxE=
X-Gm-Gg: AeBDieukYN5932gw4qU3qkftTPKxMX4UpxDHukHVA9vdT2YnKrQwlcH92khE2Z7ydyj
	ZUfS1iTFR6Z172ixA29B0tJFDB38V12tgUOU3ndH1DomPGXKG+x8NTvOlfB9fxNZ+5bugEScS8c
	FzwHOwCzZmA/g9Cdgj5VL9pUMPImGywmz7GMqpohVrSjeVZY34UghE06KGuvCds2qlC18Pp28eW
	s+P+v5zBz4Rjp1YA36wricWKMjNZxRgEQpcHqm+romGRXaH7rL857ALG8oBvFIEd3WtVSMaNCpF
	EruOxIXple1OTj3D7CBq0DdvKXPeKg==
X-Received: by 2002:a05:6512:3e04:b0:5a3:d032:6554 with SMTP id
 2adb3069b0e04-5a862ec3443mr570535e87.12.1777709230368; Sat, 02 May 2026
 01:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OsOzcjEwvHCQSghLE8LD_wHb_jDlil9I88OUuhpiRONnVd1o9p3gStbK1mx4q7OwY3ePtbZO-BBgTNOCeJ2DMyvBsdlMhRmDrTP894KP5xo=@proton.me>
In-Reply-To: <OsOzcjEwvHCQSghLE8LD_wHb_jDlil9I88OUuhpiRONnVd1o9p3gStbK1mx4q7OwY3ePtbZO-BBgTNOCeJ2DMyvBsdlMhRmDrTP894KP5xo=@proton.me>
From: Chris Torek <chris.torek@gmail.com>
Date: Sat, 2 May 2026 01:06:58 -0700
X-Gm-Features: AVHnY4IP3UVXP5pHvD1emosEvGI62Tp3u-bixVkT6EB6i3VLx0z3G5GJVHdG4lw
Message-ID: <CAPx1Gvd_VEWHrBWtUjNeWZ+wfmsAOTamKmL6fhBSQi=MbmXRcw@mail.gmail.com>
Subject: Re: git rename/moved status unreliable in ruby
To: "sebastien.stettler" <sebastien.stettler@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 10:06=E2=80=AFPM sebastien.stettler
<sebastien.stettler@proton.me> wrote:
> ... understanding the reasoning would be great

In my opinion, the key to understanding here is this:

Git Stores Snapshots.

What this means is that every commit is a full snapshot of all of the
files for that commit. There are no "changes" at all, there is only a
full snapshot, every time.

Now, internally, the storage format is more complicated (and
compressive, ultimately using the concept of changes as well, though
not exactly the way one might expect). But from the "what things look
like" point of view, and how you should think about what Git sees,
each commit is simply a full and complete snapshot of every file. So
if you have one commit where `foo.rb` exists, and `bar.br` does not,
that snapshot has a `foo.rb` but no `bar.rb`. If you make a second
snapshot, in which `foo.rb` no longer exists but `bar.rb` does now,
that second snapshot, well, has those files.

The tricky part is that you normally ask Git to *compare* two
snapshots (at least for "what changed" purposes). When you do that,
Git extracts both snapshots and, well, compares them. If `foo.rb` has
been removed and `bar.rb` has been added, Git then goes on to compare
the *contents* of those two files.

If the contents match exactly, and you've asked Git to "find renames",
Git will always say that the file that vanished from the first commit,
only to be created identically under a new name in the second, was
"renamed", rather than the one file being deleted and the second
added.

If the contents match "fuzzily" (for some value and algorithm of
fuzz-factor), Git may also say "renamed". You can control this with
`--find-renames=3D<value>`. The key idea here is that Git is *finding*
renames: either exact-same-contents, or "sufficiently similar"
contents, based on remove-and-add pairs.

Since Git only *stores* snapshots, you can get two different results
from comparing the same two commits. All you have to do to get this is
to adjust whether Git checks for renames at all, and if so, to what
extent.

These rules apply to `git show`, `git diff`, `git merge`, and even the
diffstat that `git commit` optionally shows after a commit. For this
reason, all the "compare some commits" commands -- including `git
merge` -- take this `--find-renames=3D<value>` option. Detection of
renames can be countermanded entirely with `--no-renames`.

This is why -- and when -- making two separate commits, one with
"exact same content for deleted-file-D vs added-file-A", followed by
later changes to new file A, helps: if you compare the commit that has
file D to the middle commit, the two files match exactly, and any
rename detection you have turned on finds that rename. If you then
compare the middle commit to the final commit, file A exists in both,
so Git shows changes to file A. But as soon as you compare the
original file-D-containing commit to the final file-A-updated commit,
you run into the original issue again: to detect this as a rename, you
may need to allow rather generous rename detection.

If, in the future, Git gets fancier rename detection, comparing the
original commit directly against the final one could find the rename
automatically. So:

> If this is considered something that can be improved ...

It *could* be improved. Doing so in a way that works for more than
just some special cases -- e.g., in a way that works for ordinary
text, or graphical images, for instance, rather than just for Ruby
sources (or just C sources, or C++, or Swift, or Python, or whatever)
-- seems particularly tricky. Some degree of ignoring white-space
changes would probably help multiple cases, though.

Chris
