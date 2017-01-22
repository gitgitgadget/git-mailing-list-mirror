Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FDA920A17
	for <e@80x24.org>; Sun, 22 Jan 2017 13:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751039AbdAVNE5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 08:04:57 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34253 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdAVNE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 08:04:56 -0500
Received: by mail-qt0-f194.google.com with SMTP id a29so11327750qtb.1
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 05:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=349CziiMs/jDtWQ8zmemcJZdrtRwuMnLQxTUZLS5AkE=;
        b=UCgAwnnwuXBz0C7SpZK6GeiVImxWWOfypksagUdhmUGAo9WQ3h3IY73GMekLIp08w2
         kav72zmnEGbnoAjxTjESx+gwo4xYKz632TF92jAMdjAS58IYaN/D3Dpyoh9h5yiT/tQs
         Wm4rPBQGGLKZI/BzyUzZlplw6Qs0x2nMJxltM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=349CziiMs/jDtWQ8zmemcJZdrtRwuMnLQxTUZLS5AkE=;
        b=M0GYmhft4gkfkYMZZnGwpMESckZ/3jhzxyNPDgCpzAj3B1HuRtDio2Y6jt+xyW8ccz
         IoN6A2jdaOrReJ8rLXj0JftlD/MdGTlxkfOfvzibTRTDrhvhg2lOqErPh3/6vVMqUvsq
         oYgVd+KnNTw2bxY+JHI3ckt20xaULkFpj+UxwMDUrerdasDt9HbzjHrvDG5wjEpt/sls
         22ibXC1vT985PtaAvaRq7jsdTdXrh2LuzTPo1nqcW8x6bo8WDQa3TPtDk/B+lMdfogs5
         jabYQqncARjXvqCG+rm+YLM1d7mzIbfSn7bAgpcg0xdXMXLyjeY1ncdd1cQhCGQhsld/
         5B4A==
X-Gm-Message-State: AIkVDXLvje8RWIUiecxsbX0xfCJZcIwVIz2oSJUJoR/bEJLHFWViJ/CKoP2SADX52X5vNSxSwBNDaopAXHLBwA==
X-Received: by 10.237.63.119 with SMTP id q52mr19677983qtf.29.1485090295214;
 Sun, 22 Jan 2017 05:04:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.62.179 with HTTP; Sun, 22 Jan 2017 05:04:54 -0800 (PST)
In-Reply-To: <000f01d273fa$05358ee0$0fa0aca0$@vanburgh.me>
References: <01020159c0e82598-e373cf0d-2bad-41bb-b455-6896ad183e22-000000@eu-west-1.amazonses.com>
 <A7425283-9C32-4AE8-A442-11B7CFEAB4E8@gmail.com> <000f01d273fa$05358ee0$0fa0aca0$@vanburgh.me>
From:   Luke Diamand <luke@diamand.org>
Date:   Sun, 22 Jan 2017 13:04:54 +0000
Message-ID: <CAE5ih7_+Vc9oqKdjo8h2vgZPup4pto9wd=sBb=W6hCs4tuW2Jg@mail.gmail.com>
Subject: Re: [PATCH] git-p4: Fix git-p4.mapUser on Windows
To:     George Vanburgh <george@vanburgh.me>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm confused....see below.

On 21 January 2017 at 15:21, George Vanburgh <george@vanburgh.me> wrote:
>> On 21 Jan 2017, at 13:33, Lars Schneider <larsxschneider@gmail.com>
>> > On 21 Jan 2017, at 13:02, George Vanburgh <george@vanburgh.me>
>> wrote:
>> >
>> > From: George Vanburgh <gvanburgh@bloomberg.net>
>> >
>> > When running git-p4 on Windows, with multiple git-p4.mapUser entries
>> > in git config - no user mappings are applied to the generated
> repository.
>> >
>> > Reproduction Steps:
>> >
>> > 1. Add multiple git-p4.mapUser entries to git config on a Windows
>> >   machine
>> > 2. Attempt to clone a p4 repository
>> >
>> > None of the user mappings will be applied.
>> >
>> > This issue is caused by the fact that gitConfigList, uses
>> > split(os.linesep) to convert the output of git config --get-all into a
>> > list.
>> >
>> > On Windows, os.linesep is equal to '\r\n' - however git.exe returns
>> > configuration with a line seperator of '\n'. This leads to the list
>> > returned by gitConfigList containing only one element - which contains
>> > the full output of git config --get-all in string form. This causes
>> > problems for the code introduced to getUserMapFromPerforceServer in
>> > 10d08a1.
>> >
>> > This issue should be caught by the test introduced in 10d08a1, and
>> > would require running on Windows to reproduce. When running inside
>> > MinGW/Cygwin, however, os.linesep correctly returns '\n', and
>> > everything works as expected.
>>
>> This surprises me. I would expect `\r\n` in a MinGW env...
>> Nevertheless, I wouldn't have caught that as I don't run the git-p4 tests
> on
>> Windows...
>
> It appears I was mistaken - the successful tests I ran were actually under
> the Ubuntu subsystem for Windows, which (obviously) passed.
>
> Just did a quick experiment:
>
> Git Bash (MinGW):
> georg@TEMPEST MINGW64 ~
> $ python -c "import os
> print(repr(os.linesep))"
> '\r\n'
>
> Powershell:
> PS C:\Users\georg> python -c "import os
>>> print(repr(os.linesep))"
> '\r\n'
>
> Ubuntu subsystem for Windows:
> george@TEMPEST:~$ python -c "import os
> print(repr(os.linesep))"
> '\n'
>
> So this issue applies to git-p4 running under both PowerShell and MinGW.
>
>>
>>
>> > The simplest fix for this issue would be to convert the line split
>> > logic inside gitConfigList to use splitlines(), which splits on any
>> > standard line delimiter. However, this function was only introduced in
>> > Python 2.7, and would mean a bump in the minimum required version of
>> > Python required to run git-p4. The alternative fix, implemented here,
>> > is to use '\n' as a delimiter, which git.exe appears to output
>> > consistently on Windows anyway.

Have you tried a 2.6 Python with splitlines? I just tried this code
and it seems fine.

> val = s.strip().splitlines()
> print("splitlines:", val)

Tried with 2.7 and 2.6, and bot print out an array of strings returned
from read_pipe().

And 'grep -r splitlines' on the Python2.6 source has lots of hits.

>>
>> Well, that also means if we ever use splitlines() then your fix below
> would
>> brake the code, right?
>>
>> Python 2.7 was released 7 years ago in 2010.
>
> Now I feel old...

:-)

>
>> Therefore, I would vote to
>> bump the minimum version. But that's just my opinion :-)
>
> I feel like splitlines is the better/safer fix - but figured bumping the
> minimum
> Python version was probably part of a wider discussion. If it's something
> people
> are comfortable with - I'd be happy to rework the fix to use splitlines.
> Luke - do you have any thoughts on this?

I agree that we have to stop supporting 2.6 at some point (and start
supporting 3.x, but that's another world of hurt). But does 2.6 really
not have splitlines?

If you send a patch with splitlines I can try it out (although I guess
it could be broken under Windows).

Luke
