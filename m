Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017665;
	b=N/C0lqOC8xHWK3xwekDRyr5G0SnFVQRs2XHl50o397jsncreCRroQ0qfZG4KbokwWCvz
	 dUFT8taKTl/2qPzP2vSYrxq2RaVq2baApGG/R51g6h1lh5N5DIXcZU893U9Zu+qGEVUUu
	 2QBNdFiNIv1+qfg2+j4VXCwpXPqS1yfelW1W8rzxcBWek9tENhGv1nz/3zCjPaChN7pE4
	 dSo5wXpWGxgY05bo7bvXPzMN3U9CmPN0zLcm7xI2koueCF3yLt33hrViACmeCF95VRTB2
	 rt09L5nXjQdPuhjIN16i7M4Ci35Ps61lthNOQjmuKTaIDXZmk3GKxw7+PQBeMGxjsOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017665;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RdHrBXv+OmSAueKM1XDbyLDj/JXitD2bL42cEQziMA8=;
	b=wYt+7qUSL+QsJxgIKdcVKQOUWNCgfwrDGB0DHZBcTSdzcPjj+P5jnqvdecaMsry2kW13
	 poi6KnQwjgX4DgNH0xapDiBDJRlMIpxQw5EfCNtMkH/lg/aNRO1SC1twwGRBL+oWyFCtl
	 iFa7uXI0EO4hCY7EPZ+RAsXPlnHQ/CYGgmKgYuJWHeVcVLWKUVLmwTc++y6DozyB2+4lS
	 UmWsVxSW2Tw9G+68FKRJ8XYHpwDT3gJ6GbBH+NuOUhHW08a5PohNrEc2lbAOq0N7vpD8H
	 9QCYbw+wq38Ouv8y2eMj3Pft4xPPUFugtuNMC9QH+JEQbRdd1q3De4b3eitFNA3QQmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=JM4A1PpG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Tms8uqNq;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8453606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8453606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=JM4A1PpG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Tms8uqNq
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F506EC0A4E
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:27:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 08:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793017664; x=1793104064; bh=RdHrBXv+Om
	SAueKM1XDbyLDj/JXitD2bL42cEQziMA8=; b=JM4A1PpGXGY0N+NZq2nYYAeOmH
	zLwYL6u9AnfYhwcGxMBzQ38eyHoxvI4huyMB56a+zwzFTVPHBj8kGWenYY0lKH68
	jrKSNiTGfeBFmlvQZtYk7FDq4/9EhqwaOWKTBJ30Irb793pojOC7ZC018tbRzLOC
	AAKGiA1atIdvHq3fzNB0uhPXtl2BwuH6Qe+ZA0S+Yzb6S+cVeWubr77zeNb989o1
	LwKzYPp1loQOu7z8/Bu9Xdm+/3J6GgSH4ggDKSygdZM8TQ+CBCAGwOh/d0SlLeS1
	u6yLVglh0qrfhV9C1wAkuX34TeClO3leYW/ILeQj+RFtcpxmQHneoPUGMdiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793017664; x=1793104064; bh=RdHrBXv+OmSAueKM1XDbyLDj/JXitD2bL42
	cEQziMA8=; b=Tms8uqNqVg7NYUNIbVQyviYEsBZxB8eYruyYBIjFUwjoyGMMc0g
	l/qY3YQintF3GZHLkS06EhaqHN1tlB1931aneAXCpFDOQIxxL7DWPHiuuuiDCUWc
	lBKxIK57H1KXiIspjyX053hO/yaTSO9P4JRNditFGlTARZw1sIUq6/WvaQVcbbXe
	5FqiRCiMdjf51NOFFu9dnfQOPYNA8hZQqVOQh/yk2qhUl97bZ9nYbyWLGaUuSdu8
	CBGpS56BGmZuIgUHxuAEzarLjtWqHCKEzASuIzTZZwpxGLznAYaK/PgoNoatxwLD
	oHw8msI88jLum2H+dFTowZTtJFt5k4aXMEg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793017664; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:sjpRdSNp9mWJAhaGZx49TubOdZ3HBiygeKN6W4sUsuLvse0
	7HEGc/2elTjN167C7B3c4Oljqq9WboNXkax72WbjA4ec0znlTv1ms1bHCPQMnp3A
	7JgveK7pzG+fTLwJtU78B3jwEjnzZmGN3sWAP2FRfAUNkf8bVLpKLpXiDz73g7GL
	O+/42Gq3Gnv3FlwaIZC+/JCEl5Db0XGcVxSMBaEB9Cn6ggPO+0YfwYyFqo6d5gJJ
	f1WR1a7G64sDtnW89DB9CjDPK3vrjFKwRw9pyY8El/pZ/Y0hpO+bjLVuqMQf5L7O
	QSr0EjVYrn0SN5B599MHCQHnk9uobNJ+G1244Lg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:b0jXxPo+8wy1kat81DywETeCqrEzNBvxEyJ/cKXD12o=:GMc9vDO9jla3zkZq/BhqZtnlN4GByPxf/rj73Io9AyQ=;
