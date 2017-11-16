Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D33201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 03:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933115AbdKPDzB (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 22:55:01 -0500
Received: from mail-ua0-f177.google.com ([209.85.217.177]:55053 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933090AbdKPDy7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 22:54:59 -0500
Received: by mail-ua0-f177.google.com with SMTP id j14so17819573uag.11
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 19:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DpQAm0x+xylRhRAuJ3yDC4h7txJRG9n99JB/TVS6jJM=;
        b=gelMWRscyCOmHIOt8uC3YoibmLGe4NTaV4QyH6D8z6Le7wyqa6Xtolje3iUyP2KB3I
         LG8lrKDn4SCqXrfrNtXbf80sXao2kaDdSwmN9pTY6qpYkYFJ40jXe8LVo6TOMEyVAdzl
         jVbjQnhah7dcBcXIxC/+YG8yXcyqaOjnw9iRCDeQ4PQFRrCGb3EQJCD5jXvEuakuLv/4
         WlGb2f+A6xNNkircGmAZrR23TWPkMNptfEBjVgGr5cTMH2SVNQ3de46kM/y/XiNEU3pV
         jo+n1H7CrXhCvZjW8JAFwJgZThQo/foF/+Q+PE9AWbYYBD1SGCmOvqcPBwok5pcAhugn
         osdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DpQAm0x+xylRhRAuJ3yDC4h7txJRG9n99JB/TVS6jJM=;
        b=J4Q1/oAF4tJ27CHIZQEQiaikufa2LH6Y8a2GeLY31g8xoSHlShziNCXVQjYhHM65Xh
         ZxlLNMGZ05FAYuwrSnybTdhdLi81KmnoxFpD5FaFZpo/PS2H46cwVJ5TiL0Vt4WW3n1s
         hI8bdlxz1QSQZ9d+TQhyfiZjyJn1BYc3NJvDw7w8uefCoVcOiDDrh0XNauKciDBlVkIF
         5YUukPM/u/FTs9Yzp7UZ/95p6UUJPtrdN5JEWVIx7dO/mJASqKrgl+5UlPYHD57FEz1W
         cEK5mh8AnPLkcOeFsg1c8FiQ2se7LtSXcgVWhRhpW+HFoxjRiH7kKCNFfA8erjeAzZEi
         7OnQ==
X-Gm-Message-State: AJaThX7x+53NOnWfECYypsIKt7tdC9TgRJpFU8+PtXbVJyhk30+wlngl
        HKgU7ccvK3IaFbks9l7O1+4t87EfKadnDNI0mz0=
X-Google-Smtp-Source: AGs4zMbeWTGDRIDIPmzqjawXSU6w5U2cKM1VjDLBrKJVKy9HH3aWJjyEeR5xjGgpp2HVV0XLEGSZ+Z0T99FaAkZdPMI=
X-Received: by 10.176.82.110 with SMTP id j43mr213418uaa.9.1510804498752; Wed,
 15 Nov 2017 19:54:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.87.193 with HTTP; Wed, 15 Nov 2017 19:54:58 -0800 (PST)
In-Reply-To: <CAGZ79kanxn7+bgMxbEfSPZtSr4KBWzk9NHE9F-g4J+2TXbz_mQ@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-28-newren@gmail.com>
 <CAGZ79kanxn7+bgMxbEfSPZtSr4KBWzk9NHE9F-g4J+2TXbz_mQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Nov 2017 19:54:58 -0800
Message-ID: <CABPp-BHfRtfOhD5bt-DCBgLW8NjzKsohaf4C5ZatWwPS-adYfQ@mail.gmail.com>
Subject: Re: [PATCH 27/30] merge-recursive: Apply necessary modifications for
 directory renames
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 12:23 PM, Stefan Beller <sbeller@google.com> wrote:
>> +               if (!strcmp(pair->one->path, pair->two->path)) {
>> +                       /*
>> +                        * Paths should only match if this was initially a
>> +                        * non-rename that is being turned into one by
>> +                        * directory rename detection.
>> +                        */
>> +                       assert(pair->status != 'R');
>> +               } else {
>> +                       assert(pair->status == 'R');
>
> assert() is compiled conditionally depending on whether
> NDEBUG is set, which makes potential error reports more interesting and
> head-scratching. But we'd rather prefer easy bug reports, therefore
> we'd want to (a) either have the condition checked always, when
> you know this could occur, e.g. via
>
>   if (<condition>)
>     BUG("Git is broken, because...");
>
> or (b) you could omit the asserts if they are more of a developer guideline?
>
> I wonder if we want to introduce a BUG_ON(<condition>, <msg>) macro
> that contains (a).

Yeah, I added a few other asserts in other commits too.  None of these
were written with the expectation that they should or could ever occur
for a user; it was just a developer guideline to make sure I (and
future others) didn't break certain invariants during the
implementation or while making modifications to it.

So that makes it more like (b), but I feel that there is something to
be said for having a convenient syntax for expressing pre-conditions
that others shouldn't violate when changing the code, and which will
be given more weight than a comment.  For that, something that is
compiled out on many users systems seemed just fine.

But, I have certainly seen abuses of asserts in my time as well (e.g.
function calls with important side-effects being placed inside
asserts), so if folks have decided it's against git's style, then I
understand.  I'll remove some, and switch the cheaper checks over to
BUG().

>> +                       re->dst_entry->processed = 1;
>> +                       //string_list_remove(entries, pair->two->path, 0);
>
> commented code?

Ugh, that's embarrassing.  I'll clean that out.
