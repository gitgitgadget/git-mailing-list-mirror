Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913752;
	b=b2yVbn2FOMdEsY0zbcuJ8rQaLKVB1ek8+EAAuTy/TvifI9IQuxdpLIQkA+6bJjaeaHF6
	 BQXbgTsO030kkXBWWLc46dNQydYo2VK7UvFJbfvUTfemjA9ImJAkWabdkv0nCu4rM0npH
	 7FhrkfLrGpMnH/f6l3HKMObyeoHRN9SrWnZ+Cs0BJH9/gd5vVFB3iecmigjswqTsozQ/o
	 ncI8LtYSGOTLtAT26OLJ1MpG/Opay6P+wSahcjkEQLtQQEl13/Wd0pb6RVmabhxa7Vk9x
	 bL2sHE0+0zwPNU16KEsXQXFgkJ4/DhVMfFlB1clGLALveDGR7cz/CTH/p14WqtyB4Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913752;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=F1BHWCo3hvpORl+Lcz/kqjolZpmrojP2FvLwIY2PqLQ=;
	b=4ybnBmX+AUuuJfNq/spqgif6fET6IacRLO4xWqaKG+HtYSYf9j+tfFhYq/Av27Woisb+
	 xIypUzatRBA9DLsuEpVt47JOsr0p8/c+EqCRmV/MBd91R1cOzOHbLHJL0AoMGZp1+XkpX
	 8KZjkVVAjd8H9vQJBQ5Ei+e/brZNIZhDcUEfrNqsKZ5tdus9MTrbh9ZxBtbcOUj1pxJXC
	 iV79ihe+5s6TuGZVi5vk9Cq+ZjRSiKLv1JLywzLvOipNo0V/o2QxJXYdJ+Ur9kYwtN3oN
	 n5pb+dmJaPTwxuyJhOvmqnuZWfVWmJ63LUIr/re4QiwQCV84o/q1U9X3+MXDMxHFr/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZvcM1hK+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yHcp1w3C;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD70606A339
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 21:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAD70606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZvcM1hK+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yHcp1w3C
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E74D4EC00AF
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 16:22:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 05 Nov 2026 16:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793913750; x=1794000150; bh=F1BHWCo3hv
	pORl+Lcz/kqjolZpmrojP2FvLwIY2PqLQ=; b=ZvcM1hK+X44n64QL3S+RMWX428
	jYBkXZ9XDmwdtAV8g1LoxPfPNcLheulm+xLmpzJd5P4S6eXbUoEMrxrDK7YsE2QK
	8i3pPbW0ArWXszaNMttl2lv3Yrf8hga3QDHvVjD5wZ4BnxiX+aLM66GALhGJXWrV
	BGgT/ukJ13TqxtAWuGZUmeRyTmqwP6jnOIEuVIWFiOYL8uZ+xKZYuTAfGhWXGcnn
	kVW6OaH+OqW3wSYOdNJUmdIXsh5NtT/ZJN+R+wNbNef992QkqwYx4NKLv2TSppli
	FZeNgBqhvOdPaHyRlIxr4qmcE9xWpUrShNV5LYPHbTR7KfFYyUpS5wLs+G7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793913750; x=1794000150; bh=F1BHWCo3hvpORl+Lcz/kqjolZpmrojP2FvL
	wIY2PqLQ=; b=yHcp1w3CluDZsnBTCnVirV+tIgukQ92uv+i09IPuNC3JYgibkhr
	M1bcP/06rjT8qLR9hlRCZgMvjaayH/6VvK6VfhUuT3MzvPd7mAinvJuTT6d4uoDn
	HP1GlCYCBp08elLAero2GYcPuTtz2hzoKYvfuc6CIBxDKcG0Cg/896wB7Hab+9O2
	QiAnds4V5GUhr1kpDe0n9tKl3ciJrelEIV0jSc/A1MLuyjeEnKxZrbbmGXIS9No7
	lPaGtvl07R8Uq7qm3EqXDuc7ISsuyUX1HzRdY4mRY29TYBDnphL/DjFzxgWQhWCz
	gtJU2anknoNjmUZVOTJB174aQOwWtyVqUpw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793913750; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RXmXQ0itiBdMJ4ILR29i3CcWismFRAJqCpgjQC/5ssOHc0f
	4XisTERu+piXeJK19HFeWaALra8MMWLBQ7V2wmOtQ/a5qwt6nDWW25ixsXGLkb05
	wAA+u8KsrklOvp7+XClP0OwT4YVCWsBH5P9uqUuKHOQGx8yHFmAMRkwds0AfG+RE
	Iqkx9TsoE9t68wfxf2wOyUnPPt0CAEpHJrprXCZqWrZ+PI+lNH4bbsgrrCp/F5xs
	LYv/BHymbQj7WVd1FBRsmRF5YcWSg//m9OOrdib0VOxQGi+BqR7Swrcv/UubrA+z
	6EOOOnnss+aMtg4C3D/PfYgG/ZgHq3B61JLSCaw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zdQ+imQ4Tsudmmv8TtVqWDJnj1qYV7mVguudaF+wIFs=:LB1N+vkRyYsqt71NI2LSSfSDigIKb9CVmqESuBM+Xw8=;
