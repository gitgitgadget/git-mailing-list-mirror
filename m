Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 734461F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 03:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJILOd (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 07:14:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39673 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeJILOd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 07:14:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id y144-v6so338695wmd.4
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 20:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:importance:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=1hmqP38/XjyS7Rkqo6e3PZn4Gy/7WVfqD9R6VbrHu8g=;
        b=m4sCbIQeT6ek/CT4/Q7LKhZH9lvZVy/5e+5KbUVSJ301TAS311+CyptgdjlRC5wrqI
         rF777l/jz2bUj4Zr/yHE8B6NLZr45NK+jc1mLsUrNs8ap6rEbqSCwnBgPezk+HCMjjNn
         grdSFQ0ICrRKSDAiUNBv6lzFQaGIHK6QbxhweJFfpG8uFtmmahI6CODGmTZpxqlxkrbF
         N6tFCH9rCwXV7WweMN2QtrIK7+VJPa89SXq+5a8DFN91JfeR6mBJCqVFNeTgS61fxIwo
         H9AsVZ5nR7agD/3bkfvWPwOisXCBhPlvsh2G98Aq/k3aLn1kN4cpEidqM+whkl8n+XDR
         r4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:importance
         :date:in-reply-to:message-id:user-agent:mime-version;
        bh=1hmqP38/XjyS7Rkqo6e3PZn4Gy/7WVfqD9R6VbrHu8g=;
        b=jWrP5LgPrzPJps5fu6vMVvhdtZzrwZMnSvntGC4TX1SgeObP86mxcKlUkJr1Ymelta
         6x33kZBhnhpgWg5zEeTgusFC7hNMW717XwnoZkwuLrbrPkZwpi9zufTfBgSTiWxBJIRo
         oYeBKXFnngeMCd+cPvPyoZ6Bs9O9ZJ0yAV363VaAskPUh/HKxWzLvzowCZn8ioU74ixb
         doCVz0MDwk6cQ5/hPMEfz/C0XewL7Ym46l6xFg6rXbbu/YtekEbX04MKiCIa/bZf1H5L
         JKy/LLMNB9IFn5adEckoBn8H9S2IhlQWv+wvQsixrcsfmEkEsBFJhG5WhYY3Ji1z0egk
         sebQ==
X-Gm-Message-State: ABuFfojtgvlszqibo66Ek9dZQpPCmDa2cFVCe4202iYnNDzMScOeL0Ip
        tMOjK6R10mhgu3QmGF9UmLk=
X-Google-Smtp-Source: ACcGV62JmgnZ8qMKaGId/P76eoyzfjoWWBEAuUgdYJB835LHm7KRxf9+skBtKJPYFwqGhuFuFW4jiw==
X-Received: by 2002:a1c:958d:: with SMTP id x135-v6mr493097wmd.46.1539057578661;
        Mon, 08 Oct 2018 20:59:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w2-v6sm1268921wre.57.2018.10.08.20.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 20:59:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/1] rebase -i: introduce the 'break' command
References: <pull.43.git.gitgitgadget@gmail.com>
        <b358178548bdc9134d4e4b83b1d0384ebb257a72.1538578818.git.gitgitgadget@gmail.com>
        <xmqq1s9424ig.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810051409220.2034@tvgsbejvaqbjf.bet>
Importance: high
Date:   Tue, 09 Oct 2018 12:59:37 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810051409220.2034@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 5 Oct 2018 17:36:55 +0200
        (DST)")
Message-ID: <xmqq1s8zsrbq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 5 Oct 2018, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>> 
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > The 'edit' command can be used to cherry-pick a commit and then
>> > immediately drop out of the interactive rebase, with exit code 0, to let
>> > the user amend the commit, or test it, or look around.
>>  ...
>> If one wants to emulate this with the versions of Git that are
>> currently deployed, would it be sufficient to insert "exec false"
>> instead of "break"?
>
> There is one crucial difference: the exit code.

OK, and it was good that you explicitly said "with exit code 0" in
the log message.  Together with the idea to update the doc I floated
earlier, this probably is worth documenting, too.

>> I think the earlier request asked for 'pause' (I didn't dig the list
>> archive very carefully, though),
>
> No need to: I mentioned it in the cover letter. Here is the link again,
> for your convenience:
> https://public-inbox.org/git/20180118183618.39853-3-sbeller@google.com/

No, you misunderstood.  I knew what message in the immediate past
triggered this patch and that wasn't what I "could have dug for but
didn't".  "The earlier request" I meant was another one I recall
that was made long time ago---that was what I "could have dug for
but didn't".

> Good initial version. I would like it to be a bit more precise about who
> exits with what status. How about this:

Sounds good.  It is likely that I'll either forget or will continue
to be too busy to pick textual pieces and assemble together myself,
so I'll leave it as a left over bit for somebody reading from the
sideline to send in a finished version if they care deeply enough
;-)

Thanks.

