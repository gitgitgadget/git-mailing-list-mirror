Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 763DF1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 19:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbdAZTUQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 14:20:16 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35079 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753009AbdAZTUO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 14:20:14 -0500
Received: by mail-lf0-f44.google.com with SMTP id n124so150439520lfd.2
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 11:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cBeQLwCj4IUC7bnBw/JxXwvqci3/e1XrP+Amuxw6upk=;
        b=qZAsGfwqaSXOXCXG+skJHhai0ebzOIi6+p8hPOGrFnImDi5fhvLMkxKWFp3RkDeVfA
         3CH6wFsgOzvvG9V29I/CpVdeZ9cqBupYATG4JKM19RmZbefUwyNEFr6HeTLL9V+zpJBY
         fvFBH84ltb0zF7Zg2n3HF7nAY8XsmfnOlk4QtdZkVze7YlB2oajCa0Hyh/rF6PWHVqQg
         9BJtWScz3q5HgLNpzWCfv+1n0BubzoUjLChGdWZ0jP/ovOhUKtXN+tqSJz+oow4saQx7
         n/p14mlqa/quhBcvZL301sBqlCEr/DDCgBVpKqROGmSRIgB3AsSNlAhiekdlwdZwCEI1
         XKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cBeQLwCj4IUC7bnBw/JxXwvqci3/e1XrP+Amuxw6upk=;
        b=EpaXxSiMnL/wuyGgS0rIwZIj3QNYT+/Qdx+To3cDUlWvXpi+OmCSnZhycf/wqvbScM
         sgB3D+EKmlUR0gFqGbOnipqpl5rV3UZcm1B8+305oB1bINvj/kyzoNIOiuJpYc6PNeT+
         b3/LQzwPCUhth0qKNqiyTHI9dobCBC7OV3E2Hi0FNHeVR1cxwAB4LQIyphKMFO/t3lgI
         JSDEmThP4C+UJWOxUfJ21erAFcsA0ASb8gPEd/J9ZqaXkalK9NzKSSRehZcckLfOc84I
         HomXD+4Hc2xciNf28LQ1JLvi9BRlwoopkwIF4hBbtTv0tJhzy6Bfrx383Rc7Xsi2OEk5
         GIfQ==
X-Gm-Message-State: AIkVDXK63/wnJxddcnpsGD/q8sT42nV3+Gbxk6piCdZU8QQEQKoCatBQxu9yHJWlgmBgNpStptJVz473Cd5uOw==
X-Received: by 10.25.21.96 with SMTP id l93mr1484652lfi.136.1485458412303;
 Thu, 26 Jan 2017 11:20:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.20.193 with HTTP; Thu, 26 Jan 2017 11:19:51 -0800 (PST)
In-Reply-To: <xmqqd1fa7dqf.fsf@gitster.mtv.corp.google.com>
References: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
 <CA+P7+xrupLuYAj7tn_1EaUiN6eaCmtgX-_d4mnByDq95cuqiWQ@mail.gmail.com>
 <CAE1pOi3eh7ao3NocV=PRFDby8y5ttjFR=-_VB0FoJv4MpjExaA@mail.gmail.com>
 <CA+P7+xo9WBwHjAXeUTn4bh=F6hvw1gA-79h-GmwQoeRpeLj2jQ@mail.gmail.com>
 <xmqqh94m7leb.fsf@gitster.mtv.corp.google.com> <CAE1pOi0CgfxQTygg_i3dc_-_Lb8qgOOk_0hg+goJvm7PyLZseg@mail.gmail.com>
 <CA+P7+xocc==-8ad-OVTahMDABA0-spDPEw05JTHopfO7Ovj2RQ@mail.gmail.com> <xmqqd1fa7dqf.fsf@gitster.mtv.corp.google.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Thu, 26 Jan 2017 11:19:51 -0800
Message-ID: <CAE1pOi0foJpZXSpHrbWqvOuG1+VoNKTCMjuLK5TCVcJuGMSOoQ@mail.gmail.com>
Subject: Re: Force Confirmation for Dropping Changed Lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 January 2017 at 18:32, Junio C Hamano <gitster@pobox.com> wrote:
> I think you should be able to do something like
>
>         $ cat >$HOME/bin/fail-3way <<\EOF
>         #!/bin/sh
>         git merge-file "$@"
>         exit 1
>         EOF
>         $ chmod +x $HOME/bin/fail-3way
>         $ cat >>$HOME/.gitconfig <<\EOF
>         [merge "fail"]
>                 name = always fail 3-way merge
>                 driver = $HOME/bin/fail-3way %A %O %B
>                 recursive = text
>         EOF
>         $ echo pom.xml merge=fail >>.gitattributes
>
> to define a custom merge driver whose name is "fail", that runs the
> fail-3way program, which runs the bog standard 3-way merge we use
> (so that it will do the best-effort textual merge) but always return
> with a non-zero status to signal that the result is conflicting and
> needs manual resolution.

Thank you, that's an improvement. :-) Unfortunately, it still
completes the merge. Is there any way to simply get the
>>>>>>>>/<<<<<<<< markers?
