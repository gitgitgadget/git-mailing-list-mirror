Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276328;
	b=BtYVGTHIYLb6zchICfUKjm2DGztdl+oe19AK8wdPkUvU1tBXXKTikGu/InwEd1UR+w23
	 /+7OF5pkfCOkFLvORQsshmIsVIA6v/ARe2ompdBrQj7P+7b0CTRroeFKyOLvkTyJ3mIkX
	 64KaXnduxycDhj7VhPBzHQboIpiIGpvBVjKaAZHM4NfDRRvIHNiDR7SRMjvhYY4u6lZNw
	 V715T6NDAy56+EuAPgmverEBem4O2xwVpE7sWjzImP6/u2VWt+IFkqyuWg0h7VovmD3ot
	 wDTidJsbU9QlyVMwzjHsbYfWVUq+MWua3h6buqh9rwnMXd2jAkN7xqomL+VdTH/50UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276328;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9bu2wadVSP0op0yWs50l8hjES5Cl1MOmsLCL5ZjouAs=;
	b=UWzIOCRYplrsDxNGDiVbTUQoPhesRu2ZzxzvVKr9FXQnqxg+QtYBoWVSJFFwvHO3DBmG
	 wLbRleQ03MRrHkSl0VT4CRBBhh4p8INVGIQcpJnXeEvjFuzbtjRSJA8RajxvWL6qO2Inj
	 u3YN1BrHzehEeXBz60j4q8Xoxw1swZ/5eHB8koLcqY3e/eZxwEZntalkfjSBNNhFHgiKR
	 KYa4PgMqo2690ReAuFTyBN53LrpR7WYja3gall1V0NIqTrKXboXuWYyOQlBG9pLHUqTvS
	 J4osip6j7r+ZlO0Q8Wh+REkAzYsjXMukBgZHKoQGT7lrntVtFi2Olp/IAij/B+mC61g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=kLNgvwKS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=u4GPShCz;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0852606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0852606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=kLNgvwKS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=u4GPShCz
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 259311D00156
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:18:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 08:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793276326; x=1793362726; bh=9bu2wadVSP
	0op0yWs50l8hjES5Cl1MOmsLCL5ZjouAs=; b=kLNgvwKSM4lb7tqTGcUpoBK5f0
	OIyNdZI/8boatVyxp/GrcdEF2Oeee7/B+Re6yRi32ELvHJ9DLUxkQwXM2JK4e1aY
	T7fQDdoMtUPSzSPyzoWu2ocxS8YDtN0WXUtwHsi1CrOx8UWXCw1/7ZHS3n7ohb7G
	u2qDU+SeWq6VCKZ66je8fNAohYVu2wEsTK3nJkeF8sb+aqjvMHsH96zWpxPVM8qa
	RD/NYyLNW5k4tQMAMEir8HOYz2rCPzrSTaJgQ1cLF9pgplzNLZAlVIezXu6DQV/o
	gkDDaLEVBEUG05aZtg4/vjnmTAwL6FoD9Db4PavznsYhTTbJ6e8s6SESvRUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793276326; x=1793362726; bh=9bu2wadVSP0op0yWs50l8hjES5Cl1MOmsLC
	L5ZjouAs=; b=u4GPShCzHBOjA3hQ0fGtj75NahRSzd7EIa8ef8eEw1fzmfkC5MR
	mZsqEKnUqFLTGwc/eIEW/XUComjE/gjbfqM/BhU7XpylW/oaDX18Ay0+KMTAnhNK
	/u3bmMB4XO8VFKnDohJl/U35TGtYq8m3NC+3xvX62PkvV/RdG3MOKPHyYW/Z7Q+/
	EgR35fWokc/AC/RjAfBoFQJpP+tRCDBWljfNHIpdgu7+WNm6nvFHjO8KHw5wjqZ9
	y88uiz1/slBosW6068CNVmmNfB9ga7IjzO24UxIgwhydjnIl677THKgEs0c8D91y
	Nz+MnEE18rVLWXDIMWZ4nYCXWoLsEHee77Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793276326; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:tWXlnj+SeXQvlJ7rXcVPHgpDydMOSC1xVm4uWr+Z4LIjWEG
	BrS/pVqQm99zWciTSD/iTaFdqad6S/j3jNpM3DohK2jRZ2J1p3KnZ9oRXLqBLHkZ
	RRklUh0jVY30PaFLJ7UrFIgARKTD9W21hqXiHs+M2JHtgEXDXioMhuxYzU51Iwyi
	TsXEX87RJAqmKmAjwjzUIXgpI7skUD7yy7+lG0Zs7n+NxM8iKMW1gLcec2o29g32
	fYZTpBVdBKvAyLMPTGe8T+nUWVM2dj8EqRATrN5sqZl6kc9xfpdIl5Qzltlna7sw
	NCbGMoJ97S2dpjSX9hs2XXArebH22DhKuUsv8Zw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+sR0dHloZ5+sELuYA69WJNYoUtJu8Bcvaki0rH7XG8o=:Ibp7ZdwhLHXECTs3OL9rz1JP2G/+3EIJfwdsio8rOhc=;
