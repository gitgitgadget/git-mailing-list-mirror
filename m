Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB29D1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbcHZRfr (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:35:47 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:37227 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbcHZRfq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:35:46 -0400
Received: by mail-it0-f42.google.com with SMTP id d65so2956751ith.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FO9nujKkjIGVxVwtDEz2x0DvhhDTg48jkBTUN9+2sdU=;
        b=PNw+G84664C9DVnYrTaPeyvBXlYY4/nXeQL2EgEFYL5/htt/+SjiYVm/h/jbXv17gW
         U8rQ27C8kCTMXs6xgLbVAUuMfip7cRSgLUXMC1UwO61xPOoKTAdIj5kyDEuFvUz2qvaO
         14qTIfxxs1WhxUInMi6pKtpQc/uxD8VM0c5Go4qEbhnDxrofDY0BR0WtF4/A7aw4VAhd
         ycDfiGhoWTDRTpxCGleoJK9EQdMBCoSFfCQFeKMUwaErGnu2M3jPO/23LSMizoJ6najy
         JZmgXxBG9TQjvqLe2NVFhqTWi5BkE2f9KOmFyJoC3hm5o4NqmHzlWFoGoq1BNjPC5t9z
         6/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FO9nujKkjIGVxVwtDEz2x0DvhhDTg48jkBTUN9+2sdU=;
        b=fzNhpvoLXWhONodtWLRNup7Phnt1hvvONYJ75UErFLK1TfJgWLK000plkRavrrgdCb
         3oN9qD2QpCLcarWdvnpOhULkNer/Kjr29QTchdeDAAA+VaDEFLG0t+okiPJ9CUWJn8rG
         bSB9svyd9XDhP8ZmXncmPsUvvuZdP/5yfKGricBYKk6xVjM1I3CH+tp4/dswFvdhvdKe
         jHQS3CDNJvk89E1ss+jlcdjUrPa4vIYIhsvsvRx7F6nXQdKePM2EdYyfXxuDzQrSmunx
         yZBlOoFUQuEJ6dFv4XoFc/Sb7nAvrqEYxMlPdEGbMIg9nOdfYGUDtxJvJo/G5IVikX0b
         DGqA==
X-Gm-Message-State: AE9vXwOOmXnvYUX+4Jep91nO2kVVTn3Qii73q/vEZYEELIv+t/uRS/QuVHZd4uodmwiq9fAqPIdj7ahZvCCX+NcM
X-Received: by 10.36.249.5 with SMTP id l5mr95700ith.46.1472232945098; Fri, 26
 Aug 2016 10:35:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 26 Aug 2016 10:35:44 -0700 (PDT)
In-Reply-To: <CA+P7+xqDRD4akNShqxs4D2dDUBK0E5Eyp2Y3-8xK6wEb5gCU6w@mail.gmail.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
 <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
 <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com> <CAGZ79kbsq52Qh0Jtn5hpPPfHu_9r2CUHvAHOTh6Cgz8ODkzreg@mail.gmail.com>
 <CA+P7+xrQy33gt8bnsagLVPAHhZPZx-3s0E_Aj7tOwXnHjOoCBg@mail.gmail.com>
 <xmqqr39cjwxx.fsf@gitster.mtv.corp.google.com> <CA+P7+xqDRD4akNShqxs4D2dDUBK0E5Eyp2Y3-8xK6wEb5gCU6w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Aug 2016 10:35:44 -0700
Message-ID: <CAGZ79kYbHz2E6-0qNS47KfA5Gs=Ew327LxhOyq+i3axwPVHKGQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 3:46 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Aug 25, 2016 at 3:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>> So we should support the gitlink to a repository stored at <path>
>>> without stuff inside the .git/modules, and we should support submodule
>>> gitlinks with a proper .gitmodules setup. I don't think we should
>>> die() but we should error properly so I will introduce a _gently()
>>> variant of these functions, and die properly in the regular flow.
>>
>> Because "git diff [--cached] [<tree-ish>]" in the top-level is
>> driven by a gitlink in the index, immediately after adding a new
>> submodule to the index but before describing it in .gitmodules you
>> might not have a name (and you know in that case the path will
>> become the name when adding it to .gitmodules).  Also a gitlink in
>> the index may correspond to a submodule the user of the top-level is
>> not interested in, so there may not be anything in .git/modules/
>> that corresponds to it.  In these cases, I suspect that you do not
>> want to die, but you can just tell the user "I do not have enough
>> information to tell you a useful story yet".
>>
>
> Right. submodule_from_path() fails to find a config. I don't think
> die() is right here, because there is no easy way to make this into a
> gently() variant.... I can still do it if we think a die() is
> worthwhile otherwise for the other callers of do_submodule_path...
>
> However, I think the safest thing is to just:
>
> a) read_gitfile on <path>/.git
> b) if read_gitfile succeeds, use it's contents, otherwise use
> <path>/.git for next steps
> c) check if the resulting file is a git directory, we're fine.. we
> found a gitdir, so stop.
> d) otherwise,  empty the buffer, then lookup submodules
> e) when submodules lookup succeeds.. see if we found a name. If so, use that.

When the submodules lookup succeeds, we can assert the name exists.
There is currently only one way the lookup is populated, and that is
lookup_or_create_by_name in submodule-config.c:182, which fills in
the name all the time.

> f) if we didn't just exit with an empty buffer.
>
> That empty buffer *should* trigger  revision error codes since it
> won't point to any valid path and it also triggers the regular error
> code in add_submodule_odb so it handles that with showing not
> initizlied.
>
> This method is less work then re-implementing a _gently() variant for
> all of these functions.
>
> Stefan, does this make sense and seem reasonable?

Sounds reasonable to me.

Thanks for working on this!
Stefan
