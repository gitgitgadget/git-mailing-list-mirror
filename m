Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1379C0
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211131; cv=none; b=m/P1hztBcxGA+BBdN9mnKIW0yve+FZFTSsuB7PNZKcADqjpY5AgZoZtVeZZFd9bE2tzrqmXV/c6lyBIdccef8P5z9gTZf8jNAgGynYqueeXNfRWuTOws0ns28r7hGauhu6a0i/z2c02hbDvLuUU4H9iH1HLm2XZLOL+FDL1SVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211131; c=relaxed/simple;
	bh=FDuczVgIlqbCBXXkhWVEFUmudzoOund5YwbG9DH8LPE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=V/rPiZ4QC2vR+XJSB16055i+PirnkTOlrENu2C3TifsazghANECTC5/f4eyGS9nIQuzhDgfVac6rn5Pu8lsLPr28rbuf2kwNLj+FrxxIJMRYD3oXw7/9hAos5ARGlW8p23fc1zuJVq0vzlFlAHQCKRJvEC0ANY/5rUdYmEnObYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=pRs8SiBQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="pRs8SiBQ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710211127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3l1vsAfLczxRv/6GzrDluafXMlzN24vSoagCPFGYNg=;
	b=pRs8SiBQxWsWh4rHjuAyfrHXehKUiAd1ItLx8y+hVhqzYj8qg1MB8ggh/0NEliWvWYAeYL
	QEJtkeeK96FOJwWtH0p9zmLOmy82XecYMYGWqqqxNwWjE26XIkflV4yWw41j+OZ4C5Qxt6
	3lepYwKzyszmAZlUWfnqAxPykAeerTr3GvTP8tv9HFjME45iFtlA/0WMGVDHqzwRs0qIXq
	7w81LNEO+MFoExeqh/hrNP3dOy/N8UDDphBbuj/5rgmBjzq7mRRN1xyYsBymF1MXj+I2Jc
	WTwuBCAaE+avRSxd+kPFJBLCBj3zuQhuJgk/VPKM/WrJP6ly/+MVlykETXjrMA==
Date: Tue, 12 Mar 2024 03:38:46 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ralph Seichter <github@seichter.de>, Ralph Seichter via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org, rsbecker@nexbridge.com
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <xmqq7ci8pi9d.fsf@gitster.g>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g> <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
 <ba6d65ca-8ae2-4d93-a5a5-e0b60768c302@seichter.de>
 <265e5b2d352c34dfe0625904b3356000@manjaro.org>
 <277b3187-f793-4782-aa18-50bc15febe9a@seichter.de>
 <349b8a67931a2fddfff35db393023bf0@manjaro.org> <xmqq7ci8pi9d.fsf@gitster.g>
Message-ID: <361f3554c172f43c0aff5d1a46dc7e29@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-11 22:31, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> However, I think there should be some way to allow the users to choose
>> the kind of spacing between the automatically added comments and their
>> respective values.  Yes, readability may be subjective, but I think
>> that the users should be allowed some kind of choice.
> 
> As to the whitespace _before_ the '#', we can just pick one and
> leave the choice to users' editor, which they have to resort to
> anyway for even trivial things like fixing typos.  I am fine to
> defer the choice between HT and SP to Ralph as the person in the
> driver seat,

I'd vote for tabs before hashes (i.e. 
"name(SP)=(SP)value(HT)#(SP)comment"),
because that's what I've seen used in numerous codebases.  Thus, that 
should
introduce some kind of additional consistency.

> As to the whitespace _after_ the '#', I would say we have obligation
> to the users to be consistent with other codepaths that we already
> write our own comments.  "# " is the only sensible choice of the
> default there, and we can allow other styles as I outlined in a
> separate message if we wanted to.

I'd agree with that, as I already noted in an earlier reply.
