Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0933ADB92
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382639; cv=pass; b=M7M79dvYUBTj2+pT1X2oeoi7l1hNcMkBnYDF2G5Yi8zTvKxswtX/WFBIU3pmEzBeIq8bxm8cTcOMExEZ25mJlP/FHBoY75UZVkgIdXcRQcDW2aylhgr6K6mk2nkO0djy8xa6rkosvbSjszUCff9lbNPjeW78ykUbMK262yS81R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382639; c=relaxed/simple;
	bh=U99LbzXuxAf3W2r1Jr6iMz+HiyluMCOZys07AaE7j2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEBdzoNU84PbFdGABpP26ceN0j3QDbQq2JzEoZgycAmUd7Eq1pbAkbK3ZOinLLVdWeOf02PaR7NxwlKdv6j86XASEqWDjMBYGTrjlpq5/O+fX3BFXrymP/eywPx/QELbbutnnidFaRfD3FVcC1kDdHG8sZJvLfybVgTSdEwV8Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUr9vlH8; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUr9vlH8"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6b1b1cb72d0so654866eaf.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 13:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788382632; cv=none;
        d=google.com; s=arc-20260327;
        b=gMymmYaw172QGLTyfgZ5dc21Eo3rSFDyqAXmRMqQ3kRl51luJxbQcZcE4reI/J7PzJ
         Hd6E3K7idcr2B4utRnd01lK/ZO0fEDvfO5MDx/WUsJWbJjD9EkDq/SlgJ3biSq/mHPZX
         s4rLIRiu1kBvd9fjX7V0PXrwCi1nMrWxn7CCUS95PQc+lhL0uP3DFWzXqHp1iEgUirNR
         gyVd9ki/HNI83EJS+UOg98SE5efO3bmK3sZRhPX0syVH4wBVhZ+NCRsNpjv2wQL15jp5
         0lPP/lxbqb3Y9R1cAFF1gQ9z1v2dxemtkCJJk2nhSTK9Yadsw+i5LSoImXZOxEsr8Mbm
         39Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GtaYti4egul3tmExg0w3xR/jtT6sHkKu2YHwi3jVTJo=;
        fh=EX+UwFbfhekuVLNmUkTCFZarYg2/u04pUbNCKWa10iw=;
        b=CZxaoxRoaJOipSOs+DJDeOlToHGdJy3hsBVQ1eNT5k95289ZVZPheifk6OMbTlnNV+
         O+d256GH9Yo/A64NI7PUh6oysyX/PC1ygJkUnchAW5K3Qts5/OQoGteoa/qzs1Ak2K6c
         4h6mh4b7tdIwSAGkDAClX7aJnVIwW63d21/ZCN+JnqJVXnRP9zaphPwyROgmrzKNJJjv
         qohOsAkv+0DoMEEtLD9PMBI/H9Tbld/oI9MT39uRqPZU2uryjnwXYI0OvcvvHB25P5Ir
         jlyoJ3laiXh6OmbFPAYjLkyUGG6zqQ5p+2o3pttjyPI5zAY2H7dsa9j7dRfo+hmFUcTk
         5sZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788382632; x=1788987432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GtaYti4egul3tmExg0w3xR/jtT6sHkKu2YHwi3jVTJo=;
        b=QUr9vlH8wsAE7VxdcDx7Cy3jtjV6LnLgjAS8rl26UQuLcVOUlpglfD8PWR7WY1sF60
         ynZoka1mCR+PKfxNjc2w9J3Y+RKpokWjW0yZvURhucrjfKTFvz1usuQmWrIBm7/QxpRe
         fas3KcyIDL9Mk3N4Q0pJEaBmtHg/kbg8CEpNMwEGJLC9GYvP8exMKhfAG8ut7Ro/Amt2
         p/BS1uDHW2tB8VvZXAT57W01BPqPmRKENUXbPPW8vVh0kXdQrwyv/bCv5FSUnalkAWin
         uSfC+r9k2wUgEBfZlIIgeLwDsUlCsPR+URSOrYsszX07ZOglReMzvC35npV3dNrLPkfV
         x8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788382632; x=1788987432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GtaYti4egul3tmExg0w3xR/jtT6sHkKu2YHwi3jVTJo=;
        b=deGS9G/yazeA7warYe48tKFGZ5AZ9Y/6UjeHxQWGNE29XBOu9xGCQkE8mW43PkoxZx
         iVBWdfbgb65sUrMgY8jh4Co7Wuj4VYovHP5JrS4s3gOjQp/MfKmupc5mYGGnktHaSG7+
         xm95297fT27ctx8VgOGLTgdNo2fj9ZQVRbOYzeV8xZiNfWt50i2YIqpU8Sqih0nKF6iJ
         v4nAgKwoBAaKE40q68GYUX+PK1bJG65E2pXrrMpJm79cWT1DmR0K62tmVVnC4ZkzGMNZ
         iQ2YdiafYhh6KWHtMhARGDkLFNMjaJ/rMv/EWnMPyikMkmRzPnxNRiyHzsXtErfEf8n2
         tqgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rquc4ZI8z4p1hkO4fUxmf9gf80l6gn0n2yakwc4Zq+AVQ+lXfLyMeCBIy2qVla4j8Qnjfk=@vger.kernel.org
