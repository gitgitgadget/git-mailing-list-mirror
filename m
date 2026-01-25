Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C32725FA05
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769372601; cv=pass; b=iMj2/zbUzOQnTvmfgI2YfqVrwEr6s1I34yElCGY1oAt2M2Mpy9098x0H816sqcLqizGVtrzYYgPHDNW5cZssIwbG2sLCPaD22X2kTOvL88xkyDouzvoQtvhI8V35LGwJtNTQR/XBSwYDw/b7FyT4fLpXNzr0467vRECsPH7s7D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769372601; c=relaxed/simple;
	bh=E8tb/oygs5c8qqBeSrQZzivGbqloxVlbdXmnUI6Mzbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhtFIS5g9IuSpjSl3goK+wBntRTjg0wgooBBupnkH0ow3gsc8DzWTc36C1UBLS/ovrEhxwC50C5tsJU+2/2OmhWbct2Qhs92eNp1oVWOB0Fw+5FULUUCNYMwQ1mLzs+L+xMfW7uI/Q3wkLDkjDoFnVJKB7VcchAjltSbzTvb16k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndnvKems; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndnvKems"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-649523df010so3367180d50.0
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 12:23:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769372599; cv=none;
        d=google.com; s=arc-20240605;
        b=lxvtDYwAkh4ptd3191OrNnzuZcVh1z4Maun7aIr9Kjll7xTOZI8btKj89UZ4mvLiLU
         mrngZogf7VGMe3RhQzJtyMXRPLTnWStnPSkXUnAyBnbhgICrBAhL5VMJzAFVYPFQ/TDD
         hB6G3sohAADf09vQP24iVis7svH/U9O6kR202pE88VTBE5Es0taXwDpFng9A3p7YQHcV
         l9bygYb64dJasYrAMIf0mWURx4gVycCg4iAzz20a594QoHfjM6C0cB/IkgkCBLSfM7Ma
         sZlCjC0ttLe0um1IlRt6Cjvfm9PpSya1NUr564FeK1KX0Gw4di5fbrQWJB1vNXeqO55E
         JNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VifCVUlH01DlyKv/FSXn6bPBaZJIVdf03hovDCE2C+Q=;
        fh=HWyAIkdrobpCAvaSiR+nhPRDu/DGOsKx7ldMDWy/i7M=;
        b=U7SIAHYyIbPuAwQF6M2FMoP0TtVtBhhCHM7yNacN/bw8xC5z6011s4w/NDKSGNQnRG
         BM0Gq4Azyff7tLyKjYHsGsFXvAke1n6OjKYwMKTyqa2+l1mUykxIR3C2OIWlhqaNKubx
         57YJ4CJ/4q6ga6baVxrqp9Unu+doMwcsKi7vtdeo4Zq5P18nWM/jofwrYTIc7JKqGLm6
         nxerQYka4e0+an6aTI2zrLtcCqLBZgGar+69P2rVGEobqmeA/Cvxg/d0aB6Hc3p8CVED
         XtTEwEUMXBsu0/e22G87DF2i3y1itIJxFmoUV0GGbS20a4Qp95Jc4iY+vWgdx/lXOMOH
         yphQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769372599; x=1769977399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VifCVUlH01DlyKv/FSXn6bPBaZJIVdf03hovDCE2C+Q=;
        b=ndnvKemsejFnGg84Th4/WQqHerq9OBz7oWFQoF10RsnLkNHAlauD4jdYFZXhGg2g/q
         2zK1wb1IxLoCwu3Dd8IZEyvfIpU8lH/cpT7Nzqv1pgUYYzo74VAnF/5gOyLpY9DGFv4D
         zlCC/t3LSHn0cU2yBt/SF2HADVVVq7W107EB8UZcKHHLQS3Kyeh1MdYKBLfnhiSjfL54
         3UCes0wpXjVkipVthzoAbqwiWdyNa1+7BXvidYhqWIZ7SGdw1A59bs0jWJ/3emsMZvhL
         f+0clFebJyZIOU3zcDAe/KFlFJDkJrMuDChIQgHd7pI7Qlg387Tz1RXo0K6CTKVbi1wt
         Uy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769372599; x=1769977399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VifCVUlH01DlyKv/FSXn6bPBaZJIVdf03hovDCE2C+Q=;
        b=PKv7IwBROMLXbUSeEBHsTmvlIhNyx3efhDc5Hu/V45maf4cAMJ70X8U452cEjsXFL+
         eNWsInhd38Idjoc1fR/5p0HklJIBwnCP5CE60H73XHNOuwBuATFz+PXEHAs3kACNjz1P
         O3liDSKtgAiR+GjzAF5/XtepkacrK3WcPW/BqIItljEI/biMr6HUQJQI7Zb0dzchIVqQ
         LLefKUHLNpDr93KNNb1Q678VBcFpY9YCH85x/4PzGzQ/5ITnWfk+YlJxw3T/n9C9Svab
         rn91kzFdd2/OrZxwART1NcEsCCcb0sS8qut+RXaua7urj6VctkGP4KYnftSxvTgDkuTi
         C+Ew==
