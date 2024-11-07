Received: from 6.mo560.mail-out.ovh.net (6.mo560.mail-out.ovh.net [87.98.165.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E611EE028
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.165.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975982; cv=none; b=i+2fjOz6sh5i9OVNqjl6od+1lYXX6CPfY7PcL0I7E4dmNF5xtL9eWzR+DZNh53NWgA0J0COyOaEFZiOfwofUA5hWgua4LmPh+yEoybtUCGpd0ZRV1N47QFfYjDuMFVNflh9AZKfWforjKfOyr4TSMDkgB5H8lj0Euh+dHZltZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975982; c=relaxed/simple;
	bh=C0+SP+UPcMIhCmLTMyiIvNaSAG3ep/TpdZF0lpHWlAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWU+JXCJVZMa7TfaW9Af4Tst3gX5uWX3FUij4MyCpDCKAxnjRC/4TDYT7jJKFQXc7/RfJceRgKQQExs4lIR2jDfYKOkeGe2eiOJMSftDHo+SMQ2zYMhAr9IPd5AkgrLWaAHObhzvyAB3BPyT4uNwidIoDOpotT8zkWydItULPP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maurel.me; spf=pass smtp.mailfrom=maurel.me; dkim=pass (2048-bit key) header.d=maurel.me header.i=@maurel.me header.b=AeIpmia3; arc=none smtp.client-ip=87.98.165.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maurel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maurel.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maurel.me header.i=@maurel.me header.b="AeIpmia3"
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.139.183])
	by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4XkdhQ0fhQz1gjj
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 10:33:26 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-phnrm (unknown [10.110.168.164])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E87FA1FEB4;
	Thu,  7 Nov 2024 10:33:24 +0000 (UTC)
Received: from maurel.me ([37.59.142.104])
	by ghost-submission-5b5ff79f4f-phnrm with ESMTPSA
	id gWk9LnSXLGeYcgAAYioIkg
	(envelope-from <julien@maurel.me>); Thu, 07 Nov 2024 10:33:24 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-104R0056fbfdbdd-dca2-4c3d-a8dc-90b56485803c,
                    AF239C3E440A9D24B6C1690AE6D86BCCB8FC0C00) smtp.auth=julien@maurel.me
X-OVh-ClientIp:176.138.87.53
Message-ID: <a129e967-efba-48ba-b5a0-1abbb0af5c9d@maurel.me>
Date: Thu, 7 Nov 2024 11:32:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about merge & cherry pick
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
References: <711a0faa-6d82-48b6-819d-9ddbeda03f6a@maurel.me>
 <eb367098-0c88-4bc6-b824-32ee6e6d273e@kdbg.org>
Content-Language: en-US
From: Julien Maurel <julien@maurel.me>
In-Reply-To: <eb367098-0c88-4bc6-b824-32ee6e6d273e@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10913629276062462715
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefluhhlihgvnhcuofgruhhrvghluceojhhulhhivghnsehmrghurhgvlhdrmhgvqeenucggtffrrghtthgvrhhnpeehgfejfeeviedvtddvveekgfevffehhfejjeevteeggeeujeeuheeihfekveehudenucfkphepuddvjedrtddrtddruddpudejiedrudefkedrkeejrdehfedpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepjhhulhhivghnsehmrghurhgvlhdrmhgvpdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitdgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=d3z3YmaATb2fEkz/svp1Slhq8AFq9l9JYUR8z1I9bXU=;
 c=relaxed/relaxed; d=maurel.me; h=From; s=ovhmo4520387-selector1;
 t=1730975606; v=1;
 b=AeIpmia3+tYYakKX2eRtZtSq80/5Cy+uC7CCkk1vb5u2sqX7BqcRKYMrswnFGSesLKbDJQDL
 UUG+Ziuf3DDDFHjPF5+160nH0h9CeIulfsCHr8bK0YucrAdHarpXdwVRTonGI/Amp2pGL8EW2PK
 gO6DXha2Rr3l+Oq+v7rKs22M6ntunHX0aHU/6ELVCsSzBL+4YBr4k8si4/7G2GRyiYWPftFydR7
 mDMgn9nIenEYoxI0WfHL2/Axq/afPKU6Y9NcIQhDyAiFvkJe0plYUukqKZqtUeSCuKxT8WqV1I3
 6YEeqHrKO3bNbcqMxBmtI1WWHcd+tK8ZqU5VN1rbL7xng==

Ok, I didn't have this vision about how merge is apply, thanks.
There is no option to merge by considering each commit individually ?
Rebase do it but not applicable in my case :)
Thanks.

Le 07/11/2024 à 07:37, Johannes Sixt a écrit :
> Am 06.11.24 um 21:24 schrieb Julien Maurel:
>>  From my point of view, after these operations, content on branch master
>> and dev should be same with "zZz" on second line and "eDe" on last one.
>> But it's not the case on second line...
> The behavior that you observe is as intended and not a bug.
>
> You have this (consider each letter on its own line):
>
>            A Z Q E       initial commit
>           /       \
>       A Y Q E      |     dev: Z -> Y
>          |         |
>          |     A Y Q E   master: cherry-pick Z -> Y
>          |         |
>       A Z Q D      |     dev: revert Y -> Z and change E -> D
>           \        /
>            A Y Q D       merge
>
> Your expectation that the merge result is "A Z Q D" is wrong. Consider
> what happened on the dev branch (left) since the branches diverged:
> Since the change from Z to Y was reverted to Z, the only change that the
> dev side contributes to the merge is that of E to D. The master side, on
> the other hand, contributes the change of Z to Y. So the total of the
> merge must be Z to Y from the master side and E to D from the dev side,
> and that is what you get.
>
> A merge does not consider the individual changes on the branches, but
> only the differences since the merge base. For the merge operation, the
> change from Z to Y never happened on the dev side. The reversal of Y to
> Z is not visible for the merge and cannot contribute to the result.
>
> -- Hannes
>

