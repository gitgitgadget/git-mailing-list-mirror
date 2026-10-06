Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7D36AB77
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277259; cv=pass; b=V1uHak3q0NPd19iRkBzO2agtsENeKV0cjMzXesPuCV+XlWJkBxG3sGuxQ2c9DIHK3zBEAbgOEXpBJYb818DyVEg8jx1U6M0/VmuAlrIEcUop+CA7uMUR6mNI0RsZGJdXTgpRZeEW9qg1L8wbBfHViFM8kYvhuGbhU1XUbnIZo4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277259; c=relaxed/simple;
	bh=KcqYQAy4GVsfjdU4KrgmT7BzObWnSUKiykA8a0luRq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RxGkI99LvXJIAl5FpNrdy2s5M7bx6+5C+jGslXMpKhSGwLo2mFpyoS09IhumRXzx7zSZ2b2As66ZF6UfmM38PPdHKS8PxKXZGsCwXw7MzWT30QuDhWgR1ONO+dVue6TGumEs2fYP0MzfwD4ePbYfQ6Q9p4jqMMijoqaAk9zVld0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/t7l76N; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/t7l76N"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-144f7915346so872720c88.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 02:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791277257; cv=none;
        d=google.com; s=arc-20260327;
        b=RzYcHsQFmE3sFNuzPjiGYuRCp8ohQd7GkDOUekxSBqoK0QTEBlL87uKbfPj/w41NEW
         a5Tr5fESt/tgEXCdpy4tmxoKyICAM8j0Kqv7IJSJpnu2PPi01eT0ir3PPVqgiYRe5s9F
         EFtXbQfd8hoUkWQ7WFH4H/R2drQcbXTIWDamesPSD8fZ0Fnsd+hTCSVIbnZM2w60Pvdf
         SqfSWoJArSQzCterq+pZG6Q/mBVsH8XK6IDysnxNQ210md9yJG2dmbjENQLx0jxMXXAw
         svaWMOe3bI9fghHvTwVM/DcbihP75wRdLmEq821LTjPQrNiEjOWRnmvvbweRo6gNc5fn
         B4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kBSkLmj69CO8qC1ZynyxPQIZA2KWGRasduxuu/yo9+M=;
        fh=7F/J42sidoT4dlkENlyDsTm/pakBxdK3+eJXQe0jiXo=;
        b=PCGrfQG59kWhzQZ3cMZIa+OfqW/MtXq2GSr3OwRUig+BDBgtRjcoGPMNDdj/i01rt3
         E9E/1JTOALaa8SeqEXDJiLep/UJDsnh8PYgWVIWEugr68Scs3eL13USlR+0xCsu9BlyE
         K6wQEFarJbYiYfrv+faxSnzgF9RQn5wNiCwgGqBVuvT+nY98j16D2+qALmp8mau0dhX4
         m3Kpt0qHcUtPKtRupXbZhnmpGfrfymNVbrsNEUGgPFZbgxyURolqxQB/5sYzbrCGOKOi
         b6ys+ylKL8aJ7RNlVsR07AeH0qj/65yhd7vzygRDENUbUKyga/yW6qGkRYY6fXIyqMjT
         fdhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791277257; x=1791882057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kBSkLmj69CO8qC1ZynyxPQIZA2KWGRasduxuu/yo9+M=;
        b=f/t7l76NzgRw0cs6ByJWZLsLhaOYi3RuxwLPTn2z/tN9PJ+ZUT+oTZskkOnckpa7K4
         /q83fWITjT1W+qBmw6r8PRw2Bb2kTjJdDoInvqqnCuOr6Tgs/kCgtygUB1qf+/TlDXwl
         n6j9VDufUuw4wuhu0NkL4lElbqEHAQcLJQ4L7jX4swnlVW8RoTSR6Chu7EqiuU0tOdHX
         un95MVogA6mHjAHPCTHJcTW6uUgNlPN/nRY4pX3KCFcBRf33UPO8Gd5UfrRqgsgSmR/M
         U1fuVklg9oz4we5DFC9x9TQN6UCDJ3gT8ke3V6x0rEQCsK3PCXiwvqap0y22sEeXUzkJ
         FX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791277257; x=1791882057;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kBSkLmj69CO8qC1ZynyxPQIZA2KWGRasduxuu/yo9+M=;
        b=is7lkWZICO1rOu71QH5orY/5XBwcXc2t1ufr8ggIEYUQ+f8mtXqvQ4JeTlxhLBZAmE
         9SQPbxHmqIcAMpJ7XJzHAU2jcOBrZfu0AmyVazIbPJeisol3PMZs+msC10wwY5CLVPWe
         C8CBUj6baohcTFpUe49OiZFnEXccp5IZj9LcWTmikPuawsaQiy8jHvC55LuTyWavE2rK
         jNB8Ums0wU/lcWQMaJI3NEIeRqe7czcvFVYbg/O+4QFppZX6jetwUK5rdk1v96ieKobK
         Ke8+4q35SnVKi/mVvf937pdQYSSZO/WYRgXRYCVIfL+daoBPQ1a701H8+RQjIGN3jkxY
         YGwg==
