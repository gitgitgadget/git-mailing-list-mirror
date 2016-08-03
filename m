Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46C01F40E
	for <e@80x24.org>; Thu,  4 Aug 2016 00:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933150AbcHDAVv (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 20:21:51 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36650 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933095AbcHDAVu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 20:21:50 -0400
Received: by mail-io0-f173.google.com with SMTP id b62so258572918iod.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 17:21:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oFG2AgTHt5cgXvr4pV63fOCFHF2/4NR45uk3htWmW68=;
        b=g82hd85aOSSr2/VpsM/AJ9p2aS3BAev/wX73IeLwH7SDjV3Uha8Wvfx7cFm9M6rUeQ
         AqJKSuDbfEY5LOhvekfDRxjLOVpKMsJkgSjcA3Ycmbk1AytmibQOJYz3VBPs8uSFY4qx
         R9vw27+fuNx3gG04UYmOh6Yn/DpsqIIIa8NIkhnEmyZouGVAbSutcqu+5mua5ezcY8QW
         HWf+vEdv6Kug252F6F7bvoAQVvpX+9HQskwReG7IjVSIhVPq51kIWXlBN1PU/KUL1aU1
         q9eTNjEy3enbrluvKWAnAc1XTGwq+astD1J+9sJ/BMsvQRlt5g3LELj2n33XHHI5jXka
         i/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oFG2AgTHt5cgXvr4pV63fOCFHF2/4NR45uk3htWmW68=;
        b=Ms/YWMg8KGDRQw4v9IdaeyCEkZkS/kzo9k5XQrki6roooIQ21FneoiwJI3h4ZKumQS
         1eWMEDMRHqJvxtdkRhkrnB3zCfid0NWLHUuurDA81dIPoJ1176mY3sEAFlhwOD1XxGXm
         VNrB/3z0SkwW+1S1W0o6IEn6rNuFwP+H7SONK1TzxEFKCnh9uAVHXQKzsK3co8Q/T1HN
         YgvUb7GkHPG+ZBz2ONO7Nbip1910X0tw9cy2Q4VImP+84Te1SKbccMHoPGxsH8TiWesI
         42HDXO4E8mzTbDUCkpdPjCf+ZSmZJ+xwNqaNrFmhNq2nivEwvpjqP3rdBKY769YG4Rr7
         D7ag==
X-Gm-Message-State: AEkoouso4RMio4JCjwNfiGoZZRTSGTO6DZ2O/rPWFHPokuuMffFPKbZSb9YbtgwTJbrILHxLsbwSpqPQ06dJFZt6
X-Received: by 10.107.131.38 with SMTP id f38mr73504718iod.173.1470268246484;
 Wed, 03 Aug 2016 16:50:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 16:50:46 -0700 (PDT)
In-Reply-To: <57715dee-ca73-c1bb-ee79-2813d7873649@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu> <f4ce27f389b64c9ae503152c66d183c4a4a970f1.1470259583.git.mhagger@alum.mit.edu>
 <CAGZ79kZk+XW+Bwcx_fvOLVBDse_iUSjEa_K=eJqm4PpTsTAcPA@mail.gmail.com> <57715dee-ca73-c1bb-ee79-2813d7873649@alum.mit.edu>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 16:50:46 -0700
Message-ID: <CAGZ79kbyCRDTt4u+Fje819mNZZf3GkZtYVurwOMPXRfXqO-YEw@mail.gmail.com>
Subject: Re: [PATCH 2/8] xdl_change_compact(): clarify code
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 4:14 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/04/2016 12:11 AM, Stefan Beller wrote:
>> On Wed, Aug 3, 2016 at 3:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> Write things out a bit longer but less cryptically. Add more comments.
>>
>> By less cryptic you mean in Git coding style ;)
>> The original author (do we want to cc Davido?) may disagree.
>
> Davide hasn't contributed since 2008 and libxdiff is not being
> developed, so I didn't think he'd be interested.

ok.

>
> Yes, tastes certainly differ. If more people like the old version
> better, I will gnash my teeth and undo these "clarification" patches.

I was not asking for undoing these, but giving short cryptic answers myself. ;)
While I agree the variable names are way better than before, the use of while
instead of for (and then doing another final ++ after the loop) extended some
one liners to about 5. I am totally fine with that as they are easier
to read for me
as I understand them as Git style, hence easier to read.

There may be old timers (who have knowledge of C from other projects), that
would prefer the style as before:

e.g.

-               start = i;
-               for (i++; rchg[i]; i++);
-               for (; rchgo[io]; io++);
+               start = i++;
+
+               while (rchg[i])
+                       i++;
+
+               while (rchgo[io])
+                      io++;

This doesn't change variable names, but it only transforms a for loop with no
body in a more readable structure of while loops separated by white space.
So for such a chunk I could imagine people arguing about adding lines of code
(which is valuable screen real estate) for only slight gain if any.
I am not one of these.


> I
> mean, what's not to like about variable names like "grpsiz" and "ixref"?

faster typng ;)


>
>>> +
>>> +                       /*
>>> +                        * Are there any blank lines that could appear as the last
>>> +                        * line of this group?
>>> +                        */
>>
>> IIRC this comment is not quite correct as this 'only' counts the number of
>> blank lines within the forward shifting section, i.e. in the movable space.
>>
>> Later we use it as a boolean indicator (whether or not it is equal to 0)
>> to see if we can do better.
>>
>> Any other change in code and comments looks good to me, but this stood out
>> like a sore thumb. (Probably the old heuristic as a whole stood out, but the
>> comment here specifically sounds /wrong/ to me in this place. How can
>> a question document a variable? I'd rather expect a question comment
>> to ease the understanding of a condition)
>
> I don't understand your objection. A blank line can appear as the last
> line of the group if and only if it is within the shift range ("movable
> space") of the group, right? So it seems like our formulations are
> equivalent.

Sure, e.g. in 0fe5043da (2016-06-17, dir_iterator: new API for iterating
over a directory tree), struct dir_iterator_int we have a member

    struct dir_iterator_int {
...
         /*
         * The number of levels currently on the stack. This is always
         * at least 1, because when it becomes zero the iteration is
         * ended and this struct is freed.
         */
         size_t levels_nr;
...
};

you could have written that comment as

    /* How many levels do we have to free? */

but that would be misleading the same way as here.

I think a comment should carry useful information that is not
obvious from the code. So in this comment we want to convey the
message that we need to count blank lines to apply a heuristic later
on. Maybe

  /* Number of blank lines in the sliding area of the group */

as that

* states the actual thing we do
* doesn't hint at one particular intended use case later on
* it assumes you know what a "sliding area" is though.

I think what triggered me on questioning this comment, was the fact
that it is a question as we rarely have comments stated as questions.




>
> Since the variable is used as a boolean, it seemed natural to document
> it by stating the question that the true/false value is the answer to.

Oh I see. Another example (that maybe looks constructed) is the comment
of S_IFGITLINK in cache.h which is not "Is this entry a submodule?" but
rather some sentence of what a git link actually is. (though very short)

>
> If you have a concrete suggestion for a better comment, please let me know.

I'd go with the imperative form,

 /* Number of blank lines in the sliding area of the group */

if that makes sense to you?

Sorry for the bike shedding and not focusing on the real issues,

Stefan

>
> Michael
>
