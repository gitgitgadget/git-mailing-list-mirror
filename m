Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794205831;
	b=ZbOCeXHV3uIMFcVMcVa2dKzfWHNHnRbk2akzuguTM3fhEcmdR7hk+K0eSYN7WS6VGiXf
	 xNURDsHO9rQE83r+lLGtRBGI9Wr8skYR0RAMWk8W9e6bVDFea1tHIxXJe/fIibH3hjK3q
	 GEDUJFafGNZTXRTy8jHfli6Hty2veDaDVS/vL9p7EHWyeKxSLCVysFRyFgl55yg0rvgZh
	 56hlk7oqEOzjz6F/UKktCsK6tfUzWIopLjMSeyunpQfggY43kkx/yoSxxlpGiJQtINZtI
	 J6b/cM852D8/TCX6NuwMQNekY9R2BAKJyrfG0lek0ZTEePHRSsZAS9mDeBaf1fPvUOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794205831;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=B9KoKctdEiudAb1VvBvwCLgIr3d4c/c6b3w+6iK+EtI=;
	b=VYhwSnwtstyo3zTPY6DfNo34Gq3eSwScxqFyHWQkOD6B+iVkWDXc56tpHIc+axiCC8xz
	 QFrTAkVE+1FDdPf2iLLssurmROHAY2w/NkjlqCnbC7ym8aHt7W8nOyfPouJwAOS1Fa41C
	 AFk5jnL+5tKxS+gVWRuTrZRR+L0ps8IuxXRIOaWrukT0JIfC170RWe7MBw+Ycf9hbn2e+
	 qrzfxCtd15vuqjimQe4SfbGFjIybgLlC12flWB9KiM1xsYlIiE7iStWh7YQAMuCxQIoJW
	 k3t48Jc5VeTKSkxD34/30KBjimVMcJOPAh4kvpTLuZ2F2676MGtcHz3dtFLInoPpyvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=PuukSy1T;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3SNlYY14;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB065606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 06:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB065606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=PuukSy1T;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3SNlYY14
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 827241D00149
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 01:30:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 09 Nov 2026 01:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794205828;
	 x=1794292228; bh=B9KoKctdEiudAb1VvBvwCLgIr3d4c/c6b3w+6iK+EtI=; b=
	PuukSy1Tu/bo2b4Qkd9GKbbDINwOJ4C7hUj/YDDpQEwV7pu5XHDjj/dXPh9CEkhv
	X9xot0MC2YLGj8zyE1NKIDBW4iPosBLU0wzfy9B9twRWtWvi888vWXLj13G6+yOh
	GxFB7W5Kj4A/JZpW12rn3EZpKOBHOUSzRESmysyODKrfyV3jSY5hUXwtPHxUjClF
	+a2vxgmKqrCpnNLu3n4o9lrxYEpJW6zaP6s9V2yGjjyoRvVk0NtfgWWEUN/gPIO5
	q34wP7A5F2idMgJP9u1oI+oHAfztmOeajHZ7GJnJ89wEcHHCgm3RxrQQKuDeblFY
	ZbUvoSxTSOvrO4SSscLjqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794205828; x=
	1794292228; bh=B9KoKctdEiudAb1VvBvwCLgIr3d4c/c6b3w+6iK+EtI=; b=3
	SNlYY14jxH1SqOYwa1SM9pudFiH2d6LZipzs3MP/0fX0VQaCp4PWiQj3Mqus0rYt
	iTooZBzuM+4FMr8zYApn7/VF2xqggzAST99bZLP/0bvAYaB9aihgvVz0jTTssHLz
	furqdM60CBPzsJLGwSM6stQhNXAm4JP5MYy6aLsjCXg4xPcDyEoTA3TA8ZMo5G0S
	O3qaPEetKT9Yd9WVI5ZDjerlouglOU8q9bRwfFvWe6w2TXkJhFvV8WneJ5y6j3GN
	fib9j1ulY6RDOILxatV9r330qMcAqbvjFrKd67VSJClr3ixxvRbr02+QH93x+Gji
	fT5iJTOfDLhxqu1KimjTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794205828; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:DLklD5c2gigxnueg9hxmPhlkOpcmUYkiSLODM3sfiv6IMK5
	NdeOU4utNA8EASss9L/K+myn7PLJQ/OYcZgMxXv3KtBmaSHtkpBGKuJ5nl+RuePW
	EinTXAb2YVYXEevpjrthYM6CtYMs5qZObdISvYM9Dlmi+tZjQYS7zjS2wUwQml1T
	ESb/lIWMXry0jLUV1335D+DuzOQf2/ya5EZBZrTyU1qTI5nKacLgU1bxej7Db0bi
	WGc4lnLFcG10L0CBpYRCxoduPyyOAODhiijfG9SHU7Lh5T7JO/I4m+R0amAJ9QOB
	o8WGrE8dcsh7ICbUSOYwGbfPZOgFAh0esMDyYrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zko4dpo3lr5SJtDOPBvSkgFqYh8yxp55y/AuGZtQNAI=:HEC1vDoSD0F0stNFyPypkZGafSyayhxtZwPBXrSv+lY=;
