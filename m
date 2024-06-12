Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFDC5474A
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218121; cv=none; b=QnHqv9kcXJCMv5beOVvHcZB1fKtrgtQIdxCPF7dY92/0qDPocXs4LF/pGTATvtf2wU2ve+DhvPThzs7/aOM4yZhDINLIFAv6v+v28kZjDew75dlGKUanStRtGqe+Fm+rWyyid+OwJ9nKBw7sUaktpO95S3Z3yDEfLTGwL/XhsNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218121; c=relaxed/simple;
	bh=L3c+iXsEeyPO+JgddOMLdVGMhhup36E3ijdHDRrDmNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+1fRWOrT39rDy1Jz3H4xCJRHE5JEHyt1OdnzauyGJbdagHOL5MbLxEoAQrvmkSfQv31p3vy52SbwN3loxhqQcy4LC+vK/5VhNAntCcvIv8Hg214DI48hKPig6Eu/u6eIn3jN80MZ0KJpJII/KVVIwVbmetZ7RHDLynBbP2nVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=VqNUlYtk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="VqNUlYtk"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7041ed475acso106194b3a.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 11:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1718218119; x=1718822919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yo0RS9XNUfHGThsMHAVOm+X+C6BnBqLvHVC9+SufVZg=;
        b=VqNUlYtkxns6da9DCIThPGrgd6jcke8Uh+GL62fqRzdbjaaurQYuSSt1OlXxYAVPWe
         tIfirys5iNJVEn/n5pDTZhaxJ3DBzIN8o82/gPQtZtTbLh120dJCG/ndPUfgB/nRLyif
         C5ZpTGD/Fcte7B5T2DhktLe+itEO3PtRXEJgcZFaD2GHATUCv9qfc1mKmHOhUZFNWZIg
         6HsgEO5bNAetFr4sUd6TNuFCK43ED2G2hMokntZHMuE3TZZCLNue0ZjxVhyDxrtqDaGP
         5Mb/D55KY7JmEDK0QRWZzDS4NQuN0Xl0gQws33v2Q85ueHRxgc3CMezkjhR0ZCSp8Wy9
         95TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718218119; x=1718822919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo0RS9XNUfHGThsMHAVOm+X+C6BnBqLvHVC9+SufVZg=;
        b=SNf9tTw90Vs6P3UJ6ppFsg3iNXS0t/T9/Sx+JK9I4pzuvXHowu95VG/7AHbuyhB8Zf
         WMw0srfiEFOau1q0tkMJousIQEf/Po/0E/IlM5rjV5+emQXK3OR88K9ibU9gWUX1gb4f
         1Qmo/K05AVbbC3j7YiQ/miyBfzhOkAg4GPnqQWFqYAaFHf1ccQ7amlPwjNfbI2ZrAvHm
         NzhKeXk9wWk/hDDv2dSmUutHFMyDQyDUcbD++VfhXE1MuMacACts7L0G6Yh9rrzVR32T
         iX71rzaOeU77yiH4TyW5RXdXHLFZATMglJeQFtmDUWSuZnAU2POgu+htIPi+jTCtlMHz
         XhIA==
X-Gm-Message-State: AOJu0YwIjaPjPuvjl5jn4MPrg0gDyjmrTnORhGCvTSaoVGcxE/hXYXUQ
	vpzUtMSqKZloEZzO97+hHUzX9Qjk0x9CGHHEhvmnfiuNhOE0FyxWywbhzDz959S42gP/5MCxDw=
	=
X-Google-Smtp-Source: AGHT+IGd1XikTUhCUbYXncifDO+hCnVQasXVtickd1jORobFeYIM0q032Rmi3y+Z49LZ7xIg7iWQaw==
X-Received: by 2002:a05:6a20:da90:b0:1b4:efbb:d1d3 with SMTP id adf61e73a8af0-1b8a9c886e4mr3052302637.51.1718218119331;
        Wed, 12 Jun 2024 11:48:39 -0700 (PDT)
