Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D26156250
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726575657; cv=none; b=IgmBRCMrSMjPdjZ+GoTRQWJFa3fYDhh5GSNI/NfYZGT4BiYNoEcMOeMf4ddWHkHtagvYNLKidjP2NblNn08bMAXlExWC+qI5f0epcAz1pjXegA/Avwy43/Q3UTfrkHa6JE5bghFTPX/Z+sfDyOMO4tIZ+jX0+/6JI/xMSUWp4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726575657; c=relaxed/simple;
	bh=5p3NQEgAtZvWMDJVt8UdvYxe/sCfuVAG91Tr9FGyqAk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IjkGXsRCzZrfZY8byyqXNJcupBktHeNyYX8lEZrV7ANdFSTGUKuAy46OzUfHjWiFQqrY1Sw0TYdJVltGzkaA/2uMuJdpx8m07Xj5jK4Zot7EwZHpt4V3J3DDrjriD8uN/mBDY84JGv4ArxPxuctMiJ3joHKaDOmhsmMa89bfOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=iS/cj4f0; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="iS/cj4f0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726575642; x=1727180442;
	i=johannes.schindelin@gmx.de;
	bh=5p3NQEgAtZvWMDJVt8UdvYxe/sCfuVAG91Tr9FGyqAk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iS/cj4f0WGz0UlquukxDPIHB8EJ3v9StpIJ+aI+hfUOiQviQMSJc9MAmO0HZjP0P
	 GpwLBPfMXOmVWRAAehwUyDvu5SPjKTaO8Geo8X7dMG5YOv2q6vaVTHf1Qx6t3RYtq
	 33ONDkQUL0esV0msBpa3ZQXvWyz10PU8aagW9r47K4JlnBPkuA0/VZENIarXvJkfq
	 dU4c9xxgIAYFcVMjgKNNbf0W/VBTZxXOAiQBoIG2lUK6Dl0O/uG6XrIPGeL7gPcod
	 d4brGWxAOa7gtTvGQQfI4ObLm9UkJrO/EkKHRLrp5W8XU0RTO8kwHrYK9gcxJrr/p
	 nou6QUvkhMnOmdTVDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.87]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1rvuNE1wCg-00upwU; Tue, 17
 Sep 2024 14:20:42 +0200
Date: Tue, 17 Sep 2024 14:20:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Jeff King <peff@peff.net>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] ci(linux32): make Javascript Actions work in x86 mode
In-Reply-To: <xmqqr09krijc.fsf@gitster.g>
Message-ID: <d8b15f7e-7847-f6ff-cf8f-02aee254b070@gmx.de>
References: <pull.1790.git.1726274559928.gitgitgadget@gmail.com> <20240914072932.GB1284567@coredump.intra.peff.net> <xmqq34m2tasj.fsf@gitster.g> <20240915110706.GA2017642@coredump.intra.peff.net> <xmqqr09krijc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+lazrJUyLOhIdl/AQAog0zSKxseg17Bi+IKKm3qAaTzL41f8MbC
 4y5NpbCs1SsAbVdf8N6AIDUZekghFaqCw2kpvrS4CNAliC9B1vb4yZh+KgUBd50WaFammn+
 O8rx3AdDfz8MLoNCJJfNAm143Ir6PyMglaraqUshZcUyr8TWoO2M7iIcw3Fp1z1/uHKiBfu
 gqLwV14O0pdsLDaOuNkKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lZtyxaGAO0k=;4US9NAgNlTejAqtERW2A3lT9SCX
 LLl7tE+m/Z8wdeL3zyHy/3EHKr8t5OGYVYPLFOY+P3aw+HpYCRO4Xf8HxgVUT2HyArKDiuu2W
 BYLuOVial3QXsEA7UGI/JR8TE9ltHDmjFiH7A/xC0BW490HGrFTdkRA0h33auqX7B4Ls2jGo+
 Lq+UQdqdGiDA7/79VhK/OR9Aj/W63olBg6G0To4tQkamvF6PPbztsQtx81Ul0BJ/bjtOBYKf+
 IqG86+A0WF6xXyi/MLaPLOOn18VNDDJqJh5KRqCokEvHTkS5rvfSBZOoB9xYW9c4HX+lU2WV1
 jPPXw+8sKAZbIuZpaXZ7oBkhkYJlQCRXZRUWO9UjWFDV6ijH7oCvPL9gAQfvAe7PmVpwwC1sh
 NNhzteZcR4z8cKSSz0GZPXSUjCS5M/yRwrqSAyMHMn8ILBq5Eia/hBFZ1aZd7IhhZQPelpPw6
 poaN8A5qq6GNzNe6pMp2ByBeWfXCuInKi1GrMjIzNs+salCRA7c/WIkdm9/qE4JgGbec1bTR3
 zbDMX7yfzZPTRPp2cziERzddYW5Oc3Pp6pQ8NFEmgK0uvrQCT1Blhco9bFBIOioQ1VSo0sGk0
 lXeKCpFJnZk47/C3eb3i+E2ULKNwv8P4TX6UVgRHDF4y92/rW27qJ+oOZ9pz5rZKJMF3B0VdH
 0uWFjeVKY1eQod9FLrZ/IiVLKDuaBfS6tLWWosXebFI6osN9glrRVDJ7kNMtq0Z0/k3MGA3zA
 aHaluaSarB5amwzxv31mK8JWTRcD8NMVK2kGpqBndE6ZflzhzjJRwR1zUsPF8j+9xWoaSuDk/
 KTuScFPuL4+5k8J3XHR+Gyiw==
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 15 Sep 2024, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > On Sat, Sep 14, 2024 at 10:17:16AM -0700, Junio C Hamano wrote:
> >
> >> Each of these approaches may have its pros and cons, but I somehow
> >> do not see that the newly proposed alternative is 10x better than
> >> what was reviewed and queued already to be worth the effort to
> >> replace it.

Installing lib64stdc++ indeed does not rely on the implementation detail
that `/__e/node20/` contains the Node version used to execute the Actions
in those Docker containers.

Of course, the fact that installing lib64stdc++ (and no other 64-bit
library) "fixes" the 64-bit Node version is also an implementation detail.

Between GitHub Actions' and Node's development speed, I personally would
expect the latter implementation detail to be changed many times over
before the former implementation detail would be changed.

In particular given that mapping the "externals" by any other name than
`/__e/` risks breaking existing GitHub workflows that might make use of
exactly that directory name, I consider the chances for that name change
to be negligible. It probably won't change, ever.

Of course, my favorite solution would be for `actions/runner` to be fixed
so that it detects the situation and uses a 32-bit variant in that case
[*1*].

Business forces work against this wish, though, so I don't see this
happening.

The next best thing, in my mind, is to come up with a solution that is
general enough that other projects could follow this example, which is
what I did.

And yes, the idea of mixing 32-bit and 64-bit things in a container that
was specifically used to only have 32-bit things still does not convince
me, it still looks like a much better idea to either stick with a
32-bit-only container, or to just do away with the complexity of a
container altogether if the environment does not need to be free of 64-bit
anyway (but why did we bother with that in the first place, then?).

Ciao,
Johannes

Footnote *1*: I have added quite a few details about this here:
https://github.com/actions/upload-artifact/issues/616#issuecomment-2350667=
347
