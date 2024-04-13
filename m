Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C31CAB5
	for <git@vger.kernel.org>; Sat, 13 Apr 2024 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712988640; cv=none; b=AGljg+R0lKpyKVVSC5deYKVLl9L6BuhsdLL0v43e2LsmzDTmr6AjcikqZhhu2crewp5Ia2gvlB2kiepgXOZsQepYA780Nz46mGCegIyEpl2a50+XH9JYZu1ddsP2jBU8H10pL2c/hH3DTp+SBejo1ZDXkG65dLl2kZhUKpcOrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712988640; c=relaxed/simple;
	bh=5ZjGz+/XdJJj25QPmk8XSH7K/3nzDF5DqmeK1BkyE9s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=p7wRLCVCmSLnivbmeEa7aUfff+8hzNJ07uP3riUlvNgkilB08XxemVm7KlTzNNkpXz6VSSKWhz/iDLMx/Qy76PSs9l83M4Wytn/ok7zegBJvWfU2OAnZWmA9u7HaGI+IvcSsrUaw5ifuD6jMjntsju4ROaCN9z25o+ojsWtYVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=d/JnuWA2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="d/JnuWA2"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712988634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPg34HGx6uH1HAzbUpvMm6sfc1gyXZ+iPsIunKkSS8o=;
	b=d/JnuWA2cdUyot08Kt0OXbADZo34G2+/b8RmfefVhkntr7y94cUEVBmPHljqax0yfYA3zB
	UB5GMtzoQzj9LXA/uSovVL+bWeYHJiW7wjDMXKrJw6t7pZttBeDZIWW0DA6s/PtcgbHKTC
	k6i9lrK5BveFPyKy5vpjJj6oFHmOyrAkxRUsLrsJJYg9cTai5zNOhui+cMIQXoKHt76xaS
	L09zeDb2UZfvqDPZ9h3ajZW5Wqzg90ReRZYbnpoh4Df7eBE610Aepcz1pO4i9h+97yiDmG
	eJbmdOkABjrbS9QRDrK49sr6nAD9b3Lyw6jSkPUjd2Qx71d3Hcpn/2+SZJA/AQ==
Date: Sat, 13 Apr 2024 08:10:33 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 code@khaugsbakk.name
Subject: Re: [PATCH v6 2/2] send-email: make it easy to discern the messages
 for each patch
In-Reply-To: <CAPig+cQ+VV_Raxsk31vG8H4D5NjLsW5oFCA-o28raqrSRhi1TQ@mail.gmail.com>
References: <cover.1712732383.git.dsimic@manjaro.org>
 <c78b043b5a6cf0de712d36e6e000804bd6e1316d.1712732383.git.dsimic@manjaro.org>
 <xmqqh6g9w5bf.fsf@gitster.g>
 <CAPig+cQ+VV_Raxsk31vG8H4D5NjLsW5oFCA-o28raqrSRhi1TQ@mail.gmail.com>
Message-ID: <fcf3331de77a623bceec6da6f3acbfed@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Eric,

On 2024-04-11 00:59, Eric Sunshine wrote:
> On Wed, Apr 10, 2024 at 12:28 PM Junio C Hamano <gitster@pobox.com> 
> wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> >     MIME-Version: 1.0
>> >     Content-Transfer-Encoding: 8bit
>> >
>> >     Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
>> >
>> >     OK. Log says:
>> >     Server: smtp.example.com
>> 
>> This is obviously in the realm of subjective preference, but I find
>> that the prompt line is distinct enough among all other output that
>> we do not need an extra blank line to locate them.
>> 
>> I'll let others comment as the "blank around prompt" smells quite
>> subjective and do not want to be the sole reviewer on it.
> 
> For what it's worth, I had the same reaction about the extra blank
> line related to the prompt being unnecessary, but I didn't feel
> strongly enough to say anything about it, and I still don't feel
> strongly enough to suggest dropping this change.

Basically, I went with a rather simple reasoning:  the confirmation
prompts, just like the SMTP statuses, aren't part of the emitted SMTP
traces and patch descriptions.  As such, separating the prompts with
vertical whitespace is actually consistent, and should help with the
overall readability, by taking the prompts visually out of the other
produced messages.
