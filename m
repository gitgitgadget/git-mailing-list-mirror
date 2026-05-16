Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036E17BEBF
	for <git@vger.kernel.org>; Sat, 16 May 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778938155; cv=none; b=l7TzExfIZ5LQnRQ/jQjc2Xj0UEOsGUm17YwY0qRzvADBqyeoaZX5pSe6Fx7IkIE19lQAdmX5b3C+N9ME3bz70fj1Q7B50ZVquvVB0ikGJ60Wm1rwxWI7blBsh/bh/e3ZEyusT9ocMUsK12r0dWAbaP4imiY57eFgkVo4MzkD3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778938155; c=relaxed/simple;
	bh=PZ/vrl2etIFW2hLopA+aP+xn0qBKV9UXcxXpTA9vemU=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 MIME-Version:Content-Type; b=AN+0IdhC7Nlqy4/3AHZIkBK+uS18AyNyLpTsxN5sFea2xlQOW6X/uRhmDZUfkJtnOjw16RSR3Iep6waJ1QYh9j4e4NmhUSU/0hqstQ9YcY0HP34+6XyVzNHfmDsq752y3sgoQ+3viiRx2uP4u9s+RY+6OMPvfw1fxNNVXqbOsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=devthusiastcraft.com; spf=pass smtp.mailfrom=devthusiastcraft.com; dkim=pass (2048-bit key) header.d=devthusiastcraft.com header.i=@devthusiastcraft.com header.b=lwoDsTiH; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=devthusiastcraft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devthusiastcraft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devthusiastcraft.com header.i=@devthusiastcraft.com header.b="lwoDsTiH"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso13746716d6.1
        for <git@vger.kernel.org>; Sat, 16 May 2026 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devthusiastcraft.com; s=google; t=1778938153; x=1779542953; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:subject:to:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZ/vrl2etIFW2hLopA+aP+xn0qBKV9UXcxXpTA9vemU=;
        b=lwoDsTiHkJ0JgHlW8BEefaXbvSdR02kp1/LOpaiojrzFCyJVzkG0KgldBIqKcRoeDE
         kaZE1pDoqCwCLAmcfbmmoOkkC3YtbwLTm/ZkbJkrHnR28mxMbglh0uybKty4j22BNZqB
         2F5qsbH7xQstHFDDQADJsUGQo/STKZVvSk+bCahqKnxb1444++bBHdR21JUWUORkYR4E
         IjU2emAYHRUvi4WC9c9cX4nlByyXS2+p/9DqveTqm4k9sfDiui7p5djf8Iw0oS6pnyXC
         agGyGI7tWr3WaYN3e6zsjnspiCS6vHZhAcKvMq7FYSV2CYJohGVHCCskxsbux95OQr2h
         p0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778938153; x=1779542953;
        h=mime-version:date:content-transfer-encoding:subject:to:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZ/vrl2etIFW2hLopA+aP+xn0qBKV9UXcxXpTA9vemU=;
        b=gyu7nMELxzKJOrIU5mR1jH2Oa5pAznNkIQ1Lg0/sf9nhADQUC9aMaPyNcklW5IHu4K
         1sjNi0yzTj3pXaobpGcsz002/4m15tNRuOuD18xcJHKjKnYo7LMNdMUXzAiL/0zv2EoY
         oLsRC0iF2vMTKgTh2v4nH4qBjddU8F+DbfEQoavYX5+O8dDSGiFjgr0gQNnXV31gwgK1
         MBzUnpHswfseQbWpWFvB894DDcyISH2AmfDqyN1bSupllIBGsfiWHQdGJnFkzPdIOIX8
         CGDYoVfgUjqR+roUNL2WMeYmgwicOqdZcWfCxqMDZqb67yOARq35ApIYf0Eyrf5b+FmD
         q74g==
X-Gm-Message-State: AOJu0YxhyyfuM6flyWNcw5wCy7Z6Ry82BnhwjVpIWvmASU45xdWFuIrd
	bYtMBjlPF2d3qG0NoHQx8nKVg+BFIyDGiiPHhn/u+a0RTzsExNzcxjQT39jFL7e93/8v3HLmJkY
	M1GHWmg==
