Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C76E60F
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506915; cv=none; b=jCdPmpqBbdUp8U9NTHdZbzygLuz8Wj7Jf947uMAwvYAGY5Enl+c8I6F2hx4rQfhENDW2/oNR+y4AO+7Er4mjo9arJ+a4REWCWbDlpbX/IbRpxN495dw8u2WvbDeYYb/3uIxNZF1aH2jVp/kZL4LlQjaf62q+MmVBgJ0EH8TXJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506915; c=relaxed/simple;
	bh=caeVJe4L2Rrgs3fDN3R6MsEozsfCZH/q+mvjijOLoT0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=C5BzbbvN22v3UTmXn5YQaXEdx9Z43aZku1nmP6MKvkFQ7RAHVyzV3cSpVYOOqIwe7SVWpBT9phPhgFOBFGs2LZSVOpt3LNRmqfPvNPv603FqXhHnvYIYF7dhzochxfj6ZdrMjLkElnivrIoJrC++i9SIt8CmDlIyMwZIuub6pp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xsx956QO; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xsx956QO"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716506910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+c/x7e90MEQhs/OyTfuA2ejN9A3V05V9tq7ceZvwmmM=;
	b=xsx956QOU7iB7NPx35TIntFoK8FOi5Uf6cJir8qeH/MP6sHWJqP4ILLzh0L5wVwEjGSrRT
	U0lUUL2R7vLZyDBQeh/2bodXcUO/an50/rK4eydt01pT9NrdjY+zY1idRjs/ajpzLbDk50
	1tH/x4EH+bqPGCG3XqQ1CQLZ8NGE7HWDFMWvDhPPIHZUWiRp9CcK8TFIEGK1u/zzbEvuoy
	NPoG8e8iMpNVEw9ssWaTs/OQl6iuQRobAvR6Xj2mx99Ig8jzTlyxZ/1ZkW/Vg705H6vWUV
	qUKNMHPXbKqwzluwJI465t5ohaVM0g5TsJG9w8FH2dKRPaBsGtZGsOfpo24vYQ==
Date: Fri, 24 May 2024 01:28:30 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <xmqq7cfkqger.fsf@gitster.g>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
 <xmqqh6esffh1.fsf@gitster.g> <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
 <20240521070752.GA616202@coredump.intra.peff.net>
 <5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
 <20240523090601.GC1306938@coredump.intra.peff.net>
 <xmqqjzjky6eo.fsf@gitster.g> <261636d461e58ac8a16180c4cd6e0460@manjaro.org>
 <xmqq7cfkqger.fsf@gitster.g>
Message-ID: <ba1c6fbac4424a4e2c68cb439f9918eb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-24 01:04, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>> And for usability, perhaps giving a specific command would change
>>> the default program a bare 'P' invokes for the rest of the session
>>> until another specific command overrides.  Another usability hack
>>> may be "[interactive] pipecommand = less -FX" configuration variable
>>> gives the initial default for each session.
>> 
>> I think that would be way too complicated.
> 
> It is modelled after how "less" and "vi" remembers the last pattern
> fed to their "/" command.  You once give, say, "/test_<ENTER>" to
> find one instance of "test_", then "/<ENTER>" takes to the next
> instance.

Huh, less(1) actually remembers nothing when the secure mode is
turned on.  That's another thing I've collaborated with the author
of less(1), to make it possible to remember the last search term
when running less(1) in secure mode.

> As I expect our target audiences are used to such a behaviour, I do
> not think I agree with your "way too complicated".

Hmm.  Where would that state be stored?
