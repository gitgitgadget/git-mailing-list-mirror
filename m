Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663310;
	b=G6yukAUHMoGhwsTtuAilaw9QxafMKgSLdo0dGN4fiB53LwYgNi8InswUvSxFgUSMPjS3
	 TvHWAYEfv/yprFbX2+tOrZIurJHIHrn1ASyHkcHlQ/pRWxJvgKcEJEFgalGflTB0oMRUN
	 9IyK51dl8nWQQarq6Y3wKUs1EBjvk1aDd9dJM+cUxjVD3l6HT6bk1gMaCgoBu4gd24O7Z
	 hQgk3Re4INA1rE2MNfATrdYeKKokmQncY0Z3QrkJA4byMgv6dws+hoBpZZ49b494l1oYj
	 qQgESy0qLPEwnEFOR84qwrqbpgd3ID0XFDJRHfB8TQJLt0XAhn0SJevylo7204nrVnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YyFfc4Lgt/geZER9WdJ1qu78uRRn8J3ELhxdu1Yrq5A=;
	b=QW0RiGb8X7C/baHWhiNpCbzsKxUQ+Gcsx04tdH/Bd1WPsofR65vian9bG1GxSbpa8hr1
	 D285l4nasspw+vAuBSLxIKv1O5bQc+Rn8WkXujnZnbP2QqTBCFUuksAXH9RyRf7jGX4+E
	 jVPkrp+BCB6rmf1DtuN2HZ7E83YIYuwbMBg1dxIw+JOGCpw69kjcRGmRe2Kj+3EyhiQq+
	 Pr/05gmqxaXN4iZwFFkcmJftkmohIKZj8ql1GNZCTsa5Etd3NpP8YjbgqXc7ai7O7LMfJ
	 3iky7zjeEZWPERu98du0BQ2GJZy/Ah/C5/UjNi8Fm9BEQg8W0rVSF2CZ2DlCJPrJRUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rY6YqQCV;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FA606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F2FA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rY6YqQCV
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a209a7fd1bso1814165e9.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792663308; x=1793268108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YyFfc4Lgt/geZER9WdJ1qu78uRRn8J3ELhxdu1Yrq5A=;
        b=rY6YqQCVP++4vBT/WWNMKtS9Csm3PRSqvmdhS7u62nFsZJvjFfy4a4kgl2wzf0eM6r
         LEG6AUXRrXyQ4xl7kkSPNPu7yHgpCiDQYmWwR+P7s4G4KoNqOOnUv3kpTiQ/HLbx412D
         AYf5mzE3wLE2IK7r3Qn6yH0jdlBsnW6dA2P8IMN7Bn8IC+LmJkTQWtgnpncRagkSDnvC
         1OrHUrnB/DFC22o5zlQJGyIJatKAZ3s43bPS2shwIFascT1WKDeboUlUSVsSdcaPvtZF
         WJ0vVULM/WNrovR35VqawMkMNOblXLr8x2CJzuNJUC4tuvqi2/kSXAj4uw9sEvxmA/B5
         UrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792663308; x=1793268108;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YyFfc4Lgt/geZER9WdJ1qu78uRRn8J3ELhxdu1Yrq5A=;
        b=SVAznT9ViU5+6s4+D6n2aprdNolMPwuCVZ93kmTWQebPAX3lK9bHLlusTjRZIPL0NF
         BlYTfGzEXAKB9LQSFHa4MlbFxxWZhMWLQ6WpyIA04gq2W3VnKdPpxJJV9b5BNWuDFGc+
         xLUdoa9srmpyXpuPazocMTMZLhAhIwT3cCqaPbeAnRgO/L1hGV6huCyNtlq8YdhoHbeV
         HE+S1j4kn0u/wVL9Wz/EL8QIoTyck9C7EVGPTLA5ue1wdRRCBBQHxL0OtJUIrr93QQXJ
         6qypgUD+Ys+dG5GkDL25IaQhIBIQgoygJkA48n1458/1aSQJjmW1torG7uuMEBdZ4moZ
         pQcg==
X-Forwarded-Encrypted: i=1; AKwUvBxfe39jkBTdL7P1K+8j1XaPyyMOGezuPxXHvzL05BQYB/aqtwp9RoihlHOYmWNIH2Fq0ss=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwX0wgDK6RV/d6hyyXgn/kcd+3cANlbRre+G0YIbrAznFMNZPR
	FODO5PixF7EiJoDDtn7FRK6NeADMYNBAv04cuE1cI2t6mzdE5lgaQeQ/
X-Gm-Gg: AYBFou3Hl6oDtUGFN/yyqdtivkxxkEjWRdMaDe+NHN2aARV9q8CSbGfwxjjwYYKopsv
	8gzqt8u/5LFv54Vdk7AZ4YQM9xMDsBYv875YR1zNV65zLIC710utamov67/lcqAwGshvF6ZuioL
	GDz9ln5K/BdYvBbLtwPQgJdmwMcSdL85TIpcHqCGW8zrptFLgxY95Em4DIliA+FAkreuRLauZqv
	TKivCOEooESi7x9BWTLkgYNeHNYqzHP335aCZWcKCtH8/wusKJS7Uvw4JNrEN6t5eNsJwzdIC+T
	vzPSRv61FdUqJ58d0kxOm4g1H3EJdL/msq9plz1bYACsDsBkkTPSDsIsAdbIu+W/dZJxkn5yPrN
	H0QpCZhlvJwQUn4QcetbJu839kM5oHVFLDJb7bHLeAjJ36FfrGU06fMoT5wfvEW8eD958TGgI33
	nZYLmduLGnjozTx5kFfbeMLpK9FY+qUGIEs42dVnDpFXzbJqCwa3dxEq8bWZQNCNDBnf9blOAEG
	2WuObrfFcsYbaBW1pQ4Wgoh48TfZWNde1AOmMHD1Qe3VJrWnJVX0wis+1QtgbHy7NK6Ot9yUFia
	C1kvDo0mPlXR8mNuuhBjNy/xTfyhb5PLkg==
