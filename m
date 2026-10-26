Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002023;
	b=10Q2RcrMzxKGRcC1Uthjdt0QeofKxcmXGEjQ72t8TPP7sPhdfEBZ7GDYzunSmQUfJD/q
	 YCReX8Wuc3QIKeMQfpf+5FkACCjWt/NML2KVXuIi0dFqpLgsFgO7ur9MApVD2peITHcGB
	 QP4BAbIlWiPkoiIS9ZhZfcek/z41fzQhhYljQvZ8810PCcd1ezwNq5iRPRiCXRCaIKaiX
	 NTQAcgS6UjnPVGOjd/CaXy/qLCAOgLc4wD9wYKBRpzFN7fhoM+EbDzlJ3mlzRfEyotUWD
	 hVHhKT6uLn1AMSc0gPR8teWpVgb0DoOX2/fOZD/KgYwvxwknWIgv0oDhZjqdmjSfhww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002023;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=34sgCUhL9yLoGK2emVI5vT/GMLo2YlIdptKX8j1pL5o=;
	b=WEJ0XxpgSS14mA5ZYwq0l7yAIfZ3lygrYRzbGgVJJAbizoIJmk4/Plu2H+dVZdwv5yvc
	 3ecKmeXkocG3o8HjvNeOxHVz360R4Z3CGPBoKRLAYQWW26/JGrFDlF51+xaRGbJ7eiVTn
	 Ze4lYXy3nv61AxpuLqkXl9xZlCKptAP39eRBF7Tsygx6QmgQchSJsSy70pL6nBaCG8mzi
	 bJv7QLyU5Iz9XrU95ONvF8XX3nPwdCfDvzwqE9f7XhNUJMLQPOSeXfv94wKnpG4FmcQ+h
	 zykSWA2RtqiJMIIG8uCtKkOYXlahgptMbjBYDTyqKXrS/4iZAoRHSjplc6R85kANkiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=eS8DQ5oR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QSIe0h0b;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D6606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 489D6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=eS8DQ5oR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QSIe0h0b
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B5B07A01C2
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:07:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 04:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793002022; x=1793088422; bh=34sgCUhL9y
	LoGK2emVI5vT/GMLo2YlIdptKX8j1pL5o=; b=eS8DQ5oRO+Z9Jx8U5iotNb3NlC
	EwzWPehD2/crIwAVI3Zz2+Y2WPST0aW3KYnOtj2QPwVv/AqlFi9hioEP7pENNIX+
	1EcUDKoOg9+U6sdz6oDwxrs/YiYXYfz4TG+CLGMR3vEFYzHsK4ZkjqiKvQkwfU8M
	PXwxYH7QKZEoXf1cjF3De2mBT4TpsTJdWABNlXGu9w7HMitp83wRa8mmr6Y5vi37
	N2YMPGS8kS3Nrh52D2ikYaomG0+0zth01bfhuY8EWwM3aLuCSxDLot1Ovp2bcyz0
	xVBrRcAOjX3YqWCfUdFaXkE+UX4FkQuSj3cV3v2r0cL6hQuRn+TVmpKpHFEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793002022; x=1793088422; bh=34sgCUhL9yLoGK2emVI5vT/GMLo2YlIdptK
	X8j1pL5o=; b=QSIe0h0bXIPwshSJVlF6JrWIFgWGNnZfaKX09BnVMqGOVaxh4wo
	A7H9w6fIqPEE+B2wek/n2tk6NQKyYXpUAL1lvmM/U3QrMI7YBU55qNJqiBRtAevZ
	2nq4l6AAk6dmlGEHZcrRl0HVR0nQ0FSzkvMWk8rS/d5kvvLJEcKZgt9ArxpNPeYV
	qQR73oFKgis7ne4Lr33MnR6lNKuWzHwpTCEwSsvKNLImsXF/vlbG3fJzm68dnatf
	n8JZdOHGAj0vBhGY/eJhq+SvEUKKloFVUGUd/osrzkM6IvyKh2ucbvBOPeM7SGfU
	/6vEectny3ixtjqiP0bHErffCXnC66wvjgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793002022; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kqx4geVlIIXh+Bc8Vl0YMOpCKTYc1ju5uukF5+U75pq9owH
	POG/tldh4+zpMUhjHMrkaGrF1zhAYXUsxLZ3+xjajWPi6zuBqdR2KDWTHHMVwdCk
	uV6vpU4+wuXF0pnnOKxGbSUQJ3iXHvGAl9WaiaMxzz5UwwMddBOxKnrAsWGBENs4
	/4qqPoxPQa5v2uSCZUu5ugO4c5exWRwrH23XCl/I2E2rwugVD//chkhHn/feYJ7e
	0rN8NdDbkp1Q8X1EIDz2SvzCfjW1gABcWSJwMmOUYBksfQVpvXdXIuEePPNS3esp
	d/y/UfrSO2Q01/lMmnSP/Hci8Luy+Gc+sv0fZfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QImVbJ9ovqcEqEC+00sfOEPM5qbOwifaF5ykExkJ7GU=:ReoRKAZVPiz1oOz8bisb906w1Ka1OYTqK+P8rHImvLk=;
