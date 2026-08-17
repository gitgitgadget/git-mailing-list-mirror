Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B2456E1C
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985633; cv=none; b=sGdaAVAnD9BpXMcjPnlhSkXo76j6S0FWXUy1nf9SutpzdobDdzg8n4MnU7pf8NfK74mXKuYOHx04q9bsONgXGvOs1WfDiaXfcOiOx39qdKb9ldbQfjkB+BLSFdLB+wqKL4O2pVQ11T8CQyf8sGkBVywE9owQad2b8EtEbIzzbig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985633; c=relaxed/simple;
	bh=kxCBQUDE2N4GV8QxDjaTJCHyxJJmY0uElRR0tqFl6Cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R7OhTmQg31O61uZLaKCpk/zVbR2zt4X3j1pleM02jr3YGUyjvfo+MgSfmo1GadmNzEquybKwMjJiVA3b0JDj+hxksoliOBm+IBtHGStiR6p6tQAF/j8MPM5/9JAZdAOF1OtcGA57oPs38qE4d/1FHcPdXccG0qhJAq3xbq+GTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D/1F3dGT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LVxGcd6S; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D/1F3dGT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVxGcd6S"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 719F1EC020B;
	Mon, 17 Aug 2026 12:53:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 17 Aug 2026 12:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786985623; x=1787072023; bh=3oQoHWwI+c
	06BroZYWy+nxz4Bn5UGS6Rv99tmAM3ZpE=; b=D/1F3dGTpPHrbkYS2+0ytnCoyg
	oeHUsqUGb17gz2AP1qGCxI6TanRwGGTy6LiocC/BnJ3L7vV7g5JgAEXiK/JjMQQN
	Fa6khuJfMOCFu+x9pWAwddbtBHgOnUiXfsshMO27c9yxzyFxvQydhTOrckRkcSc7
	h2A6SJfzAO3CqvIyvHg5lplnxz1t8k7Dl/i211zHHA2oAUYe+rduEWKDBaEKbUO4
	BwKG2yjFu9WAuQSpziutEwMIV/B7RgyhZ9HfbcaJC3MbLAZMtqtLc48lxsQCqprq
	5DHu5NeVGkMOHA7F78TdESM5AbCYKPa6IOm2s+nWhWLK2RDb5NB2QddEz5wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786985623; x=1787072023; bh=3oQoHWwI+c06BroZYWy+nxz4Bn5UGS6Rv99
	tmAM3ZpE=; b=LVxGcd6SbNp0Y2vSDi15Tq+Jixa3NRkCSSxMox5tN5xrt8feHD6
	g/j79VGK/aBMQE7Ptd1riAi7lfCjfGTrjBkIj4KPLGZg13vnkuW8Zg+r5kZrA1IS
	YemPp/4bFvRp7+7A4zuWcdJMFngYgSLVmj2iHHwprULwJrW6QASRjThx8KH1CoqV
	JVMqLv0YMr2VpR3vNESoIn01xPdO2APfWY29a3xc7es2xa/n4u1o40+DACKu1f/u
	yMMlBSVaui49FteVzUWg4HWB38eNOUVVL19XJyXscU+C+i8oEP90nZo0/J1li00n
	NsGmPO4FpikOwSUF7/9mzjDepM+v+cYn6qQ==
X-ME-Sender: <xms:lzyDaqRiZ0-x09Ad3xPS48PtidK2-R7fOINHxUcnWJS3ob7xnJl_SA>
    <xme:lzyDasU-oFAArivMJyDkEi3fRTeLMCZ5LDwvPzkvYj7hys_ynCQ1yHq_icDqqpmvw
    mI4AR25MliOLK6jsrPCvlf4kuXzjOCy_d7pf5HSYRiSXUWLIgsrmt8>
