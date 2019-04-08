Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E189220248
	for <e@80x24.org>; Mon,  8 Apr 2019 11:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDHLz6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 07:55:58 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:45584 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfDHLzj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:39 -0400
Received: by mail-qk1-f174.google.com with SMTP id z76so7687650qkb.12
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Sp7JaUGGWijVEXx4IMK5ye9BFrKGEl4+cVH88BwlF8=;
        b=LgpBlmegc+BNy2v1cf1VynE7rBxoZ9wk29gbE09tLXS6P6TK98Tcw10peavViFFYB7
         DxCTEJAdch65d98Qit4xqwhYP3AbovrfKcpIxnMheuy9teIeAMjCUf9RSCtPX2/uocuq
         GUy0n2zT7HGsVJ7Ow4XW11Sys6mKcE5GuuIBxSJ0fLXOOV11GddhoftTNMRdIVwIpeIi
         CxTQ8KuMffZxRlhhFl0ot/0DR9opMgmHXN8hnlRU0s9H8yowhnKUmP+MJxQ1qK0SUB93
         68nLgniiADi14cYSbxCz2T6/qaRli0eU09uSlLiUWU5GcHaUL4bBt0AlirZZ3fCLoKzE
         flfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Sp7JaUGGWijVEXx4IMK5ye9BFrKGEl4+cVH88BwlF8=;
        b=SkHJifsXwLlgTJiRGlX42nYheqJ6wRZxSju9b1AOULc84qM7XHSVfMtDH06jsfMM++
         QJaXmGhfiljorVLNSzgDtgI/uwZq9YCgzyn+iuLE1Rv2Epju3+ocHCHfzR4LqLkqSqkG
         46w9b6cig+ZT1kNjJzCoTkqzs99DSgQdkuF+ZY7VUzQUMefz2c8CdeKHH7tEJQlAM4NU
         xVzVN9Xoq3mLIrJg+5zq/KsDpiUCoH6ggXCJuJM5I/GnUjDcm5Vj5L/F9ShtrEDES+t7
         fRmBqMkWZMgR0fcmIiHZhdu6MtIIZ4Y4JU1lcHEuKlUDBV/zJPOKYTZCOKxNgNiME4lD
         meFw==
X-Gm-Message-State: APjAAAUaxCSnIuNXskvxxKvJB85BBJNJI5puYAH+0ZwBcWj8HCcQ5JcA
        o5jUT50C/fo8gA+oQdFn8+VOx9kQH4t1k36OETk=
X-Google-Smtp-Source: APXvYqwV2MVYI+McpoiqOdVaqmeTYjN+v+tcMx3pavsQPMc9rd4M11r/pF+hFPnmLRoGtrmbjJdKr0MuMoDBytMkrDE=
X-Received: by 2002:ae9:f50c:: with SMTP id o12mr22196835qkg.298.1554724537794;
 Mon, 08 Apr 2019 04:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
 <8636mvng8n.fsf@gmail.com> <xmqq36mt9e7l.fsf@gitster-ct.c.googlers.com>
 <CAA01CsqAt8osKArhdgATNj29+a9VO6wUwhX6=cRebnDBFx_EVg@mail.gmail.com> <86y34kn4c8.fsf@gmail.com>
In-Reply-To: <86y34kn4c8.fsf@gmail.com>
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Mon, 8 Apr 2019 13:55:25 +0200
Message-ID: <CAA01CspJAPnBFsQsXP4Dpweeg6oBVj==TB0aEnK5o1Et5zS30Q@mail.gmail.com>
Subject: Re: "commit --author=..." does not work if global email and name is
 not set
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 8, 2019 at 1:06 PM Jakub Narebski <jnareb@gmail.com> wrote:
>
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
> >> On Sat, Apr 6, 2019 at 8:25 PM Jakub Narebski <jnareb@gmail.com> wrote:
> >>>
> >>> Better though is to focus on what you want, namely to prevent accidental
> >>> commits without specified author, instead of how you want to achieve it,
> >>> i.e. using --author to provide both author and committer identity (the
> >>> XY problem).  On that machine with "automatic test account" set up
> >>> pre-commit or commit-msg hook that fails if the GIT_AUTHOR_IDENT
> >>> environment variable is not the "automatic test account".
> >
> > I'm not sure if I follow you. I want to be able to make both "real
> > user" and "automatic test account user" commits from that machine. I
> > want to make sure that:
> > - automatic commits (scripts) use their own account
> > - real person making commit uses their own account
> >
> > IMO the only way this can be achieved is by not having any default
> > account setup, so that both the scripts and the real users need to
> > specify it "by hand".
>
> If a real person making commits uses their own account (just on that
> machine), he or she can set up `user.name` and `user.email` settings in
> the per-user Git configuration file

There is one common "test" (Windows) account which is used both by
automatic test scripts and by real people who log into that machine,
so this is not possible.


> If however one is doing commits from the "automatic test user" account,
> then the `pre-commit` or `commit-msg` hook configured for that specific
> repository for that automatic account would be run, which can detect
> that the commit was not done with
>
>   $ git commit --author="My Name <me@my.email.com>"
>
> The additional advantage is that you can examine committer data to
> detect such cases of committing out of automatic account.

Do you mean following?

1. set default user (user.name, user.email) to "automatic test user"
on that machine
2. set commit hook to prevent commits with "automatic test user" AUTHOR
3. scripts will set AUTHOR (--author) to for example "script X" or
"automatic script user" - different than the default user
4. real users will set AUTHOR to their own identity (--author=me)

I suppose that would work. Looks much more complicated than simply
setting "--author" (or "--user") though...


-- 
Piotr Krukowiecki