X-Gm-Message-State: AFuF++kS4QNO/zdx5rsGbTfUk/ZS91Za6JQt1H5NTZjIEVo4G5Y5e8fq
	URY+wUR54cL5bR0KJNCpMWpW4yWVewLJMrFc801H0/8wxKGROcGNZgFRthQjYQ1mo1b6OI6jI82
	MWtGAAM5taqfoeJdpM5Wsa5r94qebIrjdN/z9
X-Gm-Gg: AR+sD11f/KR5iTJAMkDXCeDcGLp+8GOmqibIiPXrH2ZbXh7t9Eu9s+5cgU+DJgvU6zJ
	VrG/ResbrB4r2mCtd3GGGS+bJrdzvh16iJ+aCLjrUP5QhQBMKoE1siw4xTojFC4HgL+wBhxrhxA
	YPqn7cxgRbL7Cb2zKTJXS7vMmw9ZWkPp16KX3+/x7Wznf5lRmc/JYmcxcoVmK7+nAgJcjTYplKB
	/ts4nLp4fXfliAw9vzkrr28HOhpgRC9NWhI/GDMPVjj1A3jf7bekdXxnV19PYQZyZUCqvZ+e0n9
	HFFn0NbyrsZ7nh0nxoaavAtmsl3dFoSl8PPOwadYkc0NAmtyJf8Zrs24xWjO+DU5RWXYaEoyQmg
	r0v+qPsmp/BhpY2+oyt5lXd0DiTbbYVxbGCIUTSiRaFE80ETnfKh4SER7DZGJ5Q==
X-Received: by 2002:a05:6820:16a9:b0:6b3:c8d6:947a with SMTP id
 006d021491bc7-6b480230dd1mr5357228eaf.31.1788382632327; Wed, 02 Sep 2026
 13:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
 <aohP7GMx9oX3ZCsQ@pks.im> <CABPp-BHJj-b=ieva3-=zaCAyvn5UtNQqNT0Q76YCpqZAjO-8VQ@mail.gmail.com>
 <aovW5bxu1F8jYKYl@pks.im> <CABPp-BHwa7QM=XDuO=9xqm-OL8dn8uGf1=rv+sgBRQ9hHKMFuQ@mail.gmail.com>
 <1d6a4047-fa41-45cc-8097-88680e8ea67d@gmail.com>
In-Reply-To: <1d6a4047-fa41-45cc-8097-88680e8ea67d@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 2 Sep 2026 13:57:00 -0700
X-Gm-Features: AcwNN1Xq2lU8sggSxgMlJ78Fy-jL_waTlKjrHQzeji3B2g17aYoFyULAyDr2now
Message-ID: <CABPp-BFekYtzXo7BscEw=6CvPve-shA5ZvXkQaj-jcALE7Sx+w@mail.gmail.com>
Subject: Re: [PATCH] send-pack: avoid sending the whole tree when pushing from
 a shallow clone
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 12:05=E2=80=AFPM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> Sorry that I missed this portion of the discussion talking about
> push.negotiate. Coming back to correct that.
>
> On 8/25/2026 1:00 AM, Elijah Newren wrote:
> > On Sun, Aug 23, 2026 at 10:30=E2=80=AFPM Patrick Steinhardt <ps@pks.im>=
 wrote:
> >>
> > [...]
> >> TIL, thanks. I don't think I was even aware of "push.negotiate", and I
> >> mostly went by the folklore of "just clone with --depth=3D2" that I sa=
w
> >> repeated on many sites.
> >>
> >> But this and all of your other answers make me lean strongly into the
> >> direction that the fix is at the wrong level, and the proper fix reall=
y
> >> is to enable "push.negotiate" by default.
> >
> > I don't think that fixes the problem, though:
>
> You are right that the following cases are somewhat common.
>
> >   a) Users can do a shallow clone of a specific branch for a specific
> > pull-request/merge-request.  Then the pull-request/merge-request is
> > rebased, and sensitive data removed due to a leaked secret.  The
> > shallow graft is no longer common.  Pushing from the shallow clone
> > should fail, but it shouldn't have to send several gigabytes of data
> > in order to get the failure message.
> >   b) (Very similar to a) Users can do a shallow clone of one repo (a
> > local repository cache?) and then push to another; the shallow graft
> > thus may not be common.  An error is expected, but sending gigabytes
> > of data to get the error isn't.

I personally think (d) which you snipped out, namely
push.negotiate=3Dtrue doesn't work for some users/servers, may be more
common.  I know you, Patrick, and I were all hoping that
push.negotiate=3Dtrue would be a panacea for the common case, but the
conditions behind (d) that prevent that option from working for some
users would seem to be more common to me than these two conditions.

Further, my previous list for (d) was incomplete...

