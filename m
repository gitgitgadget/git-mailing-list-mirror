Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF83588D
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="Ag6dcAyk"
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD35135
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:13:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so3672253a12.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 10:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1699380799; x=1699985599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhN7rbvRFVdLLeZ8m6cdSg0aFz7fZNkWwUrn5awdeBk=;
        b=Ag6dcAykEmvxgm8fnGPf1ILgPRLCv5MF5loIfP2AO7dgtoMvCzMm9Pd9K55liO8JhT
         T7uPkVZHUco9hkveLP6gHA1icpO0abc+v6gvjSyyhd4agsqvnP64fbzyll8wH8w8VMWz
         tlGWbSMl/Lg+oAav2Yc7oKqLxJvnjllmiCdONOjVBtU6jU4DWPmG1UBg8uXurCMJ/gZO
         xgJ54MMYVkD/A05fkKtPvhwtn7bAkXZQwcvxnjjCoJE/kVTL0hUl31HrF/McA1C54hy7
         1O2cocgATdq+2WC/4zaYLJNrp42dLFqaNt3qpcZCeGUODLlTh2iv92nCpO1WNHx6ux72
         MULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380799; x=1699985599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhN7rbvRFVdLLeZ8m6cdSg0aFz7fZNkWwUrn5awdeBk=;
        b=k1DHUPJ1lpBv5ytIXmK4MgZOZAnAxw4LrM0c3fy/9CMm6K2pjnFqmX8ZBKTs6iNt2Q
         RwXNiuScrkIe7JwBdl1S3gIK0YfCzsK4TceZBjgnpjUOD/mCXBhKr9ncAtoUs6/lQ7lO
         aTALsUXs8AIwAsQ+4S65ybvt12Di7nKbWTlsgn4Eg7YKzimICSdG4ZziyHC/HYtPwRgV
         t8uag2sNzSJqk5DuHPTTkcUn5/MDU5JYeKWNcD9/rLSx7lwNG5vIgkdbpkCzSZCZ7Sq3
         ntbE4NW92RfCMdq5lbMimap6tO4o/w/dD4iHUPDnhUj/tvIEuw2KBe6EQPbvUmxnycQP
         xdmA==
X-Gm-Message-State: AOJu0Yx1ahUcpoAj/PfbqUZoBgzsnfQqNCA4nKkg6zO7CoPkSQV1UYlG
	Jnh1Ca1Uu6W+W1tCiUF8kmrFqkJ8FWWp0stLKQ==
X-Google-Smtp-Source: AGHT+IFpSgYBQkRALyZmWuTtTJMGCiorz0yz1upYPuNPTwrox6uJBRaxARwdJbQwg5bria49gGb3SQ==
X-Received: by 2002:a05:6a21:7742:b0:181:10ee:20ca with SMTP id bc2-20020a056a21774200b0018110ee20camr21263263pzc.30.1699380799041;
        Tue, 07 Nov 2023 10:13:19 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id x20-20020aa784d4000000b006bb5ff51177sm7515896pfn.194.2023.11.07.10.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 10:13:18 -0800 (PST)
Message-ID: <a833b5a7-0201-4c2e-8821-f2a1930cb403@github.com>
Date: Tue, 7 Nov 2023 10:13:17 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ref-filter.c: really don't sort when using --no-sort
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <dea8d7d1e866d9784320051b372ff729fca855d7.1699320362.git.gitgitgadget@gmail.com>
 <ZUoWRZcD0xyfgVnc@tanuki>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <ZUoWRZcD0xyfgVnc@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:
> On Tue, Nov 07, 2023 at 01:25:53AM +0000, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Update 'ref_sorting_options()' to return a NULL 'struct ref_sorting *' if
>> the string list provided to it is empty, rather than returning the default
>> refname sort structure. Also update 'ref_array_sort()' to explicitly skip
>> sorting if its 'struct ref_sorting *' arg is NULL. Other functions using
>> 'struct ref_sorting *' do not need any changes because they already properly
>> ignore NULL values.
>>
>> The goal of this change is to have the '--no-sort' option truly disable
>> sorting in commands like 'for-each-ref, 'tag', and 'branch'. Right now,
>> '--no-sort' will still trigger refname sorting by default in 'for-each-ref',
>> 'tag', and 'branch'.
>>
>> To match existing behavior as closely as possible, explicitly add "refname"
>> to the list of sort keys in 'for-each-ref', 'tag', and 'branch' before
>> parsing options (if no config-based sort keys are set). This ensures that
>> sorting will only be fully disabled if '--no-sort' is provided as an option;
>> otherwise, "refname" sorting will remain the default. Note: this also means
>> that even when sort keys are provided on the command line, "refname" will be
>> the final sort key in the sorting structure. This doesn't actually change
>> any behavior, since 'compare_refs()' already falls back on comparing
>> refnames if two refs are equal w.r.t all other sort keys.
>>
>> Finally, remove the condition around sorting in 'ls-remote', since it's no
>> longer necessary. Unlike 'for-each-ref' et. al., it does *not* set any sort
>> keys by default. The default empty list of sort keys will produce a NULL
>> 'struct ref_sorting *', which causes the sorting to be skipped in
>> 'ref_array_sort()'.
> 
> I found the order in this commit message a bit funny because you first
> explain what you're doing, then explain the goal, and then jump into the
> changes again. The message might be a bit easier to read if the goal was
> stated up front.

