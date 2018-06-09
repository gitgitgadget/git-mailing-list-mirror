Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981551F403
	for <e@80x24.org>; Sat,  9 Jun 2018 23:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeFIXFX (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 19:05:23 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33638 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbeFIXFW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 19:05:22 -0400
Received: by mail-vk0-f68.google.com with SMTP id 200-v6so10327231vkc.0
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ca3uV8Knu9pUSqhMmXONyUM8eiF6ao0nOGXYwUwXxYo=;
        b=ltqHvpx0WU3sdA3lL2v9GZA1OFU++93uWhQfOAGGT4tbHdstbLS0BxoJ4/EMNzj4U8
         8MwROUXXfIim5haeNz5UiCnVVpHrrfxTQ5bxGI6Z1Umq/03Z/KK6TdTagOBaluGEMGrX
         MqTPLc3Ooy2eEF8jTaQ+qyxXCjn2T7a2l+ReBhRavuaQs9kgJcAUnNrtna65IyiLEuBX
         cG5RjS3A2IZlpufT0vN+AwXjn8hmO7wDZ8UHI75nbR8y95xm209YRxOnJgd8beVjod57
         IwWQbXV97rzxjh1p7oRTyByrrtko0Ovx3LGF8mritRRSiZv4YcfJXFASzWB2sd13Fe14
         Cd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ca3uV8Knu9pUSqhMmXONyUM8eiF6ao0nOGXYwUwXxYo=;
        b=o8Oik6WmJFGYjYWPm36ZyerUCCgXi915ve/Wh6KfwUgeg/MrQrCCqo1qx0MKcvjaLO
         q9DjXAr+oaWpg/LQxPe63x770tEMbwru1y8ho2E2G7e4vozIKEGtuERpzrhUPHDDdBfq
         JoX46OlaIa6ws2EqXyM2ZoKr7xAMcDyjeEtcvUCCgBKmK/zI+g1z7LCFVcrjLVnPM83P
         JCwfM62ALxOYh/sq0PWWmpVHFVNlkZ3l0SXi5sElWuuOcvAVbX0gc5bsZ4PYfkb1Q17s
         6UWHFtM2XIjfbdFoT3BmvRDffm+sb7MDgk5V6zhAjofchcwM8bwXHkhbhz3o/ARQagJq
         7khw==
X-Gm-Message-State: APt69E3p2MOS+FPIdeD720lYwe5nC1NOjYr4kRMkVqKHi+PeUNSHN1/A
        3UaYWTRFGVYngYVAbjdA/XEr0D8yREM6AzzibVA=
X-Google-Smtp-Source: ADUXVKJZb/pHf2o+VAG+yDpS7eTCqwNH3MxqCVOW1zpTcmi541VH4eXbpx8uYy5B7PesGn9Eau4xaLOs2Fsd3/7nYQo=
X-Received: by 2002:a1f:2cc6:: with SMTP id s189-v6mr7078931vks.106.1528585521487;
 Sat, 09 Jun 2018 16:05:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 16:05:21 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1806092336320.77@tvgsbejvaqbjf.bet>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-2-newren@gmail.com>
 <nycvar.QRO.7.76.6.1806092336320.77@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Jun 2018 16:05:21 -0700
Message-ID: <CABPp-BHHgtmtn=menfk5L5s9nmG1NkNa9rfw-_kjvm+U8tUo1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] git-rebase, sequencer: add a --quiet option for
 the interactive machinery
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sat, Jun 9, 2018 at 2:45 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 7 Jun 2018, Elijah Newren wrote:
>
>> While 'quiet' and 'interactive' may sound like antonyms, the interactive
>> machinery actually has logic that implements several
>> interactive_rebase=implied cases (--exec, --keep-empty, --rebase-merges)
>> which won't pop up an editor.  Further, we want to make the interactive
>> machinery also take over for git-rebase--merge and become the default
>> merge strategy, so it makes sense for these other cases to have a quiet
>> option.
>>
>> git-rebase--interactive was already somewhat quieter than
>> git-rebase--merge and git-rebase--am, possibly because cherry-pick has
>> just traditionally been quieter.  As such, we only drop a few
>> informational messages -- "Rebasing (n/m)" and "Succesfully rebased..."
>
> Makes sense. As long as it is coordinated with Alban and Pratik, as both
> of their GSoC projects are affected by this.

I had Alban cc'ed, and had looked briefly at the GSoC projects but
somehow missed that Pratik was also working in the area.  Adding him
to cc.

> In particular Pratik's project, I think, would actually *benefit* from
> your work, as it might even make it possible to turn all modes but
> --preserve-merges into pure builtin code, which would be awesome.

:-)

>> @@ -713,6 +717,7 @@ Commit or stash your changes, and then run
>>               "$hook" rebase < "$rewritten_list"
>>               true # we don't care if this hook failed
>>       fi &&
>> +             test -z "$GIT_QUIET" &&
>>               warn "$(eval_gettext "Successfully rebased and updated \$head_name.")"
>
> In general, I tried the statements to return success at all times. That
> means that
>
>                 test -n "$GIT_QUIET" ||
>
> would be better in this case.

Good point, I'll switch it over.

>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index 7d1612b31b..b639c0d4fe 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -136,7 +136,7 @@ write_basic_state () {
>>       echo "$head_name" > "$state_dir"/head-name &&
>>       echo "$onto" > "$state_dir"/onto &&
>>       echo "$orig_head" > "$state_dir"/orig-head &&
>> -     echo "$GIT_QUIET" > "$state_dir"/quiet &&
>> +     test t = "$GIT_QUIET" && : > "$state_dir"/quiet
>
> Maybe it would be better to `echo t` into that file? That way, scripts
> that used the value in that file would continue to work. (But maybe there
> were no scripts that could use it, as only the interactive rebase allows
> scripting, and it did not handle that flag before?)

Right, I don't think we had users before, and I'd rather make the code
a little more self-consistent.  In particular, since
$state_dir/verbose work based off the presence of the file rather than
the contents, I'd rather we just did the same for $state_dir/quiet.

However, there is one bug here; in order to make it like verbose, I
need to also make the following change:

diff --git a/git-rebase.sh b/git-rebase.sh
index c8c3d0d05a..8f0c7a4738 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -119,7 +119,7 @@ read_basic_state () {
        else
                orig_head=$(cat "$state_dir"/head)
        fi &&
-       GIT_QUIET=$(cat "$state_dir"/quiet) &&
+       test -f "$state_dir"/quiet && GIT_QUIET=t
        test -f "$state_dir"/verbose && verbose=t
        test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
        test -f "$state_dir"/strategy_opts &&


> The rest looks obviously good.


Thanks!
Elijah
