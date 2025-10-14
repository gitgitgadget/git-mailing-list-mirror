Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB634BA37
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760463335; cv=pass; b=B0RdHfxyn7xMBzWBuTIcAcggXZM3C52e/V/64wA6kUX6We41AlMxIC2jrTVMScIrvplijdYM0W12/d4v5fzJbeKRNjk9iC9BR52bpqk+yVnklA6q4Z6QnzebaSE5BNJm1IhjuzSLvJSrcu/9gQGOufWjek3QG7hopHsN7jhQkAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760463335; c=relaxed/simple;
	bh=X1i06504YGtqyYoQ0dOs5aKZGZpc9cjAAc9tmBB7W4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WcabAO73yXTZIZkanv5w0IPO9jJ647Rdg1Fg2ZQ9VnJRESz4IpiC4znktvTk9i8SQDxxO3eQ1TFpzNCTgCH4yt459jBeTgikIo8WD7awlrbwhjVjTY4kljhSHbw4wL6BgmkLtJKCJUgs00knu8Xpfde63BNxTlDVqlJlDdaj2sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=i9IAwNlX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="i9IAwNlX"
ARC-Seal: i=1; a=rsa-sha256; t=1760463324; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I1lVwoNNm4O25FFuGRDz7hVXQdHK+iMgMivfBvAsjSHvMfaSRyDGqzC5dStLI+vhed7fWDaHRX1nM4D9J+HwK22VYRBh8rIV+KjSPhXYu8TYG9nabxGJd5BgJn9+u1yizuHk4NkOqlYsVrKRBdZZbBCxWYTkH25fBp1IaQqD8Dw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760463324; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fTIVcp08rF520DSPoqEnEyt6f0hd0c9/5AMvndUWnss=; 
	b=MviMr9D67hWjDk7S65pV2DdQb8qnA93y+KMtL71V1Y8zYpvknO3dlcNj2HRbnbIl7tRTuNTOO8sqfCBIk31rudrgHPnZhIRvoksivHbpL0HaHbgiUzPUOwiB1pK2ZlxeiDLEy/VSQp4i2cSRvFEaNXP+T4DR8kj48x9LMpmNUPs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760463323;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=fTIVcp08rF520DSPoqEnEyt6f0hd0c9/5AMvndUWnss=;
	b=i9IAwNlX8Rv0Rhtf7sTNPGWZ7YIkqXgtUIA7GDGiqh/9h+oEtH8VDjR+1aqyqNrp
	13NU860mzaK2s4XFAi2RSHY4jKLUEEAkWQ0kxP29gIgG6j4aco5GpEvWSWUJt12OssT
	N5RuK25WCB2RGLPtqI7uyH/ztzvcXJpE8QHBxUCk=
Received: by mx.zohomail.com with SMTPS id 176046331874239.24397659083297;
	Tue, 14 Oct 2025 10:35:18 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Josh Steadmon
 <steadmon@google.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 01/10] run-command: add stdin callback for parallelization
In-Reply-To: <87v7ks424z.fsf@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-2-adrian.ratiu@collabora.com>
 <aN4c6l7gRi4auss1@pks.im> <87v7ks424z.fsf@collabora.com>
Date: Tue, 14 Oct 2025 20:35:14 +0300
Message-ID: <87jz0xfktp.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

Hi again Patrick and Junio,

On Mon, 06 Oct 2025, Adrian Ratiu <adrian.ratiu@collabora.com> 
wrote:
> Hi Patrick and thanks for review! I'll fix in v2 all the issues 
> you pointed out. 
> 
> On Thu, 02 Oct 2025, Patrick Steinhardt <ps@pks.im> wrote: 
>>> +		 * child input is provided via path_to_stdin when 
>>> the feed_pipe cb is +		 * missing, so we just 
>>> signal an EOF.  +		 */ +		if 
>>> (!opts->feed_pipe) { +			close(proc->in); + 
>>> proc->in = 0;  
>>  Hm. It's curious that we use a valid file descriptor 
>> here. Shouldn't we rather use `-1`? Otherwise I could see that 
>> we might try to close this seemingly valid file descriptor at a 
>> later point in time.   
> 
> I actually asked myself this while preparing the patches, since 
> -1  is a better fit. 
> 
> I only left = 0 for historical reasons, to not modify these 
> patches too much. :) However I do 100% agree with both you and 
> Junio that -1 should be used here. 
> 
> Will do in v2. 

This is much harder and riskier than I originally anticipated, so 
I gave up trying to implement it after a few failed attempts.

In a nutshell, we have to change the < 0, 0 and > 0 semantics 
defined in run-command.h for .in, .out, and .err fds across the 
entire source tree.

It's a massive, error-prone and out-of-scope amount of work.

Can we please just keep the current run-command API which uses 0 
for "no fd passed"? I'd very much like to avoid changing this 
run-command API.
