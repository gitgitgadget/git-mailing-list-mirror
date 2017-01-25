Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04D71F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 20:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbdAYUKM (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 15:10:12 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:35785 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbdAYUKL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 15:10:11 -0500
Received: by mail-it0-f47.google.com with SMTP id 203so116897636ith.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 12:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zYaduK6PMAIOtiFEUAVMoPbH1EtQ17XrnLvgaiZYo8g=;
        b=b7aMuE56aDchYXdqVm9wCgSkaSVvaos8Omzty3vXd1mAGglowP/xcby1XP//eY29OK
         F3YOdDsmG1kE6wXshl4l+bansmw9HAWVw8kC+xZKCFq+Dj71pxyBdR5oRjJeHODDmgZG
         O3XIaDv4vc1wiYFVcCP8MENIcFkdrTI5hIJknu/W0zp4wbMYUbqK5e3g5924FuJlQaht
         /EAC14VOT1VljEHAXIClftQVK0LRchprJyB+7T6p8+SSIbeHn3ajUHJ2g2GGJ2rcbtK+
         aMV1JTZzgRJkc50heLtAtaAIAiIvPg9KtmZHGkx8kjS+kwEcQELYgvwO/Kol/gZgj98L
         yJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zYaduK6PMAIOtiFEUAVMoPbH1EtQ17XrnLvgaiZYo8g=;
        b=LoCCiTW9SDMSjsrb9sryEHwwaGvCIS6P+W7KGFM7SG5/pXvyOE2ICezYUv+BHocAoV
         UX6kz0vaAG2wvQLhWPj7F+w5m61FUi80oN5ZBeO8KKJMfvoyP9M1xsrRQGp1YAiCNLF4
         xhJI9/HR9xU0tjo983HRpMe8xd+FO2JsIICYEdcIdlmAlufyl7H5KOvE3GG/yBIVhuJd
         3vuvuaS0DN6Ig6grnQWJTsdBiHPk+XgL4YNN2QP1ut/aGeNcFEODdAn8cVFOvbHGDcvn
         Bod3/Ob3Y+bL0vGCGVLjI1trb1BEInlofB9VbZBGXaKUhZLI97Iv6UUKFoP/htvLq+jx
         uxaA==
X-Gm-Message-State: AIkVDXJFAjCItevJIX7ce/n4xe1IE17oBpR1GOcEDJxXpPaNPLJY9HEci4DCbSIA/KSAAaMV4o7J/61REyfBxBYX
X-Received: by 10.36.40.198 with SMTP id h189mr2952831ith.114.1485375010310;
 Wed, 25 Jan 2017 12:10:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 25 Jan 2017 12:10:09 -0800 (PST)
In-Reply-To: <20170125195745.GA83343@google.com>
References: <20170112235354.153403-1-bmwill@google.com> <20170123203525.185058-1-bmwill@google.com>
 <20170123203525.185058-26-bmwill@google.com> <xmqq37g9qwr2.fsf@gitster.mtv.corp.google.com>
 <20170123220614.GA187696@google.com> <20170124011135.GB187696@google.com>
 <xmqqinp5p4x2.fsf@gitster.mtv.corp.google.com> <20170125195745.GA83343@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Jan 2017 12:10:09 -0800
Message-ID: <CAGZ79kYhfgKnpA1KOYFu-7J+tsqfeCDnshbVKRAdCnnOiQP16w@mail.gmail.com>
Subject: Re: [PATCH v2 25/27] attr: store attribute stack in attr_check structure
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 11:57 AM, Brandon Williams <bmwill@google.com> wrote:
> On 01/23, Junio C Hamano wrote:
>> Brandon Williams <bmwill@google.com> writes:
>>
>> > ... It seems like breaking the question and answer up
>> > doesn't buy you much in terms of reducing allocation churn and instead
>> > complicates the API with needing to keep track of two structures instead
>> > of a one.
>>
>> In my mind, the value of having a constant check_attr is primarily
>> that it gives us a stable pointer to serve as a hashmap key,
>> i.e. the identifier for each call site, in a later iteration.
>
> We didn't really discuss this notion of having the pointer be a key into
> a hashmap, what sort of information are you envisioning being stored in
> this sort of hashmap?  One issue I can see with this is that the
> functions which have a static attr_check struct would still not be thread
> safe if the initialization of the structure isn't surrounded by a mutex
> itself. ie
>
> static struct attr_check *check;
>
> if (!check)
>   init(check);
>
> would need to be:
>
> lock()
> if (!check)
>   init(check);
> unlock();
>
> inorder to prevent a race to initialize the structure.  Which is
> something that the attr system itself can't be refactored to fix (at
> least I can't see how at the moment).

By passing the check pointer into the attr system (using a double pointer)

    extern void git_attr_check_initl( \
            struct git_attr_check out**, \
            const char *, ...)
{
    // get the global lock, as construction of new check structs
    // is not expected to produce contention

    // parse the list of things & construct the thing

    *out = /* I made a thing */
    // unlock globally
}

>
>> Of course, in order to populate the "question" array, we'd need the
>> interning of attribute names to attr objects, which need to be
>> protected by mutex, and you would probably not want to do that every
>> time the control hits the codepath.
>
> While true that doesn't prevent the mutex needed to create/check that
> the all_attr array that is used to collect attributes is the correct
> size/initialized properly.
>
>> But all of the above comes from my intuition, and I'll very much
>> welcome to be proven wrong with an alternative design, or better
>> yet, a working code based on an alternative design ;-).
>
> Yeah, after working through the problem the two simple solutions I can
> think of are either my v1 or v2 of the series, neither of which allows
> for the attr_check structure to be shared.  If we truly want the
> "question" array to be const then that can be done, it would just
> require a bit more boilerplate and making the all_attr array to be
> local to the check_attrs() function itself.  An API like this would look
> like:
>
> static const struct attr_check *check;
> struct attr_result result;
>
> if (!check)
>   init_check(check);
>
> // Result struct needs to be initialized based on the size of check
> init_result(&result, check);

Behind the scenes we may have a pool that caches result allocations,
such that we avoid memory allocation churn in here


>
> check_attrs(path, check, &result);
>
> // use result
>
> attr_result_clear(&result);

Instead of clearing here, we'd give it back to the pool, which then can keep
parts of the result intact.
