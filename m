Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA6ECCA485
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 20:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiGUUFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 16:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiGUUFE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:04 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458846D9DF
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 13:05:03 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p81so2214741iod.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 13:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cFPAI7NqI3Ihng2Ik+KCZjIIZ9LcvDcOwCTRLLLDrnI=;
        b=E+bCF8Nmcp2FOL2+a31sYezS3FoXwD9jYKcgy16gL5ZR+FA+jM/+qJTem1KEx5pClx
         Lo2tcA8tioTVSolLwnht7jEVKSQpXj10lZ4stfVfngji7HC2JjB4jEAEaikcStuseka2
         yAI6D72XmSzcVcy3LHw64BzJjfW6pUDN9DY777/1nI/fRl1SP1mtiLcIdGUgcfJLQm5K
         DpHWvBIEO1FcboRgvERb3NOJO8uRytHDGLgx5oB3U5pzCe6d0xg9iQkmESkeaOjZ+Tn0
         xFeFGoOqTskPqlaXnEFEN+yqL0gwNAoUasRSE5ce+ZibXSPCq47vGhgUPJ4omegFvb/8
         USzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cFPAI7NqI3Ihng2Ik+KCZjIIZ9LcvDcOwCTRLLLDrnI=;
        b=oEleAU03fxU3xsUGh9fFZYLPQ7adjTxzS8LSULTFy4zj8ecpkNgg+VGQNqXUEXQe6I
         UHQHS4jghLbpKnXhJlCHeEa07GJEWAIjBgemCzGK1WlxuO5IUq3hUpXbqPoEc4j1ygLQ
         j4YySoOuZU0Bk+2zQKSVtvhDfOxhmVlK4C00Y+0XXuFQwlymuRVFfsqe1Z5P5SpjOb0q
         gcqsPC2mxXnKYP7w3Xq5FKNrbcgTE0Jz68unvUiPy/pH3oK8krNeDke6y//FVQv5UyrF
         oGfWnNXXbCMaQi1nsyGLHSB2L5O9y8NxfbmhJez62meVw5G2pWNakLD/4QybezBhhlun
         SqGA==
X-Gm-Message-State: AJIora+aIYhcFxZP/OU1NOHcQKoXFckTpIUPZALU4wtOMhg2NpRuCqJq
        +N+jY25+I7CWE/qn1sT1fzFB
X-Google-Smtp-Source: AGRyM1umuCvGVdrWEjQ99iIqy+XyRvDValAjav1Uf+rK2Kj6ycG0RWGfEVTjOepQicVNFX+pZgIcQw==
X-Received: by 2002:a05:6602:1493:b0:67c:498f:6297 with SMTP id a19-20020a056602149300b0067c498f6297mr56157iow.19.1658433902612;
        Thu, 21 Jul 2022 13:05:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8099:5229:7961:505e? ([2600:1700:e72:80a0:8099:5229:7961:505e])
        by smtp.gmail.com with ESMTPSA id o22-20020a0566022e1600b0067bd7f5f964sm1244598iow.7.2022.07.21.13.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 13:05:01 -0700 (PDT)
Message-ID: <e18ff601-78e4-5dcf-e149-247ca2c7a05b@github.com>
Date:   Thu, 21 Jul 2022 16:05:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/12] rebase: update branches in multi-part topic
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
 <CABPp-BGKzcVatwoLhzXiJ3jkKXgWne+=5xNj+VmNO=pL5Kr1Og@mail.gmail.com>
 <f0f94d74-b49b-e26a-d38c-77687bbbb153@github.com>
 <CABPp-BEaX06dGC8YqjRPwnzpRcMorZsk=TCqCsWV4=CFgtvGng@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BEaX06dGC8YqjRPwnzpRcMorZsk=TCqCsWV4=CFgtvGng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 3:43 PM, Elijah Newren wrote:
