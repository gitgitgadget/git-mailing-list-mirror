Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118691;
	b=2lhze6fDTTTL32w+j7eyVTKPc3TnazMp0dLfaV4H0zfbkcL9mYIlGWHNwJtnZ9Lkpd/B
	 ksuk1WYdN5w59Nncf+PV3vKG54KdPMjlU/Qqf8gm5zLLknYP6772AjFNTci0qZNRS/yAn
	 vCssoX7pjg3c/+a6WSEsilYQ9sg2ObiO/exc0SFqmyDgx5mlk2HpDNfMDiiCftr/ufubc
	 UqbJ7dOQOzpziTqfm0FKIpWk9sD22S1DNsvI+4TFRIM872fSrQqDJ8PqNgy5YFTUr6+UD
	 iE4FbrAviCAZgfrvkQBNh8AwB58GsQD6SYIbKR1x+H1kwRGkeNOtncx9pMyijAWeCqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118691;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=eRnAB0AhAi93sn7k27hdT6NGfryS3vyc5K6fxU+ul4s=;
	b=NASsOPlRLWGIAo+9Ns1GTSWLS8uzG0xX3lZQ1TYNwSjP0415aJPhMarx5ycjwXnIPOry
	 lc48o2CoeqgbBAuZbhLmMqqKZCcrA172+RMZzs9ojj2a6t7/JVWp+deZrSCx7/1e+kSaj
	 yjkxqOIa7Q1vEXEhGIGLa4ot26dZ9ylNee0YSF2iBL3W6FrcAA3Lwi8ACONEr0QtqvScy
	 yFyU/aPvdjrkU296wk8f8NZdOL0+XYloQabgcV6VyGwF1Y+LZghLyy6+m9rSMWUdkMgcy
	 z45EX1xY6A3Ud40ztjaRJbSCLDNddIqTQSJExK48zHBJVggYPBF7R4yjpyLqe0v/AGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nBBTVOoT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LZBbr3wB;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53862606A339
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 20:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53862606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=nBBTVOoT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LZBbr3wB
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B9DA61D000C6
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:04:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 15:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795118690; x=1795205090; bh=eRnAB0AhAi
	93sn7k27hdT6NGfryS3vyc5K6fxU+ul4s=; b=nBBTVOoTJ+lN877oq5Yj2YDhyb
	Xq2Uzd59qNA79xTnTZ3O8J/XH4ivYQSGO5YAFRkbBeLIB6/o2l+NImtTXdQUqDfd
	PW+y19yao/rReRZcEMssm7PqhlPj5sG6EHA7pVhN+lyxeMN9fA28vaS3JihTYzlQ
	l7dK0nLvAV7KnJrPjEH0lcdj6/k9ucMiEqBdeq9SJ0o2AEcAp5KKDnDql9P6T1Bl
	eu/iWeF3fmXoqWC2oAL1m6z1ZutASE6gD+Takei2pQWNYdiIA5jNsR5PoDuZiT+b
	eorepXjHTQPMaMf7G7E6aC5qjFxSg46OCtPjbupn/UWLKPNh3uPT6Q6KxF8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795118690; x=1795205090; bh=eRnAB0AhAi93sn7k27hdT6NGfryS3vyc5K6
	fxU+ul4s=; b=LZBbr3wBX9lvqj13yZOwISuHRMZmrRCvSZKfrdKJeisnPprM0PT
	tOEOHqJPI8OyUVPlrigBE3fEmkrownN+30ueI7tvmbqs1UBMgD0ZHnIHEtfcQn+1
	/iD0aP9b1BWZDxtcTBI2JXrfaMuo7GMKKHLHOggHQU6poIRxJrdgLRtyvUZ7hP1/
	4J5wCrrYGugPC98cKPt3VvrQikNN48tfUwB9W9d/rfYs1lbM26KgyVKb2bwWz6OG
	9mvRT1Hl7Y8+sKEH9obOvNPl37AooVb1aPRFVUFa0uNRQiMvJ63ZtAAyHNDjnt+o
	tG/mBazD64Nk+3FCOOVfPo0BsTENQyKIcvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795118690; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lDGq3PG0rXIJh4hMWQP2ArbDNVnewYkrkpsDpA02Wzqm3VT
	/KltLAn+4+qpmghO18dqJL34pVje+NwgsgYkoDYppsyMjVVrOH895Ecno031vDac
	uuDMm67WJ5PmIP0V1QKritSUhDJTFwvx9JIhOSbptQjvBHFcT7S1wGp5YVSh3RK1
	9A9MMrFU6Ra2FaguZXFT2A7yPDIrFLKBEQRBbT1tlWLV2hdIXNBYBYDIQN506kSA
	blx0O2VhQx3YoZyoV5dDctyMoclZViCgQQD4bj45KMm8DeYLKd/Kbd85mB9x1ErN
	3UAsSRknjoGpWhV6L9vnfbhHyByZjrQ5/V9j+VQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rMaOaZ3FBy67+GSdr15iMLNRKgXxD6HD+Opoywqx7xE=:xPk2BS8rUTyVcloOfx6lGA9zc6F4RJfo2u4YiuTRo+U=;
