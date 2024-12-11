Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038294C85
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733875333; cv=none; b=l8YolZZd67MyC3hm/yQm4+cUIWdLSDFvv6D3H08oK6lb4BFJo3P8057oaV07uG/eIyhIJ0h7dCRL6rVmWoRfkEGIvis2VwZ04H5ajvWDJf+uXRgfOkTSFm+V0YEu4S4NkPr0l2ZyFbnB7uh8zpDXzcPl2h00jsb3p9bkS3GJIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733875333; c=relaxed/simple;
	bh=WyZOkPIKBaheqpNpgM3Nls3QRESWB3ao/FnMPnuv2LA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hELICkzxdmFEnB9fGEHHRqFswwxHqTeqQqNOxgvg/mVlkoXB41bwa3XfefpeyVpogsjHUNYSKX/getwOKEq5QMJh1aImty68GK9MCf5VU768vKd7dODy+kTn4w3/YZw/bKe8Nqz/eemCfLUiN6cKkZEEfOU5GLQ6Sj0Dx3oBVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PM1VlBKL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PM1VlBKL"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id EE1571383E5C;
	Tue, 10 Dec 2024 19:02:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 10 Dec 2024 19:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733875329; x=1733961729; bh=W1oh3oen2XCrWAjemiGvOc0MOcXLlnaebIW
	7UI+4y8M=; b=PM1VlBKLPqPAHIOL3qfT3IO/jWtqPVZJtgAYKqCiCpJnfFI8Yur
	Q7+5Op/GjERc8XTyRzykskNbaTHhxxH/kbpzqWmf3eZpZGN5LYVNmV4k2M+1/gCE
	et8OL3S3b1WvVikkpHcTXnEVGbn41/twn9SFeo+C2tXM4b9hCenB4WJY8oiuBBpJ
	g/te+1R95SN2DWllewEffTmXScGcaECpDHJXyQfw4/+DcP9JeTbKDLL8RJjMP/cy
	xearLo5/ucjpaRRL6rn0OCzYvy9H5ZIoFBXOcuqrzyZUmb0zTxmYQWutT1EvxTxe
	ZSq9veDZT6X+pBuYm188IYXxuk1l2/9+EjA==
X-ME-Sender: <xms:gdZYZ4WXaOdydjh_e71Gib6dIRMmpIiQ12Ci4SrOt39Rzy2irdN9Aw>
    <xme:gdZYZ8kdPMyo8vyhdjLokWRTHVy4mflndIJ32Kv8BvDU-_Ov9x_9obWN_HL5QHsNS
    NpSBdD3lFmJ9LgjJg>
X-ME-Received: <xmr:gdZYZ8acB7MkHr2vCl75Iyiem1kqTLoQKeqd2ale2pVfuwO6CYiqPikKuFQo6HrF3qbFt2MIEJ8Bq9-E5h2D_kArDePqWZ-ebx3TaM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohihvghluggrrhdtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:gdZYZ3UQg5CYutXmkpQY-iapliPe8TvQqPw2Mia3CpGC15waItMEig>
    <xmx:gdZYZynktiZUo_2rhTTcpsQnLJrrGIPsgyuUXd845FNivBpWgewaTg>
    <xmx:gdZYZ8eXjjGNGcDGtlNb0wo9jSAj-NV7HIrvb7j5OCH3p1hZwE2p8g>
    <xmx:gdZYZ0H7JCa0Ox9KSuyUdOIWcUOEKMmNfQyJDArAb6s77c_teTAo9A>
    <xmx:gdZYZwbobsZB8OzC6NzdVst-taaL8rHHp-RgDKnpNQt9iJ_8VCWmSYmi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 19:02:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Roy E <royeldar0@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/8] git-submodule.sh: improve parsing of options
In-Reply-To: <CAOfFamkEmJgUUj8C_TGbjgKs35vSBzNCDpLvK+utqnTtxd5iHQ@mail.gmail.com>
	(Roy E.'s message of "Tue, 10 Dec 2024 20:11:53 +0200")
References: <20241207135201.2536-1-royeldar0@gmail.com>
	<20241209165009.40653-1-royeldar0@gmail.com>
	<xmqq1pygo2ti.fsf@gitster.g>
	<CAOfFamkEmJgUUj8C_TGbjgKs35vSBzNCDpLvK+utqnTtxd5iHQ@mail.gmail.com>
Date: Wed, 11 Dec 2024 09:02:07 +0900
Message-ID: <xmqqikrrjdds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roy E <royeldar0@gmail.com> writes:

>> I am assuming (but I don't use "git submodule" very often, so my
>> assumption may be way off) that there is no such variable we need to
>> pass, but if not, we may need to reconsider and use the "variable has
>> only value of the option" for at least some of them.
>
> Indeed, there aren't such variables; all of the options which take
> arguments have exactly one argument.

Just to make sure we are on the same page,

    --foo "hello world"

is an example of an option "foo" that takes exactly one argument, a
string which happens to have a whitespace in it, and is an example
for which "variable has the dash-dash option, equals, and its value"
pattern would not work well.

If we pass an argument that is an end-user provided message or is a
project controlled pathname, we are likely to be in the same
situation.

If we can pass it as

    --foo="hello world"

then we are safe, as we can do

	foo="--foo=hello world"
	... later ...
	git cmd ${foo:+"$foo"}