X-ME-Sender: <xms:pjnjagMRcF5d7mQ-aklt8V6KItSqb5Qjs_jyR0agomlYFxSsrtD65A>
    <xme:pjnjat3W8Ej-mQHLWKlS6MkGY4k-teGo-GrhqNpWIZZRF9wdwumZrm1A_4yNej7yl
    9RgtIboihPqEMLlclU_YpyG8eJv8oy7tacSmpVDOJm88XgC2zpioK4>
X-ME-Received: <xmr:pjnjavmcZMx_H_f43dBz4-tJJP3bSRV7eAuZGgv5ZlL8YJT9BSlsuA>
X-ME-Proxy-Cause: dmFkZTFR4xdzNoWuhk/X7D2sB58gqpiefEhbCzr+ONPKIrSIMuiRgWMIMgvXrE8kli/b4z
    p5Ki8/ILcdBFSxlXJ/47edoICc+nghCIAXexg+DU1UZQEIdRjMdR3RSIRP/4kOwGYFBsVH
    /Zi4nuWKIonfIeHCx5sBu2g+TK682BEyhPl+ipb98RfWeeO0Go2VUMRSV0kwAX+R8vmD6R
    byDGVo5pjLGXZUSREbYX6h+fjDoKOBSC2cOblTIOjA+F6+BsfWHt06vjYeV6LMEITyydAS
    CUSxVUPHmc6Nxd4sezJDc4ghSbHukWHPBLiL+bmrI8+EDGSGLlGO3cfLlnRbJBQnof8bSD
    j68upJz0j5Z+HAMz1P26kW7wIcaADX7TD7dzFH3tje1m+3SH3Lx30V+UIfX4+rrHW1iu/K
    Pxz5LOMec3HJJN5dm3isN7Q46/5IJO6fTL03CyrpMcSMmLQZPZn8Clgp3JqfzCK/k5bege
    2VqR9yaTssrxOKHgMGSu7Es0C+OTVYvXfSYvlvr7Gn4U6Euaud3KYhEYibnXe8hJb5e41A
    qEsbweB+DcJaURCxmYr/nVfSfbA8WFuZi7gZ2WM75dKdWRHlDdKmpWL07t4BegXuGe81SA
    lPdiUxGVYHhI5DgU6EI/YXGmnHDIzmKOqDQp9sQO3utea2lKniZmYa260kng
X-ME-Proxy: <xmx:pjnjakW2C5Vj8YZpWFuRzBZbutceOP2DcjxhIVgSKWYnphD344wf8g>
    <xmx:pjnjaltWcA4tZISNpwU18lzpJzHFX45BDxD_EjHDQuqJ9YdXyQJeLA>
    <xmx:pjnjanbgSp1TMjQv_mrXl69IkSHKo7w5guIiJD_35OjwajTz-R78yQ>
    <xmx:pjnjakXejNXhUcbDhe9e3trhHaKvR6Vdi1H13z5Ui0vF-LMOtj-e6Q>
    <xmx:pjnjahz6DvlRYtbkIDOS_mzXJxwMkUoI2oDaNau5YpZ9yMHEfq6d9COK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 08:18:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b0fd152 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 12:18:43 +0000 (UTC)
Date: Thu, 29 Oct 2026 13:18:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Sven Weiland <sven.weiland@tngtech.com>
Subject: Re: [PATCH] builtin/reflog: say "would prune" for named refs with
 --dry-run
Message-ID: <auM5oUilcWRuWhDA@pks.im>
References: <20261024013850.66448-1-laveeshb@laveeshbansal.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024013850.66448-1-laveeshb@laveeshbansal.com>

On Fri, Oct 23, 2026 at 06:38:50PM -0700, Laveesh Bansal wrote:
> With --dry-run --verbose, "git reflog expire --all" reports the entries
> it would remove as "would prune", but when refs are named on the command
> line it reports them as "prune", which looks as if they were removed:
> 
>     $ git reflog expire --dry-run --verbose --expire=now HEAD
>     prune commit (initial): first
> 
> Nothing is removed in either case, only the label is wrong. This was
> reported at [1].
> 
> fcd2c3d9d8 (reflog + refs-backend: move "verbose" out of the backend,
> 2021-12-22) added dry_run to struct expire_reflog_policy_cb and set it
> in the --all loop, but not in the loop for named refs. Set it there
> too.

Phew, kind of lucky that it's only the message and not us accidentally
pruning stuff.

> Add tests for named refs and --all. No test checked the keep/prune
> wording before.

Tiny nit, not worth a reroll: this paragraph doesn't really add a ton of
value, as it's self-evident from the patch.

> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 93b5b49e1d..998a7e8667 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -240,6 +240,40 @@ test_expect_success 'reflog expire --dry-run should not touch reflog' '
>  	check_fsck "missing blob $F"
>  '
>  
> +# A dry run only ever says "keep" or "would prune".
> +check_dry_run_output () {
> +	test_grep "^would prune " "$1" &&
> +	sed -e "/^keep /d" -e "/^would prune /d" \
> +		-e "/^Marking reachable objects/d" "$1" >unexpected &&
> +	test_must_be_empty unexpected
> +}

Okay, this is quite defensive in that it both checks that we print
"would prune" but none of the other lines. We could have made it even
more defensive by filtering out "would prune" lines and then testing
that the result is empty. But this here is certainly good enough, I'd
say.

So overall this looks good to me as-is, thanks!

Patrick
