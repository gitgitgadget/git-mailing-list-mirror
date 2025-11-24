Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B2229293D
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001916; cv=none; b=f+ytaDUFM0rHbuxlf90nfRYeQPKvZRy90wkkk1uk+IN87fjI0fw0F5pXS31PVNeDUXQNaLO2T1GKygC8mIK8Z1zQHjAGw6GC6AnT71dLWPDxqDgtsyr7WswGcEHb/gtyK76JZQsHsLEnyAZVQXLEyitAzYDtQE14F+/gvYkyxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001916; c=relaxed/simple;
	bh=wRtCHgiKC6wowS6Gjrf44jyaAjKA9f1hFdZlWgR7r6g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K0eu/SZ+teP3ma9BFTMiMD+xJbv3QaAdsIQ3GIaGrjHEbuMpcx7rtSAQhbzg/kxhq9cmtzl2RurK3yz+zj7Wik7tAUspJQgiPAyNTXqaGwX/L3hKI3I8fNErTkQ1/2sy+JthHAp+C6JANJKcNFZ4nENWFLZhJEyuvBXopD5IBz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaLIkz9Y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaLIkz9Y"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so47153715e9.2
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 08:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764001912; x=1764606712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZhGmc6bgYmQPUheAWEVBNLD2YFBgBWonMUPwnWln+c=;
        b=TaLIkz9YDail4Mo98HfNMTLLxDt5eOV83kDy3o/YAU1wxwHybcJ3otwXTjm77hq7nD
         d+m4gzFoRjsAfItWThLKbEHBrDhZHyQ7S64rvYq1lmy8EzL/5/SPKfywwUHLEbzLwYv9
         mWVBOvZi983rCZ5ZdYwk79UYfNBwEridv/qmmilbYoIgSnjeInHFXSyRx2ATaHQ2GA13
         ZA2t+1nQcvCjZI0UEeAPij7HSmdTPZElnGyK2DfSgTFxFLMWeyMlPmvcrLEg/sbHAO4J
         Yq31VLKAJ2PFB8qtph32VNcyGthyxFNX1b673ttFx2sLxVYd7wfbNOB5Rbcd4V8gx4IY
         +sjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001912; x=1764606712;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZhGmc6bgYmQPUheAWEVBNLD2YFBgBWonMUPwnWln+c=;
        b=az1/C62jFjDr9qkRFiTtFI4SO3eQxz06MJwCLtRw5CiSBAJZ9T7X9rmlZST8imt0Ds
         yMtTnF9pgbxZvRRmLkpfvrEEGQd/M9mcMGVNxM850T7yvaMIu15m856Ikc01UVK8QV34
         wghY71yw0mSW50C3Gfo0ucYJoa5HEWxkArnTwL49rQDCs1CbNuMi8XTL5Nogl1Sw/6OS
         pp1ncX2+kfY+Ls6afu+V+SB7UNppEsBytK6e21+qH1N7S2mSllXowayVXuQKPvYrNWtT
         eCb2TauO0Da1DrMjmhdZ/yauPMnZ2KaFN7xgt/4R/dGyySdKP+VA4bOSvCnuVD+T7dMS
         3R6A==
X-Forwarded-Encrypted: i=1; AJvYcCWUxqPYVoHj0J8VWfsEScYNUUVlMrgsaXzvB0mYxdftWRpmyonTQ6T8DChinlLDDpmJYyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQ1Ca4PjVYQG5cSyJKw8N3pbMVyndww4hgG8QUcjVkR6adDUA
	mTI9UcoSISva+EUXFajUJZe9c8Ny78XEBnVyedTKT1YNxyJ9VWP1OJjy
