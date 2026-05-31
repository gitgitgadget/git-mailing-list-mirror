Received: from mail.luna.gl (mail.luna.gl [141.147.12.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84A3812F1
	for <git@vger.kernel.org>; Sun, 31 May 2026 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.147.12.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216208; cv=none; b=FXCAgM6Z5OlV9D/A6UHhGTX4xBzaokf4oDzIN3iptGkkN+rgMr+itHrStUWSeeYysHhv1IApQQbcvMcbYNsHNbPksse2Qnrhy4THWsgcjvDsziFD+65HRafTvrulRoCFZRFcZjQ87cxaEtPcvt91VduyxUk/d24hWTCgcFh+A/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216208; c=relaxed/simple;
	bh=8OPLp9UlNmY3oOrS5ARQsUnIJEdDRuU05A9U1sIlBHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7qM61hiuG6afSj7Dq5Ql9hD7/ZFOTk+/RlsJT338wa0ZlCEsLP3SlCKQ1oQDCwYklpq6VIa9UlKBsgTuJIcQpDCyly6mPhYLP2E14C/NmsVCmcLyZJRgIJboQ5MrpdR3iPStPb8jTzNwa94XqjSgumOqPNo4IdKTjYqH6cL4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl; spf=pass smtp.mailfrom=luna.gl; dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b=cyrxbIMQ; dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b=oy+q8Cws; arc=none smtp.client-ip=141.147.12.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luna.gl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b="cyrxbIMQ";
	dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b="oy+q8Cws"
DKIM-Signature: v=1; a=rsa-sha256; s=202405r; d=luna.gl; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1780216195; bh=rEMueTaG3P9Vfn8Zz5lclKS
	LvAIYRy0tq1mbHvJyIxA=; b=cyrxbIMQIEM+8fc4KaoEvNGJ7aGcwO4ZvvWI8wzOZ8cdKyKgeh
	SpMH05u1izfITD4hXoIdpyXwmckFqsVCAjgMyvucNjhEtZTDu04zXSY0P0c1gpFr6UV8lvxOgNc
	OJm/TeBFcquu2AE2K53+B8pdNzzF3FnOoA1L7X/CFvkTOl+P3+FIqLFQvnhiRy+2/aJeH8dJuS2
	+TtapjcXh24h0u99V9Ma63RRqpWybdUaWjkG2f5PeKtdih9Ty0NzuZflK9vacqRvmBrRpNufRtv
	XZ+scew4LCCC0/E7BE6xAIJApRqFeayVANxj5d+V59C6qmMI/2DGuNvM9Sz4lnNJxpQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202405e; d=luna.gl; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1780216195; bh=rEMueTaG3P9Vfn8Zz5lclKS
	LvAIYRy0tq1mbHvJyIxA=; b=oy+q8CwsamFQFPpWR4ZdKHD5S9wahBldRCPDCLIhJnhLAJMJHs
	D4hPU5jeNuQj75SmfJHhOUsvMc9oSj+ZBtBg==;
Message-ID: <ca8e1a7c-1d9b-4af3-95be-fcb5c2e24d80@luna.gl>
Date: Sun, 31 May 2026 10:29:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: doc: document '@' prefix for raw timestamps
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <fffe0ea9-baea-47cc-b354-5be4fff08983@luna.gl>
 <a8e51dda-7b1d-426e-9af9-cf856c42342d@app.fastmail.com>
 <08a04d91-af90-44dd-b28f-f3d5b9e77413@luna.gl> <xmqq7bolg762.fsf@gitster.g>
 <xmqqpl2de41m.fsf@gitster.g>
Content-Language: en-US
From: Luna Schwalbe <dev@luna.gl>
In-Reply-To: <xmqqpl2de41m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 >> This was introduced in 116eb3ab (parse_date(): allow ancient
>> git-timestamp, 2012-02-02) and 2c733fb2 (parse_date(): '@' prefix
>> forces git-timestamp, 2012-02-02) to allow specifying "ancient"
>> timestamps (like 0 +0000) without conflicting with YYYYMMDD date
>> formats.  I do not think neither commit added documentation for this
>> '@' prefix, and Documentation/date-formats would be an excellent
>> place to do so.
>>
>> Care to whip up a patch?
> It might look something like this.

Thanks! And sure, I'll try to submit something later; this will be my 
first time using the send-mail workflow, I hope I don't mess anything up.
