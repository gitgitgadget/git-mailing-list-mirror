Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8C2207A
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 04:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732510161; cv=none; b=ZWLZrci+ZrgG10zIVnHrN9emB3RTM0efQy//tC3lkanvEG6cQQ7XHkjQKtI8WZB1r2G82jNLoRoPv16/qWdC0nFzQwu+eJvk+5k1p1fnViB95Sfr6tJDa7UHiy1yEX6e1dAp+v2m7psTUM+kkdn/GWrz5Nvxsnan8h/aCOsDxTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732510161; c=relaxed/simple;
	bh=5jtEYMbxuvzKjYfq1h5SXBrIdZUYGRIfPeUOdh/eQ/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XecADi2qNIKRLXKhWF+pmggIHUVpDfV2sq/iVyJwAV8tekKc8YDZUqQaYBoOrz8aZjxg7GxZtyOGjXo8wqNdfOmhkusavgfh6NsHTz0TopiSB8ZZyaJzHDoyWQG7QMkanQjL2LBBEY1+3m6z/iuLb41hTZXHyGt2L1m0LC31r50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPboDnHD; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hPboDnHD"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7EB151140166;
	Sun, 24 Nov 2024 23:49:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 24 Nov 2024 23:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732510158; x=
	1732596558; bh=sH5eRq6Q2CwfVsS8eFRSmMSlT1U6ZWo0ARUuStdO25A=; b=h
	PboDnHDlat0r41FdbKBXYJF5Ym/z6M4hVpYHmXUHI2dVB1uFBIwDNQqz7L8zv2jP
	rgoT17EulZUlXnovfyB7a6QRpV/5J4WeOBT3DxewXs1TtF9Ac1L4v6kZEtrnBsqR
	AFv8Jy5t8NfnTaZnMiAZ2yZJIKV5zoKgjp1gAOl5kKhdXsobjpKo/t3BZnBMEHxJ
	NyE8/vNClqcP5S0uSIOogXZ8shtV15G4JIbDTbZXLlIg0xIGmzkCwyn0OH8gOvsv
	QJuhJLyjMUPjfc9Y+bfoi4pG3YdVrgEgzSeHavEAZGu7bj72yeFUudgatbKenlsE
	DmjNWVIXe7JYwcaBfbXSg==
X-ME-Sender: <xms:zgFEZ9Csb8VhZ1E7cM3-BdTUsCghw4u1lY1pZQR_Q9BAO2f9Y4AHWw>
    <xme:zgFEZ7iQhV1vrNfEcIi6F-ckFX5ohfpdB4LTBF8fxW22jIRXAmCHuIsVHxuVjxn6m
    O6fbV7UUccBLrnMnA>
X-ME-Received: <xmr:zgFEZ4lG5MILxU21r_m7m3VzTwNZsEFYc0pGwlBYE-OOGlmVWc6KctZkg0A58sOeykI4f1iST3iBHM6VFOHIZq1jqwzI4zV07pw77zI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zgFEZ3yKwCuexslKw112yhGFoe3UHeYIGFU3uvgwxF7uMdEjMbfPaA>
    <xmx:zgFEZyQj-gvQ43ytGekuVC1gqFzfOWirV00M_RNN_zcWTMo-vxC24g>
    <xmx:zgFEZ6bqKfPdydRCHMffrKmhIDbxBQW8a810eJw4E-nxCA1qPC5Ygg>
    <xmx:zgFEZzSeT-kP-8Agw7bqOIV4JuFk_gRphifAo7NW5v9bSLN_OdBHqA>
    <xmx:zgFEZwe_ykr2H7DCATZIqAhz5944_WbHuGSPVHVxcg6nxhmFjasqvNjB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 23:49:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] doc: option value may be separate for valid reasons
In-Reply-To: <CAPig+cTCiyc-8GnEEKZvDTAvmrXNrfJ-Uq4=7TCv21UgoiKAZw@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 24 Nov 2024 22:35:59 -0500")
References: <xmqqjzct9db8.fsf@gitster.g> <xmqqh67w6m4m.fsf@gitster.g>
	<CAPig+cTCiyc-8GnEEKZvDTAvmrXNrfJ-Uq4=7TCv21UgoiKAZw@mail.gmail.com>
Date: Mon, 25 Nov 2024 13:49:16 +0900
Message-ID: <xmqq7c8r7wab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Nov 24, 2024 at 10:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Even though `git help cli` recommends users to prefer using
>> "--option=value" over "--option value", there can be reasons why
>> giving them separately is a good idea.  One reason is that shells do
>> not perform tilde expansion for `--option=~/path/name` but they
>> expand `--options ~/path/name` just fine.
>>
>> This is not a problem for many options whose option parsing is
>> properly written using OPT_FILENAME(), because the value given to
>> OPT_FILENAME() is tilde-expanded internally by us, but some commands
>> take a pathname as a mere string, which needs this trick to have the
>> shell help us.
>>
>> I think the reason we originally decided to recommend the stuck form
>> was because an option that takes an optional value requires you to
>> use it in the stuck form, and it is one less thing for users to
>> worry about if they get into the habit to always use the stuck form.
>> But we should be discouraging ourselves from adding an option with
>> an optional value in the first place, and we might want to weaken
>> the current recommendation.
>>
>> In any case, let's describe this one case where it is necessary to
>> use the separate form, with an example.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> v2 looks good to me.

Thanks.
