Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81514F134
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428772; cv=none; b=j978hqQ/GP67rRiux24SELV+CxhLtzTdJs+ic772BVW31vxh7x4ToFHlqtncssm27SoHxXJ6G9Ytucs4Lmi/jI4094PoWDx37589rX+q4z2Oaak1d6KQywVaTnKbVt3GE08F5Nqv5rI8M4xO1k2+dA3dyiGOZ2AcXJVEWBC4RTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428772; c=relaxed/simple;
	bh=7sDJXjvCQZaTNOwdwDHHS2G3fIf93uZmKwZ9cN1aKiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwUyuayZhSCk8Bfl0Pa9pc5UD6UIrukR8TR39Rk+1qN/tv1Hwv73v7RPHTQJsA2VDxh9JPZT1MGV7er45sYNABqPxBe/2LTi9kDu5Lp9PYKhL1/oimR2M/LFQW7zdaUOkTQWhyWu9Tz2zBkmM2ofx7jGg2q3FJdRchC2eAYA7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=q+NnmS1Y; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="q+NnmS1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719428755; x=1720033555; i=l.s.r@web.de;
	bh=eTmarDRcAigyg6Dtg0hxNu1BuLqCmZb9zCZE9rPMGYM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q+NnmS1YLFdp6T/usvM79RJjT6qtTCIkDnfkWHFzZ0F3b0aV/vBhDk0GcOqr7ro4
	 JD+dup5H6tWFzYmExuP2+eNK0uDUG2BZVJZuh5LNdREW7QTWOSBuPNanTARXULjGj
	 CcUZYrRrg/Cbzw5TxBM8l8pK41jSKaf3WfvE5JsfRPXOEaDDFjnHvzDSgAJipMeoz
	 TXd6+Cm6XQuXEqQnK/lH2O0dkmm60yYUecWaot40tUx0BPI/wb574NxMI2MvZOmor
	 TaqpW0Cg5M+6NoLUPVHdLXUw0wmDp9cLy7AbZDAZkmDGMtFAuNgu6uFQc214LAJG0
	 WoR/emPjNDFqS+FN7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmq2-1s8m3h2mxy-0085Z0; Wed, 26
 Jun 2024 21:05:55 +0200
Message-ID: <d1842d42-6104-49f0-99b6-fc9095a61b6a@web.de>
Date: Wed, 26 Jun 2024 21:05:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] archive: document that --add-virtual-file takes full path
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Tom Scogland <scogland1@llnl.gov>,
 Tom Scogland via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
 <pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
 <bc3711a7-37d5-46bc-979e-83bd0b2cf900@web.de>
 <95B94723-BCBF-48B4-A02C-A5C61FB060DA@llnl.gov>
 <01b21870-b37e-47fe-9bd7-225499ae5eaf@web.de> <xmqqh6dvflea.fsf@gitster.g>
 <xmqq5xubfjuu.fsf_-_@gitster.g> <xmqq8qys7iex.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq8qys7iex.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gdRvdr3lZcFmLEq8Akd1wgh0W9I4/h4iA+riLbxvc0vhr8gVN2N
 PWkS8iYcpPeEU6aCNycKoTWHG9Gfh2wdxLRAysAdw2io3jx7Px9ErAtoM+B34gz6hdM6gOP
 5+iVsDzFVHnyy/QACdsJW7GL3BWYu/3iTsFpcEas1GIS6qqu+jFcbgo5Iq1nK26nnEVmu1p
 ikagMbtxp7wSwC/2zftdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lSgcjBuyiIA=;5P7ZDTPNEcFff4RGXNB3TI1/tAX
 Sp8dSnruyDMKCSHXFKTdGaYOhsRnjqztm6v7Dbq5UkkWbLKjDrr1HgaGIa8QZj5vklk/MWrud
 t2ifQ9GtdlxN4/Tr1nPySrAqHpUsCuU+c7SaxIetRLPAhWWK6xJ6Kbt4egYQCHbHLl5U96b4R
 XqUCcPGV12VnlbXSEsDMM6LrIMvCHEvKDXHskPbtcofeYt1moOXYNCGL4gQdqbV4QQi8/bV/j
 MnJCnsZjP84BdL3RmD0/nLVpVslVN4vaCgo1pX3p5q/aosY/PEwiSjB+/Y8j+SgkOMaiBZzkb
 WdyTMO1JNqGE4sv/tsv6VhJ44xHgfiZ7loGv5M+qqzihLK+EOBy+s1BSZZllCOKQ1FkjBCijF
 v3ZAd065RId3YX/UDojSbINxTIiuQCJyrSTDhBFJPKajjap8zNR1CVyNEEcEVtrA9gU+AyeRC
 rJ0PIsbQYILv5V/BSORPVZ4e/s2+bY0ueCyXNrCBcfrEHoJaToHV7ee7/2NTptSVOjgzwtubk
 9Y7lq6t6nQ0sd0PYkCrCQM0Qy28yg2s7ftWw4mS+XYOR7QsU+98dN7/J8YpWoJYuvhXCU+3os
 I6+gwRxnq8anDyTj5FopEUUsW7BhaTqf36Nr8HhMeImclcRZAyGD8PmRXRW7OD8E99lAsAHOe
 PfFNR765UQgFzjpEEnznbbgk+Jq4aY9Np8uEGsyqznYRJPLa5job7DCWXxr6dN1swWwsGT3+X
 AagsGooQmaYF5IRb/dLudZKSze8hauFIjWTEhm2fxTAPz8vueEsuLyGAaml0YOhuBDo3EzRrD
 3US0f6TjPbgKCqD3xpZtk0GXaApItZoy1Bng5R5DZ7EKA=

Am 26.06.24 um 00:43 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> It has been a few weeks since this discussion stalled.  Let me make
>>> an executive decision on the direction here---let's keep the behaviour
>>> and align the documentation so that we won't break existing users.
>>>
>>> Thanks.
>>
>> So here is to re-ignite the discussion.
>>
>> ----- >8 -----
>> Subject: [PATCH] archive: document that --add-virtual-file takes full p=
ath
>
> And it seems that nobody is interested in the topic all that much
> anymore?

I'm low-key pleased to see a documentation bug being stomped.

Perhaps this saps the energy out of efforts to make --add-virtual-file
respect --prefix, but we'd probably need a new option name for that
anyway to keep backward compatibility (--add-prefix-file?), so the patch
adds no technical obstacle for that at least.

> I've read the updated text once again, and didn't see anything
> glaringly wrong, so I'll mark it for 'next'.

The patch looks good to me.  I like the new paragraph about --prefix not
being respected, in particular because I wouldn't thought of adding it,
but it does look helpful.

Perhaps add a Reported-by: line for Tom that's findable with trailer
tooling, though?

Ren=C3=A9
