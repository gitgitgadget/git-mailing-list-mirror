Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1463D1F51C
	for <e@80x24.org>; Sun, 27 May 2018 11:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936390AbeE0LAF (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 07:00:05 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46301 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936373AbeE0LAE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 07:00:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id v13-v6so4160714wrp.13
        for <git@vger.kernel.org>; Sun, 27 May 2018 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=j7AAMLxNvHOIrJCR3bz3zs7Q9J1FzzwtCMpTScI1lW4=;
        b=E6UCUjyhGXJ6XJjJrcMgGMgB1Jk5Z54pxrj7BQvVzwXlDxbPFUFX0TP+p1v2AC/MXY
         5nnkicMa/tuIOfu459pqSIaz4yGlQlwn2JGN8l4zZd0RPxxaD8xCwPYpDDrO5GSwdx9U
         1C+KjXVSAgy5TVE2NS8YGgXnX8Z5aaaH/bZIScWGsDhM/AosUnP9cMKJd1E6hu2wUke3
         WFTbhr7J3rbxtexcbIEX3wo6vYE9p7fFuk/sbKSZ8IlAziMMdFKE2SFdnNNQsDJYM9Ab
         c6y32O6C3QwBwOEa74xhEDaE8FPuE4bjSy5bzEXrXuaz6L6kuXXkFEhZq05OlZlvqisv
         jwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=j7AAMLxNvHOIrJCR3bz3zs7Q9J1FzzwtCMpTScI1lW4=;
        b=cUWDtGTttmxT9eqMDEZMHWrnqfaXVX5eXRFOHIFAtgG3ku8QyF7wu4t0jaC+qDNZ8p
         GU8DUK3cGW0AJHJwD9A2bzXELY+EH0VBo/PoyTsbEdNtZVCizR+Vh11QuZrAgDxKLd/e
         JO9krnplGhdtEdrvhTWO89EnaCHhLO6KfUO00aoThYyfd1BQvUUbAj7Mixf798mAd24K
         a9STwPymhYSz66Wik3EY1O4YY/cDjb6aqqv1Qp1lK1GwJ+p2pygoJGC/7lKvHbLuvxRz
         X2MRfhCWbLrFRBCWzgSXRnUaxTIBGWR3XNXY1V2ra245vNlrrBN6g/nyo9FvW5tQnixK
         VrxQ==
X-Gm-Message-State: ALKqPwelVtURf2RFlNcnSRyYriM8j0iQKlxG5EdxORPyxQx+QyIPjsgh
        iU3f2Wj2M0rFKT7aEibSZn1Z6NnRMTQnPWCy3Z+7JA==
X-Google-Smtp-Source: ADUXVKLSIrYqwmJ+P99xKvXMEosv85Yl5Bma7wRPPWBYS5qflMqwd8tB4CKt+Jf26fhV1HUZvgt5TZZx864ycdeIyTU=
X-Received: by 2002:a19:4355:: with SMTP id m21-v6mr3098669lfj.121.1527418803092;
 Sun, 27 May 2018 04:00:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d485:0:0:0:0:0 with HTTP; Sun, 27 May 2018 03:59:42
 -0700 (PDT)
In-Reply-To: <CAAUqJDu_3DTyd1cFKaNRKOzo3AHosfxP1jjWpa=HGtyAyitTeA@mail.gmail.com>
References: <CAAUqJDu_3DTyd1cFKaNRKOzo3AHosfxP1jjWpa=HGtyAyitTeA@mail.gmail.com>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date:   Sun, 27 May 2018 12:59:42 +0200
Message-ID: <CAAUqJDvsRBJWZh5_A2e2x-CqgXi5gLSjo6-P2sYxsKz3qfidSw@mail.gmail.com>
Subject: Re: git rebase -i --exec and changing directory
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bump? Has anyone had time to look at this?

Thanks,

Ondrej Mosnacek

2018-05-19 18:38 GMT+02:00 Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>:
> Hello,
>
> I am trying to run a script to edit multiple commits using 'git rebase
> -i --exec ...' and I ran into a strange behavior when I run 'cd'
> inside the --exec command and subsequently run a git command. For
> example, if the command is 'cd src && git status', then git status
> reports as if all files in the repository are deleted.
>
> Example command sequence to reproduce the problem:
>
>     # Setup:
>     touch a
>     mkdir dir
>     touch dir/x
>
>     git init .
>     git add --all
>     git commit -m commit1
>     git tag base
>     touch b
>     git add --all
>     git commit -m commit2
>
>     # Here we go:
>     git rebase -i --exec 'cd dir && git status' base
>
>     # Spawning a sub-shell doesn't help:
>     git rebase -i --exec '(cd dir && git status)' base
>
> Is this expected behavior or did I found a bug? Is there any
> workaround, other than cd'ing to the toplevel directory every time I
> want to run a git command when I am inside a subdirectory?
>
> $ git --version
> git version 2.17.0
>
> Thanks,
>
> Ondrej Mosnacek
