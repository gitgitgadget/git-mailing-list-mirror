Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4061F576
	for <e@80x24.org>; Mon, 22 Jan 2018 01:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbeAVBou (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 20:44:50 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:45722 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeAVBot (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 20:44:49 -0500
Received: by mail-it0-f48.google.com with SMTP id x42so8167945ita.4
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 17:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hlhs5QfpgAT66p9CjGa7lPAAgaajx0Pn1IsjzAa9+LI=;
        b=Tl1AI9XhsXSTbYVjhRjvRwxZusznqJpfnsOvHQVgFdknbNrqjdESLTJRjoQ8BkubKo
         /Catf+26n1GzwSigja2GdcbSx9mYT4mvwkDbiXqICv17/U/HL8wUziWkL0lG6Gd7g+bH
         XhBa97hg/o92hqc/ci3Qwqd51Z6XhUPyQJ4MHQxr2moRIP7HVSQCKUw/2RBRoLAhQhxC
         AJvkUNZQbvvZSb3eSQaWrVRXL4Q2I1xecnxHUztpFlo7Lx6HI4cVAeiB/K729V/kR7M+
         4UugC1YGQHQr91KdXe9hcyV0zUGQh6d9QUweJmTwnOIUO+OWZKsCaX5O0WzTUZHk5jCf
         z31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hlhs5QfpgAT66p9CjGa7lPAAgaajx0Pn1IsjzAa9+LI=;
        b=InxsWb1TgFa+DFrGQ2DqcxkM5JyiZExJzyLg+IcNbh4G0x8FIoR0yApjU/HwQmqg1S
         ttdx9kIVqHQskts9Aat06dj78Dfhn4OAvALlRsLbvqASgCvKy3IG0hXcWxm0jkw2k1AD
         dYYxNABd1T3HRw3275inJPVQFk2o2Ks7LuF1BApAPA8T5WFFDv+Xbz3U62UYQPQUnNi2
         EZy57jpn3033kiMUhhxhn4G56z84KF6Y7bggDmMS1I4eebh4wCtL9UTzy8uIj8CH99mo
         IkOSWKKsPqJLM2X6BH/Ob39ORG2kp91Lf+fMVhw+egHdRlE2FMIAZ59t73BJed3xNAMa
         F6SA==
X-Gm-Message-State: AKwxytfB1NdFCeXNA2I+CCSjTaDvtRGvbsjJznqOQHgHydwnG/w1oL8t
        L/nezES8+IWqAF4Xtkbasv0UNR7TTjQSUKqFXfc=
X-Google-Smtp-Source: AH8x225yASRyfM71mpZZGuBG8YQE25gG4shkXaPjbKdEXWTNYy1jPPWH0Wh9Phdmeoe39cWLrzEJgpPUWOpvNKDuvOQ=
X-Received: by 10.36.225.197 with SMTP id n188mr6930209ith.9.1516585489122;
 Sun, 21 Jan 2018 17:44:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.134.103 with HTTP; Sun, 21 Jan 2018 17:44:28 -0800 (PST)
In-Reply-To: <0A3A0675F3984789908D19A7A39235D5@PhilipOakley>
References: <CAJzZBAQuOqwRmBLOdUEVMY74_xT2dWe3a+9qT9ufc4bp8gjgig@mail.gmail.com>
 <0A3A0675F3984789908D19A7A39235D5@PhilipOakley>
From:   John Cheng <johnlicheng@gmail.com>
Date:   Sun, 21 Jan 2018 17:44:28 -0800
Message-ID: <CAJzZBARW3Cm_uF24NZOXdoT3dC0t=Uh3GCxa34_B6uK=tJ+dsQ@mail.gmail.com>
Subject: Re: cygwin git and golang: how @{u} is handled
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Thanks for pointing me to the github issue. I've added my comments to
it. For my particular issue, it was resolved by setting
"CYGWIN=noglob" as an environment variable. Hopefully it resolves
Robert's problem as well.



On Sun, Jan 21, 2018 at 3:43 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "John Cheng" <johnlicheng@gmail.com>
>
>> I am experiencing a strange behavior and I'm not certain if it is a
>> problem with golang or the cygwin version of git.
>>
>> Steps to reproduce:
>> Use golang's os/exec library to execute
>> exec.Command(os.Args[1],"log","@{u}") // where os.Args[1] is either
>> cygwin git or Windows git
>>
>> Expected result:
>> commit 09357db3a29909c3498143b0d06989e00f5e2442
>> Author: John Cheng <johnlicheng@gmail.com>
>> Date:   Sun Jan 14 10:57:01 2018 -0800
>> ...
>>
>> Actual result:
>> Suppose that cygwin git is specified, the result becomes:
>> exit status 128 fatal: ambiguous argument '@u': unknown revision or
>> path not in the working tree.
>>
>> Version:
>> git version 2.15.1.windows.2
>> git version 2.15.1
>>
>> I'm not certain if this is a git problem, as I could not reproduce
>> this problem using python to script cygwin git.
>>
>> A list of scenarios I've tested are
>> 1. golang + cygwin git = "exit code 128"
>> 2. golang + windows git = "exit code 0"
>> 3. python + cygwin git = "exit code 0"
>> 4. python + windows git = "exit code 0"
>>
>> I've tried to write a simple program to echo the command line
>> parameters passed by go into the process it executes - and it appears
>> that go itself does not change "@{u}" into "@u". I'm a bit stuck at
>> point to figure out which may be the cause: golang or git. I figured
>> I'd start here.
>>
> There is a similar problem a user is experiencing on Git-for-Windows, that
> we/the user haven't got to the bottom of, but it appears to have a similar
> form where the braces appear to be is some form parsed twice (though thats
> still a guess / hypothesis).
>
> "Aliases in git are stripping curly-brackets (#1220)"
> https://github.com/git-for-windows/git/issues/1220#issuecomment-340341336
>
>
>
> Philip
>



-- 
---
John L Cheng
