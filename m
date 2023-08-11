Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B98AC04A94
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 01:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjHKBZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 21:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjHKBZv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 21:25:51 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1AB2D5F
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 18:25:48 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56385c43eaeso1631491a12.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 18:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691717148; x=1692321948;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Xi/jvQTlyyynVxruTtvR0leSBuq6yBAcJW0RmAaW5w=;
        b=tjkf307IGZdyj/gHYL/1i6E/pJOJH+rwzezbYbyILkSwAZD6vQlqEwWflxXW2/Su7V
         8piFi8RwyEA8zAlEnn9vAdkqzOiQz/BddQ+gEP2Nh2kzYWPM2HhaAi+sydtsR34QDF2O
         wfWIJWqNdSLBvOueuUxQqy3FhkWT2VrwQZP7bjJMOSciX9bCMQ8VNjQxRNU3mPBVkwo5
         GN+F9SI6akn4R1NOO92j99VbzzLYnLja4P1arxrntq6YencV5d9MWg8zKGwnSnFcLSK1
         qT2TiN2f3sKObgWff8yxxr6yIzvAhBzdaFmHgyAn4bjauzyermALJfIXy9TYd/yqFazC
         SKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691717148; x=1692321948;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Xi/jvQTlyyynVxruTtvR0leSBuq6yBAcJW0RmAaW5w=;
        b=KVYBTcabsxj7SSBtGb99oHVUuljwxZRAJiKit1TYJfCpnbJRzk+EJyoy/jXI9baAZP
         WIgqpUjlicSn3IZa7gJOI74ZL+DNLO4uF0n0KRZgGHjC64f1JgEuWJY4MKbpor9/xiUf
         6yX0kc0RCxz83vFFw03d7gRL4YcWw7eWVuCH61JXu1XUakZJdDRq5n7x1BrVgZvwsUqE
         Nx0EYenpaqHKbOePxYhTOT/fzHYaxTlmmeWi7kfiU7R9/c7GIuQ82NMWy0F7+gPAXHVx
         q6l1ExMN+E4Pbdo0wRUZpWjijuSAP1ArRB8dysQ1RI5lzzatuS/f8W0uk+GCk7+fuLTr
         2wmg==
X-Gm-Message-State: AOJu0YzInIRv7q1J9U6a41GavArW+I36pCUguRyVo/ho/aPaa7U5cvDJ
        me9zrt8qgQP8McSwVHhZpAfvsXDsOrQ=
X-Google-Smtp-Source: AGHT+IF9jw+FMXua2IiD5W0HdZ18hSqW+gDV9eCW+VEdRfTk2/7vS+OBrj9rPcmzR6B9P8WuaOW4Si+2xRc=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:25c4:0:b0:564:3bb7:b5a2 with SMTP id
 l187-20020a6325c4000000b005643bb7b5a2mr671080pgl.0.1691717148046; Thu, 10 Aug
 2023 18:25:48 -0700 (PDT)
Date:   Thu, 10 Aug 2023 18:25:46 -0700
In-Reply-To: <kl6ly1im8ma5.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <1fc060041db11b3df881cb2c7bd60630dc011a15.1691211879.git.gitgitgadget@gmail.com>
 <kl6ly1im8ma5.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <owlyjzu2fjz9.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 4/5] trailer: teach find_patch_start about --no-divider
From:   Linus Arver <linusa@google.com>
To:     Glen Choo <chooglen@google.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> @@ -812,14 +812,14 @@ static ssize_t last_line(const char *buf, size_t len)
>>   * Return the position of the start of the patch or the length of str if there
>>   * is no patch in the message.
>>   */
>> -static size_t find_patch_start(const char *str)
>> +static size_t find_patch_start(const char *str, int no_divider)
>>  {
>>  	const char *s;
>>  
>>  	for (s = str; *s; s = next_line(s)) {
>>  		const char *v;
>>  
>> -		if (skip_prefix(s, "---", &v) && isspace(*v))
>> +		if (!no_divider && skip_prefix(s, "---", &v) && isspace(*v))
>>  			return s - str;
>>  	}
>
> Assuming we wanted to make this unit-testable anyway, could we just move
> the strlen() call into this function?

I don't see why we should preserve the if-statement and associated
strlen() call if we can just get rid of it.

> [...] I
> don't find this easier to understand. Now the reader needs to read the
> code to see "if no_divider is given, noop until the end of the string,
> at which point str will point to the end, and s - str will give us the
> length of str", as opposed to "there are no dividers, so just return
> strlen(str)".

The main idea behind this patch is to make find_patch_start() return the
correct answer. Currently it does not in all cases (whether --no-divider
is provided), and so the caller has to calculate the
start of the patch with strlen manually. By moving the --no-divider flag
into this function, we force all callers to consider this important
option.

For additional context we recently had to fix a bug where we weren't
passing in this flag to the interpret-trailers builtin. See be3d654343
(commit: pass --no-divider to interpret-trailers, 2023-06-17). There we
acknowledged that some callers forgot to pass in --no-divider to
interpret-trailers (such as the caller that was fixed up in that
commit).

I mention the above example because although it's not the exact same
thing as here, I think the scenario of "sometimes callers can forget
about --no-divider" is an important one to prevent wherever possible.
That's why I like this patch (in addition to the reasons cited in the
commit message).
