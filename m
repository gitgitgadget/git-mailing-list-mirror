Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9C14263A
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271804; cv=none; b=e7guZbRXvux/0FhTPH8e0MVUALH8b/q6ygVDpFOo5kh4QGiwZfIx4Svn0agwScd0J4WRgelOvg1hkWSeaBxJl01kYQ8+aznm23mR7P3pHov+j1HfGtkLOp+qaRQH6xWitrUKJxyNLW+Ih5nC7B7CttxR2eVW6j4g2b83n1WvJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271804; c=relaxed/simple;
	bh=3nhu9wdrdu083WmB2+aiXgNUpKXUJkK7MifdYr3H9cA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZUqw2TjPa4W8BgZCbdWfn0GX2sgTmqG655l8t1qlvjhQeTjSeDOt7eMFSTz37QBMjfFykbc/ig3OEaODj5kmNU+4F+2Kjtqb9z16yIOTS228h5vlk0GD+chpL7vtGZ9XUPc2K6BH7CQWvwwntjHZ1M36F6noSvSMVtm5299SgGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CVK9/3OB; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CVK9/3OB"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710271799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tux9FPvnEostpZhHgEpSG+dj0sSAmujWLb3C4ZfR81s=;
	b=CVK9/3OB9416SNsaMRGYzfbCXg9+ZufVn8WVwkEd+hpSOAkXNNPmJZn3CJgBXwJ1hxWuwx
	WJ5z5Z2/38hZa1XJN0Zf/Rf7LM4kL4u/UY97FFjDwfvCe4fQE1+DPQqmApp3XMLFcdWQme
	/2lgnEEVJ4puXbkNv+7A8vYFJo8oskVt1UexAfRV3/iccKXy7+t/dnKE/O6kfdyPezwOQd
	G3N7aSUA27ZBMjnaY6qrxhptVxutNlV75rQMpQcvCjleNLrXcoBWgDw0NuqqGWb8xWaDhq
	THIR6A0GxO4xJk80dxsU/SYNQ35TWwQOsohMJEzVSpzMfQn4KgzwF4yQYTmR3g==
Date: Tue, 12 Mar 2024 20:29:59 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, git@vger.kernel.org, David
 Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v2] diff: add diff.srcprefix and diff.dstprefix
 configuration variables
In-Reply-To: <xmqq5xxrl0f9.fsf@gitster.g>
References: <20240312005756.GA3029606@quokka> <xmqq5xxrl0f9.fsf@gitster.g>
Message-ID: <2b2cdf7a3738f28ffc73ff10692361c5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-12 20:23, Junio C Hamano wrote:
> Peter Hutterer <peter.hutterer@who-t.net> writes:
> 
>> Allow the default prefixes "a/" and "b/" to be tweaked by the
>> diff.srcprefix and diff.dstprefix configuration variables.

If I may interject, albeit a bit late, we should use "diff.srcPrefix"
and "diff.dstPrefix" as the configuration option names.

>> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
>> ---
>> Changes to v1:
>> - note default in documentation
>> - drop the custom prefix function, change the defaults instead
>> - commit message: options -> configuration variables
> 
> Looking good.  Will queue.  Thanks.
