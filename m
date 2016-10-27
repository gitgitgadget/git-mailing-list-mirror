Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 388EF203BD
	for <e@80x24.org>; Thu, 27 Oct 2016 13:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936556AbcJ0Nv3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 09:51:29 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35621 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936504AbcJ0NvT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Oct 2016 09:51:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4907120616;
        Thu, 27 Oct 2016 05:27:16 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 27 Oct 2016 05:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=D28f30VoDfl5ic9
        RLFy+f08vXZo=; b=MOIti9TyiyXbt1UgCxT/e/RnKJ/PefBY4lYJNaXbrsEQsl6
        sjgNyMZaEsKgFAa3FQjLyx3v6vA3/ycmBwrInSR0kd9K0ZEu4lPVFpPmCJG3ZrvK
        3IbTQCbkCaIcRmhyDKA35lfTTe8OpFpnp3OHe9VH47kXMjDbAQha+bcn+lmk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=D28f30VoDfl5ic9RLFy+f08vXZo=; b=Q6g2pRz1ujEVX9tWSem7
        6TGTe+938M5JhFez5UuRcBClB3kWGtF+1mFhL287Roa2Y+vm1jfr9pBuXq4XU//M
        eEqLPLS6003BUhAiVyRxfDzIvDg448D3LFK4rz+g4bM0iJ+S4Ni4hC8SIY9qs4DE
        S1Qibt3ZspjyWF9RS2BStvE=
X-ME-Sender: <xms:dMgRWL6JUn99E2g6SUyEOl8JJmPWOLSQNybM8pt8nZdPpFQJT-8_Yg>
X-Sasl-enc: nC4dXnbFme+qeEReIZa+MZpZittoPqwVM7JQ3Rjutm75 1477560436
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id ACE72F29CB;
        Thu, 27 Oct 2016 05:27:15 -0400 (EDT)
Subject: Re: [PATCH] Documentation/git-diff: document git diff with 3+ commits
To:     Junio C Hamano <gitster@pobox.com>
References: <CA+P7+xq1i8AtQ7i=1m_n9HTSL10kFUFBn8jvNcB_t_6Rh29u4w@mail.gmail.com>
 <07712c2c94670ca4d91ef78cd7d3602a8d36b0c1.1477472970.git.git@drmicha.warpmail.net>
 <xmqqh97zask7.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <e74d4d84-d848-00be-8ca5-75204cf47262@drmicha.warpmail.net>
Date:   Thu, 27 Oct 2016 11:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqh97zask7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 26.10.2016 20:11:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> That one is difficult to discover but super useful, so document it:
>> Specifying 3 or more commits makes git diff switch to combined diff.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>
>> Notes:
>>     Note that we have the following now:
>> ...
>>     'git diff A..B' equivalent to 'git diff A B'
>>     in contrast to 'git log A..B' listing commits between M and B only
>>     (without the commits between M and A unless they are "in" B).
> 
> The standard answer is: 
> 
>     Do not use two-dot form with 'git diff', if you find it
>     confusing.  Diff is about two endpoints, not about a range
>     between two.
> 
> The reason why we do not reject can be easily guessed by any
> intelligent person when some historical background is given, I
> think.

That is very well true. I'm more concerned with the presence, though,
that is: How easy to use is git now? Users choose git because they care
about the history of their project, not necessarily that of Git ;)

>  - In the beginning A...B did not exist.  A..B was the only "range"
>    notation.
> 
>  - "git log A..B" was in wide use.  Remember, "git log A...B" did
>    not exist.
> 
>  - People started mistyping "git diff A..B", which looked as if the
>    user typed "git diff ^A B" to the internal.
> 
>  - Git _could_ have rejected that as a bogus request to diff two
>    points, ^A (what is that???) and B, but "What else could the user
>    have meant with 'git diff A..B' other than 'git diff A B'?" was
>    an argument to favor doing _something_ useful rather than
>    erroring out.  Remember, "A...B" did not exist when this
>    happened.

It did not exist, but even at that point in time, "git log A..B" listed
only commits between the merge base and B, not those which are only in A
and not in B. Whereas "git diff A B" shows the differences between the
endpoints A and B.

>> @@ -12,6 +12,7 @@ SYNOPSIS
>>  'git diff' [options] [<commit>] [--] [<path>...]
>>  'git diff' [options] --cached [<commit>] [--] [<path>...]
>>  'git diff' [options] <commit> <commit> [--] [<path>...]
>> +'git diff' [options] <commit> <commit> <commit> [<commit>...]
> 
> Made me wonder "is [<A>...] 0-or-more As or 1-or-more As?".

0-or-more, at least that's the way it is used in all lines here.

> Don't we allow pathspecs in this case?

Yes, the combinded diff mode kicks in only with no blobs (not: no
pathspec, which I had misread) and N>=3 commits. Maybe I should update
the code comments in builtin/diff.c to describe this, too.

Michael
