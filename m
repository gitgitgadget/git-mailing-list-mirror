Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1713211A
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085639; cv=none; b=pDiQgIpiAuHz/zI2XTPhiMuFR8L0mgbi3a9g9nq2H1IDROUCccvdofkqFj+2X+pKGtYoiTSdgBDJaOPyZBTAWgOPFFSxpJGjcJ1WZiQBeigcAABRmhd+qt2g6Xq4vCaogO6wswz4HVX7lxTdrvYOv1rmOvzo3vnImKyCJ+mkcpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085639; c=relaxed/simple;
	bh=/yAwNphIuIT0n4PO+7O345k52Y6w0FuK/LUnUgXUToc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J00Y1g3pVci4m9cPg9+dB/sQzrBvfm39KizHGk65ZYTuhys7lF+NP7EkmkyTBv68PUPzm1KOHNymBarILvtpxEpCscxyir/JlJ5Nb0V3ObIRi2YMn6UJ6ZbemAL7RGUUw1fBPwICzCNaCi1KqSZMbllnESBQc8C67eeyAcR+9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=eaRcIVqN; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="eaRcIVqN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724085612; x=1724690412;
	i=johannes.schindelin@gmx.de;
	bh=1aR7UDXj4SvZoh1k2KssUtxsTgKTJFKOZoldeCZPTOA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eaRcIVqNctHkfJ2DvZHvVYYYmZ1PNixwS1+bfp2sbUk7z2Z3eJX8MZxo6dt0qCMR
	 QKMBDRVfgIbsjccl7tV6lznLpqbOctJAAZCI3bD3inaEftMJM6aiPenbTNF+GSowp
	 IhYU8G/QeMVp+gmEK7zlWqTRSKE6ZXFS+3kiC8HsfrqAjGDyNG77QC4RQaub5P4Bo
	 Li49/qHSN8UMgCMUjdqlYn3V5jY5t7+OUXyv/IuAxiNcMSfyp6Go0c9t0edRu5+Nz
	 XQLasiDOJ/CnH+B9vMMnz0pkU6MM9V2/ttQU6stSXa5z8y8OyeAfGs4maV+Lyoa6u
	 gNvG6PXpG/0qdRA//g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.249]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1rx2sy2Stg-00vDBh; Mon, 19
 Aug 2024 18:40:12 +0200
Date: Mon, 19 Aug 2024 18:40:11 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Bence Ferdinandy <bence@ferdinandy.com>
cc: Jeff King <peff@peff.net>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: feature request: set remote/HEAD with fetch
In-Reply-To: <D3IF2EVJPNMX.CFNKJQDPHZQ0@ferdinandy.com>
Message-ID: <c10652f9-3cf8-e1b3-27f3-63fd5b8ac52a@gmx.de>
References: <D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com> <Zr_KtAXQuFwEmFfI@tapette.crustytoothpaste.net> <20240817050240.GA29822@coredump.intra.peff.net> <D3IF2EVJPNMX.CFNKJQDPHZQ0@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9RANHGoHGDDNHLLmJxbKTnrYxRbe6ux0/jkHmp4kRnipnpmPvHB
 C67s3reWkU5z1efwmbH9Hv2lEb6qLze8jV3MmbeblyGSKQJI84h5AszVPE8I5hJhIlOaUtp
 +rFYMLT3Rm3zthRJMMAN2eCewmxJzLL4uKTGzI5PwaTb4tDBb2YS8PPQ7Rs6lE4CyRr0dWh
 gZVvJ3OQEoVmACHMU5q5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rtuiIAJhns8=;2zRoqV+S8rtZNOcmlMr7ntQe7oe
 kGagG0SHpIgHiio0V66BEbIB1aPa3XSi5HGak3CmapPF73EJCrTayo6TkvX3aWxlPIa3esaYj
 jHCFMbHme26dAuoXaJAbCmlV73aE9RilYKtF61kq0XNR3zg1acYxMTK2t5SeTufoRJTUigEZV
 HKX7v5J1tN3K1Ofh9cB8w8YW+ktqtGqBLJ0jb8sD0RPZcJ0onbqX4/MomfFbs4fFJoGQO/yqi
 rQb3JUwHLhgxebEfxEs2IMazGVsjExOinI0FCoeUFrmOlWRrouQw/hAU9aDHgfgKT4W4mmo1/
 5pV3HcP0AV6UeKoMgwfzFOLPUNftp3C7skZ/7vw/xlHNr5OEFzB0OetCYxRAW2EbwX6uTye+f
 7iQyyRq8cJ8/oZkX9AA3ROepIQ6/uzaOldt+jiKcxXb3VfEOI58BpMkXVPXwE28p777MlKl9T
 uA6hmfilsheaim8myMm8juUFbUz6GVjv0JHxjaW3EDw8fql/HjjoADBsY0QBYWA1qcBzbX2Rb
 7ui8gzds+6e7C3O3iLKtpSCf+2JNutBjNOLj43NxODyt2bZvcmmtZkBHfuwFM1wedrxWycg9K
 pp+eHt01RUgjUsOR6aEO8odyR5Hv5E+lSiqQvh2N/26n58MovywomEKvu4LwCZtcMYrQPfyYF
 lOGUlvbq3HSBcnli7NAAImQXyVKA0B2DjvQeHk1Qt0/sqbpWPr53M29Fs+e95ICjGC9F0DC9l
 fQRlBOb3zHtLbMNr0ZipkCAwBkqeeMq9LEhizWG6WfoCuuZFGnXYjJoMEP20zVvda8Nxwy9jR
 49TZAokthuLY43ymfXrEwcTQ==
Content-Transfer-Encoding: quoted-printable

Hi Bence,

On Sat, 17 Aug 2024, Bence Ferdinandy wrote:

>
> > There was discussion a while ago that proposed a tri-state config
> > option: never update the remote head on fetch, always do so, or add it
> > only when missing:
> >
> >   https://lore.kernel.org/git/20201118091219.3341585-1-felipe.contrera=
s@gmail.com/
>
> Thanks for linking that, I didn't think about searching for old discussi=
on
> before writing ...

A better link (in particular because it does not involve a now-banned
person) might be
https://lore.kernel.org/git/CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqd=
djUOA@mail.gmail.com/

This discussion might not be about that mentioned tri-state, but about the
"take a step back" question: What is the best way to update a
remote-tracking `HEAD`.

> > I think that is a good first step, as we could stop there and leave th=
e
> > default at "never" without any compatibility issues (and/or contemplat=
e
> > a change in the default as a separate step).
> >
> > I don't think the patch in that thread is likely to go anywhere at thi=
s
> > point, but if somebody wanted to pick it up, I think everybody was
> > positive on the general direction.
>
> My C skills aren't great (probably an overstatement), but if Felipe or s=
omebody
> else more qualified than me doesn't want to pick this up, I'm willing to=
 give
> it a shot based on the Felipe's patch. It will take some time though :)

I dropped him from the Cc:, as a consequence of
https://lore.kernel.org/git/ZF%2F38DXNYMsZjvy4@nand.local/.

Since this leaves you in somewhat of a pickle because you probably should
not start from those patches, and since you seem to be in the same time
zone as I am, I'll offer you to pair with you on getting you started. If
you are interested, please just reply privately.

Ciao,
Johannes
