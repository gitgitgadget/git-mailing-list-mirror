Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B41373
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764441094; cv=none; b=Gmk8byCkjVOSO2hi/SybK52bCGA2/hYyJ5CdKWNrl3VP+IQ273nyVXM0HOm2T+s+5txOLgkzUs+nFdFKZr/sxMFbT6TLlNmYyinBKw37ZBn+sks7jTMyXmh6QWNwSfShXIlclp4P9q1Pfdb3J46llZkrPOex4LiJD1HWZYV6rp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764441094; c=relaxed/simple;
	bh=Wyv5foXML2Lh9cG3h3QRBvO8bexM6lt0IGP+pBu0VRI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G5CBLEsZdAOmsvGVsDXHZwI08F7+AmdhJwvuslF6ZZnpN552JsgmJabrJg8GHwFTCHgFDyryJtDvZ40c455TWW9hGVOxxIoupDTia67OdAsTAKQf3l/hGWFVEQ7exrQAasNYrqVrOBgmhIY60US85BVyBVjkzFFUEp0INb/bpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=IhE7emHX; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="IhE7emHX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764441089; x=1765045889;
	i=johannes.schindelin@gmx.de;
	bh=L77+IcLL19if49kutVNsMXRpu9a+EbXUErNQwF1mBfQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IhE7emHXc4TrafI6SaBx9ZGx7cS/YVU1bGV5kRgCzo0uehBTzaqE/3udXuWHXBs0
	 sOZ1biHLCX94GNhbU4rSjQ3Da8Akif7mLMtnu10d4KmlBXUCNSG2g+0wAHU1TXLYG
	 lblJXkv+7+oj5KqSQk0LVwib26rGPY5BxRtdqnMlrvvass1W6MR+8eLZcCb9p0+RW
	 0Hk5N6uh+Xrnv+a3BauXMHfy8mqAVKCCSaNWrqt+JUj9Ys8AeXBXTpWpWcsWGZRGK
	 tfRs2AT77q8O5q8/DRCwT5A9Ij7sgwCerXSP4mMZo9HJOXMyrL3oroU7O3c8E9hQE
	 3rDXq+27yk1dzzPTjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKYx-1vf9CQ1hqJ-00VLlX; Sat, 29
 Nov 2025 19:31:29 +0100
Date: Sat, 29 Nov 2025 19:31:27 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Elijah Newren <newren@gmail.com>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] ci(dockerized): do show the result of failing tests
 again
In-Reply-To: <xmqqsee1rjyx.fsf@gitster.g>
Message-ID: <920c302c-5d36-d5fe-7f19-28a1eb905a19@gmx.de>
References: <pull.2003.git.1763399064983.gitgitgadget@gmail.com> <CABPp-BErdhTjbqDem4Xvc-XbhgLUEpy9-eiaaR1F_diMca--6A@mail.gmail.com> <d8054499-aacc-f697-c117-116729432c3a@gmx.de> <xmqqsee1rjyx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-957838429-1764441089=:6155"
X-Provags-ID: V03:K1:qvnmpT2RZiR6dDs8ibGOJXSgeCKf+E1Q9si9w2vBkPVFdnTZses
 F0BfJ37+dbkNbzwbG4jUSWXgxaT2oqExLzbGkoAys2koNZQkdAn9eeFwhpO+Me6tMGmhsNY
 h3Ojxt7lFHqDQ70G/5pA2hMs5kKFyDhJI+ziQO0TEWBlU9mHxACxq2+sbZpQT5+4ydMtmm8
 GAkt4VHPd/N0BRzEMx+ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XxbZ9zviCg8=;pyYXUOlWQKuUZaRnJpfqu+EI3mo
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-957838429-1764441089=:6155
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 25 Nov 2025, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Mon, 24 Nov 2025, Elijah Newren wrote:
> >
> >> On Mon, Nov 17, 2025 at 9:17=E2=80=AFAM Johannes Schindelin via GitGi=
tGadget
> >> <gitgitgadget@gmail.com> wrote:
> >> >
> >> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> >
> >> > The quality of tests/test suites does not show as much when there a=
re no
> >> > breakages as in the amount of time required after bugs trigger test
> >> > failures before the bugs can be identified, analyzed and resolved.
> >>=20
> >> I found this paragraph hard to parse.  After re-reading a couple
> >> times, does the following convey the same meaning?:
> >>=20
> >> The quality of tests and test suites is most apparent not when
> >> everything passes, but in how quickly bugs can be identified,
> >> analyzed, and resolved after test failures occur.
> >
> > Yes, this reflects what I tried to say.
>=20
> So, do you mind if I locally amended the log message, or should we
> expect an updated patch sent to the list?  For a small thing like
> this, either is fine by me.

Sure, I saw that you amended the log message and also changed the `chmod`
to be a bit more robust.

Ciao,
Johannes

--8323328-957838429-1764441089=:6155--
