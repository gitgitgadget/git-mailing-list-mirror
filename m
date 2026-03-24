Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9B3BBA0A
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378592; cv=pass; b=MbYOvU1j3HcV65ywaZuV3p0uPsT+QKUqAggINCu07hdKA4A+h708IE9GD7tJe86MQ0cvjanBr5arNTvWcUZQzPN2Maelwg6saiWMrDwulgxZ/JVQTUJceTD0dNvwbagNN/0aKG+IJCKb00AyCwUJmeAr52g3sdSoPtoC8ZgsEI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378592; c=relaxed/simple;
	bh=vax320EpWP4SFTyMee5exzKcSOitKdbuEqo7LqVHvLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RoU8MKKackoco/hnIU/HOepgG8AXaopcslLYg6k/TVp9UOTywy0Y2C1QEECg5JMnk8ZfAeiPNIZ/rOFEsItuyVHTTcAoeDer51u5lViZSBaaHm5fIxc66sWnkwRyHZ5FmcjjnlL7Gbx6LA+57uZPSthwP1PmSbXH8cO7YKjELeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ViudxUc2; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ViudxUc2"
ARC-Seal: i=1; a=rsa-sha256; t=1774378578; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dBXtVGP0Mp6hrhRm8jl8222PrIw9rn3e31LvYoOzpiKoGQc7pvXLAQKkrIvt6HknI4hD1YFgWUEU0XNeK//8J/a+02dfiCvMmLDGxC/nBXdx3DoLY0jEAg+cmr5eN48MpCT5W4j+LmuU4DbGH+6prRN9ESpd7J1fSgSbfIYw570=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774378578; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2MfJ3KqYwqixM5ji6x3qNt47vhkllkQgB3oE/fSkykM=; 
	b=BfWCDCYGXMwhU4+lITHuKC8aiUdlgqRj7HEgCHinmsMLUpCnOybgpPVTALTM+MRHmk9ELWFXT4qkT4Sp62X/8pUqkUjKgQcOTKNesA9Jk2of7oM4R6oYN0tabmvhE8KWfOYljM22VeT14e4xHrUg8Yu17Kg3xwedhl/imzB2Ezg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774378578;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=2MfJ3KqYwqixM5ji6x3qNt47vhkllkQgB3oE/fSkykM=;
	b=ViudxUc2eh5wW4i6WDEAVO6zyKSwidBJsELl01Kv6Nq367I0HPWU5dLibPzn83Z/
	6e40n9jQJ4fCGvMMJi4JGNeDr6zxKkwAiDQFr2KpX9EiG9TPFVP65+0Xe5wwCUObQqo
	3wP69FjjslWaE/SoG76ywOLQgyPggh84MY161BlA=
Received: by mx.zohomail.com with SMTPS id 1774378576384805.0633696043084;
	Tue, 24 Mar 2026 11:56:16 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, "brian m .
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/10] config-hook cleanups and two small 'git hook
 list' features
In-Reply-To: <acJNblQ8WRGIri0V@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
 <xmqqmrzy5xwe.fsf@gitster.g> <acJNblQ8WRGIri0V@pks.im>
Date: Tue, 24 Mar 2026 20:56:11 +0200
Message-ID: <87mrzxcb04.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Tue, 24 Mar 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Mar 23, 2026 at 09:11:13AM -0700, Junio C Hamano wrote:
>> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>> 
>> > Hello everyone,
>> >
>> > v2 addresses all the feedback received in v1, many thanks to everyone
>> > who contributed.
>> >
>> > This series is just minor cleanups / refactorings + two minor feature additions
>> > to `git hook list`, which resulted from the previous series review discussions:
>> >
>> > 1. The ability to show the config scope (--show-scope).
>> > 2. The ability to show which hooks are disabled.
>> >
>> > This is now based on the master branch.
>> >
>> > I have pushed the branch to Github [1] and provided a clean CI run [2] with
>> > the exception of a known breakage for some MacOS builders (REG_ENHANCED).
>> >
>> > Thanks again,
>> > Adrian
>> >
>> > 1: https://github.com/10ne1/git/tree/dev/aratiu/config-cleanups-v2
>> > 2: https://github.com/10ne1/git/actions/runs/23340298770
>> >
>> > Changes in v2:
>> > * Cleanly rebased on master, no conflicts (Adrian)
>> > * Fix first patch build break by updating call-sites in same commit (Szeder)
>> > * Drop UNUSED from function declaration in the header file (Eric)
>> > * Drop the new struct hook_config_cache because it's redundant (Junio)
>> > * git hook list now prints in tab separated output format similar
>> >   to git config --show-scope to improve machine parseability (Junio, Patrick)
>> > * Fix small style issues, comments, type, commit messages. (Eric, Patrick)
>> 
>> These came just before the weekend for many people, so let's hold to
>> see if we hear further comments for a few days and then merge it
>> down to 'next'.
>
> Sorry, I've been a bit behind on the mailing list recently. I've got a
> few further comments that might warrant a v3, but I think we're overall
> close.

No worries, I appreciate all your reviewes and feedback!

I'll give it 1-2 more days in case other people have more feedback then
send a v3 which addresses everything you pointed out.
