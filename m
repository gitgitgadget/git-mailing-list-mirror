Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5215820756
	for <e@80x24.org>; Wed, 18 Jan 2017 00:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbdARAI7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 19:08:59 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:35138 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbdARAI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 19:08:56 -0500
Received: by mail-it0-f54.google.com with SMTP id 203so107122960ith.0
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 16:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FYr0pXo5ylSMYO/L9vnGJ9mz0G7x6gxRmthKcwSFBrE=;
        b=nkCestsjyQkzlonm2jpH7bOuAWLyxJ/N/bVMwWLOVWJBOOtcpwid4lvIr0Sd4JMnan
         9TAgNM4nOxCf+lnYwUFTYRaeDljCeKV7h19rnH3FCqnMXZJqgCAYR0n19La0CLfTQMO4
         vF1CzElbkdr04EVlW7iumdnvmr/dm4ZE8AwDywQC9J6/ZxROnT0QXB9N5n1kjWAHPHkM
         ZfCMBwQOfSAD+DqpuKl+Eth6gLR4oEMdbIbqlPJQ915TZaF/RhsEF5ISQhcevewxzw+M
         2yqGZh/mhuvj8JqLix2pDvhUJ8ENkrsEwYqxKVw2sRSAVNl5QfgE32EtX9qXomX9JnX1
         adiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FYr0pXo5ylSMYO/L9vnGJ9mz0G7x6gxRmthKcwSFBrE=;
        b=KC/91VSMIF6hGAdtWohX2uNrme+dIO7FGmVttcSe5i5vBhx/7lNDwdYJsdYNyZJWry
         buGmyl6YjYWeibExEXz8eGn/2YPzvSkFe2qggv8oam2gIsiNlipTCQ36pWYRsto4gbVI
         uj2TuLUrUyPHAlkHbORrPdeZIdhgdyuGau3h+WAPGj7nZeo7mrLqloIMItxBWbYB6/XW
         pPj+WnTiAAH4VDS7Mdr+/pDJcLuVKaMdV25Bd8Hdb06A4PT8M+A16Hy9O5rf4s4/aD59
         ULSmI4dQCeD93nNDI4m7tc4vJGb/8pe+ZbeuD4hKeE2UGy9YuMJjX6tbqV5YhNqb6A4g
         DKPA==
X-Gm-Message-State: AIkVDXLNqb4+QI8v2YFf8SMyfnIf/OFxYNHopWQr7UElmSexUMDk4FxlxY6nEMvAvLmqcQRIab2fYaXMDCfuYNIs
X-Received: by 10.36.193.135 with SMTP id e129mr23066995itg.69.1484698130896;
 Tue, 17 Jan 2017 16:08:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 17 Jan 2017 16:08:50 -0800 (PST)
In-Reply-To: <xmqq8tq9ckxo.fsf@gitster.mtv.corp.google.com>
References: <20170113235427.5768-1-sbeller@google.com> <xmqq8tq9ckxo.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 17 Jan 2017 16:08:50 -0800
Message-ID: <CAGZ79kYu1Y2pwk9+kbSrMxwP3S0n8FMW6f4wdEE0mrACqrOPNA@mail.gmail.com>
Subject: Re: [PATCH] transport submodules: correct error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Trying to push with --recurse-submodules=on-demand would run into
>> the same problem. To fix this issue
>>     1) specifically mention that we looked for branches on the remote.
>
> That makes an incorrect statement ("not found on any remote"---we
> did not inspect all of the said remote, only heads and tags) into an
> irrelevant statement ("not found on any remote branch"---the end
> user would say "so what?  I know it exists there, it's just that not
> all remote refs have corresponding tracking ref locally on our side").

eh. So to be correct we need to tell the user we did not find any match on
a "remote-tracking branch" as the gitglossary puts it.

>
> Perhaps it may be an improvement.
>
>>     2) advertise pushing without recursing into submodules. ("Use this
>>        command to make the error message go away")
>
> Not mentioning "on-demand" may be an improvement for those who do
> use set-up like Dave has,

Daves setup is not a special setup; it is just git@next (later than
1863e05af5) in a repo that happens to have submodules; using
Gerrit as the code review system.

> where remote tracking information is
> incomplete if you only look at heads and refs, in the sense that we
> no longer suggest ineffective workaround.

s/ineffective/an effective/ ?

Yes. I think this is a problem in general with Git and Gerrit, as they have
different assumptions of the refs/ namespace.
(You can obtain all Gerrit changes in flight via fetching the refs/changes/*
similar to you pushing all git.git working branches not to all repositories,
but only https://github.com/gitster/git/)

> But would it be an improvement to suggest --no-recurse-submodules?

Well it is certainly better than the current situation, the user DID
use --recurse-submodules but still git refuses and advises to use
--recurse-submodules, which is understandable with background
knowledge, but very confusing at least.

The hint for --no-recurse-submodules can be understood as:
  "I told you there is something fishy with submodules, now you
  can just ignore this warning and murk up your history as you like."
which let's me question the correctness of assumptions in
1863e05af5^2.

> This issue seems like a property of the particular set-up, as
> opposed to being a one-off issue.  The next, subsequent

until Dave got the changes in the submodules reviewed and they
appear on a target branch, then fetching them, then the warning will
be gone.

> and probably
> all future pushes from that repository will have the same issue
> because the root cause is not due to the relative position of
> commits we have locally vs the tips of remote, but due to the way
> remote tracking is set-up, no?

Yes; ideally we'd have a remote-tracking ref for each change
pushed to Gerrit.

>
> If that is the case, perhaps configuring push.recurseSubmodules to
> turn this off (especially because you plan to turn the defaul to
> "check") and not giving the command line option would give a more
> pleasant end-user experience, I suspect.

I though about going another way and adding another new value
to the enum, such that

    git push --recurse-submodules=sameRefSpecButNoCheck \
        origin HEAD:refs/for/master

works for Gerrit users.

If such a thing exists, then the check is the safest-but-inconvenient
option (in all setups I'd think), and users can switch to either
sameRefSpecButNoCheck (Gerrit) or on-demand (github et al)
