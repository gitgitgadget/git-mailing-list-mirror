Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568E437F8A0
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206411; cv=pass; b=WSNtpT+NCOAed76jPUppkKmKoQzU5h+wFxErtGO3ojnGE5vvNKfbmUxeB4BKnyEEvOP7OkGe2Pdjn6nYJMcJaREVQvSIbuEiYNtEgjy6kE6GTXbUHh2OYRw+yPJZCzjntVqFKGVv/03opsLCohqnr79gfqkgdjUNQDDJX7Mm48w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206411; c=relaxed/simple;
	bh=84XboGIbODIZYZh31Ujc4zqMFwBEaboQSFMgB5cTqoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kX55N4H9B8wy+9EmEqqSIi7ZQt8EPQeeZMvwzlPkkbPUr891APm0p3coe07MN/08IQB3PFt9qqDQ5XpM3BzO8B78mHE3hv5rSgDCTaIu0ENm9/PZ4kBkGDBdKxY9Ob3mxIYnbslinPHUuEjtLxCSw0RNU//H82/5n/GDvH3gd8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYcGy8WD; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYcGy8WD"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39675172593so3458523a91.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788206408; cv=none;
        d=google.com; s=arc-20260327;
        b=D2tjwCidsE4JhvVjxxgHMaWSqaLIAB0fh49z/StGMov0dNYfcvohDVHleByLy+8p6u
         MDq1JbOlw4kVcCPSeghlJe5mXcm+TGt580B9dL4g1zGgwJH/h9V7SB9iAMhszjBxvm/i
         lC6LpYWF0Otf3tne436jqi43naQuyhWUgc7FJ575xoICwnwgVNjcM3RjEz9tCjpMmQbH
         xD7Vm6WX9w+O7z40RuaiHzFvp6rVB/U+mR2YyyZ2ytWECGPT01sp68pbmlgfN5inuodv
         0BE1FyHa0C7hRvrew9Yovj44i36/VIkC4c8RrQpomDY87yWxmGP7nV+ldm2kJWn/euzk
         9+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oFVFzsCfnUiaar7+2k4KkeshPTYKSEzeFzxloVDfGM8=;
        fh=/iQwzFtNDCXWtGgV248b4HkGCg5LZ7vtOPQKBJiNQQk=;
        b=IGWbP0CY3Vyu6amP0P0fEUDm8H+s09Tbqpe0yyaDCNxwb5ZUayGmw1WZaBzcQCIfnh
         YeEHTvByDkPH3KUys5TlbMLiwpChh8zn3/yeEt07wYen5oxep8KgJ4l+c0zcs07/knx0
         9cBGJHj6bU7Fxk3Qbtwza6xmlPmYtVFqN5xLJbAlQRMP/KaQxQwTBjQYo3S8eh0rKieq
         B0iaqBq9cWk1to5Gg/M3FjnwhjfQUaVGCnnwJpIrIC7Fb6ImgmHT0ZV8RP8xwAkF6JDa
         FVYOTP8UW8BFVlXcxUZYLBVbWajZMthLI+qFTmhb0Hv1lyqz+ddkRedKEemVCGLQ72BE
         fPBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788206408; x=1788811208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oFVFzsCfnUiaar7+2k4KkeshPTYKSEzeFzxloVDfGM8=;
        b=GYcGy8WDzq92e848tpZlTfjzip01n/6twTGNpke5V/EFFZA+7xyYxGE5tbw+CJgcHr
         CsIxQ+uhpc6p0dhKHxCAjvoAroQeLB+XZGS4dlMupDM0Ie8uP5B+dKc04oZoq2AwFONO
         NTkwEiLJiSObMJaZh9HrDQAElTV4nIgsu455w063DFe+FfzgasVevrj7pESmCf8fCWIV
         oe4EFfm2ndDb4aTCCS3bdj2IVN+uVSBPMMButEBbCeaVM66nq9bLXVdu0jCKgCUWBpp7
         UOEmVq7Kep6D4i0T027mnxIUko6OBva9MGjTMLJzkNg7GFzINhO2Z/Ys9epT1z4DPYty
         DgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206408; x=1788811208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oFVFzsCfnUiaar7+2k4KkeshPTYKSEzeFzxloVDfGM8=;
        b=mH/qgQ2rKAC62NxjW/FcQUadibPusQ7TJRUQfYozWQlOLSYEqQunGarpXokB9CLIpH
         hCzMJfHf97LjIyT3p4zplNn2QIsEq1TJtopMT3Gy0RidCW3+2gjrduI1sflfnt5bVzV5
         3yUyg/i9HaPU7HHwcvms6TiwJOonJOqHE5ROHkqDpxaU/Swql7lT2i6rax5m1PjUYnHZ
         SDHZsJk5B524xgf0jNpF6IvXhy1DRWGrJQsFc7Gm/03RJYFidhbMolC9hiNF+lA/8ZXr
         sdn77N3APTgwEN7VM2eC6IXN8KRr4EJUJXbO0bPjQ3tT/okvH5AZmCan6jbMUScS8V0U
         XSog==
