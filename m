Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394026;
	b=thCtbpzyZBO9etv2ILtQ+hu8PqhkBn01Z7JKeuG1uypXQE7/nr7flLoQ76YyarqJvMMy
	 XfWEccXf57fD2XH7gcOKHDZ5/2jtMiM6R3IoxvYWZM0eXUuqo2p1YzO+E3/4zSQvtYIDK
	 A6mvL2CJgq74ggVfZs3a1lPA9FPTmFo7E0u+OXtX+TY0QxXwKcqYhhgBorXFdbsq0eVB2
	 CGOQh597dDxhvK0B9XAkyA17lS3/g0ae5/IdaJh6VO1m2PkMclbqq1wAn4KRxmW9EKu+l
	 qxeWCmpTKEus7T49slEJ1CYmSDndx9I5Fu4YIoDAfGCEc/hP/oG+/Mq7eTIhI3M2xtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394026;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cm77YZQBNdwtxoJvK+ea5KOrVJYAC0Gm+aLH1UjrsPA=;
	b=PhASZ9oTo1sJ9F6VToP7iRDnuMHP9WucZw+VNFWGMIueXnNPXrZUzODs7gKlm5Y5YA/g
	 ONBWjQHSp7e/pEUPnd2S/SqTz1GkmWVnYxzjsajqu3E6l0c1DxcAzFEK+H59a4RTLQPLQ
	 tl7CkIOUbY7g221LWsfN7Fp/OV7UvwWX/7NFjs64ApeqMSb86pQgfyqtsmvb22tnrPTgt
	 As0CUdgFMJL4T/i//4bf2+R5zn24JVxM3DEgrxgUDIAktban2lYwgZoRgbbcHpuikLXkr
	 4mXBJJYOWVyIII0dm8uEZ00T22+c5viW+nWIXKuMS+piGiPucWYS3E/KYf28bva3tVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ahnSIjYU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iuHTOi8Z;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4B606A324
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C4B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ahnSIjYU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=iuHTOi8Z
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E587EC088B
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:47:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Nov 2026 05:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794394025;
	 x=1794480425; bh=cm77YZQBNdwtxoJvK+ea5KOrVJYAC0Gm+aLH1UjrsPA=; b=
	ahnSIjYU3i40c8ogFqM5eQ6+npYprPdLfvAbdAKo7XpceEHs4g+TDRfKUXTvX0zM
	crHS6oFNVyzwflmylDXJ2Ccfstc9IvyxY7ZNa1T1PgjaOA1iIxIamjLBWICZ/+Ao
	DNKQKVGZmdCmOkbrie3ZCVTDuVNaquE8J0AItc/hSKjBgXzL5GxtGvVyUu/Z/Z9l
	IUQ78Hs39Jv8kEFccqSLrx2rbyF3fEAjWPaeW9Vv/7vxyz8jWApnZT2KbR/qT4Qp
	Y4ZqaqnpUshonWijes0ai4a74+lhHOMSKysrASqbBwi5oHqhywbg4OGZQgFypWX2
	RdF6TN2vVGddm1XgHpjTsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794394025; x=
	1794480425; bh=cm77YZQBNdwtxoJvK+ea5KOrVJYAC0Gm+aLH1UjrsPA=; b=i
	uHTOi8Z5PLcm1sRt9f1jRhzOwIGRw7Jbg+xU+80thM211mHNMXttAzZ1ab2Z5CZT
	oHGNXi4wq03mOQ97P6lVBRdOFb0w5kl8OGiw3varZ212YkfJTlRIZ4Sgcq2un6sk
	NEDuZtnWb3OprRjNBdpy7EDv49YGYRL/r5bKfQIUQ8XibMTFDYdgZ8hTQQDd24y2
	o/r2lgc1Io2Ny5yBKwDOiJQpKThRXwB20wJUO2z6idUFPwdZwmctS/djkSRl0qdC
	TST/4Uak8gu7Xl9GBqQ+qYXdY6zroY7S13UvbFWdZjSa5tipcTr2m/S3mRN/xd82
	4Ahp682vqc72+vojWXZQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794394025; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:eV6CYlWxRUlEep7qqe+o0NIiw4QZxRD7/tLyAbC+5kzn9JY
	Yn4l75z1vdTQvhOOqduN31DnBoh9imCsAD7C8FgmIiZYJB5AcG8Cj4PcU2J686Vj
	uEKyYEtnkQdmld90YJym/Jctb6B0kIVah75FsUsRPDTXCfdoLT2jNWVhAgVu6HnR
	lCP5nTGCDbTWodG6bGm/gl9iBQxyiuMUsDgKGYHgxFDU9hXmXfe5o+cbRR7X47U2
	HJbRd19GLT0My1BisZeXhJDrK1zKhHh3eMJqz/MTUBHAxXFnokgPDtcx/Titm+hO
	kTqL35gv79nyZURQcDvgt5yWZ+OLYbBUHbOwmvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7mjTIs/EKyeXbnCGstfcXpGVRIrK/GAmSaMdfF77BMY=:ETrK3+GvrSuNipSk3+yZDggb5loIpyItgOA5XZCEgLc=;
X-ME-Sender: <xms:qUf0ato-JT8RUu5dV8mmyTW1E7wWmyofSt-DaB1BG5KqEPCoBEUYOA>
    <xme:qUf0aklU2GPYGrOYY1nDtamSDOFD6x0M9dKBLIcV8IkW6zy735YW9dFSYD2X96USR
    JHcLgMUG3tugbQbX_IZY_jnbsBj2iBPxARnZz9uiTduhEpBfukv9nQ>
