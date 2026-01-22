Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8921146C
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067225; cv=pass; b=f8497b6OW8y5IwVq+P643xxFjbmHy869fqzXelKE4KWgeADgGAJEA/YRlbPYnR2+T291S8G8BZIIawXYF++rnt1aThVNeGxqjHdrtNyFHeuChHkBz0ld7GXszw6N+ioV6OXy/ebhspLE4vonHywV/tdBfbFAglGPX61RJPGspwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067225; c=relaxed/simple;
	bh=e1Z0jPSfWjywObc4Vuyda6q0HTnV3QtO/D+4QxNy2Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjE4mbboFNofaO8bLubgkWt8zLO83uHivhoJker7Pzkc/f2nWOSLlGS43HLYmA6TQ17Pvt2wCOdQ8fQrTybkzKfnwMIZ14UKWzKpC+LbEyoixGmsbFK3+o03jvkuQyZgohfeaal1/qbQ01cdTMpd71NNT2ycHNhKeYSRIu8uyWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLyJyt4t; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLyJyt4t"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b70abe3417so1470926eec.0
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 23:33:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769067218; cv=none;
        d=google.com; s=arc-20240605;
        b=LzT7ue7so9Lx76GGo4BTlNi6ive8j7AuyJzpyDZJV+CLGIyW1qUdQ5Kyda979AFL2j
         bKAtpbY0mnyOdmNSanRcqX5yl2Es1PllzlKN7H3iuH5BSb6OF3yE1o9Xn/e5W0ILEotL
         qPv57VmwcIOjPxhY9UzfM0PEHorUMsddQo9pxca9xGfOdN+gjwKo56cN7hX0faS2+MPl
         W9jouIZyfD4MNPSYQ3mEahsSPpoAEysQ8FR7ukn/s/udJdEqoHjPvEzLp5jdnj0V3dHQ
         x7ZzexXI9Df2gNSKBQ445JqLpnhnJ03NxJkAR9p0+Z9EKjQz12wtOmG3xYxgoYVU5LQe
         80AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e1Z0jPSfWjywObc4Vuyda6q0HTnV3QtO/D+4QxNy2Z4=;
        fh=CuOMDXva0hX4IonyewxzGOayPUk/ZrtmeAamvO3Qh98=;
        b=dYw3ekhMOCfJIMImRm95dQnUE8ZMKR3s8OsTndUGf0q150qfgpyf5XEeNNe68BEEjj
         DdB6FHatn1VaIC0X2BeUSAGZespfecGt8/i/MemYgz8iX9Kijx1QlJiekW4rWUgBiwWZ
         cIpfGAmWFu27RHfCwilqq7prFxq9gGNH80EBuqhEuyYHtuLodW4PdcvxYFAI31I9Uiv4
         iZAnfM2ABvAqKFBBBum1iVT09nLXL3Xj3ZoNgLBYSpodVQGJ1hqnFUZ+zwgHFKlh0fDw
         tt6na5wehF2y3vGdgpks/9s1cqRZwSuenXuRjCqtFZU64khE5zMYX20Qid+0aL5i/KgZ
         jVgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769067218; x=1769672018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1Z0jPSfWjywObc4Vuyda6q0HTnV3QtO/D+4QxNy2Z4=;
        b=YLyJyt4tTb+CQ+0hKM7KMTxbaCWqq/oqJEZlNQhGKjMAYNdAL/xwdLtbnF+vhDfjOt
         tiW5QMywadRMhRky59GLeRLIKJaM6MvRHU7fjSsPYIA7ol/M/JGA4lqitj8qhTf0i8Rq
         ojuCTYc7Hp9Mz7O8POdDKr1ru2a0laAFvSIwZHQFMHbYQe99bY3WaqZaqCOy+H24n0JY
         qsNCiWy0FvsTZdTz1cdxtCVfeAmw7nMxvY+YJzCxFwHOVD1T5sUZ0lDqhHn/J/Q3WA90
         b2R3tH23O2rt3VCEjl5aLD/RYgk5k26pas1HE5HlKheq/pcweVmxrXgPxv5cuKD/DXk1
         hFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067218; x=1769672018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e1Z0jPSfWjywObc4Vuyda6q0HTnV3QtO/D+4QxNy2Z4=;
        b=LimKr2/+r2tiXLJ5Hd/7jssOVpXSrWFiFB3O+rCjfIIxa0aDPXkW2Nowe3ACMiJaiC
         uTYHUk8rQ3oBdW+aevxhXVMLfk4PFlX80meR2dKHcyI2G++fq17O2Cn9DiNEOSkFXDzb
         74jqv8NGdvlG8C2PgWLBXznbt/6DzrZHUtk0AGFKZRc8ac4yQEjm+sT6tylbOVwQ6uE4
         /nnNQ9ZZoEvAbDMF8NhC5y8Omr2eh0JGQR4zSLgVTfu/BqcTXN8gx+ABvBY3dnCctYjN
         XHJbENSYrreUxgqJhPnc+TLpO/jAfVrWioUq01S4x3+J+2jy4U7q7xcmPs05eoa2je/k
         yjsg==
