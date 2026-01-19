Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1AD3254A2
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841078; cv=none; b=aJQf1espaO0X/Du+X5Q+oBV5uvK4ZsN0gvjiUM9ljgUU835c/Hk4tFaCdHLFy1O3lmBsMILi/i4WTvBwWkIRcJ6UFfL7jUNHAfyeiQ3ZWLl3ZDnUwAQ+0350/4jkEQJIDvzpW4hM7uTS3cHtwxsl/ao0bqPzPK28NkMOIMtiTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841078; c=relaxed/simple;
	bh=u1QmiEfzcCyrityvpuPoo7fn8AvoDIx50kM+f8iRp7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPZvAr1sp2mzrEl/hSnCbDSfmH570sXiyExqLHVdzBY+Fghjz9j+0RyjoGaBqN1ofvI4p3IG+homgtgxrKzbKpuUfL/UyaQgZBj0JVNdnz8xRxGxRjocX/htCkLIt0B6BTsoGaBx2J23JdKdtRs4Ob1Zsx58O0VC0lN/qR9O8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqwUyN3S; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqwUyN3S"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c6c922850cso26897785a.2
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 08:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768841076; x=1769445876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+p6Kz8SpSUJ0KzHHIn09sxhGQL8/stTvIb2G4n5tCWc=;
        b=LqwUyN3SdYpB3OmpuhhCBU6Q+s+yTmrQoSHgt5zcGUKE2hsYGuWBamrMNUmofufrUv
         FywNmIMk+dUatyPTmcvSoRhr05geQEGNVsv2ijqpuqJXyCglncpZvB9MT5hxcWUBFcp0
         AspAz4fXvvOquv9q6O8Cr5nOMwDjiRwx7C4QIo0Fye472G3yGNcDvh6CAuq7QhkRah5o
         TB+/wDBFEwyrbb8ARJrwq1w6B6fXBh0d5YOtCNln5/f2UQGp9HcKea9IYO/oUU3U0DUN
         R3tDuwgNnBVxI/y1u/iIK+ZrBorfipFmTmkMOjFimfTPlcUAghJhIdTTVvPDHz4/LvTV
         WabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841076; x=1769445876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+p6Kz8SpSUJ0KzHHIn09sxhGQL8/stTvIb2G4n5tCWc=;
        b=jaa1OxfIIJTUCRP5lX08uBwffoOl88ck7Rh2onBxhQ1A8D9HI1iabdawU9qmLfei9M
         ZKZYFGZN7K+BncOPHwdRoBS3OPKpZkamD+grUBA2g1R1dLCkJKXsZSfOOT8pxS+inku/
         brMa7tNqWz4dZju5PmOr20k4VJ/D6nNZ7oQxVcFOn4Y/WS78g4R2VqnHCY9hWqIH8mWG
         mkFz8e42dPTHBvF2rRollfFRrqWwf9/rj3paxm9rl9Q83ZEpZtpgIu7yQ1+J/HjE7FYh
         fUJDjzTdfBIvY06CzzOV2aperzmIHfRqsVXSgYyLOM5d8AabtOubkdn6CuGbmXyZtayK
         RDVw==
X-Forwarded-Encrypted: i=1; AJvYcCWmmxgkjNHkJE5mvusrigfNO67MY+L8bay60BPbdmqq7RSYh4fJ8f0d5cLgsHOvEPk/O4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUOgWAUsB5i4gnTlmUhmf5KQ37xSyRhHkA0KVU/Mv449+szixE
	QYCP+60GCSobFZjNQl57fXJ3JHCp7XtqQ1WeA8PxZVNnioE/LoQXn9eK
X-Gm-Gg: AY/fxX6xdjBjANceuuLRfb8AAZcuqpTKEKoz4OXl6PBaLp0TLB98kVuy5w/l5cU2M9O
	vEe3lLXOxIpwwGzcv1a1gGBQGzlGR+cBhhr40cGLtjjJDTNXZiTqKcnzzdU+z9juvaXRwQXzuQf
	O1yii4xtG+X6C4phVOtL98+fCCRF72HMXTeo0jVlsC+77ELdymNNoW2hLICnfalfUaBigwQ1TSV
	WkBG1ekxohzLeusCGLJjQvtoHQSNq5WbObXdmVYKbMwHzBLhccgU9oL5ibc0djCOIYJT6+kOT5f
	dg9e2KwBoMjwVHBCHbqJQVF2/LlO+/9EV8yk8TVnJg7G+TQNMhTv1x50TAGiS1QT5bo4zbIN4JW
	1Vnlejn/YubzcBmGaKHM9dG/DpQba0bPotucZvz0LkrN8xH9NQs7Z55NNny6Bxv/3kjyUzbIh+a
	qvFlnEzGNA70TB+pZkgB5I7ph8R+0odEb06ycBqRfnskkVESUgy7bYp5qpqEyyt3nhhdSx
