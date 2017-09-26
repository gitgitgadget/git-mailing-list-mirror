Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E4D20281
	for <e@80x24.org>; Tue, 26 Sep 2017 21:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032301AbdIZVjr (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 17:39:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35671 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032298AbdIZVjp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 17:39:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id e64so10078045wmi.2
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=puuBiAOWa7AFBD3hsTNEk66dRPAXlOM1OUzh1EqiE0g=;
        b=GVwrp5u03KCcTjfpO/lpL82oN98oAMnPED+0OqpISolqxTj868I0UniXvATNMkeyle
         ZFNyHnCv3Lqhqf5c41yfushROUzZTMJLbsEqHWYnmpj7D8ATyPTmUtgcrt8CceGrMZQh
         WBC/fgSQivzlX3rbxk3fDKn92gC3vrJZybT516PXAEE0PP5bWjWJxpnOy/lAPaJPZtf9
         u9Y120GVirBNc5yVnmg/uQCevsIK5jDmwSTgARQ/XmJW38ElFUWxU+hjk+lviKVz3yth
         7tj08teA46r4vBcjzXtsF4L4TYUFuFg1eZnZCPk0qgpV8tO1fzZ0Sg2xu7JSlsK+AQHC
         Xn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=puuBiAOWa7AFBD3hsTNEk66dRPAXlOM1OUzh1EqiE0g=;
        b=JXwUPj98R8G1GfOThaxhiVTokZUQET3B5v5QelZCIrPAGRLS5atJkvhHh4bsgPLraE
         lNDW45BFaUgYKGJSdv+JYi6q7RmXqWXzw5MKJ6soS7l0PKNXEViTw0ONBTA4USZ4vS9c
         A5SFdjTNfrnRWHwmzvdPBim2+Du8ErhaYgC+uThPonSktJ3XPqGaUsqWLrhyXnnRlz3Q
         v9KPj3eXerJWlI/0qaw2XYK5/0fK3RAoFhaAsaCJkl+kKhtRr5l8+aHrM1bQdPaknppr
         p22FMrK9rPKW5onnyg52HN1/irLgEB35BPOGIFXso5Wde6/0W+PHWnTALaXqngZhhtDF
         D7UA==
X-Gm-Message-State: AHPjjUhyAbDkQ0JzH0T9qiefKyjCPEZZ2K55ZARQkxbokaDAstIeDssj
        f3nRjjPDL0yv2q8IPuxSEcM=
X-Google-Smtp-Source: AOwi7QDIx18RvR7K5Fo6EmbrYWi4JvHIwezQKZUVvNqKSSHG9Za5psZKANZA7R0Ou8uc3n7HKDIkGw==
X-Received: by 10.80.224.79 with SMTP id g15mr18907657edl.259.1506461983964;
        Tue, 26 Sep 2017 14:39:43 -0700 (PDT)
Received: from evledraar (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id l50sm6479233eda.80.2017.09.26.14.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Sep 2017 14:39:42 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1dwxZs-0005aW-L0; Tue, 26 Sep 2017 23:39:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 4/3] branch: fix "copy" to never touch HEAD
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com> <20170705231454.15666-1-avarab@gmail.com> <xmqq60f6h03t.fsf@gitster.mtv.corp.google.com> <xmqqvakbjpo5.fsf_-_@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.1 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqvakbjpo5.fsf_-_@gitster.mtv.corp.google.com>
Date:   Tue, 26 Sep 2017 23:39:40 +0200
Message-ID: <874lrpw34z.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 22 2017, Junio C. Hamano jotted:

> When creating a new branch B by copying the branch A that happens to
> be the current branch, it also updates HEAD to point at the new
> branch.  It probably was made this way because "git branch -c A B"
> piggybacked its implementation on "git branch -m A B",
>
> This does not match the usual expectation.  If I were sitting on a
> blue chair, and somebody comes and repaints it to red, I would
> accept ending up sitting on a chair that is now red (I am also OK to
> stand, instead, as there no longer is my favourite blue chair).  But
> if somebody creates a new red chair, modelling it after the blue
> chair I am sitting on, I do not expect to be booted off of the blue
> chair and ending up on sitting on the new red one.
>
> Let's fix this before it hits 'next'.  Those who want to create a
> new branch and switch to it can do "git checkout B" after doing a
> "git branch -c B", and if that operation is so useful and deserves a
> short-hand way to do so, perhaps extend "git checkout -b B" to copy
> configurations while creating the new branch B.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Let's send an updated one as a follow-up to the discussion thread
>    that it is a follow-up to.  The patch in this message is the same
>    as the one I previously sent; the proposed log message has been
>    updated somewhat.
>
>  builtin/branch.c  |  9 +++------
>  t/t3200-branch.sh | 10 +++++-----
>  2 files changed, 8 insertions(+), 11 deletions(-)

This mostly looks good to me.

I've already spent several screenfuls here on-list arguing for not
applying the equivalent of this patch, which I won't repeat here.

But just a brief comment: I think this doing this is good, and it's
something I agree with given that the consensus is going this way. I
thought "do what -m does" was less confusing, but since everyone (you,
Brad, even Sahil) seems to disagree I'm happy to be shown to be wrong &
to have this go in so thoroughly reviewed & thought about.

I do think however that we also need to update the docs, the relevant
origin/master...gitster/sd/branch-copy diff is currently:

    +The `-c` and `-C` options have the exact same semantics as `-m` and
    +`-M`, except instead of the branch being renamed it along with its
    +config and reflog will be copied to a new name.

Suggestions welcome, but I think that should probably be changed to
something like the following as part of this patch:

    The `-c` and `-C` options have the exact same semantics as `-m` and
    `-M`, except instead of the branch being renamed it along with its
    config and reflog will be copied to a new name. Furthermore, unlike
    its `-m` and `-M` cousins the `-c` and `-C` options will never move
    the HEAD, whereas the move option will do so if the source branch is
    the currently checked-out branch.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 89f64f4123..e2e3692838 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -506,12 +506,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  				oldref.buf + 11);
