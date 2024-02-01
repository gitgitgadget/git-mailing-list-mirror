Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F495A4FA
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806860; cv=none; b=EJzN0F73IsaUN270+ehNG1p/cufFj5GLv36Brnq+mWb5mmAMsKDm0fq391m3agctpR/BB4NfUqljIIkdOwx+wadoEHFUURKm3BVYGaUAlJen3aWd5oADpt1GETkNXPbW3gOQLwDEdgOGXuX+I0OUU8BdcbCbCR5Le5QI8Z6iEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806860; c=relaxed/simple;
	bh=MXfRQ40DOKLq432opmAxhrGQJrtXO2LU2U978Biz7Us=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=o4mPZyOjNLShWUx5t7BWea+aW5u+a50HHAOUoV4DIUb97J70DZZHLXZ0nTh4ZNT//tUVGKFLZQ3fAVeo0aB36SWLb0y1wrqKWefJW9IhgUkZfk8seUS8ih4rj1GIFuWr3r9gw0aBvqBXlzwRHzcS8BiVuak8kScDrKC0Dtk/Ag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=A0UjIKSh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="A0UjIKSh"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706806854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqFrG05yXuR4dZyAkE1sJRN7WqfiEKsJjF65dS8qNPg=;
	b=A0UjIKShA5czYM1PSd1npKwlIOZ1PsfbHBsTJoyizuCb2zTOecJ6pCV/VTCfGLRY46Xi+b
	iOkxmo0+EQzAQdSRISidXkfddvUMDk0bd1tU1kQMWl6kw4dQs0xA3OJAe21eqEuUQ1ywOV
	mijSKd++6ro9/gGHE4NoiqaKqgS7I0+1gkxDYWiprTFn/Cn603hTh2nRfscAK5Bs6/Jw8q
	dI0a4RaVG5YE5JiH5e4PlxBAKG8bxuvu2KQIBU/LNapGQxhQgswnps8TCni8QvV29fHqaB
	pfkHlQBUwug7h86nBuWu683OMr3r4m7aVckffTspivuT+rKabza/eGXZi0NZtA==
