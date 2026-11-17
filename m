Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794879467;
	b=NyoxAGoEpWEXwL3dJ6R5EhjgC8rRmSjq1igmzn2PZZITYSMTEhLLSr/Tlqi0bdZit1+K
	 nWq+Z5apuW1EO8z9/lxTJnRkQrYPWifIP1KMWNhHFUjYiQY3kwjC/l+ZTlXlCVTPq8dI5
	 Y/OrsrbhlFI9X9I26gleVHKI6F3PSwAyGhomyr+SQrbH5p975A34wOzFf4vidCfuOijFo
	 JWukJ4msdEpw0/5JJr7dqHVbdTwc7H3KoVFmNTC0QwNFc8mld24qeagsd2YzS5EG1BX1i
	 I7D5Kr0wqyh5lL7zPhUsYKQsOig6VQcquGMCKFhJlcFO+S/WMp+LtyQTXPRtreFmsRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794879467;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XQ01/Fvw4rf5g0k6+Gbc+h3icJyZZPRvXMkoq+lmROE=;
	b=qy5t/u4guuXVl35RCOaPMKLcPeuKrcwj1FtkLCejmqQ12x+elmFFfcFEszfOVwo0qi9c
	 9Gy9Ww/7ydh9MKxVY0zAHounppuT8mnWK3iGY1oV1mErswvbyKEAWVI/7ZeyaC6GRrhul
	 QRPgGzU9t+RxJSpmp2wjKGEwJQT2qwwb/kTvWAbF96BV5EfoPSCIpe8sNF2flHk5aC0ns
	 fX7aoMKCytLjRpQuUsW1j67onFhr5jLsOocnIFo5peeOMTZ4Da1kF4waCZPgTI6SI9adv
	 xmNvjibTCzq12DuFCqj+B8VEbTUxfL/oY3coKGd9HR2qWqO+Jp7qInRLBLEj2YVtEDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=EN6ibtxK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ecaElpUT;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4261606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 01:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4261606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=EN6ibtxK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ecaElpUT
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 970C61D000BC
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 20:37:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 16 Nov 2026 20:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794879465; x=1794965865; bh=XQ01/Fvw4r
	f5g0k6+Gbc+h3icJyZZPRvXMkoq+lmROE=; b=EN6ibtxKTyM1Poi2iJwDJxHay/
	+O/up6MrYrGGYEYMAP+iPaqZdKnDR2T1kN+3YBru2x9QVynkeHSM4JFqwDluCMFT
	EPGo9piQlMzlhJpqh0tf8mw7PCbL4g6VdXtGcDzLtKQO0vRNeChmWVoXVOQTp0XE
	EC1QlQMWd6NUz/LYAZfe/c/dZ9LN1aswwxYpfCoBH+WURvC+QY0uh941y77uIFM2
	u7RkYvIg0Mq5MIVo6QvUbxYiSw/X6OVFoILwBzHWzkNlc2ndntlqYqynzZcrULTy
	et6RzSnFfGd6zKEyDwwrUYWJJUqDUtoiF/OxkOIOH+GMyu/NwopoLsTOgtcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794879465; x=1794965865; bh=XQ01/Fvw4rf5g0k6+Gbc+h3icJyZZPRvXMk
	oq+lmROE=; b=ecaElpUTgJ3RfXVCS3Qy+UkH8vJwFt1F2IGEqmes/zd12fy41sE
	GbXwVmWl705GIlXi3DFhDvC8sn9s14gg4y+FCMTbfKGenKPygcMH9kRXIV5T7jNs
	M8x5+9LyQV0rChhgR/XWxKOf5MSMQHVpeTWPZkm9DApoV2hDdbNWDix59o7t0Z09
	GFf3FF/oE3NpSEd8yaOKkp+9Cm52IML++7Koo3pMStKf2mzCkazlW2Zg3u6A6Y32
	LlVqfZ8sNtR18+AxGeXMhQJl0N66X9aqUprN4bHV7LkvlE/hpJ8ioqxhTCS8pUrM
	F8ocER5UTqQ3y6+MMnVM3p/vKIOPTzTRFvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794879465; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IumM8Svg+pvYxP7a2StiZkXOOV0CiToWbax82NcVGhaMuXo
	/s7jek8Y5k5YI8f8VxneQFxh7NJlvYK+SYpD+JT+VlfFSBv6wz+bJBpr8dDdTOz6
	rFildD4s8t38oq1W8JZqpxU2/KB6X18Ow9h35xLXrqZ7cYrokbYgNyF0EwaGp9P8
	AGdljBoUhEJmuMSU+KPi+MolPhNEybjCJopPuNdKH1GOPzSsoGC+WVYOKNefOoMj
	Yq4+FSVJ5K5uQ7/apksJS4EBRFe7902bK8pBgkGR/0cg0IABmVUenzWBAti+J6Nn
	OXWw1i0dy7xFnk+kuotTHnuGUpf2lGAATVusBKQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gK22uDrrnINDRyYGtb2pdjf4XV22pswVg23g8RcnM5s=:5DDOBgW0mNiJpfO+eLQ0By/uqhAU2xDKx1GH+EAlh9k=;
