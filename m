Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792712940;
	b=UIzZkHQbUdGYIAgMfn7wQP2L8bVT1m/KmclB7yNNN5XrcjKjhwN2f/xC+Qxoxo5hnsju
	 deh7nGy9XT0cOvnVnEkKKn7vq/zuljQoggR/WKkeSBGC8EI90Ztzc+JjOvt+JGGQ2awOK
	 s2YucF2PN5LT0oSzXzeCw3kmHXM45fdWZtM8pQjgnm7vA+HmHYgUd4mZAqpQDHO5dguv4
	 eey9w5ClgO+wpMhLK+nZUqykNZBt8FlzWrbCKDSqE8ikwbmruHlMbrsMAlKW3uePIGehl
	 P8OKHu0NJOCMcfyMhNw5HX23m+dVSiD0ht3QoGP7ssZMzxstNIi0x9/PSbO/GPLBZvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=F2LFGtcj0Qv2gG3BUobjzduxHvx50BjG7EiB4rltHn8=;
	b=voYyWIJXwNoM/Cwslpb6CRP0PGJYYFTiF3fuUXWRn/gQqhySN4AhzPwazFwmO+zuzYq5
	 ZMHxHxHU6h5m0FFzdpRO3nTCTcKVKEV1zNS0ovl1ado8Q55Y1nEhJiaVskyc9Fs6yzFIr
	 /UeYsZd2gaXYgzabIAHGO7ZOkIcVQlgfDo0uaeSu4vSo2AJP9hZT1vpmOKRBDugVw+SLu
	 C4tHI4LlCiprnvHErPSx/+avEet2OqJClZ96+ueRTrPthG/7j2DmTs+oHyJx+JHe8riEt
	 G0FrBUkYfg03xkMX7ass3SXSym7PtLE88+Ld+YY5vg0bBQHkLYB1I5m23L0yoNngp8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ieIod69J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66AC606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 23:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A66AC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ieIod69J
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-535850d4e6aso226751cf.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 16:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792712938; cv=none;
        d=google.com; s=arc-20260327;
        b=rXhW9QK0mzmh1wWX3WPyW0MjFr4NkN9LFFd4xiDxVHJt/hw9drVPEtcDXNzYcU9cTR
         aVdifaVUgffll8Z1Sf0xkj/DLS3+Wkpzi8hdu10FE54Iy5TR3O2Hx8WeC+jozC9peCV2
         D+mHkoIcjCTjcTjheF/t7u7Gtyq9ZASIe6cEHAbmt1HyngixPbrqYPKwX5najAz9ORks
         uPojb+PE+JNjZtTVduMldyYpSB7jVz/t95j27WyFw0w9r/zQKy9jZaqFT4cydoccnLcF
         JraYeQSdjLjNNpXmGCm8tvw94Xx9qeK6XyOWwk4PPoYBJYcg1FdiH0NeKVf6LzNVuO2n
         d4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F2LFGtcj0Qv2gG3BUobjzduxHvx50BjG7EiB4rltHn8=;
        fh=o5l0Eu0aYVhYLNaknXG9Bd9QW+Oip/V1pdMxWtUugbA=;
        b=c3ZBLx/q5CHewO50w7KA/kUcEWwFG+sbtb5z6wQgDfSrsX77TMpuG+lJoO8O1XKfNq
         Rl8NQ9CIMIWnVUZ3HApVtvvdjeyr7Iq3KcFiKg/NL72xCANNC3gqaGpPnp9VxFtcJHv3
         8GNC+a53nEtcg5ILo8QPr7C7UoAANfM3dZ+vhh7l4cMyHj5+2CwGvxNcwSE7JFkQB/cH
         StVQxHMd3qWIHBUoGA4UvNQOw+5La2pk5R6rE8EWbXxO9Q0y5vr2MQraNLeMX1ErCpAG
         JV0/drmg8Qgb7UvUCRzVfh60fvEPjk8F4hROjsGqDS3YueMS4MAomRg4YtYt9/Z0vrUA
         BzFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792712938; x=1793317738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F2LFGtcj0Qv2gG3BUobjzduxHvx50BjG7EiB4rltHn8=;
        b=ieIod69JivIdxtInylpNQgC3alQ1olokocsS31PXAMdwuLHd3+yRgYLk93QWdYnKZU
         uI+LZ/R7r3jDZMuBPtsR/5DQLyheHkOaRzzceDUy3LaSp2+cxG+WoyhLN47+ietQIMgE
         yMCb4mV1Wd/04sI5yml+UoffDcItcKcL2M23iS5jHkJoutW2s+GXRjG+HLA5skL8LDyp
         FCa+zpRqOduR+pzZim35Mu/j1FAYbm+VCBzLJeWlQ/Egkx19qih11/Otp1EUAeSrtJK4
         Xp0pAeWdVlyVvUeMLTC6NZRjck3wbDSQWIA95a8h6/hcsvkQ7+fyKycBLDYIgg86zVFT
         3k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792712938; x=1793317738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F2LFGtcj0Qv2gG3BUobjzduxHvx50BjG7EiB4rltHn8=;
        b=AzhPBef9TBJ0BjTZWJzEtrs1ZvQL1LOoRJWA8rR5SyC7vx8ygSPpJzr7ck0Ut0a6EN
         roT/iwJbGXYSe4MySZWHPK4dFpESs+oH+Q1uJdyJdZ7UNi59yDLZWAooU24PMLw64xZW
         RyAHEqKzDbD2ZF6mZMGPjcBPOfrPtHjAPfktflzULnpY3c1nXigJ5F5bXTI36nstQI9C
         XvA7iPdZctZeinryWhIA0F8/b/wH3Klp2R82wdRLRvi+Vh9vHm2FIlV5+Wwtjd4faK8J
         65dSXAN9YF7DDHemaBlsaqPbNmPrnlLz/0jIhGXv9NLcBjfPaXqz9kEbq/O6Qb8ftLof
         zUKQ==