X-Gm-Message-State: AOJu0Yz61Bq7ZqTEP+F+T5J77YQHB7FQviEF3NN11ZDGyUDDsX74mOcZ
	vBx+fZWM49OCMt7vEoaF9LAGEJhXpIfSbHeSWDN3ebbVAHkMUBHyp/13Y0AEPivDV26wlCImX3D
	j5rCQ/mXmPbUesUTSRmJ5Ol0FgkGPkEQ=
X-Gm-Gg: AZuq6aL8J1cd/GAUG5QBnyyAptLQW9lKKxrMR6XYi0ZfZ8yWgl74Bb7JJ1zpI2c6XW3
	PGFDWl+MWPINT+qBHIZZN13DvTAhottU1k+47GiRcrBzhAD2sCK9IZS7tjDjUpLiq7UVllWkw5w
	kkz3NUY+9ERSHCjh70TdeTzUgPk/xczdUMmQB3iumXwp5m1WG8e/l+yh+dBZmbMXjcSY/ERQoKu
	8fyrPVeW3/KJlfHmV/2RlRhKQB0AwvkSkperKcQFgEJcuDbUWFKS8rsRzaE44/9RRNeQ5SfmwUF
	02znxG0QLoYY+ZWp3UctapbR0XhS
X-Received: by 2002:a05:690e:4188:b0:649:69a0:e0d0 with SMTP id
 956f58d0204a3-64970d5ff12mr1768197d50.90.1769372599458; Sun, 25 Jan 2026
 12:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122171523.94234-1-amishhhaaaa@gmail.com> <20260122171523.94234-2-amishhhaaaa@gmail.com>
 <xmqqcy31l2s2.fsf@gitster.g>
In-Reply-To: <xmqqcy31l2s2.fsf@gitster.g>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Mon, 26 Jan 2026 01:53:08 +0530
X-Gm-Features: AZwV_QiUmB48C1G--nKvTWbQE5CykxGmxhm3jw0yal4XDQ_hc6W0bMTNvWk_ORs
Message-ID: <CAPvEtreqaocdrHf0R+kMxhWXJQnDqV+4jKWd8UHqZ3zzfZBE+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Adding string_list_sort_u which sorts a list then
 deduplicates it.
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Jan 2026 at 03:37, Junio C Hamano <gitster@pobox.com> wrote:
>
> Amisha Chhajed <amishhhaaaa@gmail.com> writes:
>
> > string_list_remove_duplicates is almost always preceeded by
> > string_list_sort, hence adding string_list_sort_u which dedupliactes
> > post sorting.
>
> The usual way to compose a log message of this project is to
>
>  - Give an observation on how the current system works in the
>    present tense (so no need to say "Currently X is Y", or
>    "Previously X was Y" to describe the state before your change;
>    just "X is Y" is enough), and discuss what you perceive as a
>    problem in it.
>
>  - Propose a solution (optional---often, problem description
>    trivially leads to an obvious solution in reader's minds).
>
>  - Give commands to somebody editing the codebase to "make it so",
>    instead of saying "This commit does X".
>
> in this order.
>
> To those who have been intimately following the discussion, it often
> is understandable without some of the above, but we are not writing
> for those who review the patches.  We are primarily writing for future
> readers of "git log" who are not aware of the review discussion we
> have on list, so we should give something to prepare them by setting
> the stage and stating the objective first, before going into how the
> patch solved it.
>
> With that in mind, perhaps something along this line ...
>
>
>     Subject: string-list: add string_list_sort_u() that mimics "sort -u"
>
>     Many callsites of string_list_remove_duplicates() call it
>     immediately after calling string_list_sort().  It is
>     understandable because the former requires the string-list to be
>     sorted, but at the same time, it is clear that these places are
>     sorting only to remove duplicates and for no other reason.
>
>     Introduce a helper function string_list_sort_u() that combines
>     these two calls that often appear together, to help simplify
>     these callsites.
>
> ... probably?
>
> The same comment applies to the way the other patch is explained.
>
> Thanks.
>

Very helpful, thank you so much, i will keep in mind.
