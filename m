Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596345;
	b=vBc8X92rUIq/gVNp0THS6OQYFnJ/adbLKuGLN4he91UzRoRWXRupkXcoXtl7SDPLeSkr
	 A/1R/xOABapGHFzCSGcj7rjL3PsV2WLUDAWdXE6DegN5k6ABIJIMlEmiz7j4WSwICsgJB
	 23ggL8FHpgYc8bI7NtmRdmIkUrzq5BTczg/2umFb+pyqPpa7ixZjhLEGiuv1j5jhl5Bgf
	 gZelPuLxpyymkkTZMce4+55+7YqSgtYj4/1U0SkUeAY8jVWR5VuevcFpnto6uXwECBezw
	 mIBUOP0AiUUjSt9olAp+LVAEwuDedCWRm4562E541B+I0ai9UArW7BWxEhFu5hctsyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596345;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NmN4AinufQxEokKNZDmZnmFZCdbvxOfup61RYs0TtOc=;
	b=rbrj33Q5XkBuF3Dv1T0wqODd2c6ei1EqptQUI60LEZP5c/EMJEQuN7E2Q1z2K5Y2YgRN
	 AAFD30+Uch6rM5AkOiwzOMMlVruHzhGOEIb8wUNrFh69KbQuBaAGO9f0/J+UHAdqEKZFK
	 H3EJ7+0+U9a8ADXgJwGsv4CD+LIF+aqoy3th44EMHqTzeCrcNbecEM2pDCaYy2ay+Y/Vw
	 k/xbaLTL2u6ZEf6FyvQeC/yuLJJ//7AtIq/f09jwqoLkws5ASw2p9eJQkfzzncO2xYazN
	 KXkmjblg2ntlYf7jX7gqRHz3zJFA3J4P2ULUY4gaY/GeF6/97d2gPT0TBTPuBq5bSqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mPdiK2BC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fY4rQU3f;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD109606B2C0
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 18:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD109606B2C0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mPdiK2BC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fY4rQU3f
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 158B57A00EC
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:59:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 13 Nov 2026 13:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794596343; x=1794682743; bh=NmN4AinufQ
	xEokKNZDmZnmFZCdbvxOfup61RYs0TtOc=; b=mPdiK2BC0JnUDAqUUBeEW9ceML
	r8+5DGN1xUXPGmOE6T62hIrjGXMd02cQE0ZnoGAPKX51GFkkEFu56GnK2SrrfBRi
	gMjs2TTBxYh9rCCqKdPtX1SkLYfMuPUJa5tLeQJg/PMTprzu3Mb5FSbPc/r4Kybi
	Mt1W7xkKqWJJIptgGjSYsB4XYHMJMEqx/n942/nqy0HZMhULKFclw6PEQstxTgnl
	qH6DFIoh5IZVbtpR2zYv70Z9IhkbiAuzE/o2fvRqgfMbSK2DcwhAQJfe8qPNBWyD
	/ZCPlbWKY04PmeLuSawwRAe9h3e1WRktGEwCk/9a8eKGBDNqXgcLtCvmjkdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794596343; x=1794682743; bh=NmN4AinufQxEokKNZDmZnmFZCdbvxOfup61
	RYs0TtOc=; b=fY4rQU3fDwS09kgXk/fC5enEvCH1iX8Y4OCAmYPfk6EQih1yoek
	Vot7JajfKxFuzNnLRKqQAR0GyE9YUJSDj7Fz1V48cRuzWwDKqtRFaRhD5xH2wiCv
	y8y2srCP7E6j+qTmJQIk+Coqv42TaKWaEKQ2tDdZFCPg0dgVR1uJCZH8EJPlCSNs
	tRh3Pa/WT5BqeE2zPpZdC2KZO7sBtrNwkHn8+Tl4T8qv/R+yluOb9YHmrD9cTG7S
	DlFWRGOViHeoHYFYthuElvVSJi/imqR3PBs1DwWO7T5ecI8XDx3IId2kbvp+qGKD
	aKVTd77SThHKMPPXjsi9uVTUYrqlmdLPnmg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794596343; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jeHM8pNnbfYIpnlgNdvrtV8QIClVZCMAgZfhQKEvK8cuaeF
	ViBtHl73xvgWi1l8Jrssd6XJEQvBl2fO/vWn4/db8MS/s93tQb6IssoC99qD94FK
	JnZb1kMMgyZy0283qvMVYBpsfUaA5rqjedyGHUHP0a8Ywp6MJwKC2V08lBVzF5Be
	EmOjOcpO5SivURkD80gNxmgUd7mzwXsiBCsGDULuVR3IJDAzJVPuioQPYYktIBxD
	VREUxFDwoYeByCSLET4S1tpHmJDQke6IRhlb2IkRI21YgEBjI9ade/HhPZDiOms1
	iUb2ufGKxtONGdnhlRl6JtiQo5y1hNL5hn3QE9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:AnTRPR13ucFtzt1PX27lyOMFFEyhy5Bbs9znbO5h/is=:iiPVvpgISU5lJi7qJF/bknfrV564oxXUVrHiBTl7SNI=;
X-ME-Sender: <xms:9133ar-8vODHLHecJOGnnPeXqc63Vj0eXi5lcOQzVyIijoawDP5Ovg>
    <xme:9133amzybHLkeISaE9vLZxu9U3TC2mcqtf0Q-ElQqSaOk2nPOwUuzwOeLzifO4JOK
    aNlELB3uQ_Gdd0E9_MrjjOUCgO8QbSeFbz1RJ9NId8iSeHhwjUCILM>
