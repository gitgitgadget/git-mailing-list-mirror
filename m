Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1014AD2C
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716508636; cv=none; b=D+/lLeWNNIDs/hqMM7qWP6pEZ0AhX83ApHF98PjwEVy39MTTMHNVtGmzzlymzIxZ1lQ1Z3EYu6FRroJ+yBhrOW52J1ShuZPheXK63Oyjt7243fU7vzFb2ypw9VW5+dJOF3GkFYUyRYU3IfPZMujZhjnG6xMGji29uupAH1fobF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716508636; c=relaxed/simple;
	bh=YVLeszVsDLlGOt/rKn6qEJA93WPfdvfY+wXLPJw8wUE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eJJbIuL+0AdCp4J3w2fDcI3NO9oyUnxhob9ca7mKUoas10IwQ9Wdi6U6+GtlZppga/yeY4jegaHtSunMYg5N2aZpmmnGx5afHezVqMi70+20EiDDwDaxZYpgPHVfcjDmspMbloAPyHQ1RHjQyiaXd9dkUAaZW+wMtTur47CpZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BsX/t5Uo; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BsX/t5Uo"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716508633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzChMhLHnc0TlaKFKr1VY6OQBcTJaekhjHnHC1MCvKo=;
	b=BsX/t5Uo5Aka22L37aff2X5QxqHEzM8rlLAg0a4SvgXGDW2ZFkw+qO6Uz4H00eMl97oDmR
	dR5pCALgrbGk2xXcD9EuxbbfAgcCLMIJYsTUEaCM0PPwLzogMRUzNyjtQrgjU0udsdchZV
	w4mt4ten2qtqh7U2kKMN4cupBw70BDCbwI4vQPu3hMMuqUzuFCmaWEALXRYv/vf3x3ek8s
	77HobhTATtC3ffNRNWMKBh7+7l0GGQdjOWtU5JAxtOIxQZ/uIeOm64FEStc56kekwvNvk4
	0Qb1QfRIB5iJPUz+IY+13XN0OPjrIWJ7mWcwSmtG5iKnmHYJGl2voZWj982/xQ==
Date: Fri, 24 May 2024 01:57:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <xmqqjzjkozhv.fsf@gitster.g>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
 <xmqqh6esffh1.fsf@gitster.g> <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
 <20240521070752.GA616202@coredump.intra.peff.net>
 <5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
 <20240523090601.GC1306938@coredump.intra.peff.net>
 <xmqqjzjky6eo.fsf@gitster.g> <261636d461e58ac8a16180c4cd6e0460@manjaro.org>
 <xmqq7cfkqger.fsf@gitster.g> <ba1c6fbac4424a4e2c68cb439f9918eb@manjaro.org>
 <xmqqjzjkozhv.fsf@gitster.g>
Message-ID: <928234dea3d6d7a5ed1e39e9897ef4cf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-24 01:54, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> On 2024-05-24 01:04, Junio C Hamano wrote:
>>> Dragan Simic <dsimic@manjaro.org> writes:
>>> 
>>>>> And for usability, perhaps giving a specific command would change
>>>>> the default program a bare 'P' invokes for the rest of the session
>>>>> until another specific command overrides.  Another usability hack
>>>>> may be "[interactive] pipecommand = less -FX" configuration 
>>>>> variable
>>>>> gives the initial default for each session.
>>>> I think that would be way too complicated.
>>> 
>>> It is modelled after how "less" and "vi" remembers the last pattern
>>> fed to their "/" command.  You once give, say, "/test_<ENTER>" to
>>> find one instance of "test_", then "/<ENTER>" takes to the next
>>> instance.
>> 
>> Huh, less(1) actually remembers nothing when the secure mode is
>> turned on.
> 
> Are you sure you read me right?  I wasn't talking about storing
> anything on disk for the "usability hack", and made it explicitly
> clear with "for the rest of the session".

I misread it at first, but I corrected myself. [1]

[1] 
https://lore.kernel.org/git/3391a15907a055c281106c4995fb8272@manjaro.org/
