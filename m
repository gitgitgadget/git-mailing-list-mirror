Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793169425;
	b=oC+jFqNRbiDSyYYnX0skTuW8aE2YpeVEfHOn0NrixzlUz+5/TEdUDED+I8cWCXSFqVNv
	 UTOzQWpZoXKD2EkpMLpiDQvSgZ4Lh2Yjl43yBh11xsUCjl9u4vBHPjzWr8N7v4lrGhz0t
	 xgvi3IcKPmorULwKsfdJAvOFrjLdZlJ9k8753hKWe5g6BEbC98XHS9fCPTyz7eNIf6pGo
	 PLfKzzNogebrLAgUu+s0fqPt+354heBP95fNJoOR4QE/L9omsvwYRoQQq4h8THzASX9e9
	 zFhazV7/M57xFA27+9oBnPdySxVwpSOYpyDGcqV7aVpdVCQU9npuUvn95FBfbMAgMcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793169425;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Xf1nQWeiO1i0RgoEk//pgLgE11Z2ah2fc6t+PTI7X9Q=;
	b=uA1FFgMWpupb/E2ek2GLVNdl/IV5scx9DpSot4/2gLfJYkN0j/qCPn//kwrZEnb4ajC8
	 4X0DvxeATwBI3QK9Xo9Bv3q8+y+05a6eMEukBOQI0wnjShCJALo+jprnM1xPxbx4/GWOj
	 iPlbo1Ua8+fh4RBuZESxZHO+JfG9Bvb/b4MRLVvhTFgCKns7LkK/0XBL3C/FY3ooK0YcJ
	 0+cwDsO9ZXGqJ6Pr2QhTrm5QFCYI1KBnndJJ/C0y+HSeFwR2ZIY+JVh6b5MMy+IudsNAo
	 1tvt7vRdEkCLnssFmbKJW0ctu0+ieSTPMqIQvU3VPJqK15VjzZPyhnQk/7ZOlXgitqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=eokQLxRa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GD8Gaaot;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE1606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 06:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3AE1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=eokQLxRa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GD8Gaaot
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 065A7EC018E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 02:37:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 02:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793169424; x=1793255824; bh=Xf1nQWeiO1
	i0RgoEk//pgLgE11Z2ah2fc6t+PTI7X9Q=; b=eokQLxRasuWV15rh4WGrzM8WcB
	LAQCZYBTgPZiiIEfpddeEHQSPI/fRbh9FH+yBzbAsUDiQWl5C/T+3I03icHJbsn8
	sjnXOBUh1g4WEYMBnAzxEehCJzc0IF0xTSpYRwQ/Zs+9CE+3VrYmvIQnvXrm/EhR
	9M1HXywZlAQK6nZ37f7l8rz2LFxHHFCh5S2UAy1Nfvfj/QMM0rrjrNOujvrIuK+b
	xp6HuL94i5AQHRlw63PmApjsIuoG5ltWDZtFUVONjfcYrtFe44v0LTy7jc2iflEK
	2XHHwRluE8tQD48D+0zXZrZVbQ8vcqewJLNZSkKc3DyMC/xAvsE0XLUDwaRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793169424; x=1793255824; bh=Xf1nQWeiO1i0RgoEk//pgLgE11Z2ah2fc6t
	+PTI7X9Q=; b=GD8GaaotsQMFCrUCv3Cd40ZXexUOjWZhbbIaJDB3jeKfk5itoLs
	jm5XfCKGWFyp1Vn5epq3YJOcvhnLw7X55+CtW0Xo9GTdAdM8aS0P8mn1DSZ/JEYQ
	V5XHI55zO/OFh2jI0nDlv/Xv0iIU98RGB1FIxBRTQfe/EacBcb0tFgD/aLYsx0Pu
	VxzhIvKeX3SmDKWHjNN/dt/N7M8s2Ie88CUV7MUmzoCX/x3BY5bXllN+epqBr93q
	Y6rpz4+FOOYMxxLIhtBsaEiT5faAw5BkOBf+yccl2vSZKQ1/6v+dEfH7GmKXgvcw
	2MhsK0WLQ30YSr2eMzWzyXw0XmG8kBJWHUQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793169424; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:PtBk+79DoHXa2xEqrXXxJs59Skbp05+6eVAb4eesjKPYrIY
	BzglkDdblBAFVtMcLDGwN8T7YpSW1aIJbV0j3XvU6l3Rg9Ve+51vex6YJaKadnlb
	9yjFhqnAyR+YCZCAtEOF8ct4l76mt2UWaZcbnTss58E8gKnU0rVVoiDqXqMh2c3l
	PkchTeFCOoOt8ibeoBzLKcNATy9V4HfVobFJHLu7gqxxaeKDwNPzxVn9xmpJYqv3
	KVG28Pbf6Q7aACkY4o3czZvrwqAtFIfrH3L4PfReaF1grJlXOlF7FV0QBAAylcfH
	nrKJ/PwMqP8cIhNV3SObHWFIoRXOuKl1ZjeWy2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Wad2nPK1P24tlwOsJl8qe93Qh2CuFrJhSFwuD3mYL00=:WRngROptcbvGMtSkcqqKLnC1jakezr0It3DPP7XzM6s=;
