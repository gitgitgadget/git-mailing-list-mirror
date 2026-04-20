Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1331A575
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680683; cv=none; b=q4Zgv07DMnELSuKVKV9zzQ/0M8ToCjIpbOqJDsIXaU+2Mhh0beKHXb4I49CCb5xSk03negYyNlrtrx1F+cWV0KlC5kp7UT0MAR3wAJ9dzsgQw48STvlP3ERExqXOTYl+iM3nSDzKatbBgeEIyKPme+uyWPUQ6mVb6BxxwlpDqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680683; c=relaxed/simple;
	bh=WYDL0vHheNZMLdJj7pYwZNFMtZk+07IwFe8kemcCj1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFHlX/jj60SPVZOVPXwvRtnyoBtDhauywwK55inAsmB8Jan/r7RCaafzPJFUgHA6ZMmBHsF2vbrkfkE1BJ7lAJRirXjPduEdlHTOnB58Q+EWE7ZJrrZTl+4meC5ek9qbhOOn7dGQzocVrwLMRyOvNY0CWi1xp6JZQzY7G0up+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lwubk/Yq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwubk/Yq"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so334413b3a.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776680682; x=1777285482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i04ct64ZACqDhKgYnj5K9n1SwNokyqlv89h4gE8tDps=;
        b=Lwubk/YqBAXzsqrQbpn/zGLlUB0+hbXOd7U9UDmSFKr+pqGZZsQdat9F4j4Hp2fV7p
         I4aZaPDSCsiGLW/sBkg7TlqtQYWOVcno1Ij2Ii1SGQ/FNXLMOpUh+4IyLXlPid5w7vae
         qE/XBPaIdIBH9IRRuA//MWFiQFwchoekYRkMJQeYzZMij+mxplwR69ZeNmB5cm6piJAa
         /C6g+1HMyLVkhXMMR+Z0w/xFGjH0PswonD796JRbGiRjIoLWDtmwDUUxZg53WAa31vD5
         SQAXa2i0rbPzB3Y8SYvJJDHpmnCf50XjLc6cSDnXCmH6QyzWFY5Wav5rd/zP4B4MtaOi
         /z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776680682; x=1777285482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i04ct64ZACqDhKgYnj5K9n1SwNokyqlv89h4gE8tDps=;
        b=DwqYcJCJMCz1Kqnwm6Rv02XRvE87FF2qWA3f5NpHY1r4s3LrNfpcDF5/50XDAUfZOg
         FrRCkC3dxd9ormA45rF74Z0jHlg7B3nypnNzWCyYBjRfQmsYlRof821nSmYkwB4Auin3
         3b3pfqE9MEP4vddBeNwxpp8BANH7zHo8lZ1cbfzuc76E65sXEKPyszbOo1jcsLHrmx9W
         3118NfDYioSIQq2jb1lcECucgt/R6xwwYth7fvNZ16eQuafVGvxhOQZrkL8YQ6JG6Bkw
         g2sectPP8iRzwmIiFh6f2jSe5yLnYALJIJ56juBx7r3kcNzmVQmYNM8u2OCMKkcb/cXc
         BpXA==
X-Forwarded-Encrypted: i=1; AFNElJ+IAhW9w3DY9Vjt0JemviIjntF7T4Tz08G9bAEdYX0/ulfbAn03vZL0M6RmVndFtcxKFgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRllvUHMplnqGEMI6Oyz2zFEOQcOTcR2Ka97FdB/l1vfMjJ8CZ
	QWYk1nwnREwZCh4zrE4493GrhsNufoZDzyUYW0Gjfd8dZeFfvSD/cErr
X-Gm-Gg: AeBDietDpXRQf1foL+SVg31bWFCcOGiBbC2sErLX9c1Xt31XlMcNasJFC+RuJrE/aXg
	55JDaqEdMxhuFYaURuf3DxiIhWG7T7nr7MQ6Ddg+BZFlCNTYwYwyvNd8jbtZl092ee5iAkBVgGB
	OmQmCn1agBqzGd0/KJNL20lKqkMDv/x4gb22A54mFPTK/U9h4afTT9TrBi3LzHQLHusJWDYU0Ty
	3aGBAuI/DMfBw58AXWSSGuSiQhhcJ/v0fMxtAnqSoVrUlEC8zSkgsgOzm0Sa/aV6xAjwJEcjT2M
	xxUxFsno5Qpjwi5eO3CxArISnTslJkZ9qEC3Ll8qdWLQx8p7zKNvbTpWSNDv65zKFyDTg2rBG19
	jQu3iizHj1oJVsxGXWEvbUHWkNgN9d+z8W9sbmCrFbX8O6Za+pcYoXeeF8q8jve9xgDClafaaim
	c0vkn42o7eRzOEJ+zpHhSylvVE6lXoeq+G5dkjLcENqP+50O7pg9xRbMNLL+0t5l+GOaCQmW592
	6OERzgJUKOtObNfsgtjQ1VWLhzswikHhyV+i6BXTBl8
