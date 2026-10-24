Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792847674;
	b=yzBwmO8OOEOQ9+ZdvpOKIPqrwJvA2ky/EOdZK7qdGOMqx70mskeEbTwmSVbL2unjlSlF
	 2RlK9lAt92LdAjRN4Is8OSl+frQ0XyJi/warrUq/MW5MABQ2pXoA7def7NjgKEWaEYkLz
	 bIk5jj6JP3uYQRGcI4EuIrPigZh0feRcZkHhBsC73S2+iu5mAX2AkEQnRq7fwOsy0qbdp
	 QoQNv5SUNI0+hANYyqfMxkUUTu7AH9QZAL5qIWBvQpwSaIItprZz8V331lqbApS5ZSSTq
	 arASeDCB117VFG8HnmkSdWwS4Qwc7ckBawLf/jXeW/NDGFXlR//EOPfCJzLhLBuIZKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792847674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J6n2LZoZ4jPa5oCujNkvGP2tFpnGafCWTHjkJ/lmQ5c=;
	b=A0f/Ty9SpwI9883g1pizBmlShoTBbAzt2OgxXeWhdXo3R0Qp+dR30owkzVPb3M0OEuze
	 SRLMtGo8BlrOBxEugsUVa14XSZqX84B8vq4YsFQAZGnpPuJZaJe5wdNtPRmYpXZQLhqyp
	 il+8q9sLUrqzAzJKiyWq5qssUD04sW9+Jfjk2bN0KPGtcW1N5AnnrqmK+nwXXjTLbN+My
	 kdzftEkYzIZ73GOHeiGaTSvqZr6k0o18xEuEfMDWAWsAf0XJiX756NOLd4YbiTxEdhXDh
	 BJPGzQUOTK9T10q+djoC7oZj3uRjeFm17hbLLXO55WjpvD9wuXDk7TY0vTat2r7Ms3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Glm4jcVa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6BF606A328
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 13:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6BF606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Glm4jcVa
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9f6a16aedso10863645ad.2
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 06:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792847674; cv=none;
        d=google.com; s=arc-20260327;
        b=L+e3czgxAEt0jHBshetgXee0QybgiDkIk4yzPsBDIgek01CeyaYZYdgDmhPBvLyYAt
         dgM5bwObH86uhKsRKro8vHRTgpQUAKmh8FlNWFj178SA6r0+dOJp4XpybD7ssmWdzCnc
         FPixOPZ5a35TeXt6uCGtp7UJBjScwkve7+V5brVsAdzW2h3a/qg+ybC+ZOqRLOZ0CE0G
         XuPH+NyrXNiaQOhHu5Pv8xNzmOscwy8fgs4tik9l017pfWEgDmByAMeVoO0qeNYVVsjw
         pnkpamDEcmAg4gtkRyLRu7agoeLYzR1h1RGvq4051c4vXmMlQv7hqkqi5lQEl9wiCS4B
         dAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J6n2LZoZ4jPa5oCujNkvGP2tFpnGafCWTHjkJ/lmQ5c=;
        fh=jWbg78oYWuv9P20kCidMJL0drbkR2iYzmHqtdZIZ8Ls=;
        b=OYg5rmkaGjnG+WmA2I/3ZEmqVXlarwMsonUkciXY5yqWkhweFiB9WMjEA8gkAVPt9d
         TikeieUVVorwbW7lR/VODMeECcE7sXMt1B6vTTbGkssDxRBFDih7mJcZuAjBUfbzOjy1
         Q6CoCQdzvDE+fONn6L/mMI3GV9l7bQBLPj2E4wMFd3i4hzXfz+sGLHfnT5qmPTfAljsJ
         47UWOAWqFPyYEFkDKlANB9/juopXFCY97PfAuzgnqx8G9M0SBF8PXg8/5KeIOGJ7fifz
         c5Uwd81Zl+L0ZPi0r+HvCvlISwfTJ7Hj0Ze/AWzGy/EdWJQrarNKZ9pdUtVEpT3inzRw
         iksg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792847674; x=1793452474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J6n2LZoZ4jPa5oCujNkvGP2tFpnGafCWTHjkJ/lmQ5c=;
        b=Glm4jcVazJn3lJ8AClaQu1iagzTb2FL3C1MwLUKQDm8d48RHOvFhPQSqQ84ehMm1Vr
         vwg5DiIlTHl99EOktIeBA34rbgNgnec9DXUbsiCbFed7B/iTMiJ/Pq2KX8ROB55J59h5
         /V12/g4+xwRdZEwI1OdPge/y6RMWZxTQorySFcStDiqCPvWmJlR/A2JXEcXr8W9sWZlT
         WXYnFQtyscYCev42ZR0hIXdM+hcgFNWH7AxtN1UztCYzwuvx1Uq+UjGWDznuXg5+JKFo
         2cX2aKauphiwhtM7UNRcu5FI1y4qhgIVMWHatP/V/mj4YaBogMBOyaWKmhUsSZ4AWb6I
         VteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792847674; x=1793452474;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J6n2LZoZ4jPa5oCujNkvGP2tFpnGafCWTHjkJ/lmQ5c=;
        b=KokZ9W2LOVFSH2GMA9j0RBoBRhvnG4oAvBcyhiwq2Ik4IFS+r87I+YjbcNxH/Xhiy2
         5t51uQba+gMO80ocUpSnWCAVmhLMGt+JSAUVOY5pTR8B2w8LiD7VCjfpZ9ATrqQCYKkN
         eaIoLUveb8bXAwIklIiMh6Ju+2DDgmn0V/+ir7izl+8YH3/T4DsBsjMIodT6GVY5+2nl
         /f2KOE0MCT1cbNLoIsohHSMbtKjGCvbXYD0SRzRrDriPDRtz7xYJnrIrKrdIi111x26J
         oiaFGYvVlilzM1rpbC6uLhEjFw0BSM7LmzNncZECb4bEb4xz7RPVqmO25gbzKGOFltX2
         kwYg==
