Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777398;
	b=4hSzY1XlprLAXRU0bxnI+ZO99F06ECprXOKjRoruPjTLFFnz7WtU+WzFRPdSyluALQQX
	 p2prhydP37/PNgk0wv7XQP+xwKxn8LREPg+8jtoFfXa/d41SKApN24OPDlemFtYSaj+FI
	 a9FsVjWx+Y5DCs1Q6rnD2WJwoGO20BVgKBsdoasnuzBmOCqjk8ioybj7Ut618tuzHstSH
	 PZuVQSzrx+WlLLx92MVJQd/ArcwCIUhTNaWPbOjf6oHYmpL0KkuV/xBg6zqZw78rNCYK1
	 y3lNVgid0b8Ffy61OGV7daxhYsjMp/uhJaRaJXZF1eaAjxUc0SXADL/0aMYt8ARzl/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777398;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=tyT/BCSSlwlwLuxgSjmBCIH1znBXSTTps6RicwuCqf8=;
	b=KXIbmAI3FoQJzng85WGzuJr7nHCfd38MA5naXHV/NBAJ/s57o6SIVWfoVAr3BUcy3AJb
	 vm9yjwpL4cuv+Os4FQs/cSBeikhtlUWga3/3UTGf65vHE0DlH4nKl0EIFj3mZAxH6Fm8g
	 gdLxlvgQ5VaYJE+ioGbtOLm3uFZ7YPp3SmneXvkgl0Qaov8nINWy4JqKX3Ru/zd5PSA8G
	 kaYXn18HFB9v+u4pltRgh+j+nbxAEBqshg7mB/zYUGFE8ZD7+ZaaqFogTm24adVQqKbtX
	 pHgSgEJs3Qixe/wRs3QzVq/SO0gxEOjBCY2DkxCce7PqvBx6PPtmRWUno6eSE292Fgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=JOfYkjx+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RkIOBqTB;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A713606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A713606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=JOfYkjx+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RkIOBqTB
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C078CEC00DB
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:43:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 23 Oct 2026 13:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792777396; x=1792863796; bh=tyT/BCSSlw
	lwLuxgSjmBCIH1znBXSTTps6RicwuCqf8=; b=JOfYkjx+dgjkck6JNQx+I9vHzy
	LCI8CEFWxw+W+dCbZJhmU9KPVLLq8yvqf3lnqZP6dXos8SmrK89YQXnT2cxMkzT5
	WemzntMCyWbJbNxto1n3U1enPzR02BPa5Xt60ZB2zTF3Mt0HKrUq7AoZj7ja6RaR
	ybVSuHgpVVTnYszIcbnV+Nzbjpc64cMVklkn6rdANHNuDqFE8yiLoNACev8KmPDo
	6NlShMsxO0IoYiP4wnH/A9BYGE9zFHbMlPe5GdKU+9zU28qevYyZEmynkQZSA3vg
	T2aUxR56AAU7eneUoyU0RtiGkvGovb/Lw948t6QOVBUivTsOHPZcLtjSbRbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792777396; x=1792863796; bh=tyT/BCSSlwlwLuxgSjmBCIH1znBXSTTps6R
	icwuCqf8=; b=RkIOBqTBeVn+GmFu6iSKslQJhauGI7VVc/u4hDJPFx+5lqcFil3
	44rZAz1KxuyaENiaOKPcY7navBX2QPoqOhckXnji8rtn+pq5Arfs6xZ+sNcZtbfu
	YT8UhkvC0RBrs1ARYvyVA2bpNCFgoCHVtD5nbvnSlDlqF/ITEGPQvLBeCzKVgSPY
	wBbKzZ5C5CagQXKejBsoYYisqvt0J8YkRYBGPua254ue/rwcVv4Xdc3HRMObzh5q
	6KcJQghVs9ea01SOuTQrnJrWI058jYYTM4eD/UKL6hcXq6FTCtwctNgJbRJnEUCV
	fi2X85dyl2PWh5prtgA8uqBow5qa6zomnTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792777396; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:EX7HCi55A1lfSzOQn0F3ZSfSAicKOinmmPGC8o01+f0wvCH
	eZKM9Wym5X8x70I20MymLAzET4xxqULk3E1jJumtl4wcZHjOpUOKzz3mYOMmRI1Q
	6DUg0C6EjAPD4vth3s2aGUvjOP2OQuHuUGQk9gDe44qfNFjLljhFAVYTqCwOvL50
	ZesffUMzWvTURpfEjbBV1EIKOWE3xdWewFYYdulNzfIOWBpsaR7XID8q1UO9Ukwp
	o5auSRAly9bOA9XELJUE/hdNlGo5bwW90E/Z1XfNaq3laJvqnuOi96HgTKJ+j2nD
	Qa+iIzS+lIp7351owyS0IOoJQfrkRmk8XXnd/jA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nE76RdMnN7+exwzMnQ7ZiIjneX4Bzk5hKOEsr+nF9Sk=:0dqKZT36WfbBnzhxyDA2ZbLpTRtdx8kuE+s7pLZyObs=;
