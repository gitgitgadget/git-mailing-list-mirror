Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A195F1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 12:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeFFMUS (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 08:20:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45000 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeFFMUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 08:20:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so3046478pfk.11
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 05:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mKjDpgin8gb1q1Yrw6yAJx0Lhtck+rtmoEaBfn6B+Iw=;
        b=hC7oPvIed1i7b/etnbqnPxEjnR+xyAZUDHlNVMUPAqPl1gu63RHB85zEJvSjaZWMHs
         d3k8JUTa5bPrcZSrZ+VUlYccr/jQzaXfaqbMV4Zsw5GFMvMPAM2RCV7tnKbEm2MrEdnG
         9IGadM+vz0sihHOV2FRNYffZlepTymdgas10XQ/9dgNzxV8P3glaoRB/qgCKT7Ep0zer
         TFAmQGqVTbgSBucgl84BTY7dRnducelCqiEAOy5N0eRtEEAaQlCRXCgaZN3ru6rWtpUh
         ZIj6rZvwGx3gOOB0m17aS+xfb/PwHWaNPHBLg/atdzNsRE8mLwRR768G74q8nKDtEPoZ
         2XaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wol.ph; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mKjDpgin8gb1q1Yrw6yAJx0Lhtck+rtmoEaBfn6B+Iw=;
        b=SVtV5RP+UN1UvRobMHHEKbgAfJ1zAPZKkRF8dweL+Dy54p/PU0AsTYc5bUD2ZNijTX
         CCgEemdi2qH9m9F2SDraY+bUL9RkuJmu+z4FBzGR/f9BD9TfjUUDGtJr33GuS7mwSgfB
         ukW862ZWUKZGekXPvkIEqJASGEzDj7MB7SSGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mKjDpgin8gb1q1Yrw6yAJx0Lhtck+rtmoEaBfn6B+Iw=;
        b=U7K4TvqsmSb10+eIxc6QAVUEFGSROeal73taG8nSKhPFIKHh1ZhzaaIzkE3P1Q47Ge
         2N0h5O2NCd6R2p3we/ow6s92wpkyZ+JRapo7vcYosMNo3T9MBRSTv7gP7qCljwrkoiPw
         mT5jgADESm4n4lX37ximuosCELIqyP7CYb4wPcK43jnTCWkwCGJrzE6CdBnPmYW1+OC0
         RJUhhYT1qSsHMHCvsE8UEk7heHGkyPqgbIZnHSwOPHt74IXrdJzKpJL7cQqZB7z8jVIs
         mfa4lHlyqZu1iSyQfsH4cgjsit4x8E6BTAz0LDu6JsTTfnTS5xyTYd7XC4tRMAoe+69w
         cz6Q==
X-Gm-Message-State: APt69E3ZM3TUd2hES0fCTN219COyPXtZhKASdUV536JnpozPkuLJcGIW
        J41VFRHLvyD0RiylIaXVXQcPpFVwvhdElkv4lNp2Kht0
X-Google-Smtp-Source: ADUXVKJ7vb6NOFm+i5yFO5h1xnkb0HfXH1e6hWI9jOh/rhEV7pAjF709/4zBhwssEC+SJLKc3KbE6JGeS6PQcDm/oMo=
X-Received: by 2002:a62:458a:: with SMTP id n10-v6mr2217247pfi.215.1528287617241;
 Wed, 06 Jun 2018 05:20:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2ec9:0:0:0:0 with HTTP; Wed, 6 Jun 2018 05:19:56
 -0700 (PDT)
In-Reply-To: <20180606114147.7753-1-szeder.dev@gmail.com>
References: <01020163c683e753-04629405-15f8-4a30-9dc3-e4e3f2a5aa26-000000@eu-west-1.amazonses.com>
 <xmqqr2ln5ide.fsf@gitster-ct.c.googlers.com> <CAJAwA=xjS6bWO2Cy+-pz-Es_RjvSyno9JNBGdPAve1L9ctOy-A@mail.gmail.com>
 <20180606114147.7753-1-szeder.dev@gmail.com>
From:   Rick van Hattem <wolph@wol.ph>
Date:   Wed, 6 Jun 2018 14:19:56 +0200
X-Google-Sender-Auth: dvXwUtOjh3k5FzTRZvtfCPJV9VM
Message-ID: <CAJAwA=yhMumYY562k2hcoeABML5a6dsJsLwGwiQUsWHmbNF10Q@mail.gmail.com>
Subject: Re: [PATCH] Use ZSH_NAME instead of ZSH_VERSION because it's
 redefined by git-completion.zsh
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 On 6 June 2018 at 13:41, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:
>
>> On 4 June 2018 at 05:40, Junio C Hamano <gitster@pobox.com> wrote:
>> Rick van Hattem <wolph@wol.ph> writes:
>>
>> > > The `git-completion.zsh` unsets the `$ZSH_VERSION` which makes this =
check moot. The result (at least for me) is that zsh segfaults because of a=
ll the variables it's unsetting.
>> > > ---
>> >
>> > Overlong line, lack of sign-off.
>>
>> Apologies for the long lines, I wrote the message on Github where this
>> message is properly formatted, apparently the submitgit script can be
>> considered broken as it truncates the message when converting to email.
>>
>> The original message can be found here: https://github.com/git/git/pull/=
500
>
> That link points to the pull request.  The important thing is the
> actual commit message, which can be found here:
>
>   https://github.com/git/git/pull/500/commits/b740bc3fedf419c7ee12364279c=
ad84e1f2f7bb7

Ah, now I see the problem. That was unintentional, I created this pull
request through the Github interface where wrapping is auto enabled
which masked the issue for me.

That's what I get for trying to use a webinterface instead of doing
this commandline... mea culpa.


>> Because the ZSH script unsets the ZSH_VERSION variable (which is needed
>> because the bash script checks for that later in the script) it defaults
>> to the bash behaviour resulting in a segfault.
>
> I think this segfault issue should definitely be addressed in ZSH.  No
> matter what foolish or downright wrong thing a script does, the shell
> should not segfault.

I agree, segfaulting is unacceptable behaviour.

>> > If your ZSH_VERSION is empty, doesn't it indicate that the script
>> > did not find a usable git-completion.bash script (to which it
>> > outsources the bulk of the completion work)?  I do agree segfaulting
>> > is not a friendly way to tell you that your setup is lacking to make
>> > it work, but I have a feeling that what you are seeing is an
>> > indication of a bigger problem, which will be sweeped under the rug
>> > with this patch but without getting fixed...
>>
>> The git-completion.zsh script purposefully unsets the ZSH_VERSION
>> before including the git-completion.bash script like this:
>>
>>     ...
>>     ZSH_VERSION=3D'' . "$script"
>>     ...
>
> Oh, I was not aware of this.  It does feel a bit hackish, doesn't it.

Yes, it definitely does feel hackish but since this has been the case
for a long time I worry about breaking backwards compatibility with
peoples shell configs by changing the behaviour now.

>> The reason for that is (presumably) the check that's used within the
>> git-completion.bash script to warn ZSH users:
>>
>>     ...
>>     if [[ -n ${ZSH_VERSION-} ]]; then
>>     echo "WARNING: this script is deprecated, please see
>> git-completion.zsh" 1>&2
>>     ...
>
> And, perhaps more importantly, to not load a bunch of shell functions
> that follow that warning.
>
>> >>  # Clear the variables caching builtins' options when (re-)sourcing
>> >>  # the completion script.
>> >> -if [[ -n ${ZSH_VERSION-} ]]; then
>> >> +if [[ -n ${ZSH_NAME-} ]]; then
>
> Looking at $ZSH_VERSION is our standard check both in the completion
> and prompt scripts.  Changing only one of those checks to look at
> $ZSH_NAME instead brings inconcistency and confusion.
>
> I think it would be better to eliminate that "let's pretend it's not
> ZSH" hack and make 'git-completion.zsh' more explicit by sourcing
> 'git-completion.bash' something like this:
>
>   DOT_SOURCING_FROM_GIT_COMPLETION_ZSH=3DPleaseSkipDeprecatedFunctions . =
"$script"
>
> (with a more sensible variable name, of course :), and
> 'git-completion.bash' should additionally check this variable as well.

I agree, that would be a better solution.

For the time being I would opt for either reverting 94408dc or
implementing this commit though.

~rick
