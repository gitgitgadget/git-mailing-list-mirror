Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2175E20970
	for <e@80x24.org>; Fri, 14 Apr 2017 16:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbdDNQdZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:33:25 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34769 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdDNQdX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:33:23 -0400
Received: by mail-lf0-f53.google.com with SMTP id t144so44086114lff.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ILBkFYLj8/lUx6QHBxf2HB87wdFkgDxTwS63IUE7s/8=;
        b=V7H9zjkzqDG6Mb+NtSzMcBLl6rx/GAvye4msZUkaP6qz7+lTOVQGA8yX8+c1ZJ3Xa6
         lznc91/jnhaM6CXjW0P9ncv0mwQtwihDqnq13Uasrp0YYtCAaB6FYBoqJC6+GE1NquUI
         Y+4g8QTc0JmV7zf/Rz22l+SRn1JKis8xl4U3wXOPrVY0puLbkTMw0dN5W2c28ijT1vmq
         DbLvaMl2FgWoDE2/3n9fXAHrYGUv1hBNZ57iCx1xyMbg49LZRtdUoCvfKzZ2ajee9RUq
         g4KyuqY0LpIq0CHL9X8JIAzqsYfOMlw9yFoSLGksW3LPYoeuSskrOEopnqYyj8en9LXz
         a7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ILBkFYLj8/lUx6QHBxf2HB87wdFkgDxTwS63IUE7s/8=;
        b=LAH7WLse3lH2HjI2OKlqABNGwu7oskAsBXBJyGnwuLpzzPfqEUzBaZZp0+WFkNrJrI
         rJLLFUu1aIBOy98B/ziCCUQ5iMh42XVDeE/v2GFLRXMCSKMDQPGVaEFWdaLhj6qaxvNX
         j64YmvsOfvEfEl0dI9YVpZ5TgKhY//BlvdKOC1Si0aNzVknbEM9HtDNbggXrwORETSND
         GynNk2XLBrf7n2FP9Gc7n/jK3NHjEJ0K/frlTR5K9d7o8k0AAsW94eY+MVMJO2Fu1uhZ
         s5thB7Tky8QlVkSPWjjqh+T0KLbas/NQB1YAPbmW4+7d1ShhRW5JFsnHQj2UWgTgF8Yw
         xcEQ==
X-Gm-Message-State: AN3rC/59BBO+uEY8hIP4ym+KXDnlx2uDuzn1WDwDnOBlq67TVyIyGbzv
        Anb5pHP6eCNcZF4vHvqTzJL68g0PcQ==
X-Received: by 10.25.24.217 with SMTP id 86mr3235378lfy.12.1492187601664; Fri,
 14 Apr 2017 09:33:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Fri, 14 Apr 2017 09:33:01 -0700 (PDT)
In-Reply-To: <CAGZ79kaRTrgHMnP6mA3V2rDHzf8iOidqLTpp2aXmi6x+6YeZxw@mail.gmail.com>
References: <20170413171224.3537-1-jacob.e.keller@intel.com>
 <20170413185707.97746-1-bmwill@google.com> <CAGZ79kZ8KV+c2StKR8tp=s_E1+uEaSezgsmUfyyO9HUrmzdT+g@mail.gmail.com>
 <CA+P7+xp=1PUsq1_or=J8ED+-1NMaF=BckC9bK4jqWbA+RFeszw@mail.gmail.com> <CAGZ79kaRTrgHMnP6mA3V2rDHzf8iOidqLTpp2aXmi6x+6YeZxw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 14 Apr 2017 09:33:01 -0700
Message-ID: <CA+P7+xoY-FFXEkPgQBA4=Twq+G5YZrHkBqiO+sKHcGJe7xt7vw@mail.gmail.com>
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 12:25 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Apr 13, 2017 at 12:12 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Thu, Apr 13, 2017 at 12:05 PM, Stefan Beller <sbeller@google.com> wrote:
>>> On Thu, Apr 13, 2017 at 11:57 AM, Brandon Williams <bmwill@google.com> wrote:
>>>> Add in a check to see if a submodule is active before attempting to
>>>> recurse.  This prevents 'ls-files' from trying to operate on a submodule
>>>> which may not exist in the working directory.
>>>
>>> What would currently happen on recursing into non-active submodules?
>>> Can we have a test for this?
>>>
>>> Thanks,
>>> Stefan
>>
>> We should be able to test for this. Is it possible that we can recurse
>> into a submodule as long as we have the clone in .git/modules/<name>
>> even if we don't have it checked out currently?
>
> Conceptually that should be possible, e.g.
>
>     git ls-files --recurse-submodules <ancient ref>
>
> where the ancient ref contained submodules that are not present any more.
> In that case we would need to do
>
>     struct strbuf sb = STRBUF_INIT;
>     struct child_process = CHILD_PROCESS_INIT;
>     struct submodule *sub = submodule_from_path( \
>         <path as recorded in ancient tree>, <ancient ref>)
>     strbuf_git_path(&sb, "modules/%s", sub->name);
>
>     argv_array_pushl(&cp.args, "git", "ls-files", "--recurse", ...);
>     cp.dir = sb.buf;
>     run_command(&cp);
>
> Stefan

Never mind. git ls-files doesn't support showing files for a specific
ancient history. (I guess you'd use ls-tree for that?). I'm guessing
we want to run in the actual work-tree for ls-files here.

Does "is_submodule_initialized()" going to ensure that we only operate
on a submodule that's currently checked out?

Thanks,
Jake
