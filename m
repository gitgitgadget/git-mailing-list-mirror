Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0121158A18
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725717079; cv=none; b=rUd6kxS4u3dxeYJ/9ujm+ZqrFbqrOiIdHsTI1H6pi8iDxFkQw+64djvigCQvbeg353rPA38cjQ4MOA7w0TGGiQJ0LYSbD0KU6v3NL8RjFWVgKx+XtlW3llas3cRv3M1V0iYeraCXaBmQfOIXgDIH38XjOsk3nmsYsvXkaHBnoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725717079; c=relaxed/simple;
	bh=dDRUqAFMLqt/lCe/qe2WVc3KgtsPUVggnqgi3W+xbPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKfFE0mykogpKVa59j2NChxnks5HXlCZto40Ga+DrHSER3W4wC1blSSvH5cTzrZUZXpZT3SnOAc60dNLgY4i3Xc+DWuYDnZB0J71BnL1EdxJvCNxC41G7dzLkcMNKvr7I1oj1roQ+cGERpkNpv05rcTuC4gQMTFprxrmmYKV+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=edXOwb1P; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="edXOwb1P"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id mvnJsftnyy9pXmvnKsXBxw; Sat, 07 Sep 2024 14:48:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1725716887; bh=a+vL7te8lmugbniqjFszom53HVV3mPCpEhLTKiT6aeI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=edXOwb1P2ay6C7b3xWLQi35IrGosWR9UYZt8DkYMEmbDIYz366CoKO/wMtbkzDHWy
	 FXpIt9AKfSuaq6sGDPs3MEpapfyn6CEkewIc72wSHdog7K//Ex97Srmk2sYILCHH+O
	 nygohfA129pc51AeJwHsFTAtnbDZ+G45EWLhSruooIF5wpVKVkMV7P6sLOOTJSdbir
	 dXYkKZs0AEWHgtZzUoupYFGY14lDz8QX0O2Q1/kqsQoUTyfKrvEPRLmjm3cQSOx0RG
	 5b2q/cJ9xRGkCNgYkCz2M7LfRXoyKlBgTknSQDn/tgm0V5EaZRk9zUK6YK9PX5N71A
	 3ENLMMQQuzKFw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JYgfrlKV c=1 sm=1 tr=0 ts=66dc5997
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=NQqX2kYxKnmtpGU3G3QA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <4e18ec3b-c536-4bc3-9883-77e35686f5d3@ramsayjones.plus.com>
Date: Sat, 7 Sep 2024 14:48:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] config.mak.uname: add HAVE_DEV_TTY to cygwin config
 section
To: Jeff King <peff@peff.net>
Cc: GIT Mailing-list <git@vger.kernel.org>, Adam Dinwoodie <git@dinwoodie.org>
References: <a59f53af-58f7-42f5-aefb-50a4d9f344c4@ramsayjones.plus.com>
 <20240905104331.GD2556395@coredump.intra.peff.net>
 <c18fc95a-4dec-4e7b-8ec3-ba9747e9c464@ramsayjones.plus.com>
 <20240907062112.GA2585439@coredump.intra.peff.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20240907062112.GA2585439@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKNHYaxY/FzH++bkGsWs5EeRdKs6+mVf7hCntPH6cIDWDzKIS2h9QVRv+06RupgOSNIsncGbk8HlooqJ+Uh92JimIif8j2y1KuCFoeEsMUR+lpxuLzfq
 Oiu9rceLdLCtIFQAVWjCw0rHVKrRRS6csYNhciRwCBMbuVuA53N6HOFdoObkCFOWWIDXDjnvbjyGDZ0mo+KqDyMsb2Y61Q/kZnw=



On 07/09/2024 07:21, Jeff King wrote:
> On Sat, Sep 07, 2024 at 12:53:11AM +0100, Ramsay Jones wrote:
> 
>>> Certainly doesn't hurt to test the single-key mode of "add -p", etc,
>>> though.
>>
>> Yeah, I still need to check the 'other uses' out. Hmm, I have never
>> used 'add -p' (never felt the need), so I guess I will have to read
>> up on how to use it ...
> 
> Try:
> 
>   git init
>   echo foo >file
>   git add file
>   echo bar >file
>   git -c interactive.singleKey=true add -p
> 
> Hitting 'y' or 'n' should immediately be accepted (and exit the program
> either with the hunk staged or not), whereas I suspect it would not
> without HAVE_DEV_TTY.

Oh, that is much better! Everything works exactly as described and is
a much better user experience than:

    "warning: reading single keystrokes not supported ..."

:)

Looking good.

Thanks.

ATB,
Ramsay Jones

