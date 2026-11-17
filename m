Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913720;
	b=QpM/1Hp+fDO5LUBm+JloJKLJdlVxJZ3WZS2bm+6VQSA3jAsv574HIP0LyqBaatQ2n0mU
	 50vneyJj+xfkY7XyiWvhK0+7UeqDxc0R1W6wVwD0+4z+tRKhV2+xkXLxUhe7DI9e7drTE
	 raZX0Czqwt1J9wM+7G1XHVJebKPq7GVRj+GedjLqYQff7c0RpiL5c19zIRQSfqvuwTqgC
	 soLxuiVWXYsARxDm7pCD/R6R/ZFghTN0GWVXCBoIVHVQkYZFG1zC5m8FsmFmt8KTewkGl
	 zpS4b4hN3lPDp0WqM/eLTAkaL6WpQ/SZAsqVEZsXq6xRZVIqJPvbwjve3MG2aO2BTZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3Msk6iECijqZAzgSJYhlYPtSzKLlYLLpZnnroyoU6jQ=;
	b=OrfCeO4kAQ9r9lH5JpI7Rkti40zApxPuSjbJkg1YjhYD8C46LSwn2R7UnfB9gWkN/oa8
	 6TIGV2Ekkq0pRdhPMQi49NJhP7VLLIt4ih15Rhon0ORur2kkEYqCfoToZl1qtHL0wfU7r
	 0fULlyjjtXHTOWiWUqRXDSJy7EYBxZBTcIa9pKg3UUlrlbZ5CNOLqU5bXDrHPFEJgMOYA
	 MPvFdt/Eg6qzEjm2Cw5i677PkfjSeTHGbtFKFNELCHfn64tvEYJde7zj6zuaB3UlgYZmE
	 hn9hZ9k4r6cyBbzkmjXWsWbFaJkqyvrDf4dmyEEB/ivxJf1vzBTFAiJC7cWhHur1R9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IcJmLd8M;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B84E606A331
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 11:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B84E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IcJmLd8M
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so10053275e9.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 03:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913719; x=1795518519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Msk6iECijqZAzgSJYhlYPtSzKLlYLLpZnnroyoU6jQ=;
        b=IcJmLd8MdjWkPni80k6NY/Tc8U54ByafWRJvYgZ+n0vQQDLHWr3NIY9tV6zPlkuOfO
         x//yqGz6QNhrm8YDdlLNmzFVs8Nls5Ox/BRtmO3BdbkT/I0omLPZm1cEuzN0L24w2bYP
         EgqtFTrP0jeK49B3q4dleHJ5eda8fIC+EbKMz4rjN/eLqLNuptWcRgLz4RMkj/0YrWqX
         VXJL72tUw+hrh4svklPdxHIzBrWLDmNlMz4dJ0TsMTDHEcKNFvxR/ZyM90fExk2gg21B
         YlQgJHqL/n7xkCTvGfazWz47doaP60b7RdIsr1ZbLhUqYZ6KjDZBQ5HUCKsxrtg94REC
         b4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913719; x=1795518519;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Msk6iECijqZAzgSJYhlYPtSzKLlYLLpZnnroyoU6jQ=;
        b=NiqHQuj/xk9zz//VkNK7P23gknV+R2DjGVU8ygYcKvnQTbziR6FRTwQqlvpoRf+hj5
         K4jK3u6Cg+XPMeYvbPacTU9l3oTV3c3ZK80LNTEbzI5ZGikOLrXQ/RGtt21mFzpIjYZz
         9qzDmnCQanSTUHmNWk+he/wUNUY7+BtDu+2A4ESk75NnU5vNgn8sOOLQGVR/2hz7aTlX
         kYKkIjB+DyhkvBNYq/cgwWH26R+v/xGAPQSl3GuwKWYWGYQWDrtinpi/TmY/am1NgIY9
         2yROevveK/PN0b1q9pcsbWkF/xnnl+GmmdzouLX8tkFu0ghsqPSu6/1JRWxh9V36jlEE
         +iNw==
X-Forwarded-Encrypted: i=1; AL+hErEPdyAXnczeWPFckEyjlAl76JMp4dcTak+Y9a/5hbcWAfdO/jqH0hRo82mJ8/hKyhlUbXA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hOdowsJh2j66cjAUl8n20k80GDdYDmyGlUY4fAyJHxgVoh8gR
	sCcvKjtuBJCc2MtJmyqT2on6FpXjKO+N7HqCyOt17/kYkH4h0Dj2LzuI
