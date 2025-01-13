Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A31F9A99
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805232; cv=none; b=S6cmVJ4RekwWjq2G17qWlBakp5QR5Ml3PXL6uEL+PIGHchgXTxIdbkiFslz2xDbauQDdySSaHjJ7ym90i8Si4GjQ2h//qPhFRo5XRnS2gTPi6TXhcAFdZ0NZqFEZk/3JrxRbpPDdpCcFDsovgNy5zOyLY+w3OmyoP6KpyXAV3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805232; c=relaxed/simple;
	bh=/Wyv5bSKCZXubGuNmlVWYYeIPdRdZkUIpaudFHxm3hE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QJy5MzhjtJNd8AxACv98o4E1JWC1/2Uc4OhcpLVOSedf9LAj1aK+7MvPFlOOEBmeGjc9N4rRNeDXacXKF6kyz6ml6ECHCRJ5JbQ/OUrOmaSACmE3wNGHlkWyM/GHCoXU5n9vx3HR3/+CFG4Vocs4nX3d7nmHwZndgoHcWJYAsn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=mmZi5Yhd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="mmZi5Yhd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736805227; x=1737410027;
	i=johannes.schindelin@gmx.de;
	bh=/vwEGGuC25kyVS8kALnZnyHvdUy+QBQb24DPmfNLat4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mmZi5YhdqEVB+BbH2y8d5NblgWDJP7CI6bYNN83Y9K8Fj9+l6VCk+1b+fDLsXLGr
	 pagSJCMIC1fb3Rg14WH3oJtpu641zt23TvFERaoDgJH+cgZhUjtED7/w2mJbAAWGa
	 1KAFR7qLf00yNXxhBzVpsbl0wPYIr4YsOVKBqExSigz5p/wvg3QbQ1MLB712a2smo
	 X58rtbaNGDwWMcYyRWPOzLCroCtWdcgmc7NXHXisJ1ue0Xbm/3oLaFadNrSRNyZFs
	 7RGku8rayk1DnWZHGtqWFTUnZu1e8I0lTwzqBuQPzmQry/fbzUAk/8WkwhAyL4qxr
	 AqFVQgwjnPtl5MqzGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.189]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSt8Q-1tzbKn2tdm-00Q2Zc; Mon, 13
 Jan 2025 22:53:47 +0100
Date: Mon, 13 Jan 2025 22:53:46 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org, 
    sandals@crustytoothpaste.net, stolee@gmail.com, avarab@gmail.com, 
    peff@peff.net
