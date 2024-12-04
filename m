Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5422500D2
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307350; cv=none; b=XRzXvlp/HIqqhBpWRJtQUGuYL0007hhETiWqp74ziu+CUlhyhOPIvqmYoLBkX6WHDL3KNmOiPB1YWcVvP7tigzLqkLW6j5NhzwDpgiG2Z6B1vB/9x9Mxy+xGsP4I7fQdFJ4SO2A5x6viW9CeYj/iyHTdijTFYIo0JFGgv5CWnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307350; c=relaxed/simple;
	bh=V+ojMZyix1/F0+xTKbtHHKsxdOUE7vlhQ/M9ZPLEC4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fVKZF/AeFggIsHA8aQ/z4FeiN32ZynFnt+lfe46TMixefEJ8ZgiPqjL4R3NO2WzQH5RlAkm3dHMx8Upr66qrio5AG3uPg7VMitjkd6TdLikrqXqfmwSvTskd9comgRaqUZV9dPpiruhWCr0oJmY/sGYgeuUWpbOUS1ckcO45Y8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3YAIWYEJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3YAIWYEJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D00C138097E;
	Wed,  4 Dec 2024 05:15:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 04 Dec 2024 05:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733307347; x=
	1733393747; bh=ERl2hTk6pyKlFSDQl8j+Xz0JPHvtGASmPz7DI93c4M0=; b=3
	YAIWYEJF8j1S4L3C90iCO0y8dj2y93QqZXSsJgzkR8Pg10lT3LSsBFi2ojMNBcDD
	F2y251n+egM+yG7NBDGby+JtljGj/hECXU0hm4HzrWpPk0AXZBu4CXKzw5k720F4
	x8YOQ3SxKSDXKrPUD15cz/v7exZKU7tbXpkUYraOddfnMHVWuIO03DD4R0Juf3RN
	607ct+cPKMvXiFjNhZvFa0x1bTsVJkIHYNbJxI3roJORKGyH1dPOlPeZA4kcmQHC
	3ZVPd0eJlqayzJbFr/SAQ4mTG/InlEHatwvB44ZzltJO8q+TcjYXA021kCRtZqBH
	i2du71QDLvD7jhYcATkMQ==
X-ME-Sender: <xms:0itQZ8C0zP8kQS22ownOkDJB7rqUmaGgJ4ghuObRehQ5f9qT_MmU5w>
    <xme:0itQZ-iRgz2cESboA1XZRs0nW6P4xL3Z80mPUE7vZWQxjqmVV-aUiLqNh7NZPj3nq
    JstJmuxaOnOgljcxw>
X-ME-Received: <xmr:0itQZ_nnWw-wbuiDUXqr1ey9N7PT-AhUjlx8wfYbMEP-wUdCGaCd5iJA-R-TvwsmgsTkb4RG3uHnPmSu4C05SkoNjGaR4iziEek4nkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieehgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:0itQZyzn-igzrf9ih5U9bLPszdCUEiaffHV9clhHGdb8W60ktT7t-Q>
    <xmx:0itQZxS6WV-gnMt-Gzs90KAJ5As6zoHrBZz58HFp1LZ0VN1T1Fi49A>
    <xmx:0itQZ9bOuJl__ZKFlnbv_lEmSqevDaXB02TDNhJjShiMkuIptPvl9w>
    <xmx:0itQZ6TmaTE-U7y6IuIHhYhfPpmk20O2ezP1m7V5XNE6uP01w7ZFoQ>
    <xmx:0ytQZ_MljKscKSlPHhBfj_Bi9ywoc2gai_JYMLRUJYfCxRplPamPlTvx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Dec 2024 05:15:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically
 initialized vector
In-Reply-To: <4e60eedc-e4d9-423c-b2e7-f1c65bccc254@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 4 Dec 2024 09:50:18 +0100")
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
	<5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
	<xmqqwmgf3nf3.fsf@gitster.g>
	<c949fea0-817b-45f9-b8b2-55e1cb55e915@gmail.com>
	<4e60eedc-e4d9-423c-b2e7-f1c65bccc254@gmail.com>
Date: Wed, 04 Dec 2024 19:15:45 +0900
Message-ID: <xmqqser33ga6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Rubén Justo <rjusto@gmail.com> writes:

>> @@ -66,6 +66,7 @@ void strvec_splice(struct strvec *array, size_t idx, size_t len,
>>                         array->v = NULL;
>>                 ALLOC_GROW(array->v, array->nr + (replacement_len - len) + 1,
>>                            array->alloc);
>> +               array->v[array->nr + 1] = NULL;
>
> I mean:
>
> +               array->v[array->nr + (replacement_len - len) + 1] = NULL;
>
>
>>         }
>>         for (size_t i = 0; i < len; i++)
>>                 free((char *)array->v[idx + i]);
>> 
>> Sorry.  I'll re-roll later today.

No need to say "sorry".  Thanks for quickly reacting and starting to
work on it.