X-Gm-Gg: AYBFou2tEtH3XJJT4lfI0IsWMtJxflswWu6qFKCq7ixBjcvsQaOolxgEIxCkKEd6iu0
	wragbP+/QIDmlTWZmPs+uH3rq7jTK9i8GuL+OSyew0Y/GQyIY1WHWSopALzCz5khtNNwGcDwP/L
	45buVwyAHSJMBQjNKLU/Zheg8S8e0jP9P0DxlztvCZz9b95tbbutCoKuYAuAj+8/K+YlQASvr9p
	HiqtjCKjaDzB3S6t6HirCKRDfblli4snu9e/tyvQrZg8MraRUUeS4Jb6m/EU+ixc4yKrHBjPc0x
	tcaPJeoBoEnrBfsC2jnNlT2ku7YvcVlKgIVVokhlOfRgKRTnYwSsreH70v9N46y/YYvp1GXxlNI
	PmGCaVw/k/zq28zQTMbSaYbacqGMMAPUFD62QBd1Jzxuzt6Gh24t8ix9LI7vB4Eer1Jv/fxE+rX
	O/ojN1IUIalodcR3USeFBwWFkCywaluwWqj6GyM38cwlgUGl1em/qnPLmn3nyCGQVCCqjPdCz68
	T6+cgliRKPOXEEPqGKRwrDGwJQKWPBd4feeloe++pQeffnG8sVXJRBBmBFjGhJEm30vGX2qb7kb
	4iZIBDUpcEdwX/j5H5o7yXBCPWOJ3jYgH4Zc38LyYPeXzSCzYJiBQbAsFz0+FU/YVO8p2tIlczC
	aqm4psKw=
X-Received: by 2002:a05:600c:384e:b0:4a1:c6f5:2450 with SMTP id 5b1f17b1804b1-4bb78399c0bmr49223615e9.17.1794913718734;
        Tue, 17 Nov 2026 03:08:38 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783e9288sm62632725e9.15.2026.11.17.03.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 03:08:38 -0800 (PST)
Message-ID: <1276fcfe-9f2c-4a2c-ade9-b88f33ae5d84@gmail.com>
Date: Tue, 17 Nov 2026 11:08:36 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v13 0/6] fetch: avoid fetching every branch of a new
 remote in a shallow repo
To: Matt Hunter <m@lfurio.us>, phillip.wood@dunelm.org.uk,
 Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Colin Hinton <colinlewishinton@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
 <CAHwyqnVJ3eUQ9tkQE3rhQ8jFZjaD0tFUv41unE-NQ1WRiyfjBA@mail.gmail.com>
 <b64387b3-294e-49da-b40a-0e757956bafd@gmail.com> <xmqqcxsbnub5.fsf@gitster.g>
 <5566b994-1070-41d3-807b-5fac9ddaa3d8@gmail.com>
 <DMTC5DR3ROPP.5V7HNV9ERYFT@lfurio.us>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <DMTC5DR3ROPP.5V7HNV9ERYFT@lfurio.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matt

On 12/11/2026 15:25, Matt Hunter wrote:
> On Thu Nov 12, 2026 at 6:16 AM EST, Phillip Wood wrote:
>> On 11/11/2026 17:37, Junio C Hamano wrote:
>>
>>> In any case, this topic one is keeping a topic by another author
>>> waiting to settle, so we have stronger incentive to see it move past
>>> the finish line.
>>
>> What topic is that? - I can't see anything marked as depending on this
>> in the latest "what's cooking" email. Would merging the first part of
>> this series unblock the other one?
> 
> I believe that is ch/remote-defer-follow-remote-head-validation, which
> doesn't strictly depend on the changes from this topic, but the two have
> textual conflicts that the other author is deferring to resolve when
> this one lands.
> 
> <CAHeTm9M5maWM=yrJPNzCibv_rewH3-yBK8J5-MDyDvPzfihe4A@mail.gmail.com>
> 
> It looks like if this topic were merged up to patch 3/6 (fetch: infer
> branches to fetch from a refmap-only remote), the situation could
> resolve.

Thanks for the link. For this topic we're still waiting for a response 
to this part of [1] from three weeks ago

 > For now, as this "what is tracked by the local branches" is the only
 > kind of smart that was designed to decide what to fetch, it may be OK
 > to use "you gave me nothing to specify what to fetch, so I'll guess
 > using the smart".  But when we introduce more kinds of smart later,
 > this becomes a problem.  So I do agree with you that we should have
 > something to specifically say "when I do not explicitly give you
 > what to fetch, decide based on what local branches track".

so perhaps we should give that other topic priority while we wait.

Thanks

Phillip

[1] https://lore.kernel.org/git/xmqqh5i8tqjx.fsf@gitster.g/
