Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB56934E745
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820056; cv=none; b=cToHAdh64fiQ9e/N8G7z4ZOtkR2GBD7p6D3Ipg9ftDv5DvLNhzl/CwRqHYMstrzQvvYn9fElYADJvp8GMpxZNcu8v0lOIAy2ce8nRVXquhdc31RZy9BMpgM+kS5advn/qBJIAPJRGZlDzu/iAvmz8jQuQKHYJc5dA/EptAJaEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820056; c=relaxed/simple;
	bh=YTJ8rK9wYC4eWq4t5hNG4sIXq7J+4IeJc/fAGml42Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLtedxmm/2miJ0kvj3pdElS2bU8UwEye7FBoEtbH10hHBfGPvdvHaOa2fXw9FcHnb+muGcDEVAP0er+ck3cLq26l/nOJJVdv3xEN7xQVAmqEB16/Ohv469pG3ttaQh8VEtjeErvCgN0lehnBXrvaWw9vb2LkKHJi+NfZ2u6xb7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Ob4S3qMC; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Ob4S3qMC"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id yZTmvpOOxWlIOyZTnvh32G; Fri, 06 Mar 2026 18:00:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1772820051; bh=zNqv31ECLu11kCUK45oDtILh/t6w3fOIvpk86IesQIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ob4S3qMC9RBuMM8dXlhubQncgvJfPZDdZsLBN+N5OWKdvJPz41THNegv6Wmr34SqW
	 0siircn4acYDbPnfm6r1I5PnHGcTRZW8I7BJULCLLpqq3qj/hiOapVs+dsdgC+FLLZ
	 tGJER5RSujoUdhfBRiFgB4juGxr6fpHuFafLhQYmzImqyWygRK+64BMypYU+6ggEu5
	 nLYljqf9yep567BB8LF9hoH4ffYYI9O5NVid2ZIqpw+AIin2NvfrV9pLX0srjn7TlL
	 bhEYgpdCuUB7PYJjUla8a+yT/pNxzO1m3ZzsqrdnCn36c6AzrI7pzvWJjb6MDY8kyR
	 2eC1cxbAKIZWg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=atcRCjZV c=1 sm=1 tr=0 ts=69ab1653
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EKwWsC6efcy-cWEmJCQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <d5a22245-662b-4caa-9ed6-0e981f9e0d37@ramsayjones.plus.com>
Date: Fri, 6 Mar 2026 18:00:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/4] meson: turn on NO_MMAP when building with LSan
To: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org
References: <20260305230315.GA2354983@coredump.intra.peff.net>
 <20260305231305.GD2901305@coredump.intra.peff.net>
 <796110ee-d795-4445-9d82-7026370a88cf@intel.com>
 <20260306162513.GB3483423@coredump.intra.peff.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20260306162513.GB3483423@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfONjWSScHXDZ79If8TaHnQKIQirePW740NDCXVNcIyAjk04sFtZHFrgyzzSzBVu1hUegSEiAxEwCQziYo5krFN0K580sNPdsv7yeF3x/uz1BVcQ7/w/1
 f9YZOW+O2iswGtidEWtK3WAfUGojI95S2e14J7j8aOmO14l4/Clb1gBgorvhmUWoZ1ZLCpl6PQpCx8RtZISs0ws9VkkGw0H1uUs=



On 06/03/2026 4:25 pm, Jeff King wrote:
> On Fri, Mar 06, 2026 at 01:17:24AM -0800, Jacob Keller wrote:
> 
[snip]

>> Also I think this might be somewhat less flexible than Make since you
>> can't forcibly enable mmap even with sanitizers enabled. I suppose thats
>> not a big deal since enabling sanitizers already has a high cost.
> 
> I don't pay much attention to the meson support, but yeah, it looks like
> there's no equivalent to tweak the NO_MMAP knob independently there. I
> doubt anybody is clamoring for it.

Ignoring old Cygwin, IRIX, IRIX64, Minix, Nonstop and OS/390 set NO_MMAP
in the config.mak.uname file. I suspect none of them are using meson to
build git, so it shouldn't be an issue. (although I don't quite know why
I suspect that!).

[NOTE that NO_MMAP is not set in GIT-BUILD-OPTIONS, so ...]

ATB,
Ramsay Jones


