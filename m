Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291342F25F3
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100507; cv=none; b=u6WyNAsxbcmHyhYayT8Xo6YBQt6D2o2lmnWFxnZ20dQwrAM6oAgaWYhaekIKOCk3Ou0INYCmB15sZTwLqwWP/KmbtnYj22J/jgV/tzQcDEc2h8ba6+OVMiVtrt7LxGv6hcmTz8r79zgO6EPF/o02FUayvNtYYWXmacyJXux0v1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100507; c=relaxed/simple;
	bh=4qfjI9gttexe0+yJpTlpgI6FLRZHNYOGm4SXfDfYqFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mv2dz3nc8YTtA+HwNitnxkH9+hACkdp5wcY9Cnpu1+iJzEuTTv+zGUbO0PAIBCaosWSQN0uncY/GAZheD6FtdnsmXNim1k5IHAoPg+V/xEVrAMNm4SXVP+7AUl9xh22mBg3oruLCQdOduz9tYnJ5d1bu0oqJpKRrNksMu9AQhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMstRX53; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMstRX53"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8571a0947d1so242016185a.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 05:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760100505; x=1760705305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hb0dX9KZVyykZy8/llTXLCoTkv3/geXCc0tLiE392KM=;
        b=UMstRX53iM1bHmJPBSYY13Qz8QDjAGmZeirBbznFrGjkxL7WR39Ima3EomXRxEvw8J
         Vtsc6DF3Ve1ujB/7VFy1h4GVBeCvxAbkmRtZh1mVq6l/SV31Q158smv+Uy/5HL7/AXW6
         cS/qTpTJX0zwk2lQ1i/YsKGyaBS9XgJZpAHIPQ4bhGYi7V71whtI/kCHILNyT38JlCKi
         UQ042B+E8dRZ+Zsrio+3/f1PpbdDXkA658TupOIEnMzp8dP64e/2gee39hda+W+tKX6F
         DfnUEs8Pd2XznphdDvaqsApRkkcEXi7/XMzmq48v5mp9wmIOLsWB1lh3kBdqYZ9pkvDf
         GdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760100505; x=1760705305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb0dX9KZVyykZy8/llTXLCoTkv3/geXCc0tLiE392KM=;
        b=PTscZ2hrId/TbHGURtRO+rNE3J9eTbInlScEchgNBBtKKewPhJkpwjvM4jjIgOLiYO
         R02aBjTlCXlDfq0CWtYostiw59JqK0gaAO4qh2TDxrzRulVyCvUDaiZsXHl/+37E9HU5
         zWSr1yohgD6tVo1vekaF8EyT+1yhvThuJfQGpFcK/zBAzRciOsDcPTbTtRuff4e3YFHO
         /kalQJlazqkdtTqi4Nm4OOGsBDY0bBQ2UUduDTraaxJk/lQ/uxgkPBO76srnxnfHi54Y
         fLd5uQ7FlmGZXZW2ZLIPImAhIWfj8Vp5NUavE4mh2GYYOcHJfE/H+3LlImNKr1pO8TIG
         X6Qw==
X-Gm-Message-State: AOJu0YwIGtbLMh5EHbWPLbv8tJcum2ODP4fGlLXSwp9nzsBTVQ4pZc/d
	fCGty2sfqtWizdeT/XtZGBvbZcHbDxuewZSROpjWyfEm9sTB3I4gypoAXdwa8w==
X-Gm-Gg: ASbGncsyearg7/3PaAF2yaVxeZgeSCvAYs/oHQ8NCzLJt9S5BC+vJpqV01I/HwvUjlc
	PShqxNjk++8oJrwUKexGUfiXPAo3xdi6zi0nS2u3NUVVuMyWI9vt1k/pDoAiKIIjnsqOO4NOMmd
	HHUR5SqFgv/rbosYH82ePYpD/u4EvN/RwmFbOaBtDW0IiCcnxc2m5zydDYSjEhhwc0dFNuRaR7w
	10NwKNZu50+7F2vT5fkpAT2Wk3jkcwexpGrrAwnUXw/ym4IO2x83LHb4RKLTTa2f2T7txOJR9oO
	tXgjMFbcCnAzmB85QE8PgUVEZ7zQ5FP7CxwVyZAMvw8hkZ8F1vP9ahrkHrCioVYPY1NJQNUTpUF
	ay86nU23vR+SZlQ9EPI27knn6n44wzsiTJeO6wEsd+DrCqHwOC3Zd7X1QaMc3aQ5UYQOfboFBFl
	4CvvJzJN5UI1PpewVKG704mQ==
X-Google-Smtp-Source: AGHT+IGW91jT8pRe035AYlcyZAjFSMyZOnZ08KqFOYcIpF+SQpKNJcDEbpv8uWPhjjxEQpSf+mkOGA==
X-Received: by 2002:a05:620a:3954:b0:813:3a81:1a49 with SMTP id af79cd13be357-8820b47d622mr2127537885a.12.1760100504662;
        Fri, 10 Oct 2025 05:48:24 -0700 (PDT)
