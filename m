Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793619120;
	b=u5QUZbgSh9DK+4kdqTHdzEzZ+2VsPrLDIXDFMHbtc3zvOXPSwiY5bFik8fmLvgGyHgqC
	 qly5lh997ndiK4x/mxkQLtfxWjcKM3/f1jRj1tbXG4PwAYe4pRuvs1eULXIE95OYAPh6t
	 c5qF68HvlNQokrGrZALCql/MFDsurrVQuAStgJNT0RyHFH4ZeKgIXa06mr1psjVpuuABg
	 iwJIv3lm+q5/lv+QxpzvoO1tkoQvOXEumsfDioAG4rryKwlumlf8LlbDSeoWyp5LZ9g/S
	 zfL+7rv/yF+VDrOV27QH88yuvX+FVkOiycaL4cMNdjLxciuJ/1ETp5hlfn+IGU4+G6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=VxwXENPTBSA+DggL0RPjIcKdpMuopkWl5iuLluuLIho=;
	b=44PBo4yLvbNJCtndc2Rm5kaizFDa7emtR2lEXmr8htLQsfJP6JrrfsiSjBjshk5LHFeu
	 ORZjIe9gNqi8wYmj44feqAMhvozKP5oj7tPpPO0ZPKNNvo+FwjsFt0wSLvyLsl9Hwe5AU
	 5Qqxc9gSlBSJK7anJEjZ7ZHTnkNn4YQatxAXLvE6eU+b80+ixSRkRG0YKGTSH3IQjISH+
	 d12G+mKXKOCUUjyElFziTaOHRZStqygO3AumiqFkGAFoF1Ru0V2yTKmmWiuNr03It1m5K
	 FySU2YQtoGfu3WtQswQRaSwfOOudpacYaUpMckeDtyd1pyo4iw6MkDaIIbPW3JRUTeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kl8lOLMp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772F606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7772F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kl8lOLMp
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so24844051fa.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 03:32:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793619118; cv=none;
        d=google.com; s=arc-20260327;
        b=DjEAXyAU5O+TYIK/Ymxk95HR30WOOj+lz2dCZjxpcE06fld607stokaxT4+lowEabg
         Msryi0VhawoomGi8ExNbKDwfcVC5GrqLEW9MpnCGOtumesavWIEBaW446LNjFgKDcf1Z
         Jnn+KXYg9EYJdLnkTcGxGd2hmsfPPEKACZRNGkuKsMwJogQC6lhGr9i1fxH3DuM3eRAw
         crzWJ/3enMZ/RYgntfJpXmX64agzs3zjwnJSRcFjv2HkuRkGLt28yyHsTl6C/gig/AZ2
         /ZIHbunYQhxEuY4S1ZzUY9+WFS1oqx7GoG6C8GX6Hydb7lpb1RpY28bC0PFt50MitM7Y
         jslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VxwXENPTBSA+DggL0RPjIcKdpMuopkWl5iuLluuLIho=;
        fh=jP6GnpT96CS5LDUFNHoKuqDubThNTnMLb4lp7T4VQJM=;
        b=fa/8tW/+69Ya4r4B4Zhzndx6s3+aws0IVb8otJKz0Ch4v+CAla6nV+wY4t7WwJUBir
         jFquDUWUUr1fLyy5uVEbjzmxdSSX8+c750jVuwD7if96Z3T9314AgOvmTuI9pUe9YN65
         oLnXDpX9glSwY3QUazMUEXCw/8gwOx3jqYHQAarxXrjBXaWfWPmLodAYoIXf8N5gwRFH
         Tser9lmt4/6NC9y/MJCZQCEbCopA25QBmcjtCaDw/ztcqbL8DBptt7G6d2XVQt8FsCWZ
         KG3UQBTjosJyy/hQRVvJ+J8dZ3cgTT6NYd3gCbG95pVm4nIGPhwDjcE0SywsfVKgCreO
         CcOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793619118; x=1794223918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VxwXENPTBSA+DggL0RPjIcKdpMuopkWl5iuLluuLIho=;
        b=Kl8lOLMpNMhxm2dsl9MPI1g0ssUrmuuavDjfW1ddeGpnvHb/o3PCWrckOwzSNnzubA
         qX4/RjptU/K4XxbtUhCcpd2nbeI0zg9jySlTFT+htTdVIeebPzYKfmocUD19p0UPDhOm
         h2hz34VgLwfT1t+rqpcsVa4vQ3T985bQ184StEWG2Y5mky+mIdrulO0RrQfD+qmn11s8
         Jf0bgLQxAka0dZCYWnacxjH6spnxCOdyBoH7Ep48edw1zaLK1xUH1ZIX9vGePiKmFZqP
         c2moKnaJ85Cc5Cs27zvXNzn7ak+dsIuUL8LJiZ/Lqv5qmV41rfAZ3JG4JZcsLuFd38f6
         bCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793619118; x=1794223918;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VxwXENPTBSA+DggL0RPjIcKdpMuopkWl5iuLluuLIho=;
        b=luzsgXZyer0N8QQ+OAa7u/lcEu3zHiye5l6Ynwefq8vnIWlKcZKiagSD3WSUVRhcz4
         iPuxQkLgCJK/YkZrqn0Hdshi78oZQUohS7ib0KxpCMowGseHehM1U3VYgwDhjb9V/ZV+
         2DNCUVKae2q/mCOGF3Ux21AP7Fn1ey0TinZwM/7kRRcgTildTSPywRSkPclLeg5vNY1I
         Y5cwOiPllGsG2eI+N5g8r+IQA6c3xyQeBIoUywAqgI/ZDpI3xNIZWXH4TYmOR3w2dPX2
         H0ZQhgGn1JZseI5KANTIsPRbFoQQ3Nq8T8C/f/qP3xTkW2ML9fCBGkJF2t9/kOoTagMn
         mwyg==
