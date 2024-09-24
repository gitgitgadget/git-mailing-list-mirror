Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502412F5A5
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727210041; cv=none; b=hhsXJpQycxs/WdDS2XubFpfuu9i8sFfKq50h92FdTryiQTszZERdZwHlDgZsRuqyOhc/bt9Or0RcYfKfK7YM61Nhe/GHepnObqvDaP17tBn8Sn4gjaXI2VnwyEdaTFt9lN1eS21isQsb+Yn0jC2YC20BbNCYsAO2AbY233hRBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727210041; c=relaxed/simple;
	bh=6X9MM0gWfFip6PV4DuwNm7DAWFJfqtZEWXDoKA0FWwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WFsEkY0P4u7z7ILwGxkTkiZAB6650JMqqfujgi2fKGZT9DI66Csv0HMAs/m8Ltb5SPgYutlmXvL9ovwbFoMNXTLaouHhYGZv7icLY/JfXL2bmIyopXgJuFIwofU4exlu7Oa8X1N3/gSHbnG+XHFaOpqZ5ksKjgcVC8W+Qea80iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uVvUcvuK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uVvUcvuK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D5211D3E3;
	Tue, 24 Sep 2024 16:33:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6X9MM0gWfFip
	6PV4DuwNm7DAWFJfqtZEWXDoKA0FWwo=; b=uVvUcvuKk6sefGhCVSdq+l8qvjLV
	R4LkMkxp1CmN8hpPIGujB9Xuomi5sT+STw97VI640zIPctAfOOCL0IFQbM0vojUo
	Mf7ioStXJu5/Tvyzw4yMoFSVcVVcvfpaPLucuPI90TbDdH5miufIVY6LdY0OvXRQ
	vOPtM1g8EoI/Ng4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 035331D3E2;
	Tue, 24 Sep 2024 16:33:57 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5E6221D3E1;
	Tue, 24 Sep 2024 16:33:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Josh Steadmon <steadmon@google.com>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Chris Torek <chris.torek@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v5 0/3] doc: introducing synopsis para
In-Reply-To: <20240924193004.GA20138@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Tue, 24 Sep 2024 21:30:04 +0200")
References: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
	<pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>
	<xmqq5xqlug4l.fsf@gitster.g> <20240924193004.GA20138@tb-raspi4>
Date: Tue, 24 Sep 2024 13:33:54 -0700
Message-ID: <xmqqbk0cssel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 523B4EE0-7AB4-11EF-A9A4-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On Tue, Sep 24, 2024 at 10:16:10AM -0700, Junio C Hamano wrote:
>> "Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> write=
s:
>>
>> > Changes since V4:
>> >
>> >  * used BRE in sed filter
>> >  * rework the processing of three dots
>> ...
>> Josh (or whoever is taking over this week from him at Google), can
>> you see if the breakage you saw that stopped us merging the topic
>> before it causes us trouble on 'master' reproduces with this version
>> (either by running "make doc" on the topic branch by itself, or on
>> 'seen' that merges the topic) in your environment that had trouble
>> with the previous round?
>>
>> It would also be highly appreciated if other macOS users try "make
>> doc" and see the resulting git-init and git-clone documentation
>> pages are reasonable, both for the previous round that has been
>> cooking in 'next' and for this latest round.  Inputs from folks on
>> more mainstream platforms with modern asciidoc/asciidoctor toolchain
>> would also help.  The more people we have who look at how the new
>> way the synopsis section is written and how the resulting documents
>> get rendered, the more fairly we can assess the value of this topic.
>>
> Here a report from a MacOs user,
> asciidoc --version
> asciidoc 10.2.0
>
> installed via macports.
>
> No problems seen in the seen branch.
>
> I diffed git-init.html from seen of today against both master and next,
> some (minor) improvements (like GIT_OBJECT_DIRECTORY vs $GIT_OBJECT_DIR=
ECTORY)
> All in all it looks all sensible.
> (and yes, `sed` understands -E)

Since I haven't pushed out the 'seen' branch with latest iteration,
your sucess report is about the previous iteration that Josh said
"still breaks on MacOS" [*].  The plot thickens...

Thanks.


[Reference]

 * https://lore.kernel.org/git/4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyk=
y6yvrozy@mr5hnrsfj6sn/
