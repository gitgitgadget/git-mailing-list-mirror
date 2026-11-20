Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795169781;
	b=btpHR+rxAQJjxYQDC9b0aPup1NRXVWyNkGR7a92PP/0jjSUKi3HI+oMW2FdE4Ct8Y5Pf
	 0WWaTaEctHf9zm3y+ujeQCp9NDQOQlfe9hJbDYwXHd77e2bT8pzl5zvAwHcreIZQtLhzx
	 f9AAaW7pcbwKJWxqbALWUYFUPSywyGVJ98RsVGys9Co5SUqClcFhyYoeyJw/MVfhmCYVv
	 3Kcp61fW+HsJnu4MmefAY68m5t0P6dp7T4Z+EbeFErevhFR4+BKijU2EXluy6Rzvrya7n
	 aeBxjtkqhRI1ujhgsYvJtBlwR1FrHOUJdoPvJX1DuUX/VEKlLHGFKCEpeQOodciJSmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795169781;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qmKpmFILNm1YFG9sbtMfcPmElQSsauz3Btlu8cflQj0=;
	b=pRzVTuq5M9vAtOxT8IVkKMLUgsP/43tfimgjsbR7vKbRZVvSvCHnTtO2bUAsZLed9wBm
	 dXY5tsYQCoybvgAfclVOztRfSV1B7qKMxF6PP5zR3xP7+sI+GT1B5ZDIAY5NgFYEnYvFY
	 QWq5k5KYX8STbizH9Z0EsHeY070q7DIqgK7TxEOvcFQgeti77f4E0ZX/wRq75ms8jYmI3
	 LUdwQzxvAhOop3XPDVaBMcwrGyeISixlFeE+aki1bjyXxlRrs0i2YUox+7Uvwz4tt0X12
	 VOgtD1LwYvEWlTJm12G3mHcapocpHTKcN2ApFDIZfr9AHsT6x651FE4yN1ysNEBJdZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=g9cbyCaL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="zD3IWb/K";
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21855606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 10:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21855606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=g9cbyCaL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zD3IWb/K
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 608CD7A03F8
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 05:16:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 05:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795169778; x=1795256178; bh=qmKpmFILNm
	1YFG9sbtMfcPmElQSsauz3Btlu8cflQj0=; b=g9cbyCaLAlU6ggRiHPXfwnTfip
	Siz4L6MrTFkFamiMRbDID/1+UgY/VQhYv0gtD8LKDNa0V1q10SEG1hvEFMct+Doh
	doVjpyrZDo9/q1iwPldyZZ3hMbloWcph2LR8Sdzh95oVB2f6v1XbY9Ajz1ke+NYT
	5f0RzWBB2cs1ojwqTI/s0lBSQCvvCJguPwvK41YdPyYkWwX52vITL0Y3QBjxL2sZ
	hmFJqrL/PJkDk/OEgCKT39OtlMoo96kIDcrxmc07iBSA5klEmlX9pFatCc47+HpN
	eRgSo6VmxfjAL9QfzgzXCRVVaAJ5M6YFYMsb235GCAagUP82LXQpDtDuiBnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795169778; x=1795256178; bh=qmKpmFILNm1YFG9sbtMfcPmElQSsauz3Btl
	u8cflQj0=; b=zD3IWb/KlJZXNMTDD8aS1ppW4z/wwVYapFHQveu7zoTBRW7nweT
	U23GA6GFoD9yBLly7cqYvAlmHznLDjBzhmRg0DWPii8QwipHSDpLLRD/lw7tggxE
	BNh+6uFI83PrITVF/m0vMWJFYhGh1yb11OupsbXreF1Y/4MLHRrC7QxyBRCcNZ90
	d4GdWZnVS/ImZZ6A/5hHC7JU+Eop2tZFan+YejCBUAU8JwnAaO+r6K7Zmm6EaRkq
	AmYhpzkDmpfsX/9BUFIX16IHpdbtjlZTLedz5VRNYr2rZneWyc8mhQotN/VF0XAk
	2hc2M9kfIjirzkoufgW6BeMZD2tMKcnlvgw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795169778; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:z3fu1NM53bKXFpdi7UtkjSgaCTHT8OU0wlQnsSDZE4z3QhC
	6+Xobwh6ZyP/irYHZFeUjvN5TwBYFUJaQIZCPh0y6q9DRPAGUu91rrqAS6WkQmiZ
	L2Dc+Un3pQi+v/PAjInxd8ht4xeR1NriSUOI3zXFAYZJ5W7vGQs+XvHTgQmxN8Zp
	n9+AaH8onW4VZXcsue3QXgmnE/bf3lysUoFMFLWNI0GpEyj9AVeiS7qnRXUFmTV4
	l4gjbs+QLi7pNYKNIUccJAhg+kdXKyIz+3wdnT/79kqiZMVuzwEiZPHKj/8ssTev
	BQ5ZtCkGhGWN6qlkC4SSqrVGigVw7kZzMNm1WDw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ysVPMH3pMgEUMFMeZTkmRuLyhVkd/fhG2fGx3J1f/vo=:UViER/QguizPnmtC44ERwpaVi2giUZfZasndjNxPRy8=;
