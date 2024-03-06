Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8013BAFC
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749214; cv=none; b=h0Nn4sf8lmJcal4X8Wr0tl2cwN6eDyHCQ3599qxmpMEepu5hrxLgMVj1ALHbRXu2wnkwqe7YKWW9/82VMs1XqdptrBJxUU/VIGk8drv/AGnGrjUZtCzAU5GaKa8Ba+/cFCKT4z9zYMOdNQHAPCAtDT1Dycb3tpppU2XrQ3TQ2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749214; c=relaxed/simple;
	bh=/RFpH7dCOZIgnAGvEcDZ3rdi4+c/Tv383F43Muwk/nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLHlcNxxw1nnXFQKOqrxDeUoC134B9XJppcUdz51wpxgYdx94VJvVGb3vekhBbg7sPRkas53D71Q1JoD1gYUVX9VaiynnRjeLzgwdz/FH6qK7pgo2jIKpEvNWKwNjRcmW2oHGiKcm4XLvsgpG214VgXkH+/ZINFDbK7N4XHy8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id 62D72CA1266;
	Wed,  6 Mar 2024 13:10:42 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:5828:3c94:9fae:77dc] (unknown [IPv6:2600:1700:840:e768:5828:3c94:9fae:77dc])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 1E71FCC83B6;
	Wed,  6 Mar 2024 13:10:42 -0500 (EST)
Message-ID: <feb7725d-877b-f738-5914-84e5cf26aa80@jeffhostetler.com>
Date: Wed, 6 Mar 2024 13:10:41 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 00/14] FSMonitor edge cases on case-insensitive file
 systems
To: Patrick Steinhardt <ps@pks.im>,
 Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Torsten_B=c3=b6gershausen?=
 <tboegi@web.de>, Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
 <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
 <ZehofMaSZyUq8S1N@tanuki>
Content-Language: en-US
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <ZehofMaSZyUq8S1N@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 3/6/24 7:58 AM, Patrick Steinhardt wrote:
> On Mon, Feb 26, 2024 at 09:39:11PM +0000, Jeff Hostetler via GitGitGadget wrote:
>> Here is version 3. I think I have addressed the remaining comments.
>>
>> I cleaned up the test code to use the test_expect_failure at the beginning
>> and squashed in the test_expect_success version of tests into the final
>> commit in the series.
>>
>> I moved the invalidate_ce_fsm() commit earlier in the series, so that the
>> final commit actually uses all of the up-to-this-point changes to fix the
>> problem.
>>
>> I converted a few "should not happens" to BUG()s.
>>
>> Thanks to everyone for their time and attention reviewing this. Jeff
> 
> I gave this whole patch series a read and didn't much to complain about.
> There are a couple of nits, but none of them really require a reroll in
> my opinion.
> 
> Thanks!
> 
> Patrick

Thanks!!!
Jeff
