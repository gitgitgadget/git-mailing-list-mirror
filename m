Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F651F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfBFRtc (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:49:32 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41615 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfBFRtc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:49:32 -0500
Received: by mail-wr1-f41.google.com with SMTP id x10so8558183wrs.8
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jKVkjsJsQvuAHMGVEwgeRFLM7ql4cEXJE5/ANMI0AUY=;
        b=IfDSZ1F4gwMdKgA/gNtoqcQ0Km2ctrXHE+c6N20FwiCoUhWzfm80KqwJpdt/h6JVcH
         /fOxYoV7BDKQML/cj1byY/E17t2nkl5IQ3o7gPydrDgPJrdjYEgCvk74WbHsYp4zVWGs
         HRBb20sGT2fdPxkLGKUl2CeD3aT1nH5DoNU6UvfRMQwiCFcySi8Il5nacKAm/sQAlJkB
         4Mgnx3Piu4Rhg2WVz/VvwgKm6PJ0LMSAZO7gFWcLpxfOZrEsRSODw52n1njD+qha9pvl
         Fn+VO4Z80rmzjvEYassVSNeYb6RE92f+ImU52/Yd0vqCR/DY19DmlQYW++2MmXYW7z2d
         I2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jKVkjsJsQvuAHMGVEwgeRFLM7ql4cEXJE5/ANMI0AUY=;
        b=jsc1cGFpg+G30Q9sOfBHDC9+ChMT+hynFUPNjEvZo2ltR2TAGwzBenEEkLqf/QA7Ed
         WD2hZoL6F1+J3JOHuKNagJaqwsXZUEVfycCuFs8hWXiEt0TxNe8qEswoSv8K3d+13/qs
         qGU+Ajg5pRWbk9XdH2d6MtSi238npogjbC1R6DK13GW68ZVNN1zGs63tRXL0Gz8Di4Lc
         KT5tebtWAmGSajCdyMELQ0M/D/hvaM7NsVmlYvsN/06szoUTBvDndY1v9LMVSQXrMbWS
         wFmtEifn9y8nWDRMFnEZo4zXYb6uXokaS2mShPCoyl752EGCaUhTtr7+ilbdCk58nqq2
         TqFA==
X-Gm-Message-State: AHQUAubXihsWHGOvEJPeG3uleyZYgaqidU26ARdRxQeHwqPYAODk5nLK
        qlgpBniIfnfU4QHnyOXS2qmZln+K
X-Google-Smtp-Source: AHgI3IYiqer1vLXhPfDEzMLTCSTuHZUBN/XClUg48GVK/eTXGc7O8iRw1WNJaFlL7ky8UdHO1LHP4Q==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr8612016wrm.309.1549475370070;
        Wed, 06 Feb 2019 09:49:30 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 2sm591164wrg.89.2019.02.06.09.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 09:49:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2019, #01; Tue, 5)
References: <xmqq1s4lst7m.fsf@gitster-ct.c.googlers.com>
        <20190206093900.GA20697@archbookpro.localdomain>
Date:   Wed, 06 Feb 2019 09:49:28 -0800
In-Reply-To: <20190206093900.GA20697@archbookpro.localdomain> (Denton Liu's
        message of "Wed, 6 Feb 2019 01:39:00 -0800")
Message-ID: <xmqqo97oremv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Tue, Feb 05, 2019 at 03:37:01PM -0800, Junio C Hamano wrote:
>> * dl/merge-cleanup-scissors-fix (2019-01-27) 4 commits
>>  - merge: add scissors line on merge conflict
>>  - merge: cleanup messages like commit
>>  - t7600: clean up 'merge --squash c3 with c7' test
>>  - commit: extract cleanup_mode functions to sequencer
>> 
>>  The list of conflicted paths shown in the editor while concluding a
>>  conflicted merge was shown above the scissors line when the
>>  clean-up mode is set to "scissors", even though it was commented
>>  out just like the list of updated paths and other information to
>>  help the user explain the merge better.
>> 
>>  Will merge to 'next'.
>
> We should pull v6[1] of the patchset before we merge into next. It
> resolves merge conflicts related to the changed function signature of
> `append_conflicts_hint`.
>
> [1]: https://public-inbox.org/git/cover.1548219737.git.liu.denton@gmail.com/

Actually we do not have to, and we probably should not.  Here is
what I just did [*1*]:

    $ git checkout -b dlv6 master
    $ git am -s3c ./+dl4-v6-merge-cleanup-scissors-fix
    $ git checkout -b dlv5+master master
    $ git merge --rerere-autoupdate dl/merge-cleanup-scissors-fix
    $ git diff dlv6

and saw no differences in the end.

In other words, what has been queued and been tested in 'pu' (and
incidentally what I have been using as part of my private build for
day-to-day job) on dl/merge-cleanup-scissors-fix may conflict when
merged to 'master' [*2*], but a good resolution for the conflict is
already known, and becomes identical to v6 applied on master when it
is merged to 'master'.

So, I'd rather not do the busywork of replacing v5 with v6, which
also would allow us to avoid risking fat-finger mistakes while doing
so.

Thanks.


[Footnote]

*1* I name my mailbox that holds the v6 of a 4-patch topic to be
    queued on an/topic-name as ./+an4-v6-topic-name

*2* Or 'next' for that matter.  After preparing dlv6 like so, I
    can do this:

    $ git checkout -b dlv6next next
    $ git merge dlv6
    $ git checkout -b dlv5next next
    $ git merge --rerere-autoupdate dl/merge-cleanup-scissors-fix
    $ git diff dlv6next
