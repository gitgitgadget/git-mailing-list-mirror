Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F5328DB
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725606216; cv=none; b=YoPB8WTzDj0jX6usxpE8N8AzdIRt95G3uFGOUffp7/+ZRq2nj5Hvhpd3DP4wBlsAy2T38FVIDWvVy27NhYPKwkqLuXFGBwhkeek9qUmhv8hn1psk4BGQwVDxYiTiYdp5iYRUGv+2FUH09GJ46oHEh1hHPdFZNjYoBKk3lv53KK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725606216; c=relaxed/simple;
	bh=4aYNYnx5wggj28UuYUoEPlzhYukAKb3c12lQL6Vd6Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=M7j3190rKj+USkfpL/64viTzufFCU4Tsy7wtzOvMHFVM0FEkcV/ULaiBn6Q2Hjmgi6JLDeNF1DhWhukpa2r7K6gxCoUjX9IQsyJLrl6h9Ji8qUp7YxJL+Tn5Mc4UUWKRp28hEMQsTAorQzr/9/CLUXcxpDY6ZYVX79qTgtoecxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4X0Ryj3VZ2zRnmT;
	Fri,  6 Sep 2024 09:03:24 +0200 (CEST)
Message-ID: <39f85eac-c6af-444a-a514-ad7172748350@kdbg.org>
Date: Fri, 6 Sep 2024 09:03:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How do git recognize conflicts?
To: KwonHyun Kim <kwonhyun.kim@gmail.com>
References: <CADLV-7K-D8ydFfeojv7EuhxBqKWsVYLofXJji+Y5rUTA8JEQ7w@mail.gmail.com>
 <cbc0019a-682a-4cec-8a06-24b12060a692@kdbg.org>
 <CADLV-7K7uumH+ikT6B2H39XR-eX21xBzUSNbeyVv2wM2q1e=QQ@mail.gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <CADLV-7K7uumH+ikT6B2H39XR-eX21xBzUSNbeyVv2wM2q1e=QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please use "Reply to all" on this mailing list and please do not top-post.

Am 06.09.24 um 07:09 schrieb KwonHyun Kim:
>   Thank you for the answer,
> 
>   Is there any other exceptions from line-by-line change?
> 
>   Can I ask you of any reference?

Another "exception" would be a modify-delete conflict, i.e., where one
side modifies the file and the other deletes it.

Apart from that, you would have to dig into the source code.

-- Hannes

> 
> -- KwH Kim
> 
> 2024년 9월 6일 (금) 오전 1:39, Johannes Sixt <j6t@kdbg.org>님이 작성:
> 
>>
>> Am 05.09.24 um 16:10 schrieb KwonHyun Kim:
>>>  Hi, there.
>>>
>>>  At first, I thought it's determined by line.
>>>
>>>  But as I experimented, it does not look so.
>>>
>>>  Here's what I experimented
>>>
>>>  merge-base ====
>>>
>>>  hi all
>>>
>>>  branch BrA ===
>>>
>>>  hi everyone
>>>
>>>  branch BrB ===
>>>
>>>  hi all
>>>  good to see you
>>>
>>>  when I merge BrB from BrA, I get conflicts.
>>>
>>>  but the first line is only changed in BrA,
>>>  and BrB added a line so there is no reason to have a conflict...
>>>  that's what i think
>>
>> If the changes in the two branches are in adjacent lines, then that is
>> considered a conflict as well.
>>
>> -- Hannes
>>

