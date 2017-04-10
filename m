Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,WEIRD_QUOTING shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A07E620970
	for <e@80x24.org>; Mon, 10 Apr 2017 11:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbdDJLNh (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 07:13:37 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36448 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbdDJLNg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 07:13:36 -0400
Received: by mail-io0-f173.google.com with SMTP id l7so90544820ioe.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GetF5Si/8O72C2qjr2cKbkFik/Ldw7gwOMbTPJzBlK8=;
        b=CfLQ2iBe0w94t4NcPg+JujIKxrQVChZmHtt4L7LSKB41hMo4PY2zWjGkPBPwl7bwkc
         f8x3h9x50PDHt4jVzLbn+jeXzMwBjtguBxQO2NXYnhtmeqAdmOgIa++5TQfda28JMllT
         M9QntcPFEzt07ooLIliSyik2+1ezjjmlNirLnQe4RzjUmoj2x7Pr6F20h4SzDhD7wdud
         9+UzZAHfQKv/IkFHCxLyJzwY97VFSclBU49kN+PPXX/aKBCP/k16QTZ3FZBXNk/JOcum
         7vWH1TXFsetDTj5FsO5ncA1HG5Kh4//WQgmgnIwpE7S4V8urA3NPjeaplbM+BU+sCyXB
         hH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GetF5Si/8O72C2qjr2cKbkFik/Ldw7gwOMbTPJzBlK8=;
        b=rk0DiR+04ZYAazYUnaGTQJ4Um0Bh/Kdu6Ff8AYhhZNWGiQh3PLvQNbRVsTKTkFnG6l
         fvP//j/QUcw38NrAtMVpeJSJHOr9SVW62eEP3AQWzSrA+JLQ5l/u5D0XF3hPfqB+a0sF
         +SkIaYgYm4anczssuhU/Cx+LzHofEv/uqqc82emv+hoNG/94YH9FhbZPBoqHfQD6gnUI
         HTfb0d/zcAE524I0F5UCocHfCX4/wBFVABryWXAAsdnqp34xbeRAKlo3e9ELgU/0MfM+
         HLD0ep/9tJMf0JwNThxPVDTbITdfyvQ/3jAd9yxTZqLSGi0n9uwdSmjuAwea7TAAwk8L
         BA0w==
X-Gm-Message-State: AN3rC/79FIbt4x8bk666uCSmnOA3bEnaaOHXGGo5sjLw6fs33E6/WrkW
        +K30PR3AYruBl2LBHTEUp6u80LcHiQ==
X-Received: by 10.36.173.91 with SMTP id a27mr11924656itj.60.1491822816069;
 Mon, 10 Apr 2017 04:13:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 10 Apr 2017 04:13:15 -0700 (PDT)
In-Reply-To: <20170409130126.uqmjop25jidhblhd@ruderich.org>
References: <20170409130126.uqmjop25jidhblhd@ruderich.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 10 Apr 2017 13:13:15 +0200
Message-ID: <CACBZZX4uBL99y=ZaKZ7dqyP9Ne-cx=kYkh8p51p3VYOr3PQGSw@mail.gmail.com>
Subject: Re: Unexpected working directory in post-receive hook in non-bare repository
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 9, 2017 at 3:01 PM, Simon Ruderich <simon@ruderich.org> wrote:
> The following snippet reproduces the issue for me (note the
> remote: line in its output):
>
>     git --version
>
>     rm -rf a b
>
>     git init a
>     cd a
>     echo first >data
>     git add data
>     git commit -m initial
>     cat >>.git/hooks/post-receive <<EOF
>     #!/bin/sh
>     pwd
>     EOF
>     chmod +x .git/hooks/post-receive
>     cd ..
>
>     git clone a b
>     cd b
>     echo second >>data
>     git add data
>     git commit -m test
>     git push origin master:not-master
>
> According to man githooks "Before Git invokes a hook, it changes
> its working directory to either the root of the working tree in a
> non-bare repository, [...]". In this case "a" is non-bare and I
> expected the command to be run in the working tree; but instead
> it's run inside .git. (This caused some confusion in my case
> because I ran "git merge" in the hook which put files in the .git
> directory and I didn't notice it at first. I know running merge
> in receive-hooks is "bad practice" but it works fine in my
> setup.)
>
> The same happens for all hooks executed by git-receive-pack:
> pre-receive, update, post-receive, post-update.
>
> Is this a documentation issue or unexpected behavior?

It's a documentation issue I think. I added this change to the
githooks manpage last year in 49fa52fd00, but didn't think about the
case of pushing into non-bare repositories. The behavior itself hasn't
changed in a long time.

I wonder how to phrase this so that it's unambiguous & simply states a
general rule. I.e. instead of:

""""
Before Git invokes a hook, it changes its working directory to either
the root of the working tree in a non-bare repository, or to the
$GIT_DIR in a bare repository.
"""

Can we say as we do now that:

* All hooks regardless of type in bare repos execute in the bare repo
* If you have a working tree hooks use that

But add:

* Working trees are ignored by any hooks invoked on your behalf during a push.

Some ad-hoc testing reveals that this rule also goes for the
push-to-checkout hook. Should it? Wouldn't it be more useful if it
broke the pattern, since it's dealing with the working tree on the
other side? Junio?
