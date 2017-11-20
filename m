Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E2C202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 23:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdKTX6T (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 18:58:19 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36796 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdKTX6S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 18:58:18 -0500
Received: by mail-it0-f66.google.com with SMTP id 187so11669986iti.1
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 15:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ruNqMLY6RTkCe0LPeBrRAH0PxDtRtDjTx0ILTKNUCbM=;
        b=FtkCtNohXwIwkGNy7VIMcoe8qduVkDEF+5EdH/5Sux8HJcTJMDP0AM5eMa72EAS4bO
         XlKXFH3M6VIPpiZDMGt1UVg+ZOgZ8FI+ypjFqdbodtmOeM8ha0ZQHtuPGNNo+kLRL1WD
         Zkl5FPXlUqg6k0DedN+ynFWBiMb44AiluY+CM9wN5kUSJFo5zUQHG95nSYYBXksEH0xJ
         8vqMHIG69QQKKeHq7xVZgv65ekkJf1Qv5TxSk49xUzEHZuy5zW6v2V/jNMnajPAlJlQh
         blHXyd/sb6r5t33CfUI2AdYTEcSsaC87r7qw0MgZjno94iieiNMpsrE0/igoc64k93qI
         96KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ruNqMLY6RTkCe0LPeBrRAH0PxDtRtDjTx0ILTKNUCbM=;
        b=jpemCrWrJN0QJepsr40EcEHp4zyATYLqoT7SoGbZuXRHXfcu/Xquo19x3RZKDepCeq
         14YpPPRvqeK+DSdLcv5I/iu86/W82pHNU6823InUfadsrG1CDxdbprDMlNA9f7iGBx+L
         E1v91MEv9CMhe1lmViPu80rCOWvm2nhEOhuzzXnf1gDBBUZm5mb9R7PGeOqmn/Sg0d/3
         /SbP3rHo/XrKxrNO1z1xb5JUj/K8pd/Igg34r4IcOFlBCi5BlrnXiXAH7fMO8LSx+pZN
         S/kRr+0+eHAU/FUGWXhzQ35ju05BPhJPGNUWeLRg5RAVUDOPkiPoVuTiB+Ovq1n0DrF7
         cxOQ==
X-Gm-Message-State: AJaThX7fOyPLqWuDUNiER9IQqncNUzdCvJasDhzfw60gujAQEf4bXYr5
        T8dtviw9UbRM0pgglQfV8PwbD39Nt13D4EYXWv0=
X-Google-Smtp-Source: AGs4zMbxImDq4/6FH249mK3GGvI8mjkI54E0Q7/7RXNBDMQdcpj0xtK0FJKBjqiKbLWukrcGVVTkZKGE4IUB8KGTHOg=
X-Received: by 10.36.0.209 with SMTP id 200mr21026581ita.55.1511222297715;
 Mon, 20 Nov 2017 15:58:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Mon, 20 Nov 2017 15:58:17 -0800 (PST)
In-Reply-To: <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
References: <20171120171517.6365-1-chriscool@tuxfamily.org> <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Nov 2017 00:58:17 +0100
Message-ID: <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Nov 20, 2017 at 8:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Christian Couder wrote:
>
>> By default running `make install` in the root directory of the
>> project will set TCLTK_PATH to `wish` and then go into the "git-gui"
>> and "gitk-git" sub-directories to build and install these 2
>> sub-projects.
>>
>> When Tcl/Tk is not installed, the above will succeed if gettext
>> is installed, as Tcl/Tk is only required as a substitute for msgfmt
>> when msgfmt is not installed. But then running the installed gitk
>> and git-gui will fail.
>
> Hm, I am not sure I understand the point of this change.  E.g.
> if I run "make install" for git and install tk later, wouldn't I
> want gitk to work?

Yeah, if you know how it all works and want to decide after installing
gitk and git-gui if you actually want to use them, then things are a
bit less straightforward with this patch, though you can still do what
you want by setting the BYPASS_TCLTK_CHECK variable.
But I doubt that many people who are actually building Git are in this case.

> Can you say more about where this comes up?

The original discussion is:

https://public-inbox.org/git/b6b12040-100f-5965-6dfd-344c84dddf96@teddy.ch/

and here are discussions related to version 1 of this patch:

https://public-inbox.org/git/20171115125200.17006-1-chriscool@tuxfamily.org/

As Peff mentions in the original discussion, at the Bloomberg Git
sprint, we saw someone struggling to compile Git, because of these
msgfmt and Tcl/Tk issues.

> gitk is a wrapper
> script
>
>         #!/bin/sh
>         # Tcl ignores the next line -*- tcl -*- \
>         exec wish "$0" -- "$@"
>
> Would some error handling there help?  E.g. something like
>
>         #!/bin/sh
>         # Tcl ignores the next line -*- tcl -*- \
>         exec wish "$0" -- "$@" || \
>         { echo >&2 "Cannot run gitk without tk"; exit 127; }

I think Peff already gave his opinion about this in the above discussions.

>> If neither Tcl/Tk nor gettext are installed, then processing po
>> files will fail in the git-gui directory. The error message when
>> this happens is very confusing to new comers as it is difficult
>> to understand that we tried to use Tcl/Tk as a substitute for
>> msgfmt, and that the solution is to either install gettext or
>> Tcl/Tk, or to set both NO_GETTEXT and NO_TCLTK.
>
> Hm, is this the motivating problem?  This is a condition where
> the rationale for failing the build seems clearer.

This is the issue as well as the above thread that prompted me to take
a look at this.

>> To improve the current behavior when Tcl/Tk is not installed,
>> let's just check that TCLTK_PATH points to something and error
>> out right away if this is not the case.
>
> At first glance I had thought this might set NO_TCLTK automatically,
> which I think would be problematic for the reasons mentioned above.
>
> Erroring out like this patch does and asking the user to explicitly
> confirm that they want to install gitk without Tcl/Tk is less
> problematic,

Yeah that is also my opinion.

> so I am not *against* this patch, just interested in more
> background.

Thanks for taking a look at this,
Christian.