Received: from [192.168.1.109] ([136.56.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ada65sm399420685a.18.2025.10.10.05.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 05:48:24 -0700 (PDT)
Message-ID: <1a88e577-a808-4815-b390-e5d2253e670c@gmail.com>
Date: Fri, 10 Oct 2025 08:48:23 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit-graph: add new config for changed-paths &
 recommend it in scalar
To: Junio C Hamano <gitster@pobox.com>,
 Emily Yang via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, ps@pks.im, newren@gmail.com,
 Emily Yang <emilyyang.git@gmail.com>
References: <pull.1983.git.1760043710502.gitgitgadget@gmail.com>
 <xmqqecrbd7yh.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqecrbd7yh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/2025 6:30 PM, Junio C Hamano wrote:
> "Emily Yang via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Emily Yang <emilyyang.git@gmail.com>

>> In this commit, we're proposing a new
>> config option "commitGraph.changedPaths" - "true" value acts like
>> "--changed-paths"; "false" disables a previous "true" config value but
>> doesn't imply "--no-changed-paths".
> 
> The way the above is phrased is so unusual that I am afraid it would
> confuse readers.
> 
> When a configuration variable gives an opportunity for the users to
> override the hardcoded default (in this case, --no-changed-paths has
> been the traditional default,

(I'm pointing out this statement and how it's not quite right. I'll
explain more fully lower in this reply.)

> and graph.changedPaths=true would make
> us pretend as if --changed-paths were given from the command line).
> So if we were to have this configuration variable, setting it false
> MUST make it pretend as if --no-changed-paths were given from the
> command line, and MUST continue to do so even in some future we
> changed the hardcoded default to be "true" (i.e., unless the user
> says graph.changedPath=false in the configuration and/or declines
> with "--no-changed-paths" from the command line, we will record the
> changed paths filter by default).
> 
> Setting commitGraph.changedPaths to true should mean that the
> "git commit-graph write" command behaves as if --changed-paths
> were given immediately after that "write", so that an end-user
> commmand
> 
>     $ git commit-graph write
> 
> should behave as if it was written like this
> 
>     $ git commit-graph write --changed-paths
> 
> and
> 
>     $ git commit-graph write --no-changed-paths
> 
> should behave as if it was written like this
> 
>     $ git commit-graph write --changed-paths --no-changed-paths
> 
> i.e. allowing the command line --no-changed-paths to override it.
> 
> Setting commitGraph.changedPaths to false should similarly mean that
> "--no-changed-paths" implicitly is added immediately after "write",
> meaning that 
> 
>     $ git commit-graph write
> 
> should behave as if it was written like this
> 
>     $ git commit-graph write --no-changed-paths

One thing that is tricky about --[no-]changed-paths is that it is a
"tri-state" argument due to 0087a87ba8 (commit-graph: persist
existence of changed-paths, 2020-07-01):

 * --changed-paths : Definitely write the data, even if it didn't
   exist already.

 * --no-changed-paths : Definitely _don't_ write the data, even if
   it exists already.

 * (not present) : Update filters that do exist, but don't write them
   if they don't exist.

This is reflected in how opts.enable_changed_paths is initialized to
-1 in the existing version. Then, the config is loaded before the
arguments are parsed (this is already enforcing the precedence of
'--max-new-filters=<N>' over the 'commitGraph.maxNewFilters' config).

Later, opts.enable_changed_paths is converted into
COMMIT_GRAPH_WRITE_BLOOM_FILTERS or COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS
flags for the underlying commit-graph API, with the default of -1
passing neither flag (which will use any existing commit-graph to
persist and extend filters that already exist).

The big reason for this is so users can use a foreground process to
initialize filters, then background maintenance will respect and persist
that behavior. The big change here is that the config allows a user to
enable the filters and have them be computed entirely in the background.

So I think this is the root of your concerns here.
>> @@ -210,6 +210,8 @@ static int git_commit_graph_write_config(const char *var, const char *value,
>>  {
>>  	if (!strcmp(var, "commitgraph.maxnewfilters"))
>>  		write_opts.max_new_filters = git_config_int(var, value, ctx->kvi);
>> +	else if (!strcmp(var, "commitgraph.changedpaths"))
>> +		opts.enable_changed_paths = git_config_bool(var, value) ? 1 : -1;
> 
> This is iffy.
> 
> Unless the way existing command line parser figures out if the user
> wants or does not want to use the feature is so screwed up, you
> shouldn't have to do any such thing.
> 
> Why do you need to special case 'false' this way? 

The config now has this implication:

 * true : turn '(not present)' into '--changed-paths'.
 * false/unset : Continue to assume '(not present)'.

And the typical case is that we would have 'false' imply
'--no-changed-paths' which _removes_ filters that may exist. I
could see a case for this.

The situation that I wanted to think about was this:

 * A user sets the config to 'true' in global config.
 * They then set the config to 'false' in a specific repo.

In this case, the 'false' _disables the config_ but doesn't cause
any existing filters to be deleted.

I hope this helps. I could see a case for 'false' implying
'--no-changed-filters' but as Emily was investigating this and
noting this discrepancy, we leaned in the direction of being non-
destructive with the config.

Thanks,
-Stolee