X-Forwarded-Encrypted: i=1; AKwUvBzJzVnxNhTZqacI2Bberr0eLB4moloKo9USJt+tGY/C35IipFpSfViDefIxHxqST1Ai8dY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLupPRgAlpO2BI/NB3vZ8lFgX1f+zbFXFBOVWzFvMxXeNqe1AAo
	3z8KPtO1czo4WKKxYNcKl0kf9a+Kb1pjduIOwCfxr9QPn3YYyxBYUbXgWvA2ktje4uAoHfY9JX9
	NWMmojIpIXiORlNM5Na/Yy2ij1ZhGJVU=
X-Gm-Gg: AYBFou3qiJPBfF/wmr71QCBHMgwJTexD6288o+CPsrtpHgEd5tD8DXGcylve8hq9zD4
	h/V5/xORPN5wm+FDMiddOJu3gRMvBVO0a5f91keA1KdvNCe6iQeDRvDM/v0R5t/KSfkWAG/hwGg
	J06nmLJ4TzHr39OeKJIwM05LYBpjPajHezzNHu+E8Hj6FS4lHAXRd3v2u9POVr1/nOUvcAozW6V
	nJaFVkpmMvXDw1fEW1d4OhyZP4BmG8lyJbnzTURFD3BPmwBJz/yCgRLUIpq7nwy9DECEXkhZn8p
	6HoghkeGjXiEEQCbvOHcfBNw1gxddO3uuhcXRgDuHQclKm0u0aZ/qagzGz918FTh9MGUNX726iC
	Ig7w8k+cp/FC7nji7qnF4+9Qb1PYGEdWKJGNIfV6KxdX3qoNqQUsj+yx+fSUFzHv19A174kadBP
	R6BXVyEm2dsHcaVsDKUGWPie+8KI8fcIKTllaiY+zpJSn8LLfp61vi