X-Gm-Message-State: AFuF++mKPW5PMjfOlIBSUyY576k7BQ6dhr8X7QjYBu/SHtSHyrYEn/GY
	p9p+Bv4lWzHjAejLuWYVhaw49aLOmMvppgax2MT/GrMvSu/sKFUEdLGlmzMY3aum4pLLJ3r8xcz
	coHPeRdSbZJo2ulQ+HdwbasKvSozCLczwyJnW
X-Gm-Gg: AYBFou0tq8LqaG0ESubShsAD0lFh5Un2itPYmDgEm9QzMAu8EZXZKIBCDoM4EgNLkry
	n0VgARD29tUuNfbG9mvZbTVkEQWvKXoJfnlLVbbFNzGQXbDhP0Sx2kyTlFh0YQoivt3Z00wlB7P
	IoS4YOx4H5BY+/vnOAm866Or4ZUIDvkKSac0OPrsnI4mToekzmjWr/ounXNo8tfSwKQmKDnYAYE
	iFUppU1UoNb3Wzw01UdncsaCsRASAaxx21Z2Th4NSmIJItg1dUulkU2andkjteKQ+haqKg9SlnO
	blGWqLDQ2YSUwOi4kldopBe1X5gPcoa2bxzl+5KDsGaQWEEs/Wg/Mbjwm7PNQJ4rFEkMbTunaL4
	2G1blTQ77fdjr/tpCUqIVjSjWsdoDg+730XyZcdHUwfBG2BMkQmN6DtbkXy6pWDBs7KQma6nd
X-Received: by 2002:a17:90b:57c8:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-396d0c347d9mr42590159a91.0.1788206408116; Mon, 31 Aug 2026
 13:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
In-Reply-To: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 31 Aug 2026 15:59:56 -0400
X-Gm-Features: AcwNN1WSUBN_NWZfZFg6qbLt-oH_S6B_AHMEoUtyIJ2ews20M_oyLxd_RJe16Q0
Message-ID: <CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence.csokas@arm.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 3:12=E2=80=AFPM Bence Cs=C3=B3k=C3=A1s <bence.csoka=
s@arm.com> wrote:
>
> Hi,
>
> I ran into this issue a few weeks ago. I'm using Git 2.55.0, which is
> the latest released.
>
> `git help check-ref-format` says this about a branch name:
>
>    [...]
>    9. They cannot be the single character @.
>    [...]

This is the rule for a reference.

> And as expected, it is rejected:
>
>    $ git check-ref-format @ && echo BUG!
>    $
>
> However, the following commands all create a branch named @ :
>
>    $ git checkout -b @
>    $ git switch -c @
>    $ git branch @

But (with git refs list) we should see this creates a ref "refs/heads/@".

I happen to think that's extremely confusing given that "@" is the
shorthand for HEAD, but=E2=80=A6 it's not against the current documented
rules, I think. (e.g., "git switch @" will fail, since it sees "git
switch HEAD"; using "refs/heads/@" will also fail.) git-checkout
doesn't fail but also doesn't change to the "@" branch. Futzing with
.git/HEAD and restoring the working tree works, but=E2=80=A6 yikes.

Of course, --branch mode is allowed to be stricter; maybe we should
reject this case?

> I believe this to be a bug. Other invalid names are properly rejected
> though:
>
>    $ git checkout -b master@{1}
>    fatal: 'master@{1}' is not a valid branch name
>    hint: See 'git help check-ref-format'
>    hint: Disable this message with "git config set advice.refSyntax false=
"
>    $ git checkout -b @{1}
>    fatal: '@{1}' is not a valid branch name
>    hint: See 'git help check-ref-format'
>    hint: Disable this message with "git config set advice.refSyntax false=
"
>    $ git checkout -b @^
>    fatal: '@^' is not a valid branch name
>    hint: See 'git help check-ref-format'
>    hint: Disable this message with "git config set advice.refSyntax false=
"
>
> After creation, this branch cannot be checked out again, as `git
> checkout @` is a no-op. Luckily though, `git branch -d @` works, so I
> didn't permanently damage my Git repo :P
>
> Bence
>
> P.S. as I was typing this mail, I realized that I should've given
> `--branch` to check-ref-format, and sure enough, there's the problem:
>
>    $ git check-ref-format --branch @
>    @
>    $ git check-ref-format --branch @{1}
>    fatal: '@{1}' is not a valid branch name
>    $
>
> Not sure why it thinks that would be a valid branch name...
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.

(I don't recall offhand where we describe valid branch names, if at all.)

--=20
D. Ben Knoble
