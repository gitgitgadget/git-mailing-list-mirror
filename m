Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE13D1F51A
	for <e@80x24.org>; Thu, 10 May 2018 22:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbeEJWcB (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 18:32:01 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36585 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeEJWcA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 18:32:00 -0400
Received: by mail-ua0-f193.google.com with SMTP id b25-v6so2388469uak.3
        for <git@vger.kernel.org>; Thu, 10 May 2018 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dcrx+Wk6xpk+fiJo7d1PjOJtIu6iCcQBYHD62atqZKM=;
        b=OvjxK6rZMMaUZ5nDuPFQwBwujPjuNB3V7rseYXZVer9RKcbCv4zVanz22xhmsa/FQs
         EykJCdv68AGud0aPt2gzhYLExbHlO4TBoOdHOubDe2EMFzGwXPRKicWUD7m9Y8Hmyv4G
         lsHoKcsQ+A92Xqerwuslsy8S3zJ9i2dU+sqHnTbahhwrQJiDv2aTypNCslmO75uLCgzl
         MZyQsx+HkqbONtt1LuU+hU8KGifD7TiT1KBp2y8ZNhFSYqW32qYj3umP2qUR0ArZAiIq
         gfMF+txI/+P+WfdDOfI7BL7uPPufkvokb9rEe+XmL5wpJZozWkgdfVwRxTcpcvkZTKYN
         WPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dcrx+Wk6xpk+fiJo7d1PjOJtIu6iCcQBYHD62atqZKM=;
        b=H9mknKVuJrxeBaPHjVTxKaR2odpZ/yRxTfzSqtXuk+Tt37lwAbgocvX29yONgGd5KK
         CbV25Sr0Z8Z81qrcPnWP8UUZrdlHHM+IUQRVJEINsWx6dhWzvlSkS6RQ5BuyWhLD73VM
         DOiJu1MoMKeb3jkFSzZXZ7QLud0tzWENTT1WJx9qya33yu/7GtWxN7L9xKCWicfZCqgJ
         deDUV/gd9uNeWYmSz0BA0vrSXuCtfKW8av/B/WgyaNQMLRWwrXlXmNMJ7y0Rm/YTqOFl
         C27q3klKLTPZWwjwl3dD6g/tVye7lgJGIVO7GH7qYpIAACoi2h9MxqKlzn1+DA5hh/xc
         AWtg==
X-Gm-Message-State: ALKqPwfWpQL1828PhXz8SlZvoLDbSECVWRjMQeJ5U7I7MbuGY63H/VEM
        LkDoaWF+GiUsoVSWhDaYvJXxog5yCYELp5RLaAA=
X-Google-Smtp-Source: AB8JxZrKx88gnzTaiTHC3er6BxeugokCCgaM2TGR7/EXwkAcgvBpenKMQg/OXHC7IufXcpLEvu43ikEu8j+u4MYlduM=
X-Received: by 2002:a9f:380f:: with SMTP id p15-v6mr2436298uad.112.1525991519611;
 Thu, 10 May 2018 15:31:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 10 May 2018 15:31:58 -0700 (PDT)
In-Reply-To: <bc81823e-7b7d-c516-dfc2-cd47bedb5a5a@gmail.com>
References: <20180509144213.18032-1-benpeart@microsoft.com>
 <20180510141621.9668-1-benpeart@microsoft.com> <CABPp-BGE6RXv3ka8wGXruFjk3W=kDEDJ6zpH3t5=_CGSTONCHQ@mail.gmail.com>
 <bc81823e-7b7d-c516-dfc2-cd47bedb5a5a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 May 2018 15:31:58 -0700
Message-ID: <CABPp-BGL2Fcnj0QNu+D3wfOU5q8MuizUGJyzrEc7FXy9Q9aA_A@mail.gmail.com>
Subject: Re: [PATCH v2] add status config and command line options for rename detection
To:     Ben Peart <peartben@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Thu, May 10, 2018 at 12:09 PM, Ben Peart <peartben@gmail.com> wrote:
> On 5/10/2018 12:19 PM, Elijah Newren wrote:
>> On Thu, May 10, 2018 at 7:16 AM, Ben Peart <Ben.Peart@microsoft.com>
>> wrote:

> Given the example perf impact is arbitrary (the actual example that
> triggered this patch took status from 2+ hours to seconds) and can't be
> replicated using the current performance tools in git, I'm just going drop
> the specific numbers.  I believe the patch is worth while just to give users
> the flexibility to control these behaviors.

Your parenthetical statement of timing going from hours to seconds I
think would be great; I don't think we need precise numbers.

>>> +       if ((intptr_t)rename_score_arg != -1) {
>>> +               s.detect_rename = DIFF_DETECT_RENAME;
>>
>>
>> I'd still prefer this was a
>>          if (s.detect_rename < DIFF_DETECT_RENAME)
>>                  s.detect_rename = DIFF_DETECT_RENAME;
>>
>> If a user specifies they are willing to pay for copy detection, but
>> then just passes --find-renames=40% because they want to find more
>> renames, it seems odd to disable copy detection to me.
>>
>
> I agree and will change it. It is unfortunate this will behave differently
> than it does with merge.  Fixing the merge behavior to match is outside the
> scope of this patch.

I agree that changing merge is outside the scope of this patch, but
I'm curious what change you have in mind for it to "make it match".
In particular, merge-recursive.c already has (or will shortly have)
+       if (opts.detect_rename > DIFF_DETECT_RENAME)
+               opts.detect_rename = DIFF_DETECT_RENAME;
from your commit 85b460305ce7 ("merge: add merge.renames config
setting", 2018-05-02), so I'm not sure why we'd want to carefully
propagate a larger value for o->{diff,merge}_detect_rename prior to
this point.  If it's just "future proofing" because you suspect that
copy information could be useful to the merging algorithm and we'll
eventually get rid of these two lines of code, then I could get behind
such a change, though color me skeptical that copy information would
ever turn out to be useful in that context.

The one place copy detection does make sense inside a merge is for the
diffstat shown at the end (from builtin/merge.c), but it currently
isn't controlled by any configuration setting at all.  When it is
hooked up, it'd probably store the value separately from
merge-recursive's internal o->{diff,merge}_detect_rename anyway,
because builtin/merge.c's diffstat should be controlled by the
relevant confiig settings and flags (merge.renames, diff.renames,
-Xfind-renames, etc.) regardless of which merge strategy (recursive,
resolve, octopus, ours, ort) is employed.  And when that is hooked up,
I agree with you that it should look like what you've done with
status.renames here.  In fact, if you'd like to take a crack at it, I
think you'd do a great job.  :-)  If not, it's on my list of things to
do.

>> Testcases look good.  It'd be nice to also add a few testcases where
>> copy detection is turned on -- in particular, I'd like to see one with
>> --find-renames=$DIFFERENT_THAN_DEFAULT being passed when
>> merge.renames=copies.
>>
>
> OK.  I also added tests to verify the settings correctly impact commit.

Nice!