X-Gm-Gg: ASbGncvfLJcBDeGnpQhNalb+y3LKtyk/jbEOTf+cXh+3kiA1bI5XkBoLYcqYILW/6T0
	q/rOLZL2P53cihHx1FJlIRSfQ7GsL5vywZSZafHkNexuHRH78aT2qtauJUeYg82VqhyfA3+U48k
	sAAU92T4WKcdc3pUuwQXSeVSe69LAzLzDgoflD9xC8taSp4GufQUe/ymNZSYyF8ksrf0DDoUQRx
	cqmaZZGJq+fpKKOhGx3hutAaamOIJc8YweVL49HQway3Aq0gJ2DzAbjG3uPKLUirYDZqhPUMjJn
	pWivIWsHmA4/0wLM7doaAOiM/G1xtltuy6Ye95Z2N4tX06HXvh4e1XOaWXabdchbzOIQWULbQUK
	KflOMMJbmu1WAH1g6yqq4Q3KFA1D7uSXojBPBb27+gn7imIkLmebOm8E0KRWH7ir98pC6qflTsG
	LOGjySetpsldEtZlKMNPtk+YiYLXHd0nfgSeJv5SCSOhc5luNO5jW1YpM/mh1LsCc=
X-Google-Smtp-Source: AGHT+IGw3B9mKQD92eNARmUbCdgdFbcTNVyU5gAfGdVuDimnQTXpTTbEFfJSzMI+1lzxaosWlNNuiQ==
X-Received: by 2002:a05:600c:4451:b0:46e:4a30:2b0f with SMTP id 5b1f17b1804b1-477c01f2d58mr123936555e9.29.1764001912191;
        Mon, 24 Nov 2025 08:31:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3b4fafsm207017845e9.14.2025.11.24.08.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 08:31:51 -0800 (PST)
Message-ID: <d9194329-266e-43df-ba11-933ecf83b8f8@gmail.com>
Date: Mon, 24 Nov 2025 16:31:44 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
To: Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?=
 <jn.avila@free.fr>, Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g>
 <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g>
 <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com>
 <CABPp-BG-tLuydXkctsitFzozEq-=A+qTf2qOe1vYm+NeRnWsOA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BG-tLuydXkctsitFzozEq-=A+qTf2qOe1vYm+NeRnWsOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/11/2025 02:30, Elijah Newren wrote:
> On Fri, Nov 21, 2025 at 6:31 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
> [...]
>>> So, you are referring to the single branch, HEAD-centric piece of the
>>> feedback.  The funny thing there is that operating on a more limited
>>> case, without checking and verifying that you are indeed in the more
>>> limited case (and erroring out if not), risks painting us into a
>>> corner or providing some really buggy behavior when we aren't actually
>>> in that case.  To me, it opens a can of worms and makes the problem
>>> scope bigger instead of smaller.  Funnily enough, the single branch
>>> thing is also the one piece of this that I think could be solved by a
>>> fairly small change in the reroll (and I pointed out how in the
>>> comments), so the limited view really didn't buy anything here IMO.
>>
>> I can't find that comment. Are you referring to reusing more of the
>> replay machinery?
> 
> Yeah, what's needed is the equivalent of running "git replay --onto
> ${NEW_COMMIT_ID} --ancestry-path ^${OLD_COMMIT_ID} --branches", as
> noted in more detail over at
> https://lore.kernel.org/git/CABPp-BEm1QBP+CuSOn5FaE3XJVFg+Qbfzdp560u00ZERbNm6qQ@mail.gmail.com/

Thanks, I'd somehow missed that when I read that message the first time

>> If so we have the problem that the user gives a single
>> commit to "git history" so we don't have a handy revision range to pass
>> to the replay machinery unless we assume we're rewriting an ancestor of
>> HEAD or we go and find all the branches descended from the commit the
>> user gave us.
> 
> The range is included in the command above: "--ancestry-path
> ^${OLD_COMMIT_ID} --branches"
> 
> And because of this, we don't even really need to "find" all the
> branches as a separate step, it's just part of the same revision walk
> for rewriting commits.

