Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBA848C
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732066980; cv=none; b=daYBdpPUNEf9gRDO2L6+k98BcJd8wVMxCyi25LA+BC1HI9mejeRkfV+puzKXHlch5ksm2MRrbZbHsirlkgIL/LEryIwE83KMCQnNYs5RZRe5UB8hsUm2B1MznLNT3hxGzOic2rOKd87dyEObvEi8E2xzJKxlqz0T6asMs4nxqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732066980; c=relaxed/simple;
	bh=yaFNsUf/DthtcHEe8tl1tttaHoIuBgaI/8pzD3p3wao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q2gxNYLpWK/6Dmw2bVBKRk7TZMZ7bBSpMzO05KoyCireVwTurcSE8dAhPKDYoZQqny758qsLMVmmlIR2d4DEvVTwlR9PtXMqwT+QBRHW0K1nNstJVEi49fhls5AvbP8zNhxHJmLB3Vd9wLMmScEiiBy1qiCBuLWKaSSSNRi3/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hy2HTOie; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hy2HTOie"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C9F8A254011D;
	Tue, 19 Nov 2024 20:19:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 19 Nov 2024 20:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732065555; x=
	1732151955; bh=GtDDLXX0Au6uywKGKs8oPr2f7xrOP0lAAFHagn/EC+E=; b=H
	y2HTOieT75nyX7XygMTEk4oFawswcioDquQiBoxQl7FR8mVmZGcnS46IRTCj8aVR
	WgGgJGeUm5Q1/8FJGenL3zX4gK+YnJEQhYIY7s6yZpuB3dWveZhaZSC4G3vl+PpO
	da7e9Qg4+iSs0egIIv+jMLAa/ie4jxYfoRV9z5OQHSApn5rNzPBBaM60M5hoARYC
	V3ytzOd3JqGRVhZrPSh1V5tZOP5kNODHsr4afUJceILVLL+bRab8WkftXPpF96r9
	9suHe+63WQG+VxQdCseB/2KdyCOduGAUYcHNTAuRYy3oPLW7szVi/Z9ee8w0ECX9
	Hd2N9C3YMgjySmY5BN56g==
X-ME-Sender: <xms:Ejk9ZwqhooTQti53fyq-1cJtancQx41jQwXRIVohTBHJrowkZJRrQg>
    <xme:Ejk9Z2qpG_94FzuEZJo4KuNR_4Dkyou0YbvRQQJ-FQ-9oYgcQ57fLyzi4PHPy9m2p
    NisMbAMdHuCsdwqiw>
X-ME-Received: <xmr:Ejk9Z1O2FIr2uuFsv8Yi3hF3iVSH2_vlhVlfQS3LP2CKTE7IJnHQVyMwTpboqrAsKyP6zZVz6D7R_VbUqreLG1Ya1yfoSWuUHJgD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvrhhitgdrphgvih
    hjihgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghlvh
    hinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghn
    mhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfh
    grmhhilhihrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Ejk9Z36fB7oYc2RPWQ_rCAVurAWJ0MQCBYWW82mBUbFXKhpxPtMB2w>
    <xmx:Ejk9Z_7g9ZZHTlGcWVbaG7lzM1wSIUjAcTQXZTWmT7z6V4WeDGqI9g>
    <xmx:Ejk9Z3ic412rMi7s_9bro5qfowEk0dBVU6CZ9etuDYENF1GuA2_CWw>
    <xmx:Ejk9Z54AuzmvNibhdEZ1loKdYqIfhAUsx_qweRF_6NfESFuxJfuUEw>
    <xmx:Ezk9Z8yurgPE_2X04-aays1-jM_S4Wu8IdXRpHw4PAP9SW2nQZz_1Snd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 20:19:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Peijian Ju <eric.peijian@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  calvinwan@google.com,  jonathantanmy@google.com,
  chriscool@tuxfamily.org,  karthik.188@gmail.com,  toon@iotcl.com,
  jltobler@gmail.com
Subject: Re: [PATCH v6 0/6] cat-file: add remote-object-info to batch-command
In-Reply-To: <CAN2LT1Dm17-mmoMQr457fb5ta-TxG6Fj3Ma-gPh4YRJV9rRDrw@mail.gmail.com>
	(Peijian Ju's message of "Tue, 19 Nov 2024 11:35:49 -0500")
References: <20240628190503.67389-1-eric.peijian@gmail.com>
	<20241108162441.50736-1-eric.peijian@gmail.com>
	<xmqq4j4egza6.fsf@gitster.g>
	<CAN2LT1Cmsw3RB1kbRBvoeLs8WaQeZWqrG96EQfMkMe_jdKaO4g@mail.gmail.com>
	<xmqqplmshybx.fsf@gitster.g> <ZzwwuU2MifISW5BJ@pks.im>
	<xmqqy11fd8i3.fsf@gitster.g>
	<CAN2LT1Dm17-mmoMQr457fb5ta-TxG6Fj3Ma-gPh4YRJV9rRDrw@mail.gmail.com>
Date: Wed, 20 Nov 2024 10:19:12 +0900
Message-ID: <xmqqr076aei7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Peijian Ju <eric.peijian@gmail.com> writes:

> On Tue, Nov 19, 2024 at 1:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > While having a quarantine directory would help with the case where you
>> > have differing end user behaviour depending on the protocol, it of
>> > course wouldn't help with the implied performance hit when using the
>> > fallback logic.
>> >
>> > So maybe not having the fallback is the best solution after all, and
>> > when users have a good use case for why they need it we could implement
>> > it in a future iteration.
>>
>> And I would strongly suspect that we won't have to implement any
>> fallback---hopefully folks upgrade their server side to be capable
>> of whatever capability is needed fast enough ;-).
>>
>> Thanks.
>
> Thank you, sir, and also Patrick and Christian, for helping clarify
> this for me. That makes sense. I will remove the "fetch and inspect"
> approach in the next series.

Thanks, everybody.  And thank you for working on this topic.

