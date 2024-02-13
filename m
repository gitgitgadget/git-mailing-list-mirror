Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC87055C15
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830845; cv=none; b=CsgaXpw0HxoUNJ04CyGy7a+auw00sjUdW0Is8tot/0UlA6/Id3yvlp8tNMXcSTUsjC1FKZ+5cJJdcHHXBqhyx0vf8KRrJdLEF2PQakrH2qJbJal+csYDEGmr2M+JjJhCyvIaKgCDSRvhVSg9VGWLopB5fpVO1I2OH1q+G3mVbLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830845; c=relaxed/simple;
	bh=pvTeqO0SO/T4hvAFuojibEQkJrptTj6knoV9LaJID1g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YMliUSO2jWgeLlyUPiQXwCIKrxozHn5qiWEubfmtFoRKMTzXCXJm6Gkmhmd6uHe+4U20KfdsfWX2+SovR3QCdf6HKpzDNFjHM67jzt/mQoT+S1P9jXoHoROCIYKZw0oVbQl+fwdA+49FCFHUYWHnl0/Ak9w6YF8+ZQRRjZxwJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeHlogL8; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeHlogL8"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4b978e5e240so1547970e0c.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 05:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707830841; x=1708435641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARHnngTthPn8O0ZnvtmeAUVgqbEoI5sObyvSgz12ZE8=;
        b=HeHlogL8RgS2E44SgYxUMZOfeW1WEqaz3bdyg9hpRigCIuHIRtWR1GGEp+hAqrLMRE
         GFvJRltfMQ2jR+4PEXEcIDRFaY5PuXnO7dZS0ZUcoK0Oy1CsgfuZwNIlLaELknhCBE7k
         6MKoEXfYQ/Dcw/sGmKk4QmthP9r6BIJQPp2NWSmwZh7P3jwj6JOt49IrZNZsurE5Q3Wx
         U5r2/MkEkcG6wim04rniBVQRwUXLo6P9c9SMATOjDULaU68PHS7W8Yfr4vWGTeqU8W+L
         GglKIaV/BqQN79zatMaDa9YY/DTbgT9gibdesqM0Ak2uu+TnvN4OYGvviAFvXz+qgzkS
         b15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830841; x=1708435641;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARHnngTthPn8O0ZnvtmeAUVgqbEoI5sObyvSgz12ZE8=;
        b=JEYc/sP6pdJ5h0veY99uBaVKAkJBk7J4lL0c19Jmiosr/wxUgqllUk84EKXHfMMgng
         n/SvpBGahILmEcmeBd45LMltAxY8qG5wRpGLfvm9yoAcrA3/LaKx+vccY4i8C5YaEd95
         QTaehaJ49SH3KSdTm92l4zc+pPOYa0C3z7in48xQC0zfPmisjb7AitTuUbH9/C9Qc8Xo
         AWhstjoOgWppVjy4iW6MJPIfPoO08wBJnu7ycjyHZw5XSpvv5f6vkCOzWd1tbHJ9la6d
         7PGGcLoYR+uFtP0lvyykFhnfipYkSUdwLDoLTf/1LqWM8ti6qkg0J9qeVHYbzvzi4vuE
         jX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW739/EBE0TH2VdELS9gAopJY391XmPyTYrPjlhlgDkZtOcDWV9I8RkF89vdT5MEEp3GbazHWHLTbNdb5A3nXxEqAtC
X-Gm-Message-State: AOJu0YyeYN3gXRSGHSI598FGItJAC4HWa+En0W9UHaCqtatIHQw5ZbG4
	bVLXnZ7OlhSwAGfME1d9IbJrG/0f8ZZ3cnpBT3ra0rHCNp4uUmt8
X-Google-Smtp-Source: AGHT+IEacwKSzVXr23Uw1aDoAPAXW9vB6rv8WRPqdi4IBCq2dH6VeZasLtr8Hvp5iDfSA966/s3wew==
X-Received: by 2002:a1f:e602:0:b0:4c0:1c4e:682f with SMTP id d2-20020a1fe602000000b004c01c4e682fmr6039342vkh.8.1707830841477;
        Tue, 13 Feb 2024 05:27:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtEmkwzmZABey755aYstlTTX2+hT9+cVKpkN8zvKcf4YYlrjPg58IFAEkSuBxVR13J6SGo852mNXAGN/kS5LK2n6zhzyF9vTjCfecmaRfJlQkKrpmr1T+DZC25VnlvPAFfUHxsJMv9hR3JRPjLyFMVRd6M2SRK7m6fBLGguZ2mKbm2fLnptr2gWb3Kdtg/oecfU8L7r4PTxcjQZPadqIYCiKKvEg==
Received: from ?IPv6:2606:6d00:17:3855:44aa:3375:448b:8f34? ([2606:6d00:17:3855:44aa:3375:448b:8f34])
        by smtp.gmail.com with ESMTPSA id mu14-20020a056214328e00b0068cc4248169sm1230682qvb.100.2024.02.13.05.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 05:27:21 -0800 (PST)
Subject: Re: [PATCH v4 2/2] revision: implement `git log --merge` also for
 rebase/cherry-pick/revert
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
 Michael Lohmann <mial.lohmann@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Michael Lohmann <mi.al.lohmann@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-0-3bc9e62808f4@gmail.com>
 <20240210-ml-log-merge-with-cherry-pick-and-other-pseudo-heads-v4-2-3bc9e62808f4@gmail.com>
 <c5d60b5b-3181-4bb7-a7f8-eb97474526d7@gmail.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <790a3f11-5a8c-42f2-7a35-f2900c0299b4@gmail.com>
Date: Tue, 13 Feb 2024 08:27:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c5d60b5b-3181-4bb7-a7f8-eb97474526d7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Phillip,