X-ME-Received: <xmr:qUf0aueooWEWHfN4KQMpE7FLOmrwDCfR69iWj5GclQfAnzevzPsHjqG46APiOTAfz9jNdQ>
X-ME-Proxy-Cause: dmFkZTGFo5eiW7+AEvzMYlQ1MSjR7qdB2RExxRVI6PhPVe13T1ySL9a/VxDMfvvBoTcHdN
    BJPP70SYOzT0LRLj1NfaxQfgJKWKUDuVRszk108x04YOaOjiKgtP4JjFiwRmBg6t2INefn
    2yKBm43Z5gLcM8OValaRofXzLVrrc5TKtOwoKGVwUa5fzv/lEUSL7AJugpYVtrF3bHwpAF
    3tL5LiPHe+yPANa0qB2fAFJcJoqmY8dTvo0fRSgMCMQHAylLParTw+ZOmIK+jbQTL8F5aG
    LFtIZmcjxDqLduPzm+CwZYxD6PFVhAEYeyywsfhZXJcD0jLm3IOy55Vz2JCFA4bTZfiai1
    yP6bDtzf4LaNIux81R9+pOsb0b0pYZMwr3bnM7BnO+b45TsiG5wcQjXWeslSpKWN/CTIu7
    QrFUNAu5ZMqIm4PKrEhqGiBt3OGdIFD0CgSRSsEpm+6ivwFY99X0aRNFNZMFUDjy3DtvKQ
    I11hMm7chvznYQRePf5JjPiv7hIRb7wYtDAIKXrHR766BMllCPhpODCI7Ad9ajNKu/+hJf
    jvrEp+J708/m8MH3Km/fv3Mvq7IkBmSy/SXdFQYExEP82EuBvRki70/lmQ8cLj0yVQAWgG
    pPohh3Dgjt8W4rbrFrKFa2O9Vc8l0qREYFoglqBl9nlTAehwYxWpkteje7aw
X-ME-Proxy: <xmx:qUf0aooqKuhKY5Ukoe6H0qKwsN6SdayQ4e0L_s-Uc03xAU8337kHkg>
    <xmx:qUf0agMVa2hU-se-a7bdjLBvmM-maF9ADdK-009oCM8TXd8eYqc2qg>
    <xmx:qUf0ajiLCBsTuyfQ4f61dwiTcy4dMMZG2fZkoq5L5__WrDDLPYddlA>
    <xmx:qUf0arvP_YqdCeHnelu89INrTM5OGY_HjY7-nRJ0B7-qKHZORchz8A>
    <xmx:qUf0aogu_U-e67ttZL3WHipYwRrcueAij1ATZzsiY0nBWznry2YQH53B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 05:47:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7d48630 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 10:47:02 +0000 (UTC)
Date: Wed, 11 Nov 2026 11:46:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Jelle van der Waa <jelle@vdwaa.nl>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
Message-ID: <avRHowwvxoo3e78H@pks.im>
References: <CAOLa=ZQowi+fepj+RNegTZhK_Jy4G8VLE_Af2UdsO8-rCdviJQ@mail.gmail.com>
 <53CA2747-58F6-4A7C-81EC-33EABF0000FC@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53CA2747-58F6-4A7C-81EC-33EABF0000FC@gmail.com>

On Tue, Nov 10, 2026 at 12:15:20PM -0500, Ben Knoble wrote:
> 
> 
> > Le 10 nov. 2026 à 08:13, Karthik Nayak <karthik.188@gmail.com> a écrit :
> > 
> > ﻿Phillip Wood <phillip.wood123@gmail.com> writes:
> > 
> >>> On 09/11/2026 12:43, D. Ben Knoble wrote:
> >>> On Mon, Nov 9, 2026 at 7:06 AM Karthik Nayak <karthik.188@gmail.com> wrote:
> >>>> 
> >>>> My preference would be to make this (current patch) default behavior and
> >>>> not even have an option. I don't see a disadvantage of having the diff
> >>>> always being shown and it definitely is a better default to have.
> >>> 
> >>> When the diff is extremely long, or if the user has other means of
> >>> obtaining it and wants the editor to open quickly, it may not be
> >>> desired. So I'd prefer to still have it optional, personally.
> >> 
> >> Another case where we might not want the diff is scripted editing as it
> >> is much easier if the script does not have to worry about the diff
> >> getting in the way of its edits. Personally I'd be happy to see this on
> >> by default - the history command is marked as experimental so if having
> >> it on by default rather than following "commit.verbose" proves to be
> >> problematic we can always change it in the future. If we were staring
> >> again I'd also make "commit.verbose" on by default as well so maybe I'm
> >> biased.
> >> 
> >> Thanks
> >> 
> >> Phillip
> > 
> > I'm on board with this suggestion. Plus, I see 'git history' to be more
> > user facing and it's always nicer to have better defaults for users.
> > Showing diffs and verbose information seems to be inline with that. We
> > could add an option to disable such output for scripts (but that can be
> > done later as you suggested).
> > <signature.asc>
> 
> I can live with opt-out as long as I can turn it off via config.

Yeah, agreed. For me there's two important parts, where being able to
disable this is the first one. The second part is that we need to make
sure that such a format can work for every subcommand of git-history(1)
so that we don't have to have multiple different formats for it.

Patrick