X-ME-Sender: <xms:8h0Aa-Tp1zXuKEfQmLb2mPZ03zCXZ78qD2gUr3kSNUGnYMDyiZ4ogQ>
    <xme:8h0Aa6wucKKLPzf6ue_MYRGRB3TVHDjlfJ_nbRXwctoHf1H_o9JwPq0vt28-GFt_-
    mQFgFkWqKZ9E-K3RbsPDC3-HSl8fApv6Pf2fKg0ax0nvP81DFNTIdU>
X-ME-Received: <xmr:8h0Aaw11LJDQWbJhzAYbIZsnQE5M67sC-QkStI8u_yOg6BmqyLC6IhFWmyqT0xexcHdim_E>
X-ME-Proxy-Cause: dmFkZTGFfqslnFrE17TTnpzLSFn9MkxmSnvUqgiLW+Uo4Dcu3460U2tQAzd/gy7BLgBPxE
    yqY0em7zOC3qclzQ55FePphfbvK60TQpLv8TBRZJed9pvaa17H01MAU2VbFSuMWMdTEABJ
    4gFfB3bLxYGb8Hp3UpARPrn7iis+6kyPmXQ48V17ULGe9ca/3V2RtnRZileREz7jk5ZBnE
    BVmlmP9heCJqrgRInwVt+HoHgK7MhlEUNJAxlu/65QLjeuUn2zdMQRGxPZmn44j4jox/od
    zAbLPKrS9C2k4/vp2LeVi7LVOwODkkWauJMcnveeexi+cwxqr3jAG56xBKeMsy8wlMNcPQ
    ADNGRyE68nXBnabWBbjbrHaJlsEYMuQOoAHqGCybDwJV+O+axXhg9TBxAEmEzPLY8OkWCo
    Rt3JIzlVyzVX56syw0KbgUO07HS5eROwnfunCJ8AeoQTvx05YnGtr2TuJabpeUfN5GCA7S
    oJa9bUlIocRBK5TtBDOn4EnU3MiJl4X4icRu5yke8neuAUbbPg/+QsGLGpJu7wRO0ph8+i
    R2CMLHjmI3Vt/qVhOu2ojqtMBKjGO/ZrWgpK7Rb5Y91fL/Bl+xHATxFj3XFV3K+f+/qvSV
    rPw2kcGfZbstP/S2B5V3fm5Z98iYVt/eqT2U7QokOQDKA/JD8/yvTrFx2PVw
X-ME-Proxy: <xmx:8h0Aa46SM1smJYQBbLfOcXNA_sQb678bR_Y31RgqFmvz3QHrpuU97Q>
    <xmx:8h0AazUwyhYiI_idVzhpHrixofn_oo0bp9D3o2c4NHhLTs3X1TLkEA>
    <xmx:8h0Aa3By2BDoejQPZNfYZ0enh_D87L0x3AYVWBeJ07c4zOnjJDhNNQ>
    <xmx:8h0Aay5tJMqV8v05memVvcdxm8RNl9CI0hoD0VMJHg1C4IPpSduOBA>
    <xmx:8h0Aa4WN4psYV4PeEV2G6yxoJdJ31B5ztmuLh6hJ7TCqkJn6gzj3QQIe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 05:16:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86714e1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 10:16:14 +0000 (UTC)