X-ME-Sender: <xms:lvPsatNuG_AoLg_kBY2nJKGY02JpNeaj8_HjGr5VLzAygs_OUFDCvA>
    <xme:lvPsam2o8CA4NIOXCjihY5LolZnnnJ_GOfoWoLKZ0rY-nr2fD_alVcWh5WbSaU2DA
    -Nt_XBIkd5yvDfnjVRGFg-bOcabe-fRCDOV_D1NvQss28Q5zH6vMAU>
X-ME-Received: <xmr:lvPsakk3WKuST55KUE3LNcodeg32cPddKnR3HK3wgxRhMSQb0oEnXOrzfGF30fULZy_HheaGTiWLUhy84BBr2smejOBy-FsLHEMs>
X-ME-Proxy-Cause: dmFkZTFWsc69SsjbwrTndSI5s8AjCmIWHSfcAEBlXD8juzDZ0ySCB9Q9cUACvf75e4REqW
    HTCsDagAgeKkToni31IzPyFqy1IDy7cEdCS7zw4lLriiNr7xuZULEKEW8J6yxYpw9Jmdmh
    O0FnNEc9P0MuDZBPXITle+ylALXNxdBsVYjqHE0rme15kIO2fj3NxPXjkeQIerY2DR09HS
    EilVZr8GdqKBFj/9OORQP74xmq7+C5j7onEQ7uUe83ZDq8Np/heex4UbpvoMO+RRuj9Ah+
    cnqkIsrCo7+y/tdaMhX9wyWAozqk6pYOARDV5KbPh5pWgWbdsbJXjAbFuePPKR9x4ha6Up
    xM9LeiupIxit4OpDMpzet0SUvDo+Ki+aA1TqT59+gIFQFCt7aQTHf58ZilaZWuHcopUBfa
    U1y7HpFpz6zO1Ho3MUk+2j3oBSwZuK8R73vQjqbA0CxEX8yzIDFfqXNXOnCYFgXCrZbGwr
    auQLJlgfLfXAmz3Nb2C/IsSkE5RJ9IHz0J6jwugnUsNncCpWEiogYQ6cEMcN18s9YupDC9
    W4GbnRPVQ9eoQPlr5Dpr9R/7qJTIL50Ai60p8IIDwUva/DJ2S6oqSTDBEF/ibl9l0QhVvR
    nDqrVOPCk2YG+/oyS6oYxEIDMh+rkWhmlEEpu7D2EI5l56jou5tdMsY6ODcw
X-ME-Proxy: <xmx:lvPsalVKKAHw75TsDsboER9E_bttXRZ2l_KCN79gCKm8-o8rtxnJUw>
    <xmx:lvPsaivBYSK53Za5g8LXI5WCqaaiiLR1K45Y0SBR_XBsk_T8YradGw>
    <xmx:lvPsagY7zNhbVMvKeAS5pZjlWoCLqYtuddqZ45QRSwA1rY1IJzWJOw>
    <xmx:lvPsapXNvb9oVbpd6zQN-T6I-T0036pGerQjtrcADC0vEX1u8Npw8A>
    <xmx:lvPsaskINlyEQ1goNgaqp5pDm11mfGi41SxE08gLavqXyDXoR8PEPxtN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 16:22:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow
 clone
In-Reply-To: <xmqqy0bbhyit.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	02 Nov 2026 10:35:38 -0800")
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
	<pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
	<xmqqtslzlhbm.fsf@gitster.g>
	<CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
	<xmqqy0bbhyit.fsf@gitster.g>
Date: Thu, 05 Nov 2026 13:22:29 -0800
Message-ID: <xmqqik2brn1m.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
>>> We unfortunately haven't seen many folks interested in this change.
>>> Is anybody interested in reviewing the patch to give it a push?
>>>
>>> Unless we see some volunteers to give it a review in a few weeks, I
>>> will discard the topic out of my tree, as 'seen' has been crowded
>>> with topics that have been collecting dust without getting many
>>> reviews.
>>
>> Is it possible that maybe the review process needs to change if too
>> many things are getting stuck? Rather than discarding acceptable work.
>
> If it were acceptable, it would have long been in 'next' and
> 'master', though.  One of the important criteria for being
> acceptable is whether others find it a reasonable change to make to
> the system, and I do not know of a way to show that other than by
> positive reviews.
>
> And that is why I pinged the thread again.

And after a few days, nobody in this thread is supportive of this
topic.  It is very unfortunate that the discussion thread that
starts at https://lore.kernel.org/git/xmqqtslzlhbm.fsf@gitster.g/,
which was meant to invite people who are supportive of this change
to talk about its merits, has been cluttered with messages that are
only about the review process, which I was hoping would happen
elsewhere [*].


[Reference]

 * https://lore.kernel.org/git/xmqq1p93ofjx.fsf@gitster.g/