X-ME-Sender: <xms:tJzbak3MXmo4io78Cnvp_bd6TTi_BXxgGM9gpCMo29ujZLiuNZEpxg>
    <xme:tJzbaixsV4rLllOYRa0rsV_SX4OSHjVy06NcXCbG4F0MuphodjMs9edGbFiAxef4g
    up0l2LyCTWvAJqwZp2ZOXsczhP2gQ33vd9YApXEMt_jSzYyd5HgTA>
X-ME-Received: <xmr:tJzbamvxu5sqcDv7m0dWR8e53kK2zxofW4Vl0SqrMMn4n4smu6F6A0SMe3p9Nz2yRxo1ktKzeHFjzfZfvoEDZLMM33CAMEBXU_p8>
X-ME-Proxy-Cause: dmFkZTGtBZDYtt0xOSKDVfNfbBB+UhnjWtILVkMuObiLvD5UUAeA1yim1/4h7+8lRwPkM9
    Kr4xQnBgc45vGfSmQpFRvpRCYUo6y2uRu1DBUpDkA51A/88PNm1CX/V9Nu/2oMJHFfiQI3
    qJ69PYJd4ITolq95aXRibqQ472AzlN6oOS+GbwYW4aIwtLiLV3taTqUJj5dS8+JK8ucxck
    V7r1ebdfmAG1THkDp6EdJNl6ZimHXXU+lVzPc2UqMkERPDePaB8CJvAvmNMPqWIdUThSB0
    or75zjE+Ecmr8xSQdRw7Vk5WKZqca3BUTCGZIlUtVTzW3FlSPmXdtvv0NiNjbIuLpcXes4
    EHwvtD0E4vbNIjdnCFeysDkQ1prK+jGk1NwTai7mzUzm3XThNcmyPeiXzj9jtiVW41HyiC
    2qs3wI3Q9LsiQkbF6rwp5ANOAh4isfCpdzpSuLnvcILzcfXDxKEqAsuc3X54O0oGYD9apU
    vviwH2iqQq0fffy1EjasSnHxfPtq3AmpUpYsbm109FteFX+cqT0xPUwDl5EdiJXObtJitE
    5gQ6DbREQXFlCiDX2iSqgLo2eFytDvml/EYn6qgflE23dQZ8kk4Zear109/MCS+66UKA6Q
    IUblSI/As9ircEd/WHNV1eAtdkycjchjeX1kmz00c+K1GYeKOBaKTUzkLlBg
X-ME-Proxy: <xmx:tJzbakxcfWZos8KpYF5wro1mhlbtGExAi-b1O68n1bLzdW0fm85ywA>
    <xmx:tJzbapBj0qidYjFcrpysxJIiU_68jxtMtYsdmgDz4OAfzZZt2MJgDw>
    <xmx:tJzbaifj9x6HJAGHKHCCKH87ToPGGyAal_mjh--MPqGvsY9D1ZFudg>
    <xmx:tJzbajk4nS0c_ZGfmsj7sPKyicVVJqvQDNxnBIDVpKf1ckaJxv-Hlg>
    <xmx:tJzbarYblvm_E3vgp6trWqRFsNefx3qeae1CLRx0QG_A7ZS1AK1X6QOf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 13:43:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] status: compare against both upstream and push
 branch by default
In-Reply-To: <pull.2458.v2.git.git.1792585662669.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 21 Oct 2026
	12:27:42 +0000")
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
	<pull.2458.v2.git.git.1792585662669.gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 10:43:14 -0700
Message-ID: <xmqqld7o71ot.fsf@gitster.g>
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

> Showing both without any configuration was the original proposal for
> that commit. But some found the comparison with the push branch to be
> noise. So the comparison was made opt in [1], with the idea of
> flipping the default later if people like the option.

The key phrase here is "if people like the option".

> Those who find the comparison with the push branch to be noise can
> set status.compareBranches to "@{upstream}" to get the old output
> back.

The presence of an escape hatch is described here.  But its
existence is not a valid excuse to force people to use it, nor does
it answer the question "if people like the option" posed above.

The paragraph above (and below) also assumes that comparing with
@{push} is not noise for many people.  We have not yet heard a
convincing argument supporting that assumption in the proposed log
message.  In a triangular workflow, @{upstream} is not under your
control, so you may want to monitor its progress closely.  But isn't
your @{push} destination typically owned solely by you?  In other
words, aren't you the only one who pushes to it?  If so, whatever
you did locally would be the only change that could go on top of
@{push}, and unlike @{upstream} you would not see any unexpected
work over there appearing without your control.

> Having configured push.default and a push remote to get there,
> they are the users best placed to find that setting. Those who are
> just starting to push somewhere other than where they pull from
> benefit the most from seeing both comparisons without having to
> discover the variable first.

I do not think I follow.  Those who are just starting to push to a
destination other than @{upstream} would have changed their
configuration to do so, wouldn't they?  Aren't they equally well
placed, if not more, to find the same setting?

Overall, I still do not find it convincing that we should change the
default to surprise existing users.

Thanks.
