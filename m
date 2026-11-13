Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575437;
	b=zpGo6ldXiwbxWY6W90ALa/22RPfSeiUYP6VGgkM0yGrikaSfNj74OyQElcQZh3dkzMyk
	 KwqRP0J65WHfv/pQ8QOGBt2QK0+k3MUaVtOELZvtNsMCKSivLM6RLjNwO8be2qm6U2mWP
	 IJubo8Lt+WlfbLQibS8XB4NbGLdk+Xm510NsdS72vrx9DiDizhwuOMJc0LfosovHm4M0E
	 HGrjPDt5FL9slRLbTqb1SOM3FjVPP6ai8X4YppaE9K9m884YPONRyqUkmGJn9UsQiblTy
	 wqPTh01CZBUHK2Ejb2rBSLn1ZBOseojyg1SWTB+50Pbyi+yYG+wMVSwMYhvhc5Xiz8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ygKLqrrkgOT8wGbNnV9iCpsrbx4+qwony34569EkGU4=;
	b=lwEwon/X93gOYxbsg3hP2Su1DadvfxzdwStKtO12gLJXRWkftYZgHwr3/pnkMoDNLJSd
	 v95hgJkfjfI0T657jl1AU8xMLBdLQae/zivfuTTSi6FBDMcb3J45L8JHtMsvsCzggaS40
	 jjGR0nawprnNsWjOXPhveSiGIA1tIuOlvrIXJ2VpcDvRBFnsra/o7gK0GduHWVpGyzZ3W
	 l0sPNJIPwOJRo9FnowYr3c8Vq9C/PU2PusCWeIrZZw8al/LbUCGqw2ZWNXPxb0WxT3FkV
	 ux/2zA9VvKy2YeGu+YVBzE5lzcHHxhLWBfCyZyeFSXbhhUjLiuQe2Afiresxxw6KSxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4qs9XmU;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CDE606A32D
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4CDE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P4qs9XmU
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a315ed211so845163eec.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 05:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794575436; x=1795180236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ygKLqrrkgOT8wGbNnV9iCpsrbx4+qwony34569EkGU4=;
        b=P4qs9XmU3tE7NqiLSIrI4CVPNS0WZRBzuydsyyqAD6CPkonfpe521GnLNB8NppPrqB
         gMzKDgo//EYRERxvIpgB4kHpDkOeQB35oiwnxeDKJ4rAo1O3c5zxOlMG8L8oWAbO7xT3
         HrkssY73zDYKRdQoEiMnoWWX2+yHzYT7iZfhl6PQ9AW9GYuQgbtdPWuXLLngllx9MaoA
         Olo+G14Hft6bWCeTQZVpPH9SUCgRfksqSzEEYJQVo0WYAvsDrdCqjcN8mi+fOqgRr4si
         kgt+7Nw9adGwoEnosQxQzb+H5ZmL/TgMFM20qIwVN8wbldWJMcfgNV6jw1vYM13SpocH
         UrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794575436; x=1795180236;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ygKLqrrkgOT8wGbNnV9iCpsrbx4+qwony34569EkGU4=;
        b=CK9lLuhoPIOt5VA4/z02dw7LJ0rNa8NON7h1juvzPogxPCG4nJjnV8uwFlywcTIYwl
         PLC4lcHwVA2Zj7E6qsBElOJULfKlyRw5MosUPYAM0iCaB1GDXL9ZO6s7ubGFipavWdbp
         +tN89FqWSa+MKXS30hd5+I9CfBZRIzKBeZMMEEQv0iI06dYtVLvKYYv/d/CTR1OxpKw7
         /lj/FToCNMAi+D/YU1Igll43ccIJfncsE2GC8ecFthA3lyiG8VTxEeXuwwyZQ+ok2VPU
         XapADmo1RZsEpBdmix0cqwYESwHGEe/UppScc2JiHyH6WRfH5A22psJsBUS9e/cli7Yi
         sjbg==
X-Forwarded-Encrypted: i=1; AL+hErGFVaj4Se6NKOCW48B7GVtlMORrBryny1/QtkiKH6Rgkwh141FFRNjDrFswTW9xm7uqlKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FnN1gnM402RT1lJxDVqj0uSvzlE30kosFN+5InnZAXqXFwjib
	2JrDg7WiEBobjnHbDIvdChk+AaFNqmBR920jrjZ/pIlmdeyyScyf3F7s
