Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3924C207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbdEBERs (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:17:48 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36323 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdEBERr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:17:47 -0400
Received: by mail-pg0-f44.google.com with SMTP id t7so54247900pgt.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YpY0d6b3gbxuIZPydJ17M0AbYXUx++x1U7V4T0srlBw=;
        b=AvXzcJg7XkF/KYDgiboyS9i4oR3V3SNFnYIJH8ZCjtkAOq4DWupul1d1thUTsu0t8p
         uNWEWISV4D00Cl3h4TOkFCpXr6SEtaziZuXtL9TylKlUItcFns5OhbaYlGmKbpBUv5F7
         N8I9wQWc5n3+mpBASVRLif2VhsB5l1ieUGVvmSBf9pkjWlHvQcc7DPJL+piquttIBJ6R
         CtFATIOCuUNoz5Wb+Zs7907w00g8sNs38LTQUhWvohbTPA4hTe44nWFJ4bWy0BOhyQ4l
         DzcJuqqG8rlPcwWMGFMFfY3HVaL2F9vaI5XGrSJ8ycegDy2V9DiSu+6KmgvdyLbUfGSv
         ClPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YpY0d6b3gbxuIZPydJ17M0AbYXUx++x1U7V4T0srlBw=;
        b=cVsVhvLoA4r0hUjAbagpVhwIGdCRsgEmsWZDVEb6bgcb8GTAn4WwAP4L5FRqVd+ts9
         bj1FUhYgFnnokcsThMQreaLhMkD5hjaqrNMwxvt5CkeqImhBkOPwH21B1UjwQY6MJxi7
         PcbiOrV6ItYNuQc82/x9zq2r/lCIRsfKnoTLh57bVw4X1Wme64+j1TNCt1DtyaBJhbf9
         iw5Ect2lCERGspzfQKnuDyN0k0k/+lS2HdGQdZXnZoVWCG3TO20Euc9jefxAcRneAler
         mOybpxh9mG0FX2rHDJGXv9xuh4viRO5pu62lTRuKTZtNaXUkqygT86IdGd9Cemc+oqla
         7nqA==
X-Gm-Message-State: AN3rC/5xiogJl7oq2pW9W/vxUvYMdJFZ7yKsbsnKBqbvOqt0WzkdgNeQ
        KO+X6j1XufND7zori/zP7UPmAlUso6qV+6z8GA==
X-Received: by 10.84.142.133 with SMTP id 5mr38698356plx.52.1493698666477;
 Mon, 01 May 2017 21:17:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.169.14 with HTTP; Mon, 1 May 2017 21:17:44 -0700 (PDT)
In-Reply-To: <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
References: <20170501190719.10669-1-sbeller@google.com> <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 May 2017 21:17:44 -0700
Message-ID: <CAGZ79kZkssTEdNyzYh1YYv89szvig=rn2j3DJcHxsbzdADRw-w@mail.gmail.com>
Subject: Re: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 6:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This applies to origin/master.
>>
>> For better readability and understandability for newcomers it is a good idea
>> to not offer 2 APIs doing the same thing with on being the #define of the other.
>>
>> In the long run we may want to drop the macros guarded by
>> NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.
>
> Why?  Why should we keep typing &the_index, when most of the time we
> are given _the_ index and working on it?

As someone knowledgeable with the code base you know that the cache_*
and index_* functions only differ by an index argument. A newcomer may not
know this, so they wonder why we have (A) so many functions [and which is the
right function to use]; it is an issue of ease of use of the code base.

Anything you do In submodule land today needs to spawn new processes in
the submodule. This is cumbersome and not performant. So in the far future
we may want to have an abstraction of a repo (B), i.e. all repository state in
one struct/class. That way we can open a submodule in-process and perform
the required actions without spawning a process.

The road to (B) is a long road, but we have to art somewhere. And this seemed
like a good place by introducing a dedicated argument for the
repository. In a follow
up in the future we may want to replace &the_index by "the_main_repo.its_index"
and then could also run the commands on other (submodule) indexes. But more
importantly, all these commands would operate on a repository object.

In such a far future we would have functions like the cmd_* functions
that would take a repository object instead of doing its setup discovery
on their own.

Another reason may be its current velocity (or absence of it) w.r.t. to these
functions, such that fewer merge conflicts may arise.

---
This discussion is similar to the "free memory at the end of cmd_*" discussion,
as it aims to make code reusable, and accepting a minor drawback for it.
Typing "the_index" re-enforces the object thinking model and may have people
start on thinking if they would like to declare yet another global variable.

Thanks,
Stefan
