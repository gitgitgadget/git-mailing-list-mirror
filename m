Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03212B75
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714240148; cv=none; b=TKMww0ot+XpBW99dzk/aCoMVuPigdEzhV1pehSc+b+3dQcWm5dPqwUQcJx2DApdPhhEiuVJ74fSt03RtQi0Jaed2BGd/sXJa/OqYSEPFJlL4m0XRQqJKnlj7OpCbk//r93R59Qb6wIGi7r2dcqhEKnRi5XZ8RqMMHQPMkhWKEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714240148; c=relaxed/simple;
	bh=+b3bkgBBuiiJtd/BiHrmS5y5rVmwzgldSJKU2DPH198=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=N99kdccyCigniG1xKop/FaYlTW/Rk166R2cuYlhUxlNFKdTac49c+yhUhBwa1xhHIW3/E0yUfzprF/l4XJPeYSL1bcOF4G5i6kSsE67i6DYC7ncrEI//iuJTK5HsEkJtvT3BlYA+NNjxiQjBWYmmE0qy9mcFMqJySn4AhcoybVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ydqNSh0d; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ydqNSh0d"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714240144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=shhetPE24v97ON4grLbojxcqYxYAh06pL/qwlBmQddQ=;
	b=ydqNSh0dxsCqLHwRy/J4NihNtI7tW4gyvaVTIh3v8AKZwhYJszTtFVoqBvKt8HjydVySEP
	DWyJvGl5Y1r9AP/Ne0x/xBqYQBl/oqDlS2hk6wc8x3/GjUFWrzXQnRhF3xhYwaUeIdeHH/
	1nqET4JpwyWSgU6I7wkNIjEPTYVSNOz41jeWHoqpLjnafaLwaD7FwbgGE5HGgHA9g7ni4y
	iPlLII08QbZQ7p8n/txDK64yvgjlH6vtuiHBhqO4J5Rxx2Tpn7uL5d7KoXd0HhKo+zbHvc
	HGljJQi7WYQ8XnKSXeIpsjpuneLtci9nUxkxPEcHox8mSNA8QbExY6uOHLpz2w==
Date: Sat, 27 Apr 2024 19:49:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v6 2/2] send-email: make it easy to discern the messages
 for each patch
In-Reply-To: <xmqq8r0y66ub.fsf@gitster.g>
References: <cover.1712732383.git.dsimic@manjaro.org>
 <c78b043b5a6cf0de712d36e6e000804bd6e1316d.1712732383.git.dsimic@manjaro.org>
 <xmqqh6g9w5bf.fsf@gitster.g> <7dcc6f23cc7cb823cb19ec63c69c60e4@manjaro.org>
 <0216a0e8369b8a3592dda90e5680be31@manjaro.org> <xmqq8r0y66ub.fsf@gitster.g>
Message-ID: <d4d63b9f3c7692bb48ac3e7ac34b663b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-27 19:41, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Just checking, is there something I can do to get this patch
>> series moving forward?
> 
> Get it into a shape that is more palatable to people?  That's easy
> to say and hard to define X-<.
> 
> I didn't see anybody enthused about the change, and I didn't get
> enthused about it, either.

Hmm, I was under impression that the amount of discussion that
already went into the different versions of this series clearly
showed at least some interest in these patches.  We've reached
the sixth iteration, which shows something.