>  	}
>
> -	if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf)) {
> -		if (copy)
> -			die(_("Branch copied to %s, but HEAD is not updated!"), newname);
> -		else
> -			die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
> -	}
> +	if (!copy &&
> +	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
> +		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
>
>  	strbuf_release(&logmsg);
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 5d03ad16f6..be9b3784c6 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -422,7 +422,7 @@ test_expect_success 'git branch --copy is a synonym for -c' '
>  	test_cmp expect actual
>  '
>
> -test_expect_success 'git branch -c ee ef should copy and checkout branch ef' '
> +test_expect_success 'git branch -c ee ef should copy to create branch ef' '
>  	git checkout -b ee &&
>  	git reflog exists refs/heads/ee &&
>  	git config branch.ee.dummy Hello &&
> @@ -431,7 +431,7 @@ test_expect_success 'git branch -c ee ef should copy and checkout branch ef' '
>  	git reflog exists refs/heads/ef &&
>  	test $(git config branch.ee.dummy) = Hello &&
>  	test $(git config branch.ef.dummy) = Hello &&
> -	test $(git rev-parse --abbrev-ref HEAD) = ef
> +	test $(git rev-parse --abbrev-ref HEAD) = ee
>  '
>
>  test_expect_success 'git branch -c f/f g/g should work' '
> @@ -494,12 +494,12 @@ test_expect_success 'git branch -C c1 c2 should succeed when c1 is checked out'
>  	git checkout -b c1 &&
>  	git branch c2 &&
>  	git branch -C c1 c2 &&
> -	test $(git rev-parse --abbrev-ref HEAD) = c2
> +	test $(git rev-parse --abbrev-ref HEAD) = c1
>  '
>
> -test_expect_success 'git branch -C c1 c2 should add entries to .git/logs/HEAD' '
> +test_expect_success 'git branch -C c1 c2 should never touch HEAD' '
>  	msg="Branch: copied refs/heads/c1 to refs/heads/c2" &&
> -	grep "$msg$" .git/logs/HEAD
> +	! grep "$msg$" .git/logs/HEAD
>  '
>
>  test_expect_success 'git branch -C master should work when master is checked out' '
