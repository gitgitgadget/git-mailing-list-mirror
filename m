Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA883112B4
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764674058; cv=none; b=DrPdkK6uT4LNgW1KbF0UBuco8SKIyPXxG3+ELV4/R40F960T0Qs42y0bznKP3GdOyqRK0b8GKcRxITLkjKbhngpQ/1FuLzmc+vyvc+Cq80wPo6Ch3jHM1ytqhmbAmMzBmtNl68jTLUmvejD4UYCmrK+EO3Eww1zaciKJVWaK1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764674058; c=relaxed/simple;
	bh=dpDS/hs9WopEJEGSMmXoKRkHlFGgp2EAFO89hN89H08=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tJXAJjyCTcRbLRpNcOhOHCiOK2islwwryyDbPnj2ByYSTXHwtMutnv1UyC1a6RPLmW/XKorx8f7Q+19szzFoq9fNpMunY/I4hKkQ4ule04RlhT8pN287QdS9GocIJjfnl8RESiyHlZ0UWLsxZMcHzCT3FWDmc8jZ0UkGY58wgz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=cOxHV09Z; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="cOxHV09Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764674051; x=1765278851;
	i=johannes.schindelin@gmx.de;
	bh=dpDS/hs9WopEJEGSMmXoKRkHlFGgp2EAFO89hN89H08=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cOxHV09ZzNi+45f17A9mQhysz2G7YcgaWJAx737WhZF2r1ZDNR1u1CloSMEC//rT
	 ZSHIckxxLS+LF9lCmqSo6cdFYwOhtpHj41A6Av4VPesSgabIN12WHBnA+DP/I/1Bu
	 O3eE/MnQs7NO8J5XYMaw1ODSWVAF2nU+mdfDZ6VgQcFqXJR3odaoj6avkSlWBJMJ2
	 Qp0tyocvyZmJzaCKgwF+RslRLIR6g7cFkAoADSpDwWDxR58ih8uEpiotq/cs30dXf
	 5o7322OSDCfzFNSxs3wu7ewcrVekxhMt+7Rmw3znwcUTiRsvbKTyvBXLkHAd94MQU
	 3fEa38+s0H6cEYhgAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1vLldw1FKd-00GA4f; Tue, 02
 Dec 2025 12:14:11 +0100
Date: Tue, 2 Dec 2025 12:14:09 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 05/10] t0301: another fix for Windows compatibility
In-Reply-To: <xmqqfr9t8flg.fsf@gitster.g>
Message-ID: <8129143e-79fb-cadc-8f88-9c8daa73c317@gmx.de>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com> <c59a5f24789cff55819caf92d828256f2291b3ff.1764440906.git.gitgitgadget@gmail.com> <xmqqikescar1.fsf@gitster.g> <e355d80a-a0e9-7795-06cd-1b8acfa6c7c8@gmx.de> <xmqqfr9t8flg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CGgKhlo9mKTm+iHP1uupQAkak9cOMBT3sdEYS+RbzeqrWfhIa2Z
 cscQsIRCiQl+T0Fl7OAouu2XsSFXhhCXmHg6r1HiIEN1/1LTp2gr6slGwES7q3VNE4fsgML
 DHN7KhsKez4AOwWyyWdxXatP2gDkN1LWLJXewNFSTxAasTACXcMIKEOqeQXpUErS3Bfw6+r
 dkjvEm4oLQJT7xTA39gZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZTOmX0jPZV0=;8OH9XyOxoAspOPmEdBSJBgnVPEn
 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
 Z3NhRj7lARI3QO+f5/KefGjXoKug7ybEA74GWK
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 2 Dec 2025, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> >> In any case, a more productive than rethinking the "can we express
> >> what mkdir -m <mode>, which is a construct in a simpler world, wants
> >> to do in terms of a much more powerful permission system?" would be
> >> to see if the test linter can be taught about this particular rule.
> >
> > Seeing that this issue had to be fixed twice within the course of over=
 4
> > years, https://xkcd.com/1205/ applies.
>=20
> It means that we are punting and are not proactively helping future
> developers who may make the same mistake, but we expect it would be
> rather rare so I am OK with us making that trade-off.

Good, then we're on the same page regarding this approach.

> But then can you dial back your condescending tone against those who are
> not as familiar as glitches in the Windows port of POSIX shell
> environment we use for tests?

Please don't read more into my words than merely a large frustration with
the state of Git's test suite. It might be mostly conforming to the 80
character per line convention, yet I yearn instead for the same speed,
readability, portability and debuggability that I've encountered in other
projects' test suites.

Ciao,
Johannes
