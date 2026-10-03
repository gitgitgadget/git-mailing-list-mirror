Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE931AABF
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 02:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790994327; cv=pass; b=tZYJPJ7Pj2T/dpYiGZ0iO6BHQ0Y1dWJNsVKx9YXy/dc0huIGQgRqu3Z50cOVRK9fpgCz/AnJ4Tq2Ud4GF5wBVs0GtAx64IN0JcyWxCWf61TjJRwXQmajQuUYvSwzURYuBWoQ1oU0t21MboezDTvllYHwvs/6uDCyZJyJ9jP9VKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790994327; c=relaxed/simple;
	bh=xTGj8d/+I+9Pp0f5Lo6S6ID7ft9/YH/7mwyjVaSzzns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtkDQWaisuD+cKoUJcJX5jMbIoA75QqnmvffDoFps28yj0NNXr2omp0XlzEyJ6ql09Ni+IxJEyEc0va+wfZJHokkrSP4c7HRQxhx2rOyq6FdorcQJgodyi4MAdNYtZJVEB64hCABcrHMvjmcJBWLoyqJQlD/t69tgdvmUfZAC5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOphe2z/; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOphe2z/"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so24823a12.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 19:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790994325; cv=none;
        d=google.com; s=arc-20260327;
        b=OU6T6mPijrccl6r6pFd9IdbXW6pDXDLB0WxAed2J8pecKUjDG8GcvHQShtmco7kx66
         u4j1M3+HRELV0fyLaIvCJ2q8qZomMRpIE958rIKNKjxR2DRvSpJB72XMR8ZIZR1msT4F
         PuCKWlT9zppfC4S9rcOd7wZLErsRr4/4qFhm/Lw/UTau/Jh3IeQdjvUUmhWEfk00bufp
         c3+adrYw58bb1pps9fdoDzaX4f0KX/H/M8ZBnFn+cFjxsNZnMoXZNuxjH8v3oUNNAKkn
         e99LZju/ObK4NERbdIMQJLlLDxvyFvcPHygDKzSjxB7ZLaYQia20eWfVtbrJ9yA4k8j5
         TS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yA0Mh3b5r9+NcCPlPriEiJrBaBuZKzS8B+F5Qq64CwU=;
        fh=gPkdGHBI96mSRzA1ftca8ZPBPRdpm25wrXp2I4AuZyA=;
        b=jbsS5fSe5/nO0gIX13FmDrQ1n9xH9PHLgVvKTfhoCRBik6T9ZOKp04pOGhLLUuVhFb
         ID2ekMGOYnzHgdUn7kDOz1YnJbJhj5BjMX/lBRCeXQpJhG8DgM5r3bfI/tpeSPVl3R0a
         4MNV+hJ7ONUfKpRwrxxI+cispI1cqJGAHTPUo6g0B6Kugd3ABOXmLEGYLiEl+U0V2yU4
         vRTokuRX4zBTjQKau6G5x1ygTpMkqNtSTstaSTJiJeaIy9cms9b/jFOPKhWlo7HNP/01
         AT9ZwO4n+H+xNgGsGDAJzzTPGcObdMljVaCNajejJOjBPGOVDKbqMrSbijio4saV3HuZ
         OXJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790994325; x=1791599125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yA0Mh3b5r9+NcCPlPriEiJrBaBuZKzS8B+F5Qq64CwU=;
        b=bOphe2z/NNjf4z1c8r1G8ODjIez4vDgCIX8S5IkDRyq9D1cIlHcVWyyW8D41yIvLIa
         uJtNsfU6P/PrCPb0tJezc7uUxaxftuEojYKZIblUsw0Z/XYt6WVdMAVsH7OzOQf2oUBc
         1qjRGEcvDkYJRSFFv52FkL5xPKeswYmrwtxxduLPjlxAKsRpfsQ9yx/s10ls47JOScIX
         NNLCs4Ye/yPtTiKf6IvlaRYT0eYJRyosDU2+Ak52VrsI0OWatsDtBUmU/Ch5or+BhrVa
         O63eDjzqBReZ9LGoAVzi3kOJS2x89Gay0fb667hOXbuF0clDUOkcn1iWYSj6rvMy7gdo
         WK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790994325; x=1791599125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yA0Mh3b5r9+NcCPlPriEiJrBaBuZKzS8B+F5Qq64CwU=;
        b=i6aFvoxA7oG6I69RaywFKUrMQjxCYFmEkcqid4Xc4PXtmyGJmRe+zlVrXtW02kE5Ii
         Bn9l3liPiaS0e1Dg4TNjzr0Ve8ae1QVsWmODx6S2G/8VF0nRZH9m8eDWfq5CdVOj8UAn
         HISj4Us7HmMO2YPMHzLWIO13OMH/4WS3jV3XPXdX6hlRGEqbcM15RvXP+Gg/3LnmEpdZ
         ESz+iqmrX8UgxEa9WRy5Rv7DGOotqIvLidacOvxzkhkh7D1SSsp8aDf/Oow8kgjmS0ZQ
         yKBqk8othSq2VBmHUC+6uREBgdENO3ITYTUdvYIFNrGSqTK3+xCI81uIhZhAnfnt305/
         DbFA==