Received: from [192.168.50.41] (syn-172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7042d735b55sm7440078b3a.39.2024.06.12.11.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 11:48:38 -0700 (PDT)
Message-ID: <dab4b0e3-8000-465e-8f0a-61df3d9168a3@github.com>
Date: Wed, 12 Jun 2024 11:48:37 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] mktree: overwrite duplicate entries
To: Patrick Steinhardt <ps@pks.im>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <b59a4ad8ab4b0e47373f811700eba59141fdc6c6.1718130288.git.gitgitgadget@gmail.com>
 <ZmltGAPQ2dAfW0kG@tanuki>
Content-Language: en-US
From: Victoria Dye <vdye@github.com>
In-Reply-To: <ZmltGAPQ2dAfW0kG@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:
> On Tue, Jun 11, 2024 at 06:24:42PM +0000, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> If multiple tree entries with the same name are provided as input to
>> 'mktree', only write the last one to the tree. Entries are considered
>> duplicates if they have identical names (*not* considering mode); if a blob
>> and a tree with the same name are provided, only the last one will be
>> written to the tree. A tree with duplicate entries is invalid (per 'git
>> fsck'), so that condition should be avoided wherever possible.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  Documentation/git-mktree.txt |  8 ++++---
>>  builtin/mktree.c             | 45 ++++++++++++++++++++++++++++++++----
>>  t/t1010-mktree.sh            | 36 +++++++++++++++++++++++++++--
>>  3 files changed, 80 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
>> index fb07e40cef0..afbc846d077 100644
>> --- a/Documentation/git-mktree.txt
>> +++ b/Documentation/git-mktree.txt
>> @@ -43,9 +43,11 @@ OPTIONS
>>  INPUT FORMAT
>>  ------------
>>  Tree entries may be specified in any of the formats compatible with the
>> -`--index-info` option to linkgit:git-update-index[1]. The order of the tree
>> -entries is normalized by `mktree` so pre-sorting the input by path is not
>> -required.
>> +`--index-info` option to linkgit:git-update-index[1].
>> +
>> +The order of the tree entries is normalized by `mktree` so pre-sorting the input
>> +by path is not required. Multiple entries provided with the same path are
>> +deduplicated, with only the last one specified added to the tree.
> 
> Hm. I'm not sure whether this is a good idea. With git-mktree(1) being
> part of our plumbing layer, you can expect that it's mostly going to be
> fed input from scripts. And any script that generates duplicate tree
> entries is broken, but we now start to paper over such brokenness
> without giving the user any indicator of this. As user of git-mktree(1)
> in Gitaly I can certainly say that I'd rather want to see it die instead
> of silently fixing my inputs so that I start to notice my own bugs.

'git mktree' already does some cleaning of the inputs by sorting the
entries, presumably so that a valid tree is created rather than one with
ordering errors. Deduplication is also a cleanup of user inputs to ensure a
valid tree is created, so to me it's a consistent extension to existing
behavior. Conversely, rejecting the inputs and failing would be introducing
an error scenario where none existed previously, which to me would be a
bigger deviation.

One potential way to get the kind of functionality you're looking for,
though, might be to combine something like '--literally' and a '--strict'
that validates the tree before writing. Like I mentioned in the cover letter
[1], I do plan to submit a follow-up series with '--strict' (it's just that
this series is already pretty long and it would add 4-ish more patches). 

[1] https://lore.kernel.org/git/pull.1746.git.1718130288.gitgitgadget@gmail.com/

> So without seeing a strong motivating usecase for this feature I'd think
> that git-mktree(1) should reject such inputs and return an error such
> that the user can fix their tooling.

Practically, there are a couple of reasons that led me to wanting this
behavior. One is that it allows using data structures with more rigid
integrity checks (like the index & cache tree). The other is that, once the
ability to add nested entries is introduced, the concept of a "duplicate"
gets fuzzier and blocking them entirely could lead to inconsistencies and/or
limited flexibility. If, for example a user wants to create a tree with a
directory 'folder1/' with OID '0123456789012345678901234567890123456789',
but update a blob 'folder1/file1' in it to OID
'0987654321098765432109876543210987654321', the latter is technically a
"duplicate" but rejecting it would avoid being able to create the tree
without first expanding 'folder1/'with something like 'ls-tree', replacing the
appropriate entry, then calling 'mktree'.

> 
> Patrick


