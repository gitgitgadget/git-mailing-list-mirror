Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010997;
	b=glEaAjeNZYHYOlPoJRg6kE2e9nrfcMk4OQ/90iG5iAT10c9T1uP0vKhEdAJo7k6LoNy0
	 qT5TsStQpP75NMyGlSgSN0ZOuqhxFwxAFqKMgc4/iJQRJaKwFEpnAtfndrjl8RP3JAV63
	 xb1sCPt9T5Ol5eQ6tnziXX2Ruh/SH0D5cvdcVPIs9ZE9QLkkM32P85Aku2dIOvmbTbpCV
	 MIyewiAGSv1QjpEPdaCN2aW1iow7znPF5DNIz91kRFX5/rZb1vibB/nN4Z0cYr/Wn+3Ai
	 VZBVeo3erv+CD/Ffs61AEH2tvV6fyfCDytQcY10LZKUZeEDFGEmKckobT3Dh65Ky87Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010997;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Sfs5xZ4tNr4lf1oD4rfiMznEWR5lVaXlc1PXmJgDCSw=;
	b=c3l89YglB/DD5ZIrSqt28oiztQqivbDJuIEAmCl5WcasQC9ugutFA7bWNSvoOlPXoc/G
	 nQxVq3Ly9C6u08YuGu42i7XwrudBb0rdBHZvE+a2i19oJK7Cb4NhNr4dNlISFArE/q0n0
	 KLWWSC5PYg3B3ydIfEyWTlFg9dPSziRFjEs75QAQiVEPyXkbtPWvyvKSdVMM7LirBpzaX
	 R+6H9sdiYDVkTMtCtfE0BL7WqYH2fF0+F/XI2C6JFx88KVOebn6GOcjC3w/bch+LWLaia
	 By9sMmtH1E4A8n/a6IWsZ7BgmPxTI9IZSyYNrLvAgRLIUeqdm3LWpJIete2V0TqWDEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=e5h8pOYK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=geqP5DAO;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8260A2621
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 14:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E8260A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=e5h8pOYK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=geqP5DAO
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5164AEC0B00
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:09:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 09:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795010996; x=1795097396; bh=Sfs5xZ4tNr
	4lf1oD4rfiMznEWR5lVaXlc1PXmJgDCSw=; b=e5h8pOYKerSNoYSp81/JpjK+T+
	+zAZczmZUyFsg6K7pdAcCZX/5vWUkLFSWwxsaPSkTX6IIHHb5osK9vpdW9QdrYtN
	slU53tA9LR2+SC/pN9OcgGX+YeJcJKjyQWwjtRwJMtfui7+t1tsyePOzB+iHRhcI
	7p2BKadWVmraMjdFvbrJBMNzSGsBfwWuKUvi6NX0LsvkPa5FG2aqS19D1/JMJGKC
	zdS7emjhqr3YD4SdT7K/BJlvPEyQHqcQjpUa8eHVKCC0XJzwpUnO1Y4BdpgNxvA7
	pwHoq9zRLCjroP5IIiC14KYvSpp6W1LAMYnsXRGaPdZuxHc5GUDkkfcNRMPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795010996; x=1795097396; bh=Sfs5xZ4tNr4lf1oD4rfiMznEWR5lVaXlc1P
	XmJgDCSw=; b=geqP5DAOaBEHh2dJ24AccJcnqSbyzxFQrJj4kilBF4ZhBL/MvgK
	gLtVxeHWewDn0O8IqVKRpfZDhvXnlmGlUA8K+sJxTThH6yMWVg+a63/1gn4+0q38
	AUXamQ1pRge4X0KAvGFSBVd9x/PovVJ/kgyGR69Xex3trXFrCFTfn51qyn2vqKhK
	2YzmtR9d+oAA5ZOhhtaaQsI3j5Xym04+pHwxB5r/2W7nNNreA8WgJXqhQLta6KXL
	lny6ejSQWke7zNsXj9/ik/OmKc18x48duTojyKb9Zj86ortG69Tf0waDU3CR4bjK
	kI4fSMcVC5YPqreaCm3udNYk/GS9SqFRMcw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795010996; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:CsWTqh9vFaa8z5Og4xXddFA/68pYDoZH3tCMToy49mTH65L
	KDTZn31yaqZIw7Df1ibv/oMbOMPe0jzchV6V2Z2D8HrBpV2FvR+NzUgn5FkZ9QBe
	nskt53RXWvi0oAYwCCWmiYIOx4hx50hTPFHIfQJZaviRSz+Zpk/JJIcL/l1crIVd
	4F7EMzZsG1dCMXuXYu0VSb6yzL9epKVVkYrsdGkQAJpjONfM5RjOff4vnyVKJ26a
	IiscCNVoLYZ+DvC6FSzDdE/YpNOZf2uur7cEh8PK4ucjrFINhMUqSr96cKvGBXNo
	ZH45O1BZN34PBLyWatynANAxkXOn/g9FpB/q5tw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sPDesCO5tCpjuC+nwOBL2AKe/thaFxwhYDHYTuAYDc0=:+w+GeipWP5+/EZItDTh9v2ImprwuF6NaKr+5WrMAK1I=;
