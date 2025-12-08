Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC482E6CDF
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184523; cv=pass; b=Nvs12XZBhm/zsX0omokhgE99ybwxSPH8x8IciOPldVzNvV2r3p7AfJrpdatXF8HH2HvVizzlfgeOkjqnnVQV6fKGF3IEyX5PaX7DlUNuHRvQ4L1iGjVIniiRSCtAYsvjrSMfFZjuUntulUo03iJz6R+mf0Omz/Y/QWiMopE29dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184523; c=relaxed/simple;
	bh=Y+CUp8tBd2p8s7WsUvl2gbbArP95k8zXQ38FFD9z03s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P2PuUkdGOj8FOfLfo6lZDCYdHgMrcUYEt2Ac6EmySPOXXNslWpdEsRe77ysingqpGKcqRYOnuE+7FCF6trYk87hYtVM7P0n19qaUkcG4ASIDujvB0KxtfskVM9tPYL7iriiYhqgiUBSWQyv4UEqSuBJxV7iD/BKxv2gpHL+G93w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=K2pzM2ex; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="K2pzM2ex"
ARC-Seal: i=1; a=rsa-sha256; t=1765184503; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eXhVqWjQBB3oc9rXvbiZ1tjSTZ/aHjityZauEiI76L/skYz2gp0QN7vI2ZYZA1/6WIF2BGNl4Q8lu4LXftgbvlOcCuR7XVunssQrRsUMWIqCJsfm7pj8m5/RwUwezM4XLq6u2QIHhDSqtROUMb/AQu4eUDizBIj8fPm9T8Lfw3U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765184503; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mDHBQBZK9q7nhOzxyZnxpaMNtYg7CB6+npIKBuM2HzU=; 
	b=fbQyveD5UdgfMOW0lAgUT024tbflqyNZtcoswRvZ9fXK7qbmlGkizQjH43FhXCjrfpX0Q+pO63Wp8nyaURb2PYodQnPsyc6+OV9TrCauWkLBEMKlRUR1zANHKuYkEYz0wipXplRxL1sb1MuXVvJsphJdN3DCC7dHdFCAb4FHCdM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765184503;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=mDHBQBZK9q7nhOzxyZnxpaMNtYg7CB6+npIKBuM2HzU=;
	b=K2pzM2excy+LfXTTfMICdBXwbKMbJXsUtSa+zW9iOaZQLZmerznQHu7cU975JzrQ
	LLvC8bIGJRHE2gmVQSBJsn5XYHl5ysrqI6d821VO4kFquhgz/lUUGEqsgu4V9OmZwxV
	FKa12fUFikgLiaOXIsM4WgrjiD8xOAptuGQ0ku2c=
Received: by mx.zohomail.com with SMTPS id 1765184499968553.6750072403931;
	Mon, 8 Dec 2025 01:01:39 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily
 Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron Schrab
 <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Josh Steadmon
 <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH v5 4/7] submodule: add extension to encode gitdir paths
In-Reply-To: <xmqq8qffpnui.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-5-adrian.ratiu@collabora.com>
 <aTLNwHpLUcy-WsZs@pks.im> <87v7ikeng2.fsf@collabora.com>
 <xmqqqzt87dgj.fsf@gitster.g> <aTQanNSlj6VxDY-n@pks.im>
 <xmqq8qffpnui.fsf@gitster.g>
Date: Mon, 08 Dec 2025 11:01:33 +0200
Message-ID: <87tsy1uz2q.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Sun, 07 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
>> Maybe the right approach would be to tell users to never manually enable
>> the extension and instead to provide a command that both:
>>
>>   - Persists the submodule gitdirs for any populated submodules in the
>>     gitconfig.
>>
>>   - Enables the repsitory extension.
>>
>> If we had that then we could count on the submodule gitdirs to exist in
>> the gitconfig, and if they don't we would die with an error message that
>> indicates that the repository is broken, maybe even with a hint for the
>> user on how to fix it.
>
> I personally like the simplicity of this approach.
>
> I haven't however thought about operational complexity, if one has
> an existing user base that have been using a custom pathname munging
> code that needs to be migrated to the new scheme.

The good news is that for all the real-world use cases I'm aware of,
migration to the new scheme should just work.

The problem we're discussing here (automatic fallback vs requiring the
gitdir to always exist + using a migration tool) does add a bit of
operational complexity, however it might be manageable.

I have to see how this works in practice, especially with the users
setting the config (likely I'll add an error to block that path) and the
build-config to enable the extension by default (will likely run the
migration tool automatically on existing repositories if enabled via the
build-config).

I will attempt this approach in v6.
