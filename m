Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3709A3C3F4E
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789918032; cv=none; b=bErSW/YaLkiWYv0sZ7TslWWwsk+vJXJDPp+DStJwW/S+oW0Anr/8CVgdxinw4pwkBWJpWLWmHbBDIHmfpzMDPPCIpVf/dmF2qNxFAYuptOVVYCYahJEfGSElow2FNE97v+P4mi3nzLn38DGpJVk7RZoT56XXi7usqX508XLBnro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789918032; c=relaxed/simple;
	bh=6Yu47KpsEdDt7TmJfvPI4SE5FZTEOsTCoILsv24lgxA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f2+rcHhf78aQUUS2+YwilUJ2SQkXt/R/KVjnzKTKCl7YW95ZD99jcWRiWC4igMEq05TypniAFx7wZNDlGYl+tRIQiNCcm7Qq1VU1DHdOnThT/oMkZ9s7Gvb0HJx+n7+d8UoCDVoLyxOvSoL0WztFHX2p6jJ+Z9gKAU6k4zWYz6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=d0UwBKdq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="d0UwBKdq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789918027; x=1790522827;
	i=johannes.schindelin@gmx.de;
	bh=6Yu47KpsEdDt7TmJfvPI4SE5FZTEOsTCoILsv24lgxA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=d0UwBKdqLIQyoD/ACkVGYRHY7ao4AAEjQNoQIfuKeAOi81U7oJaON4wCqhxdypQ1
	 BqCCdzzyw5B3BLvQGWaXhnRYcQy1uVwuPoQ2YiNFTypS7Oqf2onllaNwdyTrOyPnN
	 n+XSUls+BwmMk+Cos7CrnOyyBBVslqXee0CCrKeqbMBdercEK4kNUkVPtieZRSvRV
	 FOpsutyZ5/XBv9szy8iytLIwoe3RU3fxRTBFxFg+xRMsWd3pRR7qOrhB93iFB7gnb
	 msuCvHyk6w1+uQiF/eClLCD9/ty6Hn1UKycojd339/y0S8ZXxTJjyyulno7XE+RpN
	 fDBGUP++rcozveUoYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1wkPPx3KBK-0155n4; Sun, 20
 Sep 2026 17:27:07 +0200
Date: Sun, 20 Sep 2026 17:27:06 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Karthik Nayak <karthik.188@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] gitlab-ci: fix the cargo invocation in the Windows
 job
In-Reply-To: <CAOLa=ZTgF+Qw_1FMUEF-YyBYo-gKnhPVk+qxd+gt1PMrt9GYqQ@mail.gmail.com>
Message-ID: <6c2bba91-a1a9-3547-4be3-f4f9ce03e696@gmx.de>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com> <CAOLa=ZTgF+Qw_1FMUEF-YyBYo-gKnhPVk+qxd+gt1PMrt9GYqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:6NfANFOdEVBKloNFpePmKvsb3mrJgxWq9mY78vzTfg6720Y272I
 +cpj7yKJOnIm30Axv8+60ZIClwh+uE52ASaf7XNImYxf3hg3XWENaalA69hmTpuYI1Gi05v
 ZyIQiOvpVVFe10/WkgbybLJW5K3DeAmK0YhKCKhSX+HjC4ot6Z5G48246DMNTjry7BiM8Ej
 ICtVMyVF8Sxvhb7WY8NvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RuBo5o3xwH0=;g8HwrxKCy/hq5oTxcPQ9rZpF4BC
 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
 0uvRCuLCitInR
Content-Transfer-Encoding: quoted-printable

Hi Karthik,

On Sun, 20 Sep 2026, Karthik Nayak wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > In https://lore.kernel.org/git/xmqq8q4zosri.fsf@gitster.g/, Junio ment=
ioned
> > that the GitLab CI seems broken since I enabled Rust in the Windows-ba=
sed CI
> > jobs. This patch series should fix it (lightly tested, but I don't hav=
e a
> > whole lot of build minutes on GitLab).
> >
>=20
> I've created an MR [1] on our team repo for testing, I'll try to update
> with newer versions (if any). The pipeline for this version is here [2].
>=20
> [1]: https://gitlab.com/gitlab-org/git/-/merge_requests/671
> [2]: https://gitlab.com/gitlab-org/git/-/pipelines/2863888081

Thank you!

It looks as if the `build:mingw64` job succeeded, as planned (although it
should now probably say `build:ucrt64`?).

The `build:msvc-meson` job seems to have timed out trying to do something
with credentials, though...

Ciao,
Johannes