X-ME-Received: <xmr:lzyDasTw4XOhVFne16WRK2FDYAPdYSTjOLftlRoUH86dwEZ--UWUaBzQ73zV37VcTY7S84b0VhRpAUHUAXQbfQFY1AADQWsmOQ>
X-ME-Proxy-Cause: dmFkZTFlZqwVTHNHJ80kEHg7D6umrnLgUEmIsRhQXFSs6iURupRcMj7njOpOYS8as+PO5L
    7QtFq4a8JDhEZTQFOpU8PiDXCGPEDDl7E/t+Af8mNiNVWGO3OWDDgJlBlnvcjAXs1t5blD
    sAd2NIFNdPTBNH4xZKcee4UyL6qWrSg6a1m7hU4XvYgKeftP6Chhq92YIICvmYwk+rThiU
    bSZa/KCKaRLE6K6R0i8EhIhLA6H3FhtKf0IQ59LeDlq7hdiGXELxYC5QhnZCC9/CiSp5cT
    rLbnJuc2FSX3DnBiRxmGIWPVbopLpz/0buyPHpdasw3WrZO2fNprlTM1rLqEWW+E+kUmKP
    3mVshLLVg81kHaHqTyDkoEd/xelVix8SXqWaLcS7Lu7krcBBRG0R2+4hSn8NuK3CSd1A80
    DK/cANud2TboFsLQoMmTbrbEReHkaR8F+ed9j03j6K0Svj2E3TkuW0EwQ/Nwc/AMnxvv/e
    vpiEyNtemtT5Nxqllmnl038Ea9QT9OQeIbVQQ6FELNooKnTLw2jjegbcLN2Jm5v/mFKfrc
    Fn4ZR4NvVQQKT7ESZVtXiDXqeIYUBn7TTV4P/Z9uMRMTrtfasDskHl0xuXRq3nwc+M4Bv8
    9IL1CF0l2Ji4RNQzHLhrksg1nUOo70z9lgS0+81kjPBw1SQO+nN92QIB2lKw
X-ME-Proxy: <xmx:lzyDas2cqHIumVdjJEiP8gGf4pHaWnG-kSxzcK03F8fwU-GPRqgmrA>
    <xmx:lzyDakfJxP2s4FapKrBCw7lnWTzadUf9zPBIiwoTKR9zaUnnrRWQ6w>
    <xmx:lzyDasP0FdLp9tC8uGiBkzp1YrU_sn27HB0nx_Vb8Ayh-rzCRQLoww>
    <xmx:lzyDagXSxH4fVcR5LCWvgNWUoHTi9lVC3Eq29AdwQPJSBKGtLkmj4A>
    <xmx:lzyDamig0A6n5d2pd5H21oO1XDJ19J9SlJTOMMW70brhpvuSpD6qoC49>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 12:53:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Matt
 Hunter <m@lfurio.us>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v13 7/8] history: create squashed commits without editing
In-Reply-To: <xmqqbjb07osr.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	17 Aug 2026 08:24:36 -0700")
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
	<8b3551d0d4ecb360775ea29507ee262c7bf9cd42.1786088371.git.gitgitgadget@gmail.com>
	<xmqq4igyszeb.fsf@gitster.g>
	<f34669ad-9157-4f13-a3c1-c0abbc660497@gmail.com>
	<xmqqbjb07osr.fsf@gitster.g>
Date: Mon, 17 Aug 2026 09:53:41 -0700
Message-ID: <xmqqecfw663u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> It's piped into "tr" to check that
>>
>> 	target = lookup_commit_reference_by_name(s);
>> 	if (target && istarts_with(oid_to_hex(&target->object.oid), s))
>>
>> uses istarts_with() so that we accept uppercase object ids.
>
> You should check in with brian about istarts_with() that is used
> here, as I suspect he missed it in his effort to declare uppercase
> hexadecimal literals invalid.

Ah no, no, no.  This is a new code introduced by this series.

And as I said, I do not see why we want to be case insensitive with
this comparison.
