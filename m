Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081715B685
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707674369; cv=none; b=g1L45vSfKquMgwd0y3dW4khmOrTXLVFE+NVRXoIlFHcTUJIxBt3P5CW19v4yrkkVlT5uSN32FC8CTYSRCMuDpgJMBssNs/HmfEwizVz8P9DIpK3eeb3pZJW9oSbn/AxyLYKO4D4ss7+/fxtLCYa02S+MMiRQ/OjDiYQi8WXLN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707674369; c=relaxed/simple;
	bh=Q5HxvQYsZAdesbAMa/dBuJ4hM/onvzyacX3TUbKR5jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHK0XD6QScMKyaCNvRRnF5Icw5Kl6gEioW6YnQVqhgYw6sXhKI7GoS2OPkuc4yh5hGqVQNRIbXRrCc4E858ngMtZc26yybww6YBGIXOKSc69gWGGx2CQRS9mSw+D80xAJ1E+2fhn3Sv//f1SPDEhldZBq0I/6f3t9xhwzo/qk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4TXwMK1bbwz5tlC;
	Sun, 11 Feb 2024 18:59:09 +0100 (CET)
Message-ID: <529c7b42-c606-408e-b6a3-fe189c28db9b@kdbg.org>
Date: Sun, 11 Feb 2024 18:59:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
Content-Language: en-US
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Elijah Newren <newren@gmail.com>, Michael Lohmann
 <mial.lohmann@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Patrick Steinhardt <ps@pks.im>, Michael Lohmann <mi.al.lohmann@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
 <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
 <2cf557e9-bf48-4bf3-be24-c1eeaa887418@kdbg.org>
 <1c258037-cb08-5fbc-d473-743a60cd8eab@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <1c258037-cb08-5fbc-d473-743a60cd8eab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 11.02.24 um 17:43 schrieb Philippe Blain:
> Hi Johannes,
> 
> Le 2024-02-11 à 03:34, Johannes Sixt a écrit :
> 
>>> Adjust the documentation of this option accordingly.
>>>
>>> Co-authored-by: Philippe Blain <levraiphilippeblain@gmail.com>
>>> Co-authored-by: Johannes Sixt <j6t@kdbg.org>
>>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>>> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
>>> [jc: tweaked in j6t's precedence fix that tries REBASE_HEAD last]
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>
>> Signed-off-by trailers should occur in temporal order. Therefore, when
>> you pick up a commit and resend it, you should keep existing
>> Signed-off-by and add yours last.
> 
> Thank you, I did not know that. I guess Junio should be kept last though ?
> Or maybe  I should remove Junio's sign-off if I send a new version of the 
> patch ?

You should *not* remove Junio's Signed-off-by, because the patch went
through his hands before you picked it up. Then you add your own
sign-off below. Later, Junio will sign it off again.

> I'll resend with corrected order.
> 
> By the way, Michael put you as co-author but did not add your signed-off-by...

This is fine and sufficient. Micheal used some of my ideas, but I didn't
take part in the patch submission process.

-- Hannes

