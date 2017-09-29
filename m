Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4357920281
	for <e@80x24.org>; Fri, 29 Sep 2017 18:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbdI2Sa4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 14:30:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34394 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbdI2Saz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 14:30:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id i131so306734wma.1
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=y6adlqEPpAkaqWJNZwSBnELG3xT0yAlssiVYgZMztQA=;
        b=TNr8S8hXQx7YJgLW2jNy/DBwAa0PesHYLsmjlepmQhvqP1fwqNvn2uU3WU6n2zWmbP
         Q63Awa6TzxkXa48tUSxoNHjHocUo9OSqi0KxzyyC0OgaTIAwVMijkeJ3B615DaVU3ctp
         owQx9lh2mmI5GRSf+cBKX1YsraP6pRRCbLbIbODDQS+h034MqIy4PksADtlfz+oDHZQb
         MxbK/2mSoSE6Q1X+shnOCeJfIP/oBydjDWwKieE2wIZzmRw1zpPsGNP1uvmRRS6VEtuS
         Rsl/XN8CX8WKzz4DEh9lSesORjAhrO6g5cMTL5FyPJLlro7kyqA9Id48Rrhizdaw/jUC
         Hp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=y6adlqEPpAkaqWJNZwSBnELG3xT0yAlssiVYgZMztQA=;
        b=td3oeGfE5I0u2JWT0RWDUhNp1sKU7clvDP4UJaN77v78liScYyP9zENsYcB7u059GJ
         NJZDlZyK0PjZRyQ5HWN2uRO7nKKvLUin0/CTrdZihBkCErrS8MyAHoGzWg5up+IT6bNw
         DxDeKDOw+wIZ+U9hgLYRmR33jJmibN0apIuIhzLYjIicxPlEVj8Yv8f1aJDPrwh5cX7P
         J9pApdlkFEe8GNYh+aSN8t1buCZiLljJprbVLqrPsvUPkVHaa8yt1QZhUuJV4RUkOakT
         ZkObi9HU4FatMg0gZ10k1OYqtAc6v8R7FcR0HkBSauY9lHwqFlM4ebFsmoqStQ5ek44p
         hygQ==
X-Gm-Message-State: AHPjjUjUkXu3fJ3vB2VDwPKgcjxBXpb3OF8SFy2Bf9HSQIohJgxg/5Uf
        KMJCf4g4l9QaqJZvMfUvSbo=
X-Google-Smtp-Source: AOwi7QBxIqFa2eL9XJnW0K38bpBXVKBjduX8wyP/FYd7pmfYIPi6tyubAwKiwxneQ1qROAx9EpxArQ==
X-Received: by 10.80.184.69 with SMTP id k5mr10642589ede.59.1506709854374;
        Fri, 29 Sep 2017 11:30:54 -0700 (PDT)
Received: from evledraar (dhcp-077-250-131-208.chello.nl. [77.250.131.208])
        by smtp.gmail.com with ESMTPSA id o6sm4136112edb.10.2017.09.29.11.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Sep 2017 11:30:52 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1dy03o-0004Co-3i; Fri, 29 Sep 2017 20:30:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 4/3] branch: fix "copy" to never touch HEAD
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com> <20170705231454.15666-1-avarab@gmail.com> <xmqq60f6h03t.fsf@gitster.mtv.corp.google.com> <xmqqvakbjpo5.fsf_-_@gitster.mtv.corp.google.com> <874lrpw34z.fsf@evledraar.booking.com> <xmqqvak47val.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.1 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqvak47val.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 29 Sep 2017 20:30:52 +0200
Message-ID: <873775tl0j.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 27 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> I do think however that we also need to update the docs, the relevant
>> origin/master...gitster/sd/branch-copy diff is currently:
>>
>>     +The `-c` and `-C` options have the exact same semantics as `-m` and
>>     +`-M`, except instead of the branch being renamed it along with its
>>     +config and reflog will be copied to a new name.
>>
>> Suggestions welcome, but I think that should probably be changed to
>> something like the following as part of this patch:
>>
>>     The `-c` and `-C` options have the exact same semantics as `-m` and
>>     `-M`, except instead of the branch being renamed it along with its
>>     config and reflog will be copied to a new name. Furthermore, unlike
>>     its `-m` and `-M` cousins the `-c` and `-C` options will never move
>>     the HEAD, whereas the move option will do so if the source branch is
>>     the currently checked-out branch.
>
> I do not think anybody even _imagines_ copy to move HEAD, and do not
> think "unlike -m, it doesn't touch HEAD" a worthwhile thing to say.
>
> It is '-m' whose behaviour may look strange wrt HEAD, so _that_ may
> be worth mentioning, though.
>
> I suspect that your reaction probably comes from being too married
> to the idea that HEAD has a string that is the same as the refname
> of the current branch.  But that is a mere implementation detail.
> Users would think that HEAD points at the current branch and does
> not even care how that pointing is implemented.

To cut to the chase instead of pointlessly replying to this
point-by-point, I think your patch quoted below is good and solves the
minor doc issue I had with your patch.

Yes HEAD is an implementation detail, but it's an exposed implementation
detail.

Thus before your patch it was true to say that "[-c] has the exact same
semantics as [-m] [...] except [ s/move/rename/ ]" since that was the
only behavior change, but with your patch adding another "if (!copy &&
...)" we'd now have two things different in the code, but only one thing
enumerated as being different in the docs.

Just rephrasing it as you did is a better way out of that than my
proposed patch. Thanks.

> Conceptually, you can consider that each branch has its own
> identity, separate from various traits it has, like what its
> upstream branch is, what commit it points at, what its reflog says,
> and (most notably) what its name is.
>
> Then you can think of "branch -m old new" to be (1) finding the
> instance of branch that currently has name 'old' and (2) updating
> only one of its trait, namely, its name, without changing anything
> else.  Creating a new instance of a branch by copying an existing
> one, on the other hand, would then be the matter of (1) finding the
> instance of branch with name 'old' and (2) creating another instance
> of branch with the same traits as the original, modulo its name is
> set to 'new'.
>
> A necessary wrinkle for "branch -m" that falls out of the above
> world model is that HEAD needs to be adjusted in order to keep
> pointing at the same (renamed) instance of branch that now has an
> updated name, if HEAD happened to be pointing at the instance of the
> branch whose name trait has been updated.
>
> So, from that point of view, I'd prefer to do something like the
> attached patch instead.  I notice that "branch -m" does not mention
> configuration variables carried over to the new branch, but I do not
> necessarily think we want to exhaustively enumerate what traits are
> carried over here, so perhaps it is OK as is.
>
>  Documentation/git-branch.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index fe029ac6fc..d425e3acd4 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -63,11 +63,13 @@ With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
>  If <oldbranch> had a corresponding reflog, it is renamed to match
>  <newbranch>, and a reflog entry is created to remember the branch
>  renaming. If <newbranch> exists, -M must be used to force the rename
> -to happen.
> +to happen.  If you rename a branch that is currently checked out,
> +`HEAD` is adjusted so that the branch (whose name is now
> +<newbranch>) stays to be the current branch.
>
> -The `-c` and `-C` options have the exact same semantics as `-m` and
> -`-M`, except instead of the branch being renamed it along with its
> -config and reflog will be copied to a new name.
> +With a `-c` or`-C` option, a new branch <newbranch> is created by
> +copying the traits like the reflog contents and `branch.*.*`
> +configuration from an existing <oldbranch>.
>
>  With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
>  specify more than one branch for deletion.  If the branch currently