X-Forwarded-Encrypted: i=1; AKwUvBxeIENnnWYXN85xQ6LlcYf8VTvfK7+X+9SHYJOM7tXhArTKfNpMJ+bly1vzpTXEFFlofWA=@vger.kernel.org
X-Gm-Message-State: AFuF++kHBBeNvat5OOwImaor12s8SVv2onb7NfoM9aU60zPv3Kf6OHjL
	95Sxaik/eBCL5ua6a+f80T+8Z0ZsYT5vO4qROg7YFSJafq/9QmVT4XqcbteEdJ4RzRG1cSmY/yk
	v03nmZqgsLYpOaq3FhvyIPRgiPpFJdwA=
X-Gm-Gg: AYBFou1Q0uSA2Ki2AQ4fVdDtJF17NzM7pW36smwiSSSc4EEWx6XQrEU3w400vSl6BRO
	cIPPvvuAVLcwvzPrEm/oS4ydmt+5yODwtqu1Cx2pFMa+kocH3bderi2Lz3NOH+vUEAaS35nnQ/+
	c4FPyFG2Gm1GRRHyQJbcg9ALRA77XhWEsgj1UdTiCBK3ssDrZyA/PZ58ch2kDPO+z3b/NefMxZS
	Sq7gvobe1atMLRLAq1YYSMg15kXawJ2HiNQahlA1rcssYRGzT3FdLysL2oMU5om9uOOc8IFh8/p
	5yHBUWk9yiisNi5RMxj5MI5uIaNfNuhldT6VOLoFDkHnOM1jwCocwdhpaSc2+46mq2H1LCAASQp
	8fq9YBSbuQeQfYDArsSfkA7RkLv8jRwrUwsmimYjv7pp8aeke7O/U0Dp7hiCUs6PjN13GKghu1A
	==
X-Received: by 2002:a05:6a20:3d11:b0:3de:b120:bbaa with SMTP id
 adf61e73a8af0-3e0bcf9e556mr4570093637.44.1790994325182; Fri, 02 Oct 2026
 19:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
 <CALnO6CDdoqE2hyZMJg6OZkzNtcnjNXRz=HO4q6cZVpF_wbTXyw@mail.gmail.com>
 <2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com> <4e579181-e93a-4746-8c2d-b127cb0e053d@app.fastmail.com>
In-Reply-To: <4e579181-e93a-4746-8c2d-b127cb0e053d@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 2 Oct 2026 22:25:13 -0400
X-Gm-Features: AclHuK-SzNoL4tQAXGrEGPL_bzvJnEuWteOoVYlqQj1xl5Fi0R4ejW-oGonuDsw
Message-ID: <CALnO6CDoMTtyPJyOiXVPSZvFGHgGkFT-u_Qk1km+XYn9BR0OHg@mail.gmail.com>
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
To: Julia Evans <julia@jvns.ca>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 1:01=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
>
>
>
> On Fri, Sep 25, 2026, at 12:59 PM, Julia Evans wrote:
> > On Fri, Sep 25, 2026, at 12:36 PM, D. Ben Knoble wrote:
> >> Hi Julia,
> >>
> >> On Thu, Sep 24, 2026 at 10:46=E2=80=AFAM Julia Evans via GitGitGadget
> >> <gitgitgadget@gmail.com> wrote:
> >>>
> >>> From: Julia Evans <julia@jvns.ca>
> >>>
> >>> All of the info about merge conflicts has been moved to the new guide
> >>
> >>> Among the changes made to the common ancestor's version,
> >>> -non-overlapping ones (that is, you changed an area of the file while=
 the
> >>> -other side left that area intact, or vice versa) are incorporated in=
 the
> >>> -final result verbatim.  When both sides made changes to the same are=
a,
> >>> -however, Git cannot randomly pick one side over the other, and asks =
you to
> >>> -resolve it by leaving what both sides did to that area.
>
> >> I think these are both valuable pieces of information we have lost in
> >> the new guide (unless I misremember just having read patch 1 :).
> >>
> >> The first explains a bit more about what a conflict *is*. Maybe that's
> >> old-hat nowadays, but I think it could be nice to keep a statement
> >> about why conflicts exist.
> >
> > Will think about this!
>
> After talking this through with my collaborator Marie, we wrote a new
> "what is a merge conflict?" section which I'll include in the v2.
>
> Like I mentioned before elsewhere it takes a super light approach to
> introducing the 3-way merge. (there is intentionally no mention
> of "since they diverged from the common ancestor" etc)
>
>     WHAT IS A MERGE CONFLICT?
>     -------------------------
>
>     When Git merges two commits together, it looks at the changes that
>     each side has made and combines those changes. For example, if one si=
de
>     edited lines 1-5 of `hello.py` and the other side edited lines 20-25 =
of
>     `hello.py`, then it can easily combine them.
>
>     But if both sides edited overlapping lines of the same file (for exam=
ple
>     one side edited lines 1-5 and the other edited lines 3-6), Git will
>     not try to guess how to combine those changes. This is called a "merg=
e
>     conflict".
>
>     When this happens, Git shows you both sides' edits and asks you to pi=
ck
>     how to resolve them. It:
>
>     * Stages all of the files which were successfully merged
>     * For the files with conflicts, it leaves them unstaged, puts both
>       sides' edits in the file, and leaves <<markers, merge conflict mark=
ers>>
>       that you need to resolve.
>

I quite like this. I'm sure it oversimplifies somewhere, but at least
I personally cannot immediately see where (or how it does any harm to)
;)

Thanks!

PS Unlike Junio---perhaps due to my lack of older Git history and
terminology, despite using Git since 2016?---I would never have read
"unstaged" as *deleted* from the index. Just changed and not updated
in the index (i.e., not "git add"-ed).

--=20
D. Ben Knoble
