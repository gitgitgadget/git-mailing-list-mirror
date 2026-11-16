Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815225;
	b=gA09lvXbQyyFHhCFye3UDFiYk5pzT0LDS0xWac1HLD3YPnpsZnkoC49xrK/YrZHFoAZa
	 80G4+12TpJN7Yw+wtLkekLhXuLk3tWoFtbExj3imPjJP50oRhRGW1QRyakvQHD8pk3/it
	 I55to47RcAIXhjawyALTJp33Muu1+NIFXayjEzm2BlvoPeP+ZwkW5YcR9Eo23Pugtwz4E
	 O/1pWuJAFem/p8wVrpSRUG1ut72aroW9TZTgRhuEab3mngamaMH3FHNUz5rtF+XQ2wWdn
	 B+IefQRJsz6ovSrDJha4C9MOlADften5quLquxlAMZAeKReNUWDnYuzFaI2Rwgzg1lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815225;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WF4QKfEmgxbaImD0viSQlB8CdU2SrxiaoLhOvvAqwyM=;
	b=wGCIzKYHXJ4GttYvdShRv1RDf3a3RyYh0q9e2RedWur2x9mISl5ELelxkyVwCRaSB/G2
	 IEZ32dDMVlajgM+/05/bO8z6xkYCjOVnVl2enXtpEhE+1w1ZxudlK62VexjGwjy2yvfvj
	 Uc+aXi3a//TGv6RAPecQ9Pdi0ffAGjOLb8YoqWif2wKxNs3TT1FlExffq6AuWpwZXpz6W
	 oYbzx3CEsVCGjJjqrvmFQyNY5BSuLdS/JJq+MYFjrpNx5SvwPA8Ux7ziNxbz0daiHCk0S
	 LnBwWFRdKk+zi0MPmoWjHhUCeT6T53796aiBz9hIp+BT62309xwEmKGbQi25r2UgYBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=BMrZ2fVh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ndn1jYxU;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F356C606A323
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 07:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F356C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=BMrZ2fVh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Ndn1jYxU
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 54A8F1D0013B
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 02:47:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Nov 2026 02:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794815223; x=1794901623; bh=WF4QKfEmgx
	baImD0viSQlB8CdU2SrxiaoLhOvvAqwyM=; b=BMrZ2fVhviCYJd/oj9XMaAxyPU
	6iA82r7NrPknqJk9aHofdndRn/ODYyDoTHL4oRWJj9uB8vNEjPZbUoxziib7c6gL
	u3SX6E9q0jkENJWjljsJRLz/0ZYMhOuR/Hk0ahLrRLlnNlyvsJdspCLNphZfzFji
	uc8+RPcI1NBFk3S4C0Gb2xQ4hL2OgQxysNm+T225SBCU1IQcw6yvGq26vr7iLDBs
	Q+H7NOgimscE//5dAOLUb93ZpU/hNN3DiOzegc68uSQqGEoO65Ld9twKylxgEDHt
	L+yUlEeOYXxcBbqOrdT6olDAm8UKGDL7tfNckQzo6twmx5ZRiM1022uqa4lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794815223; x=1794901623; bh=WF4QKfEmgxbaImD0viSQlB8CdU2SrxiaoLh
	OvvAqwyM=; b=Ndn1jYxUVnQIgH3tnVXCD4m2drcs5R3tbtEl8yfUBFcahWhxJmQ
	ULZIMDqIzbVeSIRLN++NXjCp1fpKDS+Ad1ocAcz4f4tEwBHQHeikCmERDzcStyf6
	zoMNRxxs0EFo8od2xb56zSgekeqq26rCfMcABrPns0yVmG2sUnK5k9ypEw2B4TDK
	aMO1k4WOrfZKebtW6SDz+X9FLwaww0OSU56AL6dha8XJzTpXGzVzpnqvtU3Ctvjp
	hqQOP/zZORphKlm8osSZFBTtoPCe1I+RFDS6vXer/xkNNouOu7zQmwNdenBbllha
	NQGz25EuDKwn5zsyvlTXUKW5I/55YrCmn+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794815223; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:u+MORfEmGCyJPSZ1eP4Ib+UlFmgvYx12QmoiZr8GfAqzr1b
	ANHuWsQAj6ES4iXVpzcCB0kEwuikDJYJJJG6vH96+mqnynWoDOb+zPs2CkUDa9N0
	DQuLMEJdfaJQGG0iWxMkXCtNj8MSoPyoO8L1uGiEgu7ubYNcTpS46O/rf5NPykp0
	tWjVrg/gfqtXGE8199f5PoNLh987q1x5B+Hocch4F+NuoBQG7fw8a1oBSLP6yY0R
	+EJzLdj9UwTPNyrl3QSgTUje7gz5XWG9jkGRoo7bvCQpQEgT+0+nbVXLvpM80QUQ
	850NEXYpVaI4KD2mc3bzV/zdpuuvuf5Th3TnxAw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:kz/W67dt1fmpPXvYG1zh0FpLi2cz23N0CdTzEKhxsSs=:rSaxrqWfu+yDlpo00arE3Wa6AYJrYof27vgqtbd/NUI=;
X-ME-Sender: <xms:97T6avadV78LnJOp8DgfkDUYZNmMdmg334F2W2EEd9SHqSXvAP5a4A>
    <xme:97T6aiGHchpwgA7gKYI721QHKdr2E7c0sEoD3MlcfKhG4q-UdGtbG3faH9OX97wkp
    -1zVHD3AKVdu4LkjLjoqB4BnIfuGsoJs24kzwfe85lfgJAoo8Cu0iY>
