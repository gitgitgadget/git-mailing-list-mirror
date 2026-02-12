Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F4F4F1
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770906302; cv=pass; b=IC3cpMasSV/ARAGI5YzEW8fP2Vq7HR11eRbLlqW1Fqbf0j6HHMXElfCcxJT968yHeaZHtdUvr/W74LbYwnW7F9w2ZcUWIUs3lXps+ccULrSZt8+EhV/9EJJC67Y/aPhPekQT0ddOJ/t8CGvowM5sl3lc0iqR68sHFdKqkSpVWfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770906302; c=relaxed/simple;
	bh=Mb9vCeHyLGaW0fJFR82K80OsWop1W6GpMqQaV2bzDj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G5jSusZBN+2VFzQFxhQtKLXG2IcUchl/deDO7Cm0A06Hgd0dMEVOgn7dFXNdKqZTaXAxjcWo89Zpck6nHcnnovpa6u5u7QpI7Zfu6bDaxTBqxN8hNog1dmTxc0qluTjakNVwSmqmxevbhwaJ7zTh0Xp6OzMMCTPsRmK+BC877AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=UYYotGQE; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="UYYotGQE"
ARC-Seal: i=1; a=rsa-sha256; t=1770906281; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k7MZ17U7WqZD3HG7F/Y2LL1KhPljFBFccVmNzqSgHBRtNQkSbyf3svGosIsjd+vjMadnZBktyFb0fDBmRrBuhsANSBDS+ODsumxX5Oqc5Y8gOsPlI86akitG4R8jhSQUVYk9WZIox6HlbaOC5RiUnUTAb9di3gkt6xb0K92Dnts=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770906281; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6MJjsQ7UvMcs0/S9yKRFtSUCPg13o0WYU8zcUxofLSA=; 
	b=NIi9MOVkqQfskOYIRv2sMabT3zNRpyA1PuF5ggE19MRMGpCuI53XohjsP97BML3Kr2i2oBZpX/SbSk2ns5Y5PwznowJ1FQfeVYnQgp/ufS7v7YWDvfRDuc9wMLAW+FPE1nlNZBw7USw3Qh2uxW0L4NEJ8fvw063PgiDMixBspiE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770906281;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=6MJjsQ7UvMcs0/S9yKRFtSUCPg13o0WYU8zcUxofLSA=;
	b=UYYotGQEp+5awrf0TuatB7HB2toMdj/RDOS2CmDxkF+oFMgArM3shUz6y9+zxt2X
	wxEzPqmHHLghmt0dgtLZ620k9MPHo4CSjA2WV1FvuK+QjggyEHenXP7bFAXU7iFoNZN
	MejPrPNMeApWNW8gpnMQ0U9tz9XSc2KV/l4lpJiQ=
Received: by mx.zohomail.com with SMTPS id 177090627307031.933490015510642;
	Thu, 12 Feb 2026 06:24:33 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 0/4] Run hooks in parallel
In-Reply-To: <eedde9c3-2aff-433b-9dc3-f8593d53dec0@gmail.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <eedde9c3-2aff-433b-9dc3-f8593d53dec0@gmail.com>
Date: Thu, 12 Feb 2026 16:24:28 +0200
Message-ID: <87jywiox9f.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Thu, 12 Feb 2026, Phillip Wood <phillip.wood123@gmail.com> wrote:
> Hi Adrian
>
> On 04/02/2026 17:33, Adrian Ratiu wrote:
>> Hello everyone,
>> 
>> This enables running hook commands in parallel and is based on the patch
>> series enabling config hooks [1], which added the ability to run a list
>> of hooks for each hook event.
>> 
>> For context, hooks used to run sequentially due to hardcoded .jobs == 1
>> in hook.c, leading to .processes == 1 in run-command.c. We're removing
>> that restriction for hooks known to be safe to parallelize.
>> 
>> The parallelism enabled here is to run multiple hook commands/scripts
>> in parallel for a single event, for example the pre-push event might
>> trigger linters / spell checkers / unit tests to run at the same time.
>> 
>> Another kind of parallelism is to split the hook input to multiple
>> child processes, running the same command in parallel on subsets of
>> the hook input. This series does not do that. It might be a future
>> addition on top of this, since it's kind of a lower-level parallelism.
>
> There's quite a lot of prior-art on parallelization from the various 
> hook managers - is there anything we can learn from them? For example I 
> know some of them serialize the pre-commit hook by default as it may 
> update the index but allow the user to configure a subset of scripts 
> that can be parallelized. They also allow for parallelization where 
> different scripts update different files (e.g. code formatters for 
> python and C can run in parallel). We don't need to implement all that 
> now but we should design our config so that we can support it in the future.

Yes, all the prior-art is very useful and it is possible to do
finer-grained (or lower-level? :-) ) parallelism further with the
new run-command parallelization design, APIs and config.

Obviously that will require more work and doing careful analysis on each
hook-by-hook case. I'm just adding the basic buliding blocks and
enabling the "highest-level" (most... independent?... level between
tasks) of parallelism here.

My approach to this big problem was to simplify and break it down into
smaller / easier-to-manage chunks. I'm still splitting up commits and
untangling logic to ensure each part is done properly (also easier to
review) and can work independently (no regresions etc) before building
on top of it.

Thank you, and everyone else, so much for all the help and patience.

>> The pre-push hook is special because it is the only known hook to break
>> backward compatibility when running in parallel, due to run-command
>> collating its outputs via a pipe, so I added an extension for it.
>> Users can opt-in to this extension with a runtime config.
>
> In the past we had a regression report [1] when the pre-commit hook 
> stopped having access to the terminal. I've not been following the hook 
> changes, is this series (or any of your preparatory series) in danger of 
> reintroducing that regression?

Thank you for raising this, it is a very valuable data point!

The preparatory series 100% will not reintroduce it.

This series might reintroduce it, depending how we set the defaults.

By that I mean:
    -j1 will keep all hooks connected to the tty, just like before.
    -jN with N>1 will disconnect the hooks from the tty and their
        outputs will get buffered through run-command's pipes.

The design I followed (which to be transparent is Peff's design, I just
implemented his ideas :), is the keep the original, serialized behavior
exactly how it was before, to not introduce any regressions and to also
keep identical "real-time" performance.

Taking this into account, together with Patrick's feedback on this
series, I do intend keep the jobs == 1 default for all hooks in v2.

>
> Thanks for working on this - both config based hooks and parallel 
> execution are really nice improvements.

Thank you for the kind words. :)
