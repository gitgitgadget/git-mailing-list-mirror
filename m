Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714CC1E130F
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346440; cv=pass; b=WDGKDWJfRX1ljmQ/tmiiVtWav6azUNwa1+Whh94K7tGvrCzO45S2VNt3VF6+6on1vg7MEPeuruoZBuxNIpYcFwXk5BPVCzeIP0FKWeim4q6EFbzGTfdZZyDRZrFChR2AIVnzd9kAM995iqr8mNvpWHG5YzgWxVlPFaK5VthgWbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346440; c=relaxed/simple;
	bh=wvROhhXIBj8BZCS5Xt1QV+QWww2XCjLwMQ5C8vyx1cM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RjSk/urmGwsFzYRH4wTre3XV7qc6JjaHYKfTiZsyu5eVrR7q0u9B67PPE4rJoeDaQx7wBj7s/9Zp/YsDfR7Pdran3yBYfJ/izIup0IAntKSorIcT5S9H0SO1jsnFvljSwfJymQCSZ0n0cjiiNQGz/V420ksf0TJaNmJ8orNv8p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=YXep3j20; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="YXep3j20"
ARC-Seal: i=1; a=rsa-sha256; t=1757346414; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HnslVh0Z6EdPOpdZpILTnLWbgg34PEhz2UOH9rAnrNT3kqYbax+Ty25f803wDz8ssf1Lbh1/sw/H2PMUlU2SCEo777gWE3UlxNL8GG7FxYqnEzQKrFPYFlW1PHvO22Lz1w7PmpymnQUc8xvUrGoL/PTUR6Aqw9syne41m9Zl3Yk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757346414; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A/jsRDJ5EhrVuxiZf6bmojjBUKM5IYPVcZreDvy2UCI=; 
	b=Ic9b/ZV0LBS9G9pJnur4gR9PfgdTL4W+PSqv+NdfBFVv00hk6ITSAlQ3XFEGesqKchkeahc84j7zEEJgQyM4QQhSlTWaJ+TRHWodFLfW0+ULDMmqrk1+i6wLgesDeMMyCYnk1W8Lev+E0H7mOY0SHJP6ca/uVZqguECGhWm4LwU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757346414;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=A/jsRDJ5EhrVuxiZf6bmojjBUKM5IYPVcZreDvy2UCI=;
	b=YXep3j20HL/ff8xkO95PvyU/5Z+35CBFfKcomZRAacmUKRuosgn8dgr9Sk4nitvC
	hDHiE9ANufZw+HSBs1MaLfMUg4bY9ezEgM23rlwl50/3t9BGMLSJdsZ4tC3M68V1OjJ
	S9OQ3VkyHzdQ31j4nxOVZH1BvtLjyAWRZAH7jsZ8=
Received: by mx.zohomail.com with SMTPS id 1757346410747630.8874359585689;
	Mon, 8 Sep 2025 08:46:50 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano
 <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan Nieder
 <jrnieder@gmail.com>, Stefan Beller <sbeller@google.com>, Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/9] submodule: create new gitdirs under submodules path
In-Reply-To: <fc69ee66-815f-48ec-a5fb-99cac5f4d58c@gmail.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-3-adrian.ratiu@collabora.com>
 <fc69ee66-815f-48ec-a5fb-99cac5f4d58c@gmail.com>
Date: Mon, 08 Sep 2025 18:46:46 +0300
Message-ID: <877by9ndzt.fsf@ratioveremundo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Mon, 08 Sep 2025, Phillip Wood <phillip.wood123@gmail.com> 
wrote:
> Hi Adrian 
>

Hello Phillip and thanks for the feedback! :)

I just sent v2 at the same time if you want to give that a look, 
though the issues you raised are still valid for v2 as well.
 
> On 16/08/2025 22:36, Adrian Ratiu wrote: 
>> This is in preparation for encoding the submodule names to 
>> avoid conflicts like submodules named foo and foo/bar together 
>> with case-insensitive file- system handling and other corner 
>> cases like reserved filenames on Windows.   Backward 
>> compatibility is kept with plain-name modules already existing 
>> at paths like .git/modules/<name>, however a clear separation 
>> between legacy (plain) and new (encoded) namespaces is 
>> desirable, to avoid situations like an existing plain-name 
>> module containing the encoding escape character/  Thus we split 
>> the new-style (encoded) gitdir name paths to .git/submodules, 
>> while legacy-style paths remain under .git/modules.   This is 
>> just a default directory change with the accompanying test 
>> updates, in preparation for the actual encoding additions in 
>> future commits. 
> 
> Does this need an extentions.submoduleEncoding (name suggestions 
> welcome) config key to stop older versions of git trying to read 
> the  repository as they wont be able to locate the gitdir of any 
> submodules  added under .git/submodules? 
 
Very good point. I'm a bit unsure we actually need it, likely we 
do.

On the one hand, older versions of git can still initialize and 
work on submodules under the legacy .git/modules/ path ignoring 
the new one...

On the other hand, there is a non-zero risk users will get in 
trouble by switching git versions or can lead to 
inconsistent/corrupted states, so I'm inclined to say the answer 
is yes: better safe than sorry.

So if there are no objections or better ideas, I'll add this in v3.
