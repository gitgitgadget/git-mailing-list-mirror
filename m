Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790389;
	b=XkZsIEu7tGojCC9QVONfSzIKw4hRT2xDvztv2jbW5d08Pw5tKPwu28JN9nh+PVvr2rU+
	 lKpj/QoX2FF/un10zdcj5wxDVTmaDYXE5dFlT7cH5Lsb9S/KHVsgr4WHcqrf/oKmeuYKG
	 Os2swQTgyDd3tSwODFENJM02/8F9j9uyWMdsrj3QYnlTZ80TbbDIM97hXcQjjhudkPHK2
	 HlDWYNXm/Q1tAQ5usvCzCzqCXszNZwXSGtZi+zQW4/YPF95RrF665q4Z1+2uKPDs2US2Z
	 Sf7bJRdO1FVW3xVX0znUgdcUJNFe96gMj6rLzkkVlddl3EfitRKWuH11RF0t1wC43Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790389;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=S46B9OblIV5MQWY4pACdbgFW8ApIEJnlOmcqw02BJDE=;
	b=IdT21Qm2JfIXvM/QHedXt7y00kx2G1ZujcoksaafHZJt8zNQJyHO5vFJKgOKZJfUmOuV
	 tPnRe/sJVFgedCXxh7MkPpenybee/2u2Rni9g2A9jsuZBC4/1MBqoQo5OKUzp1Sg2kQ1q
	 tThJZIOdxwjXWLyJPyONJKRXOF3U2ywY+wALaDBx7VsRTA7z4Zn0RupeDZOvSisdTQ5u4
	 HzfotzUpUOlkSG/vVnkJJc+UlrdLZk4RIduZzJInltU9TX8ERDAfG46bPLktUsx0UdJjx
	 nu07QPaEawKqZD6HKJOcIaqA/hnwJrTGv//TfcDSoksx7Uom+Io7VBzRaI2WDwWYW6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gkXqAZAs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fQBWSWIY;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47846606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47846606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gkXqAZAs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fQBWSWIY
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A38061D000B6
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:19:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 17:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792790387; x=1792876787; bh=S46B9OblIV
	5MQWY4pACdbgFW8ApIEJnlOmcqw02BJDE=; b=gkXqAZAss1OghAqsbRWxumHZy7
	iiJxyd6Eo65g50jrmJs2dpt2hjFO7kPNSqPtwp62WFE2s8X/hqkrHuWTj2g7umHe
	IlQOjQoKhdYL6rI/C4c+Vgyj8B6QPMTU1Rgo47qMnEd5bqWSTtsiHg464olGGCrL
	KNW1MHQ5/eEOzDKI6DI0ziAn12tgm7U2PTe26DWwrABhJAvvfMkS3Pk1n+T77S4e
	36Sa2t1YO22O0RJsY0ZNdSzttn2zV0Onhs2TBbsbT5nvPVn+mVYyVTaS9NJOizZe
	8q8/NYasyA8Dxjhv9a0dehfvDsQhiRfnX4DrtnJpsdgMbVqqSknhvlQboGrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792790387; x=1792876787; bh=S46B9OblIV5MQWY4pACdbgFW8ApIEJnlOmc
	qw02BJDE=; b=fQBWSWIYTyoCajF5rj3nhvWfnO2zS42+UeneOwH0fgQ+36324I3
	xe4C+tJTAykUelypTxwdArbYy1teTYEgGHlycQoqEtzwoYU4+t9hmCRiCRwqAveD
	gJB+ZnOEizdpqLfu4ijHVs9LyRy1xq2FNfdKZzoWtu5nOcqFjttojh1vaARZNKCa
	j2KmbUhroDUD8rpRUED+OsfvCu3xQc+qtPNiKzJezUUhRnxZrOoWAtP2f1jK/04q
	c4l94hEAsbfjRRnU3e4aHh0wp9wB2dJlAej3Us4bl05JU1FHBZEoiL4oM9EGOaNm
	basZMTqBjmjq6fJqNfmCO9OdNsaKneieByw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792790387; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:JlHNQvPHYF1lv6kSP4TTtkEpDFlwTkKy3zJGuI9BDxQi3q8
	RGxv3irQzWoXHIMFQsr9IvusRlE4lD8nqY9p4URgiFXJA3zURN0csUcgApxOih1S
	GLz3bIZySXdddCk49YVoEJJgvhgRbeoA6dRNo9fiybtxCEOg429wbv4qW/jEd+mN
	Uzf0MkV24atWpwfO7JHY3vV1qnNIPT3wmkd+3thlG6heE39NtFLVtnovLUIuFSSj
	NafQGwxDEl5AZWYj5sIOH+2Hzv+BBHNshjk8tAWCjarwD5J9Bd2VN28XQZB9a1hR
	r7kUJEe283ZhXsYKWhUSQLRw5C4DpAS9hg1vonA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rXb96OWQ5s5pvn5U7cWsuYMnEsnMl1kod/Itflhtntk=:fQ/T6v6zc7kOP0K77dS6CqfSYMIosx0xSIWxBYqxjnQ=;
X-ME-Sender: <xms:c8_bauKwemL0q27_AQxy-iSGU4qaxx62to8CB1MhNXEGkJL7gk0KwQ>
    <xme:c8_bap2d8Syckro3bqo3En14XMHP_Wwu_hLEQ5hCa-IqYJFgaOuknwLCsPHKQghC5
    EtmPYG921bDGWCLBAGt-Zd8orp3VaUVKAW_h6jX5vtuDG9x0x_hjWmw>
