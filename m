Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793000544;
	b=zEj6Y2sgZiD9GliBQS6R8wONu89zRKK1tpysqC14Tsh3GpLCyer3UG6ykS2gHCEPf0Nr
	 32pswA9RrNo4ibXgKqJQxiSDu87s95nInl22sdZMqlixhijrxlThAlH4+uYuGjyg0qli+
	 KcJu1iwcJsGKZkf4Bkh+yA/emLZjHG37KsJzuJ3uOEsQEC0O6Q+38CdVBw4xpJ1puACNL
	 gclodt8GJg2fz9QB3PMSAe7FyCNuZMqipC8ewwM05WdqqVQhVH+VefT9c9TOuK1QZo6GW
	 TvklXfICruLet7gg/JchAvNzcAw4uzvifnmC0r1L1C2gqd2HkxMnWfp6Tih7SywNXSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CNn2YxFJSXifftHetmM/NaZs2A9+RrVDE10/S1WyxGk=;
	b=5UgeCamr+fvw4HOnNCl8ngUXgHJw/mRmgQiqjBy6+edLgTfTW/XBqVH0TSikYUbjl/da
	 2MESvt1UUem601VE1xsi8Rpp65chvJRxZ2XjsEfvpmK+hG+/4byU7u/Ic8qfoH/y37f4z
	 QL0Zo/x2ih3A9w5LgVh0cSlmtJ/4Zpl7J3GmBcBSmQ69fq7xIRAJHHVRSX21ksKeLTrst
	 clxnAJ1J5jjdVBNz4HKfD/+1WMNXDRCFTS3b1cplC8UEzB+5/+uoRHulcC15WIPGU++vQ
	 x3+oor7zaET5Xv6DFoXobYrgi7GK6s/G0qcAt6XNkJgrikQBKV3ztaGG1QB8seE2/sQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ozv5IOLa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84165606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84165606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ozv5IOLa
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91befe703c4so21028636d6.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 00:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793000543; cv=none;
        d=google.com; s=arc-20260327;
        b=esHUcpqd1NFYui7mThkGejSHUJ1wv8L2Uh0EhswEzr2txcuS8UmIbwJJ5DZ2ULc+3X
         3v32AMJ0vckCq+p36vSjbsWzsD6nzirms90LT0qzr+WU+uFD/fgXV0esoZtmQH9+f+pO
         BM1wEOFIsMf7E9XdugDfR+j9FvrdVZnmfFu7IlVXnsGAZbLNLDOvNYQlSWHO3ya+YJvx
         EHA6z4hTItEe4Wvr6/St1yVZT7NwQYWCQGou25ppcWIgQzVhVX94GLdCncEHZGvlQAws
         KzD/HSqaLn1j4+jJ5o7ObroAR6G2dg2axr2SYsR/zt5eGy/EsBW6Y7oVUL/a7QfQmygo
         B7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CNn2YxFJSXifftHetmM/NaZs2A9+RrVDE10/S1WyxGk=;
        fh=fvyVEOpvqwClv+9tWyxlbG0RLWDy+OHJdJZSgiBEirM=;
        b=TGTW/n75iLqH1e3MNeOwVyTIPd9ZCk7PYojCN8HUkmUTiFkAnPVdYFH0d+W85xbMeG
         FoPb7S0zo6NRkA3q4Dw3gnbwn5KyVTm9xSktthQqdb6m6KfE/mGm8t4Ms/6mcaeiUbZw
         xTtGBTKTi2b/CnRnrzHPXD4Baobly3VXwgsYQ1STio4mFbQNeIGDqNlrz4Yd3XsXFXGZ
         T7vqZyeOuxAWXXOP8DviGAx8EL03XrItAKV6/E6AQUEA6GT4t95glmCr3P4TNifVOAsH
         ibSAmltzn+nPTBKT7ccUbRJkP3QtbTH3B8upEKCrTWbiHeoKDensa0a+JM0bDu3TpmfJ
         LaNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793000543; x=1793605343; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CNn2YxFJSXifftHetmM/NaZs2A9+RrVDE10/S1WyxGk=;
        b=ozv5IOLacpekcXW0SGGYNEpqPr/jGZk4cRdqTXZv+zkH7MEgo9NoiiJ8BFva/KYCBs
         oIvAmAXKyN2hquyraEAMaPH/TIuKfSWT+yhEe7xqIQoq/hX0ZzFD/mKcW3l7A0p5JKbN
         Pv/V5ZzGzqzIDikRq+eCWdRcPna79fCTNTXyYzjHgy2rpBjPIpSgplm4vhEPY/rbYZwY
         XQwkXQKR71yhmbrHNKo6q+ce49/c5fzdm6N2DC5cr4xcPT9IK50ODK/im+tW8lNB/d8t
         TLQ7PZW6JBA5C4XYImHsMJ639h45Oa0ys75wFl5LH1ge62L0XZTGP7MLlaSP8j/pr8z0
         6Ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793000543; x=1793605343;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CNn2YxFJSXifftHetmM/NaZs2A9+RrVDE10/S1WyxGk=;
        b=Cf1JPWkmcgcCKALfJo5027gWHsV/otvzFRdehG1C450rnkItDy3C9xb5NIkrcbKAbE
         4AWGB1++5auoissANzeKq641AnuYxShEqcgvQKZakI+FEGO+z8LX4UFU4MKeMrNjhzcn
         NhHMFv4q3ujntU5V5tgbIuKACs85yppQ9Galp4fWihgncCQc082nmaqnSJBHQiWXDdHN
         +8ZEstmht2kXrncdpmgIP5nDFIuXlHssagKnOOfAM6uU8th+bwxXYO0upS+AtpeZ5RQK
         wnpWqccmB3W1jP/Y3vwXDoojJ0wHUdZd5Hza8cDQVAWpxySfvCL1zhYPFSayLS54WO0p
         6B0g==
