Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02BF1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 19:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeCVT3V (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 15:29:21 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41018 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbeCVT3U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 15:29:20 -0400
Received: by mail-lf0-f67.google.com with SMTP id o102-v6so14865999lfg.8
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=628BKbmg/1EUhWdnPu0emYApF7y+z82rE+AiGh2KWmo=;
        b=bpQC89MRirbFd+1nkl38NtLdXOiq9S5VwFGJvf0MsFmPUuLQP6qaIAuV66sxvvHlL+
         BSRpR4oDSnkkDR68fnJdKZUSlDEb4cG295jEQ4/TSH65GNwxLQMUqzlSXcMQnkvkIjtB
         oU76wzTtxqroFznlDqBxywHEWcwiCzCBXPsvVYyM1Ng4oa3ZIVXkAiPFtviuRapqQLnG
         jvCx5WQU5hJa2Bd3BBvKrB/dUsLMtFPljX/T3lbkfhB3qbra/Fcv/pGVd09AUOn8fzrS
         OCjxz2mHuIEq/rEwHBVCv++r0frLKON7Shynr7o9hAhquvP7QD2DPeOxWg23XLoMudM1
         XauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=628BKbmg/1EUhWdnPu0emYApF7y+z82rE+AiGh2KWmo=;
        b=Od2TyvXPGKybb7eQ4EuNzmZAsV8PlOrUUdc5quLF8jAOnkxjSfV7PoMNeFJXVMtkjx
         +4jPhVpIrH7laEy8Dv//x5bSf+CJaGXHxFIz97md0k+KKzh4wK0GGHaz4RmVaGxSXVAV
         XQZDcyS+3XjiyzXC/Cqaqc2Hx8ezvbQhJcOq1bMhsEoVy2Q5ZaD/d79Zc8zfzKji++IN
         PJwWKLKDtRZ7kJNbNOaeux88b4VrP9GCZlmJu/LnR0KeqcizHBHBJZDfZi0e9BCtSxp6
         KXOudXbmA8FKOykg0Pj6b+0RpEAe/WirO29VsfT7r3Y+QLpb0JeA0WLcD2h/kjBg6BAQ
         m9TA==
X-Gm-Message-State: AElRT7GeIhRh0CrQ84VxOgSnvu9ExtJ45pCqJOOwqSQNV0zkWnng1sc8
        zLsDvPevPoBiw+conoJ5PqAXFKIVkTS9dwVli9bu5Q==
X-Google-Smtp-Source: AG47ELsStBgBFB0k3Kcc+wfkvejUQKNyP4QGdTSmuTgT1O2rf3OzEMweOLIUbDKRUfMJfCmGEeKzhE6VNj91eHcJwxk=
X-Received: by 10.46.85.196 with SMTP id g65mr1911949lje.10.1521746959286;
 Thu, 22 Mar 2018 12:29:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9a93:0:0:0:0:0 with HTTP; Thu, 22 Mar 2018 12:28:58
 -0700 (PDT)
In-Reply-To: <xmqqpo3wklt2.fsf@gitster-ct.c.googlers.com>
References: <cover.1521690197.git.wink@saville.com> <47b224af1c22900a69d0e292935f37a719b6a9f3.1521690197.git.wink@saville.com>
 <xmqqpo3wklt2.fsf@gitster-ct.c.googlers.com>
From:   Wink Saville <wink@saville.com>
Date:   Thu, 22 Mar 2018 12:28:58 -0700
Message-ID: <CAKk8isoL--f1gt_p5XZ99ybN+xts=0_AKBo52Ej=n3SMPoMq3A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/9] Call git_rebase__interactive from run_specific_rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 11:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Wink Saville <wink@saville.com> writes:
>
>> Instead of indirectly invoking git_rebase__interactive this invokes
>> it directly after sourcing.
>>
>> Signed-off-by: Wink Saville <wink@saville.com>
>> ---
>>  git-rebase--interactive.sh | 11 -----------
>>  git-rebase.sh              | 11 +++++++++--
>>  2 files changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 561e2660e..213d75f43 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -740,15 +740,6 @@ get_missing_commit_check_level () {
>>       printf '%s' "$check_level" | tr 'A-Z' 'a-z'
>>  }
>>
>> -# The whole contents of this file is run by dot-sourcing it from
>> -# inside a shell function.  It used to be that "return"s we see
>> -# below were not inside any function, and expected to return
>> -# to the function that dot-sourced us.
>> -#
>> -# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
>> -# construct and continue to run the statements that follow such a "return".
>> -# As a work-around, we introduce an extra layer of a function
>> -# here, and immediately call it after defining it.
>
> We still enclose the whole thing (including the returns that are
> problematic for older FreeBSD shells) in a shell function, so it's
> not like we are dropping the workaround for these systems.  It's
> just the caller of the function moved.
>
> I think the removal of this large comment is justifiable, but the
> structure still needs a bit of explanation, especially given that
> the caller in git-rebase.sh needs to treat this scriptlet a bit
> differently from others.
>
> If we were not in the (longer term) process of getting rid of
> git-rebase.sh, it might even make sense to port the same
> "dot-sourced scriptlet defines a shell function to be called, and
> the caller calls it after dot-sourcing it" pattern to other rebase
> backends, so that the calling side can be unified again to become
> something like:
>
>         . git-rebase--$type
>         git_rebase__$type
>         ret=$?

I've gone with the above suggestion and added back some
of the header.
