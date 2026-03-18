Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E8342CA7
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839777; cv=none; b=CmnRsck0g4WW4qYdfgVltqjMBV+6NyXiB6sQS20g2srNVqs3civgs8xHQeDXLDrNxGKaPqH3+0gH1dnBNwuvLOCR5etIAqGOD0M7YueD4LUshqzX/4bXEOG89LpJxBVd30WOdbnSMcLK2uwBInra5yNiSJuCdeuFhNh8ZuQTrfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839777; c=relaxed/simple;
	bh=6uk+GYh07vxwe8lAMvZ+QvRx92w/e57xgRevfpl+3RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uv8Bre8CY10E6AdfiM0aL1Duu9Zvqcf1bS2K7YELVRjl+3stFb3S5iwyO7bbgPAgAtRCTKfUJT6CCLTSGbPZCVjrkKPjYac7UlQwm0tuMrb1WGG50cmrXUZejPFQEiNOX04IsSCxi1bZZRsEXbmMCYjli37giSpPMB106JMvyms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcx63D6u; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcx63D6u"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509064418a8so81686991cf.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773839775; x=1774444575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WqJrxoNCpSFG4MF6IoVh9C6d2UK78GvgSARffMNiuI=;
        b=Zcx63D6unHTRuF/jifyENq9UHg1EDGputDcU7jEigs0/QRUfqSJatLd4MAOeWdX3RW
         ngQjV041JTCPiETxVE0xFbhGWvdQySxnR4AmSRerzy1FA92wI2SAyVUFfTmDyJInWBki
         dbPXcqcDdDF87uhTAt5OJhTzTBz7PO34xsqd/Uzn17cQLRc0vf03REvHloCcvZv+WoYO
         BnLC9G+XoY1pSWNtqug/lbVY0mObGOf8XnB+YqUBmF8kyGVTGHm3RAM2Z00nspHiETI+
         qMU5NyQ0UT6eK1SCXSww2ubDo4wPK0aLi8uq+vcpyZmOl6rRO5sJVZpKezSLXDr+boR+
         aseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773839775; x=1774444575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WqJrxoNCpSFG4MF6IoVh9C6d2UK78GvgSARffMNiuI=;
        b=X3XcbaknhbPWdNvts3ZjSzsWC3VPQZNONI5slx2y0kwQW/7hiCvJlXzBErg0J8dvFs
         4tkcPC30CBmAfYlEzqSpHXLCPAAi2nzHG6S996Co7eu73WWgfn1FJGgKrhPsTCWG7oWW
         R0vTKz9ldzUI32bFdR2w7Bb2zp8HEJOaY8u+BNDI80RlM9lQ+YP57aqVKTYzxfaW54AF
         O/XP8GboLXxWdOStPwUmowiA/JiRmvkwfS6GOCKVjDcvriWKgl0OvI56xDu96IJWPg7X
         LUFHYKFY+5u6vfaavKuXwtaEqQAOn4B2JPPcCI6vvF0m1yGBf6UIfxHp78Yg/OobmynA
         4Q8w==
X-Gm-Message-State: AOJu0Yywfzfb/6ziNWI0hF3fsunY2b5Ef8phb1LZVzDgISz+5JRxJZPB
	ml96ze4A9mGynwT7JuC4Hn1ujhJwOHImcQHTzfBcVvopW98InlLvCfrb
X-Gm-Gg: ATEYQzwCaKEa488lQcn5iR2k/MPIl20RfBn499EldQwF7FzMl8RimGKRzGYazejPha4
	pC7pToxrePiUnVYa87w7BPCl59vBP1TavKHeuyyxf/W4/u808h51An59xTtYLWbTilxn1ujYv4W
	kHQE9DFV5tfJBw5LOGouqckp/KWLl2dQsoyuGHgSq1j9itV5+31Mk3nkkUDk3zs4ZtFzdZ0QhN1
	uYO7TKN4pVkgU2j30xo9r+lLf0aaBWgWR+MzjifrEqzojzSstJPvyjs0f5i1gxhkm6m6V+eqkg8
	s7+gi3QVBQT4UQo2BHC3C/2R3oBrvumPn2hQ9bFwSZHwgTavo6DiER6RZDbzwk4nO6xoSkA7n1a
	SxZyiVtvZwBfQd1EUnqwUifN7Pg/BldXyOWWh0M6U0e6uT4EJBrka9Ivu0KSVAAl8j6E/9cnYKo
	O6US+iM34RgibuZy78P31N7qfFPxfB9aK4QIASws6DW5oBk7ql+gphWZ8ucbkMQZfvY15BzQ==
X-Received: by 2002:ac8:7d09:0:b0:509:2d50:9778 with SMTP id d75a77b69052e-50b14864284mr39338251cf.40.1773839775361;
        Wed, 18 Mar 2026 06:16:15 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b134aba5dsm21950931cf.7.2026.03.18.06.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 06:16:14 -0700 (PDT)
Message-ID: <443e5b25-46a1-4990-96b3-122e66d81828@gmail.com>
Date: Wed, 18 Mar 2026 09:16:14 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] path-walk: support wildcard pathspecs for blob
 filtering
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <beb1c92554c76907315a4d1a7983226d2bf5a828.1773707361.git.gitgitgadget@gmail.com>
 <xmqqms06hzfv.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqms06hzfv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/2026 6:19 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> Previously, walk_objects_by_path() silently ignored pathspecs containing
>> wildcards or magic by clearing them. This caused all blobs to be
>> downloaded regardless of the given pathspec. Wildcard pathspecs like
>> "d/file.*.txt" are useful for narrowing which blobs to process (e.g.,
>> during 'git backfill').
>>
>> Support wildcard pathspecs by making three changes:
>>
>>  1. Add an 'exact_pathspecs' flag to path_walk_context. When the
>>     pathspec has no wildcards or magic, set this flag and use the
>>     existing fast-path prefix matching in add_tree_entries(). When
>>     wildcards are present, skip that block since prefix matching
>>     cannot handle glob patterns.
>>
>>  2. Disable revision-level commit pruning (revs->prune = 0) for
>>     wildcard pathspecs. The revision walk uses the pathspec to filter
>>     commits via TREESAME detection. For exact prefix pathspecs this
>>     works well, but wildcard pathspecs may fail to match through
>>     TREESAME because fnmatch with WM_PATHNAME does not cross directory
>>     boundaries. Disabling pruning ensures all commits are visited and
>>     their trees are available for the path-walk to filter.
> 
> Hmph, I wonder how significant an impact does it have on the
> performance that we have to disable pruning here.  With the bog
> standard tree traversal, wouldn't tree_entry_interesting() already
> be capable of doing this, even with fnmatch / WM_PATHNAME ?

I will explore what's possible here and see what I can do.

>>  3. Add a match_pathspec() check in walk_path() to filter out blobs
>>     whose full path does not match the pathspec. This provides the
>>     actual blob-level filtering for wildcard pathspecs.
>>
>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
> 
> The latter person cannot sign DCO or vouch for the origin of what
> they have written in this patch, can they?
No they cannot. Sorry for this error.

Thanks,
-Stolee

