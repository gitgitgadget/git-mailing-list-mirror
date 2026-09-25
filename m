Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C28B33F8AA
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354185; cv=pass; b=L/WzYP/m5Ev8QMG7EBVvW37mkkZuaQ7YU/a2npPGYvH85SCwkDM0+wDRDoR+u/JILTcXF6LeYzIus58aAaHBSBMB3ZGaggy/oLPfxRIzoTtq5MPiKUdp0k0zf6WLGo4xSPErHcLuVKF0harzNhIayTXmOgTvwmqYBpWEughTl+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354185; c=relaxed/simple;
	bh=ViAHIza9YviYRmvTI7L7iHnHLaIvP7sS6SwibBvzY+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azUco10qPpSCQ/BbuWZ3hnHzK4Ju0I46kWFsX/wWTh+C9qCDDovimCJuAp4HDRIh4+vW5DzyIO197yX4jxGsAo7mCJlrcWpFRHM0lSbD3mRKgkktu2q5N11AFSbbuU95jPZuIdrRJ3r2Rkmeqcvc6+4oSo9jUJSB9vjS0nKRQQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgTC9GGq; arc=pass smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgTC9GGq"
Received: by mail-pz2-f39.google.com with SMTP id d2e1a72fcca58-88103e47f72so241497b3a.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790354184; cv=none;
        d=google.com; s=arc-20260327;
        b=rcklz0A8OH3EiMPNZGLR4lNhcn71C9Sw193WsP7FpUMpmXqZnIpnjw0BVDOaw2Yal+
         LcLcYtQZOw5Zc1EkTlRcPa/M6eyfnoW4gK00artT9rQ1qcMz7pgKBmwlvf4gq/FsVHi8
         T31VMpX2Z++mUeFJ1w5WkoDYB9POaPx8Q+0J5OG92ASK1aJDxAhqjoL8dBRQl2zGnzFD
         od26aeYVVWBlorKA1AuE/+c1xfI/J8ZuObMXaCbcGhgiFnJ5GQ2705u4s/MO+sm/hXR7
         uKK4y8Eac7kgaD1f0FmPxi38mlIuXlvO6nnWN6jCghrRfCTQVaifCaswrYwQCm7kaACl
         maWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IjFGRwxkFO25/b8agRsxRHuYHwyAuFSFjqeVu+eLPKU=;
        fh=SMcdeyh5Ydll3uJ2fNj3zdbWH6sdNhaXZDFdUs18jPo=;
        b=Hj8c/oHJ35pdi0X9i/Xx4gnV5zsWe4otKVzwKbX4fCD/KDc1ooUQAO852u00jw4UfC
         8m9ubUPudYHCCNqGn4j+sFXNRtclnkLeJFTMhaIBdWpNRZUOfQMxpaltNf/b5sxOWafb
         jb32NT/UiqCZawcNR+WWuehT13kp+x5ZWAqzcZONfq+/XMhTga3tlkqqgtUSGrxrk1he
         fUdBOfWtyRs6LjuBsnKvG9rMdeBYRqbhnF4YGLidpO7CGasQvoOvWrDHUMZeI/OCdlN8
         5KTIOeYaOV96CkU0b6nVEg3I4fQKqws2hNKzYg2xBOM6gcQDg1h5Y23A6K8WsicPtOiY
         0JUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790354184; x=1790958984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IjFGRwxkFO25/b8agRsxRHuYHwyAuFSFjqeVu+eLPKU=;
        b=PgTC9GGqzsU0CvylhDlOa+IDR+kVv3F0sX/bphbE7C0ne1ucthcndva9peKSkEfz4i
         PkAL+pv/GRlvCWjebpgucCR67ggpXypTvn/sfLSBnbI9T/SwiUZDHMsngV5cA9WLJtGj
         VyccUjjX/Ah59QagXjSMWONiQbcx4Uzne8lycvv570wzbc5V2TsMWRNlDrlEqX6+xCwJ
         72MUUD2M+Qf7CV0SMo7HoWMnTmtAUEFb0lDaHQdFVQlIsXq8+OlP/BQyToW65FC1mCiK
         djSzK/euNPWoD5U3mj4yL+tu0moJGM8V3Y2G6azL1Sn5oXqF7bOE5NrdgtHOgxP5pU84
         vcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790354184; x=1790958984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IjFGRwxkFO25/b8agRsxRHuYHwyAuFSFjqeVu+eLPKU=;
        b=o8s2AcDfXYguAjWJ+3CFrcKWIsnZe7do9CQnhniAtbg4ZxN89RPSOA1xJaF6gOLDEG
         9ouJzijEpsURkTLnQzbuSO9MOoxt9OHgaxX4ove9enQ47BF0cbA5OtiqFfm0BVCxOMrH
         t/B9rW32FzXseSeasJpvUQWQ8Xh2OG24xYWRyz94ngGHd8ijEWN5m8CE1C2DrEG1FTDZ
         WGHgPoAkzqczy1K0nOPwvc3QpyxDB/Uc9u42Fsu/aMi6KEZ2u0HgFCfhaBDW4Wk837CK
         +3KsjBYuAD2Mjd3I4WP7sJGFgJpnn3/D5yzWZ0YANk0NnGOTef7HHbH8Bvv4lJ4vmqRI
         YIuA==
