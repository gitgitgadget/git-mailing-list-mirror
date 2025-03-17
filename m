Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D9218787A
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231150; cv=none; b=R7x37wqetkyx1mnuBPCCQOZ27VfDElbUIuHTRbCumBkQJKuxNVB2VE0OmVNtD6VOcOT2wMBNbnPtHBIyQbuStB8/kPfKvwgIWuhZ+k3nv89UeeVmvCOOqMHLA4x0SS6RdkW0FZ7m58SIEswEaSwyOsOG2CNymzArrmfGSnqfyCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231150; c=relaxed/simple;
	bh=1Lct27ps85KAzZx0t+S7/OIqeM4AkucuOFXieJkjybE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzHa/NQJE8CWAccl8c/uscMHn5VUcENhjFNt8caC38bz39p63h27vymERLNQi5mThVyvoa9Ytu8873GtSSyTG9m3aswB19nNFXA1yJMTuiT7L8LzGZNtdl9DrWoc8YLG90rOdKarOOKeSair8zmnSzjV1kkHuAhvG1k4CHd7chE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF367hNR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF367hNR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2255003f4c6so80363825ad.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 10:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742231147; x=1742835947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0YlXTxHj+sdq7+/c8BI2fFi0U5/qQpp5X8i3D3JCfj0=;
        b=hF367hNRBwcRp0rB43/bXoQ4gmqRcHECYubeafxOX4pRsCvG8ylqiPPMF5qM16IzQP
         7kSq6CQXHw5LAtZMYJJFAt/zJP6XaM9YTwzETUaQG/oF/pf9xeOLikK/BEzWalW+zB4o
         rCEit8EJo0BdBLB78ABUA74twXXuYX9dVNZRGw+tCIeQ3DDnlYsAZLejNYuvqIcSwwzy
         Nix5ajLysavCBtVSMhq9d+wVVSkEEg+1mwOKqZsADKdEj4hhoKMLdHESbOvHsgxQ7Olm
         W1lGa1NGR+Y4GHM3947rxKemL5WBIzZC//vFG27r8+jYf28GofmRvX78uonsSTb6JX0m
         DuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231147; x=1742835947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YlXTxHj+sdq7+/c8BI2fFi0U5/qQpp5X8i3D3JCfj0=;
        b=XT4E2nqizHhCDF4qltzQy5jKxrGNbFcyrMP2zor4FZP5MUtRvToAtC2j4gT0xMt/jM
         2V9px/k17iZpqUmwY7aNn9QxQO2w9DUNC4fV9lq440fudHQ5AF3g2T+UrBndAkVQWIJ5
         dn4dPyEDOwNbgyQcHXLJh3yi/B2qFN+6ck0dlTdggc5uvG6DU6kCkfYF4Xd6n4BMp8+N
         r5u1e6XQvZNfd7X49yWeF54JYNvfW8tvF94DrQbCPVjoFUpZPflamIUUlaQ05UAlScAp
         06aVp94TZd2aHVKPfxSF0Bg8xxm5Kk18rqswIQFEWagDPBTShufeYn0BnVoaITWFqMzq
         rhrQ==
X-Gm-Message-State: AOJu0YzRhbDXERGWAtcEaiYEATg9OHDqvqfabCJCH6CO89S9CtjXiMeL
	cQBZRYu2WTnH7wlA/762bkmB0gfL0VNHEo9mtlu6OfM9NQyIoAyU
X-Gm-Gg: ASbGncv3x+WWg/AO1oXJZB/m7cZ5z2nF3CF4Hv8iROjfk5JyTsO0PZwzGdT4mAhltRs
	28bJAVhGZB/y1LUcJKWWIQnE9C2q4BsLON4QzyFYVN2eQifGl+cQ7pb1CTuhyzQoCCL4EpVrXIY
	F4XOHym0oR9VmcWUeSUj6A2d6ucTrQkCSo6QBNJyLxdXfq8h4AN/9eyUE+U7LZKKrmGNVKJQYN5
	WqZcC4AaWMQxSy5ztHUI/UYgjOpEV5qdSRybZlIRkFqbkfr8TZG0zpNF9Z4BlsJrm9/e8NdoSN6
	TiHNwFfuMPn9hqutFJz8852Rt4KxubrXhGkbVlIn/JxG0rOnbLNCDwWZj7qUp2Y=
X-Google-Smtp-Source: AGHT+IHgVzhFunM2yqHxUmEAeCnnogllpq0muHPoRYj19RhIVscYAYNV4ghO5mO4iFNpzV8tM8sgyg==
X-Received: by 2002:a17:902:da82:b0:215:89a0:416f with SMTP id d9443c01a7336-225e0a92d7fmr142501735ad.30.1742231147360;
        Mon, 17 Mar 2025 10:05:47 -0700 (PDT)
