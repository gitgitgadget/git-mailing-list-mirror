Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210272021E
	for <e@80x24.org>; Thu,  3 Nov 2016 15:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757569AbcKCPwp (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 11:52:45 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33194 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754218AbcKCPwp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 11:52:45 -0400
Received: by mail-lf0-f42.google.com with SMTP id c13so42631584lfg.0
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uI5l1ov0o1QSM6asE6oGagih92oRZ6978nQl4zueq7A=;
        b=sF+NLmZC2Xrq9iyFgRlClsuAO1C5duXqb9ctTqaLgMrLXsfEoqPdeJJHFtcCbXnGCn
         eCjvbNc3Ln6G6mdtjg29i2+09MrmKrcRrxhDzBN4tgi68eaaB5XhyudEFgkS3rQq0boi
         xso7/uIDxpS6+s4c2I+GJN2qfDEo4J+lICiB9hi0/g1Adcqi4WcSW0cE2vaY/SAY0ec2
         S0t+eqR5U9842CBt0LVIngFZyC0WJMpL2LZltQKQGBL5nGDvAdbJEI9fgna3KxnG0CgN
         KlQVq0SGRSVBizxGoWqt7FwUC1mDmL2ULsi45HAa9SI2GRxsmruuEv3I2wW/u5P1BnN7
         hb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uI5l1ov0o1QSM6asE6oGagih92oRZ6978nQl4zueq7A=;
        b=GRekZWccNJD1dKu6XgMpcuiGIcaifIF5ZPZCfrSmWm1USaR4pHpPPHVRU/s4NzoZBb
         rT1MC4BcSmoxQPpR1w3PSNcweJ8fy5NkUQST0oGa3iv3vxlP2J+6RfH/FmbsiZdpH3Rg
         yzu2rqQnLnEBWpq9UseatUXAYQlI5Knbzvz3YyZU622U6CqVuKoUoPKCwHn5cepsMlQ9
         Om8tvZzBdI5HMceuPp8ZdS5iJy8uRIqEoooP2PbORuCMpS8jRX1+WUQ+Gp9Heq8jgUvR
         ueabkZ3jtpr2a80sbgpCCcpv8ZEqYhQ0bCioP6JCLCqHhExVh844Xcfw7fcMJWVkJQ7+
         Oqxg==
X-Gm-Message-State: ABUngvcwLVZTyGsYBayfE5l1Tc5qlVJPmC9ZxkIAjcu2qBBt81jPteMQo/aVAgF7eLDvvWDZLf3nfc6pJDHaaw==
X-Received: by 10.25.32.67 with SMTP id g64mr4897275lfg.180.1478188363057;
 Thu, 03 Nov 2016 08:52:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.215.102 with HTTP; Thu, 3 Nov 2016 08:52:42 -0700 (PDT)
In-Reply-To: <CAJUoZVbnWzpjzWe_qGZTnX_6N2+OJVG39WYaBgY7OfQBNCg+rg@mail.gmail.com>
References: <CAJUoZVYF=ZCBUX6jztwhJX3BZdq4JEfrSRbi4cFPwn+7yA=VjA@mail.gmail.com>
 <20161103151422.nhrgzivapy5tisr4@sigill.intra.peff.net> <CAJUoZVbnWzpjzWe_qGZTnX_6N2+OJVG39WYaBgY7OfQBNCg+rg@mail.gmail.com>
From:   Chris Purcell <chris.purcell.39@gmail.com>
Date:   Thu, 3 Nov 2016 15:52:42 +0000
Message-ID: <CAJUoZVaKFdwtPRi5PGodzxHp6_NOsR0P9ToRfQnuVMDLztPHgw@mail.gmail.com>
Subject: Re: Bug in git rev-parse @{push}?
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resending to mailing list because Inbox is fighting with vger...

On 3 November 2016 at 15:48, Chris Purcell <chris.purcell.39@gmail.com> wrote:
> Thanks, Jeff! If I remove the explicit configuration of remote.pushdefault =
> "origin", I get the same error message as you, so I suspect that's _not_ the
> default.
>
> On Thu, 3 Nov 2016 at 15:14 Jeff King <peff@peff.net> wrote:
>>
>> On Thu, Nov 03, 2016 at 02:53:44PM +0000, Chris Purcell wrote:
>>
>> > I think I have discovered a bug in rev-parse's handling of @{push}:
>> >
>> > $ git push
>> > Everything up-to-date
>> > $ git rev-parse @{push}
>> > fatal: cannot resolve 'simple' push to a single destination
>> >
>> > The documentation for rev-parse says that "the suffix @{push} reports
>> > the branch 'where we would push to' if git push were run while
>> > branchname was checked out", so I would not expect this to error
>> > unless git push does.
>>
>> I'm not too surprised if there's a bug there. IIRC, the way the code is
>> structured, some of the logic had to be reimplemented for @{push} rather
>> than re-used, so there may be corner cases where they do not agree.
>>
>> > The relevant parts of my configuration are:
>> >
>> > [push]
>> >     default = simple
>> > [remote]
>> >     pushdefault = origin
>> > [branch "foo"]
>> >     remote = origin
>> >     merge = refs/heads/develop
>> >
>> > The code in branch_get_push_1 (remote.c) in the PUSH_DEFAULT_SIMPLE
>> > case is calling both branch_get_upstream and tracking_for_push_dest
>> > and erroring if they don't return the same result, which I assume is
>> > incorrect for a triangular workflow?
>>
>> I assume you have branch "foo" checked out?
>>
>> With this config I don't see how "git push" would work. Because you're
>> using "simple", it should complain that "develop" and "foo" are not the
>> same name.
>>
>> Can you give a more full reproduction recipe? If I try:
>>
>>   git init tmp && cd tmp
>>   git config push.default simple
>>   git commit -m foo --allow-empty ;# just to have some commit to push
>>
>>   git init --bare dst.git
>>   git remote add origin dst.git
>>   git push origin master:refs/heads/develop
>>
>>   git checkout -b foo origin/develop
>>
>>   # pushdefault of "origin" is already the default. checkout will have
>>   # set up branch.foo.* as you specified. So let's try our push.
>>   git push
>>
>> Then I get:
>>
>>   fatal: The upstream branch of your current branch does not match
>>   the name of your current branch.  To push to the upstream branch
>>   on the remote, use
>>
>>       git push origin HEAD:develop
>>
>>   To push to the branch of the same name on the remote, use
>>
>>       git push origin foo
>>
>> which makes sense.
>>
>> If you _don't_ get that same message with "git push", then my next
>> question is: might you have any aliases or other systems like "hub" that
>> are munging the arguments to "git push"? Running with "GIT_TRACE=1" in
>> the environment might be enlightening there.
>>
>> > Please let me know if I've missed out important information by
>> > mistake. I'm happy to work on a patch if given guidance, but this is
>> > definitely outside my comfort zone for an unfamiliar codebase
>> > otherwise! e.g. I can't find the test suite.
>>
>> The tests are in the "t" directory; see t/README for details. You can
>> run them all with "make test" from the top-level directory.
>>
>> -Peff
