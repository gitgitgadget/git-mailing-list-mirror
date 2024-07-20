Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86862913
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 23:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721517841; cv=none; b=gBpxukeQ7J3vy6GCCkwGIgBMOanuS2Mjqn+7j2HExG3DVKA8Ry8/HQxljw9kOYL0sh/vZ0H7kg+2vJGLu3j14ciDDkkoXgygQqu0XARnrsLd37zBMGIxL154K37HEAw4wpHreAtbC42La0NKMK5RXAiHo4wBkbwgWvwLty78Y8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721517841; c=relaxed/simple;
	bh=Y12Q8tWpeQpm+o+Dxv+XYlFUxJs3A7l2r4og4jGU7as=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Obe/4mFhBGfxyRVT+Um1kmdiFwGbE1auQt3E7dzuS8zP8Sv5W1Fa5dwQXp2dhTjeQO4nNHcczNMX4pEkyBh92upkqC5qXAV926pIaEwZpHyrbzTtweYpaRmYVT1icpV0tbsBLmUau0cwPgVcXTVvee3OQn4ehtglz997sxfbzis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RXQW3Ixn; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RXQW3Ixn"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A4E62BC3D;
	Sat, 20 Jul 2024 19:23:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Y12Q8tWpeQpm+o+Dxv+XYlFUxJs3A7l2r4og4j
	GU7as=; b=RXQW3Ixn/NbWAGAD+n2vwLrE0OOq+oO4pSa29zF8snEo732BoeH3Kl
	CCkKXOJQMg41W1CGk4vmtAR+g0yTQdfrSGJXbdgoyslXbLkK66cNrgc9Dq7U4H5l
	QZ95Fue+zBtcTmgKA3EMkMQkeTPCUHyu/FYByH2hOzhTbe6iw+Au4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 42D892BC3C;
	Sat, 20 Jul 2024 19:23:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AED522BC3B;
	Sat, 20 Jul 2024 19:23:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH] doc: git-clone fix discrepancy between asciidoc and
 asciidoctor
In-Reply-To: <xmqq8qxvhcy5.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	20 Jul 2024 16:16:02 -0700")
References: <pull.1765.git.1721496853517.gitgitgadget@gmail.com>
	<xmqq8qxvhcy5.fsf@gitster.g>
Date: Sat, 20 Jul 2024 16:23:53 -0700
Message-ID: <xmqq1q3nhcl2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 21A43D58-46EF-11EF-9FA3-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> The reondered result _might_ be easier to read than pre-2.45 version
> of documentation, but I somehow find the updated SYNOPSIS section
> almost impossible to work with in the source form.  And the need for
> these otherwise no-op {empty} makes it even less pleasant to work
> with.
>
> I wonder if there is a magic incantation that says "everything
> should be typeset in monospace in this block, unless ..." so that we
> can lose all these `back quotes`?  And then the part that follows
> "unless ..." would say how we mark up the <placeholder> part which
> is the only thing exempt from "everything is in monospace" default.
>
> Thanks for a quick response.
>
>>  Documentation/git-clone.txt | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)

Ah, another and *more* important thing.

The original series that added the new mark-up to "clone" and "init"
updated them as examples to illustrate the rules added by c42ea604
(doc: rework CodingGuidelines with new formatting rules, 2024-03-29)
to Documentation/CodingGuidelines.  I _dislike_ the idea that we
have to sprinkle otherwise no-op {empty} all over the place, if we
were to update the SYNOPSIS part of all other commands consistently,
but if that is what it takes, we _should_ document that they need to
do so (and no, we should not assume that those who document the
commands _know_ why asciidoctor wants to eat the [string] there and
we should not expect them to insert {empty} without being told).

Thanks.



>>
>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>> index 5de18de2ab8..8e925db7e9c 100644
>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -13,9 +13,9 @@ SYNOPSIS
>>  	  [`-l`] [`-s`] [`--no-hardlinks`] [`-q`] [`-n`] [`--bare`] [`--mirror`]
>>  	  [`-o` _<name>_] [`-b` _<name>_] [`-u` _<upload-pack>_] [`--reference` _<repository>_]
>>  	  [`--dissociate`] [`--separate-git-dir` _<git-dir>_]
>> -	  [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-tags`]
>> -	  [++--recurse-submodules++[++=++__<pathspec>__]] [`--`[`no-`]`shallow-submodules`]
>> -	  [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] [`--`[`no-`]`reject-shallow`]
>> +	  [`--depth` _<depth>_] [`--`[`no-`]{empty}`single-branch`] [`--no-tags`]
>> +	  [++--recurse-submodules++[++=++__<pathspec>__]] [++--++[++no-++]{empty}++shallow-submodules++]
>> +	  [`--`[`no-`]{empty}`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] [`--`[`no-`]{empty}`reject-shallow`]
>>  	  [++--filter=++__<filter-spec>__] [`--also-filter-submodules`]] [`--`] _<repository>_
>>  	  [_<directory>_]
>>  
>>
>> base-commit: a7dae3bdc8b516d36f630b12bb01e853a667e0d9
