Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE23F6C59
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929979; cv=pass; b=DdrVArDyss0f4m7Xh1SEpzPVhVyJZ3prHNBx+Zklwgex86P88GGpwwl78FI+E+rDwXhuBiJDgxiZkWSDvSqQ8asmjiSNzpmF5bfkl1Ix2GqLmIIKU1486SkGLE1lohVBbaXzlZzWUYKNpPEVameuOFo82gMnSjGWSlkRS1Xh2ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929979; c=relaxed/simple;
	bh=audiDQRqpA2gCzSrgUsFtRs3n7X1xYMAFgpkZ4Or2xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBk1CMLFftQVvBOUyYuMLeLPX+PeaW4Fex5bM/uPXgR/5NMPVzkinN+8vxOCDH7bVZuo3BjBRnY/3dSZ/LQbxRkRepiGP21ESnrPAtLKh/xIia4YLLuKea46BUrXKXqOldMKNhp9dOYlNti8UYWtpLhT01C9ARSYygY7jqIGquY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaoI9LpO; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaoI9LpO"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so651746a91.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 04:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785929978; cv=none;
        d=google.com; s=arc-20260327;
        b=qvm7UciatOdfyalCaoe7vm5MPzEpCm+OmYjJYcGBKADQO/PXNi7olhh8kICrt8S7mE
         b/dEURWALbSgLJ5mxIXovC/8Tk31irhiL9lkea0bo7BvcP9t7d9NuUrRxhaWeH2+v2uM
         E2WtKVROJqgly+g9m35rEMQLRycyddPTSvaHoG7+aUbMAfPAqz5ZftQWAFl0MGZJ6FgI
         elo3OUOavTGNpem13HzH67LLemHpe+mfpzW1pWZQ6ZbOqEjuF4xZEdazrY1veEedLLZV
         ag0DjEdhhkEZj+kp8c5sCcxzveJCk5kWkxOll3u9+zEAMOWo5fxDF0g8dqpiUSlJ13X0
         gscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=audiDQRqpA2gCzSrgUsFtRs3n7X1xYMAFgpkZ4Or2xU=;
        fh=92Tkvip5+Uv0xznDncd2nXUB2I+db6hkkkTbNZurL4E=;
        b=jbQbTPSZNENZsd6d566erZnUJ6rzPt3aBbV6P/PsEUu0cloECvlEw5/0rZVN8y08AN
         w63efWVBme0qJ3saBxcpzcytpiYQdGf3zSMDtVBQd0VSHoSsw0v/asxq21AheDLuSynd
         tuTjwrdfksP3zlQsOzpqXdiho4sZe2KA8Pw46FzKJMRdEpvL0A98XiuqUOnmVYs72dK8
         aUQTq6HOzy7oANPe2/CQceXbkiZ1NtyLRIrUWsXPmngEqT0bQu8Wn8KmCjFi1EOuLXCZ
         a7jTkddaZO3qgw34mWbp5NvYLBkjP7IyJx59MDxoxzrt9968Jwg4KDYcuZFN+IKUgayc
         dgDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785929978; x=1786534778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=audiDQRqpA2gCzSrgUsFtRs3n7X1xYMAFgpkZ4Or2xU=;
        b=TaoI9LpOFh4/ORKz90isMbPBecIkkfWKnir0Hp/e0IN5IggXucv9r70l3crtDkv7Z/
         u80zwfT0rlpTxoP7YvVHjLUsZYNd239PUi9KFlBrDQ4cuUxyo1mDqzXpj+4XUMS7Jih9
         7ib6U1VnJfQ5hjcSJRX+QD/9vT36lU3dKw0v5isxAlDiJ93ti147UAtPFLG4cx6I6KNW
         qPSGK03sOoe9E0TMTISx5Ob+SMfUytj15/MZXhxXffP/SJXko6ap4sTGX8xRuJR1wh75
         YtVULJDIb6jsCvPIy8BcUqX1bb4BaMCz13ROYbsl/syvQcrg6RFR/2slRLZv9rlhTtNq
         R81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785929978; x=1786534778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=audiDQRqpA2gCzSrgUsFtRs3n7X1xYMAFgpkZ4Or2xU=;
        b=fnZff4mOA5zFV4sQaFVyOJpWO+ewmdQRffFPVnAKu++dnUzO8RybyCLOS1yVWMj3zg
         9qul734fu2gBD4k5GcqFSy4LSC5tXuDDldsAG/Vjh7YcuXssEVisq26HTFTlEtCmkFI6
         K0TO5JBiN7/28R1Sxd+GL+Vr6kczSyoDrk4kGtAbzyM33N9YJ7xb6jbCliailtae8CGI
         z7fYBMAyFs4PuIwCWbMvtZrAF1QfjsA3W6ufnbty4tLPokicFZpdJCXJ8fYywk93M+ln
         rlOflLrf+lYqX7xzpcb79FHyhcJcr5jLo45+05k+w1fdlspkUXJ+01tBPJhKsJ1C6gxa
         YYzQ==