X-ME-Sender: <xms:Ylb_as4vxGUjSOGkHh_ZVIhFCDW2CBVWggfEdtgeoPrwJK4-6_0rrA>
    <xme:Ylb_akxVkGg-EFzWbjZMJp7wX_6RQssTXXRCdLS1cjy1jTEuWMyq4yhxK1eedKemz
    P7F5rGtnZIk0hmBTGMc0prHgXnrlR5SmN7iV-J6iLFU-KlCBGddta4>
X-ME-Received: <xmr:Ylb_ajwsOV_HIf-ICVkNPTS5ryHsZXmbDZK5mJJxdZFr7ojodyaSzHos5C4mukPhcseocpUQ3SqYDq5O7AkftpGVmukTroKmXJLd>
X-ME-Proxy-Cause: dmFkZTEWjKa5SZbAeV+Nkhb3xZEAaiz66tfWhkibfJYx4UxzZmPVFUjew0fPcKOIrmSlSj
    VBaCsVXahILXzfOVGayj1pSsvzbNwEN2JiabKB8oq61mtfUB/znJn17WcpJo+Wlz6kY5yA
    KxffumRQDar1/XwxEl/pvEzan5huTcQOxRAYOctbd0IWjOuai1zSuAEiBxNQcs/aVub/9W
    8nCwARAVJQvC5rmsYsIdZh/PfHw6oSyaLqS7NMzp2reXYN7ci9cipAMvVG/RNS3x/WJz3p
    BK5hV9NYEVwIu4PTkP3Fv1sbJ2ALKk9YOta/ezlPF+LGIu0uTyhRMeySx/3FeIrIXmYOq1
    VsaCng99RTZQy5MWjbiUsXN/yTXc5uFog4sz+q4q+mwrlaCz8b7JgSZK2fXQWpgCu06CG4
    i80az08vpzixKa415P0oXy9POvyfKx2SeHN/jR5JR3p/zoZdtWdyQUn2f/IB/eY6djBm5m
    msZ2hRtglp4hBFdPzfVX6tuZ28bVziQUB3BmBQtVx8gG4v6VqQq+c9Lv4+gIz7qoOcfVCW
    u6QpujbJsNQ5Rb+yPvp6Kq0b61PnT44a3ouRGNqibFGcmkfE95TcXA3fTGKDXpibb4eueS
    v1zrqVYTbWXP+rMPgJ098LGAR/d6oBsLqcp61Ddmf0byI1/4fUOa+5OygJCA
X-ME-Proxy: <xmx:Ylb_asznBj6mvFzUWmxHUSlNAXyllfsulu2cDz60RPGDA5pDUg3PPA>
    <xmx:Ylb_ata2V2pkgJbn1_rrUcrXtNBTMZtM4O1iljXYTNPd_RYp2La7tw>
    <xmx:Ylb_atV24Tq1UJLlJAeZ1Cpl4EbPztxHRUFAGyEDv55pJf9gL2aKrg>
    <xmx:Ylb_arg-WDvj9_lB8I_FZOXBqXdFcpp6e5M_ZTHRwCYnnX4IaiwXew>
    <xmx:Ylb_agCBnFBI87_GDDPpFrLDCxyTTsS1bc_vhJzHedwr-OmsM1_F7aLU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 15:04:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com
Subject: Re: [PATCH v2 0/6] object-file: eagerly create ODB transaction
 temporary directory
In-Reply-To: <av7oYYvxdMutzgyP@pks.im> (Patrick Steinhardt's message of "Thu,
	19 Nov 2026 13:15:29 +0100")
References: <20261110002251.2007617-1-jltobler@gmail.com>
	<20261119002043.2108654-1-jltobler@gmail.com>
	<av7oYYvxdMutzgyP@pks.im>
Date: Thu, 19 Nov 2026 12:04:48 -0800
Message-ID: <xmqqeccgwpsv.fsf@gitster.g>
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

> On Wed, Nov 18, 2026 at 06:20:37PM -0600, Justin Tobler wrote:
>> Range-diff against v1:
>
> All of the changes look sensible to me, so I'm happy with this version.
> Thanks!

Thanks for writing and reviewing.  Will queue.
