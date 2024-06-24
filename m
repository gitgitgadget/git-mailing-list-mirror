Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179543B1BC
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214685; cv=none; b=Jnchaniq6KQfIM/RVm+3VKalBd/AE4NHm6GLytTEUQ1sshrGXtjJVTlaVsxzd8hO6kmnQ8QveaXUggGyJnlj41IyCAWipxc2umdEhSo9LfagyEZdkGEredfidePesHVF60oSNdkoK965waSrK52BEpCncC82W+RgkLnTgfzPxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214685; c=relaxed/simple;
	bh=k7+WfBw3oGV8FTIC77s1dIp28PJjr0djq0QuekIdnm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GISLLpFYBBHj0aoIqWNrYWOyhmcFaRCi/pJ3q7SHhc7dF56fCTtrEsExmg0xvK5Y/F3exIovPBJ/twOXhun4h4N6XN8Div6/4LeyTfim9EYqBUpBZPsaNJRmv7Qcyy3KEJzyfMKjPj/1cKpjUfTjQp/OJWhqn1YJjkZItz5SpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=R5mMysf9; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="R5mMysf9"
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 3E073A0790;
	Mon, 24 Jun 2024 09:37:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Y6kQreBxD76dRTR6BfiM
	RCPns9FvBGOQe5+k0R5VWpw=; b=R5mMysf9Y7dumwGGdMt09GfJbjKnsrfSZtKZ
	nq3e+ylhcmo3ftWjL/AUBKslBMnn1pnTk/hlzSffvtSAtdCoS8ngrdFVAf1AncqN
	1SpJDeXT/5GPipjQFqyb4ovpSaNG+Vq/aq/LL3KV2qYMpF530s8rjR86GJyrA2Kj
	Ufei+RWgSVdXe1z4oU1+wLbf1zakoz2P96YcgnL61iEiO/ZKlrbqVsObIfVPpslP
	Hx1WB7H3Vza4M66mVbE7qOUWVMACJztbZuc5kWVsff0w6SWguywDzZs/SY2UixjE
	ziCdrkRHRZqbaF+ZHVrv3k2jKL8d2lp8iuAeVrZv7ypJlFiKCy242DeCo3XVhhi3
	BbWZn7lxYlwXovauS5E5lsBK2TP0av8G/KliMeIBN3PBOHeaYNhL+8QgXsnKRF+g
	QL3Z0t2XnBdcEwV+YBN3P0B5xcf5kI02BYuIRdceBSUu5OeD5pf4YP8xn+EC50Rs
	THl4ptli8W6Ee+3fQeaRQ9QOL6+KEwNOxmLThbaNe/akZsooe4KU1XtJyQiYL+C9
	QEcDWWnxinSThjBfXJDWRSRQIyZLXe+XiTogRLa+HRwTf8oZGHY+IWLYmIfeZOAP
	xdoJGPW4vurMprLpRlOdxyyo/Xo5Cxhc2DXAqL601RSPXjmu1Flhdy3+AdJKV0wo
	8bm9uHM=
Message-ID: <a55cc932-98b0-43cd-9dfa-ea21a4340bf6@prolan.hu>
Date: Mon, 24 Jun 2024 09:37:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend] git-send-email: Use sanitized address when reading
 mbox body
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
References: <20240621092721.2980939-2-csokas.bence@prolan.hu>
 <xmqqr0cqmck5.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <xmqqr0cqmck5.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A129576C7661

Hi!

On 6/21/24 19:27, Junio C Hamano wrote:
> Hmph, there is this piece of code before the block:
> 
> 			if ($c !~ /.+@.+|<.+>/) {
> 				printf("(body) Ignoring %s from line '%s'\n",
> 					$what, $_) unless $quiet;
> 				next;
> 			}
> 
> This is to reject strings that do not even look like an e-mail
> address, but we called sanitize_address() call on $c way before this
> check.  I wonder if we should move this block way up, even before
> the call to santize_address()?
> 
> That was a relatively unrelated tangent.

Hm, maybe. Should I add this to the patch as well?

> In the same function, there is this snippet about Cc: (I didn't
> check if the same issue is shared with other header fields):

Yes, I've seen that. However, the mbox headers are more likely to 
conform to RFC 2047, or at least `git format-patch` generates correct 
mbox headers. (Before sending the original patch, I was playing around 
with purposefully broken mbox files, and at least Thunderbird seems to 
correctly parse these non-conforming mbox headers in _most_ cases, but 
that's probably just extra caution on Mozilla's side).

> It looks to me that there are many other places that we try to be as
> faithful to the original as possible.  In the same block as the one
> that handles "Cc:" I quoted above, an address on "From:" is also
> sent intact into @cc and addresses on "To:" are handled the same
> way.
> 
> The patch under discussion singles out the addresses on the trailers
> in the message body and treat them differently from others, which I
> am not sure is what we want to do.

I think it is a reasonable assumption that the mbox headers will be 
conforming, whereas the message body is just freeform text and no such 
guarantees exist. But if we want to be paranoid about it, we could try 
and sanitize everything.

Bence

