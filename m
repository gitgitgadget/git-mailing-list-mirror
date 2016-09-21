Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637F01F935
	for <e@80x24.org>; Wed, 21 Sep 2016 23:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756550AbcIUXXQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 19:23:16 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38609 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755025AbcIUXXO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 19:23:14 -0400
Received: by mail-wm0-f54.google.com with SMTP id l132so117749987wmf.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sqd/LaKoXh7JGO73kicPmYKruYPXXEmRtZaJpu2AUis=;
        b=KQR6vic9Juuc4RXxKOZ21NluGs1IlqupgZ0sqORS5NqISdMMuMUevDvPDIJDihZQv6
         cEi4KzeJlXxRwgoP2aW7+zFJbxRliJzYKJ3AwNsEVkpNsewGyrLOAT3qB/XYcywzVqR+
         uvsqbizZEF+mXJcnR1k/xZ+4RANp+wCwLqEVM88cou9J2+fMc7XG7DeY71Msztln24R9
         WFR5XOJkL5cDZWVzFrOSYdgI7cMUn1Toq6FRA5na6kSPChvSOf9/zN1bWAAmIMx+gTsk
         dLXZPr3qII9j83GdbZK7dQrYMpgJ+oamYe6EVp6oKk8nlnKXCquJ8UpUUNbXgzZNcfpO
         NJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sqd/LaKoXh7JGO73kicPmYKruYPXXEmRtZaJpu2AUis=;
        b=dcGpC0mERff/fVkh+BeJ/wGw/gIj1Cmv7ojpy24JYXJkYF9nykHzWY5Qtw3IofNBoT
         TGtznwCrq/RXpK2EElpnwsI0EQnW+Xl4oMpkYMnEOhnp2WLg4O0t8/et8OVv/5BcBMf2
         5Z0D7uSvnXMDe+GdG9ccxvPiNHgKMOHRKahsKJAn9oRBie57QcrrTIMUh+FSZn8hgu8f
         UkYNRbDiAwmW7gz/9x+LSiG20KsrhUckOzSmacSJkMnbriBeRPMKQ2FxizwWXU+Yp6Ru
         PPdm0aSsmqH6Hj4D4dqiugYipDa+VzwcajrQwF+GuOO9BpjUohIBQg1LiVhpuOwkbXfW
         /DzQ==
X-Gm-Message-State: AE9vXwOvbmS97W1HaAjEUnRX5VXVvgP/hhqrgAfXJbXe5klumfI967RkUko4L+no2bmR+0Sc0s6Mz0PPx5hzY5SB
X-Received: by 10.194.164.102 with SMTP id yp6mr35096180wjb.50.1474500193243;
 Wed, 21 Sep 2016 16:23:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Wed, 21 Sep 2016 16:23:12 -0700 (PDT)
In-Reply-To: <xmqqtwd86f0q.fsf@gitster.mtv.corp.google.com>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <1474495472-94190-2-git-send-email-bmwill@google.com> <xmqqtwd86f0q.fsf@gitster.mtv.corp.google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Wed, 21 Sep 2016 16:23:12 -0700
Message-ID: <CAKoko1oacXxrSMZBvfM9X6iGDq+KcUUZnUrD2qD3X8+ze8vUXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ls-files: add pathspec matching for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Sounds sensible.  Just a minor nit in terminology, but I think we
> fairly consistently say "a superproject contains submodules" (run
> "git grep -E 'super *(module|project)'").
>
> I'd suggest s/super module/superproject/ for consistency.

Will do.

> An example of this test would be to match pathspec "sub/file" with
> submodule path "sub"?

Yep,  I believe there's a test for that case

> item->match[namelen] is accessed without checking if item->match[]
> is long enough here; shouldn't item->len be checked before doing
> that?

Oh right!  Good catch.

>
> Hmph, isn't this the one that is allowed produce false positive but
> cannot afford to give any false negative?  It feels a bit strange
> that the code checks two cases where we can positively say that it
> is worth descending into, and falling through would give "no this
> will never match".  That sounds like invitation for false negatives.
>
> IOW, I would have expected
>
>         if (flags & DO_MATCH_SUBMODULE) {
>                 if (may match in this case)
>                         return MATCHED_RECURSIVE;
>                 if (may match in this other case)
>                         return MATCHED_RECURSIVE;
>                 ...
>                 if (obviously cannot match in this case)
>                         return 0;
>                 if (obviously cannot match in this other case)
>                         return 0;
>                 /* otherwise we cannot say */
>                 return MATCHED_RECURSIVELY;
>         }
>
> as the general code structure.
>
> Fully spelled out,
>
>         if (flags & DO_MATCH_SUBMODULE) {
>                 /* Check if the name is a literal prefix of the pathspec */
>                 if (namelen < item->len &&
>                     item->match[namelen] == '/' &&
>                     !ps_strncmp(item, match, name, namelen))
>                         return MATCHED_RECURSIVE;
>
>                 /* Does the literal leading part have chance of matching? */
>                 if (item->nowildcard_len < item->len &&
>                     namelen <= item->nowildcard_len &&
>                     ps_strncmp(item, match, name, namelen))
>                         return 0; /* no way "su?/file" can match "sib" */
>
>                 /* Otherwise we cannot say */
>                 return MATCHED_RECURSIVELY;
>         }
>
> or something like that.  There may be other "obviously cannot match"
> cases we may want to add further.
>
> Thanks.

You're right it should be structured the other way.
