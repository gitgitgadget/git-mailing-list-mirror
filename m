Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725556;
	b=Z9qr+R/jb+W3Sn3+lY/rjiMnYY7Tdx8ReJUFlxQYruiM5l37nYYsYbEQhuKj/bKZ/696
	 U8bnDkzEtUr+LbEM+mVnPOxXeAvH15zyJm0cz3xDM4a7+Vbko5NXpAeBEYdNpgDA2fpYB
	 Zvy4KL+5LYRxjiJUdZNnn9pz3bsNNSyDErTgjehlrwfT2nuQOIYP6qWHLOa5n2/366KGG
	 umxj0AJHOyG3axq/LZDamivL7Voo0HdHJUZhj7r6Qx38lsyED7IxgqRW/w6MMgKif0mZw
	 YnhtptPsKQ1rQDYmFLiioNghIDt5Es9wnZ6brosTsKji+yEfLrb8DIM7FYjOc8EN6lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725556;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jhOpWy7OMt3ToCPY6rlu9Sq1QW+6O1UnAKqLRwLC1I4=;
	b=F8OwVtmSim1DPpbUGMX2bAZWJVrP+V+SdrMUY2hVZCo8/BbTtKRccwgn2p435D6R7pQu
	 9UHIdxd/2Z/hDBgdt51PmhfMTUPYv4YbldiGt0G/9d52/TdGM7OvGvNQbCGJouvb68m0r
	 KaUI9INxJMSrdhPH7cnxliSStl3Jkl0O4rXBRFGdnR2heAlaqqycdHCsVKvCSzJh9sBlQ
	 vG1m46N2BhWUJc2S5xnAIM1bKV70C8nlbM3RcH18EVrX8nycQ4CbrWBQwhSswWRkxkxr6
	 Zehe/VYB87xecUUEZnRvVVUftKzmHXCjSf9NrJi8+1JnW6WmisbO/wV4+5DFICR32ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=UGmAz3YZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ntlJFrqT;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E8606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 20:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC8E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=UGmAz3YZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ntlJFrqT
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD76A7A03C5
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:39:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 26 Nov 2026 15:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795725554; x=1795811954; bh=jhOpWy7OMt
	3ToCPY6rlu9Sq1QW+6O1UnAKqLRwLC1I4=; b=UGmAz3YZ4xKSqIJwzFaAD4tpM+
	raMH4pPrYTc3nOLHRrcZKFUl0bmVWzneaanOR7nlUO+a6NJAzpQvg/QQ9NwQu0AH
	VuPC1PQeXvaItLb5JAnc+rNSHMvVjUxtEJvSvN7STbbeuAWJ4CsvmpQv6Fa2AZJ5
	jXjFMYFDmL/Otm4gWhIXsyUosaOL71kfAHG68l1Di/VBFw2VYkXTJ4ukLBykNI2y
	mLX/6hQM+/7B376TDUqSPA3CU6I5Ze7+dOEDvRpzT+lHsHqSXWCElKYxgdfwz7zW
	ZN+08enfJ/iKig7JvkgepjbBeHOsgqwU0b202/o01VwRxvKpz0QOic/PRApg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795725554; x=1795811954; bh=jhOpWy7OMt3ToCPY6rlu9Sq1QW+6O1UnAKq
	LRwLC1I4=; b=ntlJFrqTX6TRqwU4DCSIcpdLr1S5iqMz7MLV+sCfL9dSvwZ+SRu
	E0Pxxwi0hl3ehhyW8zCqgRoEYEwoqCcLUDXhZWqJYN5cNCxbBaJt35bKkB+liiI8
	DTw0Ww9TjruZ6e0IRn8jNkJkEk3wFzPvJTRDYSRFMLqNFpGslS2A7s8s0MzD5yUN
	Vz+77j2QQ4RnVhgPwmqIzq2BD9d9oL31BcPi1WyVbV+m/bAKlJ5Xd4JBgZnUOQPO
	TsIh1W5NkGUly6jW2/XhVhAdK6P/lbJoR9Yw+slZdMLZba9n7beKyugsTf/6mixk
	zD0StW464ekzixTvEGjoFKucKjRP6Leh8fw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795725554; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PsPhpXMRg2ECh0tzkC5jUgEvEki/LZxnK3Yo7LMVh5KHRtD
	7Xc+9Fk/2up4yUGEZ48sC26i9xxOeyGatIDnd5QRKzJ/WT6gdcxHJxZvkJ9a9etH
	FPVz23F9/isJY4Rw8lVuFXpKokvqj0FBYlpnyoOqt5M2jdzqdZLQJRWzacmTeg/w
	fSUnmHgmaUSfv3vd7adKMRnYPvPSSza7A02PMuh0s1DBGPnT6D+Qtpn3YP7rq4HL
	oIhYYzv9XJnRlljFYs8Pd9M2BO3UdTxXYYDhGTAl6yuLZd/tpOOIWRR7dSaM5w62
	KHUZzKyYO2NQaIhee3ALri7OFEGQUwNu6HjVrVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:02JPI84s5+FdQ2xjro668jbpvHnRBD2K91MLN2lsCKU=:TqV3mqeeeCbCTiR92yM37UU/BJBQi1xKss+kE2GzC60=;
X-ME-Sender: <xms:8pgIa3INJo_7592htT2HF2mJQSrPH2OlMQCPC9MB9n_DP_TXALHShA>
    <xme:8pgIa1szStK_YixfgUgmplDo8NDNcHoHerl9QBI5kyF9N3P5QFIZtYk2jrLZkahFb
    92USaKFTvcCM-me02SQxWbZmW_QPRN9RykkgaTiZ60ACb51mrlY9fY>
