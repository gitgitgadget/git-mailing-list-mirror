Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ADB7F
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485302; cv=none; b=uo0TlwUjH2gM4ws8CpDan75Gv4oFOPqssbwR71j1SxwGxW4pGW1xfeQUTPOZuCerKHyJFRg/H2xLzrMvxy1dmTMhwO5npIwKN2ruxXB3i5Zcw2Po5d6WkFxkwRDhwzDIUOLvvzjLBafn3KEVzXtDAP2MpwtszXt625oOIVOV81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485302; c=relaxed/simple;
	bh=+lqVfsc9LUxdklKYgP3q4g9OWzBh/3bzCQMEMTI0T1o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=S9C5fQ6Ui5W3mJzl7rZmkIPbWKYzn7ZMgFCi2vzc+Xusxm9Afyws9VLObchmgnbEY2hRjMEFEr2OvoJdQfpyiJA6NqCYRQ73k5D1XvvQa6Kv7SLgdEH/ez3qvzjqL7iCbgQDBLB7RtstMYoPpYOPpZvEuBEfAN0+YW1kbfN5K4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=VcIJoaSw; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VcIJoaSw"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713485296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyRqeCU6t67Bf8NrfJov46qlgEF+Ib4SChMD0VqXfF8=;
	b=VcIJoaSwloW/AuwmBjF1oi4/fUqvCoCZSfFp2CnADwFcliPmYGK5ucVA34VlrH5rT5zkSd
	keo1Ep2Glm9T2yi3kBKZEBl0NVS2cxuKf+F3dSMFmbrfK+bSeeaIASibGMkwqAp0QoNdtF
	mZA1jvTOMgSM34UUaDWWoPWZn/7hEp3Mc3EsJwaStoFLMiSRm4dl3x3VgXVVB9OfsCt+5b
	2K3ouK08w8E5xsEMqkHIVFNDESiPOmFMztPuN1UmaA7dpIaxeoiujV/ac6ekA4Eego6Uny
	AL0WUBTXQdqxojZxZuVE2m9WOi9C7RtGmd3spIcJAmGlOT9e1XMI1D4PH/dYdw==
Date: Fri, 19 Apr 2024 02:08:15 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <xmqq5xwepafi.fsf@gitster.g>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
 <xmqq7cgwau1v.fsf@gitster.g> <c2cb9268c29ae4a5cac34383b7443763@manjaro.org>
 <xmqqle5b66sr.fsf@gitster.g> <19d5f3d4c99fc1da24c80ac2a9ee8bf8@manjaro.org>
 <84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org> <xmqq5xwepafi.fsf@gitster.g>
Message-ID: <e6afba5f27887fb35e2e236135ac06b8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-04-19 00:34, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>>>> With all due respect, "--rfc=WIP" looks like a kludge, simply
>>>>> because "--rfc" should, IIUC, be some kind of a fixed shorthand.
>>>> I wouldn't use "should" there.
> 
>> How about introducing "--label=<string>" as the new option,...
> 
> I still think --rfc=WIP is a lot more natural and easier to
> understand, and it is just the matter of how you introduce it.
> I'll show you how in a separate patch later.
> 
> The problem I see with an overly generic word like "label" is that
> it would mislead readers to say "--label=important" and expect it to
> appear on an extra e-mail header, not as a part of "Subject:".

"Label" is a little generic, I'll give you that.

> But we can do this to get the ball rolling, without bikeshedding
> what option name to use.  Until we find a good name, users can
> use --rfc=WIP and when we do find a good name, it can be added
> as a synonym, possibly deprecating --rfc, and if we never agree
> on a good name, that is fine as well.

If you insist, let's do it that way! :)