X-ME-Sender: <xms:P0ffartV-JH79tC6bDALziGwqqbtb-1Aj3CRJKWgR9dznLykjrpblQ>
    <xme:P0ffauuG9HT8Dcd6f6D2JzzZNeBCFLHxfSsrgxZc4NT-pEZgGraQ3_HQxln5C89KZ
    KET1UPS9UpDlDFtNHcI8DhcgkPTOY7y5W9jhuyvhbbcSeDyhm8>
X-ME-Received: <xmr:P0ffahBwPJOWl0YJ57LR-6gnQvq4s5qtb8wAOo-2dTCl2tFq-4iN7w>
X-ME-Proxy-Cause: dmFkZTGXBtdHgHoc8aXNDkIUQedYCn0BBcTeynV5qbsoKfiSIbLA592gP/FSeBbHhEcDp3
    jJJC5V68j1TBHuwT3m6q8OGOeG25twt2vD5yx0VjKR8On8clallLavcDTapHqbf6Q7AvTd
    ILq7kc5EuvUYLm1MhlDg3EIzuN+4bVw7PFh+gpvMfUMSZpFd29w4UBUPk45SPv3kp3DDdh
    3wIg9k1EwjuC3o9nZquffepG9wy5ah9D0HddnFiml3gOwSD1uCeg1N6LYEe4DI2g4SUcL+
    +oZFO0svk0dYMHwNoDZ2vWUDsiWdHbHWqxaQChcYQmtgtOHIKx+vZRrsEtC0vKajC3+gDJ
    vA9MnX1raJvCWmNRahGGv3g23PFi2tOoNgp5vot3QIWfiwmVf2b4+lLOAhstwnGsG16PeD
    tRWrmOn1jeEbV9oGsAfCwGgo3lC/KziWp8bp0UtLmfmSCF8dqNFjvCxkJxB9FbXNcxfA9A
    F+KMCZXnGqHxBSt1rVfZFZmYLwgq9d0iz6YuHmcHIiB1jhyagVCAM+fdKT0vd59rpIqmn8
    EOM7sbUnA5oK7p6ZNS1o7LqlZCuTFL9TG2fvL1aAJ5geNimb37Ku4pomlV8ZnDVSAhskom
    Mde4xJ7i30HM10M5c9xIN+FwpBVCPgavS/ZnYYG+NEMzLxUBAb3ScDL5ic5w
X-ME-Proxy: <xmx:P0ffagOF2bofdMeDjP0UWLDFSpf2aq2g4iqeARRNvV0RdPCS6vPsvg>
    <xmx:P0ffaqwol3wiLbFzYkRGqdEiS4q5tbFJ6ROA1Sii3pY0pNZbeIt8TQ>
    <xmx:P0ffagU5xNNW5kpVrGOYWxA7KVaKxdiyIkLx_DdfJLd6sq6bMLtmXg>
    <xmx:P0ffasMgPdCTElxxVMXfqDlywfHBFRK2YdrLGZ44-XBcEqM1X8IiQw>
    <xmx:QEffat7z0L3rjX3fQ1mGiO1jtG4Sv3jSuh_7undHToCfDIkybeMSLzzo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 08:27:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f53e0ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 12:27:40 +0000 (UTC)
Date: Mon, 26 Oct 2026 13:27:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
	cat@malon.dev, belkid98@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH 0/4] environment: move line ending config variables into
 repo_config_values
Message-ID: <at9HOXZhVcl53CGX@pks.im>
References: <20261024220012.486-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024220012.486-1-aniketgupta3001@gmail.com>

Hi,

On Sat, Oct 24, 2026 at 10:00:08PM +0000, Aniket Gupta wrote:
> Hi,
> 
> This series moves the global variables behind core.autocrlf, core.eol
> and core.safecrlf into 'struct repo_config_values' to continue the
> libification effort.
> 
> The first patch passes 'repo' to the working tree conversion
> functions which need it to read the values. The other three move one
> variable each just like the earlier conversions.
> 
> An alternative to passing 'repo' would be to store the resolved values
> in 'struct conv_attrs'. I went with passing it since that is what the
> earlier conversions did, but I can change it if you prefer.

This isn't really your fault, but we've had the discussion multiple
times by now that we need to stop moving more config values into
`repo_config_values` until we have a way for how to decouple it from
`the_repository`. The problem here is that the only way to populate
those settings is via `repo_config(git_default_config)`, and that
function will populate the repo config values of `the_repository`.
Consequently, `repo_config_values()` BUGs when called with a different
repostiory.

While these patches _look_ like they libify Git more, they actually do
the exact opposite right now and tie us more and more to
`the_repository`. So I'm inclined to say that we should hold off merging
these patches until we fix that issue, or otherwise we paint ourselves
into a corner.

Patrick
