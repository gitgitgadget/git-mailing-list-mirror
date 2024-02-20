Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4C14A0B7
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459017; cv=none; b=MyGqtJmAT7d4lFLZs7n9hfkunEzgSIcKVW+yJFUyWy1N+Juq/bJXkTimGKIewrgpszpyV0b8rRQ999Yx/S1m7+laQdUp2Je5Ixe3CcRjAtRhCycFO8IR/BDQ6/q4MJMDDyNUagNmZUXHMobaVfCzAC+b/zyEECq9Kwn80Hu2Jnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459017; c=relaxed/simple;
	bh=ItgqTQ9PEjZAJaS9K4NMC8fcyhrpJIU/Pg3uOphAYkk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kYS3fGH/tx03IeaSsw95b78XOHoWbPpEXxWK4B2rRwS7cDsryS+pc4jX2ZFVkZt2Z8tL3lF2bhTVEtP5FzEjXt8/zbQKudd8BqWivlJ8pKldlrEU43WGXAeR9/HPq4Nd3Xs1Yj72Px8lzIeC33TvJhQMlSPXNVEG/19RLB4PsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=EiUF3cPj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="EiUF3cPj"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708459013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8NmlsoMvD2lpJUMqQepRrwLNYpXpoU1yxKI1hO6Iv0=;
	b=EiUF3cPjabXQu8l3+NhLrSdAg6CRmioyYl5HBozAil9tAx+QpaAihpGQN5gaPEi2z9KGgz
	nT5xhddUmGVQgvOCYuFZe033vfjA8egVkwHPOdCMvqNUKG/MaoDiiuD3d/rcqZ4yBfuPE8
	5UB8Hlda9t/yp3KDHk2mtvCjJLrV4le8j3PkqhN7XlwxiBmqzdH5Aff35nJ7yTcm0l+iUU
	6keWY8zBE7lMClMUKHWH+lbE/SysXxLHJLz5v1NttNz9T4UxVpjWriq0ECROHjCJBvUnf8
	M9wAB7ENKACHwUlgd/Jk+u9Sjgfqjsn3Xbu8/WuvBTI1fOzgJBdCCJWKoN37NQ==
Date: Tue, 20 Feb 2024 20:56:53 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <ad20099a-918d-4c37-8d5c-20c3f491728a@gmail.com>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
 <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org>
 <ad20099a-918d-4c37-8d5c-20c3f491728a@gmail.com>
Message-ID: <164b9780e82b3c677ad97fc8545353e7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-20 20:14, Rubén Justo wrote:
> On 18-feb-2024 21:38:54, Dragan Simic wrote:
> 
>> Regarding the branch copy and rename operations and their argument
>> names, perhaps the following would be a good choice:
>> 
>>     --copy [<branch>] <destination>
>>     --move [<branch>] <destination>
>> 
>> It would clearly reflect the nature of the performed operations, while
>> still using "<branch>" consistently, this time to refer to the source
>> branch.  Using "<destination>" to select the destination name should
>> be pretty much self-descriptive, if you agree.
> 
> Sorry, but I don't.  Actually, I don't see the logic with 
> <destination>.

No worries, I appreciate the directness.

> I appreciate your efforts to provide consistency, but the current ones
> seem better options to me: either <oldbranch> and <newbranch>, or the
> shortened ones: <old> and <new>.

As I wrote a bit earlier, while replying to Junio, using "<old>" and
"<new>" (together with "<name>") is fine with me.

Though, using "<branch>" and "<new-branch>" is also a very good option,
which would additionally avoid introducing "<name>" to replace 
"<branch>",
which I find highly beneficial, because it would provide consistency
with the rest of the documentation.
