Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9ED770FE
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208912; cv=pass; b=DTUlPWcCbbst3NpxgMZNHsi9dpXCODuwi8WdO9uHE/QyGmPcIVcdPxxooS8DoHM620ec6UZrhxVeMwXNPaVv1W+JB2SsbnYrwA9+twK5Z60yZph6UupNf1eREKs8k5D3uc/sG1vzDYhxe+jDaH1zoxihaHbLuRt3rlpmkE5kNNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208912; c=relaxed/simple;
	bh=5aoFpud2vwxGObVZcuGgqMf+UsEyghrw1Qr0BLftPzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fGBeDb5HZHqHSqDTgaUs78yE/yOUXkA6MzJIrJJNz4YW/hGrUn1OziGBbb5D5Ny4aS4U4z9/7bQwaEE2f12c+NWFJmIkOWhd1yVhIl81HMW4FhZtmy7J2KfGmHS6o3LH3thwMYj+Mg/iETcZELUvmrb37aXSr2hoccmdPIBwvXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=fjvrM7iP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="fjvrM7iP"
ARC-Seal: i=1; a=rsa-sha256; t=1765208895; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LXGAaUNO9GgBhZWnHfaJW6Z2zOcoXrJCdOJxhzzzJzICaeSP14KauKZv2/1bB47lAV0UUu+iYYf6iOnINeV30nl7vK8iJdr7/Hs1MKnu0rPzX/e00nJ5u6cQ7IdOC5ILo8LE+JAPvW0iTZV3iXvdgGF22TonRzY2mr8nlY3buaU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765208895; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=89aLRKw5vnK2udH0Nwlzg3H7InqpyLQLQ27gFC8mfq0=; 
	b=B7OJphAv4T+jS7QDOhL9HlbCJUWxUJjRCFnW9Gbz7KuWHiJc/e7DybdTcFoPRYk4eU+DY984vNxoXV4gW3fWE+ieR/ujeiVMdPYptuMfFVoMZavX3IuF1znh57e1wP7SYB+0ZXhtyr8l9PCcfrue6gNAk92V0VK92cXHJfHz6GI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765208895;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=89aLRKw5vnK2udH0Nwlzg3H7InqpyLQLQ27gFC8mfq0=;
	b=fjvrM7iP9WffMitHRjDlE7NLH8yGAeaxOu7VMDUX1xuzxKREMdVTjbsZyRNFANPL
	n2UgxHAYu+tQdr9EhAPBihXRS0ZAONOgqSTxd4M1QgJpCbtgSoBwO/PgJGL54NV6iv4
	iPc/c7fbovFLgyohznvCTtgGPwLFda3+gmaxaYMM=
Received: by mx.zohomail.com with SMTPS id 1765208892193641.37187600524;
	Mon, 8 Dec 2025 07:48:12 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Emily Shaffer
 <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron Schrab
 <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Josh Steadmon
 <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH v5 4/7] submodule: add extension to encode gitdir paths
In-Reply-To: <aTa6lr9AOPIZlw5M@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-5-adrian.ratiu@collabora.com>
 <aTLNwHpLUcy-WsZs@pks.im> <87v7ikeng2.fsf@collabora.com>
 <xmqqqzt87dgj.fsf@gitster.g> <aTQanNSlj6VxDY-n@pks.im>
 <xmqq8qffpnui.fsf@gitster.g> <87tsy1uz2q.fsf@collabora.com>
 <aTa6lr9AOPIZlw5M@pks.im>
Date: Mon, 08 Dec 2025 17:48:07 +0200
Message-ID: <87ikehug94.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 08 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Dec 08, 2025 at 11:01:33AM +0200, Adrian Ratiu wrote:
>> On Sun, 07 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
>> > Patrick Steinhardt <ps@pks.im> writes:
>> >
>> >> Maybe the right approach would be to tell users to never manually enable
>> >> the extension and instead to provide a command that both:
>> >>
>> >>   - Persists the submodule gitdirs for any populated submodules in the
>> >>     gitconfig.
>> >>
>> >>   - Enables the repsitory extension.
>> >>
>> >> If we had that then we could count on the submodule gitdirs to exist in
>> >> the gitconfig, and if they don't we would die with an error message that
>> >> indicates that the repository is broken, maybe even with a hint for the
>> >> user on how to fix it.
>> >
>> > I personally like the simplicity of this approach.
>> >
>> > I haven't however thought about operational complexity, if one has
>> > an existing user base that have been using a custom pathname munging
>> > code that needs to be migrated to the new scheme.
>> 
>> The good news is that for all the real-world use cases I'm aware of,
>> migration to the new scheme should just work.
>> 
>> The problem we're discussing here (automatic fallback vs requiring the
>> gitdir to always exist + using a migration tool) does add a bit of
>> operational complexity, however it might be manageable.
>> 
>> I have to see how this works in practice, especially with the users
>> setting the config (likely I'll add an error to block that path) and the
>> build-config to enable the extension by default (will likely run the
>> migration tool automatically on existing repositories if enabled via the
>> build-config).
>> 
>> I will attempt this approach in v6.
>
> One suggestion: it might be sensible to move auto-migration into a
> subsequent patch series. That way we can focus on the general approach
> of the new extension at first, and the potentially-bigger discussion
> around whether or not to auto-migrate users can then be had separately.

Hm, yes, I started implementing the feedback and the closer I get to v6,
the more it feels like we should split this series in two or even three
independent patches/series:

1. The base gitdir path extension and config infra, renamed as you
   suggested, to be independent of the actual encoding.
2. The encoding.
3. The migration.

Let's see where this takes us. :)
