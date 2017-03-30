Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF4020966
	for <e@80x24.org>; Thu, 30 Mar 2017 18:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934036AbdC3SC4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 14:02:56 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33237 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933891AbdC3SCz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 14:02:55 -0400
Received: by mail-pg0-f51.google.com with SMTP id x125so46707970pgb.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dTaaub+hfVMt95itu2m9w2huX0RkKmuMWtIAVxoRiik=;
        b=VUOHZpUB1W4tGnGxynstQy9jz8QT2IkJPCU+RAPhDQ+Dk/1vyqCzLMB8cxTluxPYEm
         CIGQtbI7KL58ffgod7BJR9NQPcuCZlOJE4Gh2Zflv5NdOBd7EouxGxjg7qkYTxwK24Dy
         B9bqfaFlKB73cfnm0q3t/+gcRvIi3rDLLqx+JzIfoMY+RTfdHbd8nld30fpQ4RPRSD2m
         ndUmd3ynUs/c429CUGgpD6qKnjZ79SCktURAeaSGCmODiAUx4r6Dv7AGKaqGGkvGxB/2
         HiH6LC5vaQ3Mvmcv83GnEWspHrsMj2UlEbG+SuO3CrGslzjVGYHh+ksXOmPhIu9YGwzh
         8Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dTaaub+hfVMt95itu2m9w2huX0RkKmuMWtIAVxoRiik=;
        b=d1MzHbJwd5K9OlPirm5mFB8BN3SI10ygbB0c79r43Gf1nAFIYiOog3mUz9beEZjICV
         gPRBUQwZWjshu1kyqxuMYZCxN3YtUZ1aoOrIThwEjTB3L0hDbMF0v2jDgDRcnX9qhdEz
         l6dmFqHC0NpsN9IgGWIZ6ICY2JiK+3A4ktW9vPJMDgxjI4v/LnbqEiWWhAwv2xIUkcmx
         lsdK3w7qEISW1LKbQvjHEWtDIBg196UVaqXG4rXXsKNiw9HIYl4ygMXs/Kl77szJlRtI
         otWcECstDBFd8lXVUUEX/JsOSMF3FdfhBiaS48/QLfb+QO5xndYWFDTxySmOmyW7ZDPl
         Tqjw==
X-Gm-Message-State: AFeK/H24HHHtazAGtFbiDI+M7HIbUjnCwX9zNcBEoDap4gdBr4z17oOZpXwFmFavzEkTzbG9uEu0qQaX3ZFC2jTb
X-Received: by 10.99.119.140 with SMTP id s134mr799205pgc.162.1490896973767;
 Thu, 30 Mar 2017 11:02:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Thu, 30 Mar 2017 11:02:53 -0700 (PDT)
In-Reply-To: <xmqqmvc37120.fsf@gitster.mtv.corp.google.com>
References: <20170330012025.22122-1-sbeller@google.com> <xmqqmvc37120.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 30 Mar 2017 11:02:53 -0700
Message-ID: <CAGZ79kbnq0uh9VGwru0JjW8_gJvUtvnt2fsCHNAyBiM=u6ENmw@mail.gmail.com>
Subject: Re: [RFC PATCH] change default for status.submoduleSummary to true
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 11:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> A user complained about the workflow with submodules:
>>> Re submodules pain, I've seen a lot of people get confused about
>>> how and when to commit submodule changes. The main thing missing
>>> in the related UIs is some way to summarize the subproject commit
>>> diff in a human readable way. Maybe last log message would be better
>>> than just sha?
>>
>> We could advise all the confused users to turn on
>> status.submoduleSummary.  However there is no downside from turning
>> it on by default apart from a slight change in behavior and bit
>> longer output of git-status and the help in git-commit.
>
> Is "there is no downside" substantiated or just hand-waving?

It's the best kind of hand waving.

> Any pros-and-cons analysis, e.g. performance implications, etc.?

Performance will be terrible. The submodule summary is gathered by
running "git submodule summary", which is shell (that is slower than
the C code in status).

In gerrit (which has 6 submodules, that I modified for the test by adding
one commit on top of each), we find

$ time git -c status.submoduleSummary=false status
...
real 0m0.043s

$ time git -c status.submoduleSummary=true status
...
real 0m0.359s

So it is slower by an order of magnitude.
Maybe it is not the right time to propose this patch then, but we'
rather want to wait until "git submodule summary" is converted to C.
(Maybe we can even parallelize the data gathering before output.)

Even for git.git (which has no submodules), we have

$ time git -c status.submoduleSummary=false status
...
real 0m0.014s
$ time git -c status.submoduleSummary=true status
...
real 0m0.125s

So additionally to porting that part to C, we may want to condition it
to a new function "int do_we_have_submodules_at_all(void)",
which has a similar heuristic as the once proposed patch
to recurse into submodules all the time
https://public-inbox.org/git/20161006193725.31553-3-sbeller@google.com/

Now that I explained why this patch is unacceptable as-is,
let's think of potential upsides:

git-status is the one command to deliver a summary on the state
of a repo with the granularity on the commit
(e.g. it reports the relation to its upstream tracking branch)
and file level (which files are change, untracked).

And I think a submodule is a weird between-state of these
two as it is seen like a file in the superproject, but it also
has commits, which are the smallest unit of logical change.

So maybe we'd want to report just a number in git-status,
which indicates how much the current detached head
is behind/before the remote tracking branch, and if it can be
fast forwarded.

Thanks,
Stefan