Date: Thu, 01 Feb 2024 18:00:54 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Hans Meiser <brille1@hotmail.com>, git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <7e395301c5ff46a69d8aca71eb0bb766@manjaro.org>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <7e395301c5ff46a69d8aca71eb0bb766@manjaro.org>
Message-ID: <5d796ab27f4575ded4807e08618c9249@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-01 17:54, Dragan Simic wrote:
> Hello Konstantin,
> 
> On 2024-02-01 16:39, Konstantin Ryabitsev wrote:
>> On Thu, Feb 01, 2024 at 12:10:11PM +0000, Hans Meiser wrote:
>>> is there any current discussion about moving Git development away 
>>> from using
>>> a mailing list to some modern form of collaboration?
>>> 
>>> I'd like to be able to follow a structured discussion in issues and 
>>> to
>>> contribute to the Git documentation, but the mailing list currently 
>>> just
>>> bloats my personal inbox with loads of uninteresting e-mails in an
>>> unstructured waterfall of messy discussion that I am not able to 
>>> follow
>>> professionally.
>> 
>> Here's a perspective from the world of Linux kernel, where this 
>> discussion is
>> continuously raging. Funny enough, the main objection a lot of kernel
>> maintainers have to forges is that it makes it really hard to find 
>> relevant
>> discussions once the volume goes above a certain threshold. These 
>> folks have
>> become *extremely* efficient at querying and filtering the mailing 
>> list
>> traffic, to the point where all they ever see are just those 
>> discussions
>> relevant to their work. They love the fact that it all arrives into 
>> the same
>> place (their inbox) without having to go and click on various 
>> websites, each
>> with their own login information, UI, and preferred workflow.
>> 
>> The kernel maintainers are able to review tens of thousands of patches 
>> monthly
>> with only about a hundred or so top maintainers. To them, this system 
>> is
>> working great, especially now that some tools allow easy ways to 
>> query,
>> retrieve, verify, and apply patches (shameless plug for lore, lei, and 
>> b4
>> here).
>> 
>> The obvious problem, of course, is that these folks are FOSS's 
>> "marathon
>> runners" who got really good at their workflow, but the situation is 
>> different
>> for anyone else who is just starting out. Any new kernel maintainer 
>> stepping
>> up obviously finds this overwhelming, because they aren't yet so good 
>> at
>> filtering the huge volume of the mailing list traffic and to them it's 
>> just a
>> torrent of mostly irrelevant patches.
>> 
>>> Are you consideration for migrating?
>> 
>> Yes, of course, this is constantly under consideration. There isn't 
>> some sort
>> of anti-forge cabal that is preventing things from going forward, but 
>> there
>> are some serious hurdles and considerations to consider:
>> 
>> - How to avoid a vendor lock-in? Those of us who have been around for 
>> a while
>>   have seen forges bloom, and then shrink into irrelevance (e.g. 
>> bitkeeper)
>>   or slowly ensh*ttify to the point of unusability (sourceforge). 
>> GitHub is a
>>   proprietary service owned by a single company who are currently
>>   FOSS-friendly, but have certainly been extremely FOSS-hostile in the 
>> past.
>>   GitLab is open-core, and the current record for open-core projects 
>> isn't
>>   very encouraging (Puppet open-cored themselves into irrelevance, 
>> Terraform
>>   has gone full-proprietary, among most recent examples). Full-FOSS
>>   alternatives exist, but people aren't really that enthused about 
>> using
>>   less-popular solutions like Forgejo, because they hate unfamiliar 
>> UIs almost
>>   as much, or even more than they hate unfiltered mailing lists.
>> 
>> - How to avoid centralization and single points of failure? If Linux 
>> or Git
>>   move to a self-hosted forge, how do we ensure that an adversary 
>> can't stop
>>   all development on a project by knocking it offline for weeks? This 
>> has
>>   literally just happened to Sourcehut and Codeberg -- and as far as 
>> anyone
>>   can tell, the attacker was just bored and knocked them out just 
>> because they
>>   could. Yes, you can knock out vger, but this will only impact the 
>> mailing
>>   list -- people can still send around patches and hold discussions by
>>   temporarily moving to alternative hosts. With the distributed nature 
>> of the
>>   mailing list archives, this can even be largely transparent to 
>> anyone using
>>   lei-queries.
>> 
>> - How to avoid alienating these hundreds of key maintainers who are 
>> now
>>   extremely proficient at their query-based workflows? We're talking 
>> about an
>>   extremely finely-tuned engine that is performing remarkably well -- 
>> we don't
>>   want to disrupt development for months just to try things out with a 
>> forge
>>   and find that it isn't working out.
>> 
>> Finally, there's also the consideration of current trends. One upside 
>> of "AI"
>> (LLM, really) technologies is that they are extremely good at taking 
>> in a huge
>> source of data and finding relevant information based on natural 
>> language
>> queries. I can very easily see a mechanism spring up in the next year 
>> or less
>> where you can issue a query like "send me any threads about reftables 
>> or
>> promissory remotes if they contain follow-ups from Junio" and 
>> reasonaly expect
>> this to work and work great -- all while keeping things decentralized 
>> in
>> addition to distributed.
>> 
>> Above all, this isn't a "forges are terrible and shouldn't be used" 
>> response
>> -- they are clearly useful, especially when it comes to CI 
>> integrations. A
>> large part of my work is bridging forges with mailing lists and 
>> vice-versa,
>> which I hope I'll be able to do in the near future (GitGitGadget 
>> already does
>> it with GitHub, but my goal is to have a pluggable multi-forge 
>> solution). I
>> just wanted to highlight the aspects that aren't necessarily obvious 
>> or
>> visible from the outside.
> 
> Thank you very much for taking your time to write this down!
> Much appreciated.

s/your time/the time/

Sorry for the noise.
