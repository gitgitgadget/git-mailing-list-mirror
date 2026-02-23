Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB51328B61
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866289; cv=pass; b=jr2QHSpBc9novEx0tlna/NyI6G8ZNF0Ut2TfI5oOAgkvRpNAMuJWqb4bFWq+Y4FYIp1INvcG1dyh2qj7sd43FEr+ZXbwOrsbfsoNQWx6c1O017iusxZdDGhekJj0P8hViT8sA4H9g/kKwZDjflerDDjrdmZJi5rX5VZM4N4twiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866289; c=relaxed/simple;
	bh=Wpf/z6GzqyG72VKCb60JTpsarAxXLEFEFCqepsokx8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twt6JTxCPpJ2BKrmVI6dxGlqr6P4ZTqqYKapx42WCEgrXVMcKbX/STc8lu1RW8uk+2z9qnFcYCSlPTkPJz/WaX0JYHwMb9RwgXMekhMLgb9qXNY5LebCq17LPRpYCqbJZlT9Xi7kfUSdHiwB73QrcL1zBC2n910UzL8W8QZRQ7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5AcdVLQ; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5AcdVLQ"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-677a11d11e0so1700377eaf.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:04:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771866287; cv=none;
        d=google.com; s=arc-20240605;
        b=VAdKB/wn1VGX6zQuCpQd/ORi2mQ7WgBEWNsKVBzIFiFd0p1HPqMOvq70AsH0qgDmj7
         CEFC+kNrkqBjljV7/gB0n1fDkhOmk/1222sB5ChTxNqIMscbRrXd+toP8W2CNnCvnUP4
         cYqLfrHVbmvGxUelH1Ej+OueFl6clPK/hO3Zy1w4SBqj3UGrBHIj33VKcXHpxxUc/ZNZ
         cDumIsd4VDy+S329+k6PPxazVvUIbNLQTz82ku9Y8Bz0sOYN1epnsVjB6f7zXH8umnm0
         8Q15NE1ADROnj98+doBqraMNeYV7yVcXG7GDhg6+M/ydQ8JD2Cz2rp9gLH3BTyhKWbrA
         oWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+7wDC+qvbAI5Ob6FDRoBXS1ODMYDcDi6ACW3pQla4bg=;
        fh=4zLAr358KLnmEWirS5350TtoH2Id33GSf5WuMtM1gig=;
        b=BzMWwXKO3zOKzVOhzti5gkKeEmLeeiaDV9PLerLUqhPC6IJFO8i/achVDb8bh++zdC
         dy7uEHPLHQGuWNzQUfQx8ePtC8P5NlYTpWlpcnseQN4Itu1j35twuZyF2PnE2rki66FZ
         JEjHVDbU5LjeE92x3/tTeKvPYOEvNPqLx8NuSBPyEYzs+HtgTD68356m9ukJOWrV2JE8
         XQ9iyIllo76ekcarCGgQaNDzhPm4D7Q5DTBn789ivkVuX+X/BzoLV0NYPDIzWjCx732t
         lCnHslv0AHCyfXObbrX+0+JwUW2baEPo0dWmnlio+MS2huhrsGivfB3SuVjEoxj6ScQL
         ByLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771866287; x=1772471087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7wDC+qvbAI5Ob6FDRoBXS1ODMYDcDi6ACW3pQla4bg=;
        b=b5AcdVLQIyyMjlPh3qq0Va+yykqWYlu2CRyuthpwyzs30ILAtRbq30wRACJ5H7X52i
         REursq1Cm0quYpoNbFW0v+SkuZPx79b7Ik589a51vmA0BLDjUHP80sGRjZR8+lTd3Xnb
         ZzqNmGGORtb2PjQJ+OTa0mECa/EgM/oM6cHR0GIWR5nAgoa5plSJ3V5t7Rs8E2Z0Cpdh
         tiILhO13Qkb3k+d+fVEGw+udmcCNbp+S4MqMl9hvLQEj2tGaFdvr7Q2Qdt16RkrPqN/5
         9bSn/rI/9vHGiBsQbVF/nnOIrKAYmcqzpC+5xgGHEtZDwGR+NZy2YIyMAhiRA6y0xi2i
         8Xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771866287; x=1772471087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+7wDC+qvbAI5Ob6FDRoBXS1ODMYDcDi6ACW3pQla4bg=;
        b=qcYwkGLV3IyJdbn0L7aVXK2GeJ2qNzb/JBQHMO+pJfsCjim0pxtyppSwRGS9bx10fb
         3ITj7uX+L3AsLKhAnVrGsHVSeBjtMHB89wY8jINbzi40wEXKob8oDJqBfk18AhPHNmcN
         GxsdCScJKFeOB7Bvou4Dh3S1pvSa+nuxfM1XHOR0rFFJNri3B0rGLp1pUvUXyOLudsxz
         6duxqvUX51Ep5LDcRZUHKEUB28eIdWgpXmyR6zGUK27iKUKSrQixrJlNMfmKvcfRAet5
         HhYOPWvWae02aQEAwikkmJNP4jtTVMlbSjBSP6hYeIDFzOoiU5H+4+NFVruELdsja7mS
         x+ow==
