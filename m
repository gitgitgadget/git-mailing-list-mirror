Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223ECA6B
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771003297; cv=pass; b=MwMUtQUamSg5wqgghek58E8wloOV/OtYDZmO4Hw3jKWIXNsoMLbSzRA/S2lK/L+hmp/NqyCsPb3alwXu7ygxGBlWOtN0Dvqpm9EYjVnXRvc1EFWYi8KAYJFgBpkrfVk3JoH2RQz/fzlvPn7HeaLQKb/iQrowKFbp0AudzHc6o8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771003297; c=relaxed/simple;
	bh=jJEMIFHrPv3QiF97LbQJYOcNMxBr+AZXb1S/vD8rdk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TyVAs1ex3/seBa0Dpg9OO90INCStidnRJSh5umWY9gJ6+NtT7ftUaXm2ONXGTnjjRhBgvB46Hd5A+dKRiGNx8kWq+lxcCWM6BXJ+1xSUJOK7n8reOC3NtUi1nBqgI9XHO0Es/oNHFVEIFctZnHrSbz9VpgENEp4FJgvlSBgp4AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=X5qZt8nn; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="X5qZt8nn"
ARC-Seal: i=1; a=rsa-sha256; t=1771003270; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ad4rTQ7eJusgSl/iqoE4c0IdSE2LltWDioLSCj7eluYzTg3N2kSGqaU7k+BZPk24jLVkzKsD/xx6gW8IEAKqxouMmkFTSae/rB+mKFCP9HRD4FuQ5B6Vdh8JHZMlb56cjimnpgIZn4JOytjUQd6FLJ2kzwREYyHLm0ECEeqXBhc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771003270; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wdwzIUppmkI6fvkMj/e5dQnV/DJv+/QaL9hpQF3ej0Q=; 
	b=Mjkukbs16H2bJP0dQaiLeiAF6qjW3AUd5h0NRu6P23kXf9Bun/GWsAzfSXm2Azn8l5dyQFhrA66uE5KjFRVo6IsCJGWAdRCB93H3qhTx4Sx7R7ZNP5+p04PRZKq1GcfbT6geIBkwbQtgj3eEIhhleK+c3hs/YhpaULnmebqaoGA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771003270;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=wdwzIUppmkI6fvkMj/e5dQnV/DJv+/QaL9hpQF3ej0Q=;
	b=X5qZt8nnzFHPIHwv153JmYWgAxqxxVqR1/XFx3cc9hd1n5JmkZrl2Yzq4WSckwko
	0iE/HwoASGZpmDhqp55c2rvMuamS5vYysMN3GfPU9RMg9T9+FeuPiQQtbSsxmhbiqhv
	RWSOD8mJJDcyGj81V9H04uyBBHPL+WAXjJd8qsSs=
Received: by mx.zohomail.com with SMTPS id 1771003267817142.8258244992021;
	Fri, 13 Feb 2026 09:21:07 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 0/4] Run hooks in parallel
In-Reply-To: <1dd09e04-dbdb-4a6c-933a-e4dc451878f9@gmail.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <eedde9c3-2aff-433b-9dc3-f8593d53dec0@gmail.com>
 <87jywiox9f.fsf@collabora.com>
 <1dd09e04-dbdb-4a6c-933a-e4dc451878f9@gmail.com>
Date: Fri, 13 Feb 2026 19:21:02 +0200
Message-ID: <87h5rkpnk1.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 13 Feb 2026, Phillip Wood <phillip.wood123@gmail.com> wrote:
<snip>
>>>> The pre-push hook is special because it is the only known hook to break
>>>> backward compatibility when running in parallel, due to run-command
>>>> collating its outputs via a pipe, so I added an extension for it.
>>>> Users can opt-in to this extension with a runtime config.
>>>
>>> In the past we had a regression report [1] when the pre-commit hook
>>> stopped having access to the terminal. I've not been following the hook
>>> changes, is this series (or any of your preparatory series) in danger of
>>> reintroducing that regression?
>> 
>> Thank you for raising this, it is a very valuable data point!
>> 
>> The preparatory series 100% will not reintroduce it.
>> 
>> This series might reintroduce it, depending how we set the defaults.
>> 
>> By that I mean:
>>      -j1 will keep all hooks connected to the tty, just like before.
>>      -jN with N>1 will disconnect the hooks from the tty and their
>>          outputs will get buffered through run-command's pipes.
>> 
>> The design I followed (which to be transparent is Peff's design, I just
>> implemented his ideas :), is the keep the original, serialized behavior
>> exactly how it was before, to not introduce any regressions and to also
>> keep identical "real-time" performance.
>> 
>> Taking this into account, together with Patrick's feedback on this
>> series, I do intend keep the jobs == 1 default for all hooks in v2.
>
> I think that would be safer. If we could opt-in to parallel execution on 
> a per-hook basis would that be a solution for the "pre-push" hook? Users 
> who want to keep the current behavior would avoid configuring parallel 
> execution for that hook.

Yes, opting in on a per-hook basis is one of the mechanisms I'll be
adding in v2 (that's what I've been discussing with Patrick via the
other thread on this series).

However we also need a mechanism to enable more than just 1 hook at a
time, for users who want to enable by default a known-good set of hooks
to run in parallel.

That's what we did with `RUN_HOOKS_OPT_INIT_PARALLEL` at compile-time in
v1, however that's a dead end and I won't pursue it.

For v2 I'm thinking of a runtime/global config which can specify a list
of hook to default for parallel execution. That should be enough to
replace RUN_HOOKS_OPT_INIT_PARALLEL.

Suggestions welcome, as always. :)
