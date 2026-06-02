Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544CB364047
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417593; cv=none; b=SuGPbq2m9w2+uuXUZJiskXOQKvSaX8oWdM/GmMlTnNqfhfHN8ujmNsvYQ9ZNcDJ8FcMbas0ASYqE95IR4TP1TaV5PDsf1ooV4y+Dkg4IGDxSRe/Zct0Z0K3iVGbnSVqw4gkmNLRo9tQp7a7bvHkF2fNVx2mL42v89+4+CMhn6JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417593; c=relaxed/simple;
	bh=+SmLK4mm9cNsFdE7iRrLC4348Es5De44dSsNl+nRvco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlLxEkbp2m4W8jH1vSLtLiYuzU9fKVrhBOxTtykLRStzGKKwCT6fTkj+oB+Buhf8qKUm1NqNrXlRRFnZieabKQTHOWjfmY1CGUQUB5NcbcViMCMP6wyI3+egZjHf4CFt5AvRU8Wa6XFz0NYO3+KxvY694HwTeR3O9fTzzOXKngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=FqoD9FMm; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="FqoD9FMm"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id URtdw53BDe3PcURtewIc0V; Tue, 02 Jun 2026 17:23:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1780417398; bh=ioAMdrTGM/UkuXrrOeUXdirzPq2d9fHpS68sB45yOfA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FqoD9FMmhOg1cOjzTTI44JPZBjZTqq4jhMbdkP5/8fad978B1YQqKTDdU3oqZyakv
	 xKhAn4culMUKatLekJkmSuwKq1nrm7/GzTzKK4FRbQIMA3dpxF2XIuICimRJkrE8Gy
	 rWvJINwvqpc9Y2z+ubHt5SXwRCJZEcf3WUuHs61glGrNyzrAiz910RMEiqdrLM4Yh8
	 AbqZt6YdIgW0MpsWYVFbBfDy5a/iPHEGBl7+gpvIM4BYt8nAnnP+K/vbkLsL8ftjdv
	 g8WnYsVuxDRjYNFqmyQ+zWd44HdlT2qOniAw/aP6Vojd75L1s6PEHKezbRhFne86uh
	 883osJj3kqASQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FMy4xPos c=1 sm=1 tr=0 ts=6a1f0376
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EtsWfwBCrxUDNBtQhTUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <8dbdb553-9633-46bb-8a51-040d06d0d10e@ramsayjones.plus.com>
Date: Tue, 2 Jun 2026 17:23:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im> <xmqqldcxvziw.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqldcxvziw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOhpxaM3K7syXOe1lrFraXWCkiKXKmCGxSXEp5GVEjJF5ix0Zr6iEU7PvScMz5dBLz6OAgvqPeaLK130p/ole3NGFfzRLDtJvo1k3pdVcKSLae7w9tdr
 12dt2a4tt3Q+BRpN5FKT3TmjKiC9TwwtAYuJiVCSjaK30tZ9QAR2GJy2YlGszqX0LdB58VXkl9nlI+W1RxH3XlnE/TMZzDsxp0I=



On 02/06/2026 2:32 pm, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> We're about to extend our documentation to recommend b4 for sending
>> patch series ot the mailing list. Prepare for this by introducing a b4
>> configuration so that the tool knows to honor our preferences. For now,
>> this configuration does two things:
>>
>>   - It configures "send-same-thread = shallow", which tells b4 to always
>>     send subsequent versions of the same patch series as a reply to the
>>     cover letter of the first version.
>>
>>   - It configures "prep-cover-template", which tells b4 to use a custom
>>     template for the cover letter. The most important change compared to
>>     the default template is that our custom template also includes a
>>     range-diff.
>>
>> There's potentially more things that we may want to configure going
>> forward, like for example auto-configuration of folks to Cc on certain
>> patches. But these two tweaks feel like a good place to start.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  .b4-config         |  3 +++
>>  .b4-cover-template | 11 +++++++++++
>>  2 files changed, 14 insertions(+)
> 
> Shipping a sample like ".b4-config.sample" that users who opt-in can
> copy-and-edit into the final name ".b4-config" is OK, but I'd rather
> not to ship the configuration files that the users would want to edit
> (hence making the tree dirty).
> 

Hmm, for those of us not in the know, perhaps mention the b4 documentation
at 'b4.docs.kernel.org' (which includes how to install b4 ... ;) ).

ATB,
Ramsay Jones



