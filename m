Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF7A209FD
	for <e@80x24.org>; Thu, 25 May 2017 16:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934636AbdEYQba (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 12:31:30 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33480 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758256AbdEYQb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 12:31:28 -0400
Received: by mail-pf0-f172.google.com with SMTP id e193so172070448pfh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QvsfGJwQaW7+633Pf48LsnUmWcQe42DGumovJXy9eKQ=;
        b=eAw1SSkZbVHV15ltDpriLxoamZdoKqlfFVpc+rEQUgKeGtLDuNOUBTOvYTbPlNIntk
         sd0GnqtuiVFPj/a+oeGRrGoRafn06tLiqwasQeEHjgeCEsUyg5/447Jpx1WYL+Uk8DXo
         LmhjbAns+IVHE9FANFUdOc2QS2dmhJW2UaO/R7g/MemcRiwO3o1IkPOlPcep/9YZdsGS
         0mM0O9io4Wl6ag0IqdL8uz+FXi4TT/NLL97LelJ5rwa3Q5DqYQRTovDMmtBm9UP2mkEV
         K+AP82w1P9Dav4ZVlfB/zhofk/vza/8JAqBMNbkte5aRt0sTBEF0LE5EDDTj4H5a8oXE
         1o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QvsfGJwQaW7+633Pf48LsnUmWcQe42DGumovJXy9eKQ=;
        b=VseLFdrNRBiLILK2dNmj9TW5c/BuYpgo5dVHdAiokGz2LThyGOrGOcFuoFTShsMgv+
         zB2tGkZMyM/DGfJFnJhxxmKmIMVrA7tL8z/G5ZkNF+ItFcBl+WdIxcXzq3IbZnryJC2L
         BtoIwdlLm1fEzfBsr4Sg41d17CePH7tPis58PyTSTl165qON3t/AzkemK+KT5fpv1mUP
         vpg4Hg0HjUZKUBA6LmadWKy+JCB1UEwu+PNvDZy2oecPx/9xSZ8YjPXi9dFL10OYSM3S
         MdJxAAbdybO1s7ZKkXebG8iNleM+TJFjmFl097ycXhhvj21bg8ekTbkhLJo+PteTEd2B
         AZDg==
X-Gm-Message-State: AODbwcAppUfEdGTiENZ3KeZS3LFKI0U1aSuWlmGpjRPi5WAmnS6R/nmx
        W1Mi+wCaGRUdMLQ+MiYRXXOrY/RdBkIF
X-Received: by 10.99.116.7 with SMTP id p7mr45908244pgc.162.1495729887968;
 Thu, 25 May 2017 09:31:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 25 May 2017 09:31:27 -0700 (PDT)
In-Reply-To: <xmqq7f15e8pu.fsf@gitster.mtv.corp.google.com>
References: <20170523024048.16879-1-sbeller@google.com/> <20170524214036.29623-1-sbeller@google.com>
 <xmqq7f15e8pu.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 May 2017 09:31:27 -0700
Message-ID: <CAGZ79kYO8DoTDCXCk1uSFSAJA5JusD-t4BZoQfGy5n9DF34EvA@mail.gmail.com>
Subject: Re: [PATCHv5 00/17] Diff machine: highlight moved lines.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 11:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I was trying to see how this is useful in code moving change, with
> this command line:
>
> $ git -c color.moved diff js/blame-lib~6 js/blame-lib blame.c blame.h builtin/blame.c
>
> Some random observations:
>
>  * You do not seem to have any command line option yet.  I guess
>    that is OK while the series is still in RFC state, but when we
>    are ready to seriously start considering this for 'next', we'd
>    need something like --color-moved that can be used across "diff",
>    "log -p" and "show".

There is "--color-moved" as a command line option. (See diff.c:4290)
Oh, it is not documented! That will be fixed.

>  * As configuration variable names go, "color.moved" is probably in
>    a wrong section.  Perhaps "diff.colorMoved" or something?

As you turn on/off normal coloring via "color.diff" and this only extends
the coloring scheme, I have the impression "color" is the right section.
Maybe color.diffStyle=[normal/enhanced] and "enhanced" means this
feature for now?

The only option in the "diff" section related to color is diff.wsErrorHighlight
which has a very similar purpose, so "diff.colorMoved" would fit in that
scheme.

>
>  * The fact that I am using
>
>      [diff "color"]
>         old = red reverse
>         whitespace = blue reverse
>
>    on a "black ink on white paper" terminal might have an effect on
>    this,

Yes very much!

>    but lines printed in either bold green and on green
>    background (i.e. not new ones but are the ones moved from
>    elsewhere) stood out a lot more prominently than lines printed in
>    green (i.e. truly new additions), and I felt that this is totally
>    backwards from what I needed for this exercise.  That is, while
>    reviewing a code moving change, I want to be able to concentrate
>    primarily of three things:
>
>    - What are the new lines that are *not* moved from elsewhere?
>      Did the submitter try to sneak in unrelated changes?
>
>    - What are the changes that are truly lost, not moved to
>      elsewhere?
>
>    - Do the lines moved from elsewhere form a coherent whole?  Where
>      is the boundary between blocks of text that are copied?  Do
>      adjacent two blocks of moved text come from the same old place
>      next to each other?

So with these questions, I wonder if we want to color moved lines
as "color.diff.context" (i.e. plain white text in the normal coloring scheme)
This would serve the intended purpose of
dimming the attention to moved lines.

Regarding the last point of marking up adjacent blocks (which would
indicate that there is a coherency issue or just moving from different
places), we could highlight the last line of the previous block
and first line of the next block in their "normal" colors (i.e.
color.diff.old and color.diff.new).

The very first version had some boundary coloring, but then
I switched to alternating block coloring based on an idea
by Jonathan Tan.

Maybe it is time to go back to boundary coloring, but optional
and apply the boundary color only if two blocks are adjacent?

Example of how it could look:
---8<---
    diff --git a/poetry.txt b/poetry.txt
    index 9d32b3b..cc50ca1 100644
    --- a/poetry.txt
    +++ b/poetry.txt
    @@ -1,12 +1,4 @@
[W] -A simple text is
[W] -written in paragraphs and
[W] -many more lines.
[R] -
[W]  A diff is smaller
[W]  than the pre or post image text form
[W]  used for review
[W]
[W] -In between focus
[W] -is hard to keep consistently
[W] -errors may occur
[W] -
    diff --git a/engineer.txt b/engineer.txt
    new file mode 100644
    index 0000000..8fbc0ce
    --- /dev/null
    +++ b/engineer.txt
    @@ -0,0 +1,7 @@
[W] +A simple text is
[W] +written in paragraphs and
[B] +many more lines.
[B] +In between focus
[W] +is hard to keep consistently
[W] +errors may occur
[W] +
---8<---

W -> simple White text (diff.color.context)
R -> Red text (diff.color.old)
B -> Boundary marker (Maybe just diff.color.{old/new}
      or a new color to configure)

>
>    Using colors that stand out more prominently than for the regular
>    new/old lines is counter-productive for all of these, especially
>    for the first two purposes.  I may suggest using cyan (or any
>    color that is very close to the background) so that the presense
>    of moved lines are merely felt without being distracting.  IOW,
>    while reviewing code moving patch, moved parts want to be dimmed,
>    not highlighted.

I agree. So I could resend the algorithm used with other defaults
or try out the "boundary only iff adjacent blocks, else context color".

Thanks,
Stefan
