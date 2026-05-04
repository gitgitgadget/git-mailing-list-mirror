Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0DD19CC0C
	for <git@vger.kernel.org>; Mon,  4 May 2026 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926575; cv=none; b=BLYcbRmpFq9Tlk0bOUeve2oOE5RgRmx2hBLCGJuGCq1Ffsutjp9fFNW/rwPi6dbsx+YcSTRvkSS0DOXApdhfqNC+KRUJhjDqCgk4HJ+p2AdSAwLuJ9IyxqxZGe1NYgCqZc9H9+rhb8wGPB5Cldvyk51nvVH9XFxkiEy1q8X43kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926575; c=relaxed/simple;
	bh=lnWE8KEqdoOQsRR6QX7LVQR3+bCx2rUpRTd1IzcUQO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWab7yj5/C5cJAA2esL35lA2xhDHaROlyjih3szE7DBoGQGLnx3CO8oI1IL4dxBy6oHw4KxfI9QtMkFyLyaCJxTHGWNA41wDJjXZOg6uIWx0ZmvccRN3xNi6fHeLR3yOKr4D965lHfnwanwrG7yqkD5PWiHx7kjIK2qVfdkAKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Pv7VPzCo; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Pv7VPzCo"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id JzrxwB5z1WlIOJzrzwQeyY; Mon, 04 May 2026 21:26:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1777926383; bh=CCTN9xrLuBxFz0FentetCL3Gq4+Vz3aUdayzApQSLDA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Pv7VPzCoi566p1DSdSJDQ+omZqv/euC82DhSEVwqAHTJSnGiP4D5AnDiMPU0bY7AQ
	 fZL2NC4B1j8diD+cTCNypp5DcKuL1fpX6MZ3fTC6lnnge0alaf0fy35CxMINOXX6Q7
	 wyC4hDMAGVz6x55CAUIxZLvSXZDKAOMhTxiQsYFVftyBnIQ5QtikXxoW2rnnAx4LeA
	 qrvPeC0vIKSvepA2qnF2hoA2oz3eqBzyLqe5hmu1+pcBG2EalZWKCc4RPT+9UAo3m4
	 IeJLUUE6fX7YzdvBted9pbGHauk8pvna6o/50iSUhmSdZH2dKLvYawFAWjSk1SH3PX
	 8XhtDiwMeSDXA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=atcRCjZV c=1 sm=1 tr=0 ts=69f900ef
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=pko6VkqtiMf1LGvLsy0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <b04e98e3-0840-456d-a627-351f2378c037@ramsayjones.plus.com>
Date: Mon, 4 May 2026 21:26:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] name-rev: fix an 'may be used uninitialized' error
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 GIT Mailing-list <git@vger.kernel.org>
References: <e74a8fd8-0617-46a8-8bef-a454d51a99c1@ramsayjones.plus.com>
 <xmqqv7d4ou3m.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqv7d4ou3m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGse6yfUR0ZFJUnT0oqfAycIGmuVFhFKaqSwgBc/CeLzSospcj3QvuqDY+T8sNBe3EtCfn4Arl1irJnyubQCM7LoQbNsOG/c7PCpy9mVP03v4pfWaMka
 S8v6BI9fzAHJHHAzvaZUWpVLrnPM06xE14KGhiqPeg3RTI5sgUSmttdfRO6z3i+zOEzIu7k4T6Eg25vFtalE+PLOoGL8XPkHGXQ=



On 04/05/2026 2:13 am, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Today's seen branch fails to build (with DEVELOPER=1), like so:
>>
>>       CC builtin/name-rev.o
>>   builtin/name-rev.c: In function ‘cmd_format_rev’:
>>   builtin/name-rev.c:885:28: error: ‘commit’ may be used uninitialized [-Werror=maybe-uninitialized]
>>     885 |                         if (!commit) {
>>         |                            ^
>>   builtin/name-rev.c:867:40: note: ‘commit’ was declared here
>>     867 |                         struct commit *commit;
>>         |                                        ^~~~~~
>>   cc1: all warnings being treated as errors
>>   make: *** [Makefile:2932: builtin/name-rev.o] Error 1
>> ...
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index b941e93834..5b7f7a00e5 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -882,6 +882,8 @@ int cmd_format_rev(int argc,
>>  			peeled = deref_tag(the_repository, object, scratch_buf.buf, 0);
>>  			if (peeled && peeled->type == OBJ_COMMIT)
>>  				commit = (struct commit *)peeled;
>> +			else
>> +				commit = NULL;
>>  			if (!commit) {
>>  				fprintf(stderr, "Could not get commit for %s. Skipping.\n",
>>  					*argv);
> 
> Why not

Heh, you noticed that I spent all of a few seconds writing this patch, just to get
the branch to build, as I was in a rush to go out. I wasn't quick enough anyway, so
I didn't send it until the next day. But, as I said in the patch, I wasn't pushing
this patch as _the_ fix ...

> 
> 			if (peeled && peeled->type == OBJ_COMMIT) {
> 				commit = (struct commit *)peeled;
> 			} else {
> 				fprintf(stderr, "... skipping ...");
> 				continue;
> 			}
> 
> 			get_format_rev(commit, &format_pp, &scratch);
> 
> or even
> 
> 			if (!peeled || peeled->type != OBJ_COMMIT) {
> 				fprintf(stderr, "... skipping ...");
> 				continue;
> 			}
> 
> 			get_format_rev((struct commit *)peeled->type,
> 					&format_pp, &scratch);
> 
> and dropping the variable "struct commit *commit" altogether?

Having now spent some time (well at least 30 seconds :) ) looking at the
surrounding code, then your final suggestion looks really good to me! ;)

However, these 'maybe-uninitialized' errors (historically have been) somewhat
sensitive to the level of optimization used in the compilation and even algo
used by the compiler changing frequently from one version to the next ...
So, I wasn't sure if Kristoffer was actually seeing the error or had the
DEVELOPER variable set (which is why I mentioned it in passing!).

Thanks!

ATB,
Ramsay Jones


