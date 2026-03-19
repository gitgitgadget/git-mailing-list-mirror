Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8B39C003
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904072; cv=none; b=T16xmQ/hgMAydDplzRqUJXVFvayVngzARs9M/V1PHI5o2dW+MiI1sdYEn9ITZPXSM1WWcANcbKm4VZSMbkNAAv7hjnXkSOaywWIVhiNAr7VT4btvNO5inwU3ffAEvFpDNjNatv4BsUBo6CdaNubfwFKa25gL9itYArWZ/tmuwUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904072; c=relaxed/simple;
	bh=XHDEWGLbISJUB5bkmhMKucR1BLeiPhYHGBLFrv8Vwfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shZA8X/xlKAMfso7GVGAsGH81v7FNul9GGMrdYNM2gWoNN7nfLWVU6w+pjZJTHAf6CuscQAiGZkMSfUQkP/ACarTRvBbItV/u5GzHoDNafKQtT8v6B1NFiyGs7VCwBXXne2jyIUKORwHtp6IyA4LAVTmMziDKTamUNX2EmXX71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4fbxbg4Wf1z7QZ0Q
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 08:07:43 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4fbxbT4b62zRpX7;
	Thu, 19 Mar 2026 08:07:33 +0100 (CET)
Message-ID: <42b146ed-1c53-4b4b-9ead-99d924bec501@kdbg.org>
Date: Thu, 19 Mar 2026 08:07:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC RFC PATCH v2] graph: add --max-columns option to limit
 displayed columns
To: Pablo <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com,
 jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com,
 chandrapratap3519@gmail.com, Junio C Hamano <gitster@pobox.com>
References: <20260316133426.117684-1-pabloosabaterr@gmail.com>
 <20260317220929.120746-1-pabloosabaterr@gmail.com>
 <xmqqzf45gm2q.fsf@gitster.g>
 <CAN5EUNT7co=ucbBRykXdLJDUdewvoh+cMVbbOOUuRTrv7j2u5A@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAN5EUNT7co=ucbBRykXdLJDUdewvoh+cMVbbOOUuRTrv7j2u5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 18.03.26 um 19:20 schrieb Pablo:
> Junio C Hamano (<gitster@pobox.com>) writes:>> If the option is named clearly to be related to the "--graph"
>> feature, another way to go is to make it imply "--graph".  If the
>> user says "I want to limit the graph output to consume no more than
>> 10 leftmost columns", it is clear that the user expects the graph to
>> be shown.
> 
> I'll make the name clearer about what it does and less selfish. I like
> the idea about --graph-limit-lanes to imply --graph directly and not
> force it to be explicit.
Don't let this option imply --graph. It specifies a parameter that could
also reasonably be specified via a configuration. But we don't want that
the existence of the hypothetical configuration implies --graph.

How about --edge-limit or --lane-limit?

-- Hannes

