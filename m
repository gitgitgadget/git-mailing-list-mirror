Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 022511F424
	for <e@80x24.org>; Sat, 28 Apr 2018 00:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeD1AYp (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 20:24:45 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:44169 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeD1AYn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 20:24:43 -0400
Received: by mail-ua0-f182.google.com with SMTP id h15so2244382uan.11
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sLoCy/lKewo2mCwung1rnqIs8F5/BmbujOW+HJpCC/4=;
        b=fEf3dhzpC9om3NWQjq2+cY7Xl7YNOag6FbX7JagxBq/+8pGJ76kxneDcHuX1oNuGck
         buYFzJe9Zi/zdzo4nxBnP/Ua3ZIERNACp7mQhdekSSdESA0yEqZFo0Akf+T2q8b60cBB
         xSOBwhILcBRp27s3isxpZDdYdGK0JzUPjOl9wKCQ09zqqKkW7jroxqrf+BCFABvUYdi7
         QACIydjzuhj4o9IM74s3nZJUheixuhPtCgXh/2ddZTXXSN9gKP/112l+vc8rJSUFsZCW
         DCZs9RFfvtzjk/tN+Xqoi4sknxJcLzbiVk77ikoHM9r1pNe04IbUDdcsB2MhKVOxa/vH
         eJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sLoCy/lKewo2mCwung1rnqIs8F5/BmbujOW+HJpCC/4=;
        b=ENaS0qAnWXHROqwWiXxaA17w1pm2AzEj59Fl9Kz9rWNeI9Ybv3VVyHhosXzwFGmX8l
         mNMUNxLwpkoq3bHqi0w5ZxVXwjN84YOTh4WR/t5LYv5AD/UMhLxR3FcXfRsz+TuXHAFB
         zHNGvGcU3Qjv74iunoMaYnY7DNpOQoY2PFzIw0l8u5E4vYp2HwLx0tJnPN5rf1tKgveT
         nYuR/hXY2b7nq9dkCNyCZRrEoFLUTsgvtNSN0H3VrdEAsMT4dxQrUTHk5ut1a8WXHNTb
         mFYHYfIv+pmOeqPT1TnXL2lyS0vCQ0dI85eMJPcdZiIBpfKYYSH/5xLLhzluApfZqqwH
         D4QA==
X-Gm-Message-State: ALQs6tBBRtyfdkbsKaj08SgRCodz+7120wvlXYwPZGAfRbDzYfQzdwyu
        9+ABFw/X228oP/GJsNNTnAWpyz8ug8GEge/lVLw=
X-Google-Smtp-Source: AB8JxZrZimmvnY7382CrJqgEH3GYaGzGq92UfYn79vldUJdInZkGCOMpLOA2KENYHHKtXR7H1tIwSw58w6yJ1ToBwLE=
X-Received: by 10.176.21.232 with SMTP id j37mr2969412uae.199.1524875082916;
 Fri, 27 Apr 2018 17:24:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 27 Apr 2018 17:24:41 -0700 (PDT)
In-Reply-To: <1524825269.2227.5.camel@klsmartin.com>
References: <1524739599.20251.17.camel@klsmartin.com> <CABPp-BE5jRG8JdDfH1XG-Btz9jJxfwf_oyNni8Ci1j+J3icbVQ@mail.gmail.com>
 <1524825269.2227.5.camel@klsmartin.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Apr 2018 17:24:41 -0700
Message-ID: <CABPp-BGX-hQYdqfNQZ42313VVhKd7GzgUJqvgwOj=0TEO5UQpQ@mail.gmail.com>
Subject: Re: git merge banch w/ different submodule revision
To:     "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Apr 27, 2018 at 3:37 AM, Middelschulte, Leif
<Leif.Middelschulte@klsmartin.com> wrote:
> Am Donnerstag, den 26.04.2018, 17:19 -0700 schrieb Elijah Newren:
>> On Thu, Apr 26, 2018 at 3:49 AM, Middelschulte, Leif
>> <Leif.Middelschulte@klsmartin.com> wrote:
<snip>
>> > Problem case: Merge either branch into the other
>> >
>> > Expected behavior: Merge conflict.
>> >
>> > Actual behavior: Auto merge without conflicts.
>> >
>> > Note 1: A merge conflict does occur, if the sourced revisions do *not* have a linear history

Let me just note that I don't actually use submodules myself, and
rarely run across them, so as far as users expect submodules should
behave I may have to defer to others.  But it was particularly this
sentence of yours that caught my attention and got me to respond.  I
may have misunderstood which repository had the non-linear history,
but...

<snip>
>> But, there is some further smarts in that if either A or B point at
>> commits that contain the other in their history and both contain the
>> commit that O points at, then you can just do a fast-forward update to
>> the newest.

This particular paragraph, is relevant to your example; more details below.

>> You didn't tell us how the merge-base (cd5e1a5 from the diagram you
>> gave) differed in your example here between the two repositories.  In
>> fact, the non-linear case could have several merge-bases, in which
>> case they all become potentially relevant (as does their merge-bases
>> since at that point you'll trigger the recursive portion of
>> merge-recursive).  Giving us that info might help us point out what
>> happened, though if either the fast-forward logic comes into play or
>> the recursive logic gets in the mix, then we may need you to provide a
>> testcase (or access to the repo in question) in order to explain it
>> and/or determine if you've found a bug.
>
> I placed two reositories here: https://gitlab.com/foss-contributions/git-examples/network/develop
> The access should be public w/o login.
>
> If you prefer the examples to be placed somewhere else, let me know.

So the only thing I see here is a single repository, which contains a
submodule with linear history.  (unless I was grabbing it wrong; I
just tried `git clone --recurse-submodules
https://gitlab.com/foss-contributions/git-examples`)  Do you also have
an example with non-linear history demonstrating your claim that it
behaves differently, for comparison?


Anyway, in this case you had both branches updating the submodule to
something newer (to a fast-forward update of what it previously was),
but one side advanced it further than the other side did (in
particular, to what turned out to be a fast-forward update of what the
other branch used).  That means the whole fast-forwarding logic of
commit 68d03e4a6e44 ("Implement automatic fast-forward merge for
submodules", 2010-07-07)) came into play.

I would expect that a different example involving non-linear history
would behave the same, if both sides update the submodule in a fashion
that is just fast-forwarding and one commit contains the other in its
history.  I'm curious if you have a counter example.