X-ME-Sender: <xms:hGjxamNgQijgP8C09h25l-ePchs-3Wz-i8jad7gZIguyFUSNL1gquA>
    <xme:hGjxar-8Tt-pe8ss-1aQvXUQwwEFnMJac5LgAwdbZb-PlnTA7KUJFuKcnZheiPN3Z
    XgqZXaj0ezhrFAB_-inU29ZaqvWhwNRzmfoSoZgtjd5HyCOpqkohw>
X-ME-Received: <xmr:hGjxaiQFGOIOkzvd4Q6_WnQo4d-uI4A_gck9wk24Ptg8yveE6BuSZdwlIyTPQWP-SLyd9VM>
X-ME-Proxy-Cause: dmFkZTGNWDMVrXopqjE4gjKlIMRHr1dz+P+33iY5ahGxks7Xh5U75ITRbYfHjvfBKzk+Cv
    1zzrUkzcKbxDitlpomwQfFVqXtmo7ZxD5BfMPVD2uLTP/X/owfND9USFj8pl2g3Wv/zDXQ
    aAkbb9egOnLA5E8Ss2EUPfqVFDnbFedAwqqbtImKbXTUZSAjQJDszxe2cgM9jfrIiu/WA7
    b+Qgs4d5HEXYFd8q9Vx2bU39y3HnQ7AVD8dA6OjDUvkk/BCtYBxsGzbg7WP10f8wIunavQ
    PwxKpJvH5uy4PbSoGk3Ljb570khAmi16jE3YR+fjlZqVNzsvnC5kMyvvhOhFhfUqzbBSNv
    BT94GBHE92bW8x4PhMjpmdr+G42GyJc2pgkb9kp6idFlC5XhpDB1fjteJHE6XbPaZhbK+d
    zxfQ+Md0oKASnQlPpoTs2PHWg8vJHWBCWHO09iIbzAQEbkRqC/dAzz7vkff5RDcjb8N4Uu
    nbkzVXbm6WlnlfWuQclZ7GdtK0SspeaaAVlqb/RRvIi6vNVeuA9a6aLkIszcpxWm8jtgD/
    lDKy5hMuHPyiJryUbf73bi9JebSovL2osA7y+51ModlfQVNl1rFvNKVb2co2Eg71Xfkp5I
    wgLLLCWn2ZvJcJuJAnM1ikfdjwnoU+a2leJ3vONT28tYDTMLLbsVxbnlVv5g
X-ME-Proxy: <xmx:hGjxalmWKKdWh8aBU4fYKnCKNxetN9tvpQruExCmFzbQBZmHRFNTyQ>
    <xmx:hGjxaqQvqRhUnT5h2UTVxUo0yBFd64ga729AixjqoNa7lYVLFfANIA>
    <xmx:hGjxarPunPLzJCNbrIZ0T7viKD6tzjhD76udxr0D1ZWQB4mixdGDxQ>
    <xmx:hGjxarWHNRqaD_Tabz83D6dRES5oGF_vx73ECJIC_d8CRWGNunNXPw>
    <xmx:hGjxakkeNGGvvPVhzu1doaiK5Ncf1aXUof-_v3549USIbll3SvnSBhXB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 01:30:28 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 77504d24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 06:30:25 +0000 (UTC)
Date: Mon, 9 Nov 2026 07:30:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/7] t0027: optimize how we reset repository state
Message-ID: <avFofjtc-1oXIPrB@pks.im>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
 <20261106-pks-gitlab-ci-speedups-v1-4-1fa0374c7287@pks.im>
 <xmqqv769kgqa.fsf@gitster.g>
 <20261108164901.GA29213@tb-raspi4>
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
In-Reply-To: <20261108164901.GA29213@tb-raspi4>

On Sun, Nov 08, 2026 at 05:49:01PM +0100, Torsten Bögershausen wrote:
> On Fri, Nov 06, 2026 at 09:33:01AM -0800, Junio C Hamano wrote:
> > Hmph, don't we want avoid hand-expand the list of files even though
> > we may want to use one "rm -f" and another "git checkout" command
> > to work on them?  IOW,
> > 
> > 	paths=
> > 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
> > 	do
> > 		paths=${paths:+"$paths "}crlf_false_attr__$f.txt
> > 	done
> > 	test_expect_success "setup checkout ${ceol:+ with -c core.eol=$ceol}" '
> > 		rm -f $paths &&
> > 		git ${ceol:+-c core.eol=$ceol} checkout -- $paths
> > 	'
> 
> "Wow, so it can go" - a well working, but slow code is speed up so much.
> 
> I used the following (before reading the suggestion from Junio)
> and the execution time here on an older MacOs dropped from 71 seconds to 54 seconds.
> 
>     test_expect_success "setup file checkout ${ceol:+ with -c core.eol=$ceol}"  '
>         files="\
>            crlf_false_attr__LF.txt \
>            crlf_false_attr__CRLF.txt \
>            crlf_false_attr__LF_mix_CR.txt \
>            crlf_false_attr__CRLF_mix_LF.txt \
>            crlf_false_attr__LF_nul.txt" &&
>         rm -fv $files &&
>         git ${ceol:+-c core.eol=$ceol} checkout -- $files
>     '

Hmm. I think I like Junio's alternative a bit better, but both are
definitely an improvement over my take. Will add to the next version,
thanks.

Patrick