X-Forwarded-Encrypted: i=1; AKwUvBxKTSRkCzHUGiyZunyQFq47fPlmZGfh9lXYgyR+Dz53a96ukrNObkQ8XjkPAHDBTHWiblg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmw9w+fLWWGfwjVeJYluO3voNfA/L7SAEEfn5WWSc9h3vkf68v
	QG3kncAJZ+bghYy8xLWABqyPNOwqShG4cHLB0lPrRED6zq9xI/gP/UIyCGbNtwb8napsGrgqM/c
	GV7R56H2Bv7J9OG+7+i64jZFZxxfQ+kQ=
X-Gm-Gg: AYBFou3vmsvZMr0nCV6Wg7Y30IfFZ9kGHKiQW7th+x4q0OHUDbeu75fyVLfDPbylyVG
	Lz8lZqdHZABN4mynTVibRCawqEHhpqhwzo0l+m+hcRZwH4/S1HamAApnYquKUaoTPL9bfPTVyXJ
	EYGg7RU5cZM/UhXtBqO6RZm9udZBbU9nobzScDDQdAqds0FyCYi8kVj9KDoZsQ8w92qm1T8TKpZ
	iud7o4f+A+3WVqEDDKVjy2n9Z2FXCWD/XyrWSG2SgqP63WEQOu4zi8x0i5Pjw4T4QcfLPQ9Grc7
	7M35APcZUBI2CJhCdwOWzATF1yNhjS7cPvYJwBts1lfitaD/ikWb9JUSEoVy3bZqpNaYZMB2+EZ
	9YnYWG/5dJFbqmp3UZH/JAdYSS3OFT3tykeHiBUeTrUkyzozKgQ98FgrRrvVBXq9fOJfovK6/gk
	lzQwo7wBVC4ccNaYA=
X-Received: by 2002:a05:6214:2f11:b0:917:8a83:a15c with SMTP id
 6a1803df08f44-91c48e7d7a5mr91741676d6.34.1793000543346; Mon, 26 Oct 2026
 00:42:23 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>
 <at79nEHLDrcoCgn_@pks.im> <CAHwyqnVVCp9ovsHDtc0pHYrFvpmdJq74gyx9yf3+ZWkL+d=CVA@mail.gmail.com>
In-Reply-To: <CAHwyqnVVCp9ovsHDtc0pHYrFvpmdJq74gyx9yf3+ZWkL+d=CVA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 09:41:45 +0200
X-Gm-Features: AclHuK9zbBj7DZjlB4VDGKrk_tHCZNq0biDGmbOS8dV-898go9yuyUSEUfcERho
Message-ID: <CAHwyqnVGpc5ro+TksGGv4sp_JT-_ntuQjuXfVPSaeW+BYu2Pbw@mail.gmail.com>
Subject: Re: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit fail
 to install
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > >               wget --quiet \
> > >                    "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" &&
> > >               tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
> > >                       -C "$CUSTOM_PATH" --strip-components=1 \
> > >                       "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
> > > -             rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" ||
> > > -             rm -f "$CUSTOM_PATH/git-lfs"
> > > +             rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" || {
> > > +                     echo >&2 "error: could not install git-lfs"
> > > +                     exit 1
> > > +             }
> >
> > This could all be a bit less convoluted if we had `set -e` in
> > "ci/lib.sh". But that certainly is outside the scope of this patch
> > series, so meanwhile this looks good to me.
>
> Yeah, `set -e` is a gem of a command. Would be good to do later!

But wait, we already have it in "ci/lib.sh"!


Harald
