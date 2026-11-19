Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089527;
	b=HeR+OAAKyyHQ9F7YRmFEFlDxkTkNOeR16yNtpMQZ4v+G75fxBzh+ZTd136cknbeElFdR
	 Yzz9LDOMyvImGNru6gsId2C2pkCAyFOqH8hIWxorrLrHGLgaejFe/85U9DH9cwSz876ln
	 lLHwXRZf+9iPetXIndO2yyFtq5Ui3vQH1YO0JeRIyHcQctCHQMLJ7kzngp3LndoQtpM7b
	 T39ANFjlMuYPK1wM3eEhHtZ42yOhtG7TxOPjhE404O8begkVERRbZFPSAwchCDF1KzevP
	 jkuF1cTLq8RtmsK1Wb3eV/v2VeVUoeWJ7fxOvR0GNyfx/UBXsEOAkEUoLojxnXyU16Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089527;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xYCwQO1N/BVzX6aOPrJ76LO5/WAoXGV+NWhXgjYs9yc=;
	b=roTU0GsoDhzjKijOruQ2Tea9g0LCs7xS0WvXy+O+cmG32qPOkCHj1Y7rdfdD07UNey3F
	 LuNpjx0RyphiIvgdWijbeeHSjM42/b6/BwH9gVeADyXmEghzopSkrU9I9MEgOv7ECuLep
	 Mv2uYvme/KGE9Qcyx6AINE5ehhFktkO5ZzKyFuX0g3EY79GZVn9okYPsB9iIvJs596Bd1
	 SfKPq2p6KLQEePUohQF8Lf9C8NM1VY5VQzWcQXKbZ5s3zXgccQzQUmBJQd4CfCAPfvaaZ
	 zOaBfQFfEkvhSQLuMskrQa5i2m5WnvMBu8LTH8nYzJDi4U0TWf0M6CFVt2RQq/RdkXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=QThLw8f2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fOazvRYF;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9992606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9992606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=QThLw8f2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fOazvRYF
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 174A014001C0
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:58:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 06:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795089526; x=1795175926; bh=xYCwQO1N/B
	VzX6aOPrJ76LO5/WAoXGV+NWhXgjYs9yc=; b=QThLw8f2UiDGsa6mXnxv4O6BL9
	LUGT0B4RgjgPrRKXMPaymMJm0Q9gK+liTK6EH7CF3f31m6w4ivet6fRKC/SVcIQx
	9VoJiHm3HctKJXeaRkmTg45HTcnaEEeSyra84mq3upKg5tS2w3eOo5In6UmhKsBz
	XsBpz/SNFKDnSa5dQbtu7JKc/+umCSW0oH4WMPAXBWhJqoz/yZljJU0H6+XBnrAH
	6ETAmM7KvQ5ylQiG3DXxSmZ+WRwjtil73otkGz6imod2K6zqXpW7drTb75zJ9cBD
	NvjXgJKKZbQMFOOMDEgIXcLefnfsi2g3E5hcrELwDNos+n1LbrncZQh5NXsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795089526; x=1795175926; bh=xYCwQO1N/BVzX6aOPrJ76LO5/WAoXGV+NWh
	XgjYs9yc=; b=fOazvRYFbRJXvesVkpTOJFzxWorESIsNCmZ1icmBwhxyTMCRc2q
	NU9+ReKkbRr7Ahl7hJb8Rwuau1T9m260VpNgoM2d9SEPpIRngMw4xG7Hd5YHHUsq
	t/gUeIouGDoqWhwAQWWo/NPrfpYQl746k6dHWOrGQ5LPH8ko9TKJz6eQzcyGk7sw
	d98M/gG7WossoSQSJGRxsRvkrRDgzmxcwvCJIa5zAatRIGGZkqo2xSdX8jmpsheb
	JKpZN/o2qyzDpZcp36GyBjO4XP0M0HTkbrhh8GH4DQaFM2+JKU/XKyHHoJQaWxcc
	GJ5qb5dUpD8oQip1NRebANhjWHa2tHwqnuQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795089526; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:DLcZxBeVTGKD5jlinrXA/8nqbbCUNT18YmSN1CUDPp98DFu
	D7N+m/mGOPV+TabD1plG08D7QmFOQ1GiOKcnNp/ErX3roMsxaSjldBwkL3pe7Kk5
	yOIXkNoE1rQTY2wkxfRxZhhc3xqansj0ny039I7kvxNSor2NWidCDXaFS6kx0iH4
	AM1V8uVomIp1hHf9K042gXtLBeHaxC8rYNxAPK00mM3HfSuVZu9FTU/yCkrPQZ4j
	ue8n0YSTqAYyx+2R3F6E1BWpgiKaBDyHuMj5XDzlc9JAnI3HfCfJdgBNKf6dCO/U
	kUYjO8cARvyycV1qDXW0NAl3JzA4SS/C2F+O8Ow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YkAahoIUwcLhLBXVjp3516mljqQ8FQ38nfvnXllk2UE=:ihcQUYKy9u8R8/UTHWkJuc0TTbxNeUFx/cRVx2jUv0M=;
