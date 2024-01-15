Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D51DDC1
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkyYcgNa"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e800461b1so1292705e9.1
        for <git@vger.kernel.org>; Mon, 15 Jan 2024 02:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705315719; x=1705920519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EWzDXIedIJ9KK4z7vBdmiM05InD7nRGIABNZwBu6PeM=;
        b=CkyYcgNaT6kzh7P/VWKkizka11/MkKdhT4NGlPSe+xMp9BuU4Qc4WIQTpoz47mo1FR
         L05b87qYbYndVRLndclkW0+xYm3Gebj2sGtzEGdor0iuy0YOh4xBxQbvUwiQlsZrABtG
         ZZaKMnpAVbyOfu16ZbHDEcRSkIK2JIL5uFQRO+xDseNp0k+dWpub4qpU00WQOMoUcwvf
         hYo8f8wyog3ldq0Vc8YESHulheUJ3FaF6mrYqGupcw0uu+IUWPX29hIMywJ6BmhrcTtY
         4oDZjb7/KDnWRhvrp90MTSskLdkOdi7M1J87CvwfK//HlMgL3can4RURsc6aLMRZGjMY
         EaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705315719; x=1705920519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWzDXIedIJ9KK4z7vBdmiM05InD7nRGIABNZwBu6PeM=;
        b=SL1KMPDStrnJWQP04187tyuFqWQcqNJXGUqvW2HX3J68Me+VO7H8CcGJ+jyoPQ5Ier
         0xiF+4KnY8gpPRPCVwKTnxbp3gQ0b9WbZ2+ruhPFRJWlvrBImd6vnyqanXUeuF6YIMVw
         9yW/iYIGRJi0ICELb7YYSjfr8HSdNI36+Un8FBJMynXpp8x6rznWI/lb7ERsDE/qribF
         AHw6QW11M1zkAWNOD1PMlGDlRFTzENwSuJGK3MOBtIoIoZsvGvKtbNjAOozjEm9pUdwt
         Omy5QVxDQlnIyyC7aUTMmJR6ewJEJwONaV488uMZKsenHaR9Mr6iRzVCkwjI3vpC34Vt
         1+ow==
X-Gm-Message-State: AOJu0YxXq74jUu9cufMkp7eTaxM8rrX6M6irxLa/l54DVeIVJXj6YFFo
	+tzkNhsUNAHvE/a72xga+5/T+VhP7gc=
X-Google-Smtp-Source: AGHT+IEOduxLDdlnUXfIt0btUZwGaJ5t5I1ZP4cSmeFMkcijeDj1N3ZKvo+nHHQojnvZJqZIOCB2iQ==
X-Received: by 2002:a05:600c:1649:b0:40e:555f:12ca with SMTP id o9-20020a05600c164900b0040e555f12camr2339580wmn.135.1705315718778;
        Mon, 15 Jan 2024 02:48:38 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id g7-20020a7bc4c7000000b0040d5c58c41dsm15094324wmk.24.2024.01.15.02.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 02:48:38 -0800 (PST)
Message-ID: <648774b5-5208-42d3-95c7-e0cba4d6a159@gmail.com>
Date: Mon, 15 Jan 2024 10:48:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] `log --merge` also for rebase/cherry pick/revert
Content-Language: en-US
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk,
 Junio C Hamano <gitster@pobox.com>
References: <47a4418b-68bf-4850-ba8b-1a5264f923e4@gmail.com>
 <20240112150346.73735-1-mi.al.lohmann@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240112150346.73735-1-mi.al.lohmann@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michael

On 12/01/2024 15:03, Michael Lohmann wrote:
> Hi Phillip,
> 
> On 12. Jan 2024, at 12:01, phillip.wood123@gmail.com wrote:
>> I should start by saying that I didn't know "git log --merge" existed before
>> I saw this message
> I also just found it and it looked very useful...
> 
>> so please correct me if I've misunderstood what this patch is doing. If I
>> understand correctly it shows the commits from each side of the merge and is
>> equivalent to
>>
>>     git log HEAD MERGE_HEAD ^$(git merge-base HEAD MERGE_HEAD)
>>
>> When a commit is cherry-picked the merge base used is CHERRY_PICK_HEAD^ [*]
>> so I'm not sure what
>>
>>     git log HEAD CHERRY_PICK_HEAD ^$(git merge-base HEAD CHERRY_PICK_HEAD)
> 
> Almost, but not quite: "git log —merge" only shows the commits touching the
> conflict, so it would be equivalent to (I think):
> 
>     git log HEAD CHERRY_PICK_HEAD ^$(git merge-base HEAD CHERRY_PICK_HEAD) -- $(git diff --name-only --diff-filter=U --relative)
> 
> (or replace CHERRY_PICK with one of the other actions)

Thanks for clarifying that.

>> Indeed there HEAD and CHERRY_PICK_HEAD may not share a common ancestor.
> 
> True - but same for MERGE_HEAD ("git merge --allow-unrelated-histories"). I
> have to confess I did not check how it would behave under those circumstances.
> It could either error, or (more helpful) show the log touching the file until
> the root commit.

What I was trying to get at was that with "git merge" "git log --merge" 
will show commits that are part of the merge. With "git cherry-pick" 
that's not the case because we're selecting the commits to show using 
the merge base of HEAD and CHERRY_PICK_HEAD while cherry-pick uses 
CHERRY_PICK_HEAD^ as the base of the merge. I think Junio explains why 
it is still useful to show those commits in [1] i.e. they help the user 
understand the conflicts even though they are not part of the merge. It 
might be worth expanding the commit message to explain that.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/xmqqil3y9rvm.fsf@gitster.g/