X-Received: by 2002:a17:903:1b4c:b0:2ea:8442:db73 with SMTP id
 d9443c01a7336-2ea9c7ffa6dmr15007735ad.40.1792847673545; Sat, 24 Oct 2026
 06:14:33 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <a8561fb7c2da446e7f7acc7e2a443991@donquinleone.com>
 <CALnO6CAsCvJRywkw0WpO1nEhL+yU2-r_4Z2AHdJch1m=NK8=TA@mail.gmail.com> <CAHwyqnWi3MCvAw-sNrn6k3ht1tpUfmNg18BAvEThKthen5Dwmw@mail.gmail.com>
In-Reply-To: <CAHwyqnWi3MCvAw-sNrn6k3ht1tpUfmNg18BAvEThKthen5Dwmw@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 09:14:21 -0400
X-Gm-Features: AclHuK8NvIR89RhP6nHnx4mnbVPEBdkkAL6_peYHd-DsbnTNxGucY-13Xqv07PY
Message-ID: <CALnO6CAxzo5gxpWkfjtvskTVjmWWD4oFE2QKyFMMo7JZUCkBmg@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: DonQuinleone <don@donquinleone.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 9:44=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> > Ah, but the manual seems to contradict my (personal) "natural" reading
> > of the command: "--delete-merged" actually deletes branches whose tip
> > is reachable from their upstream (when that upstream matches the given
> > pattern). So, phooey. In this case, if "topic@{upstream}" was
> > "origin/master", though, "--delete-merged=3Dorigin/*" would work, no?
> > Incidentally, I find it a shame that GitHub's documentation encourages
> > a triangular workflow (whether or not there is a fork remote involved)
> > without talking about how to configure Git to help you: fork or not,
> > if you push to a topic branch but merge to another, it's extremely
> > handy to use push.default=3Dcurrent or some variant so that
> >
> > - @{upstream} is the place you'll merge
> > - @{push} is the place you push
> >
> > and suddenly "git pull [--rebase]" does the right thing, "git status"
> > (esp. with the new "status.compareBranches") can tell you where you
> > are relative to both places of interest, etc.
> >
> > IOW, "git push -u origin topic" makes upstream configuration very odd
> > in the GitHub-ish workflow!
>
> Fully agree!
>
> I would say most workflows are triangular on the underlying level,
> even if the developer is not aware of it. If you work with GitHub PRs
> or GitLab's MR, then you are engaging in a triangular workflow.
>
> I picked up some important tricks for visualizing the triangular on
> this mailing list. But most of our users are not on the mailing list.

Yep. Maybe I'll start writing a "triangular workflow" document =C3=A0 la
Julia's work=E2=80=A6 going on the todo list, at any rate.

> But what we can and should do is to make git itself clearer, so they
> have a chance of intuiting it. I think for example that
>
>     push.default=3Dcurrent
>
> should likely be the default.

IIUC, the last change in this area was controversial. I worry that
changes here now would have to get through "scar tissue" (both of Git
contributors *and* users). At any rate, it would probably want to be a
major version release, and I understand it's probably too late to
discuss flipping that in 3.0?

> And many people would have a better time with
>
>     branch.autosetupmerge=3Dinherit
>
> which gives you upstream/master as @{u} from the beginning, and then
> you likely never abandon that if you are a regular GitHub user.

Hm. Since I mostly do

    git switch -c topic origin

or similar, I'm ok with the default (=3Dtrue). With inherit, the primary
help is to folks who do

    git switch -c topic main

or something, right? But the documentation doesn't say what happens
when inherit is used with a remote-tracking branch as a starting point
(which has no upstream to copy from).

> This is also why I feel strongly about this as default
> (https://lore.kernel.org/git/pull.2458.git.git.1792437798463.gitgitgadget=
@gmail.com/):
>
>     status.comparebranches=3D@{upstream} @{push}
>
> because it's confusing to switch tracking away from your "own branch"
> to upstream/master, if that means losing the waypoint of how things
> compare against @{push}.

Yeah, I'll try and reply in that thread shortly.

--=20
D. Ben Knoble