Subject: Re: Changing transfer.credentialsInUrl to default to "warn"
In-Reply-To: <xmqq1px6br7p.fsf@gitster.g>
Message-ID: <7a60c9ec-8f98-73d3-4539-d96b63a4f442@gmx.de>
References: <20250111071500.710169-1-mirth.hickford@gmail.com> <xmqq1px6br7p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gMwJbbAkdNYLnCLgs/QUKSV6HjnjB4zOm8vpjZjqjZ8FMo+CPT6
 +bo1w4Kzw4uRwFLQUaQL3FVXywtLBFGL9EmDFHUxLPP0Bpt88hl2CIAAH7HTn/IUKEN/DSc
 lMUVuRDKYMdfSy/DcZB2smvfVSlzHpaJgKOkv/Pz3me8S3s90u8gAwuZzb/cwrIc2zNfq2H
 uUCGCjRlU8AnXCqCdecVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SxPxAisfpOk=;O2/YnDcHVCEXKWeq7f6dzjebXdJ
 f6GVzaZs/HkcMCBQlFuAqpFtdgQEQWFpU2g2KsBPJoTugbnxaG3qCwcQt8YvoKHojRqru6PVS
 uk1euvw9LU+a5jlqhPk0N060oYAaFd50jMW9iwsM2tNuqmQO6uyELF67qRyifyqP6d6hsYpuz
 zABhU6ylYoT1SqlNnqjRUUSwou7fXEr3htWHyP/qWROSdyoukbsHc6ZbYaInlPF5qiyiWA+eC
 0SPMr3q1DwuhWdb2P2B+S9806a6EJ+i9lskgv2+2wYSCIFWikUBhsub7W9Cq5lcNABG6IE+qV
 txT7UR98Nbdb7ZLtaQNPf7gwcOW2GUCoxYoYphrfsKdcfPOnS31BfTZ+uTQTWfsZLSchip5c8
 l6wMQUZQqDnXlEQo14e1UTd6a4/43zrk9R1LhhsHHhiwhCK3hNzaBatSmXLBjXUpPhaqFOGIt
 iwseglC+2TESt/T+bcrkInpkvnM6DWsqvciWUTxVbf4zeHxqWG6VzTspONj43ZnlQuAgciszL
 W9WcDIMyEvuM921v1ZK1qB407vkRGnTLS0p3vGFWBcHXYX26Dp4l9Ko6AA7BXV9uAegl4Sw8Y
 5kDXo0MVq9kNikp8TNuUx6+r4ZIMLUgOFlQD/kaNdcv9XfVgaElfqLffX/qmSBDeyOaUg2iOl
 cuQXFxXcp6QiWns5Adks4YzY6l+2HXANL8uItGNno4PAyCPoJZd5syQAoj3/I1QIGYHeqDiIZ
 ub8h557pZK6GsYUWvpuOFgxVAvp70zL8KysSmpB0M+Zp+Ox+tjXFRNDTpCBYObXqoGA9k1UEL
 rpnMhf+JPhvIynxUw3iQIBGXuf1Bibx6D6vHEjPi/1P4S7r6RBf4JBT6ABXJMibUpzZzQRlXV
 PmQeIM1AkU3EpYJrXNZsQmAieqh8wqFtLdbJ7SK0z8QZfb7wFOz8kD1ZG4LSDj8j7mL2SB2H4
 Z4NWQHT5FgTm3KfZnLzetcPg4+0YsBicxivr+yDMHI6u6c3YGweil/v6EY9v5bzoYyTWhstEx
 1mwn1J5nnf8jZhrY7aeR0nx1Oyb1LnMOJBHMhCI0B9rqjVF3DnVp/XynaMicAqt7Ug22+YRFT
 lpjKWMRNAE1+R4D+WOVzxOleRCTrlb
Content-Transfer-Encoding: quoted-printable

Hi M & Junio,

On Mon, 13 Jan 2025, Junio C Hamano wrote:

> M Hickford <mirth.hickford@gmail.com> writes:
>
> > In order to nudge users towards more secure practices (namely, using a
> > credential helper), would anyone else be in favour of changing
> > transfer.credentialsInUrl to default to "warn"?

IIRC that was the plan all along, and if the original Git Fundamentals
team (of which both Stolee and myself were members, and from which this
patch originated) still existed, I believe that plan would have been
turned into reality already.

Or more clearly: Yes, this is a good idea.

> I personally do not have a problem with the proposal, but it is curious
> that it is documented as inspecting only .URL and .pushURL is not
> checked.  So, in addition to "once we start warning by default, we'd
> need an advice message to tell the users how to turn it off" Derrick
> says in the commit log message, we would probably want to see if we
> should/can cover .pushURL and need necessary updates before it happens.

The reason why `.pushURL` was not handled as well is that it is way too
common for Git users to call `git clone https://<user>:<password>@<host>`
(heck, I am privy to documentation that explicitly calls for this) and
those users typically do not realize that the credentials are then stored
as plain text in their Git config (and prior to b7d49ac1ecd (trace2:
redact passwords from https:// URLs by default, 2023-11-22) would even be
logged via Trace2).

There is no similar indirect way to leak credentials into `pushURL`; You
really have to set that config setting explicitly (or call something like
`git remote set-url --push [...]`). It is much more obvious in those
instances that the verbatim credentials will be leaked into the config.

Having said that, I would be in favor of letting
`transfer.credentialsInURL` treat `remote.*.pushURL` in the same manner as
`remote.*.url`.

Ciao,
Johannes