X-Gm-Gg: AYBFou31E7k7xc4SDqRJSFibqmbQPidcGMz+qG8XdB/QDRBFZX4TGlOaOKU04mqWwRf
	X5kftn0ih+1ojJqWQoBT02jQZkGUq7asiSOmhPDCsUtEL3a4n37Sa9+B1yh4qEAfzZs8VYl4af9
	U3WPu5pUw6SZFsCVwSCortINMT8+Orh7JJcljigdeWxu7ivM7b2ZF+ss7V20VqKJX9+B5RXpLcF
	VjZ2OtXRsunvk6/oCb0DeqY7QhYyewd0vlqTFFeY1ryftSwNN/ejZDitpKFZOztjR0R0ggB11C9
	JFDmTq5hQoEC1TSMrwZFGmmBsVPq0IK0gJNE5z97FyVlYmfhlreB6u2ZeptyBUgKan37mzo0gs5
	l7zz5ftW5tRe3Hl/P9wp+5yhJ0/S4KpSwbuA7hLmaRUQotO5qV+hI+UB4uWshng12ZsmietoDqE
	2NnSuxCcUOxxEoH1wiIBiA4i5JgJ2v9XbJgevGHPkUMxLCxp17BGnVhWSUnBuK+Br6AlfppMp4K
	NhFjYMqzw6ca398JTbNYRj1IvwMqhbFxx7lqq9OieOJuX7fo014w3Cc2JM/aTCj4g+AQMB9zztI
	QPWLkIYgu5CVxy5pmJihLw9Q4xSuC91BY5l4d284Cd+DeXPXnlRZLNgkAzWleGBmhQ==
X-Received: by 2002:a05:7300:c00b:10b0:36a:647b:2d7a with SMTP id 5a478bee46e88-377db7c8ac3mr5829825eec.0.1794575434598;
        Fri, 13 Nov 2026 05:10:34 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm14803304eec.20.2026.11.13.05.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 05:10:34 -0800 (PST)
Message-ID: <17a5f239-1b95-4909-b3f4-b9555039ef2e@gmail.com>
Date: Fri, 13 Nov 2026 18:40:29 +0530
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
Subject: Re: [Outreachy] Project Proposal [v3]: Implement promisor remote
 fetch ordering
To: Shashank S <shashu8660@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
References: <CANHmUQQvN0xQuXqTE2imochXyQuU_ag3KHb0gkGEZ-cPLFbBYg@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CANHmUQQvN0xQuXqTE2imochXyQuU_ag3KHb0gkGEZ-cPLFbBYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shashank,

On 11/6/26 18:48, Shashank S wrote:
>  
> Design Questions and Initial Reasoning:
> -----------------------------------------------------
> 
> I do not consider the design settled before mailing-list discussion. My
> initial analysis identifies the following questions.
> 
> Client configuration shape:
> 
> ... snip ...
> 
> Server-advertised ordering
> 
> ... snip ...
> 
> Precedence and persistence:
> 
> ... snip ...
> 
> Implementation Risks:
> 
> ... snip ...
> 

Thank you for the additional details! It is nice to know what all you've 
thought about.

> 13-Week Internship Plan:
> 
> ... snip ...
This plan reads a lot better!

> Availability
> 
> I can commit 40 hours per week exclusively to this project throughout
> the internship period. I have no university exams, classes, other
> jobs, or planned vacations that conflict with 7 December 2026 through
> 8 March 2027.
> 
> I am based in IST (UTC+5:30) and can adjust my hours for synchronous
> discussion, pair programming, and timely mailing-list replies.
> 
> Communication and Long-Term Contribution
> 
> I will publish concise weekly updates covering experiments, RFC
> decisions, patches, review feedback, and next steps. I will remain
> active on the mailing list and will communicate early if a schedule or
> technical risk affects the plan.
> 
> After the internship, I intend to continue contributing to Git,
> especially in promisor-remote and repository-libification work,
> including reducing remaining unnecessary reliance on global repository
> state.
> 

Sounds good. Thank you for taking the time to draft this!

-- 
Sivaraam

