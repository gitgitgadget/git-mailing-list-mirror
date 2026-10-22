Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688251;
	b=WYs5JV8Uq7MRmYGWrDRPI8xfUdkf5+p95c3hPNyC6Pz1tVIaDfht6D1B3LncxYDlS9RP
	 YxBVGJxIks9kXuxvRV5l8leBZ9iGLDeyDXy7WBBb38NzxY+AAtyrUNqC9D9FO9/fxOh5o
	 eOYbJ97nY+VqgoV09CaPL00tYcYf25wHfw4LrUlEGszKoOW5/XMR4rFGAkbgi/n1HFNKd
	 mL+QAVOvuWlINGKpIHSeUsA6cfnRjHoyxgy3M3XoFevx/0Gk0tHeWCkTKFGJRWgKRiI0B
	 Cx6SiQDVJQJfcGEoVEjdvP/uLSSns8NDJ3Qgx+cBgeOe25/84HmH1oGWjYBDU/vIcDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688251;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=EGuCEWUOZdP1bpg21ZpclNVxtNh+SDAbW8v061zDhLc=;
	b=KYl+yoyC+9I+otS9dmk4WflUhP7UQubzA2OdjYsdvHct/6fmB078PwKHW75MforvHgvh
	 4WxoHv0iM9LCu5rzLBJTnjbpnvkiYEKNQBFXHMVKITn/ZP/S0RlYa3wpvz34s1tHah+rO
	 XKeXwEJAVIxjcwd08+0xiENG743XrppCaPWX1qT11xs/4gj2l+t9N26OD0HiPIiOHe+Xe
	 GCFd+vOkHlE0hDb35DxQHNAakiQpCH4ir84LwFSDCfYP8itOwscDvucEXYQthZuCy9tyP
	 ZtZYvB/lZzJ2TmW2X1ppSC41H00WOXOykbrOCWnWrq4lYVFvtzqJTSeO2lAg30qMsIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="C/+n1xkO";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ORcgaFMW;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B26606A31D
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 16:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1B26606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=C/+n1xkO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ORcgaFMW
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 10F5A1D00166
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 12:57:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 22 Oct 2026 12:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792688249; x=1792774649; bh=EGuCEWUOZd
	P1bpg21ZpclNVxtNh+SDAbW8v061zDhLc=; b=C/+n1xkOAmQ7f6Qt2gO08swaWX
	edGiRDxR15tVAXaOaIeQ3tW0WphKKvoSg7CZo5mg2Mlt+AzDt099I2zf5xDNyWDT
	4DyYaUnZBK5G7nNjM517xILPI/t9BbbiRRtNmTs+Y6yannb1Ht9BY+hzdCk43Tko
	wGuLo+pucN0AJ+B4AZNunThPQj2Gp9wDc3MJ4iC0EU/kzOTdVthVQ6crb0lbSimi
	nSs1ob3PCB9vFTnsMilgenmflfu3VUR8qc4+dqZUbzmVGsDK8P5xoyzzuTIgibUK
	MDPHjBCMHiFz4pYNwoNuNn49OQwFQEGH/O4BVDpA1dwpbOYk7RtHOvJvsM3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792688249; x=1792774649; bh=EGuCEWUOZdP1bpg21ZpclNVxtNh+SDAbW8v
	061zDhLc=; b=ORcgaFMWZZWF3zrRbLNQV0wlxJowd8HBronMbM/CI+YuOt8j3rL
	sUGxPu5TtFjGS90qYhyXCu6qBRiDIwizOMjHK81gQ1K85a9LCb8DC+r75BDJgtJ6
	oq7qrPfcDHnmegVxHt9IORB4YzOHlSAQq7XnkNYAINN9qfKb8beY5oR30Qw6gWpj
	FdXey2ed9wmcn+3w42+9YEXWH0H2naKd9O4lEpjHA/HLw7FsjfRkbpjoGEara0+e
	Z8Q36pfda5ZJMzxQc0dvSdZKLHzc6i9+HWmIDJjJaORyJSp8Wby1pp4WRCGqD1me
	/7LsVbb7htmyLgfFdcr2CBAXrcz95d+LUAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792688249; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gHULyT3c95NAYjNaSJQ0Pd/+ghiqz/cCm+Zlc5RRjZp/9QH
	J2IDz8ybWXAy6MSemxK+0zAaDh6wQVAZkNoS5uC1cDAIunHbskbad5cRSlHEaUyy
	7mo26Y8JOKXUU3d88pm4bmO2af1ZM/eJkvXt/GRU/6x6rSPD2d/yonEnvD6DLGP3
	nHeibrdw2W6Q59lQqlALkhLflC8shJTSo6ZQWUUZqGdAxCrsx5mVFaiTAdjchMlM
	OgMEnmj/UY+z68kMjFrV4SLktSpjOAJIQ+smu0bTEsm/YIIx4aJv7OJHxrsuYqJH
	+T+r+z+bJlbUOSPcNOkhwbQRy470IkyJZb2vJZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/TLdZ3v8O59w83teuYGvQK/0RPrsGmgPR9fdJlpKzgA=:ujXAtCtb68ADqusSmE8fBRdZDbgozNXOornIKS0ZT2s=;