X-Received: by 2002:a05:620a:710c:b0:8c5:2e1b:7913 with SMTP id af79cd13be357-8c6a66ef7fbmr1784637585a.25.1768841076174;
        Mon, 19 Jan 2026 08:44:36 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71c1a15sm828444085a.20.2026.01.19.08.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 08:44:35 -0800 (PST)
Message-ID: <3fab80c8-f602-44d5-8e7d-436982a5e3a8@gmail.com>
Date: Mon, 19 Jan 2026 11:44:35 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision: add --maximal option
To: Johannes Sixt <j6t@kdbg.org>
Cc: gitster@pobox.com, git@vger.kernel.org,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
 <1da38e88-3f61-43df-9c75-5716d715bf80@kdbg.org>
 <b46885b1-5781-43d8-8751-d85048c45e5e@gmail.com>
 <1ce18cac-f988-4741-b9dd-6c1cf2d4e6af@kdbg.org>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <1ce18cac-f988-4741-b9dd-6c1cf2d4e6af@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/19/2026 6:15 AM, Johannes Sixt wrote:
> Am 18.01.26 um 19:27 schrieb Derrick Stolee:
>> On 1/18/26 4:05 AM, Johannes Sixt wrote:
>>> Am 18.01.26 um 03:34 schrieb Derrick Stolee via GitGitGadget:
>>>> The option name is too generic IMHO. How about "--starting-point",
>>> "--topmost-only"?  It's function is somewhat parallel to --boundary, but
>>> at the positive end of the revision range. Perhaps we can use that as
>>> inspiration.
>>
>> My perspective is skewed, because "maximal" is a concrete term in the
>> world of partially-ordered sets (such as commit history ordered by
>> reachability across child-to-parent relationships). It's important to
>> distinguish from "starting points" because the inputs to the command
>> are a list of starting points, not all of which are maximal within the
>> set. In fact, if some positive starting points are reachable from the
>> negative starting points, then they are already excluded.
> 
> AFAICS, we don't have options named after graph- or set-theoretical
> terms, but tend to stick to terms established in the Git ecosystem. I
> assume that "maximal" isn't a meaning that an average Git user would
> associate with the operation that is performed here.

My mindset is usually "all words are made up by somebody" and since
there isn't an established term for this in the existing Git ecosystem,
it is up to us to create a term. Borrowing one that exists elsewhere is
a valuable way to build upon any context that term brings with it.

It is also helpful that the term has an explicit technical definition
that means exactly what we're using it for here. It explicitly
differentiates from any "maximum" or confusion with a collapse to a
total order (such as Git's --date-order or --topo-order apply).

> But even if we decide to use "maximal", the option must be named
> something other than *just* "--maximal"; this is simply too generic.
> Perhaps "--only-maximal" or "--maximal-only".

When the argument is moved in the documentation into the set of
filters, then the fact that --maximal restricts the set of commits
makes any modifier such as "only" redundant.
 
> Other ideas:
> - --hide-reachable
> - --range-head
> - --range-head-only
> - --most-recent
> - --most-recent-only

These all have issues, such as being technically wrong (maximal commits
are reachable) or imply total orders, date orders, or generally only a
single result.

>> [--maximal]'s interaction with
>> --boundary is trivial because no boundary commits would be included as
>> they are necessarily reachable from a maximal commit.
> 
> So, --boundary --maximal shows only the maximal commits? That sounds
> unexpected. Boundary commits are shown with additional mark-up; they
> don't need to be suppressed. But in a first iteration it's probably
> better to just make the two options incompatible.

Sure. But I'd like to counter that filters like --author also restrict
the set, including not showing boundary commits that don't fit the
--author pattern. It just happens that no boundary commits are also
maximal by definition.

I do sense that a lot of this is a matter of taste, and that you and I
differ greatly in our tastes on this topic. I look forward to more
opinions that can lead us towards one side or another (or in a new
direction).

Thanks,
-Stolee

