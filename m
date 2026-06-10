Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51574374A0C
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119745; cv=none; b=tEZwzILnmzc9Frmr64ljylJF2uetxavhGSNBruvTHO+Hf3zdQnFNCli8raXiLRpjF6NX++aIx6PbrAi9typtuuWiGjmlbX16YeQL3K+VsjnNlY6VCQN10l9wr+8lxpNSlASK8YMKB1NXkPJ4xFy1jYX8QYmhApGGviXCb40B2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119745; c=relaxed/simple;
	bh=X1CBODJrI4C3/TqXQcruL8XZkTbz3sRv3TVH3fY1UVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4Lzbey/d5We9DDGpPTweo9MFrHCg8lkNfmclWrTvPDAum35kA9i7NqzjGRx/JG8PaYk0NVFnOCXSK4RiYA4z+wrDj1QgxfOYVvdOiYAeebN8mJom3jAxv3VMxotybxEv21B7Fj3rZq3O/ORtkEc2MqCb6J1W3UdOjygUj3lpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgSEqUg2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgSEqUg2"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51778077b28so78645061cf.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781119743; x=1781724543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Te2TBzoQ3dE1uLZR6DpujDSQyuFmI9N4bzc34dPSrEo=;
        b=OgSEqUg20kybI1J2AWVf07VIlLAkatm2I35uDbN+c96kKsZQ6xSFH3Qa1IUt9Ah4lf
         2cp5GMQjdDmH49SZydbLOtVgq49F+1xGWGKPk6v7xGHdntJFNfwQFWDuPDU9FFywkUG3
         320gwFZ0T5L5MrsUlWTMfz1JEvZUbUMvOohy0qFPUJh1OutUEB/fnmRg5uiSV0VJX0Ax
         6F1Ytzxvl/bQaZ7uADl6lhQTELnpnQBuyUyNG/c7/15Qu5AAKR1cqH8TsifS7wp2+MIi
         C/sRFMHHQv8jBfF0YS6fqLiCyWrGD5KBVxrK18og/LNOKWWVWkDF4MsqHDfYf8CJnHtg
         ATSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781119743; x=1781724543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Te2TBzoQ3dE1uLZR6DpujDSQyuFmI9N4bzc34dPSrEo=;
        b=mkD7Z3Fpzj0GAwcK86M1e9lSvTtPSKcPS5p3A0jrD40uBqx8M4nnKk7RTuqfJdtgKB
         mqA6eVUIGqQG0lvVnYVAdnR20R9rEXOww+Swaw5ef+K9DNmcH4H1J5Npfi2ToHSoWv9G
         VD3hK+hPkGE2+BLkeEV6kjaVNq6hXM9H9vWtM2JNaP2UZSmRnqCS36cf5MFCuQWUqKAi
         6beHxLaRLrudZ0MigW0qTRyEeJYUQTGd6NCA/0ADjWNsfx0u/sc3ryqposMuapML2+Hz
         rlyFeghoI3Canm7g5TR3QBXHeUE72OY/+XoXk7rn3a+wmxk4a6py4/uXcFqGVBjbBEY/
         KMgA==
X-Gm-Message-State: AOJu0YzXYKpEnUDKbxYQV/CziRpKwI0UCjepsORH0c6LQ/bEcNvF0LjP
	xRZ38i0f999dlL5OxV4DI6kXynkX1O5XKAKdRpmx/KipN8eBBQbdI4VQ
X-Gm-Gg: Acq92OFCzOoa6+2HeMNo1aR34fQ7dlAY2Db9F7X+amhHMOdctZelsXnsOoTri7ZKTXj
	NSXUHs9F8S04PfO5ul64xJUlw/g2FJ/P51NMpueHQwzGgcjs2wzEZbIF/F7ssMH0qdGUORS5glP
	IskoEl5izBiE+ZAKas/gEzxPyNJLxTXO+GqbaA3JrVMTB+RsIdwJjIGA6CWfi+/dvjZja5Z0UgF
	o3uFEaPL8b7nUKE2d6zXHRqW0XI1OWtT1Vp/iPBjpBI3mHf2l6GAhwz8rHUv9ZIY11DEgm3T/Yi
	y9iZyKn5HEgRyPP+vh7hyY/Chyz4tWlRx/1l/4d2fy+TYVqnM5HWiaFKBpelAgUlSEWN4FD0+Bq
	ibn0jcKsdSx93nDDJ2mENFxxgsQJYVv25mYeMi8SkdzH8XwcSMLDtInALiECHVSEDEP1MHcFOe5
	uUOiK8o03hIEtgGLCqqUR6LfuUPP12jqEQ2ZOjFdOs498WvxOh4xIqsKaDzTaItwRhirMWeXndi
	9STvsM=
X-Received: by 2002:a05:622a:411:b0:517:6351:b401 with SMTP id d75a77b69052e-51795c0763fmr394321971cf.44.1781119743154;
        Wed, 10 Jun 2026 12:29:03 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c4d7absm218818101cf.11.2026.06.10.12.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 12:29:02 -0700 (PDT)
Message-ID: <eae94a67-9c66-4b1d-9f0b-45ee3e80ddf8@gmail.com>
Date: Wed, 10 Jun 2026 15:29:01 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit-reach: remove get_reachable_subset()
To: Junio C Hamano <gitster@pobox.com>,
 Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
 <xmqqbjdixupc.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqbjdixupc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/2026 11:48 AM, Junio C Hamano wrote:
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> get_reachable_subset() was introduced in fcb2c0769d (2018-11-02)
>> for add_missing_tags() in remote.c. tips_reachable_from_bases()
>> was added in cbfe360b14 (2023-03-20) as part of the ahead-behind
>> series. The two were never consolidated.
> 
> Good finding.  It is curious to see that these were from the same
> author.

I agree. In my defense, these commits are five years apart. I still
should have looked for similar code that could be reused instead of
rolling new code. (But the new code is better when a commit-graph
exists.)

The other thing that I should have done in the later commit was add
the method to the test-tool, which you do here.

>> ... Without generation numbers, some edge cases
>> may be slower with DFS instead of BFS since the date-ordered
>> prio_queue naturally stays near the top of the graph, but this
>> should not matter in practice
> 
> "should not matter in practice" because...?
> 
>> -- worst case both visit the full
>> graph down from the bases.
> 
> And of course the worst case scenario is by definition not a typical
> case that appear in practice, so it does not make a good explanation
> for "should not matter in practice".

It's important to recognize the use cases that call each method and
to understand if it is appropriate to take these performance changes.

Both methods terminate in the case that all potential targets are
found. And that's the only case that matters, as we will walk all
reachable commits in the case of any one commit not being reachable.

Both methods avoid walking below the "minimum generation" among the
target commits.

The key opportunity here is that tips_reachable_from_bases() will
"increase" the minimum generation when it finds the current-minimum
target commit. That's a big reason why the DFS approach wins: it
has the opportunity to find those lower commits without needing to
walk _every_ commit with higher generation.

The one downside to this approach is that the DFS approach does not
take into account the commit date as a fallback when there is no
commit-graph file with computed generation numbers. When there is
no commit-graph file, then the fallback to commit date to break ties
among "generation number infinity" commits can't be used to help the
BFS search in get_reachable_subset().

And perhaps that is the critical reason for the different algorithms:
in 2018 we didn't have the commit-graph for very long so it wasn't a
reasonable expectation that we'd have one, even for large repositories.

Now? The feature is quite stable and it's easy for users to create
and maintain one. All servers are expected to use it for performance
needs. It's probably reasonable to expect that any repos where this
would matter would have one.

Thanks,
-Stolee

