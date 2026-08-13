Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F03E49FD
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657245; cv=pass; b=ty0lKBIJKthRWKoytih+P7bOLSIDR8n+KByPW9BzojItFzcLDUMhDImKpuW7z33oqV4VoKYYSsCZr1PW5D6LYtuy0LmvssEJqzJsv6pFgkLWDIBMTF5LcZ38tpkSgVa/NoSLeglOnMTTMzIN18V8IaRGDRdoK0CZm3uwhePW6Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657245; c=relaxed/simple;
	bh=bHTC/alK42t//7LY/H53X3K7mgmaBaCIkuMzMWJruCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMoRuDnMVj8Mn4ppDQR2OLGof6BbuajUHK6VJ61rizitKd5S2b9VoOV9fhbf4P7Q3ElkoQe9QQ+nFb7malKWRx7LY/jgH1Is2+KHYF6WUcXBe5NVpYLFJeRYBAtv3bJhXd0gOJD6BL3SNcNJn51O+iBdjeeJKLWY2LEC7AyTTwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWKGtDD/; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWKGtDD/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ceab75934dso5155645ad.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786657243; cv=none;
        d=google.com; s=arc-20260327;
        b=pSZ8Sfqs1gsk50qf1liy07UR0b1VjwTyxjur7oBfhy7Letz1Hol7RUXk3AYAN1Trbi
         TOUs6bw4+BRzvmXGvaHpNyVVX3W0StMAPLTTA6Olvi3I9kEOz7cmAXay9hjrqGVuQg5N
         x131zeVeeiNJ2Wpvr7uitvNegvfVTSdvEnnCrlBk8C2yTVKPBdbBvuV7GHimNtj7hWhS
         mrxVOL0o+9lqivJPzvlhQBur1vN8CnmiSjqyjayiQATKj8kOEpZcGccCc7HBYoVujsnG
         VtQ6VdW7X7Dxip5QthlCzV3KvugUnlEV/yyB/ZyZs0XwYrNGcx6tOswwL/t1WZbgGErf
         3nwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bHTC/alK42t//7LY/H53X3K7mgmaBaCIkuMzMWJruCI=;
        fh=L/Q3/+SSNf2mBcOF000U6fnByE3XQW5Yj+lAfPuq9Dc=;
        b=daUj3Sz9ZtjQRbcb3bD1eSpXq3GZE3F4yeGtCT8LdpTAaDlfwWXjOUSyUEdhZ2Xsbm
         g2hfvRdO+UuP5KezILkyJKnnPCmJHHgvWmV8Zv44P2oeXtMpnCFQ33omyOUc5Mk4Q83D
         uUvGNdV/K6XuMywIHZWNwy2nWA5ltkKUqOs4xMMzmvjqoyR+D3Y7YERAXsw6G5ezKCKx
         mP/HrHlKiw7yjrdoo9NFaRM5dWgd1RfiJMISShat9wgtiCMPLgQYI5g+0ORY3WtQdtCi
         5hSl3V80sbI4gwPiDao7yg/1TOc+MpJersL4l9UW2t70+h/QdhTXeAQEi9VT8KGcyXsZ
         FEEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786657243; x=1787262043; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bHTC/alK42t//7LY/H53X3K7mgmaBaCIkuMzMWJruCI=;
        b=PWKGtDD/c7vFe+Oex3HKo7Aku66asD0w4aOsGyRwxa6Zanyh6SAxDcpLWyGJu9tUvE
         QrwW9kFtgBAkELDHbN7IsTkcDxYxYOi43Zi8T0nRkwL5bJGlS96S6Yr2gQUO89L57vXS
         GkmYj+yv8b3G2I4UHcs3fTqjCLxIY/HQDb2gL2qqMxprM6FkT80pscrKwAcIQYHU2GLW
         Z/JZRvZBVIreZOpS6r9umZbuVudn8HuD/r6/lDsm4YVdKFxuFYmHh/c0tOQkxgKDiMkV
         zzV4T1ZtFgFHU0bX2jeO4I46QHBDzf1uoHu32vnTZQIVj8i5ITJeyYRh+d5pb+IvWwgc
         PYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786657243; x=1787262043;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bHTC/alK42t//7LY/H53X3K7mgmaBaCIkuMzMWJruCI=;
        b=COTygKghVtgjtDdfBMNzweweGJ6E1j0+jbFIOgyhm8FFj3LV1t+K0W1jMfE8J8IacG
         qh+vvbGG02QeVVAb7haCWK26ouwFVwd6u0hVzRQ9FL2ttwzgewFKK9lmmJa3U6xdHIyC
         v+g79RgpdmmtMTxM48SXt1KHres+ZD0+g7eeFY1atyd4sezAFTuUDe/dLyZStMmsqoYm
         swL6zr3PL5wC1G8ZxGsTZunZHVAImDTlVA1B+0oeibwk7CXGzZF4kxPONuVyEximxPLo
         8OJ/aedQP63/1NfMW2v95DtDf3zgWsKRFevD32HKAYbFd7s2BRE6U2eqxj06byFfstyA
         8QiQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvzdrMKBk/QFq1bWvWh27WbmnZbs8z2rteW5E3UdKmvqwhMtIDgkWEoYsigkKM7q9VmP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKPAEteuKl3YNlRZwU1W332fo3W/R9AuYOBLZKeWCjW8wvCW9w
	OpFgIRBbmSja1bmDmPnyPWuUmWmW01BqgMD/69ef9zj37miLZf7vfR9Z6MhQFnIT/YcZVyMGFH8
	/LnE5zYQk5r0M2D84JhHzW6LPuhc6qLw=