Date: Fri, 20 Nov 2026 11:16:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 11/13] builtin/rerere: use `OPT_SUBCOMMAND()`
Message-ID: <awAd2xxwvH7HCpbH@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
 <20261119-pks-rerere-subcommands-v5-11-0c1092b88958@pks.im>
 <xmqqwlq8tpbm.fsf@gitster.g>
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
In-Reply-To: <xmqqwlq8tpbm.fsf@gitster.g>

On Thu, Nov 19, 2026 at 02:43:25PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In git-rerere(1) we have our own custom logic to parse subcommands. In
> > preceding commits we have refactored all of those subcommands so that
> > they are ready to be used as `OPT_SUBCOMMAND()`s. Switch over to use
> > these so that we get rid of our custom subcommand parsing.
> >
> > Unfortunately this means that we have a backwards-incompatible change
> > because we no longer accept the "--[no-]rerere-autoupdate" flag for all
> > subcommands. But this was arguably broken and misleading as we ignore
> > this flag for any other subcommand aynway. So we cheat a bit and simply
> > call it a bug that those flags were accepted in the first place.
> 
> Aynway.
> 
> > +static int cmd_rerere_perform(int argc,
> > +			      const char **argv,
> > +			      const char *prefix,
> > +			      struct repository *repo)
> > +{
> > +	int autoupdate = -1;
> > +	struct option options[] = {
> > +		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
> > +			N_("register clean resolutions in index"), 1),
> > +		OPT_END(),
> > +	};
> > +	enum rerere_flags flags = 0;
> 
> The "register clean resolutions in index" text used to be given for "-h"
> 
>     $ rungit master rerere -h
>     usage: git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]
> 
>         --[no-]rerere-autoupdate
>                               register clean resolutions in index
> 
> but we moved it to this subcommand.
> 
> It was a bug that "git rerere diff --no-rerere-autoupdate" did not
> complain.  Because this option only appears here, those subcommands
> would now complain when they see the --no-rerere-autoupdate option.
> 
> Which is very good.
> 
> What is a bit sad is that it has become very hard to actually see
> this help text.
> 
>     $ rungit seen rerere -h
>     usage: git rerere [--[no-]rerere-autoupdate]
>        or: git rerere clear
>        or: git rerere diff
>        or: git rerere forget <pathspec>...
>        or: git rerere gc
>        or: git rerere remaining
>        or: git rerere status
> 
> Because the primary subcommand (i.e., record and replay after you
> got a conflict in the working tree) does not have a subcommand verb,
> "git rerere -h" would trigger the help for the top-level command,
> and the help is shown from there without using the options[] array
> in this subcommand.
> 
> I said "very hard", not impossible, because there is an awkward way
> to see this.
> 
>     $ rungit seen rerere -- -h
>     $ rungit seen rerere --rerere-autoupdate -h
> 
> Both of which would give you
> 
>     usage: git rerere [--[no-]rerere-autoupdate]
> 
>         --[no-]rerere-autoupdate
>                               register clean resolutions in index
> 
> but it probably is not what users will ever use.
> 
> I think it is OK to stop here and leave the above as-is.  The only
> people who use this option are those who already know and are used
> to it.  Everybody else I would imagine would rather use
> 
> 	git -c rerere.autoupdate=no rerere
> 
> instead.

Fair. I think all of this boils down to the pattern of having a default
subcommand. I think the pattern is okay as long as we really only accept
`git rerere` without any flags at all. But I think the moment where the
user wants to do something non-default we should refuse flags and
instead ask them to use the aliased subcommand, e.g. `git rerere perform
--rerere-autoupdate`. So essentially:

  usage: git rerere
     or: git rerere perform [--[no-]rerere-autoupdate

That ship has probably sailed for git-rerere(1) though, and I wouldn't
feel comfortable breaking that interface now. But at least it's my
personal takeaway for future commands.

Patrick