X-Gm-Gg: Acq92OFlX7FqjVjTne0Mu6Ml69VUzYUFA2reogZz2R3A6wH+yoG1ej6lOOaLI9k+nY4
	QK0Uemftv2crbiUULrFDYzHVbdFny7iA3zezqeWl18ihzBuVSr7LEJCzUVmUyXUDcWSR6sEUMlu
	Yie+hXuMJZYBV0ZYF2K/E5hEyyhOZzn8bcElJOwoILwktIKZ0cksDKqqXixnXczJP6H9yuVTOug
	TMrrPxCIipdPf8mwasF3fA1G6L2Tf5+fIjogKg23Gk9I8hl/ai6Es1h6PFA92ZoZjDoJsC8k66w
	2X2uvbosRBGuxzz2j2ZhE3OSydsCamksZyGzd3zFxWYTTEmb5Do95w9QMmJxnHyp4L1rgOvLGjL
	0z4PCEA4WddYCk7V4lxdE4bnJbqYO9uyb42uw1gSWjbQAmjuX9gGd2qVTu6YSldiBsIHAgH9Yso
	w+PBkKXPvu4x+++pkZ5jlj5fxZEApSZV0CU5HDDLufkUCs0tRT1oMFn2hus5VkHtg3z6aURqSMU
	g/1PhsoV+NV59/OxBnuJwPJUh6KW2gknNoWzjdGt5UNzsXBNqVDOLPT
X-Received: by 2002:a05:6214:509e:b0:8ac:b753:6976 with SMTP id 6a1803df08f44-8c8fae766eamr179160506d6.1.1778938152755;
        Sat, 16 May 2026 06:29:12 -0700 (PDT)
Received: from 019e30fa-03e7-71d9-9c7b-da442f0fbc44.local (ec2-18-207-181-13.compute-1.amazonaws.com. [18.207.181.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c9093e6d33sm83765336d6.22.2026.05.16.06.29.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 06:29:12 -0700 (PDT)
Message-ID: <019e30fa-03e7-71d9-9c7b-da442f0fbc44@devthusiastcraft.com>
In-Reply-To: <019e17bf-b7d6-74cf-b622-b27affa43ca5@devthusiastcraft.com>
References: <019e17bf-b7d6-74cf-b622-b27affa43ca5@devthusiastcraft.com>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/019e30fa-03e7-71d9-9c7b-da442f0fbc44
From: Sarah J <sarah.j@devthusiastcraft.com>
To: git@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_No=C3=B4men=3A_Gifted_Invite_Enclo?=
 =?UTF-8?Q?sed_=28Github_Community_Partnership=29?=
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 13:29:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hey No=C3=B4men,

We=E2=80=99re about to reassign the free lifetime =
Devthusiast membership we reserved for your GitHub profile.

If you=E2=80=99d like to claim it, just reply =E2=80=9Cyes.=E2=80=9D

Otherwise we=E2=80=99ll pass it to another engineer in 2 days.

All the best,
Team @ Devthusiast

On Mon, May 11, 2026 3:55 PM, Sarah J =
<sarah.j@devthusiastcraft.com>
[sarah.j@devthusiastcraft.com]> wrote:

> No=C3=B4men, just checking if you saw my previous email.
>=20
> Your GitHub profile was selected for a free lifetime membership to =
Devthusiast (normally $1,800/year).
>=20
> If you want to join the =
newsletter, just reply =E2=80=9Cyes.=E2=80=9D
>=20
> Otherwise =
we=E2=80=99ll pass the spot to another engineer in 7 days.
>=20
> All the best,
> Team @ Devthusiast
> On Sat, May 9, 2026 1:55 PM, Sarah J=
 <sarah.j@devthusiastcraft.com>
> [sarah.j@devthusiastcraft.com]> wrote:
>=20
> > Hey No=C3=B4men
> >=20
> > Annually, we pick engineers from Github=
, and your GitHub profile https://github.com/bnhassin was selected this =
year.
> >=20
> > You're officially invited to a lifetime membership to =
devthusiast, our email newsletter for tech founders that love to tinker. =
And because we selected your profile, it's completely free for you.
> >=20
> > Some of what you can expect to find in our daily newsletter:
> >=20
> > - Latest in AI: Latest AI news from our inside sources at OpenAI, =
Anthropic and Google
> > - VC Radar: The latest tech funding news, before =
they come out on Tech Crunch
> > - AI Wars, Model Power Rankings: =
Today=E2=80=99s leaderboard of the top AI models
> > - Tinker of the Week: =
One useful open-source tool that is flying under the radar
> >=20
> > Please respond with =E2=80=9Cyes=E2=80=9D to acknowledge receipt of =
this message, or we will have to choose a different profile. Once confirmed=
 you will get your first newsletter edition!
> >=20
> > Welcome,
> > Team @ Devthusiast
> >