X-Gm-Gg: AR+sD10Wj8sVsTNyPXqWOahSS/UQSgo1MkTggFAkKhWCk0Km9pM4+n5vdBxJBOfZJRH
	keeZMTsn3OMb58ZyUFlCSChT3iMIkgJgpnGPgRUgH/K99agHLShisWeM2O5qNgSWKJnbB+DA2lN
	goe2ruDQSgV2o384DR84MQhLcGLwuTYWFlGQ8t1UkpuqEUAQVP+ByNUy+IO+lUHk5JFYPWOnmAf
	H5Y51DUxFnUNrlnPGFMQa/4RF+cXfjb1FFoh90jTcNw2H/E5LlQIf6f3fDglWYDfD26DSMSu48m
	8P/B0+HnW2o/PbsufjRmvU307P/jZbKzn9g82GK8Xi1QUEpg3yR4gOc7PhHQueHeo2fhz7ko2Jt
	AZa4YB9JbA1IBVcWfiS4xbGEJ1dk0jF3yklpdvMvWGF0olOonfWYynjY6dV6sOKdKYRba0V6qBf
	m5r5rvm1P0FApK4ITppGcgy9TKIyWmDg==
X-Received: by 2002:a17:902:fd90:b0:2c8:248a:5dbb with SMTP id
 d9443c01a7336-2d3b0d16339mr10979105ad.7.1786657242808; Thu, 13 Aug 2026
 14:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <annHlFwu4NKwmcLr@pks.im> <59E4039A-C9BA-4EFD-8022-77C73EB51ED0@gmail.com>