X-ME-Sender: <xms:tLH9amD4O_Dd52vxeBZnSiZkmmfSlpyAjhGEfg6hdC2yeL0KfKo__Q>
    <xme:tLH9anjBXcYSBpLvX3sVqRe7ne7m0sVix8qmt5R9JQ0mysWmwnCi-bSutsLVYH6G7
    x1OFvyDE3sM0Fv8JEiFgzoePh2ZvXFGYrgwVLtTbO684zqqqDFuW5n4>
X-ME-Received: <xmr:tLH9auk9R4q8jYvYpK6YQftIZo6cvG0urG2VWXNAUkr_XCxyON83jA>
X-ME-Proxy-Cause: dmFkZTEqfIEQ/9Eq6adTzWUpBsRIjiEQmgF0LXw0ElBUKrPLueKPwYFPp923R+EAITdCxM
    S0C8gPoBurgCineGoIffVvDxK6Ndcw46nV07m4y8YSbVRO28oyxqyRsTlDJliml0XyWyD7
    T3N/V8isoP1AMd8aGOBr8QZghtFBLsJ8mgqDdU+Guy50rGQ/GpBCOkxDM5Pb7N3GDc/Odt
    Oicfb5/Q3h3c429j8tyPhwmEwYZlq2Urn04afl7WbGhYC+qWHFPmduzKUGNXMpybygrQ/F
    WedrOJ/ugSdR4GZI/XmQ0J2blrW95YcuhkcgUw1j8LBkRs7xU0sRI0f75y0B781GLC1hpW
    +VfGKUmrXC7nKt63ybpyxCLgaAplSxUwr8GysWkjQEIegTfdmVH8muRom7hIX6ctaFfANA
    /mU7qt9AmG34/0lxSFQH7d4GZ3o3B9XPzemhXBD77M8GbrePRbXFBb0ALpj9EzrgVhX+UF
    7nfZhTyJVkQIC/WeDg9zDYd/vctaaVDlJjWyFvkkdLYRBq1SPS2cx+RMfyYJIzy4HodEWW
    yoevpS4wI37qu7Lynf5cA/S/+pK/wTOQ3RklynJEjsPHC7RRdoIpg5T7IiB6BAmJHRwisW
    Ryq4EGruk8SusDC+OmHtfeydZuGrXc+do+I2PHpSos9L9EsKTtoKv5CTjfGA
X-ME-Proxy: <xmx:tLH9ajrA4NsCzxAkg55ey1tf2S6PDTfFHR5yOJolxK3W4ogqJPEI_A>
    <xmx:tLH9anEqH7r84NJ-B-AMiT1z8Y-X3IU-cd0YdZ97_OEkMqB-78vAvg>
    <xmx:tLH9avzlKKxLAhGGTds1S_VRr7YLudNFtamZnuMgZTqdxppg8Hbmuw>
    <xmx:tLH9aspnRSC34D-xQU2V2KcZkOWuIV2P71NtXzJXKY6rM-47U9Y0mg>
    <xmx:tLH9amGBoq1GCHvq9rjVBPBDVE7yOSlRY00Ooc6JhevNtDBihSNsa7OO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 09:09:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d49baabd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 14:09:54 +0000 (UTC)
Date: Wed, 18 Nov 2026 15:09:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
Message-ID: <av2xrR48fdyIRwTL@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
 <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
 <xmqq7bifponx.fsf@gitster.g>
 <avq3YHb_J8Ww6Kq7@pks.im>
 <xmqqik1wn5mu.fsf@gitster.g>
 <xmqqbj7oi7fn.fsf@gitster.g>
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
In-Reply-To: <xmqqbj7oi7fn.fsf@gitster.g>

On Mon, Nov 16, 2026 at 05:16:12PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >>> $ rungit seen rerere --skip-locked gc
> >>> error: unknown option `skip-locked'
> >>> usage: git rerere [--[no-]rerere-autoupdate]
> >>> 
> >>>     --[no-]rerere-autoupdate
> >>>                           register clean resolutions in index
> >>> $ rungit seen rerere gc --skip-locked
> >>
> >> Yes, as documented in "builtin/rerere: use `OPT_SUBCOMMAND()`.
> >>
> >>   Unfortunately this means that we have a backwards-incompatible change
> >>   because we no longer accept the "--[no-]rerere-autoupdate" flag for all
> >>   subcommands. But this was arguably broken and misleading as we ignore
> >>   this flag for any other subcommand aynway. So we cheat a bit and simply
> >>   call it a bug that those flags were accepted in the first place.
> >
> > Ah, I missed that part.
> >
> >> But yes, the same is true for "--skip-locked". I was expecting more
> >> review feedback on that specific part, and was a bit surprised to get
> >> none.
> >
> > OK.  Let's break it and have the users fix their scripts.
> 
> Having said that
> 
>     $ rungit seen rerere unknown
>     usage: too many arguments
>     $ rungit master rerere unknown
>     usage: git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]
> 
> the above might be a regression that is more easily spotted by
> folks.

True, will fix.

Patrick