X-ME-Received: <xmr:c8_baoiE-vFbEBjzW-GmTB5iVzd7QZ8754rGt4rrO6mpd2Pre8PP9JPO7-yYHihN6IE9Jp7_B-oBqTvulHWC_rtYdqn-zli96OMN>
X-ME-Proxy-Cause: dmFkZTEBRrgeYmeyFrJr9H2w9HTrNX0tpOF6CWvXJja2kos+M3iRHuwv62UK+bv6GOCMes
    Csi0ydyiJgCdmTCrp+598FcuesId8HnXoQ/NTDx/+gtIXs4SXJiHZQdrePX4xFq04OIL7x
    KFjNmjXJEehFoXMec1B3ijJp6diwRxVm69cjLB9KtS2LSucTTaVVuIK48ksTYk7XrhqPI5
    UsIYxcVSiVT+9f5OdGFEjh6KnMsVIqV4p6UqEVqrqVmeIC+a7xoZrUVJgz+QGeXDNcAWoh
    cLh8lBl96By351yha4qvoHiYfpqzE9zAcpY8B0SIfnSI16r2uy60sal/MART8+z9HkcdJt
    A2vAZGldil3PkgMbaLgejLGIqXiE4SF/JWKSUjbeAMa6s8DmScS7v1NgpctiPisSUaEoGx
    w/G+cfyacnvypHT/Fpum3r9Yw83Q17gFT27EVA7VeOzsq4GGexrWqt/CLFrMXA0ND9G6yZ
    KTiWr2TixDIOwcjTy13o04b1YnMlztbd0wGtUk4ji9hY1YUMal2gE0Ya8mok/WztIQYQZt
    H0PJgyCUEfHmDAKIwS7jKsRHZooxef+3RSIpOjMtc7EOEAYE6ir8Hxu3569KYpBsC5YArB
    zm29MaMqWPiqLSK7yPR8E3fi0PGFKqLPqd0hEmdek2pAqh1z0XmJurUwCUcA
X-ME-Proxy: <xmx:c8_baqUNChyscoFCkAkAa4nbOodMqCjjp2XvP7Q2onMeQeBOoclZng>
    <xmx:c8_banXcGwmLNTgnCzaDtj-z-YHkFAfSeCmjCS8ISzMlpBGWGflLsQ>
    <xmx:c8_baqga-inVV3HWMGbg3hjRISLlY9KP0N3k0WbhkZyMV18qmVy_Ng>
    <xmx:c8_baibAWOQgMr8v5OGq9RxKYbt_bP49WifMK8mmue_ckxIh6ziu-Q>
    <xmx:c8_batvEFFUxLc0q0ksALXBkEHR0G9UNCUZu_mF98MWwpkiMpze8YlQG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 17:19:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 1/3] reflog: name the strings that mark switches,
 renames and rebase steps
In-Reply-To: <745929bd805784bebeccc7e3ddee638aaffaeded.1792348037.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sun, 18 Oct 2026
	18:27:15 +0000")
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
	<pull.2448.v2.git.git.1792348037.gitgitgadget@gmail.com>
	<745929bd805784bebeccc7e3ddee638aaffaeded.1792348037.git.gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 14:19:45 -0700
Message-ID: <xmqqmrs43yj2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Name the strings once in reflog.h and use the names wherever the
> messages are written or read: the "checkout: moving from " prefix
> written by "git checkout", the "Branch: renamed " prefix written by
> "git branch -m", and the "start", "finish" and "abort" steps written
> by "git rebase".
>
> No change in behavior.

Would it make sense to test the behaviour to demonstrate this claim?

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  builtin/branch.c   |  3 ++-
>  builtin/checkout.c |  3 ++-
>  builtin/rebase.c   | 17 +++++++++--------
>  object-name.c      |  3 ++-
>  reflog.h           |  6 ++++++
>  sequencer.c        | 13 +++++++------
>  wt-status.c        |  3 ++-
>  7 files changed, 30 insertions(+), 18 deletions(-)

> diff --git a/reflog.h b/reflog.h
> index 3bdd1ca8a5..32c3737db4 100644
> --- a/reflog.h
> +++ b/reflog.h
> @@ -2,6 +2,12 @@
>  #define REFLOG_H
>  #include "refs.h"
>  
> +#define REFLOG_SWITCH_PREFIX "checkout: moving from "
> +#define REFLOG_RENAME_PREFIX "Branch: renamed "
> +#define REFLOG_STEP_START "start"
> +#define REFLOG_STEP_FINISH "finish"
> +#define REFLOG_STEP_ABORT "abort"

I was hoping that we could eventually make reflog messages
translatable, by splitting each entry in the reflog record into
two: a human-readable part (shown in the usual output of the
'git reflog' command) and a machine-parseable part to be used
exactly for features like this.  We would hopefully need to update
only reflog_message() and its dozens of callers to make it happen.

I wonder how far this change will set us back from that future.
The best case would be that this detour does not make it any
harder.  The locations this patch touches are where we would
need to leave clues in the machine-parseable format, and the
locations touched by later patches in the series are the places
that need to be updated to look at the machine-parseable part.

The changes in this series looked sensible, though.
