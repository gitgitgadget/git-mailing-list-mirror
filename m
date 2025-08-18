Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C07F321430
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524583; cv=none; b=uuTzHDmRgsgqSLKNQg4cN2ed+C3j0yzwn4ZIhtd5/cxfFln1Yy+0hPAaibzvqRhCux520d3GK7oufoKir0jV5BV+mxKvhRW1MYw3hNzwp7fbDjFC7cCF7VjWUcX72AIFJal+wbBCsfCBu7BySJyW6r7ZNykWal4rz2BG9+ETA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524583; c=relaxed/simple;
	bh=KJbBUPu5ryRnx6v/+IRD6uaWPGgGQnZSCFdxu2owjks=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kdkqGSvMSovXeDLa2bA6KSaI/LHWOemeuC/X2oSuM1Hdq+ztM8pNA3foAlJoOsAmzmuI5HBcCa9oJPW695bho1IhbHdC8n2KIL0IaMmYthIlbGPQRzo7s8PELqXTcf+doOdQG9EGPk81lNZHleLI2KtKyuTSfi44SVoVAQOsX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdF2TIio; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdF2TIio"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b00a65fso20572905e9.0
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755524580; x=1756129380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SE8JXK2s4SrsL/zBBXw3VKtQ0WTHtvbITuTSU+FqJwE=;
        b=EdF2TIioCvq95+lXlzE/C8oIY0A9qD5r8mj8fmhtYdNNV0z1oFQ0VdbkglYDvn44y7
         lztr9lcGtUyxU533teeAgoReztdaYpsw9ooLps8bTOK+N5ru5G7L2VNUuiEtnRzl7MEk
         rFZm6duZTd6OD/XqA4Eaa2lo4yXXuOVwhA0ew5CXQSXXqI0VFc7HMhX5qgjYYKCG3tmj
         GAgYAaaj1wCB7du5R7RAd1w9eHRDF6tzjyvVoVykyZLi77F1E2mtwusUjgH7t4N/1Zgk
         U+szdpKYUuyP0f+PxCucF/SMwzQgfO+RVrlr7LNaXwVfiu329VZoFBe6ave97BnWFx1t
         9OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755524580; x=1756129380;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SE8JXK2s4SrsL/zBBXw3VKtQ0WTHtvbITuTSU+FqJwE=;
        b=nCdYfr8/LDbadKcX6CU+Y8XKPN908VT/iBtPn4uOaCp1cfu9aHYSTCGtFnLbDB49js
         kupN8U9Xdh6MB0vF26AbT/Kw/KHliafbwFE3RaNaJiqsZTzo2ghYgr1Z4InzqL8BUKCe
         Yt4dLjjdif4KN1fF78g07F7LO4hAP61WVSh16qgT42pcx2Q6NdKh7P4P0S57GtPRYw15
         QMbdwaRyu8GqzZk+e9FwZxjwvAJnX4TXF+8yAIja9D1ySjsjnQBs6HZmut3FJUf1JZJq
         rKI0Wq9rthuhb4Q8OvydkosO0qHy6HymWkLlgReEKzLOyNaDOu+IJnOkTlytGrAsz6fX
         kg9Q==
X-Gm-Message-State: AOJu0YzlZx7/VCY2M97aMyQUa07ZdqKCDAgzUWPLsqWmBMLWn1fYP9YD
	G6L+qTrjS3FX1j1o7SG0/fnf6SnovAb1rGKP4c3+/eN1N36fwMhLpsEAfr3o/w==
X-Gm-Gg: ASbGnctgksDsYXl31w/PumyVhDBAczGg6bXm8eCtXYpiwyzB/+LcAv6CjjPYFgl3A+o
	wENYsaAqDdRlwB7zjxmSfYC4GVvjBp19w6GNOp5cG44TjghkIY+u83+aAX12x+DSIdwaJOmgvzp
	jsdNRw31CXign5A1SMIn3ygH8PH5h9ZOAdsEGPHf3roMolUzRK33PfJfM5yHD7z4EmHF8dZJYda
	XZLF9FH6NyhQWJAEDHLlZ5U+ZX0x9pwLB8tBc+1bAm/3LPkGIZudx7DUHeRWqtlb67ov+o96FSX
	6IzGYq5Wfreje03jFGbviRz9FOnBreceCcwfqf0IOW8OMRWgJqx24WT2ZlWep+c0AAkwluLujxL
	tCKCyEdIjG1bOeTX2Pl0GJ+wNWoRx88B6WKV/Fc7wotWKSRY1YdY4TLmGPT52IZPYeJ6lMJvh68
	xS5BSHGLlNFtQh
