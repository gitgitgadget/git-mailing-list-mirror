Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5325BE6C
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733708136; cv=none; b=E0vvSI0iSbGUQUE63DNyOT56utawPvDg9y4BkMBOJCa+/Dr9xi/kKdRXPPWs8xLMRRxLnQrlqtgewiuoYC/bt81q0eDUMUkn5WpHg53iVoK8M+5QWtbA/LAPJt/0ScZLVHBTCUBF+IK74DxotG0+NwivdOhjg/rTzUYuRDo62rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733708136; c=relaxed/simple;
	bh=SDNs5mdOIddCTx5UkLFZN1aLlRG7SqtgtmcYlKvb8+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S6/JnUOJbb4PHf1KkCUtAet8H2ZfyCrmztjjxdFVRqB7EKKvf62/ir43zXwvlXXy0N+LgcMKzR4w4GnZYY0pHYYd4+2KHUn2x838rtmhGGJSBRsXYkpMbXPrP1A2f11Lq9s5Q4TR3wL+TFTeSIeYgpXgOqeRBWwgPDFlr1TBzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dfmmessW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dfmmessW"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF1FC1140127;
	Sun,  8 Dec 2024 20:35:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 08 Dec 2024 20:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733708132; x=
	1733794532; bh=MhWm34YDgpfJ86qNjQD0L6YMKwGfcvDag28QRcCgwtU=; b=d
	fmmessW6xkkxXx5q+0rPb1RqL2apNxtW0wRsu2Z4g/PWQcIzWrVwCftsLpzNafMt
	gHgXUUGFmPqDtbMBDlF9xekgWLlpEpV34vNCOG1SJAQoQSPxSsePJwXBgwjnF6aA
	KPUIio6EmWHcO8JyLAdPwwgMIEvZolTY74vDODe4eVrpimRKA3S/UWg9x2THe2Nv
	u3eGdgVXXQP9N0w6s9D2sp/p84KoVrAd3+5ITZiyC2RZrwp7lS68S8ucN2fN38a/
	Vnr9iZyuX4ixEonqoRGJo9+U7JGwAiq4dFZLs2wdLngETHmeEaB1YisP7PioFzjk
	vIaiZ7VaFo7hrtBTCTtgA==
X-ME-Sender: <xms:ZElWZy5ovgRVXd_JCawR0ltVxBjgK_Zn4i17c74vD_Br0-Cbv5f1Zw>
    <xme:ZElWZ77LCU0bRdOOECzAvH1bLkGIXMopkwz6lzifLx2N5IB0b6dv1pKIaqCtEFPbl
    O5ssjugUudiVO5VrA>
X-ME-Received: <xmr:ZElWZxfMwCgT5lYWiqKiomdVJS9EThrLU7946XL_HlneNmysu5wl6bK0C1mKjwtu6ogpX3lysouvr-wzE7JRWhJ2lD9EwPcSvh69dqE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggdefjecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:ZElWZ_L7iu27-GPyDOM43UyGMQUNf10F1jjT8s6W08SCxWAL83mUeg>
    <xmx:ZElWZ2J25F2uH-GJVWpC4HPUiCb6OEBs1wPFY_dEfTqb595vxnBBCA>
    <xmx:ZElWZwwQ4dtXltMi3zA9hkH1H7_xqnkHMf_dvwkXwxpZIw_y7IYqJg>
    <xmx:ZElWZ6Iu7HisO4ERiuvMoOBkGx4F72uJjmNC4-gKX17ctZd3l8vzLA>
    <xmx:ZElWZ7EvxPdz7fiddys0nbDzyOCWGkBwJPJ5pAEQeD-rLirvKBMMEQfy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 20:35:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] strvec: `strvec_splice()` to a statically
 initialized vector
In-Reply-To: <xmqqy10pprnp.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	09 Dec 2024 10:32:42 +0900")
References: <37d0abbf-c703-481d-9f26-b237aac54c05@gmail.com>
	<5bea9f20-eb0d-409d-8f37-f20697d6ce14@gmail.com>
	<xmqqwmgf3nf3.fsf@gitster.g>
	<c949fea0-817b-45f9-b8b2-55e1cb55e915@gmail.com>
	<4e60eedc-e4d9-423c-b2e7-f1c65bccc254@gmail.com>
	<xmqqser33ga6.fsf@gitster.g> <xmqqy10pprnp.fsf@gitster.g>
Date: Mon, 09 Dec 2024 10:35:31 +0900
Message-ID: <xmqqttbdprj0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Rubén Justo <rjusto@gmail.com> writes:
>>
>>>> ...
>>>> Sorry.  I'll re-roll later today.
>>
>> No need to say "sorry".  Thanks for quickly reacting and starting to
>> work on it.
>
> Any progress?
>
> Thanks.

Sorry, you did send and I did queue v3.

