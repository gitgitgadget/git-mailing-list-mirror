Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974453;
	b=QYfwilal9JG0+8ENTxUOq/Hpvnr4qthOMxCUbRt9JkgpjCp3vypgP7wVapt0lv0AbJXW
	 CXzILtKv8vzKkTsx1IFFy94RhSED/U75f+u9Z9MusVD08zf9D8LcDJQr3jiGNG2cg7mnc
	 r52r9cdBvft40PYyQIBC/H8Sg2Gtj7pjNzZbQx2BB9bDWTC3RnrUyw9WtEui8Wv4QCZrX
	 FswhvknucYVqQYp8uKM1TVeo0Norw/WvlSVN4e9wQDoxQsCVRfvubaZvvufy9ORBCcgZF
	 Gd9jAnN8vI81SNHqlFnr/4kssnVqpzHjaJ5TC5qCZmoS7u/2qGUgIEicqFen9xTd2KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974453;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=d2fHPjhUIuG3wGpDmjBvxMFSdaBrW3Ye3OoeEt8Bgzg=;
	b=zER89peFPudhCPGqetJix2f3WWhWDQQpNHpYpt+698AsoOgPJ8BKj94WuUi/ANylTsfk
	 jsqjmRrOkieaijEvhR6NLRoBA2Fy3CSAB8OsDJSblfHJgsmPtXlH/z46t4nwPFPbdddvM
	 v3sO9QWPcgVRdJr3h72Rw0fAv55J6MdwziIQVDTvIANwBR9V/XptnpdOKJX7eHFd58eat
	 g43su+1d1oZ9AX1cvFS8pw0GWd+OLgF18ypEtfEh83ny8L+5NKAdn6i3oxP+SgFlNDHUh
	 FWg5RVecwry4wxspqFWHpusMqhvy0dZnMeze55iEBWSUsXgPn3fCoQf/viMbituC78A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=fF84krh6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KEkmye23;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36109606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36109606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=fF84krh6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KEkmye23
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 271CE1D00124
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 09:14:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 06 Nov 2026 09:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793974450; x=1794060850; bh=d2fHPjhUIu
	G3wGpDmjBvxMFSdaBrW3Ye3OoeEt8Bgzg=; b=fF84krh6R/5LECelz3SVtBhawE
	fj57vmaD8W6fxp9UI0Ot+AYRmOTVfl4aJIuhXFpr4xDPHUHLQ9wYhCmv2LQdQuzl
	lybvABlXU9A3CfSzj/QThgI3x2ZyQ+fzBtQ45NCVOM5oZft4W42klQFbzmu1CA50
	/hk+WwdsXMpECPH7mSGOZTin7iyxdG4hmpk5h4s99ak58I21aL/krp+HRR6fDPg3
	HWJBoB6bok9ek7JQZvsjxGKydR8Uaojm9HAEFxXRGHL03QWfAbxPnQqMrNJlAFTO
	aTLNcAen7E1zQUqjHmvHEeFPcDuzqRVkFTQaSnJkIDrstgy7rahqZ3/dJI9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793974450; x=1794060850; bh=d2fHPjhUIuG3wGpDmjBvxMFSdaBrW3Ye3Oo
	eEt8Bgzg=; b=KEkmye23GBgRPiq/KkNuSm8MBUNNXAGs5Cxepw1aKIUeyRy4dW+
	S5mtQkUdmX2M4Jx39FNOAH88IEJXE7OCwRMaRlxHENOxCEveiqFZeMdb4IRVqP9K
	E4IhBYfV38GIOWkqz09ns1ymvy8LUi9f0ixnsy6awLLsdxS8fWPfJZy68nqJNbCK
	OhuHvKBQW7O6Cyu70IIJeC1Ttyoyxbz1B8RMk9G+2yFPLrdO8/831kap2EVr5q64
	KeJXuE0Qvlh7s6xsZ52MCDqGt3oo7WKMsn4iIyE14n/YHHVvJRelB0DSC6fbrnsm
	tCLsT3dBxxKYigAN0iRXfseBAs0oHI6W/lA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793974450; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:yguj+EElDD3AKsjtDs1OOJ6Ijp7DEqR/qb90iJTYCbReZgR
	Q4ROMuPtbfw5khaxb09VUUczpQOFDSf8mImbwByPY4ceCiqcOulMJdpN8LZYwIoN
	2ye5/vtJRFT3mtCGHNbAm9rPwPv7EVRV8BvfazPfIeWKbFjiDaLl4fgZCkHT91bp
	GdbpTcoo3mvAtK16riYhceAtRUvGWsrJ+Y90oHEwYkGQLCjxeFCb4DD6Fp8VM9MG
	K/4n5K74QIRndhR/9Tcfw/QuPnEgB2ZFZtI9t03MLRK2qKjR7J1iqVNcj9GPI65N
	RM7V+D5Iqsdxba+sj+nBkaPv2hzoHVa6j30Rnaw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:85AROBDh42J+u56zt8PhLCAvHZjl6nl8oY5RxMY55Ok=:DTNcngkw18jNPI1fboNfp0M1WAb6zgKnVpjgOpdyCdc=;