> On Thu, Jul 21, 2022 at 5:13 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 7/21/2022 12:35 AM, Elijah Newren wrote:
>>
>>> One thing I'm curious about (sorry to bring this up so late):
>>> "pick" commands come with the old commit hash.  Perhaps the update-ref
>>> commands should too?  (e.g. "update-ref refs/heads/topic from
>>> <OLDHASH>")
>>
>> I don't personally see the value here other than to make it harder
>> for someone to add new commands (and confusing when wanting to
>> create a brand new ref).
> 
> I apologize if my late query caused frustration. 

I intended this as "I don't understand, please enlighten me", but
looking back now it definitely sounds more frustrated. Sorry about
that.

> I was thinking it
> made more sense to ask now than later and was genuinely curious for
> thoughts on the idea, but perhaps it'd have been better if I just
> didn't bring it up.  Sorry.
 
It's definitely the time to bring it up, because it will be harder
to change it once it's shipped.

> But, if you're curious why I was thinking about it...
> 
> 
> There are four ways I can think of to handle the <oldvalue>: (A)
> include it in the "update-ref" instruction, (B) manually get the
> <oldvalue> at program invocation, (C) accept an increased race-window
> by not grabbing <oldvalue> until the line is parsed, or (D) ignore
> races and just don't provide <oldvalue> when updating refs.  If one
> chooses (B), they can either (B1) pre-parse the entire todo list and
> look up the current values of any refs mentioned in an update-ref
> instruction, or (B2) record the value of all existing refs at
> invocation.
> 
> Rebase is already paying the cost for pre-parsing the entire todo list
> (i.e. B1).  In fact, you _also_ preemptively locking the refs
> mentioned.  So, in a sense, rebase is already covered. However:
>   * adding such a thing could potentially remove a small race window
> (perhaps the user takes a while to edit the todo list, and the ref
> somehow gets updated before they even finish that step; being able to
> specify the oldref might help in such a case).
>   * existing commands (pick, merge, etc.) give the oldrefs (or labels
> to them), so having update-ref also do so might provide some "feel
> good" consistency.
> 
> Perhaps those reasons are pretty weak for the rebase case, given you
> already do B1.  However, `git replay` isn't going to do B1, and nor
> will it preemptively lock refs.  I see `git replay` as a patch-based
> analogue to the snapshot-based tools of fast-export and fast-import.
> (fast-import doesn't pre-parse its entire input before starting to
> process the first commit, nor does it preemptively lock refs.)  B2 is
> not appealing because some repositories have gargantuan numbers of
> refs.  Also, the update-ref-during-edit-of-todo rationale is more
> important for `git replay`, because I want `git replay` to accept a
> filename containing a todo list in lieu of a range of revisions to
> replay -- perhaps users spent quite some time or programming effort
> generating their todo list and it took some time to generate/review.
> And that further undercuts both B1 and B2.  So, between all those
> reasons, (A) is very appealing to me.
> 
> All that said, `git replay` already has other planned differences in
> its todo list (e.g. a "reset" directive must be the first non-comment
> directive, there's no separate "merge" directive, etc.), so if I have
> to add another one, it's no big deal.

I'm happy that you're working on 'git replay'. I'm excited to see how
it works. Also, it would be helpful to keep these things in line as
much as possible.

> Your point about specifying <oldref> being seen as friction for some
> users is well taken, and I'm thinking of making the "from <oldref>"
> part of the instruction optional (though documenting that users are
> accepting some race risk by switching from (A) to (C) when they omit
> it).
>
>> We could consider adding a comment in the
>> future without any backwards compatibility issues:
>>
>>         update-ref refs/heads/my-ref # was 0123dead
> 
> Yes, this could certainly be added later (though none of my reasons
> for wanting <oldref> were geared around pointers for the end user, so
> this form wouldn't be helpful to me).
> 
> Also, if "from <oldref>" is optional, it could also be added later.

The optional value makes this something that we can add later, which
I think is good flexibility. I was thinking about doing the comment
thing as a follow-up (in addition to Phillip's error mode comments)
but maybe I'll explore this direction instead.
 
> If you've read this far, let me just take a minute to again thank you
> for your work on this --update-refs option to rebase.  It's some cool
> work.  Also, thanks for listening to my random ideas and musings along
> the way.  :-)

I really appreciate the attention you've given it. It's already
improved a lot due to your help.

Thanks,
-Stolee
