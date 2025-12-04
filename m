Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65E13321A3
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764840066; cv=none; b=DrY2LAKvyYJUaeP0+IOAIH/GWdK8JK9yGVbunzRYcwKsMbh5Bn7ApIDrqui6vaf6RBzuiYJs73XQavZa+8tjopsBAyxb+WqN0ynJb5sx4Ps+QBY8mRqXbV+xVZgpOPlC10w4EzhMdZWxXbsyk3js2E1CyWDaUPweEA3nVQXrCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764840066; c=relaxed/simple;
	bh=cWhslAgfz+i14Ov0ayGV1nTDnxNdw+RLAKLvjxUk1Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Glc1w0kZ+4u+hi/DnRX/E13a5okJlr24X8u/xuDuxsj2uUm2YA3bHrSMEjtlucinizVgOBInVxrzccRDGI++SQkLLYOpGSILr6P/QLqRDNzeLROdlEgdcjKLMc/1dOA/VV87Zyq0c2xjMpt28PMWg64maZkAI19XQOnaTYt1Z/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dMTWy5Z32z7Qjd3
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 10:21:02 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4dMTWn1FTmzRq1n;
	Thu,  4 Dec 2025 10:20:53 +0100 (CET)
Message-ID: <9f7af47a-ae39-4931-805d-f6e4549231ac@kdbg.org>
Date: Thu, 4 Dec 2025 10:20:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: fix history window panes position
To: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
Cc: Git Mailing List <git@vger.kernel.org>
References: <AM0PR08MB5426BC141388A69BB5087732E1D8A@AM0PR08MB5426.eurprd08.prod.outlook.com>
 <9a9441d5-fb64-4718-8765-852e66458598@kdbg.org>
 <DB8PR08MB5433FCF25C0693952E0E67BEE1A6A@DB8PR08MB5433.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <DB8PR08MB5433FCF25C0693952E0E67BEE1A6A@DB8PR08MB5433.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 04.12.25 um 09:39 schrieb tobias.boesch@miele.com:
>> Von: Johannes Sixt <j6t@kdbg.org>
>> Also, the error is not limited to the upper half of the window. The lower panel
>> (patch text, file list) also forgets the last used position when the window size is
>> changed. Can we fix this, too?
> 
> Yes I plan to do that, but I thought it would be too big for one commit since it is
> a slightly different part of the app.
> I wanted to put this in a separate patch, since I just started with using emails and
> the git mailing list directly instead of using gitgitgadjet. That's all new to me and
> I didn't want to start with a series of patches on this first try.
> Would you like to have that fix in this patch and convert this patch into a series
> (somehow) or is it okay to put it in a separate patch?
It depends on the solution needed. If they are the same approach, it can
be a single patch. Otherwise, a separate patch may make sense.

BTW, the email that I received was not usable for git-am because its
body was base64-encoded. I had to copy the text from my MUA to a text
file before I could apply it with git-am. If you have trouble sending
out unencoded, raw text mails, please use Gitgitgadget if there is more
than one patch in the series.

-- Hannes