X-Gm-Message-State: AOJu0YwijT0dkMgfqfN6Nl2ZkEnHDy1TZHvuq7jX2ZIX0ESRKcK+grUA
	HLp8odlnFmD3Uyt0e+faT46XOExXTJJmX7iGmfAHOv/iTAHyOifg0A/JFqGQF98fdAZChm6bIej
	FbjYM38Fe0dZrvmQIIilUsdgKbUROFuU=
X-Gm-Gg: AR+sD11bHdoF3NXA70bQyw+DaYQxLf9svCGFvidojHBpcjEM/f+HRCtpVYMupWUzobe
	M/QbmbEMn9rd591BfEOE2BwuDitRWZ8OKTRm/pKUsyjcOnO27O+nBGEcGWERhHVl66+IId9ZHL6
	4ykf+TvFK+MFHV/dmUnNB+bktAuytNGqZVF5obLNuJpEdeaLvAEWJP22pIodsekj2tPo4mG/X7E
	5JFLhem3wtpiw9GNOaasyeACWsYRNcHqxPvOZcEpSKTwxImjC+tIXUV16gXiD6D+CxmcVsErALo
	A93FiYNhdGp+hi8uVE17UDJ+tnOEkZug6xDQzFYs1pYBx4SadfQAkvHTFQ6nk34AnKM/PKD/nVZ
	NoOoxlh1sWPoXlqgDf+LV1cmqvbXAkeVf0NpETWGmRkgTviCucpgi2skEk4rPQnabQ4ItxKB+rG
	yaucY4g5temWvkGNkFSw==
X-Received: by 2002:a17:90b:2248:b0:38d:adae:4866 with SMTP id
 98e67ed59e1d1-3903c63c51dmr5119768a91.21.1785929977872; Wed, 05 Aug 2026
 04:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CAN1=dgRsYjABfa3CJkGnvb139EcrzS9EnX43i3szOgtQ@mail.gmail.com>
 <anLXz2vos4zbIciW@pks.im>
In-Reply-To: <anLXz2vos4zbIciW@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 5 Aug 2026 07:39:25 -0400
X-Gm-Features: AUfX_mwbTRP6-14f-oNAdbb8buTE0QNs0nlJXZFNHa5mwqlBXnGT_mNQ33itpWc
Message-ID: <CALnO6CDtihFytS1dhfZPDA7jUL3bvAt=zYOH9Wi=naEoC58B1Q@mail.gmail.com>
Subject: Re: git-replay/git-history lose notes
To: Patrick Steinhardt <ps@pks.im>
Cc: Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 2:27=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> Hi,
>
> On Tue, Aug 04, 2026 at 04:06:38PM -0400, D. Ben Knoble wrote:
> > Hi all,
> >
> > I don't think this has been reported or discussed yet, though my
> > apologies if my search skills just didn't find it.
> >
> > It looks like git-replay and git-history will drop notes (or rather,
> > not carry them over) when rewriting history. I've seen this both with
> > "git replay --onto=3D=E2=80=A6 =E2=80=A6" and "git history fixup" recen=
tly, though I
> > suspect it affects all the modes.
[snip]
>
> This somehow rings a bell -- wasn't there a recent discussion about this
> on the mailing list somewhere? I might be confusing it with a different
> command though that's loosing notes.

Yeah, that rings a bell for me, too. A peculiar rebase bug, I think?

> > Are notes out of scope for replay and history, or is this just a
> > "nobody's gotten around to it yet"?
>
> For git-replay(1) I'm not too sure, as I consider that command to be
> part of plumbing. But git-history(1) is a user-facing command, and
> because of that I think it should handle notes automatically for the
> user.

I can't speak for replay, although I do use it as a convenient "rebase
a bunch of local branches that have conflicts without checking each
one out"=E2=80=A6 but the history part makes sense to me.

> So for me at least it's more of a "nobody's gotten around to it yet"
> scenario. I've created an issue in our GitLab issue tracker so that we
> can maybe pick this up in the next release cycle. But I won't complain
> if anybody beats us to it :)
>
> Thanks!

Thank you!

--=20
D. Ben Knoble