X-ME-Received: <xmr:9133avP9TFGW2uomA53a63r-UyYddn7HyeQFyz5zZbmEesJYi8gJGm8I5uw9j0B9zMA9BBgZNTQwXYp1nGPFw_LVGpr1VGpRzkDH>
X-ME-Proxy-Cause: dmFkZTEe/zjN9ruqpG2DiYhO1/oO7PrgI4p1rvdSX7yXVvKlFfAJ9WrPyj9yL3G3vrL6Pg
    MT7eI4joDHRmlylnw97BUI2aSQoW5/z51dptjK/TW/yKCwxFk9c5AWKa6QKNstms2msdD2
    9/GmxDuZWiPdlvPlQfWwfu5k+47W9RIdEErVpt0qbVWwx6ZNPWd0HEEsO63pE5SyrAvOFh
    9gtL9XKG0ybIJcoju12JmmGK6CPx1G3sbdGdLoGL1qZO/5VZrpzNJAIh1ixsyOcYqpFyqj
    dUGJ75KTGTM/LIO+pKKO8Fa6xKOEEKpRGgTyOka5bbSeRYr8RvJ8w5OOTn+OCOuUcLfmph
    MHEn0+e/UihOopY7FqoCMPhVqz4Fng3f2o20w8IMicvCs/2IhM1X0n+d1iQJQy0qCam4NW
    JECEQ9WkqQ/aSpemxjI+4xevxh1BAytoTtj2NJMMxdt9g1kKfdJC08Meh8LUx+enwINGss
    hwgnWknTD1LWHfO1uDZ/XJCnktHQs44gTQ5efIIKHjlg1lWtfh4qe7kIOX4Y6AV8qLNIVu
    g/WRPKXQ2IkUn/EM73jL5ca+VwMnI0c118lhXMl6Je1d78n+tkHDsv/7CgGZyZgmrSt/HX
    3iGTwcUPkY0FU8cdw4m8hFW5tmSKKxZXOd4qANZesKRKoMJspTcp5Uiqv2sw
X-ME-Proxy: <xmx:9133aj-Q3RRnzOxXfY7WMAqhph9JVEr-VkDL_m10wHUFq7F_2FQ4OA>
    <xmx:9133ak6TQbZh-q4nQKXsZCG_ACZNP5C-Pq6VIwTuxEEClHuioDVX-w>
    <xmx:9133ah7K49RK1a99cxilhcwvaVGQgHZDBfTiXobDJESj2x6QvTl5Bg>
    <xmx:9133alpT_ybJXA7lxPMh26W93JMc6REpBQwauf2V18GIdCL0LajrGQ>
    <xmx:9133aonLw6t3JFJ9Ac2A0xGAVVupXIKHs9d4cddZ6_s_S8pbI4yfczfG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 13:59:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jasper Mayone <me@jaspermayone.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  sunshine@sunshineco.com,  kristofferhaugsbakk@fastmail.com,
  ben.knoble@gmail.com,  haraldnordgren@gmail.com
Subject: Re: [PATCH v5 5/5] branch: do not mark the branch the current
 worktree is rebasing
In-Reply-To: <20261111152811.99986-6-me@jaspermayone.com> (Jasper Mayone's
	message of "Wed, 11 Nov 2026 10:28:10 -0500")
References: <20261102182930.3511-1-me@jaspermayone.com>
	<20261111152811.99986-1-me@jaspermayone.com>
	<20261111152811.99986-6-me@jaspermayone.com>
Date: Fri, 13 Nov 2026 10:59:01 -0800
Message-ID: <xmqq8q2wd0cq.fsf@gitster.g>
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

Jasper Mayone <me@jaspermayone.com> writes:

> Since "ref-filter: name the worktree of a branch being rebased or
> bisected", "git branch" marks a branch with "+" when a worktree is

It cannot be avoided but it is awkward that we have to refer to a
commit without a carved-into-stone object name yet.  I wonder if

    Since "ref-filter: name ..." that is a few commits ago in this
    series, ...

or something along that line would help?

> rebasing or bisecting it. In that worktree itself, the list already
> starts with "* (no branch, rebasing topic)", so a "+ topic" line
> below it shows the same branch twice.

Two comments.

 - in what context the command "marks a branch" is unclear.  Are you
   talking about "git branch --list" output?

 - does this talk about a regression in the middle of a series?  Can
   we avoid such a regression by reordering commits in some way?

I seem to have ~600-700 local branches in the repository I usually
work in (with a handful of worktrees), and I do see the list starts
with

  * (no branch, bisect started on jm/worktree-rebase-bisect-checked-out)
  ab/describe-no-i18n-of-debug-messages
  ab/index-pack-retain-child-bases
  ...

but by the time I scroll down to see the branches around it, I suspect

  ...
  jk/test-lazy-prereq-heredoc
  jk/unit-tests-via-test-lib
  jk/xdiff-size_t
  jm/t0213-skip-emulated-ancestry-tests
  jm/worktree-rebase-bisect-checked-out
  jr/bisect-custom-terms-in-output
  js/adjust-tests-to-explicitly-access-bare-repo
  ...

that I would appreciate the branch currently being bisected marked
as such in the list, together with any other branches being bisected
in other worktrees.

So, unless I am missing a use case this change is trying to cater
to, I am a bit negative on this change.  If the [4/5] were solely to
support this step, then stopping the series at [3/5] might be
sufficient.

Thanks.