X-ME-Sender: <xms:6a_7ar73-U1e-tt0hhBxZyRjhAg7pt4g-Eaf793K8ify3VCYvNHy4Q>
    <xme:6a_7anwWWApQSm6WJWSdihH2bGFg62v6AaeHobaFL1bCA-rAOofvm4vQoCWB2nmS-
    Qr1B1Tovy1hpiaHybWex588cXx4QK70uRZLGx9lAlRziGvi1aOz1b8>
X-ME-Received: <xmr:6a_7aqyNF3G1skKUlOLhm5g5xWMstkJ3shFnXa11DwQI6HI8slxqkMn2SURfzMBkfYNcoVE37Z6qJJ-3rSme2pheBPg8T61JoeoT>
X-ME-Proxy-Cause: dmFkZTEntWp/ETakhqvX+xRhvBca5YAzRNdMp5u9e1cvlFWpkDADpaE6LCeMseL1ys0KVr
    feAzIsv+DTI6gExSjlPspA8iyU1znHw2CWQJvU0E7+ih7MrK/lUKdGDpLBBAVNHl32Qovd
    UvCp5ofsABBN6IOtat/ApZYHZXe/AL69NctpZPMAqze7jD5qXbR4TOWrhzpaLMs12nLpwe
    vDSPDkJJ2fRun5uhmeImFEsuu6Jp/mCkJbDWs2iAhDT/YyREB2Xf/ZgHsKlufSVjtpXPu1
    lMBB7d+9Xc8Kd7OR9AD1xSAVEntfa2ILACRS8PEThOHln/hSCAB120OpoXZBgc67ww3soJ
    xsKv01/KImZ8L4lyu3cctNC8v57v5SB2is54Cd7nC/3IBP/KppwRgUM3XU91ngd/lwN6zs
    V0O/bQnnUkFtuGaiHklqTAINn6ffinOMoXV4+ZU4CqwFTAr8VdkHmml2Qn5XajzwGFb4xO
    znRHRij+98UnA5oMCqZnNcJiUQ2hgk7FMxMNXk8MDjdkaJC+3FRCgSETRThh0tb76rkTC9
    OJdynfANUsZwRmiAZthIGo5BJoknmsOP6vJce7Jf4Fq3W3Qf1J5BjCtclYlJp20nRc4L9C
    5/kJrdkz5xrlTr8eLxujhaB39NX+EWLpd1d02V/WuOwSgWqvwTorMsnVplCA
X-ME-Proxy: <xmx:6a_7anwEgZj9HNoCRuDaNVX1RIF-uXG5s_dZ7T0qxp8PIhYyusYRmg>
    <xmx:6a_7asYNXLi5gad8nCy7Qsn0ORQ-c8XpVwCRzjL_o6fS6Gny3dwwqQ>
    <xmx:6a_7agUbFp4QW9r1LWa0HZyTlMLmfCev_BDBygGRN6K3KVu1MfxYcA>
    <xmx:6a_7aihHhcATlInSgVquUV34FNBAVMkTdOx_l8cOq-6C3PTSILyE3A>
    <xmx:6a_7arBZZ1MTOfn4E0nNFJQ-baw0StlloWoyCsPe5dtF4X5SAzMa8sZz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 20:37:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 12/12] builtin/rerere: introduce proper usage strings
 for subcommands
In-Reply-To: <20261111-pks-rerere-subcommands-v4-12-df0c8bf79e16@pks.im>
	(Patrick Steinhardt's message of "Wed, 11 Nov 2026 13:18:48 +0100")
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
	<20261111-pks-rerere-subcommands-v4-12-df0c8bf79e16@pks.im>
Date: Mon, 16 Nov 2026 17:37:43 -0800
Message-ID: <xmqqo6bogrvc.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
> index 4e6ab9a27c9..e04e9ef3ef8 100644
> --- a/Documentation/git-rerere.adoc
> +++ b/Documentation/git-rerere.adoc
> @@ -8,7 +8,13 @@ git-rerere - Reuse recorded resolution of conflicted merges
>  SYNOPSIS
>  --------
>  [verse]
> -'git rerere' [clear | forget <pathspec>... | diff | status | remaining | gc]
> +'git rerere' [--[no-]rerere-autoupdate]
> +'git rerere' clear
> +'git rerere' diff
> +'git rerere' forget <pathspec>...
> +'git rerere' gc
> +'git rerere' remaining
> +'git rerere' status
>  
>  DESCRIPTION
>  -----------

The above is consistent with [9/12] where we saw that the command
barfs if you say 'git rerere diff blurb'.

Yet, the documentation contradicts with the behaviour.

    'diff'::

    Display diffs for the current state of the resolution.  It is
    useful for tracking what has changed while the user is resolving
    conflicts.  Additional arguments are passed directly to the system
    'diff' command installed in PATH.

We do not take additional arguments.  We do not pass anything to the
system `diff` command installed in PATH.  It was a behaviour change
left undocumented ever since 658f365027 (Make git-rerere a builtin,
2006-12-20) was done.