I'll try to restructure it.

> 
> I was also briefly wondering whether it would make sense to split up
> this commit, as you're doing two different things:
> 
>     - Refactor how git-for-each-ref(1), git-tag(1) and git-branch(1) set
>       up their default sorting.
> 
>     - Change `ref_array_sort()` to not sort when its sorting option is
>       `NULL`.
> 
> If this was split up into two commits, then the result might be a bit
> easier to reason about. But I don't feel strongly about this.

The addition of "refname" to the sorting defaults really only makes sense in
the context of needing it to update 'ref_array_sort()', though. While you
can convey some of that in a commit message, when reading through commits
(mine and others') I find it much easier to contextualize small refactors
with their associated behavior change if they're done in a single patch.
There's a limit to that, of course; even within this series I have a lot of
"this will make sense later" commit messages (more than I'd like really)
because the refactors are large & varied enough that they'd be overwhelming
if squashed into a single patch.

So, while I definitely see where you're coming from, I think this patch is
better off not being split.

>> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
>> index fc765754305..436249b720c 100644
>> --- a/builtin/ls-remote.c
>> +++ b/builtin/ls-remote.c
>> @@ -58,6 +58,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>>  	struct transport *transport;
>>  	const struct ref *ref;
>>  	struct ref_array ref_array;
>> +	struct ref_sorting *sorting;
>>  	struct string_list sorting_options = STRING_LIST_INIT_DUP;
>>  
>>  	struct option options[] = {
>> @@ -141,13 +142,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
>>  		item->symref = xstrdup_or_null(ref->symref);
>>  	}
>>  
>> -	if (sorting_options.nr) {
>> -		struct ref_sorting *sorting;
>> -
>> -		sorting = ref_sorting_options(&sorting_options);
>> -		ref_array_sort(sorting, &ref_array);
>> -		ref_sorting_release(sorting);
>> -	}
>> +	sorting = ref_sorting_options(&sorting_options);
>> +	ref_array_sort(sorting, &ref_array);
> 
> We stopped calling `ref_sorting_release()`. Doesn't that cause us to
> leak memory?

Nice catch, thanks! It should have been moved to the end of this function
(right before the 'ref_array_clear()').

>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index 3182abde27f..9918ba05dec 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -1606,10 +1608,70 @@ test_expect_success 'option override configured sort' '
>>  	)
>>  '
>>  
>> +test_expect_success '--no-sort cancels config sort keys' '
>> +	test_config -C sort branch.sort "-refname" &&
>> +
>> +	(
>> +		cd sort &&
>> +
>> +		# objecttype is identical for all of them, so sort falls back on
>> +		# default (ascending refname)
>> +		git branch \
>> +			--no-sort \
>> +			--sort="objecttype" >actual &&
> 
> This test is a bit confusing to me. Shouldn't we in fact ignore the
> configured sorting order as soon as we pass `--sort=` anyway? In other
> words, I would expect the `--no-sort` option to not make a difference
> here. What should make a difference is if you _only_ passed `--no-sort`.

The existing behavior (as demonstrated by this test) is that the command
line sort keys append to, rather than replace, the config-based sort keys. I
don't see any evidence in the commit history to indicate that this was an
intentional design decision, but it's not necessarily incorrect either.

For one, it's not universal in string list options that the command line
replaces the config. There are examples of both approaches to string list
options in other commands:

- in 'git push', specifying '--push-option' on the command line even once
  will remove any values set by 'push.pushoption'
- in 'git blame', any values specified with '--ignore-revs-file' are
  appended to those set by 'blame.ignorerevsfile'

In the case of 'git (tag|branch)', I can see why users might not want
command line sort keys to completely remove config-based ones. The only time
the config-based keys will come into play is when two entries are identical
w.r.t _all_ of the command line sort keys. In that scenario, I'd expect a
user would want to use their configured defaults to "break the tie" instead
of the hardcoded ascending refname sort. If they do actually want to remove
the config keys, they can set '--no-sort' before their other sort keys.

