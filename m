Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85412328DA
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="Felm5KJS"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2382B10C1
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:41:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b709048d8eso5137861b3a.2
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 10:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1699382491; x=1699987291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2sRFIzYRt3Yv/Xbx1hjMt0b4VJYMvXCSflAa9sp/nE=;
        b=Felm5KJSc4jch43gDCHHk0Y0yCOcnCe3vlIhsbPt82LJcfbLJUWcY4Z0ukDOSTRwZF
         lDaayGXj3sWnVf3GAP9jwLKpML1rtB2/4tgahFMN0jb9l4cd5KBnI9Ra6hef8OU2sDZs
         iPwCdG30etS0w8XJBF0Yz2M4di/Ah5VpXJPu9w9SD5rL+QB9cN4H2FT1RbMKR/C9DCMT
         fwjQ3cbgztHkN2t7HoCSvU6lt+cNjchcmNNxlDRpp0uEfuBBwy0tuhc+wnv1/vntPlj9
         FhbryCUOWIoL//2DOn6HIkUW4jPCN/rbwdKSynmh310qdVFfya4YkJEZyUS9gY385vea
         xLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699382491; x=1699987291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2sRFIzYRt3Yv/Xbx1hjMt0b4VJYMvXCSflAa9sp/nE=;
        b=md31PBfI4DlXU7WYSj6a2np6xEnsFyPXVndm6+20bbKHnePrUrIdxry/LHJ2moEVGS
         b96bMTze5b5+rfwoHdus+dRAzes1+tk7na6LM0uAsEqU5Bo//iWcGTGcci9SdDpREC+r
         eJrhdEyl3RFW7uKTuc3PQSgXVUq6niNmTQbD6xDiv3mXhKZcekUtk9LxRHVx7RSHodFi
         jdYKp9W55Snk5vyeOj6bvDwSywGLeJyH/dWdh1uKIeWIGLTfJ//+CqZFWrYQPIPcUY2r
         +ug1fCauun4SVbUvqEye+kSuv/LrNJzAdKMih6u9P7FeOxEWFIXDXpNC+D9ZpI1TzCN8
         pguw==
X-Gm-Message-State: AOJu0YyALHAew8MrFus9AtKRb1HdlvD8iVunyl0Vou6rhW6Til0T4YmV
	lzHABE9hcQc84dSf8nSh7Nkp
X-Google-Smtp-Source: AGHT+IFt0PoL+G4yhrAw5LFAmAHQVMFcWWLxXqFdDg+tN3PwZfuVtusOC5Q4lrtNCSdPRvdgrMehvw==
X-Received: by 2002:a05:6a00:1505:b0:6be:2649:8c6b with SMTP id q5-20020a056a00150500b006be26498c6bmr30035488pfu.32.1699382491549;
        Tue, 07 Nov 2023 10:41:31 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id h15-20020a056a00218f00b006c3467ae25asm7480712pfi.206.2023.11.07.10.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 10:41:31 -0800 (PST)
Message-ID: <ecd7b723-0ff7-412b-a332-8c011ff12f86@github.com>
Date: Tue, 7 Nov 2023 10:41:30 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] ref-filter.c: refactor to create common helper
 functions
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <8c77452e5dd8d5cafd95c68480bf5675d51b4736.1699320362.git.gitgitgadget@gmail.com>
 <ZUoWT8GyrZlvH_Go@tanuki>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <ZUoWT8GyrZlvH_Go@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:
> On Tue, Nov 07, 2023 at 01:25:58AM +0000, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Factor out parts of 'ref_array_push()', 'ref_filter_handler()', and
>> 'filter_refs()' into new helper functions ('ref_array_append()',
>> 'apply_ref_filter()', and 'do_filter_refs()' respectively), as well as
>> rename 'ref_filter_handler()' to 'filter_one()'. In this and later
>> patches, these helpers will be used by new ref-filter API functions. This
>> patch does not result in any user-facing behavior changes or changes to
>> callers outside of 'ref-filter.c'.
>>
>> The changes are as follows:
>>
>> * The logic to grow a 'struct ref_array' and append a given 'struct
>>   ref_array_item *' to it is extracted from 'ref_array_push()' into
>>   'ref_array_append()'.
>> * 'ref_filter_handler()' is renamed to 'filter_one()' to more clearly
>>   distinguish it from other ref filtering callbacks that will be added in
>>   later patches. The "*_one()" naming convention is common throughout the
>>   codebase for iteration callbacks.
>> * The code to filter a given ref by refname & object ID then create a new
>>   'struct ref_array_item' is moved out of 'filter_one()' and into
>>   'apply_ref_filter()'. 'apply_ref_filter()' returns either NULL (if the ref
>>   does not match the given filter) or a 'struct ref_array_item *' created
>>   with 'new_ref_array_item()'; 'filter_one()' appends that item to
>>   its ref array with 'ref_array_append()'.
>> * The filter pre-processing, contains cache creation, and ref iteration of
>>   'filter_refs()' is extracted into 'do_filter_refs()'. 'do_filter_refs()'
>>   takes its ref iterator function & callback data as an input from the
>>   caller, setting it up to be used with additional filtering callbacks in
>>   later patches.
> 
> To me, a bulleted list spelling out the different changes I'm doing
> often indicates that I might want to split up the commit into one for
> each of the items. I don't feel strongly about this, but think that it
> might help the reviewer in this case.

While that's a good guideline to keep in mind, it's not universally
applicable. In this case, (almost) all of the changes are done the same way,
focused on the same goal: extract bits of 'filter_refs()' into generic,
internal helpers so we can use those bits elsewhere in later patches.
Splitting those extractions into multiple patches would essentially lead to
a handful of very small patches that more-or-less have the same commit
message. As I mentioned in [1], I think there's value to having the
immediate context of related changes in a single patch (as long as that
single patch doesn't become unwieldy), so I'm not inclined to split this up.

That said, I did say "(almost) all" of the changes are conceptually similar.
Looking at this now, the rename of 'ref_filter_handler()' => 'filter_one()'
doesn't really fit the "extract into helper functions" theme of the rest of
the patch, I'll pull that out into its own.

[1] https://lore.kernel.org/git/a833b5a7-0201-4c2e-8821-f2a1930cb403@github.com/