X-ME-Sender: <xms:suDtanlkPtVkmzseoltAxucb6tvzcyiehz1Robk-e_TwrC_p1svNfg>
    <xme:suDtah0-kMov9rg6y_xVRcikJzx-AgOrT2OM8_SWAmlzl-ziT9YYIsHGSYQ3hiF4J
    gRrGE3S-LEBVZYV3ZP0xPX4N5MHHPt1JZ8HKY7ggzxTUTIeT8Ht3w4>
X-ME-Received: <xmr:suDtaiqO3q0aWtMTg97rb3k8VC3tWTitKNazR2sxnwbEqD3akdk65NXvMaXZwz6up_cV0w>
X-ME-Proxy-Cause: dmFkZTETgXY598R+p9wU8H+amhlSOKZDjmdISNZ/aoOw77BInPbYYlIq5/n04G5Yjeain9
    OVDPJEAEZVoeRPRCW20zoo2Lj3vhYzEO3ezOEfDN7G+/OyXR3vYAXaS7Bf1c6VbHZzzbww
    0iJ8Pn2GWXyCOtmGjpf0nJ544KNC8IEpQoqFfAKJ4os0DbvKI5v1rrTBxCsoXO6j7iVV4n
    cIkcC14JeSCyEKWS0gZUgDtVjnb/6wTKuG/vfbtWQJdmEC0e71g1uM6iAsGh2yGu1QV3mg
    FTx4lrcFIFOEFQ1mBI2Gb8LWS0tknBOonY6zqqdB89QfiTpoHDQjoMpzgz+RJShCyhQvnP
    KOG6a5qJplN0LgGv5z9cTL/A8c6SyjgzJ4z2O8mjyLNEqIaJcKM4uRob6TsNvFxQB6kXwJ
    rC4L8EEZkcK4f5G7+DdMhQBPVk80YkqFmKRL7bdr7R8SCKK8qUBBnGqrSNeRj0EE4eq1Hw
    679/AmeQCw11EDjOfVJYILdN088rbbkh7o+K2Bc0ldPgg01ZjNkPLzxVtep1kak9KhpjNR
    Hpui6tbPKZdkodXKj4WFaQeEngnRWwRtlnAA2UaAMA4RD9LghLRKdvPoUjzzZ8HRlT7Xoe
    7y4PBdzfjDkH7Q0mFsKXckxzRJLWVGpVVS/GioYiygW+maiHVHn1EhekI7sQ
X-ME-Proxy: <xmx:suDtaudRVE_F6GeqRk_6Mk77CWzurglckqxUTjbIzBRGH3s1KNoL_w>
    <xmx:suDtahqfsQhOQhUlj_mrFfqLY5_giJU5h6EQsK-cMdtUQey4HoBjPA>
    <xmx:suDtavFnIM-AdxcbC7wbNVVJiCJqjlxaW9QNVddCQKRHhjhlknZx1g>
    <xmx:suDtahvbRaZkNifKgdzLva1NrpbhPfVFjrabdz7n9lNxyHfC4dmVfg>
    <xmx:suDtamaEN83Es220sXEyD7gEyTE8MPAvfAy_IeOB6I_KoS-rHmu7W_Hd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 09:14:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35477967 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 14:14:06 +0000 (UTC)
Date: Fri, 6 Nov 2026 15:14:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: gitster@pobox.com, szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v4 0/6] log: speed up --follow following renames for
 non-linear history
Message-ID: <au3gn7kUFYZWUinE@pks.im>
References: <cover.1792701579.git.vmiklos@collabora.com>
 <cover.1793298331.git.vmiklos@collabora.com>
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
In-Reply-To: <cover.1793298331.git.vmiklos@collabora.com>

Hi Miklos,

On Fri, Oct 30, 2026 at 09:07:00PM +0100, Miklos Vajna wrote:
> Hi Patrick,
> 
> Thanks for the reviews of v3. Changes in v4:

please note that the expectation is that you answer to the review
comments directly instead of only answering reviews via the cover letter
of the next version. We want there to be discussions, and reviewers
should not have to figure out by themselves whether you did or did not
address specific concerns.

> - Patch 6/6 fixes the case you found, where the speedup lost history:
>   one side of the merge renamed the path, and the other side, whose
>   version the merge dropped, edited the old name. It uses your test.
>   I kept it separate from the speedup patch, which is complicated
>   enough already. With the extra check, the linux.git case still takes
>   about 37s.

Hmm, okay. But isn't it the case that your speedup patch introduces a
regression where we now don't follow history in some specific cases
anymore, and that regression was only introduced in the preceding
commit? So it's a bit curious to have this be an extra commit.

> - I also noticed that the simplify patch lost history with
>   --diff-merges=first-parent, which diffs merges only against their
>   first parent, but still walks all parents. Fixed that and added a
>   test for it to 1/6.

> Interdiff against v3:

Instead of an interdiff, could you please send a range-diff next time?
That makes it was easier to see which specific commits I need to have a
look at again, and it also shows diffs to commit messages.

Patrick