X-ME-Sender: <xms:deT-aiz0zR7-4iNLxfKn-2E-SQ6md2g-OHBReHnrU6yj96Y3gZyWQw>
    <xme:deT-akQeNECvNJrj7Knkpcon-drF9ypovYr4xbMnrJPcSlV5Q-2OrliGF60MbON_b
    R6jmfA4U4BFEF9hR_NLPeBgzSXwOGYz5iRBS31g2kUo4EaCKS7oqA>
X-ME-Received: <xmr:deT-ah_xWjyYYXgu-XdqTz4VAR4C5vWZFjGSsdKyazhLxpfa03U-iyoJcLbyxj83NU0Sbrk>
X-ME-Proxy-Cause: dmFkZTF/pgHeYl/zTTcgs8O4xATC2fmYuNR9fnrmXQ8YCKEeWkilu6sD/HBw9yhHGFTzzb
    f93I19TtzI4girHnAb0+N2j3DKKxFULQRNa5Q/gNw3d2j/2dpQa8JMJWiFA1QD2HCfRI1s
    dBr3TtEEtEariyR8eEIRwOQmEGaTsROZpgA9avXDQ2dnNabkmRvFkd0eRWl5BMTIfquuKK
    OGeV4sXdjrJX6FWEttcmDRTfm+h2dHGiBMHZYLaE4pxkaY9To6faUIl55uf4dYuLmozSie
    Pc0YQdDuCDaQK5rWfreutgZelIF8eviRn8KvE4If0n/gIIrhBGWzR66DRf8S4GEcT120D6
    NQFrhfNlJLkVIR64IXr82JhL6+nkc+9eOOfXvtmcmYe2o369KV36HgVxHF4hef3sJ4nFL9
    3fnAwj/tHlc+CtI9ssaqmv1LaJZzQgq+gMhULQbXk2V6wE2sFxijyUb0VD5jfhz6w1R7Uu
    Eo3ON/ghaK6CWXKJW5knuSTMcoQAtZLCJwZS21u+qEdFU/4Qeu27odAu/AAct00yDQ8eVK
    6UgTbNLy1/Yw6hthPO73DaDl7iFDhUOkvtJUWDHLLCs4iAC82tlxBxueni7RDo1LdT/4Rb
    zZYEqdHpE+hXDlxz7VC+149ccC6PzqjGMnGdMBGMGbHz+4x/hibGBlDxalqA
X-ME-Proxy: <xmx:deT-ajrNyLm-HQYbtvC2sU0ZYsSaVpiJ3dt98BG3khl5TEEkFFDnZg>
    <xmx:deT-amn7H-pUxmvlI1dJ7I4hPYIulQuslE5EbIJTvuLDjQj5Fedfsw>
    <xmx:deT-aiJN4ts4R0LU29nmUrnG1bw6vnOO450pTTbBicVfw_98GRDm8w>
    <xmx:deT-ajwWlGN0w9IOyJpm2iSifMyIwmijcC7JQ2rZOSpn16-fZCP-3w>
    <xmx:duT-amKI7AfVQ3E_y5f3_AXAFj64EFqX_d9mQCk0YLfB8jqqopF9hLf4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:58:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ee78c67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:58:43 +0000 (UTC)
Date: Thu, 19 Nov 2026 12:58:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] builtin/maintenance: only consider `gc.reflogExpire`
 for "--auto"
Message-ID: <av7kbFW33jKrm7xb@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
 <20261118-pks-reflog-expire-performance-v1-3-10b9263566a8@pks.im>
 <87h5hejfw2.fsf@dev.null.iotcl.com.invalid>
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
In-Reply-To: <87h5hejfw2.fsf@dev.null.iotcl.com.invalid>

On Wed, Nov 18, 2026 at 04:52:45PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The "reflog-expire" maintenance task is responsible for expiring reflog
> > entries that are older than either "gc.reflogExpire" for entries that
> > are still reachable, or "gc.reflogExpireUnreachable" for those that are
> > not reachable.
> >
> > When executed with "--auto", the condition that we use to trigger this
> > task verifies whether the number of reflog entries that we would prune
> > is larger than "maintenance.reflog-expire.auto". This is evaluated by
> > walking the "HEAD" reflog, where we then check every entry by calling
> > `should_expire_reflog_ent()`. That function will then check whether the
> > reflog entry refers to a commit that is reachable or not, and depending
> > on the outcome compares against either "gc.reflogExpire", or against
> > both "gc.reflogExpire" and "gc.reflogExpireUnreachable".
> >
> > To decide reachability the caller has to call `reflog_expiry_prepare()`,
> > which amongst other things also performs a reachability walk for a given
> > refname. But we don't do that in the "reflog-expire" maintenance task,
> > and hence every single reflog entry will be considered unreachable and
> > thus we'd consider many reachable entries prunable even though they
> > won't be pruned. So we overcount the number of prunable entries quite a
> > bit and will thus trigger `git reflog expire` even though it won't do
> > anything.
> >
> > Now we could easiliy fix that by calling `reflog_expiry_prepare()`.
> 
> Do you mean "not calling"?
> 
> Anyhow, from reading the diff and the surrounding code, it's not clear
> to me where this is/was called?

It isn't called, and that's exactly the problem because we need to call
it to compute reachability. So we could fix this by starting to call
the function, but we instead pick a different route to fix this issue.

Patrick