X-Received: by 2002:a05:600c:a204:b0:4a1:e9c2:6c84 with SMTP id 5b1f17b1804b1-4a1fdd2c140mr61831975e9.18.1792663307623;
        Thu, 22 Oct 2026 03:01:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a207b29276sm68614695e9.6.2026.10.22.03.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 03:01:47 -0700 (PDT)
Message-ID: <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
Date: Thu, 22 Oct 2026 11:01:44 +0100
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
Subject: Re: [PATCH] Documentation: propose community voting process
To: Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Emily

Thanks for working on this

On 21/10/2026 21:05, Emily Shaffer wrote:
> On Wed, Oct 21, 2026 at 1:03 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>>
>> +Voting Eligibility
>> +------------------
>> +
>> +Votes are welcome from contributors who have authored a commit which has been
>> +merged to next, or who have provided 2 or more code reviews, and who have not
>> +been banned from participation in the project. All eligible contributor votes
>> +are weighed equally, regardless of the overall number of contributions they
>> +have landed.
>> +
>> +To prevent dogpiling, contributions are only eligible for a given vote if they
>> +landed before the beginning of the voting process (the kickoff email mentioned
>> +above). That is, the code reviews must have been sent or the patch must have
>> +been accepted before the initial email is sent. The intention is to ensure the
>> +mailing list isn't spammed with low-quality reviews during the voting process
>> +solely to increase the number of eligible voters on one side of the issue.
> 
> The specifics of this eligibility rule can change a little. I'm trying
> to figure a balance between a few principles:
> * Not all contributions are code (e.g. community moderation is
> contribution but a moderator may never send a patch). I think in the
> Git project we have less issue with that, because we don't have a
> community moderator unless we're counting the mods in the low-traffic
> Discord, and I believe all of those mods have code or review
> contributions anyways.

I agree we want to include those who contribute more widely, but I think 
restricting the criteria to contributions on the mailing list where the 
development of git takes place and the impact of any decision will be 
felt the most is a reasonable place to draw the line. I'm not sure how 
easy it is going to be to count reviews - does posting "LGTM" count or 
do we want a more substantial contribution? Should verified bug reports 
count? - that's also a useful contribution to the project. I agree with 
Junio that we should count patch series, rather than individual patches 
and I think it would be easier to measure when they're merged to master 
rather than next.

> * Avoiding dogpiling. This is my biggest fear, Git is a very
> well-known project and there will be a lot of big opinions on the open
> internet once people know we're voting on this policy. I want us to
> measure the opinions of those who participate in the project, not the
> opinions of random passers-by.

I agree this is important. Before a vote is proposed it is likely that 
there will be some (possibly contentious) discussion on the list so I 
wonder if we should require that eligible contributions are made at 
least a month before the first draft of a proposal is posted. Junio's 
suggestion that we restrict eligibility to released code has a similar 
effect but I'm not sure how that would work for non code contributions.
I also think it would be sensible to restrict eligibility to the current 
set of active contributors, who will have to live with the consequences 
of the decision, by requiring eligible contributions to have been made 
in the previous two years. I have historic contributions in a couple of 
projects that I'm not active in anymore and I would not expect to be 
able to influence an decisions those projects make now.

> * Easy (scriptable) eligibility determination. If we start to explore
> other types of contribution, like user support in non-mailing-list
> platforms, it becomes really difficult to send a ballot to everyone
> who's supposed to get one.

I think this is tricky even for mailing list contributions, as I said 
above what constitutes a useful review? I'm afraid I don't have any 
useful suggestions. (It would be interesting to see if an LLM can 
usefully classify the emails on the list but I don't think we want to be 
using an LLM determining eligibility to vote on a proposal about whether 
to accept AI!)

Thanks

Phillip
>> diff --git a/Documentation/DecisionMaking.adoc b/Documentation/DecisionMaking.adoc
>> index b43c472ae5..c08fb7abd5 100644
>> --- a/Documentation/DecisionMaking.adoc
>> +++ b/Documentation/DecisionMaking.adoc
>> @@ -72,3 +72,9 @@ We prefer that "official" discussion happens on the list so that the full
>>   community has opportunity to engage in discussion. This also means that the
>>   mailing list archives contain a more-or-less complete history of project
>>   discussions and decisions.
>> +
>> +Formal Voting
>> +-------------
>> +When a decision cannot be reached by general consensus or compromise, a formal
>> +vote may be called. See link:CommunityVoting.adoc[Community Voting] for details
>> +of this process.
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index f8dea4b395..314b8dc8f5 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -113,6 +113,7 @@ SP_ARTICLES += $(API_DOCS)
>>
>>   TECH_DOCS += BreakingChanges
>>   TECH_DOCS += DecisionMaking
>> +TECH_DOCS += CommunityVoting
>>   TECH_DOCS += ReviewingGuidelines
>>   TECH_DOCS += MyFirstContribution
>>   TECH_DOCS += MyFirstObjectWalk
>> --
>> 2.56.0.rc1.315.gc6ed9934b7-goog
>>
> 