X-Gm-Message-State: AFuF++nc7Y3Rxtj6VVxB2z8lGaHHXEF2qZBoYlZ20A8NPKHSoB7gvYy+
	G0J5XmUbkBGPeCXpIXf6wAR6t+ZW1dr7ytyDavasM/DOasbIr0Lh2C2lMOiPVPOuvs6jod4MC2T
	JoAN20668bhvBfn+z0RXNQhOi1JmwrXBI9GyI
X-Gm-Gg: AYBFou3mmbS/vQiRX/BAnLfCIS3+xIcD5Sft/LyOlY3W+1CPnU6y682/vFc3YMYT1RE
	pV8KJJ/0P+UaOMTwrJYVLkSyb4FKJsF2K+XLzuIy6+6afwzMicKB+dx0QnhRc4J1+M+X0gbA4vH
	mc6zmAguMNgsxnkyuOOIzXtIHB0FIUCNKkcI7tK2pspoWtOrZe739qrtcP2IKgLiy9JLh4YJ/f8
	1o4zwEAibMktwHRxXkxN9qu5yntss0lJw3G9h0rr6BYDCcQjNdN3+D6A6uRNja8CSFsWhMEpdXR
	3p2gQs3PqOmDT1AzkU6lkLkbQj59wMPpNW9VqGKA//StPmN7H45IrXafOw2ZBEW3ymEP+GJt99L
	ahe1UgkrunYi6dkD1/ayyr1P9DS7GHGCWQM1BE6ZxNSYkR7BHoZMqsQhTEb+L1iqXvBcaaBD09R
	iyvM0OCjPM9wzFRphqxYpkhjdce1jvFg==
X-Received: by 2002:a05:6a00:408e:b0:874:d464:d541 with SMTP id
 d2e1a72fcca58-87e9b3baa33mr5533286b3a.28.1790354183783; Fri, 25 Sep 2026
 09:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com> <a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
In-Reply-To: <a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 25 Sep 2026 12:36:10 -0400
X-Gm-Features: AclHuK8rmpVLjMaAY2CJFe50A7TWSo0aSYrSzsFG2jy4fP0QV9O3j3-1t1j62Yw
Message-ID: <CALnO6CDdoqE2hyZMJg6OZkzNtcnjNXRz=HO4q6cZVpF_wbTXyw@mail.gmail.com>
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Julia,

On Thu, Sep 24, 2026 at 10:46=E2=80=AFAM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> All of the info about merge conflicts has been moved to the new guide

> Among the changes made to the common ancestor's version,
> -non-overlapping ones (that is, you changed an area of the file while the
> -other side left that area intact, or vice versa) are incorporated in the
> -final result verbatim.  When both sides made changes to the same area,
> -however, Git cannot randomly pick one side over the other, and asks you =
to
> -resolve it by leaving what both sides did to that area.

> - * Look at the diffs from each branch. `git log --merge -p <path>`
> -   will show diffs first for the `HEAD` version and then the
> -   `MERGE_HEAD` version.

I think these are both valuable pieces of information we have lost in
the new guide (unless I misremember just having read patch 1 :).

The first explains a bit more about what a conflict *is*. Maybe that's
old-hat nowadays, but I think it could be nice to keep a statement
about why conflicts exist.

The second is a very useful way to get more context to help resolve
conflicts! I have an alias "conflict =3D log --oneline --graph
--left-right --boundary --merge" for a similar purpose, and I think
the new guide should help folks discover --merge. Often I can get a
better sense of how to resolve conflicts by comparing the original
changes on each side, or I might at least know who to ask about what
to do.

--=20
D. Ben Knoble