X-Forwarded-Encrypted: i=1; AJvYcCXpadEC7sxKiPUE+K69v7ne/ELqqp0sea2IFW1IVfNJReRcmVEBRFfo9vW1emiyjntoVzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8oKGUNn+9ijjMimTnRsm729HmSbMImWkrdC3RL0Gz2fxpYPoF
	tRc/STEgSIR26U1O1n7snHZ/ncmmVm8tuY5e3HJTrOp08XXg+mWW4y5VhmXXogaG51Oi9T42oEe
	RPP3wOT213ygtKt1+x1GSoXJh3wSXvJE=
X-Gm-Gg: AZuq6aLNua7hUdOJ2L7E4XVIqGo+kWiN4z8fXvz/0RwMsC5k7LjAxzM57NFLujuWpni
	0by8hA49LuzTf2AIjqkZ8WNRocnSBycEe2s8aNm0MsGY507LgYTsQu9emGH5SJkMhCt6L+B7Nne
	SqsXLhaWbkpIh+ngW4SqiMKZ4FqHM++xlkF2XmcDfoYhM8rlF5V3fNuSd613B19YvQLngHWJBfK
	mtg6Mdr+7+bAzVCRSAoj/QWIo/VwjP33X7Ysu2ccqmh4K9lubvuwFZ5TQKQml8mCm1uogEczbGz
	8QbsbWtYLdOPpkQjpTo7TvUSaUTb7AMD3LOcW5+z
X-Received: by 2002:a05:6820:2215:b0:66f:6d5e:76c3 with SMTP id
 006d021491bc7-679c46eaeb1mr4443415eaf.42.1771866287440; Mon, 23 Feb 2026
 09:04:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2054.git.1771837399472.gitgitgadget@gmail.com> <xmqqjyw3o2w2.fsf@gitster.g>
In-Reply-To: <xmqqjyw3o2w2.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 23 Feb 2026 09:04:36 -0800
X-Gm-Features: AaiRm51QTq0ThbSlanRQrlkGPg5lbfQuDRRgPlHRW8H7GCexlMBURrTUzBzkiAk
Message-ID: <CABPp-BENP2tUt1MufKeGxXwgr+iHEDnXjOLsaFk7OPkbOsLAMw@mail.gmail.com>
Subject: Re: [PATCH] t2018: move checkout case-insensitive test from t0050
To: Junio C Hamano <gitster@pobox.com>
Cc: Md Ferdous Alam via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Md Ferdous Alam <mdferdousalam1989@yahoo.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 8:12=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> Adding CC the authors of 69f272b9 (dir: special case check for the
> possibility that pathspec is NULL, 2019-10-01) and 06d53148 (t[01]*:
> adjust the references to the default branch name "main", 2020-11-18)
> the block of lines removed by this patch are blamed for.
>
> One thing that I noticed that needs checking but I didn't do so
> myself is that the original is prepared not to break after Git 3.0
> by using 'main' in t0050 (which forces the initial branch name to be
> 'main').  Whereever the corresponding new code goes, there needs a
> similar provision to prevent the test from getting broken with the
> default change.
>
> I think specifying the initial branch name explicitly when the test
> creates "repo-case" test repository and use that to go back to that
> branch would be better for the purpose of this single test, rather
> than using the blanket "GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" for
> the entire script.
>
>
> > From: mdferdousalam <mdferdousalam1989@yahoo.com>
> >
> > The test 'checkout with no pathspec and a case insensitive fs' in
> > t0050 does not really belong there as it tests branch checkout
> > behavior, not filesystem properties.  It also had an unnecessary
> > CASE_INSENSITIVE_FS prereq since the sequence of commands should
> > succeed on any filesystem, and it did not verify the resulting
> > worktree contents.

Actually, the CASE_INSENSTIVE_FS was very much intentional and
critical to triggering the original bug before it was fixed, and in
fact was overlooked by both Denton (the original reporter) and I,
which made us unable to figure out how to reproduce the segfault he
had triggered.  (The testcase does use both "Gitweb" and "gitweb" in
it as paths).  Luckily, G=C3=A1bor came along and noticed the case
differences and created a testcase for us, and then I dug further for
other surrounding issues with that initial guide.  See the threads
around https://lore.kernel.org/git/20190925215530.GA9013@generichostname/
and https://lore.kernel.org/git/20190927021746.GL2637@szeder.dev/

> > Move it to t2018-checkout-branch.sh where it belongs, drop the
> > prereq,

I think it belongs where it already is, and the prereq should be kept.

> > and add a check that the expected file is present after
> > the checkout.

Not sure if that's worth changing, but if others feel strongly then it
doesn't hurt anything.

> >
> > Signed-off-by: mdferdousalam <mdferdousalam1989@yahoo.com>

From Documentation/SubmittingPatches:

"""
Please use a known identity in the `Signed-off-by` trailer, since we cannot
accept anonymous contributions. It is common, but not required, to use some=
 form
of your real name. We realize that some contributors are not comfortable do=
ing
so or prefer to contribute under a pseudonym or preferred name and we can a=
ccept
your patch either way, as long as the name and email you use are distinctiv=
e,
identifying, and not misleading.

The goal of this policy is to allow us to have sufficient information to co=
ntact
you if questions arise about your contribution.
"""

Since your patch was sent by "Md Ferdous Alam via GitGitGadget" I
suspect that your Signoff should have been "Signed-off-by: Md Ferdous
Alam <mdferdousalam1989@yahoo.com>" (and the From line updated to
match).  If I'm wrong about that, it might be helpful for you to
include an explanation of the name differences with or before your
next patch submission.
