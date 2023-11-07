Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B17328BE
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ZFlLWIHI"
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B9710C1
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 11:45:24 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso1035976b3a.1
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 11:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1699386323; x=1699991123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DrTYd6C7dX1GGRfiL9c3H1Awr0PgH3jTx37V42AWF4=;
        b=ZFlLWIHIRr9CgWIO9c8ezcT9Q59qFFJE9IQvmlP9MgZP54ALvS2vSL/b3R/BbMTMzF
         IU5WlLsOdDx+WoPmRTA3BSp2suysIdEvUWnqoUpqIxyxHXEdRZyKgeTxTPPwb4YAoiVt
         OJf4B3QibG0wfgoo9MlPaxdvbzbZtGTm7LwjPiQXcATABpLr1v47/smZRw2D8jfKgJd7
         1fwLmLw0OlBzS3vDq0ebM8XAoq0prsFyppyGlbDZouYjgTlUtyqIsnfH0/6opGX4d3TV
         VgKcuMwlwoGSIgKLPy/6jeKnnz6G/NjAi8MMlIS83PMBEYGC09mtToecL5dsdxbB39UU
         BMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699386323; x=1699991123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DrTYd6C7dX1GGRfiL9c3H1Awr0PgH3jTx37V42AWF4=;
        b=lZt5J40BJ6rL+3lzH5tM6jnsGdbDOnQKiKTQEhDaZCBH2fA2bqKIJ+SR2zay4WMu7W
         C1cOxD0KWS2FyYiBppRT2RiO1yjqg2yIMlF6qq7fKXqT+sYlON+cwFNDjWQCF6ySEJ+s
         ZNiGxZcA+BPx/a8ldkXy/oCAtLuCIgfCgVJ046t0Tvq8/cyFYEZvB5oLUVg8oplkod8p
         sPTbcZejIWeJl4Y4h+eEYudRER1H592pOqz3AEhMkZmGH23HeQ75pnvBSo82edhabHJp
         wfJ2M64zU5jOH/QZQ7lhPTNypbd/s4ZGqmRWG0ImuqxvMKcDPAni2+PcqXppuD9sBicU
         +B7w==
X-Gm-Message-State: AOJu0Yyd+aA9gXwymt5QJppVDbvAiOwMim06tjiXrHRV8Dc7BaNSDAVP
	LNnitv8g5SZ097hac9GZj6/4
X-Google-Smtp-Source: AGHT+IHlO6DGKCgKP1C/fGBBe9dpJr1o+yImzUH9Y0AclvOP/tcz3CGMx9suOUKID7dS7p4SSj3HEQ==
X-Received: by 2002:a05:6a21:78a7:b0:16b:8154:2168 with SMTP id bf39-20020a056a2178a700b0016b81542168mr31055169pzc.26.1699386323612;
        Tue, 07 Nov 2023 11:45:23 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902848a00b001ca2484e87asm180809plo.262.2023.11.07.11.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 11:45:23 -0800 (PST)
Message-ID: <df782f9a-2590-4c9e-a1cd-6cb6758f9248@github.com>
Date: Tue, 7 Nov 2023 11:45:22 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] ref-filter.c: filter & format refs in the same
 callback
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <84db440896c162bcbeeaaf00d528839056aefaa5.1699320362.git.gitgitgadget@gmail.com>
 <ZUoWVPSE1GcJdHFE@tanuki>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <ZUoWVPSE1GcJdHFE@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:
>> diff --git a/ref-filter.c b/ref-filter.c
>> index ff00ab4b8d8..384cf1595ff 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -2863,6 +2863,44 @@ static void free_array_item(struct ref_array_item *item)
>>  	free(item);
>>  }
>>  
>> +struct ref_filter_and_format_cbdata {
>> +	struct ref_filter *filter;
>> +	struct ref_format *format;
>> +
>> +	struct ref_filter_and_format_internal {
>> +		int count;
>> +	} internal;
>> +};
>> +
>> +static int filter_and_format_one(const char *refname, const struct object_id *oid, int flag, void *cb_data)
>> +{
>> +	struct ref_filter_and_format_cbdata *ref_cbdata = cb_data;
>> +	struct ref_array_item *ref;
>> +	struct strbuf output = STRBUF_INIT, err = STRBUF_INIT;
>> +
>> +	ref = apply_ref_filter(refname, oid, flag, ref_cbdata->filter);
>> +	if (!ref)
>> +		return 0;
>> +
>> +	if (format_ref_array_item(ref, ref_cbdata->format, &output, &err))
>> +		die("%s", err.buf);
>> +
>> +	if (output.len || !ref_cbdata->format->array_opts.omit_empty) {
>> +		fwrite(output.buf, 1, output.len, stdout);
>> +		putchar('\n');
>> +	}
>> +
>> +	strbuf_release(&output);
>> +	strbuf_release(&err);
>> +	free_array_item(ref);
>> +
>> +	if (ref_cbdata->format->array_opts.max_count &&
>> +	    ++ref_cbdata->internal.count >= ref_cbdata->format->array_opts.max_count)
>> +		return -1;
> 
> It feels a bit weird to return a negative value here, which usually
> indicates that an error has happened whereas we only use it here to
> abort the iteration. But we ignore the return value of
> `do_iterate_refs()` anyway, so it doesn't make much of a difference.

I'll update it to 1, and also add a comment that the non-zero return value
stops iteration since it's not immediately clear from other 'each_ref_fn's
what that means. For reference, there appears to only be one other
'each_ref_fn' that even has the potential to return a nonzero return value
('ref_present()' in 'refs/files-backend.c).

> 
>> +	return 0;
>> +}
>> +
>>  /* Free all memory allocated for ref_array */
>>  void ref_array_clear(struct ref_array *array)
>>  {
>> @@ -3046,16 +3084,46 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
>>  	return ret;
>>  }
>>  
>> +static inline int can_do_iterative_format(struct ref_filter *filter,
>> +					  struct ref_sorting *sorting,
>> +					  struct ref_format *format)
>> +{
>> +	/*
>> +	 * Refs can be filtered and formatted in the same iteration as long
>> +	 * as we aren't filtering on reachability, sorting the results, or
>> +	 * including ahead-behind information in the formatted output.
>> +	 */
> 
> Do we want to format this as a bulleted list so that it's more readily
> extensible if we ever need to pay attention to new options here? Also, I
> noted that this commit doesn't add any new tests -- do we already
> exercise all of these conditions?

Sure, I'll convert it to a bulleted list. I don't really expect it to change
much, though; to have any effect on this condition, the new filter/format
would need to act on the pre-filtered ref_array, which isn't particularly
common.

And yes, the existing tests cover scenarios where this function returns true
(e.g. 'git for-each-ref --no-sort') & where it returns false (essentially
anything else).

> 
> More generally, I worry a bit about maintainability of this code snippet
> as we need to remember to always update this condition whenever we add a
> new option, and this can be quite easy to miss. The performance benefit
> might be worth the effort though.

I'll add more detailed comments to clarify what's going on here.

In practice, though, I don't think this would be all that easy to miss. As I
noted above, the only filters/formats that affect this are ones that need to
loop over an entire filtered ref_array after the initial
'for_each_fullref_in()'. To have it actually apply to commands that use
'filter_and_format_refs()', they'll need to add that behavior here (like
'filter_ahead_behind()'), where it should be apparent that
'can_do_iterative_format()' is relevant to their change. 

> 
> Patrick
