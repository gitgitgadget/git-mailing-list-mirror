Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F67020A40
	for <e@80x24.org>; Mon, 27 Nov 2017 01:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbdK0Byr (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 20:54:47 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:39363 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbdK0Byq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 20:54:46 -0500
Received: by mail-qk0-f173.google.com with SMTP id w125so30581973qkb.6
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 17:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ML7Whjeb+m0TRGe1A04zszASSUnE93wtODmMcN2ZamE=;
        b=MXfS5NQcB7kpoKA5n2qg5W1+P8mMwOTHPMPrvCekgPPk4201Bgue7RevisELO3nnRV
         MsO+tocTnKJGBa1AIrQrUNsRvdQJexDC5fiZU+Xjt8YuzTY8Gggd7bYpsQJ32RaRz4fs
         vKg1xMLQ6oN42n0TZQfe3sKhvfVxCgSu17u03MzRvEhL+DhJKDVSKr8rtR8WP0TI4SQ1
         juJS5cvrAazs2eZGzzAXgpPT0h07D8VSDSOMGTlWMqxbr2/cLrwCIPb3Ff2p80cH7KYI
         3zH4+VZC6RM0otiOQWpnrjJHhBoZVCylpPdCHMDl4i9uAmOsK3XlFTOvNe7M5p6wh2En
         slMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ML7Whjeb+m0TRGe1A04zszASSUnE93wtODmMcN2ZamE=;
        b=BR+M58MxIDo85kVWXcwUM8ptQi43jvk1DhmOKIS8F1xIl69MHIhPYEu4Wj/dd2AdPD
         6axognCfrA2NGtrgBZk+m+zommcVrEtWQ7Cy2JMjSAZYo6cOW+AlwmkU1I7C/kXh/LT0
         JSDTTVVrQ6uMjXzhBP2WGmLLMK1WH0Klx6K577rOae1PJ71fpf2u9Wjn6CdaZPZbMBhi
         HP9LPBS8S/rH01vCOUhSQBEWfIlud3wsUPJwZQHTLujnaoIkZeseVlPxOuDRnS1s/8uG
         iPCBbhsmp6rKxird0RpoLHWCYxKKAy9DrarSfz3SV5RVFqXPpL1jRKeRhAdDY8CVnfkD
         XGkg==
X-Gm-Message-State: AJaThX4Snrebeds09/pptVlnfn1JtRKnFeabu3iirwKW2VTQwZrKUTXm
        mn0Qu0BXQziEBKOLA9lT0blh2/gG802weNTU3zU=
X-Google-Smtp-Source: AGs4zMarplYS8rw7APO+qGIE1cVpXRaSfm+DNvmjkn/ZRSpCohRXEC0lwUHp35CHbkKLybAisGvUK8YC1NQVCO/j4qM=
X-Received: by 10.55.48.69 with SMTP id w66mr28558409qkw.123.1511747685794;
 Sun, 26 Nov 2017 17:54:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.209.220 with HTTP; Sun, 26 Nov 2017 17:54:25 -0800 (PST)
In-Reply-To: <xmqqtvxgfrlp.fsf@gitster.mtv.corp.google.com>
References: <CAEDDsWdXQ1+UukvbfRoTPzY3Y9sOaxQ7nh+qL_Mcuy3=XKKh7w@mail.gmail.com>
 <xmqqtvxgfrlp.fsf@gitster.mtv.corp.google.com>
From:   Michael Sloan <mgsloan@gmail.com>
Date:   Sun, 26 Nov 2017 17:54:25 -0800
Message-ID: <CAEDDsWeLYGXn_ZeCAxGJjOUzfm_FZjZYWu9f=dAOAfe-2LcCZQ@mail.gmail.com>
Subject: Re: Problem with environment of hook execution when git is run with
 --work-tree / --git-dir
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 26, 2017 at 5:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Sloan <mgsloan@gmail.com> writes:
>
>> So what's the problem with this choice of environment variables?
>> Well, the problem is that if PWD is changed during the execution of
>> the script, then GIT_WORK_TREE and GIT_DIR will no longer work
>> properly. For example, if the pre-commit hook is
>>
>>     #!/bin/sh
>>     cd some-dir
>>     git status
>>
>> This will fail with
>>
>>     Not a git repository: '.dotfiles-git'
>
> That is to be expected.  It's up to the script to make them absolute
> if it cannot cope with relative paths.
>
>> There is another detail here, which is that when --git-dir /
>> --work-tree is not specified, the no GIT_WORK_TREE / GIT_DIR
>> environment variable is set.  This means that in this case, changing
>> PWD in the hook will work fine as long as the search for .git will
>> find the right one.
>
> That also is working as designed.

Hmm, I do not think that this is good for the reliability of hooks.
It means that hooks written with the common case assumption (no
GIT_WORK_TREE / GIT_DIR set) will fail when run in these rarer
configurations.  I imagine that many authors of hooks are entirely
unaware of work-tree / git-dir options.  I know that I used git for
something like 8 years before encountering a use for them, or really
being aware.  Perhaps hooks authors are savvier than your average
user.

It seems to me like something similar to my suggested GIT_DIR_MAPPINGS
could be quite powerful for this circumstance as well as others.  I
guess a temporary hack would be to create a ".git" file that specifies
the git-dir, but this doesn't work if something is already called
".git".

I do not have a concrete example of this causing problems in practice,
I've just observed that it is a potential gotcha for --git-dir +
hooks.  I can understand keeping things simple even if it means making
it much harder for hooks authors to write correct code.  It seems
bothersome to me that git hooks have to be crafted so carefully to
support variations in environment.

If we could go back to when hooks were introduced and add a
"GIT_IN_HOOK=1" and have it require manual specification of
--work-tree and -git-dir, that might have been the best option.
However, doing that now would break everyone's hooks, so not really
practical.

Also, thanks for all your work on git, overall it is excellent software :)

-Michael