Received: from [10.53.2.153] (125-86.iitb.ac.in. [103.21.125.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4095sm77953405ad.66.2025.03.17.10.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 10:05:46 -0700 (PDT)
Message-ID: <741cda93-5dd0-4e7c-9ecf-66af84603cca@gmail.com>
Date: Mon, 17 Mar 2025 22:35:43 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v2] rm: fix sign comparison warnings
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
 <71098ea7-9136-4ab2-8e15-27017773e054@gmail.com> <xmqq1puvbo3s.fsf@gitster.g>
Content-Language: en-US
From: Arnav Bhate <bhatearnav@gmail.com>
In-Reply-To: <xmqq1puvbo3s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano <gitster@pobox.com> writes:

> Arnav Bhate <bhatearnav@gmail.com> writes:
> 
>> -static int get_ours_cache_pos(const char *path, int pos)
>> +static int get_ours_cache_pos(const char *path, unsigned int inverted_pos)
> 
> This renaming of parameter is not right.  
> 
> At this point when the value comes to this function, it *IS* the
> position, there is nothing inverted about it.  It points at the
> position in the .cache[] array where an cache_entry at a higher
> stage would appear.
> 
> It is perfectly fine to state that the value that is returned from
> index_name_pos() is potentially inverted.  The function is given a
> path name (without any stage information) and
> 
>  - returns a non-negative number, the position in the .cache[] array,
>    where a cache_entry at stage #0 (i.e. an entry for a path that does
>    not require conflict resolution), or
> 
>  - returns a negative number, when there is no such cache_entry
>    exists.  The caller can "invert" the value to recover a position
>    in the .cache[] array, where a cache_entry for the path at stage
>    #0 _would_ _have_ been found, if existed.  Due to the way the
>    cache entries are sorted in the .cache[] array, when you are
>    interested in finding cache entries for a path at higher stages,
>    like this function is, you can start scanning at this point until
>    you see an entry for a different path.
> 
> Calling the parameter "pos" is the right thing to do.  The value
> used to come here _could_ have been called "inverted", and the
> result of (-inverted_pos-1) can be assigned to "pos".  But because
> the patch moves the inversion to the caller, what the code in the
> while loop sees is no longer "inverted".

My logic was that it was the inversion of the variable pos, but your
logic makes more sense. I'll make the change.
 
>>  {
>> -	int i = -pos - 1;
>> -
>> -	while ((i < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[i]->name, path)) {
>> -		if (ce_stage(the_repository->index->cache[i]) == 2)
>> -			return i;
>> -		i++;
>> +	while ((inverted_pos < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[inverted_pos]->name, path)) {
>> +		if (ce_stage(the_repository->index->cache[inverted_pos]) == 2)
>> +			return inverted_pos;
>> +		inverted_pos++;
>>  	}
>>  	return -1;
>>  }
>> @@ -58,7 +55,7 @@ static void print_error_files(struct string_list *files_list,
>>  			      int *errs)
>>  {
>>  	if (files_list->nr) {
>> -		int i;
>> +		unsigned int i;
>>  		struct strbuf err_msg = STRBUF_INIT;
>>  
>>  		strbuf_addstr(&err_msg, main_msg);
>> @@ -83,7 +80,7 @@ static void submodules_absorb_gitdir_if_needed(void)
>>  
>>  		pos = index_name_pos(the_repository->index, name, strlen(name));
>>  		if (pos < 0) {
> 
> Here is where the caller notices that index_name_pos() did not see a
> stage #0 entry.  This caller wants to see "ours" entry at stage #2,
> so it "inverts" the returned value and asks the helper function if
> it sees such an entry in the .cache[] array.
> 
> A handful of prerequisite pieces of knowledge to understand this
> code are:
> 
>  - The index (i.e. the .cache[] array) is sorted by full path name
>    (down from the top level of the working tree).
> 
>  - The index can have at most one stage #0 entry for each path name.
>    When a stage #0 entry exists for a path name, there cannot be
>    higher stage entries (the path is called "resolved").
> 
>  - The cache entries in the .cache[] array for the same path name
>    are sorted by their stage number.
> 
>  - There can be at most one stage #2 entry for each path name, which
>    are called "ours".  Entries at stage #1 are from common ancestor,
>    entries at stage #3 are from "their" tree.  These higher (i.e.
>    more than zero) stage entries appear only for "conflicting"
>    paths in the .cache[] array.
> 
> With the understanding above, you can see why "our" position is
> computed only when index_name_pos() returns negative in this hunk.

Thanks for the explanation, I was not able to get this from the code.

> 
>> -			pos = get_ours_cache_pos(name, pos);
>> +			pos = get_ours_cache_pos(name, -pos - 1);
>>  			if (pos < 0)
>>  				continue;
>>  		}
>> @@ -131,7 +128,7 @@ static int check_local_mod(struct object_id *head, int index_only)
>>  			 * Skip unmerged entries except for populated submodules
>>  			 * that could lose history when removed.
>>  			 */
>> -			pos = get_ours_cache_pos(name, pos);
>> +			pos = get_ours_cache_pos(name, -pos - 1);
>>  			if (pos < 0)
>>  				continue;
> 
> The above hunks are perfectly fine.  
> 
>> @@ -314,7 +311,7 @@ int cmd_rm(int argc,
>>  	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
>>  		ensure_full_index(the_repository->index);
>>  
>> -	for (i = 0; i < the_repository->index->cache_nr; i++) {
>> +	for (unsigned int i = 0; i < the_repository->index->cache_nr; i++) {
>>  		const struct cache_entry *ce = the_repository->index->cache[i];
>>  
>>  		if (!include_sparse &&
> 
> OK.
> 
> Thanks.

-- 
Regards,
Arnav Bhate
(He/Him)