X-Gm-Message-State: AFq9FYLL6y/bSuJDQWPkYay9xVwJUNVR1HVNHsk/ZYegVRe4jXGMhzUT
	YWCKLUqQxsaOjjqiRf30ow5rCyzdnVaKCnuu7jOJbeJfzkpOBP7HIBj6J8zlmBMKU7QXjAAKjdQ
	rhyfdse6qnwBpCVUCy7b1iWqc/Ynh70NkUQKSPgE=
X-Gm-Gg: AYBFou05AQBMeSLTP/25ZxVM5CumrgOWBPTtO3jpCPMI2lSKjvDsT0g0FhLj6z5pdZq
	pgR3YczhZCHT7iKD+Xo87BYtbg2aW+Bfu3G52qTF1yO4DaTOo/BZLAnpa8N4ZEd5guA2zgFuztH
	Iv7JeEG9IcRheu+qNTDMVVinwR8Yn9D3S7oO82ZtGN9rR41rNEUpXL7i2qmqpJDpE4GwIZYwSt6
	R5SRKJkgUr6EkIURta0je0uG6+4MK5yokEL9uKL6Y9M5g2qjO3w5rviKyQsS00hbC+0nOKXSiyZ
	QNOXGl0tZcg0k1V3nscBn6fsSrRHagubO4NgMg4HtFw8+KNxYU/M+4QqIv6RqKxTAbhuyoKuFr8
	iYd4rRnI5h2nCza3ZCDTsv1FKPzP5jepPaVQ=
X-Received: by 2002:ae9:e507:0:b0:93f:211f:7ba4 with SMTP id
 af79cd13be357-93f6fa10fabmr155261885a.5.1792712938478; Thu, 22 Oct 2026
 16:48:58 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAP8tz2JPXzq=Skokn4OtH8t6c3b+p1Wny1iX6AhXReUGvsBhuw@mail.gmail.com>
 <CALnO6CCFfd3VcZkFGmc6kYHqEwsafa7UbOg-6cN0jEfsipQm5Q@mail.gmail.com>
 <CAP8tz2+CQcQyTdj3YFpEaiVh=hVoK5Xo8WFxGZNMJoCCM-u=hQ@mail.gmail.com> <CALnO6CB=tmTrNKcWOanb79Bm9gPT5H_dntNGRJGp6iEYHe_aBg@mail.gmail.com>