X-ME-Sender: <xms:JgrfapYCXpqBqBk7AxwbpndUmY8u7HBtjtwXl2-wWyqIwnqgU3OhYA>
    <xme:Jgrfan3Vc1juJhH1JGYcTWh7FhzlArTn6ed8WkR1pAVXw4YbX1WEfuAGNQ8hOuCN2
    AlRxF9Qxxq0JGJzIzRQpQKWFEndRe9TefkRVrYE5awxMFT9gc-FcBY>
X-ME-Received: <xmr:JgrfapU82iTYCB45BRjvSup96uVFHkognfq0iz5_0Gi-fbAYF8LeJQ>
X-ME-Proxy-Cause: dmFkZTEtGkjiEQeVSZpnv6Iu3vBvENwzf8VRHCn+zEMExC8ygsWOO9f3DvFeexIdHzq60J
    xBles9bVTnGjbZiRmhlCF7fXLjE9JXmN+kNXrbGzht2R6XAnKQOmLMfIYardQSjaoACk7z
    DuH31Ea3yMNanfFzRQSgbZPhlmGdXfGHiy2ZCFttxKgfpZpsTJKkXkkQY5d4QC3UY+A1Qs
    gzU29WklUHYW3Cd6SAeZqqjaVM8tloxolJntRQbJ4PXJ+DK/Spk69FC3CZD6Jfcrqfvvgi
    i8SiZ6igmAuEJiAz6fY15++OLyMnysjSNddPMqM7nDAqlfvSySmvEG/CpL3W8wlQOLcxfQ
    xOD9PGbmfYG0sJ74uzMZM0HNAVegrjL3JnH+K5wnQtUsVZHH8KGXelq2sKBOFsp0aMxmmJ
    eElQzJgF/sq9DNhqYehvKyjeNKdmOkpFlcMfYVselWdwxgrQgdAvspBJDTleiC25pD+iY6
    lVH4bLn/v3U7ZSg8uE9ct2FYFnyBL4AxTJBGAAO5C+rfNWXifM5n9o0xEsYKJdJG2f5qft
    JAODIOTnC2zmg7/yDDoV1XrrXnJldqOqMA7S/CHpKHfUCTiTIgqy5DXZpDwQ9zY8yYx/Dv
    tahs/rilhfzkalun68FLaIbJKZSzEXGStv6UboQWb8d7Gr+B6YsyG879Sjtg
X-ME-Proxy: <xmx:JgrfahUtgLsrjNSojXiTDmp7ASTr_DrF8rBDsPgpiHxs0kiuifGK9g>
    <xmx:JgrfaoeL0S0bE9PVUMfyH5FO7t_afK5eH7l-TZo9bhpbwQnYp4DGfg>
    <xmx:JgrfaqUzmYLvzF9uWAUbXEmljGIv_DaBcObMzPtq1kTRMCrLpdN23w>
    <xmx:JgrfahdFkF_9PDtIS0pwzTGaqKjtHtlzd_S5U6xTe_ZJ3SGSkY6hNw>
    <xmx:JgrfapT9i0Le0Zg9qHsZfuXdEBto5eujaAgykLfhGB1kN9uUmaxF4Q9Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 04:07:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2b498cf8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 08:07:00 +0000 (UTC)
Date: Mon, 26 Oct 2026 09:06:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit fail
 to install
Message-ID: <at8KIQPtBHXyLPyY@pks.im>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>
 <at79nEHLDrcoCgn_@pks.im>
 <CAHwyqnVVCp9ovsHDtc0pHYrFvpmdJq74gyx9yf3+ZWkL+d=CVA@mail.gmail.com>
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
In-Reply-To: <CAHwyqnVVCp9ovsHDtc0pHYrFvpmdJq74gyx9yf3+ZWkL+d=CVA@mail.gmail.com>

On Mon, Oct 26, 2026 at 09:38:10AM +0200, Harald Nordgren wrote:
> > > @@ -121,9 +133,16 @@ macos-*)
> > >
> > >       mkdir -p "$CUSTOM_PATH"
> > >       wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
> > > -     tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
> > > +     tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d || {
> > > +             echo >&2 "error: could not install perforce"
> > > +             exit 1
> > > +     }
> > >       sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2>/dev/null || true
> >
> > This line is a bit curious, it makes me wonder whether we want to
> > tighten it as well now. Any reason why we wouldn't?
> 
> I asked Claud about it and it said this, does it make sense?
> 
> 'wget/curl never set com.apple.quarantine in the first place (only
> Safari/Finder/AirDrop do, via the LaunchServices quarantine API), so
> xattr -d on these files always fails with "No such xattr." Tightening
> it to fatal would break every macOS build, every time.'

Well, if so we should be able to remove it without any detriment, right?
Maybe that could be part of a preparatory patch.

Patrick