X-Gm-Message-State: AOJu0Yw8i9S8GKvpludf67Y6q+eJ4wrlo6oNXKzXdn51fZRjTtCgR2m8
	eVfJeSRJgKffvkH0si8CId9QX/b6G8NtUzS25DBLszLlZovNp8CkL32wjvVKltIdnY0vEdcNt4u
	07RFnUj40EZAhE/R+oc78eGPgk0EjBIY=
X-Gm-Gg: AZuq6aKRTIeE8iP0G2jdLP/QnRcNCDTEVbkvMjRjV/w7YxHveKcr8n1furxIPrU7IcC
	N2is+18wd/hFEXsy7O3YGVv7FSuAKo3vnSa00CiCEwM/z9JazfC3JakwDdBfomjv/LEHELqoSA9
	TYE7TOMp0uYC32Ll2XlzzaVz1qVqZOy4wRgjz/hTZvzwcyH4U2Uh4ZQ2lXuwZPNcl4+y126yO1i
	H64kez/Mt0+H/8JRT0nQdI9u4YeLcxezAf3io7obKYU3eQPiluJs5kZv+D2CiwMAs7vyzBi3wOv
	Qou3sSaCBCMSztHkdKoMfgdS9rt7eNpf/I1DF8pdqiYW51ekUuRJHySe
X-Received: by 2002:a05:7022:1601:b0:123:345f:5d9c with SMTP id
 a92af1059eb24-1244a6fa70amr14843052c88.2.1769067217906; Wed, 21 Jan 2026
 23:33:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com>
In-Reply-To: <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 22 Jan 2026 08:33:26 +0100
X-Gm-Features: AZwV_QjyBTKw4axcEcM2E7RoOgSOzYwrUaNq00SZ-UW_jXC6IhHXQRX0oUzdcAA
Message-ID: <CAP8UFD0kEATc6sU4r2pVq9k2X737Tk+_VXrxXx8K=M6=ciL=vQ@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git <git@vger.kernel.org>, karthik nayak <karthik.188@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Meet Soni <meetsoni3017@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Bello Olamide <belkid98@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kaartic,

On Thu, Jan 22, 2026 at 6:08=E2=80=AFAM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On 16/01/26 16:36, Christian Couder wrote:

> > If we want to participate, we need (co-)mentors, org-admins, projects
> > and micro-projects ideas, and we need to update existing pages or
> > create new ones on the Git Developer Pages (git.github.io) website (or
> > on git-scm.org if we want to switch this to it now). Please chime in
> > if you are interested.
>
> I would be glad to help as an org-Admin this year too. I could act as a f=
allback mentor in case any mentor / co-mentor becomes unavailable during a =
particular period of the program.
>
> I also Cc-ed Chandra Pratap as they expressed interest to be a co-mentor =
before.

Great, thanks! I will add you to the Slack channel.

> > About (co-)mentors and org-admins, Karthik, Justin, Siddharth and me
> > have already expressed their interest in (co-)mentoring in internal
> > GitLab discussions. I am willing to be an org-admin too.
> >
>
> Wonderful to see that we already have 5 potential mentors! Keep them comi=
ng! Also, it would be nice to hear potential idea suggestions too. The more=
 the merrier :-)

Yeah, project idea suggestions are very welcome.