X-Google-Smtp-Source: AGHT+IEtO17U+V0FUsv7EjM4tc7gu4Um/iUPb76UX5IFXe7qAHpeVhcK74XwGvC4uixfvLFb2UFoWQ==
X-Received: by 2002:a05:600c:524b:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-45a291681fbmr51047275e9.6.1755524579303;
        Mon, 18 Aug 2025 06:42:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc85csm173530375e9.5.2025.08.18.06.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:42:58 -0700 (PDT)
Message-ID: <51468411-8251-4f13-90f2-5cd5184d7c52@gmail.com>
Date: Mon, 18 Aug 2025 14:42:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 4/5] doc: git-rebase: move --onto explanation down
To: Junio C Hamano <gitster@pobox.com>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
 Julia Evans <julia@jvns.ca>
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
 <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
 <4686417b28e4ab386983ad68e4d4d4798a467811.1755276751.git.gitgitgadget@gmail.com>
 <xmqqh5y8nvmv.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqh5y8nvmv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2025 22:05, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Julia Evans <julia@jvns.ca>
>>
>> There's a very clear explanation with examples of using --onto which is
>> currently buried in the very long DESCRIPTION section. This moves it to
>> its own section, so that we can reference the explanation from the
>> `--onto` option by name.
>>
>> Signed-off-by: Julia Evans <julia@jvns.ca>
>> ---
>>   Documentation/git-rebase.adoc | 168 ++++++++++++++++++----------------
>>   1 file changed, 87 insertions(+), 81 deletions(-)
> 
> Deduplicating is very good idea.
> 
> I gave a read-through over the result of the entire series,
> including the parts that did not change, to see if the new
> organization is easy to read and coherently tells the story
> we want to tell, and what I saw was mostly very pleasing, except for
> one thing.

Yes the reworked DESCRIPTION section is very good.

> The new location of this section on "--onto" felt a bit off.
> Perhaps it is just me, but in case others have different opinions,
> I'd raise it here.

I agree that "--onto" is a fairly commonly used option and so it might 
be nice to mention it in the general description. The existing examples 
are all good reasons why one might want to use "--onto" so I'm slightly 
wary of replacing them with a single example in the description. Maybe 
we could just add a sentence to the description explaining that it is 
possible to transplant the commits to a different base using "--onto". 
That would also keep the description fairly concise.

I've just built the html version and it would be nice if we could add a 
link to the TRANSPLANTING A TOPIC BRANCH WITH --ONTO when we mention it 
in the description of "--onto". The same goes for the mention of 
INTERACTIVE MODE in the DESCRIPTION section.

Thanks

Phillip

> The overall structure of the document with these patches becomes:
> 
>   - description that gives a simplified "what is achieved".
> 
>   - "mode options" that control what to do during a rebase once the
>     user is given control back
> 
>   - "options" that is given upfront
> 
>   - notes about incompatible options
> 
>   - discussions about apply/merge backends and how they differ
> 
>   - overall notes on advanced topics
> 
>     - interactive mode basics
> 
>     - splitting commits
> 
>     - use of --onto
> 
>     - dealing with rebased upstream
> 
>     - rebasing merges
> 
> Is it so exotic to use "--onto" to replay a topic to somewhere other
> than the direct descendant of the fork point, to make it a part of
> advanced topics?  I somehow doubt it.  It is a very basic and common
> thing to do while correcting a mistake of choosing a wrong base
> commit.  You often realize that your topic is basically good but has
> to work well with a different base commit.
> 
> I wonder if it gives the same understanding with a much shorter text
> and illustration if we get rid of that section, and mention --onto
> as a part of the early examples in the description section.  That
> way, we can reuse the "set up" of user's brain and context we
> already made with the existing example.
> 
> For example, after showing the rebase of A..C on top of G, we can
> mention that the range can be transplanted on top of commit other
> than G, say D.  Perhaps we can say that 'D' is still part of the
> maintenance track, and the topic being a fix for a bug that happened
> before D, it should not have forked from E that is a feature
> enhancement commit that is not eligible for being on the maintenance
> track.  That would be a good reason why the user may want to move
> A..C on top of D instead of E.

