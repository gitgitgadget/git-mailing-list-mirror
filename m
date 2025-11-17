Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C7334C33
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388199; cv=none; b=ky8x6flhtK8+9FmM4/Hws7CelZPOANWtmBchtMJJvGNUnn7irEa5CnOTZpM4ZQw7N6DtJk2KIQtcCH3ep8i+U7R2kLIN1J3zowdNTsn8bhEOiCDL9UqkwoQge1ncP/BvwdP3yU7QIhHLhIisfJQ7LFcFlmNuzHNkhyFUf2DzMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388199; c=relaxed/simple;
	bh=tdsPDPnUuTiQJC0O1Zggp/RUSOPHHPccOO/R2cSWBl0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lFr6Qg2+4EfTSeQhTn2YTOL/SNM2FmOXoca+4AiHd3fE8YBq0IYg2/SMIym5c/1tssQ8yQ4gFTMHaw+u01kRO1WjRys9P3vnvW5zDE5IX7MhMFembI3WlDYMLLGHLYoEH5WvRyu0OPusLfPnxdXU3TySbYfWcGPTmpq5CA2w4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=H3cts1rU; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="H3cts1rU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763388191; x=1763992991;
	i=johannes.schindelin@gmx.de;
	bh=WInWHuAvzLaG5d2a7e+MFNJWPyeDMA0h0s7ZN3Dg2LI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H3cts1rUsNuT5JaDtezy3b0uASsospuBLQi5SU3Nf76WuRclFqfSXg8ECme7u59Q
	 XTqS6ePUu4Xr1FattgucCO1V1s/j+gAYC/jNAzVe1TCtBezH7HBqrzL+EW5mpFkuf
	 4lHa9xbSqSyKpQLbEbV5rE8On6Vae9b2THWXgvYveYD6x3nrh8dj2q431AJrpzGH7
	 D9iBawrP4e0gPTDem0u6fAVZjRLfbDgE9+BK0qggNAJJ8+hI6rMcpFippVbdCcGZx
	 S34ygQ39EOIzeCzL0O2b/1h/mPjHd1fYEtxNobiRL9B8Tuxb/wXmcfXHl4bFe/wYp
	 XCbgFQ/PZ4HWMm7PbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.224]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1vKzp10d5k-008SBh; Mon, 17
 Nov 2025 15:03:11 +0100
Date: Mon, 17 Nov 2025 15:03:09 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
cc: Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 2/4] git gui: set GIT_ASKPASS=git-gui--askpass if not
 set yet
In-Reply-To: <816cd946-4f25-4ce8-aa06-6babf9e90751@kdbg.org>
Message-ID: <1295d263-e60d-0acb-91ef-9de888398840@gmx.de>
References: <pull.358.git.gitgitgadget@gmail.com> <pull.358.v2.git.1756371530.gitgitgadget@gmail.com> <e1aef533bfe89bfb87b1a83bf7c7375e6238b06f.1756371530.git.gitgitgadget@gmail.com> <816cd946-4f25-4ce8-aa06-6babf9e90751@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0VWWCWLkIxjLocLMRUOXvlrx4DYoQw1/FYyZgSF6p40whrkzFdJ
 +x8HUyTEZPDEn7cewis5+3wDhu5Vj0s4lbqrHag0R6vesHdEQAy2ITDCOT55JZI3kLG7ezE
 0WF2I6zuHCBGrwbsXWL0mgo+/PDAO6FBP6j95ef1tT8D6pCnad0z7h/t5e2QEcGBvbesw/k
 zbSADaQrXKoYubOvnKFHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LqBJKu/k+KM=;Ruk6Yj6qS/7+Z5CdkHuEb77slZO
 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
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

On Thu, 28 Aug 2025, Johannes Sixt wrote:

> Am 28.08.25 um 10:58 schrieb Johannes Schindelin via GitGitGadget:
> > @@ -1130,6 +1130,9 @@ set argv0dir [file dirname [file normalize $::ar=
gv0]]
> >  if {![info exists env(SSH_ASKPASS)]} {
> >  	set env(SSH_ASKPASS) [file join $argv0dir git-gui--askpass]
> >  }
> > +if {![info exists env(GIT_ASKPASS)]} {
> > +	set env(GIT_ASKPASS) [gitexec git-gui--askpass]
>=20
> Is this [gitexec ...] deliberate, or can this be [file join ...] like in
> the surrounding cases? If it is deliberate, we need an updated commit
> message and/or a comment, otherwise, I can amend locally while queuing.

Sorry for the late reply. As you suspected (seeing as you changed it when
integrating sthe patch into your tree), it was just an artifact of
history.

This patch entered Git for Windows back in the msysGit days, in
https://github.com/msysgit/git/commit/1644f8ea0159 (2010-07-23), according
to my records that corresponds to the v1.7.2.3.msysgit.0 timeframe, when
this block was surrounded by similar, `[gitexec]`-using code blocks.

The patch remained virtually unchanged until
https://github.com/git-for-windows/git/commit/076c4bc42171 (2025-06-16),
which still made it into v2.50.0.

Starting with https://github.com/git-for-windows/git/commit/ab11df9a3899
(2025-08-05), this block's context changed, and I must have changed the
block itself in reaction to it in Git for Windows (but I failed to miss it
before sending the patch you reviewed). The patch made it into v2.51.0-rc0
in that new shape, using `[file join ...]` instead of `[gitexec]`.

Luckily, you made the very same adjustment before committing it as
https://github.com/git/git/commit/aeaabebc1a10 (2025-08-28), so all is
good.

Ciao,
Johannes

>=20
> > +}
> >  if {![info exists env(GIT_ASK_YESNO)]} {
> >  	set env(GIT_ASK_YESNO) [file join $argv0dir git-gui--askyesno]
> >  }
>=20
>=20
