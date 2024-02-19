Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37D50A67
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372538; cv=none; b=uNBYUSj+eKKJu27be8z4oe7CMkzZOYv38da1QEflaJgljKEBNGtIWCvmO9A/CHgOdkmDkgcypimPcbJCuByCQe/vxt9QM78UOL2fwiIaOme6EwnlnxOgK/pAKMU9nanKVZPzc1vPUX7M7RINh/L1fKYY0HZQFoQLs6I96RvBJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372538; c=relaxed/simple;
	bh=4AJFdihFTKvHYCyxjkezinFTJ/w8ilCQTg0PH5DHPeQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EzlcZgqQK4KwgUMiYgF7u6QlTc0uFukm7/nH3u4YRJrqK8MiKSg8UC+gc8PPsIdLnwL5N/JSskOf0cQjzmHfKfX2l4f57ZL/GplqvRLPaP1AnF/nsqLc3YNWU9ml3RkIqpjFLwkZV/AjPFtwyhhjcsmAyYLsw4ynlENmDbuAWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xSuklP2b; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xSuklP2b"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708372533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hh99HGkChZMWtk0H4lCiY6K8rOBJ+7Siy9BGzbCZc30=;
	b=xSuklP2bjJgXtqCVJWUrPOkJtshz22zhMw4yg8kevcf8iLDOx8/ODQoi+b44zoX1/vzgSd
	x5tKtdo0mP7r4DFsDHQDxsztno3aC11L5RdqSRo8thLboifWft1c3dRYtJI6AeBnh53Nhj
	Gwls6M3fCD91IAU+yf9FTs1zjzwbjiiwXuvc6TXG6v1cORB0Ec3uAwG/LTcb8sFnGv7dKI
	HMPA4I4f7OHC2zXL12bdme7mP4THW/b4htlmybP6Qjo36uzY6VLeS4VRR7zGE7ww7u6FgE
	+C0zExWZ2ijyLjQy8f8ulQaiHL4u0YacHK2lg/zaqmFkBEn7vDFS7NNnnPgC7Q==
Date: Mon, 19 Feb 2024 20:55:33 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <xmqq8r3g8caz.fsf@gitster.g>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
 <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org> <xmqq8r3g8caz.fsf@gitster.g>
Message-ID: <35738a93f5cbace5b3235ce614b7afbf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-02-19 20:49, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Regarding the branch copy and rename operations and their argument
>> names, perhaps the following would be a good choice:
>> 
>>     --copy [<branch>] <destination>
>>     --move [<branch>] <destination>
>> 
>> It would clearly reflect the nature of the performed operations, while
>> still using "<branch>" consistently, this time to refer to the source
>> branch.  Using "<destination>" to select the destination name should
>> be pretty much self-descriptive, if you agree.
> 
> Awful.  While I was skimming the messages without reading the
> Subject line (hence without realizing that this is about improving
> the existing documentation and not adding new features), I thought
> that these two are about moving branch to a remote repository that
> is named with <destination>.
> 
> My advice would be to stick to <old> vs <new> that contrasts well.

I appreciate the directness and honesty.  How about using "<oldbranch>"
and "<newbranch>" instead, which, although more wordy, would be more
consistent with "<branch>" that's used in a number of other places?
Such consistency should make the users recognize the arguments better
at first glance.
