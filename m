Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB9E20986
	for <e@80x24.org>; Tue,  4 Oct 2016 23:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbcJDXZ3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 19:25:29 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36173 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbcJDXZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 19:25:28 -0400
Received: by mail-qt0-f173.google.com with SMTP id m5so44239573qtb.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 16:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Du+7G3Ns1tj4Vb2PSkTJKN3F+i5fUDJdahsZXLI4Zgg=;
        b=fGPYO28MTOExAs78JuetP4GVW4QPDGzlC2fTCyy9ZMDIfG7JvzNp/vj3xq7BgzR8Kg
         kvika4XMUQ7I0TByupKZ2vKDxD1rtNEjfvAPAmX9bfzrcP+CvLwh1M7/PCuWBDAkn7FU
         Xg6Nn/IQF3qAyPsB1YjL/jiyYS2T6flek2Be+ar9TCZMXzbCvjhGll4TmfKuxyNtoVGb
         5oA8roGA5j6naVL2Bkag7em2B97iYVbEZTxU77KT5rt3iEZDV2zoVMZUTOJpHenv1Tu9
         bzJgF1N9so9d7J+pZ+oKDwvMMpAOQ/S2Sgta+aPXAgnnYqoOqeirDTbijRsbGmL0Tl9N
         msqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Du+7G3Ns1tj4Vb2PSkTJKN3F+i5fUDJdahsZXLI4Zgg=;
        b=I/q3HCy0dC2iCnQjS+pcXBHAj6nQ9Pr374/76RU7WOOPMOWEoy0JKPgDogV6hjUXE2
         t8i5/KYnnmY2rJSuB5CYmTNbYiEdlIKjjmZ7tz00JKywuw+fs3e2YP/KsyO9omiyCd8u
         CFjbwEPN94kZ2GDYNRYc0oMz2FVkb2++JkXgkyMAD0POa+xzd3zmvFAaD0D01GIEoW9Z
         JEsfER1fKyP7qbpZHwJrfZYBkv3L6xw2da9FuaZVuACgoPbN3gJSyymPsm+z+YmKywpw
         StTlraG0Q2Z0erxa0vkNFjARZEbr1Ig6NTs08q4DW3VtEFfydPLmcmiePQDET8je3ng6
         5LEQ==
X-Gm-Message-State: AA6/9RmDW2sXMxHuhLrSM0CoEvU9ek+SDA1qtbPY1/d2tAW9t9gb6K6wSU/+ZeaxzGGrxG0+f3Y/QlZhFYhfPR+U
X-Received: by 10.237.33.203 with SMTP id m11mr6536548qtc.61.1475623527483;
 Tue, 04 Oct 2016 16:25:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 4 Oct 2016 16:25:27 -0700 (PDT)
In-Reply-To: <xmqqtwcrr9l6.fsf@gitster.mtv.corp.google.com>
References: <20161004221433.23747-1-sbeller@google.com> <xmqqtwcrr9l6.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Oct 2016 16:25:27 -0700
Message-ID: <CAGZ79kaFx++yipGmq=D2EPN4Gw9JhRXf_i4pFivTnkJmJXjFfg@mail.gmail.com>
Subject: Re: [RFC/PATCH] attr: Document a new possible thread safe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 4:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
>> index 92fc32a..940617e 100644
>> --- a/Documentation/technical/api-gitattributes.txt
>> +++ b/Documentation/technical/api-gitattributes.txt
>> @@ -59,7 +59,10 @@ Querying Specific Attributes
>>    empty `struct git_attr_check` can be prepared by calling
>>    `git_attr_check_alloc()` function and then attributes you want to
>>    ask about can be added to it with `git_attr_check_append()`
>> -  function.
>> +  function. git_attr_check_initl is thread safe, i.e. you can call it
>> +  from different threads at the same time; internally however only one
>> +  call at a time is processed. If the calls from different threads have
>> +  the same arguments, the returned `git_attr_check` may be the same.
>
> I do not think this is enough.  Look at the example for _initl() and
> notice that it keeps the "singleton static check that is initialized
> by the very first caller if the caller notices it is NULL" pattern.
>
> One way to hide that may be to pass the address of that singleton
> pointer to _initl(), so that it can do the "has it been initialized?
> If not, let's prepare the thing" under lock.

Oh, I see. Yeah that makes sense.

>
>> @@ -89,15 +92,21 @@ static void setup_check(void)
>>
>>  ------------
>>       const char *path;
>> +     struct git_attr_check *result;
>>
>>       setup_check();
>> -     git_check_attr(path, check);
>> +     result = git_check_attr(path, check);
>
> I haven't formed a firm opinion, but I suspect your thinking might
> be clouded by too much staring at the current implementation that
> has <attr>,<value> pairs inside git_attr_check.  Traditionally, the
> attr subsystem used the same type for the query question and the
> query answer the same type, but it does not have to stay to be the
> case at all.  Have you considered that we are allowed to make these
> two types distinct?

I thought about that, but as I concluded that the get_all_attrs doesn't need
conversion to a threading environment, we can keep it as is.

When keeping the get_all_attrs as is, we need to keep the data structures
as is, (i.e. key,value pair inside git_check_attr), so introducing a new
data type seemed not useful for the threaded part.

>  A caller can share the same question instance
> (i.e. the set of interned <attr>, in git_attr_check) with other
> threads as that is a read-only thing, but each of the callers would
> want to have the result array on its own stack if possible
> (e.g. when asking for a known set of attributes, which is the
> majority of the case) to avoid allocation cost.  I'd expect the most
> typical caller to be
>
>         static struct git_attr_check *check;
>         struct git_attr_result result[2]; /* we want two */
>
>         git_attr_check_initl(&check, "crlf", "ident", NULL);
>         git_check_attr(path, check, result);
>         /* result[0] has "crlf", result[1] has "ident" */
>
> or something like that.

I see, that seems to be a clean API. So git_attr_check_initl
will lock the mutex and once it got the mutex it can either
* return early as someone else did the work
* needs to do the actual work
and then unlock. In any case the work was done.

git_check_attr, which runs in all threads points to the same check,
but gets the different results.

Ok, I'll go in that direction then.

Thanks,
Stefan