X-ME-Received: <xmr:97T6aryJWqEFZP8y98gAGuwhZKJ8SeBKVdKEpqTj4phZegDF0-U12vuTi7aPxRr9tK-ZBLo>
X-ME-Proxy-Cause: dmFkZTEBqW15UE0A8N0Npr6FWHRk72PtyRsBdT4qdpNkpOhHtezYDOJaCOuOcZEr4DFsTQ
    0ype4bpMgVM4aScxr/pOjD6pBTdDVmN9UsNAwf1VqqVC5i1GjY0VZ6iUwTsr83PLsf7W1u
    ikAFxpRsEM1UxcmN9/kdXT8d19mr9SCdF5WbiarFfHkNa7h+TmZiwZlyUn1sEA8T2Ag5cu
    0O3F7AIeb1ftvdhzER07l9PWcUxpgA8WPPkRTPLXMpgisDoK/8D6I1l5U9O+iK/J57s89z
    ASSyhBEXd4MJPNUbv4i6bxGjRf4DfILQZSeon1NY1pTD1XoC1VWIGW8PjBF15DIakELqLv
    w0VjIFNsQb20/1/YWQSuYeuP9nlMcuZmLePMvrRkxiyeLLRHLt7GeBxJxy8aWhawPKC2sf
    rN9KK8hpMJj7z74f8yELsIfLZDUspaCz+0AYarQdVyQR+3ybKJg/defVXSsLPEZzlAV0QD
    rEvr8BQf8rmNkUYXbRiCAyhcKD9Tu9gBmWOcOL+YuydUEHUAH2kCQMd+xEt0dnXiSexJm3
    j9TWc5KuYu2j3LYctLnwstrZBf6hNW2zedBlufVjRjsLy5DgdFeIlDgVnMRa8ULwRAK+yN
    c3jGHIxhtWRTEjALgGl7o+/Y17dAZCIyOXeS6L5zNitaSGRqyyBF83ZfKgLg
X-ME-Proxy: <xmx:97T6asn8iPDpvjYV2KCOQQ38qz08JWKI0UYLIv3gKVmP0yjWtqWOQA>
    <xmx:97T6askGMjvzeWrcIYZS6JreuQibFF3D-YipDTHJ1uuzHyD4JV4PYQ>
    <xmx:97T6amyY4UTcJdhIL6s27Sy14-qd99ArOxuqVSxhLo2Vekv5ieIm5A>
    <xmx:97T6appklzw5zXkc2EzcHH5Ov_a20puQhUy46XzUDQZkbl87Birr5Q>
    <xmx:97T6ankKW6FwXrvY_xVTzl8Wmpfgjzd8vafnjrw9D2cBKQ5QiKKnUZqO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 02:47:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fab52b82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 07:47:00 +0000 (UTC)
Date: Mon, 16 Nov 2026 08:46:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
Message-ID: <avq08CLwtg0GQWnN@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
 <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
 <CAOLa=ZTAYtq0K4YfcSBocf-fxadTiaJp+AV5-_6_pbNMBwYQXA@mail.gmail.com>
 <ava6Q1u65ASVeth5@pks.im>
 <xmqq33t4eh84.fsf@gitster.g>
 <1ebac86a-6674-4c6c-bcff-a71c05b26d3f@gmail.com>
 <xmqqtslk9zk2.fsf@gitster.g>
 <20261114072240.DBIRJ%taahol@utu.fi>
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
In-Reply-To: <20261114072240.DBIRJ%taahol@utu.fi>

On Sat, Nov 14, 2026 at 09:22:40AM +0200, Tuomas Ahola wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> 
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> > 
> > > On 13/11/2026 18:09, Junio C Hamano wrote:
> > >> 
> > >>      $ git checkout ps/rerere-subcommands
> > >>      $ edit rerere.h
> > >>      $ git log --oneline --first-parent master..
> > >>      $ git commit -a --fixup HEAD~10
> > >>      $ git rebase --autosquash HEAD~11
> > >> 
> > >> By the way, I wonder if we can simplify the last three steps in any
> > >> way?
> > >> 
> > >>   * We can use 'HEAD^{/^rerere: convert flags}' instead of counting.
> > >> 
> > >>   * The last "rebase" does not have to be on HEAD~11; as long as it
> > >>     covers HEAD~10 it is OK, but we cannot use 'master' as I am *not*
> > >>     interested in taking any new development from there, and I do not
> > >>     want to worry about what the command would do on the merges the
> > >>     topic has as synthetic base.
> > >
> > > So long as you've set an upstream branch, you can use "--keep-base" and 
> > > omit the upstream commit.
> > 
> > I do not think I want to set upstream for ~600 topic branches (among
> > ~100 are still in flight) I keep around.  I was hoping that after
> > making fixup changes in my editor and adding them to the index
> > 
> >     $ edit rerere.h
> >     $ git add -u
> > 
> > A single command that names the target of the added change
> > 
> >     $ git fixup HEAD~10
> > 
> > would automatically do the two "commit && rebase" commands.
> > 
> 
> Which is exactly what 'git history fixup HEAD~10' strives to do, isn't it?

Yup. The only part still missing there to help Junio's case is to replay
merge commits. Once it supports that you can say `git history fixup
"HEAD^{/^rerere: convert flags}"`.

Patrick
