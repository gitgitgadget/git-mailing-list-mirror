Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0EF10E3
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889799; cv=pass; b=nuRCousw0YG31Umt64uWN+sXWJiuzyrCirWzTRYFGd6K6zRoizI6m71/mgcFWRRz6j0USJbXUu2WTM2GPGJ5/TtEHrEgt2KnqIr3mgigeXuCTcI+PSUMbJjeOMSbqXUbvFctNSZL9wHxkSOi9KrJpwWGBpi7lciVh/7+B77Mc7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889799; c=relaxed/simple;
	bh=xh7baeOJRR/KmbC+inKAogDG5G9E4tsEnAey1gLaSVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=irZKGp0Ur5cnHmyBQ+e+11WryTIpSQidRT50e3M30wzLyBcK7kghM3wrV1oB1pfw3hrpx9UnrS2VC8dXq9F7YwMEpWgeozupj1BrkGSibmbCG3TKr9kbHcbdCbZN4wJic4syOBQFS3KoWaSgEjjVt7bDs3QiVt9mdOW+K5LbOcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=lZ/NAl8S; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="lZ/NAl8S"
ARC-Seal: i=1; a=rsa-sha256; t=1758889784; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wt7UtUcfNBHBs0Kgy67LX7lRSdDsSffcjHqiU6IU1LeoPUtlUW0LtFYqOYG/I3X+LU3DfTssg+IX5P4Em0lihoefJsNDKhhehz6o0lQ6TDxGpAno6XZ6WYFRrS6l0tsjDGr7e61hEpFSJf3edUVYMi8ldFT45uw8LrG4RtSOBQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758889784; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1A2Ju+UACUg/VJdgXV9/fZgELEJtyOf3BTAowWGtLfA=; 
	b=HWtsfeoMaGn/DEtCEjr0TI/IFifAPbfNtWzeA0pZ0SDNkIcT92KMtV0Mr0+SLI4++N7/DHDU1x/CP+KmxwEpAuDrJSIO5k2kdzluAvfPoEQdDHJvEalmAy5gS6KFsYAtB0hAZZjHx4eaumfYhWP4m9xgptUhu3VRGlZKwnI7+3Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758889784;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=1A2Ju+UACUg/VJdgXV9/fZgELEJtyOf3BTAowWGtLfA=;
	b=lZ/NAl8S6ERsptTu7jdu7z4QhmlbX241XvmsVXjs4E7kyDwXaUZMI1bPRKHYdBc8
	Pjxlod2UP3GVZsSHVnkgpvxxhG+SU9WTxN4h+3E/bM1YZtoAo375NRazkBOPh0ObpA2
	FdSeq90wU90kRCrWQQCuRyIbSD3gJ8LYEx/WuuOA=
Received: by mx.zohomail.com with SMTPS id 1758889781855590.5999301556622;
	Fri, 26 Sep 2025 05:29:41 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Patrick Steinhardt <ps@pks.im>,
 Josh Steadmon <steadmon@google.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 03/10] hook: convert 'post-rewrite' hook in sequencer.c
 to hook.h
In-Reply-To: <xmqq8qi2ffv6.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-4-adrian.ratiu@collabora.com>
 <xmqq8qi2ffv6.fsf@gitster.g>
Date: Fri, 26 Sep 2025 15:29:37 +0300
Message-ID: <87bjmxo0r2.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Thu, 25 Sep 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> From: Emily Shaffer <emilyshaffer@google.com> 
>> 
>> By using 'hook.h' for 'post-rewrite', we simplify hook 
>> invocations by 
> 
> This "By using 'hook.h" is somewhat a strange thing to say. 
> <hook.h> has been in use by the file (evidenced by the fact that 
> there is no new "#include <hook.h>" in the patch).  I haven't 
> carefully read other steps in this series, but from my quick 
> skimming of them, I got an impression that this comment may 
> apply equally to other steps as well. 
> 
> What the commit does is not "use hook.h"; it is to replace a 
> custom run-command call with a call to run_hooks_opt().  The 
> shared API service function may happen to be declared in 
> <hook.h>, that that is secondary piece of information. 
> 
>> not needing to put together our own 'struct child_process'. 
> 
> Imperative?  I think just dropping "we" would be sufficient. 
> 
>> The signal handling that's being removed by this commit now 
>> takes place in run-command.h:run_processes_parallel(), so it is 
>> OK to remove them here. 
> 
> Phrase it more positively, instead of "it is OK" (which sounds 
> like it is also OK to leave it there).  Perhaps say something 
> like: 
> 
>     Another benefit we gain from using run_hook_opt() instead of 
>     a custom start_command()/finish_command() invocations is 
>     that the hook API handles with sigpipe itself, so we no 
>     longer need to toggle signals ourselves. 
> 
> or something like that, perhaps. 

Ack, will reword in v2. I actually inherited this message and thought
about rewording it as well :). Some others I already reworded in v1.
