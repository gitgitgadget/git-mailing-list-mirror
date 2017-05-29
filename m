Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D801FD09
	for <e@80x24.org>; Mon, 29 May 2017 02:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdE2CJj (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 22:09:39 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35039 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdE2CJh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 22:09:37 -0400
Received: by mail-pg0-f46.google.com with SMTP id 8so15976457pgc.2
        for <git@vger.kernel.org>; Sun, 28 May 2017 19:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nWbVdh6v8Vy85VWRFSujPgKTbQqknzqKVuixVItgMTw=;
        b=q4aGaAjcPqK5zJJ0RMpbBn1Avsiq8NwtKcjfj9fVel4uz35DVvngtmby5b81ik+79G
         sy4ErUDGQsBeJYkQHxNc2Cg3glg6/JqU8OEKkse16eCW8RV8FRZolgb4l3MgKo9CkBTU
         ViSU4xoBHoOjZTRAAOFbMB/c/AWd24hioUAfrMbWqG0V+Gil1/X1E5nA3kT7oE8rTlhh
         pYqxcGI1anqvrZjoxXfv+wet3tyUOL5ey82K4l8iAe9HDA0qZjGXDJ+hhl08OTFyd82M
         HSEP9y02/ilsIPXcTIsT6vWHVYhKep0S6DD63Z80WXbg3djCImb1ulCihdfgxbBvPZy4
         o2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nWbVdh6v8Vy85VWRFSujPgKTbQqknzqKVuixVItgMTw=;
        b=iATpCy0lILRU9SZoQ8Fvz55If610e98AhzuMWyZQBOlcrS90MVBMlqQxf9bPFyuuJK
         EMki/o/G9pqf/Tdw2DUTCr9p8BNnmFRvh+P3txSlb5Ofg8NJKkUWxLzk4vXgDaZbbA21
         9CJ/DmN/jIeyqAcKKd5EOINeECAzD7W+QeQA1GBNw/erI/IQyAalfoWKWTZX0riOtLZA
         8HD/cFUpwcKa7Ie46QIrZtYJuvUJ6SjZn/8rR3ZtPehdobffVpCaQx8lf8x05YF78KCg
         5rsFiRKYtVG/Ly1W6bEUDXHCwnwrdiKCJBofDAYcnzuiLWZKHEUtK1vCwIBHRwv0t3Hl
         GHig==
X-Gm-Message-State: AODbwcArogJ04rmnJ6ABejWIBbEpfhKvW7M/BIn41G8XuIwjS0eW+g/6
        r4sltaYyPsTEqA==
X-Received: by 10.98.194.66 with SMTP id l63mr15145036pfg.234.1496023776851;
        Sun, 28 May 2017 19:09:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id o20sm12579084pfa.96.2017.05.28.19.09.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 19:09:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] branch: add tests for new copy branch feature
References: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
Date:   Mon, 29 May 2017 11:09:33 +0900
In-Reply-To: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
        (Sahil Dua's message of "Sun, 28 May 2017 22:56:52 +0000")
Message-ID: <xmqqr2z88lcy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

> New feature - copying a branch along with its config section.

That's an unusual non-sentence (without a verb) in our commit message.

> Aim is to have an option -c for copying a branch just like -m option for
> renaming a branch.

What should it copy literally, and what should it copy with
adjustment (and adjusting what), and what should it refrain from
copying?  

For example, when you create a branch topic-2 by copying from a
branch topic-1, do you copy the reflog in such a way that topic-2's
reflog contains all the entries of topic-1 before the copy happens,
capped with a new (and not shared with topic-1) entry that says
"Copied from topic-1"?  When topic-1 is set to pull from a custom
upstream 'upstream' (i.e. not "origin")'s 'trunk' branch, by setting
'branch.topic-2.remote' to "upstream", i.e. the same as the value of
'branch.topic-1.remote' and 'branch.topic-2.merge' to "trunk",
i.e. the same as 'branch.topic-1.merge'?  Should a "git push" while
topic-2 is checked out push to the same remote as a "git push" would
push to when topic-1 is checked out?  Should they update the same
branch at the remote?  Why and/or why not? [*1*]

> This commit adds a few basic tests for getting any suggestions/feedback
> about expected behavior for this new feature.

Writing tests is a good way to prepare for an implementation, which
must be done according to the design, but that happens after the
design is polished and judged to be a good one.  While soliciting
comments on the design from others, tests are a bit too low level to
express what you are aiming at.  It is a bit unhelpful to those who
may want to help to figure out answers to questions like the ones in
the previos paragraph (the one that begins with "For example,...")
by telling them to "read my intention from these tests", and when
you want as wide an input as possible, that is counterproductive for
your objective ;-).

> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
> ---
>  t/t3200-branch.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index fe62e7c775da..2c95ed6ebf3c 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -341,6 +341,59 @@ test_expect_success 'config information was renamed, too' '
>  	test_must_fail git config branch.s/s/dummy
>  '
>  
> +test_expect_success 'git branch -c dumps usage' '
> +	test_expect_code 128 git branch -c 2>err &&
> +	test_i18ngrep "branch name required" err
> +'

OK.  Do we want to support a single-name format (i.e. copy from the
current)?

> +git config branch.d.dummy Hello

Write your tests to do as little outside test_expct_success block as
possible, and do a set-up close to where it matters.

> +test_expect_success 'git branch -c d e should work' '
> +	git branch -l d &&
> +	git reflog exists refs/heads/d &&
> +	git branch -c d e &&
> +	git reflog exists refs/heads/d &&
> +	git reflog exists refs/heads/e
> +'

A reasonable design of "copy" is for d's log to be left intact, and
e's log to begin with a single entry "created by copying from d".
Another possible design is to copy the log (making them identical),
and then add one entry to e's log "created by copying from d".

The above test would succeed with either implementation and does not
answer "should reflog be copied?" (see above about why "here are the
tests that shows my thinking--read them and comment" is a bad
approach).

"move" that makes the source of the movement disappear after the
operation has a stronger justification of moving the log under the
new name (the only alternative is to lose the history of the source
forever), it is debatable if "copy" wants to retain a copy of the
history of an otherwise unrelated branch, which has its own history
retained after the operation.

> +
> +test_expect_success 'config information was copied, too' '
> +	test $(git config branch.e.dummy) = Hello &&
> +	test $(git config branch.d.dummy) = Hello
> +'

The expectation is that a configuration like 'dummy' that does not
have any meaning to Git itself will all blindly be copied, which is
similar to what "move" does.

> +git config branch.f/f.dummy Hello
> +
> +test_expect_success 'git branch -c f/f g/g should work' '
> +	git branch -l f/f &&
> +	git reflog exists refs/heads/f/f &&
> +	git branch -c f/f g/g &&
> +	git reflog exists refs/heads/f/f &&
> +	git reflog exists refs/heads/g/g
> +'

Hmph.  What's the reason to expect this not to work?

> +test_expect_success 'config information was copied, too' '
> +	test $(git config branch.f/f.dummy) = Hello &&
> +	test $(git config branch.g/g.dummy) = Hello
> +'

Isn't this part of the "should work" test above?  The definition of
working is not just reflog is created for the new branch without the
old branch losing its reflog, right?

> +test_expect_success 'git branch -c m2 m2 should work' '
> +	git branch -l m2 &&
> +	git reflog exists refs/heads/m2 &&
> +	git branch -c m2 m2 &&
> +	git reflog exists refs/heads/m2
> +'

Is it OK for the configuration be lost silently?

Thanks.


[Footnote]

*1* One way to avoid having to design an elaborate "definition of
    copying" from scratch is to piggy-back on whatever "move" does.
    Your definition of "copy" could be "copying from A to create B,
    followed by deleting A, should leave the identical result as
    moving A to create B".  And ask people if they agree with that
    definition as "the first principle".

    All the questions in the paragraph that begins with "For
    example..." and similar ones can be answered by followingthe
    first principle.


