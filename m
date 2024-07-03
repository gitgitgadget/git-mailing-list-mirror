Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68C187549
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720032791; cv=none; b=hG2fsV/Yzknq5/gLPW7OnS/TSSQhp7UaX2bBdM25hvqJ0G3+fguUEz6GGwMlffeOX3+TTWiYmNLMCHxm392LExe9kTI7K+cPni5H/JKZEP49coAJGb2AIVunwNDxkRCOtkG5PzdkdTrxq4Y1Ti16Sa4tQZhWN6UAS+MhAdTmS3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720032791; c=relaxed/simple;
	bh=Bawwdmx2EqFulHdbDwtUxQuUhbYOeO4XcwZYrJdikGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qe9M4WNtzQuyM2eGAiuLzAYfvSCLDrVA+rHxmpC07PNztCgHns8Pj4YvqU+1QIo4r+JBfrrvfnZWqpVfYPxqwi/fm2H/J7FJk3deNljOck673gpvNAXjR+XRqm7nhSIH9glnwYd5xMG/xRX5r7QsztU/ovfe2nig9YGx9zI5Ztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=xKVxjAOw; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="xKVxjAOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1720032786; x=1720637586; i=antonin@delpeuch.eu;
	bh=UeuRTCxhpcOUE3+dxjjbn2Q289tYDl83LPHDdNFr6qM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=xKVxjAOwn7VzeX8ZrLobex6SBWj2zOfPqFWJ3wyk4A4z8m5LezoscfpgBfHRmVKw
	 wal26C3xHTLYuDoDmB/1GnlUpkgXXhDziCi21YCdMwObd72qU/E6LNCGZ/MkH4Vx0
	 RmrntUvvXBHnietP0k56Xa3/jjSDmOTNMb1oCshdPf+g0T4Dlt0+cINyJGp48OXKH
	 5ZelSqRxMe8BzWhUcOqFP8EWgU1gM0aPH66KH9fIO8LKJVCwH7Ku4VXrcjvev5HEQ
	 m5zGAW4ByI5O1EDCgIQPr3P4Ry1zIUp3TcV6cmNOJq+Dk0PvhcK2+9dX+Mvh85weB
	 kaXZzjzj/zZ7dPaW+A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.21] ([79.246.85.203]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8hMt-1sTBS50kQD-00G3qY; Wed, 03 Jul 2024 20:28:16 +0200
Message-ID: <dd1f768f-a137-428c-8a60-c5e875b66592@delpeuch.eu>
Date: Wed, 3 Jul 2024 20:28:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge-file: warn for implicit 'myers' algorithm
To: Junio C Hamano <gitster@pobox.com>,
 Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1741.git.git.1720016469254.gitgitgadget@gmail.com>
 <xmqqmsmycriv.fsf@gitster.g>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <xmqqmsmycriv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yLhwb7HBDl+S5fBxP+1w+gWy606th55ptCMkEBZD0e7AlrvUzZT
 pRJ6rJaCu6y23Mcds8mUpndiCNmuyF0pJiWqt6oivStKhnGs6OYMZGwbpj3Od3seOwd1nFh
 3euKCEpImSlEWrbXhYLGIv/q0GpR321x9T3UN3WdagAYo0koVdOsBQ/RMp04/agkHd7vqtT
 pCyMPVaCpeUEQPu0WBU5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BncGhTQTobM=;/4TSdsDLZhAZCFLg4H2PsDe5jqv
 k7F90GUBtr8wdCmFSSZFxHdf4O/C52biZkbrraHA2Tu/QBmXxCDvmp1Wh1Ze0JouKPNuTGgwm
 +O3RCRijBC7bGjMG757tJC2SkpWBHN6HIC6uABHFvh4dftsXYnsUgK1IsNE1CiwpNXc1mlyhx
 HRaxour0FqTE7B25uNlNIA+n3RERJG+bJ8hwrEF8/dywLHqprd74rfhgQAT5GlfjCx3dytL4/
 lg5jl3t/csbL4y9buKaxYg1gxIJBiN1D6JmyNwTps9Di4v6srRQZCRBG0oD8va0q3ujjN4D6j
 XmDqcCJodLB1Lkx4Vwfsc6kkcM4sP2jbmY9j2jjNmwRgUm30Wz70kfIW+QkHE6pjJatidSLIp
 iMD4nc5e+zZ1Es/53mN8FbmtHjtOAtiDmkwSdLb5Kl1WLSHqCNheINkzSlTfN35NMMpn9RYcC
 434IMeE+muYykQV0Mu3t1TLQPBk7Em3LZ1Az7tT5vHVts40Jk+8Se3YP5iHZewGWmMyv7WT01
 jfO4JdPu31b27kBAkAzbbPcVxXErzCRAtANn+ToiX8j5d4nfxpic9z9WoEIqv3gZ/fy2GTaIx
 1B7Lw2YaIclok9jVLzMUBU4nBoWFaUxyEpz6JfsC60i8nAJw64ciNLJ9XYH4dVY7GESOSlS+0
 p00CdMmBuTWIJfCviW2EOLIvjyf4d8QYMo0CtD29STmOpJdSJrbnogBjl0cRo+5mxrRPC/hLi
 qhPLW5IbUXXIJ8/p4tc63O6SXkt0vF5POEZfSiBUBEbbCvIrCVeFug=

Hi Junio,

I'm really sorry, I thought the switch of default and migration plan had already been agreed on in our discussion of my earlier patch.
Specifically, you wrote (https://lore.kernel.org/git/xmqq7cmdpbhq.fsf@gitster.g):

    First allow to configure the
    custom algorithm from the command line option (and optionally via a
    configuration variable) and ship it in a release, start giving a
    warning if the using script did not specify the configuration or the
    command line option and used the current default and ship it in the
    next release, wait for a few releases and then finally flip the
    default, or something like that.

So I thought it would be helpful to follow-up with a patch that implements the approach you outlined.
But I totally understand that it might be worth discussing this more.
Actually, I do agree with your assessment that this warning is not great UX.

I think relying on `diff.algorithm` is a natural idea, but it might also be confusing for users.
At least to me, the name `diff.algorithm` suggests that it's the algorithm used for "git diff",
but I might not realize that it also influences how my merges are done.
It's probably common to want different algorithms for those situations as they require different speed and accuracy trade-offs.

In any case, I'm happy to withdraw this patch. Would it be helpful if I start a new thread on the mailing list, independently from this patch, to discuss if and how the default should be switched?

Best,
Antonin