X-ME-Received: <xmr:8pgIa8Stv075sdGhvOM81VuzkGIFY8J_uBs2L2HBKCCrxFjscmbBAOuchb1RfhNylLKEy1GP9KKhH0RQ4SCKLZt_4eNfty13FTW93nU>
X-ME-Proxy-Cause: dmFkZTFeVzYUXZnL4g1XJZAdmtXK7GqXGHbdf7i+1c+Nv5fVP4Tibh9gpgB0syPcPP0+dZ
    1Rq/PZWYQBrLmeQnIlgSIxyhoWa86PbYfCq+LuMiMdNJVmOCUIyodMS6XyhOAbD2//kk1k
    kUCcEY8uZ48zIqGB6nDElPVAGxeQzPN6NF0u0nMrrqaUUiTfcxwGr+geACNd66o/6qREkX
    LdUDwvx6UOhVn6b9ktrE6tLzct4S4ZYXmR9+6i+BDVflzuI/Mu1X4ZEmR23V4MxRmUh4fu
    CN5gEYPYaTkb/oeh1v0b/Zq1oHElhxlYrJjAiJ7zcljRwfAL7RQBJzA0ztk8qHe7UP//tM
    gdK1FQaxh+y88JTxSeHsicOvqta97b0LK9VqRyugN6VnYf1pT+nylkXVeZojdMA8ETGZO8
    fLAw/4CE6u6pl2ym63OnH595QuRxOHabPV+Q9pRzG0xTSkDv5uiUstpV2H8vv4qeeNaq6S
    Z8tRazJoTXq8WhCipVrzaq3/SG6i8/vZVfTsC+7nSyfQCAUMT21Jy3Lisr+ZTz3yJ0vgRe
    j6EPuIOAPCfymDEoQma9NB9MWLBmtzElv5vQReDhYNOwlZMEsVpfSKPcWfHwY+AYb/rB9C
    4Jk4HBmQ+MwS1S7giCEITwyfa9G3rxlL6wN7SnukOxcDpZaTLK5oTNFJR7XQ
X-ME-Proxy: <xmx:8pgIazNKrJNHS0p6Mf6uRMcr12CY3FS-B4cho0-C4lFT3Q_wNLcH5A>
    <xmx:8pgIa5a3n5oo2OIXtHK95KfgnVVl9IkUWl69lyIXD24v5ISDeDpUvg>
    <xmx:8pgIa1wCJS9icuhBs3XgdOM90O84qCyRZK62c_23Ca6bHrY2sovSJw>
    <xmx:8pgIa8KP3WJKu-tbYNKrDEY-JI1GPHl6ZceQcCQ3pk-xVZnYn6o_og>
    <xmx:8pgIa9NmJS1kkaS0JurYDqHnVRUHapDM_zkQW5xBXqeZNazGldgng3dI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 15:39:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 3/6] packfile: inline `open_packed_git_1()`
In-Reply-To: <87bj7bsmoh.fsf@dev.null.iotcl.com.invalid> (Toon Claes's message
	of "Thu, 26 Nov 2026 15:16:14 +0100")
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
	<20261120-pks-packfile-global-statistics-v1-3-19beb83b145f@pks.im>
	<87bj7bsmoh.fsf@dev.null.iotcl.com.invalid>
Date: Thu, 26 Nov 2026 12:39:12 -0800
Message-ID: <xmqqmrqviaz3.fsf@gitster.g>
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

Toon Claes <toon@iotcl.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> The function `open_packed_git()` is responsible for opening a packfile.
>> The majority of work is not performed by it though, but instead by its
>> `_1()` sibling. But this sibling really only exists because we thought
>> it too hard to handle errors properly and close the packfile's file
>
> Is this missing an "'s" after the "it"?

Both of these are grammatically correct.

    We thought it too hard to handle ...
    We thought it was too hard to handle ...

On the other hand, this is not entirely grammatical

    We thought it is too hard to handle ...

because the reporting verb (thought) is in the past tense, so the verb
in the subordinate clause (it is hard) is backshifted to the past tense.
This is true even if the difficulty is still true today.

Your suggestion to add "'s" after "it" makes

    We thought it's too hard to handle ...

which is a contracted form of "it is too hard" in the present tense.

>> @@ -492,9 +488,12 @@ static int open_packed_git_1(struct packed_git *p)
>>  	unsigned char *idx_hash;
>>  	ssize_t read_result;
>>  	const unsigned hashsz = p->repo->hash_algo->rawsz;
>> +	int ret;
>>  
>> -	if (packfile_open_index(p))
>> -		return error("packfile %s index unavailable", p->pack_name);
>> +	if (packfile_open_index(p)) {
>> +		ret = error("packfile %s index unavailable", p->pack_name);
>
> Not sure if it should be part of this series, but should we make the
> messages localizable?

The file is in a sad state.  There are a handful of _("localizable")
messages given to die or die_errno, but almost all others messages,
mostly given to error but some to die, are not.  It is clear that it is
outside the scope of this series to decide if we want to make them fully
localizable and do so if the decision is made, but as a measure to avoid
making it worse, it is dubious we want to make these new messages
localizable.

>> +	if (hdr.hdr_signature != htonl(PACK_SIGNATURE)) {
>> +		ret = error("file %s is not a GIT packfile", p->pack_name);
>
> I'm surprised "Git" is spelled out in caps here.

I am too.  Thanks for the sharp eyes.  As the name of a system we might
call ours 'G' 'i' 't' but not in all caps.  As a common data interchange
format to be used among compatible (re)implementations, "a Git packfile"
might be fairer phrasing than "a git packfile", but I dunno.