X-ME-Sender: <xms:D5jhas028HdntZ6Irt1hZURanJP_AjdPVWwWlcXtTiTx1g6q08y0vg>
    <xme:D5jhauh6Ud_CImy0zSptVWeb9tV4s-9c5XPCNwOoHpEibBw18q0v__alcxDAfWsH-
    _e9GpwaTar_qPXgOBMmHOEcA8duFGzywxoJBOgeHs4aFOlp-4fpHw>
X-ME-Received: <xmr:D5jhaiTNe_wKAJ9ZWVXAmgKWLEHleXox9d1zqYD4Gx4-LgpfjRq9oh4P_xCjo95a4Vg-UjMshWn4gd1dB9ccf7yNik4noxTP_lHz>
X-ME-Proxy-Cause: dmFkZTEq90LjbDWSA2DNvjJpfn+Kj08bBTphGYHaQlfX3p+Oz4YWp5CRGvUoDng3gzhNWY
    advf1EQ0Y3rodcbUP3IjdNPU1VhjPSzm3zQcbCd/f+ILDXhm/cbNHAwBbB2m11j2RvTCAQ
    pvTBkMAIE1DnCoPZYV/bDaqBbgR3JSVhWqiNMwh5ro/82MlitbcUXQh9qx9khRESlAqq1q
    CICwZTAd5vB/K/67psOfrmmd43yGV0Lro0qyQfgumeno77p9t/D3eMJIrNZkmaJ6Td10HO
    ndLY1gANvz6kFhbflqed4ja8SQxekKdHvKpVDqTTj5Y2vF9+s2Th/WOPZFbvcoXHHxP8OV
    e9v31MLPfv0/HdVxbLGpmAtA+jEGkmCPU+p2hAc18UpCHv5y/hdJV1EhBvl8gEG0zYcLsr
    5HyZ4sx3utJtWd1Fjn7GOoBiBYhygkVBOILxmOq0kDuz386YM0ScBTwUAq7LNCB31Vdavt
    iU86zofukJg2TKlZVY476B0kfXSeQTyAtc42QJ7w6SGqXDUSSwGtINr7Sdaw7Q9vg4+MjW
    r1G/rgffFwy8ItTjaOF6PIZ09RZ7m0RriIvcJrHO/40bD0wAr+YYkI88cN6ZY+arFFiIir
    Ok4ElaywdAWncEJeuwC0pzq9pq+9SFnNVCBjORKv4V3btdfYFSWHYzmysWiA
X-ME-Proxy: <xmx:D5jhavgz__j-hMAU_Qx4VpRc5298f_xjsUdS64QdFBS53esQzurbyQ>
    <xmx:D5jhai5sW7Dm7KKIZ5FSm6Edh-kDwGYgxaShgbvLPvnmW4AjEGhlow>
    <xmx:D5jhasDkF-MPWPdn319db-D99X8EfmtQQfbzjy8WRSsqGjO2Af5C2Q>
    <xmx:D5jhapbvg_dYx-LzGxf5ZyUsZY3HWNGJPF22KpMk2Bbc-fzs4aPfnw>
    <xmx:EJjhaijXJlw-x7v8UJOLF-4ewLUfLwtkvsiNtuqnW7-cYeRMQ03DhWro>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 02:37:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] cat-file: extract the transport ownership from
 get_remote_info()
In-Reply-To: <DMFX8JPX16W8.9VBEJMQVF998@gmail.com> (Pablo Sabater's message of
	"Tue, 27 Oct 2026 21:00:01 +0000")
References: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
	<20261027-remote-object-info-batch-v1-1-ea7a1f0b1df1@gmail.com>
	<xmqqpkwvj7bj.fsf@gitster.g> <DMFX8JPX16W8.9VBEJMQVF998@gmail.com>
Date: Tue, 27 Oct 2026 23:37:02 -0700
Message-ID: <xmqqbj8ee3g1.fsf@gitster.g>
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

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

>>> +	if (!transport->smart_options)
>>> +		die(_("smart options required"));
>>
>> Is this an end-user facing error message?  I am not sure a user who
>> saw this message can figure out what went wrong or how to correct
>> it.
>
> I thought it would be better to say why it fails instead of a generic
> error. If we drop the check it will die() later with "remote does not
> support object-info".
>
> Since the smart options check only die()s when the remote is a bundle,
> I could keep it and change the message to "object-info is not supported
> on bundles".

I am somewhat torn on this.  It is certainly much better than the
"smart options required" message, which the end user would not know
how to act upon.  However, that improvement only holds until we gain
another transport other than bundle that also lacks support for
"smart options".  Saying something like "object-info is not
supported by this remote." would avoid blindly mentioning "bundle"
when the remote that lacks object-info support is actually not a
bundle, but it loses the clarity your rewritten message provides
when the problematic remote indeed is a bundle.

Do we have the remote information at this point in the code (i.e., the
URL of the remote that was given to the remote-object-info command)
that the user would immediately recognize as the remote they asked
the command to access?  If so, "object-info is not supported by %s"
filled with the remote information would probably work better.

Thanks.