X-ME-Sender: <xms:eUDaaqp6EFsC2d-p9rFf6smmwxa5swPgfqwGbuOkZMEm9Oc-q65YXw>
    <xme:eUDaanvxWaNlIauxrweDY2WJqhaKiMyuVVYZ9grQkw_ZzadatN41gJpUDz2hRqE5x
    McziJacmq0JamxnDQ-NzQcxPZRosecMX_CjoeId1KPp7XgxP7dh3Q>
X-ME-Received: <xmr:eUDaalYRMTfitHHfyBd40D6ogrogFeYj0sQDRoV_LP8pUjW79Rckx7a1V9-1Dd_t8-sicJaIXK9TpGAUYKyCVwqq_U2GISzHQDk2>
X-ME-Proxy-Cause: dmFkZTGWOUNb4WK5jPN3BjQUNEe6hfh76gqzKY9AMCVMu9eiyHxusRcb1ROyfIipVBfy/j
    oAxhs2QRzY3xk8tlMEsYt/V2U67oPy98whHmMVUFdb4Ge2Y1RGR0ZDgR0oRmMROV5T9nxQ
    IwdCbZKaLmC2XXkGUvRxbvLCwp9VqEJb/Q4Gb18Dk5MmTKSl0DUX7AOvEsPIEMeO8JaF4Y
    a+IGYZbMnIe5afx6XIBB8hB9hXympW9mzJ4+fyISu5Sdbid+mSzAnypPa0Nhmla1zS4yMd
    SK+9t96sMS9F0mHO2imEgqZrAaQ45v5Ughxmk9erD8pCm2gsG+EJD7v+VtMUuteGRtgFOt
    VlPdGiv9Qvbcju1BRNReIB/uPh42GfKhgVJ+069dnIjVADpxJWiK2EmlnDlRGf7lHeTF7J
    00qFwgzuG/JEaaNpJJCWfQTBkxwOeaLtJP2dlzAs9sptpL8az16a7vAYeJBX0fZOoERfWi
    jAqiFg+a2xSY5itdXeBk1nHceXb6nyTy2OI5BuPTzp/nSo0ShgigOJy0yiUSj1o998AxUe
    oyfLKz/5kOOuO5kGWj88akUzS1lxUFPQ2qvtbmv4YqeJXIg8ztukSdEWU2fUkyxhyab+VB
    MFks5tEOUJu4p0y98j2VMmZxdQHhAKvsVR83Uk0kdXlwsBKcQL35O5BoxKyQ
X-ME-Proxy: <xmx:eUDaambDqJmS4ZwyKqxlLLm1-6YaKaiFpSRm54iMOrtk8LY_t9UzbQ>
    <xmx:eUDaaulkr8q_CCndbADz8wMblcoX_v0jwjOZtLe67GuXfK15G-P3pw>
    <xmx:eUDaah1L29YOSqwSBQxiS2Q7JIqUdGMNVIqG7i0TKunKOIycx_sC0g>
    <xmx:eUDaau1ZWmjmNM6-0CJ53Z_pWv9vZDv3OaH396mstXXfdfskXAXzfA>
    <xmx:eUDaaitkhdzwcpT21OBTJrRDoITNkrT1ici7geK9SP2oZ5diYizU1Ecr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 12:57:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged
 branches
In-Reply-To: <xmqqa4o5itkc.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	22 Oct 2026 09:33:23 -0700")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com>
	<xmqqjynajndt.fsf@gitster.g>
	<CAHwyqnXcdgzRnFgFhTfhQFFOgDxUUKoPf2sGViBTiXMK1aNttw@mail.gmail.com>
	<xmqqa4o5itkc.fsf@gitster.g>
Date: Thu, 22 Oct 2026 09:57:27 -0700
Message-ID: <xmqqv76thdvs.fsf@gitster.g>
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

> I would avoid a negative-sounding word like "irrelevant".  Your work
> is almost always relevant, at least to you.
>
> The purpose of the new feature is to find branches that the user no
> longer needs to keep because they have been practically merged.
> Perhaps --delete-integrated?  I do not know.  The naming matters,
> and I hope somebody watching from the sidelines can suggest a better
> alternative.
>
> For lack of a better alternative that I can suggest, I will use
> "--delete-foo" for the remainder of this message.

Here is a short list of candidates for "foo" I came up with.

    merged
    integrated
    subsumed
    absorbed
    included
    done

Reusing the existing --delete-merged option by extending it as
--delete-merged[=<level>] is somewhat tempting.  However, we frown
upon options with optional values because our options by default
allow option-arguments to be given as separate arguments.  If we
can, I would prefer to avoid doing so.

Our documentation uses "integrated" to describe practically merging
your work upstream, whether by merging, rebasing, or squash-merging.
However, that word is a tad too long.  "subsumed", "absorbed", and
"included" are shorter alternatives, but none of them is familiar
in our parlance.

The word "done" may be a direct match to the mindset of our users.
Once your branch is integrated upstream and you no longer need to
keep pushing for its inclusion, you are "done" with it.

I dunno.  I hope others will suggest something much better than any
of the above ;-)
