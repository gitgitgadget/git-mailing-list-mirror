Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C7E1FD6A
	for <e@80x24.org>; Thu,  9 Feb 2017 00:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbdBIALV (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 19:11:21 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35100 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbdBIALU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 19:11:20 -0500
Received: by mail-qt0-f193.google.com with SMTP id s58so25482477qtc.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 16:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xDl9eUbqdQpzxT0HBEvCVyLqa3FoMSiIXflsHEppqs0=;
        b=YZdR7ZVoAanlUlSl7iEgGyzzyHtoLK84QJxQKwU9nSJQlGN4zmLHdnzODZAbGfVAh4
         lBV4ib9BtUhTgoxuBd17YheyS3p/z/gAxbob4kGWU4y0Wvzg6BgmPLkd2HVcKQCIBxET
         HKmGF52kTHdKY8eyRMgztC7++I+Ctvq25093+3elLeBJRDqoXXQZRBZmrimDtfEfNmBk
         7hX9kCz9IU7RBfiNGPK89KkBn1a5d0dgIa+KqQxh6fnybtPnDcDOdhMJeP9MhsJYSdeT
         4JiNjPpEQz733UoW9Ym6eyqZpBqf6KLpUGbPsAQoWEuB+lrw4avrBytSwYBCxP7hftxH
         S0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xDl9eUbqdQpzxT0HBEvCVyLqa3FoMSiIXflsHEppqs0=;
        b=kZDiQkyxOqb70R+EG0YxHn55+bjjQN/JJXFsXxMXoY13FYIH3JEjKWO4ksEqFomWpM
         G2PPbECAKtXb/rLzX3MdT8e1fVc04On83gewUzGd5cK5187+7tovyRjms39RZ9O7T20E
         6CBMezTwAqfSQPNRmDIiMqTZ50x6KFrD0RIITUv6DYqh59U7vUsLfDd9Lb/PRBCC1RKU
         5vfNfKoCwarzigLBkPBsUKE5Irb3467oniR5aGtU3CD3C2yctdK69Xtra8KuCgJffvq2
         My3RIcMqjkfajVwVbsdDyFKfLzUx8DJSRo4MhPoQRxqFatZOWxQk0shngWewSTuisN83
         xSfg==
X-Gm-Message-State: AMke39nN+uB4+6ffvkoZy1JamkWvmE9Qm+z0iLP9iUz5oe3dFRykWx2t3lXhi69cGEXjtJclvfOTYNVD4yu3Fw==
X-Received: by 10.237.36.166 with SMTP id t35mr20434332qtc.172.1486574625894;
 Wed, 08 Feb 2017 09:23:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.106.138 with HTTP; Wed, 8 Feb 2017 09:23:05 -0800 (PST)
In-Reply-To: <vpqh944eof7.fsf@anie.imag.fr>
References: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
 <xmqqtw882n08.fsf@gitster.mtv.corp.google.com> <20170206181026.GA4010@ubuntu-512mb-blr1-01.localdomain>
 <xmqqtw86zzk4.fsf@gitster.mtv.corp.google.com> <20170207191450.GA5569@ubuntu-512mb-blr1-01.localdomain>
 <vpqh944eof7.fsf@anie.imag.fr>
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
Date:   Wed, 8 Feb 2017 22:53:05 +0530
Message-ID: <CAN-3QhoZN_wYvqbVdU_c1h4vUOaT5FOBFL7k+FemNpqkxjWDDA@mail.gmail.com>
Subject: Re: [PATCH/RFC] WIP: log: allow "-" as a short-hand for "previous branch"
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Jeff King <peff@peff.net>, pclouds@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Matthieu,

On 8 February 2017 at 20:10, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> In a previous discussion, I made an analogy with "cd -" (which is the
> source of inspiration of this shorthand AFAIK): "-" did not magically
> become "the last visited directory" for all Unix commands, just for
> "cd". And in this case, I'm happy with it. For example, I never need
> "mkdir -", and I'm happy I can't "rm -fr -" by mistake.
>
> So, it's debatable whether it's a good thing to have all commands
> support "-". For example, forcing users to explicitly type "git branch
> -d @{1}" and not providing them with a shortcut might be a good thing.

builtin/branch.c does not call setup_revisions and remains unaffected
by this patch :)

In my original patch post, I was not explicit about what files call
setup_revisions.
I would like to rectify that with this (grep-ed) list:

* builtin/blame.c
* builtin/diff.c
* builtin/diff-files.c
* builtin/diff-index.c
* builtin/diff-tree.c
* builtin/log.c
* builtin/rev-list.c
* builtin/shortlog.c
* builtin/fast-export.c
* builtin/fmt-merge-msg.c
builtin/add.c
builtin/checkout.c
builtin/commit.c
builtin/merge.c
builtin/pack-objects.c
builtin/revert.c

* marked commands only show information, and don't change anything.

As you might notice, in this list, most commands are not of the `rm` variety,
i.e. something that would delete stuff.

In the next version of this patch, I will definitely include the list
of commands
which are "rm-ish" and affected by this patch.

>
> I don't have strong opinion on this: I tend to favor consistency and
> supporting "-" everywhere goes in this direction, but I think the
> downsides should be considered too. A large part of the exercice here is
> to write a good commit message!

Yes, I prefer consistency very much as well! Having "-" mean the same thing
across a lot of commands is better than having that shorthand only in a few
commands, as it is now. Unless there is a specific confusion that might arise
because of this shorthand inclusion, I think that this shorthand
should be supported
across the board.
(I especially like typing `git checkout - <filename>` which is very handy!)

>
> Another issue with this is: - is also a common way to say "use stdin
> instead of a file", so before enabling - for "previous branch", we need
> to make sure it does not introduce any ambiguity. Git does not seem to
> use "- for stdin" much (most commands able to read from stdin have an
> explicit --stdin option for that), a quick grep in the docs shows only
> "git blame --contents -" which is OK because a revision wouldn't make
> sense here anyway.

Yes, just to jog your memory, this was discussed here [1]

Junio said:

    As long as the addition is carefully prepared so that we know it
    will not conflict (or be confused by users) with possible other uses
    of "-", I do not think we would mind "git branch -D -" and other
    commands to learn "-" as a synonym for @{-1}.

>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Thanks a lot for the review on this patch, Matthieu!

-- 

Best Regards,

- Siddharth.

[1]: https://public-inbox.org/git/7vmwpitb6k.fsf@alter.siamese.dyndns.org/