Le 2024-02-12 à 06:02, Phillip Wood a écrit :
> Hi Philippe
> 
> On 10/02/2024 23:35, Philippe Blain wrote:
>> From: Michael Lohmann <mi.al.lohmann@gmail.com>
>>
>> 'git log' learned in ae3e5e1ef2 (git log -p --merge [[--] paths...],
>> 2006-07-03) to show commits touching conflicted files in the range
>> HEAD...MERGE_HEAD, an addition documented in d249b45547 (Document
>> rev-list's option --merge, 2006-08-04).
>>
>> It can be useful to look at the commit history to understand what lead
>> to merge conflicts also for other mergy operations besides merges, like
>> cherry-pick, revert and rebase.
>>
>> For rebases, an interesting range to look at is HEAD...REBASE_HEAD,
>> since the conflicts are usually caused by how the code changed
>> differently on HEAD since REBASE_HEAD forked from it.
>>
>> For cherry-picks and revert, it is less clear that
>> HEAD...CHERRY_PICK_HEAD and HEAD...REVERT_HEAD are indeed interesting
>> ranges, since these commands are about applying or unapplying a single
>> (or a few, for cherry-pick) commit(s) on top of HEAD. However, conflicts
>> encountered during these operations can indeed be caused by changes
>> introduced in preceding commits on both sides of the history.
> 
> I tend to think that there isn't much difference between rebase and cherry-pick here - they are both cherry-picking commits and it is perfectly possible to rebase a branch onto an unrelated upstream. The important part for me is that we're showing these commits because even though they aren't part of the 3-way merge they are relevant for investigating where any merge conflicts come from.
> 
> For revert I'd argue that the only sane use is reverting an ancestor of HEAD but maybe I'm missing something. In that case REVERT_HEAD...HEAD is the same as REVERT_HEAD..HEAD so it shows the changes since the commit that is being reverted which will be the ones causing the conflict.

Thanks, I can rework the wording from that angle.


>> Adjust the code in prepare_show_merge so it constructs the range
>> HEAD...$OTHER for each of OTHER={MERGE_HEAD, CHERRY_PICK_HEAD,
>> REVERT_HEAD or REBASE_HEAD}. Note that we try these pseudorefs in order,
>> so keep REBASE_HEAD last since the three other operations can be
>> performed during a rebase. Note also that in the uncommon case where
>> $OTHER and HEAD do not share a common ancestor, this will show the
>> complete histories of both sides since their root commits, which is the
>> same behaviour as currently happens in that case for HEAD and
>> MERGE_HEAD.
>>
>> Adjust the documentation of this option accordingly.
> 
> Thanks for the comprehensive commit message.
> 
>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index 2bf239ff03..5b4672c346 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -341,8 +341,10 @@ See also linkgit:git-reflog[1].
>>   Under `--pretty=reference`, this information will not be shown at all.
>>     --merge::
>> -    After a failed merge, show refs that touch files having a
>> -    conflict and don't exist on all heads to merge.
>> +    Show commits touching conflicted paths in the range `HEAD...$OTHER`,
>> +    where `$OTHER` is the first existing pseudoref in `MERGE_HEAD`,
>> +    `CHERRY_PICK_HEAD`, `REVERT_HEAD` or `REBASE_HEAD`. Only works
>> +    when the index has unmerged entries.
> 
> Do you know what "and don't exist on all heads to merge" in the original is referring to? The new text doesn't mention anything that sounds like that but I don't understand what the original was trying to say.

Yes, it took me a while to understand what that meant. I think it is simply
describing the range of commits shown. If we substitute "refs" for "commits"
and switch the order of the sentence, it reads:

    After a failed merge, show commits that don't exist on all heads to merge
    and that touch files having a conflict.

So it's just describing (a bit awkwardly) the HEAD...MERGE_HEAD range.

> It might be worth adding a sentence explaining when this option is useful.
> 
>     This option can be used to show the commits that are relevant
>     when resolving conflicts from a 3-way merge
> 
> or something like that.

Nice idea, I'll add that.

> 
>>   --boundary::
>>       Output excluded boundary commits. Boundary commits are
>> diff --git a/revision.c b/revision.c
>> index aa4c4dc778..36dc2f94f7 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1961,11 +1961,31 @@ static void add_pending_commit_list(struct rev_info *revs,
>>       }
>>   }
>>   +static const char *lookup_other_head(struct object_id *oid)
>> +{
>> +    int i;
>> +    static const char *const other_head[] = {
>> +        "MERGE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD", "REBASE_HEAD"
>> +    };
>> +
>> +    for (i = 0; i < ARRAY_SIZE(other_head); i++)
>> +        if (!read_ref_full(other_head[i],
>> +                RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>> +                oid, NULL)) {
>> +            if (is_null_oid(oid))
>> +                die("%s is a symbolic ref???", other_head[i]);
> 
> This would benefit from being translated and I think one '?' would suffice (I'm not sure we even need that - are there other possible causes of a null oid here?)

This bit was suggested by Junio upthread in <xmqqzfxa9usx.fsf@gitster.g>.
I'm not sure if the are other causes of null oid, as I don't know well this 
part of the code.
I agree that a single '?' would be enough, but I'm not sure about marking
this for translation, I think maybe this situation would be best handled with
BUG() ?

>> +            return other_head[i];
>> +        }
>> +
>> +    die("--merge without MERGE_HEAD, CHERRY_PICK_HEAD, REVERT_HEAD or REBASE_HEAD?");
> 
> This is not a question and would also benefit from translation. It might be more helpful to say that "--merge" requires one of those pseudorefs.

Yes, I agree. I'll tweak that.

> Thanks for pick this series up and polishing it
> 
> Phillip
> 

Thanks,

Philippe.