X-Received: by 2002:a05:6a00:3397:b0:82f:2243:e448 with SMTP id d2e1a72fcca58-82f8c83048fmr13631509b3a.3.1776680681510;
        Mon, 20 Apr 2026 03:24:41 -0700 (PDT)
Received: from ?IPV6:2401:4900:86e8:71dc:a082:d961:4e27:7d6? ([2401:4900:86e8:71dc:a082:d961:4e27:7d6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebba485sm12576332b3a.38.2026.04.20.03.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 03:24:39 -0700 (PDT)
Message-ID: <9e2ca91d-9091-4d4d-9427-ec8a23ee8909@gmail.com>
Date: Mon, 20 Apr 2026 15:54:34 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rev-list: add --missing=print-only mode
To: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org, toon@iotcl.com, ps@pks.im,
 karthik.188@gmail.com, justin@parity.io
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
 <20260419084840.33986-2-siddharthasthana31@gmail.com>
 <4c9fee0b-99bb-4e41-9227-f09c63df9f9d@gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <4c9fee0b-99bb-4e41-9227-f09c63df9f9d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/04/26 04:06, Derrick Stolee wrote:
> On 4/19/26 4:48 AM, Siddharth Asthana wrote:
>> When working with partial clones, it's common to want just the list of
>> missing objects. The current --missing=print mode does this but mixes
>> present and missing objects together, with missing ones prefixed by '?'.
>> Getting only the missing OIDs requires an extra pipe:
>>
>>    git rev-list --objects --all --missing=print | perl -ne 'print if 
>> s/^[?]//'
>>
>> Add --missing=print-only which outputs only the missing object OIDs, one
>> per line, without any prefix. This makes the above one-liner unnecessary
>> and the output directly usable by downstream tools.
> 
> I'm a fan of this mode. It saves time dealing with the I/O.


Thanks!


> 
>>   static struct oidmap missing_objects;
>>   enum missing_action {
>> -    MA_ERROR = 0,    /* fail if any missing objects are encountered */
>> -    MA_ALLOW_ANY,    /* silently allow ALL missing objects */
>> -    MA_PRINT,        /* print ALL missing objects in special section */
>> -    MA_PRINT_INFO,   /* same as MA_PRINT but also prints missing 
>> object info */
>> +    MA_ERROR = 0, /* fail if any missing objects are encountered */
>> +    MA_ALLOW_ANY, /* silently allow ALL missing objects */
>> +    MA_PRINT, /* print ALL missing objects in special section */
>> +    MA_PRINT_INFO, /* same as MA_PRINT but also prints missing object 
>> info */
>> +    MA_PRINT_ONLY, /* print ONLY missing objects, without the "?" 
>> prefix */
>>       MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR 
>> objects */
> 
> I'm not a fan of this adjustment of spacing on the comments,


You are right, unnecessary churn - will restore!


> though I do see that MA_ALLOW_PROMISOR had already broken the
> pattern. MA_PRINT_ONLY would still work with the earlier
> comment alignment, though.
> 
>> -    if (line_term)
>> +    if (arg_missing_action == MA_PRINT_ONLY) {
>> +        printf("%s", oid_to_hex(&entry->entry.oid));
>> +        putchar(line_term);
> 
> Is there a reason you didn't use a printf("%s%c") here to
> put the oid and line_term together?


I just followed the existing pattern in the same function where every 
other path uses a separate putchar(line_term). Happy to combine if you 
prefer.


> 
>> +        return;
>> +    } else if (line_term) {
>>           printf("?%s", oid_to_hex(&entry->entry.oid));
>> -    else
>> +    } else {
>>           printf("%s%cmissing=yes", oid_to_hex(&entry->entry.oid),
>>                  info_term);
>> +    }
> 
> 
> 
>>       if (!print_missing_info) {
>>           putchar(line_term);
>> @@ -209,6 +222,7 @@ static inline void finish_object__ma(struct object 
>> *obj, const char *name)
>>       case MA_PRINT:
>>       case MA_PRINT_INFO:
>> +    case MA_PRINT_ONLY:
>>           add_missing_object_entry(&obj->oid, name, obj->type);
>>           return;
>> @@ -246,6 +260,11 @@ static void show_commit(struct commit *commit, 
>> void *data)
>>           return;
>>       }
>> +    if (arg_missing_action == MA_PRINT_ONLY) {
>> +        finish_commit(commit);
>> +        return;
>> +    }
>> +
>>       if (show_disk_usage)
>>           total_disk_usage += get_object_disk_usage(&commit->object);
>> @@ -384,6 +403,8 @@ static void show_object(struct object *obj, const 
>> char *name, void *cb_data)
>>       if (finish_object(obj, name, cb_data))
>>           return;
>>       display_progress(progress, ++progress_counter);
>> +    if (arg_missing_action == MA_PRINT_ONLY)
>> +        return;
>>       if (show_disk_usage)
>>           total_disk_usage += get_object_disk_usage(obj);
>>       if (info->flags & REV_LIST_QUIET)
>> @@ -525,6 +546,12 @@ static inline int 
>> parse_missing_action_value(const char *value)
>>           return 1;
>>       }
>> +    if (!strcmp(value, "print-only")) {
>> +        arg_missing_action = MA_PRINT_ONLY;
>> +        fetch_if_missing = 0;
>> +        return 1;
>> +    }
>> +
>>       if (!strcmp(value, "allow-promisor")) {
>>           arg_missing_action = MA_ALLOW_PROMISOR;
>>           fetch_if_missing = 0;
>> @@ -967,8 +994,7 @@ int cmd_rev_list(int argc,
>>       if (arg_print_omitted)
>>           oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
>> -    if (arg_missing_action == MA_PRINT ||
>> -        arg_missing_action == MA_PRINT_INFO) {
>> +    if (missing_action_prints()) {
>>           struct oidset_iter iter;
>>           struct object_id *oid;
>> @@ -994,8 +1020,7 @@ int cmd_rev_list(int argc,
>>               printf("~%s\n", oid_to_hex(oid));
>>           oidset_clear(&omitted_objects);
>>       }
>> -    if (arg_missing_action == MA_PRINT ||
>> -        arg_missing_action == MA_PRINT_INFO) {
>> +    if (missing_action_prints()) {
>>           struct missing_objects_map_entry *entry;
>>           struct oidmap_iter iter;
>> @@ -1011,7 +1036,7 @@ int cmd_rev_list(int argc,
>>       stop_progress(&progress);
>> -    if (revs.count) {
>> +    if (revs.count && arg_missing_action != MA_PRINT_ONLY) {
>>           if (revs.left_right && revs.cherry_mark)
>>               printf("%d\t%d\t%d\n", revs.count_left, 
>> revs.count_right, revs.count_same);
>>           else if (revs.left_right)
>> @@ -1022,7 +1047,7 @@ int cmd_rev_list(int argc,
>>               printf("%d\n", revs.count_left + revs.count_right);
>>       }
>> -    if (show_disk_usage)
>> +    if (show_disk_usage && arg_missing_action != MA_PRINT_ONLY)
>>           print_disk_usage(total_disk_usage);
> 
> I'm a little worried about all of these checks that need
> special-casing. These seem like options that are enabled


Phillip suggested making this a separate --missing-only flag that 
composes with existing --missing= modes - I think that's a better 
design. will work v2 around it.


> by other options and could easily be grouped with the
> print-only setting.
> 
> If there is something wrong here where these need to be
> disabled, then we should update the documentation to say


Agreed - I will make --count and --disk-usage incompatible with 
--missing-only and die() with a clear message instead of silently 
suppressing them.



> how this interacts with those options. And perhaps some
> warnings to say "these options are not compatible".
> 
> On that note: this patch is missing a document update.


There is a doc update in rev-list-options.doc, but it doesn't  cover 
interactions with --count/--disk-usage. Will fix in v2.


> 
> Thanks,
> -Stolee
> 
> 




Thanks,
Asthana
