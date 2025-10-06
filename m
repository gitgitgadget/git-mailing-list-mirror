Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F952857EF
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755719; cv=pass; b=suCdxrW6JIDy/TwSs4yZEtRQgK7Kz9cRkryQoAZokDkjq1We6jFF/9pzTM9bfZqRAh+WrAe3FAwykXZwP5w/5t8a/KcdFSNGnFVoecBgD4yDYqehRAl92KgbAhewa8U3gmrePJERfQq/M+hd9yVpHImKoLZQWuqsA0EKVh3RyJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755719; c=relaxed/simple;
	bh=TOve47HAPCWscGR6YdwMHKKgV+TzdnoQxJ/H7LtASeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NjOEg0n+penQXteiwdCgWMkBavwtoTkbnw0ltYwCH1G7vCTczpit0cv4scy2sK25XFneECMhIb7VX7ym11iqn+nzfcUb7LHgy4fA+J/czKO4tYnaoOX/AwxSOm2f5n+xDzHKgocx3tkll0SRgIAH7PCbTkKSESrxQe4XmUdZAlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=GZKluVeU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="GZKluVeU"
ARC-Seal: i=1; a=rsa-sha256; t=1759755701; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X1O6AImvj7L8V7j0vveGO3y82s2glJTWpFtMfhAucrNXDrKIL3e+IOSJUA9z25UXNFlnOod+lwUBLMa6S5OsJSx7sgNKV5DETDhxnbDR4mb/HgzbiveaZftjPgnKnxHRHnEDOV9NpwYivlQLb1fP2/C1vD7IxJtRYBYx7ACAvcU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759755701; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PFuI1j9IdNMHNAx93CTlZM4Wt3G93zeRwf53GLIAQMw=; 
	b=RLjE9KvYbAdu15yL7o1+BPu8Zcf7zzVMla9BrnjayaJYy/DoZhEaOtuJm6VaJT1Ma48q8GhM/5wGMfJ2TbJVyFvpztTy77Arz/2NCg2BOuUE1WhqYupw3Kjo4AM0KX0VT2F24hcQ6MeDPY7/TBZ4fBEERO8vjP7fM9TFGpPVNWw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759755701;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=PFuI1j9IdNMHNAx93CTlZM4Wt3G93zeRwf53GLIAQMw=;
	b=GZKluVeUfcI4XO9W7NM5DzPk6jXj7PDihQTW6g0Ts1erqbrVEmUMnN1z/uVFcTUH
	LJ3YA1/fUKgbU5j9akJfam1E51Ua0Nry0LXYpjB3KXQdvTm4wNsf0igACOSWdB6n3WL
	vR38BHSNuVawyYXB9pE8Uts1KhUpkuBapYZD4O9A=
Received: by mx.zohomail.com with SMTPS id 1759755694353978.4429893788583;
	Mon, 6 Oct 2025 06:01:34 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily
 Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Josh Steadmon <steadmon@google.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 01/10] run-command: add stdin callback for parallelization
In-Reply-To: <xmqqbjmpxq67.fsf@gitster.g>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-2-adrian.ratiu@collabora.com>
 <aN4c6l7gRi4auss1@pks.im> <xmqqbjmpxq67.fsf@gitster.g>
Date: Mon, 06 Oct 2025 16:01:30 +0300
Message-ID: <87sefw421h.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Thu, 02 Oct 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Patrick Steinhardt <ps@pks.im> writes: 
> 
>>> +	/* Buffer stdin for each pipe. */ +	for (int i = 0; i 
>>> < opts->processes; i++) { 
>> 
>> `opts->processes` is of type `size_t`, so let's use the same 
>> type as iterator. 
> 
> Good eyes. 
> 
>>> +		/** 
>> 
>> Nit: multi-line comments should start with "/*", not 
>> "/**". This is also present in multiple other  
> 
> True. 
> 
> Especially for a comment about a specific piece of code and not 
> about an interface---even in a future where we use some tool to 
> extract them, we would not place them in documentation. 
> 
>>> +		 * child input is provided via path_to_stdin when 
>>> the feed_pipe cb is +		 * missing, so we just 
>>> signal an EOF.  +		 */ +		if 
>>> (!opts->feed_pipe) { +			close(proc->in); + 
>>> proc->in = 0; 
>> 
>> Hm. It's curious that we use a valid file descriptor 
>> here. Shouldn't we rather use `-1`? Otherwise I could see that 
>> we might try to close this seemingly valid file descriptor at a 
>> later point in time. 
> 
> Good eyes.  Does -1 also have special meaning or we have no risk 
> mistaking this proc->in that was once used with a request to 
> open a pipe?  Regardless, I agree 0 would be a bad choice here. 
> 

Ack, will fix all these in v2.