X-Forwarded-Encrypted: i=1; AKwUvBxmGjfCjxQj/CWd+vCBCgoog3yWovR00Utwd6CWG4CKx8tkiI0etwnvmz4MneFEf744QFE=@vger.kernel.org
X-Gm-Message-State: AFuF++lKiDXcy7XtlEELPCTxeohJfM/o3Fb0RWEefAYR/l4YYXAS18pR
	5hqHEcLLhojlQzrYqcyIo99/nd3wKIXjeEE5dxjf2+8AfV/AwVwbiZmM120K5/ZFwGxUQ6Qa3Xu
	x5d4BlycGgpec1Yv7JTM4cyCwXVmVx/Dgxhs7yFKZ9A==
X-Gm-Gg: AYBFou0p+3YQtUghwAAYHX/lZRGYqUvrdko3+Qe9HJ6JUaLfHkC7T97OA9axdAdDow1
	xzBs0/V0cZRk5yWA4e5lEYbsit0McEc+wk9+konD+51COsqVOgg9nrrHpu0kuT+6wlRMyENC8mg
	Wz6+rrGfiTcuxSXM4q6dN7ZmY5K7bxcYyLS8lUbGVOHDPsJqreoFeQ7GDKC1Plh70wk1XIOkumQ
	Fq/mbe+quD8GGHfZg95vaJg+i3XC7qUZqM6BDgl68tc8wA8G9hEnzGVgGX8zYWIIFNwKUPmiv4C
	qqTq74m8ZEt8OFmnxE+F7voA3/ZlIC2esrlssdes9i1A58CIh82GLLT77sRAUorvbNXQngneUwC
	CW+5jMpFxyQ96/YrVIroq8HNLSQl7h3xYa0TEr1DsDgPAY53ppAAVViKkSSkmmCtOl9SwQjnOmr
	r5B/W3ii75Ca+8RKbAkd+0jUowmCkT7DJPJCTl+E8=
X-Received: by 2002:a05:701b:4588:20b0:147:9ad0:cf10 with SMTP id
 a92af1059eb24-15ece6d2ce6mr1133084c88.47.1791277257348; Tue, 06 Oct 2026
 02:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002081846.25144-1-scott@gitbutler.net> <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
In-Reply-To: <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 Oct 2026 11:00:45 +0200
X-Gm-Features: AclHuK8c5LCqXcI_NvK5ONV8i3SgPQuldDWwwNCEouMzFt5BgRUAlmzo9sGpscg
Message-ID: <CAP8UFD096CdR9MXd+VHk7Zf9rCJEnGTEiBhCc0mJdMmE3U_gOg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and tags
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Scott Chacon <scott@gitbutler.net>, 
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 9:15=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:

> The thing you really want is the interoperability work, which can
> automatically rewrite repositories from one hash algorithm to another
> during a clone or fetch operation.  Yes, it isn't quite that simple for
> submodules, but if you recursively clone the repository and all its
> submodules, it should be possible to rewrite it in place, although that
> hasn't been written yet.  That work has not yet been sent upstream
> because some of it was written at $DAYJOB, which requires that we use
> Outlook and we all know that Outlook corrupts patches.  However, there
> is some intention for another company to handle the polishing and
> sending, so it should be available sooner or later.

Sorry for the possibly stupid following questions, but I think the
answers might help us get a better idea of what might be needed to get
a smoother transition.

And yeah, I know that many people have said that merging all your
interoperability work should not block Git 3.0. But if it can ensure a
smoother transition, we might want to get at least part of it merged
soon, and the rest in a good shape, anyway.

Is the current state of the work publicly available somewhere? Or
could you make it publicly available somewhere? (Fine if it's only as
patches in a tarball.)

Is the submodule work the only missing part of the interoperability work?

How much work is this? (At one point it seemed to me that it was
around 200 patches.)

If you were to work full time on upstreaming it, how long would you
expect it would take you?

If some of us could help you, how could we best help?

Could you say which company is interested in helping with this? Would
that company be willing to work openly with others on this?

Are there some tests or kinds of automated ways to check that things
work as expected under realistic conditions like:

- using real world repos (large ones, old ones, with submodules, etc),
- mixing a number of new and old clients and servers,
- interacting with other implementations (JGit, libgit2, gitoxide,
forges, CI, etc)?

Thanks for all your work on this in your free time,
Christian.