push.negotiate=3Dtrue can fail in another case both under http and ssh:
  - repack replaces packfiles on the server with a new packfile.
  - The client points to the shallow-graft as something it has.
  - The server looks up that commit ID with QUICK, losing the race
with repacking, and reports it doesn't have it.
  - The client doesn't have any more history further back so it can't
find any more shared history.
  - Under current versions of git, the client believes it has to send
_everything_ it has.

In the concurrent-repack discussion, upload-pack's QUICK "have" check
was deemed working-as-intended, on the grounds that a dropped "have"
just means "the client is sent more than it needs." For a shallow
clone that "bit more" is the whole history the client has, which is
exactly the problem this patch fixes.  I'm not trying to reopen that
other discussion, and I admit this race is rare, but when it triggers,
it'll defeat push.negotiate=3Dtrue.  I think we need a backstop.  (And
even if we do revisit that QUICK race, there's still the other
conditions in my previous email under which push.negotiate=3Dtrue
fails.)

[1] https://lore.kernel.org/git/20260827055743.GB189659@coredump.intra.peff=
.net/

> For this case (b) I can think of it as doing a shallow clone of a
> base repo (https://github.com/git/git) and then needing to push to
> a user-owned fork (https://github.com/derrickstolee/git) and the
> fork not advertising reachability to the shallow commit.

Yep, that's probably a better way to put it.

> I think the difficulties here is that your approach is assuming
> something about how "non-advertised" objects may exist due to either
>
>  a) delayed garbage collection, or
>  b) shared object databases across a fork network.
>
> I don't think these are reasonable assumptions to have by default,
> so we need to be really clear about the reason to use this setting.

I don't follow.

A shallow push already assumes something about how "non-advertised"
objects may exist -- it assumes the *parents* of the shallow graft
exist on the server.  Why is it such a big leap to move from assuming
the server has the parents of the shallow graft to assuming it has the
shallow graft itself?  Further, what are the consequences of assuming
or not assuming the shallow graft exists?

Here's the matrix:

Assume the shallow graft exists:
  (A) and it does -> push succeeds, and does so orders of magnitude
faster in large repos
  (B) but it doesn't, nor does its parents -> push fails with error
message we would have gotten anyway, and does so dramatically faster
  (C) but it doesn't, but its parents (magically) do -> sends an error
message quickly, where the push would have (eventually) previously
succeeded

Assume the shallow graft doesn't exist:
  (D) but it does -> push succeeds, AFTER pushing hundreds of
megabytes of almost certainly unnecessary data
  (E) and it doesn't, nor does its parents -> get back an error
message, AFTER pushing hundreds of megabytes of unnecessary data
  (F) and it doesn't, but its parents (magically) do -> push succeeds,
AFTER pushing hundreds of megabytes of mostly unnecessary data since
we can't determine which parts are necessary

Clearly, (A) and (B) are vastly superior to (D) and (E).  The only
case in question then is (C) vs (F).  My opinions there:

(1) We already generally require folks to push from shallow clones
back to repositories that have the parents of the shallow graft and
extending that requirement to the shallow graft itself does not seem
unreasonable to me.  I would much rather be told I'm pushing to the
wrong remote than wait forever.
(2) case C/F is incredibly unlikely (people tend to push back to the
same server, and even if they don't, the server likely either has the
shallow graft and its history or is missing the parents of the graft
as well).

> As your test demonstrates, some amount of "our assumption was wrong"
> is built in, so we should have a way for users to respond quickly
> or automatically (retry without the setting?).
>
> The multi-push case that I brought up is tricky, though. It may
> be very narrow, and HTTP servers would be protected, but we should
> avoid allowing corruption over file:// protocol.

Ah!  I see where the disconnect may have been.  Yeah, corruption needs
to be prevented, and if corruption was a risk then it'd override other
concerns.  But that isn't relevant here: receive-pack checks for
connectivity (regardless of protocol -- http, ssh, or file) and fails
the push if objects are missing.  (See commit 52fed6e1ce07
(receive-pack: check connectivity before concluding "git push",
2011-09-02)).  The multi-push case then ends up being a case of us
failing more refs than necessary, not a way to induce corruption.


Also, I didn't state this earlier, but this bug can actually be more
comical.  If someone clones with e.g. `git clone --depth ${N}
--filter=3Dblob:none --sparse ...`, then after making their changes and
deciding to push and the server no longer has references to one of the
commits in our shallow clone:
  (i) Push notes that it knows no objects the server has -> it needs
to send ALL trees and blobs from the shallow graft
  (ii) It doesn't have ALL blobs from the shallow graft -> promisor
remote handling kicks in
  (iii) promisor remote downloads ALL blobs from the shallow graft
from our origin
  (iv) push can now push all objects to our origin

Above, you'll note that although the user started with a tiny clone,
step (iii) downloads huge amounts of data from origin so that step
(iv) can upload that "necessary" data back to the server it just
downloaded it from.  My patch avoids both the unnecessary huge
download and upload.
