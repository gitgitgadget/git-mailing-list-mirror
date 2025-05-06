Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63BA17A2EB
	for <git@vger.kernel.org>; Tue,  6 May 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520361; cv=none; b=fMcr95t4xbxAse9ft86/vqMT4YQBXXxHOGUXtQUOlibdT08L0RQ0Q1AVzpqkIzT/l3zJE5U4HlVOrWeyV9+WS6g+WLdsX8AuL1IrHiVidvsPQMOgL6VScQA7juHRrxRl3a1ub7I4uwLQumetQlw8np6P19Q7EX7XsuqoCuBW6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520361; c=relaxed/simple;
	bh=yffiMytxVnm42lefxUlL2uPvd4nYFE2v+N2ZsyzqJlY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mCu0NPcJJSGDPLQA+diki4hjlLYqvo6ipsrL3+ejtBIni0zqWz+drxNPIcYDAvG5xDqbLEfrNzWdqqULPJxK0MnyqjJMopkcIXjoMVz2UKA8EMkHmkR1VWn1lgNMWRaVbUWBSfyXizgd/6veq1MwRimkAu6KgU7tTEupC6hIHkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=JRhdBtWT; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="JRhdBtWT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746520356; x=1747125156;
	i=johannes.schindelin@gmx.de;
	bh=U3fGEJqY/nDF8n6Q8E2yi5K1VzlixLgc3aYW1ni5fog=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JRhdBtWTzUfbPc5Rt28yLWoWoXxfP4CAjNc6T5Jlx0s5DJC7LjvBSQkajBiLm6q0
	 GLnsAKsfiEjpszBu/RtwdjVp63yudOidkgYAcfMuBlcRCAiPoK6JdOCNVyC1iJP99
	 DVvce6lNNecKifuy9LPwqAkxiNH4kPPcjAp7j1ziiAcHN11DTaWzJebRfLkNlEvo3
	 jzzZb1XEf2DFBlpyLA4sbLmkt0Sg+4bCTvu7YbmC2ifRIcV+fzdnoWXiZ3taHSBnE
	 hBCZR77CH+rL81SXED64CYFewLiCkn3AJ05Dcf8mxsmfIbECi6cy1I1VMq67EDUh/
	 /XToNcuRICUZhZuYYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.189]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1v4BxT3Vp9-013kvj; Tue, 06
 May 2025 10:32:36 +0200
Date: Tue, 6 May 2025 10:32:36 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] ci(win+Meson): build in Release mode
In-Reply-To: <aBnA3KNOfAo9EbpS@pks.im>
Message-ID: <3952ab1e-dc67-c47b-a86b-88b0e8886755@gmx.de>
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com> <pull.1908.v2.git.1746282346370.gitgitgadget@gmail.com> <aBhVWMabOFYRUjvD@pks.im> <5e2fdccc-2c52-805f-ff9c-b9e0e72614ac@gmx.de> <aBiIPe7EVTBxENUp@pks.im> <xmqqmsbroxxs.fsf@gitster.g>
 <aBnA3KNOfAo9EbpS@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OLam7c9UD9boQWS46rrN8l5+QQhHRbVW5BoGqmlFQkvnGYZ/dVE
 57/NscKS5HgO3yKBY0ingvMq/SwPpOnJUph91T0S8HzWUtqZR1wadZS76yfmD6KO7OKYNbZ
 inc+gC0C4LBVmnrJgqAThpk0i92/Ydsd0nXkL2ncob1fr+yjcK+4qp6czTNEkm2W/KBBU7o
 Oc2mMszIxD1ds8/14E52g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HatWuvdG2gI=;iI/akpz1UfNdQ1qCYYfagB1amc1
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 6 May 2025, Patrick Steinhardt wrote:

> On Mon, May 05, 2025 at 08:54:23AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > >> I am afraid that getting rid of asserts in Git's codebase won't eve=
r be
> > >> able to address the challenge that Git -- despite much reluctance -=
-
> > >> relies on a couple of external dependencies that might at any point=
 in
> > >> time cause `assert()` to be called, e.g. due to unexpected changes =
in the
> > >> CI runner images.
> > >
> > > Good point indeed, I haven't considered this.
> >=20
> > Thanks both for a discussion.  Let's replace and queue this, and
> > fast track it down to 'maint'.
> >=20
> > Here is a range-diff for my tentative rebasing the patch on 'maint';
> > I'll make sure merging it up to 'master' would match exactly the
> > result of applying the original patch directly to 'master' before
> > queuing.
> >=20
> > Thanks!
> >=20
> >=20
> > 1:  f3ae94b175 ! 1:  184abdcf05 ci(win+Meson): build in Release mode
> >     @@ Commit message
> >          patch is still needed.
> >     =20
> >          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.d=
e>
> >     +    Acked-by: Patrick Steinhardt <ps@pks.im>
> >     +    [jc: rebased on 'maint' to enable fast-tracking the change do=
wn]
> >          Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >     =20
> >       ## .github/workflows/main.yml ##
> >     @@ .github/workflows/main.yml: jobs:
> >             run: pip install meson ninja
> >           - name: Setup
> >             shell: pwsh
> >     --      run: meson setup build --vsenv -Dperl=3Ddisabled -Dcredent=
ial_helpers=3Dwincred
> >     -+      run: meson setup build --vsenv -Dbuildtype=3Drelease -Dper=
l=3Ddisabled -Dcredential_helpers=3Dwincred
> >     +-      run: meson setup build -Dperl=3Ddisabled -Dcredential_help=
ers=3Dwincred
> >     ++      run: meson setup build -Dbuildtype=3Drelease -Dperl=3Ddisa=
bled -Dcredential_helpers=3Dwincred
> >           - name: Compile
> >             shell: pwsh
> >             run: meson compile -C build
>=20
> Am I reading this diff correctly that we drop the `--vsenv` flag?

That's similar to my reading as well, but...

> I think we should keep it around as it was a bug in the first place that
> we didn't have it.

Correct.

> I guess this is done because we didn't have the flag in "maint" yet.

... I think this is the reason. It would probably make more sense to
backport the `--vsenv` patch first, seeing as having `win+Meson` without
that flag defeats the purpose of `win+Meson`.

> But I'm not even sure whether the fix would be needed in case we don't
> build with Visual Studio, as the MinGW toolchain probably doesn't have
> the same behaviour with asserts (but please correct me if I'm wrong,
> Dscho). So maybe we should also cherry-pick 85e1d6819fb (ci: use Visual
> Studio for win+meson job on GitHub Workflows, 2025-03-31) at the same
> time.

Indeed. If we keep both bugs unfixed in `maint` (the bug that `win+Meson`
does not build with Visual Studio, plus the bug that `win+Meson` builds in
Debug mode), the CI will continue to pass... just not for the intended
reasons.

Ciao,
Johannes