X-Gm-Message-State: APuU4Z9U48tafv3WO91c2iHchvTq2trF+12QcX6MBBlb6l9YJbF0k3l3
	rI1WxE+g0iHNMkfPF9R2vmy1C3CnD04uL7OZEWaA8pDT/DHsbpK1Mn5lztt5Iu45mUo4FiJcC9F
	YKnO/ClSq3yXbGYZH4COcllXoMyasLdo=
X-Gm-Gg: AYBFou0T0CM6+us3xGpBVB8h6fFQWpWebY2X7bVCqhSpRWj5ibdQ11ped/383jisHKQ
	5W47OqgYberrxauOPkW9B6/3CfpfCnLHdzXjKSIiROpnv0nv5b4aCf81CKBV19lrmql67l5Sh6X
	vsjMnwBuBtTW0t8c2hR+KApJhC9y+abvLAyzt1ct4W7Ici8ODHBt/kQwXGGYM3vxgkv+3nOu9U0
	/RkkYAKWbl+NazIQnpKK+yqP4M4LtJ+bLNEL4Sx42j1WqhSszlMwTwTFI17p8ON7ZzdZOnRqenk
	ak+nXCwlan4CHhR3u7u7We4c/lr868P4BVpmZGdbHCtDE8gnTcFLWWvfXAjC0/nswgDBgfKHTm1
	UKMulBZSvcQ4x5GuI77rn0rYL0C9cjGHRobX26XexQbbH12PGYqaw/gw0FDQuTAO5RzyBSW5ojA
	77F/3pazaTDJRxjwXXbOh3+NPpk9tPCP4+waI3ZFp82JNGevoMWku/LgQ=
X-Received: by 2002:a05:651c:3605:b0:3a9:811d:3a58 with SMTP id
 38308e7fff4ca-3acb7add60fmr22893471fa.14.1793619118305; Mon, 02 Nov 2026
 03:31:58 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
 <cover.1790269745.git.maciej.ciemborowicz@gmail.com> <2af3eeadd18806c5298d53072428656885cff89d.1790269745.git.maciej.ciemborowicz@gmail.com>
 <CACQ=SRFWAJSRO7d5PcTK_FZBJrhdcr1ff_FfTUWmnQNB-WBnUA@mail.gmail.com> <xmqqcxsnlgut.fsf@gitster.g>
In-Reply-To: <xmqqcxsnlgut.fsf@gitster.g>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Mon, 2 Nov 2026 12:31:47 +0100
X-Gm-Features: AclHuK9xjwjLUwB2g0UdwJE-F0EZOzLMO_15IMxSlwTRRBxAmcjIg3nyzZCLdLk
Message-ID: <CACQ=SRF9xVyw++iqSnd3uDf=5ahDfNaGLYS4hF_CBLdPTpd2WA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] refs: report old values to transaction hooks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Phil Hord <phil.hord@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I understand. Maybe someone else will be willing to review it or
provide a patch. Either way, thank you for your time.

Thanks,
- Maciej Ciemborowicz

On Mon, Nov 2, 2026 at 10:31=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:
>
> > If anyone finds the time, I=E2=80=99d appreciate a code review. I=E2=80=
=99d like to
> > close this chapter (hopefully get it upstream) and move on to working
> > on the next bug.
> >
> > Thanks,
> > - Maciej Ciemborowicz
>
> It seems that nobody was interested in this for a full month.
>
> Unless we see some volunteers to give it a review in a few weeks, I
> will discard the topic out of my tree, as 'seen' has been crowded
> with topics that have been collecting dust without getting many
> reviews.