In-Reply-To: <CALnO6CB=tmTrNKcWOanb79Bm9gPT5H_dntNGRJGp6iEYHe_aBg@mail.gmail.com>
From: =?UTF-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Date: Fri, 23 Oct 2026 08:48:47 +0900
X-Gm-Features: AclHuK-fNSjBbMMOIEbCPAj1rlVn05cLmSuj7n7ygpoH1oKgpNIdo41menG5ang
Message-ID: <CAP8tz2+cJ4E+Nv_dHuY-8-DoGj7_nP1=98Nn5+M3qMb5WezYVw@mail.gmail.com>
Subject: Re: switch/checkout stops halfway when it fails to write tracking config
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I wonder if it's a royal pain to make that step and the index step come
> later in the sequence? But that is more of a band-aid than a proper
> atomicity fix.

I checked this against the code and tried two cases. I used a build of the
series (2.56.0.217.gfcc73a773a, master plus the series at
https://lore.kernel.org/git/pull.2275.git.1792637495.gitgitgadget@gmail.com=
/).

Why the worktree update comes first: switch_branches() calls
merge_working_tree() before update_refs_for_switch(). If
merge_working_tree() fails, the function returns before the ref is created
or HEAD is updated.

Case A: a local change to f conflicts with the switch, and I ran
"git switch -c y origin/main". It fails with "Your local changes to the
following files would be overwritten by checkout", exit 1. HEAD stays on
main, the local change is kept, no ref y is created, and branch.y.remote
is not set. Nothing is left behind.

If the ref and the tracking config were written first, this failure would
leave a new branch and its config behind. Moving the worktree update later
would move that cleanup into this case, so I agree that moving the step is
a band-aid rather than atomicity.

Some failures can still happen after the worktree update:

Case B: with .git/refs/heads/y.lock present, "git switch -c y origin/main"
fails with "fatal: cannot lock ref 'refs/heads/y'", exit 128. HEAD stays on
main, and the switch's change to f stays staged. This is the same kind of
halfway state. Updating HEAD can also fail: checkout.c:1027-1028 calls
die(_("unable to update HEAD")).

The tracking-config failure is handled by the series linked above: the
switch finishes and exits 0. Full atomicity, which would also undo the
worktree and the ref when a later step fails, is left for a separate topic.

2026=E5=B9=B410=E6=9C=8822=E6=97=A5(=E6=9C=A8) 21:48 D. Ben Knoble <ben.kno=
ble@gmail.com>:
>
> On Tue, Oct 20, 2026 at 11:09=E2=80=AFAM =E4=BA=95=E4=B8=8A=E5=8F=B8 <ino=
ue.tsukasa.4@gmail.com> wrote:
> >
> > > I can see where create_branch() is called prior to setting up HEAD,
> > > but I'm mildly confused about the index/wt updates prior to either! I=
t
> > > seems to me that should be one of the last steps, hm. Unfortunately,
> > > I'm having a hard time finding the responsible code outside of the
> > > "merge" case (which probably has a similar issue).
> >
> >
> > - merge_working_tree() updates the worktree and the index. It is called
> >   from switch_branches() on every branch switch, not only with -m,
> >   because do_merge starts at 1.
>
> Ah, thanks, I think that's what I overlooked. I wonder if it's a royal
> pain to make that step and the index step come later in the sequence?
> But that is more of a band-aid than a proper atomicity fix.
>
> > - The "merge" here is not -m. It is the 2-way merge in unpack_trees().
> >   -m only adds an autostash step for when that 2-way merge fails.
> > - The order is: update the worktree, create the ref, write the tracking
> >   config (which fails), then update HEAD. As you noticed, the worktree
> >   and index are updated before the ref and HEAD, so a failure later
> >   leaves those changes in place.
> > - As you guessed, the -m case has the same problem. I tried
> >   "git switch -m -c y origin/main" with the lock present (v2.56.0 plus
> >   my hint patch, which only changes the hint text). It stops in the sam=
e
> >   place. If local changes conflict, HEAD stays on main, the file is lef=
t
> >   conflicted, and the changes remain in the stash.
> > - Running the same command again in that conflicted state stops with
> >   "a branch named 'y' already exists". Switching to the existing branch
> >   y stops with "you need to resolve your current index first"
> >   (checkout.c:887 in v2.56.0). Neither run changes the state.
>
> [trimmed repeated quoted content]
>
> --
> D. Ben Knoble
