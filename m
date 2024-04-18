Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8824F1E4
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713409981; cv=none; b=EhjWDEkfxq+kp54E/EbTexrNvhaOqU2VEb8YDHr6/RDxYlVd/T9aJqvz3PtN7VNuXBxClMUteElwZZ6QKYyMhGFo0ZSZK2bkdUQ40281CWO5M1qeOR+KVbW7M3LtREudF8YLrgzX8TzjYEcrM/aGO+twSsclMIMSgFAQetR8xJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713409981; c=relaxed/simple;
	bh=tMgGbxEjPSnBRh4gWViFth4XHXp+cNl/BBxeh6HR5PQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MQgEzHLubKErrji9RcRAm1S4liuv5c/ouaDSHR6gauH7pYC+Pnj1PEXpiP9vjuKQAqF9dpruIPAuUmIDPV4BQPUEMmuKsMmtGEH2Ilmd3ev6TmmeNCyBQf9bIy6KXSvT3EeIF+891mYTUJ1SF8mLFzqnrA1CNQLMlG4SJXhMjl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=AF1wtkha; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="AF1wtkha"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713409975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISVWSCDo2opM1iZzVQnwH99h0eKz25WdsraFPwpnF1o=;
	b=AF1wtkhaPB811UdrEvQRLkxNNb9lZ4kXeJ2B3UnVVxik1TZbte9ZxYHLJjz2CLKAfyP7U7
	NnmjetJ01RrTHIk7RRvJmb5mXSe7osMyaFqPb1G1186CLF+wHSPeyfZ8ZGyUyQbh0RdDmQ
	iG4yemcw8JX3W52tlYsJ542Jc74I6VE0tSgkrT1wd4gYlqxn1UBVrsmmM8jgJjJc1ID7mA
	cIS+YDgzYZ0fNtM5I2GwrDjoBPO9ye3g/5AZ2RXsSvr2PF0KQ9m+vWCOyq394yIiPSkcvy
	QvombBtV0gmKvjjeFf3yNI56DA3R4zI200DU5KuuZAggvf+x5crDx7RxT/HZeQ==
Date: Thu, 18 Apr 2024 05:12:55 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <19d5f3d4c99fc1da24c80ac2a9ee8bf8@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
 <xmqq7cgwau1v.fsf@gitster.g> <c2cb9268c29ae4a5cac34383b7443763@manjaro.org>
 <xmqqle5b66sr.fsf@gitster.g> <19d5f3d4c99fc1da24c80ac2a9ee8bf8@manjaro.org>
Message-ID: <84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 23:09, Dragan Simic wrote:
> On 2024-04-17 23:03, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>> With all due respect, "--rfc=WIP" looks like a kludge, simply
>>> because "--rfc" should, IIUC, be some kind of a fixed shorthand.
>> 
>> I wouldn't use "should" there.  In any case, we are not going to add
>> unbounded number of --wip, --resend, etc., on top of what we have
>> already.  Introducing --something={WIP,RESEND,RFC,HACK,...} and
>> deprecating --rfc is not something I would object to, though.
> 
> Good to know, thanks.  I'll drop the patches that add "--resend"
> as a new command-line option, and I'll think a bit about the solution
> you described as acceptable.

How about introducing "--label=<string>" as the new option, where
"<string>" could also contain '$' as the last character, which would
get stripped while indicating that the label is to treated as a
(sub)suffix, instead of as a (sub)prefix.

For example, "--label=RFC" would be equal to the current "--rfc"
(which would also become deprecated), producing "[RFC PATCH]",
"--label=WIP" would produce "[WIP PATCH]", and "--label=RESEND$"
would produce "[PATCH RESEND]".

Specifying '$' before a space character in a command line doesn't
trigger parameter substitution or variable expansion by the shell,
which means that using '$' as a "suffix anchor", as proposed above,
would require no escaping or use of single quotation marks, making
it more convenient to use.

Please, let me know your thoughts.