In-Reply-To: <59E4039A-C9BA-4EFD-8022-77C73EB51ED0@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 13 Aug 2026 17:40:31 -0400
X-Gm-Features: AUfX_my_VipciIRwgSqHeOTdBQJ7zbiuv8AcYHcp_shkmCofZOjbNoye4TY_qkY
Message-ID: <CALnO6CA5LdL74SqC9V_wJWi=Pf7+cHBDkuUFAJ7jCOVWZjBOzA@mail.gmail.com>
Subject: Re: [PATCH 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Yuchen Tian <cat@malon.dev>, 
	Todd Zullinger <tmz@pobox.com>, Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 12:26=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> =
wrote:
>
>
> > Le 10 ao=C3=BBt 2026 =C3=A0 08:44, Patrick Steinhardt <ps@pks.im> a =C3=
=A9crit :
> >
> > =EF=BB=BFOn Mon, Aug 10, 2026 at 08:27:51AM -0400, D. Ben Knoble wrote:
> > [snip]
> >> Back down to being on-par with original code. So that's good. The next
> >> version will include some variant that reads a struct member instead
> >> of going through repo_config_get_bool().
> >>
> >> But which? Reading the private_ member is obviously wrong; I suppose
> >> I'm supposed to use repo_config_values() there. Or, rework the series
> >> to put this member in repo_settings. I think I originally assumed that
> >> struct is for things that are settings that aren't configured by
> >> git-config, but=E2=80=A6 now I'm not sure. Looking at prepare_repo_set=
tings()
> >> shows lots of repo_cfg_*() calls. So I think I see how to adapt to
> >> using repo_settings,
> >>
> >> Patrick, Junio, and Tian had a brief discussion in
> >> <anlmwaEtwcCPse1N@pks.im> about the split creating confusion. I don't
> >> really want to wait for it to settle to land this change, but we might
> >> want to work together on identifying the best path forward for
> >> core.useNanosec :)
> >>
> >> I don't suppose it really matters to me which struct I put the member
> >> in. As I said, v2 will definitely fix the hot path lookup here. Just a
> >> matter of input on which struct we want to use this time, I guess.
> >
> > I think `repo_config_values()` is the modern variant that we're slowly
> > migrating stuff into. But that struct only works with `the_repository`,
> > so the question is whether we ever use "core.useNsec" for a different
> > repository. My hunch would be yes, for example when recusing into
> > submodules, but I'm not sure.
> >
> > Patrick
>
> Thanks. I=E2=80=99m working on control-flow analysis to see what kinds of=
 repo values end up there. Of course I=E2=80=99ll also run the test suite a=
nd so on with the repo_config_values change. But the analysis will take som=
e time.

Ok, CI run: https://github.com/benknoble/git/actions/runs/31701945211.
This demonstrates that nothing our test suite does across the many CI
configurations ends up where with a non-the_repository-repository
(ahem).

I have been working on control-flow analysis by hand in my Git time
this week. It's of the form "Z calls Y calls X =E2=80=A6" until we can see
what the repository that's (eventually) fed to repo_config_values()
here in is_racy_stat() is. My notes are one node per line, which
indentation showing callee relationships. Some lines are pointers to
other nodes to avoid duplicating work.

With that in mind, filtering out the pointer nodes, I've analyzed 214
nodes in the graph. If I'm lucky, I'm approaching the halfway mark,
but I somewhat doubt it.

But since CI shows things work=E2=80=A6 I'd rather not continue the analysi=
s
if we're satisfied for now. (Esp. since that will give me more Git
time back for reviewing ;) It being outside-of-work time, I only have
so much of it.)

A few other related things:
- Some of the edges of the graph appear to be public libgit.a
interfaces. That means we can't guarantee that only the_repository is
used.
- On a related note, I don't know how large the current "must only use
the_repository" (e.g., via repo_config_values()) surface area is right
now. Based on the partial analysis I mentioned above, this feels like
it's introducing (or at least contributing to) a rather large surface
area. So, this change might make it more critical to resolve the
limitation mentioned in the other thread. OTOH, I don't think this
change is likely to represent the only pervasive the_repository-only
limitation, and I'm afraid it will never land if it must be
the_repository clean (unless repo_settings is the_repository clean and
we decide that's an acceptable place for this member).

So, idk. If we're happy with the CI run + use of repo_config_values()
overall, I can send a v2 shortly (in next 24h), I think.

Thoughts? Strong opinions?

--=20
D. Ben Knoble