Oh, so --branches means we consider all the branches and --ancestry-path 
excludes the those that are not descended from the commit we're 
rewriting - nice. We'd need to be careful about modifying the commit at 
the tip of a branch though as in that case we'd exclude the branch from 
the set of commits with ^{OLD_COMMIT_ID} and so "git replay" would not 
update that branch.

In general rewriting multiple branches can be confusing if those 
branches are checked out elsewhere and the HEAD of that worktree 
suddenly changes but for rewording and splitting commits as implemented 
here the final tree is the same after the rewrite so it should be fine. 
The other potential problem with rewriting multiple branches is that we 
need to ensure two separate "git history" processes running at the same 
time in two different worktrees don't try to update the same branch. 
"git rebase --update-refs" has some logic to prevent that.

> Whereas if we do want to only handle a single branch as the current
> implementation does, then we *need* to do an extra revision walk to
> ensure that the commit is not also part of any other branch and error
> out if it is, because disconnecting the histories would be very
> counterintuitive in most cases. 

Oh - I had not understood what the "extra work" you were talking about 
before was - that makes it clear.

> If users really do want to disconnect
> histories of two branches sharing a commit, we should require the user
> to provide some flag to explicitly specify such to signal that it is
> okay for us to bypass such a check and just rewrite one branch.  Such
> a check is missing from the current code.
> 
>> Long term we should certainly do the latter but depending
>> on how much work it is to implement that we may want to go with the
>> single branch case at first
> 
> I showed the implementation of the latter, and it's actually (much)
> less code than what's already in this series; see the
> replay_descendants() function I posted at the same link above.
> 
> My replay-edit work used a just slightly modified form of that
> function, because editing a commit and replaying all commits from all
> branches that reached the OLD_COMMIT_ID, to now be replayed on top of
> NEW_COMMIT_ID, is exactly what was needed there too.  (If you're
> curious about the modifications: I had an extra --brief-stats option
> because I found it nice to provide some user feedback about what was
> updated, and I pulled the "--branches" portion of the command from a
> ${GIT_DIR}/REPLAY_EDIT file, because that allowed me to give users the
> opportunity to disconnect histories via some mechanism that would put
> a single branch name in that file instead of "--branches".)

Interesting - I watched you're git merge talk about it recently and it 
looked quite impressive.

>>> I'm also worried about extended header handling for the edited
>>> (reworded or split) commits.  That seems to have been overlooked in
>>> this series, despite the fact that in early versions extended headers
>>> were explicitly called out for the remainder of the commits being
>>> replayed/rebased, so it seems interesting that they weren't considered
>>> for the commits explicitly being edited.
>>
>> What headers does it make sense to copy when splitting a commit? When
>> rewording it is more likely that copying the extended headers is what
>> the user wants but the example of the "encoding" header you gave does
>> not make sense to me as we re-encode the commit message and author data
>> when the user edit's the message so we're not preserving the original
>> encoding.
> 
> I agree that when rewording we probably want to copy most extended
> headers, but you make a good point about encoding.  For splitting, I
> agree it's less clear, and I'm not sure I know the answer.  But I
> expected the topic to at least be discussed and mentioned in the
> relevant commit messages.  It appears to have been silently
> overlooked, and I'm worried it's the kind of topic that doesn't come
> up often, meaning that if we don't discuss now and just pick whatever
> behavior we get from implementation side-effects, then people will
> come back in a year or two and point out we got it buggy but it's too
> late to change it.

It would certainly be worth adding a comment about commit headers in the 
commit message.

Thanks

Phillip

>>> And I'm a bit surprised that the original commit message for a split
>>> commit is automatically associated with the second commit; if I had
>>> been forced to choose, I would have assumed it should be associated
>>> with the first.
>>
>> I don't think it is safe to assume either - we should prompt the user to
>> edit the message when creating both commits and seed the editor with the
>> original message.
> 
> That sounds like a better solution to me for that particular issue,
> and probably wouldn't be hard to implement.

