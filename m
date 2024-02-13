Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F3F5FB9D
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844152; cv=none; b=JjYga7wBQFkjiarVTyEouvzcAGnXY9D8y24k0cGMO9OnIefMd9AfvFvBQDz+i5XCWtMTGN852b4mcWIOTlcN118UF7WiZPovgreyim62LYwZaR8ARVUKqsUiiaYa+Epp/Elxy3/oBg2kP/zEGvU8W5yR7DWlfx3OvUc+l4tfRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844152; c=relaxed/simple;
	bh=2amIka1dXhX6dqGIhaDy1creILGNbLUmHsyIZz4TivE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XpStN2AKlptO8FhD5q/ofJeJdSHyxCjv1UJEzDhi4eGI/Pg4qzcLZrw8/T8Je53DZx+iZkAA6gGpQjPDD+o6BZ9MZAEuaHmIhH3xnx6Ae5UzrrZiWQkBcVJ75Td2auMtURa/gxDLQfqUvDwiOFwsJAHZ/VNoUrtvY1QoiQ+GMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZI0eq6PD; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZI0eq6PD"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 089CD34CBE;
	Tue, 13 Feb 2024 12:09:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2amIka1dXhX6dqGIhaDy1creILGNbLUmHsyIZz
	4TivE=; b=ZI0eq6PDZFXMb2kMXksy379diLjZsuJkXg9mw535eR6LMtSbgjbcGf
	38Ksazl1LjnJzpdy1EPsygGvnLllFXQcNYoT3q55tSx6NbIjAigvnzlqZxAK0Thk
	l4TuBp6YtepS6EH8js/GQOPlZAD6x3it3DUUhvzToQcEbe56GQmxw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0126E34CBD;
	Tue, 13 Feb 2024 12:09:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2E0334CB9;
	Tue, 13 Feb 2024 12:09:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 0/4] completion: remove hardcoded config variable names
In-Reply-To: <Zcs34kGTqTbIana6@tanuki> (Patrick Steinhardt's message of "Tue,
	13 Feb 2024 10:35:30 +0100")
References: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
	<pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>
	<Zcs34kGTqTbIana6@tanuki>
Date: Tue, 13 Feb 2024 09:09:04 -0800
Message-ID: <xmqq8r3o8f67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 97DB416C-CA92-11EE-875D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Feb 10, 2024 at 06:32:19PM +0000, Philippe Blain via GitGitGadget wrote:
>> Changes since v2:
>> 
>>  * Moved the addition of the tests to 2/4, and tweaked 3/4 and 4/4 so they
>>    simply adjust the test names
>>  * Added a test for user-defined submodule names, as suggested by Patrick
>>  * Added more details in the commit message of 3/4 around the use of global
>>    variables as caches
>>  * Slightly improved commit message wording and fixed typos
>>  * Added 'local' where suggested
>>  * Dropped 4/5 which modified 'git help', since it's not needed (thanks
>>    Patrick!)
>> 
>> Changes since v1:
>> 
>>  * Corrected my email in PATCH 2/5 (sorry for the noise)
>> 
>> v1: This series removes hardcoded config variable names in the
>> __git_complete_config_variable_name function, partly by adding a new mode to
>> 'git help'. It also adds completion for 'submodule.*' config variables,
>> which were previously missing.
>> 
>> I think it makes sense to do that in the same series since it's closely
>> related, and splitting it would result in textual conflicts between both
>> series if one does not build on top of the other, but I'm open to other
>> suggestions.
>> 
>> Thanks,
>> 
>> Philippe.
>
> I ain't got anything else to add to this patch series. Thanks!

Thanks, both.  Let's mark it for 'next' so that it can be one of the
topics to graduate first after the current cycle.
