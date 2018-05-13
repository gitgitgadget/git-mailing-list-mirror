Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67FA1F42D
	for <e@80x24.org>; Sun, 13 May 2018 06:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeEMGuk (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 02:50:40 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36051 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbeEMGuj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 02:50:39 -0400
Received: by mail-oi0-f65.google.com with SMTP id v2-v6so8085022oif.3
        for <git@vger.kernel.org>; Sat, 12 May 2018 23:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pxR1pH+iUCKWFaRAgu0kfRx670akJIe0cvwDlwS6DRs=;
        b=lfdxYr3sQ2bLWDxRvKZZZz4QdLCShvq+Njr+n1qLsx+QW5hpTNXyrJ3t6zK/zRR9k4
         VccwwK3LK6aeL7konlA2Q6IQueOl3AxQRVHFwCx2xlI2vKRYX7v0AdRHUbz1OILZGqOj
         J5JBh99cqO7tg+ificy6auF4xl8xFtK5oQQxJs7a0feFhiKglr84H+b3sktiEvsalIMV
         roh/KyKaomnarEinU5kwbKdvVzpLKAKwKeM8il1QrIlWU8kDwKxiBrSRbtzcjEvroj2d
         b8us/3UrINDQ+JWyAz7W4QsQoFup74v8OS+xvAG0EgwCZn7sHXU7UZPqWORttRkzVHG5
         WQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pxR1pH+iUCKWFaRAgu0kfRx670akJIe0cvwDlwS6DRs=;
        b=LRNcrhkcHSL6zSHlZZuG7BXuc16I4mXUQPS3pF8uJqWOpJXo1HnNdNQq8EVsBj8v/I
         KW0eODb2akVQSIofVDNKqspxReCZKnuScxbhf8OjWEjjjOZ546M5D1qtx3Nx+Uc9RLd5
         md2jT1LqIWuZOL3tB4OjZqKBZizGZ5gO1qY4Jedh/ENhuXi1nrUzq6YrxOaGm3PRVYuJ
         tdNmv2tfXQ+/2cx8j9a6NmUK3ZJ+25Mjx7Ey82L276RSJlBYplzBE7TSiEXMGvbV8iRo
         nwalHvi3SZve1vHsebsWClKUiG/EpG9yoYuBinjVw2fFOLsmxtjx+Pdhg20kF+0X8zQZ
         EEug==
X-Gm-Message-State: ALKqPwdYur+1DCPZiSmci4YLJIaDMTlPFR2Xf0mm88LGcmnxqzoHhaeH
        mKHkQb5FiyHeNPDR9sekeQOOJPLcsuhvnz1YG97I2Q==
X-Google-Smtp-Source: AB8JxZog2pWa9yxf2lIMXGcPK9YPL4P+D0xHsT3QcHp7QzfIgJJuOM/WH8ZWaFyFSe4WBb0hKgPmwHEGzWfZi0n7Zs0=
X-Received: by 2002:aca:2813:: with SMTP id 19-v6mr3685335oix.281.1526194239379;
 Sat, 12 May 2018 23:50:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sat, 12 May 2018 23:50:08 -0700 (PDT)
In-Reply-To: <CAM0VKjmL=OfKcveHRW+eAzvwS2o8TjcOS-uRNzD1JuKY2DYfFw@mail.gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com> <20180510084652.25880-1-pclouds@gmail.com>
 <20180510084652.25880-13-pclouds@gmail.com> <CAM0VKjmL=OfKcveHRW+eAzvwS2o8TjcOS-uRNzD1JuKY2DYfFw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 13 May 2018 08:50:08 +0200
Message-ID: <CACsJy8D+xes0+Lqyh+QEmTBuGm47nbbKQdcBRiCx-p5s7SoXnQ@mail.gmail.com>
Subject: Re: [PATCH v7 12/13] completion: let git provide the completable
 command list
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 5:05 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Thu, May 10, 2018 at 10:46 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy
> <pclouds@gmail.com> wrote:
>> Instead of maintaining a separate list of command classification,
>> which often could go out of date, let's centralize the information
>> back in git.
>>
>> While the function in git-completion.bash implies "list porcelain
>> commands", that's not exactly what it does. It gets all commands (aka
>> --list-cmds=3Dmain,others) then exclude certain non-porcelain ones. We
>> could almost recreate this list two lists list-mainporcelain and
>> others. The non-porcelain-but-included-anyway is added by the third
>> category list-complete.
>>
>> list-complete does not recreate exactly the command list before this
>> patch though. The following commands are not part of neither
>> list-mainporcelain nor list-complete and as a result no longer
>> completes:
>>
>> - annotate             obsolete, discouraged to use
>> - difftool-helper      not an end user command
>> - filter-branch        not often used
>> - get-tar-commit-id    not often used
>> - imap-send            not often used
>> - interpreter-trailers not for interactive use
>> - lost-found           obsolete
>> - p4                   too short and probably not often used (*)
>> - peek-remote          deprecated
>> - svn                  same category as p4 (*)
>> - tar-tree             obsolete
>> - verify-commit        not often used
>
> 'git name-rev' is plumbing as well.

So? name-rev remains completable like before and is not mentioned in
the above list. Am I missing something?

> I think this commit should be split into two:
>
>   - first do the unequivocally beneficial thing and get rid of the
>     long, hard-coded command list in __git_list_porcelain_commands(),
>     while keeping its output unchanged,
>
>   - then do the arguable thing and change the list of commands.

I will. Though the first commit still changes the output slightly
because there are three commands not in command-list.txt. To keep the
output unchanged, I would need to add them back in command-list.txt
first (and find the right group for them) only to remove those lines
later (two of them deprecated, the other does not even have a man
page). It's not worth the effort.

>>  {
>>         local i IFS=3D" "$'\n'
>> -       for i in $(__git_commands)
>> +       for i in $(__git_commands $1)
>>         do
>>                 case $i in
>>                 *--*)             : helper pattern;;
>
> Is this loop to exclude helper commands with doubledash in their name
> still necessary?

It is needed for __git_list_all_commands() because that one still
essentially grabs "git help -a", which includes command--helpers.
--=20
Duy
