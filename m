Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51BE81F42D
	for <e@80x24.org>; Wed, 30 May 2018 04:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750739AbeE3EVp (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 00:21:45 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:41391 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeE3EVo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 00:21:44 -0400
Received: by mail-vk0-f51.google.com with SMTP id 128-v6so4926037vkf.8
        for <git@vger.kernel.org>; Tue, 29 May 2018 21:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PKWuRiShBXW5ZXTDM3t3ThcZ/na+NSB7RR3CmvX5rj0=;
        b=UaB90NSx8iQYvwDsi/Lsa4zS5I2iMg+r6xgK0flm1xCcne9Ul6y7egKhoMSbfhPWWF
         DPURbAkx06rWfHNgPV6EiQSzBCHHuFBr1ZmgMUSVwB/RXj5LY0cbg/t6FE9e9cUa90BZ
         QOngu3YIwSIDcty95k6sBhH5MuynlRDyFX2nQnlZ11LrK445V3V/+rEdi6X1dSRQknZs
         thD7BIzSgt6HwdC1A1muJ1cqzfsXBm+YbYeSL4zCl+l6uo5ju/0F3YVVmXbRjf8t1P1b
         WyB/yXV6RrUkg67W5syquP76bXETAHMtAxqyHZm2ZJ3U6P8dJuCG7IKvQYVSYfsCB1E4
         z1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PKWuRiShBXW5ZXTDM3t3ThcZ/na+NSB7RR3CmvX5rj0=;
        b=LllojgmYqlPWUT265djdnibQ6n70Avdd3xceypCt2XnW3aaUZF+EMVHONE9ednOm5k
         xpE2mUJYu1yKGrybcnfjXj0evgiIAIWOX+oYA+5veOdr+X5nDQ9iVoEFfIdeDDVocGdW
         dw6dXicIwHbqlH3cYd3mFlF4c/asmSFWDVN+GHgBaHxEc6gKeMyZhOJnHdXMOQUX7aNP
         SNVtve4KpDw5OpkQTSfGZhcAhN4PvpmocPrpbsTC+99CtZB0PJR+6vodz5IzbsEIUa1p
         /+15adm1cTaPqC9U4Ch8q65kY82o843sh7gx1vkroykK7AHZFd3Wi7L8mGJndpNkHtcO
         kyTw==
X-Gm-Message-State: ALKqPwdn8vGKHv75ZL22O5+8zbcMsJTElRWBnmN4L+ASS+1BfobaqM+p
        qzcDPixR+uhmZwHIRn5E91/qElTPG2mgcAaock5xEg==
X-Google-Smtp-Source: ADUXVKJPKFK37GEs5tuvEE/Tp4V5l7vIbrHWp53yR/ZQU3YkLjaDyV8QulSkywZHBsPdRAV/rQlNVALBXsmFy62MOIg=
X-Received: by 2002:a1f:e483:: with SMTP id b125-v6mr539929vkh.149.1527654103513;
 Tue, 29 May 2018 21:21:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Tue, 29 May 2018 21:21:42
 -0700 (PDT)
In-Reply-To: <CAGZ79kYGTaFg7NnfxzdXQYTNddvqbUD3hfWEiq1RBETjYk=3gQ@mail.gmail.com>
References: <CABPp-BFQJZHfCJZ1qvhvVcMd-_sOfi0Fkm5PexEwzzN+Zw2akw@mail.gmail.com>
 <CAGZ79ka39xbbm_koyFeEizggoDBqKuwgmGwRBZJnBc13aOWZag@mail.gmail.com>
 <CABPp-BH1BBH7aBpoSaJE5J7okdfrDzpbu5rH-w-FSG2RM0hU1g@mail.gmail.com> <CAGZ79kYGTaFg7NnfxzdXQYTNddvqbUD3hfWEiq1RBETjYk=3gQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 29 May 2018 21:21:42 -0700
Message-ID: <CABPp-BG2fZHm3s-yrzxyGj3Eh+O7_LHLz5pgstHhG2drigSyRA@mail.gmail.com>
Subject: Re: RFC: Merge-related plans
To:     Stefan Beller <sbeller@google.com>
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, May 29, 2018 at 3:12 PM, Stefan Beller <sbeller@google.com> wrote:
>>> (B) sounds like an independent feature, which could go in parallel?
>>
>> B may sound like an independent feature, but it needs a merge
>> algorithm that doesn't mess with the working tree
>
> I agree on that,
>
>> so it depends pretty strongly on E.
>
> .. but not quite on the conclusion:
> You could also make the current merge algorithm working
> tree independent. Thomas Rast (cc'd) did so IIUC in
> https://public-inbox.org/git/cover.1409860234.git.tr@thomasrast.ch/
> (search the archive for "--remerge" if interested in this prior work)
> which did not land upstream.

I'm aware of Thomas' remerge-diff series (it's where I got the name
from, and I linked to it in
https://bugs.chromium.org/p/git/issues/detail?id=12).  It's some
pretty cool work.  I also submitted a previous series to make
merge-recursive not touch the working tree (for different reasons),
and then when folks pointed out the similarity between my series and
Thomas' in this area, I compared our approaches:

https://public-inbox.org/git/CABPp-BG49Gr3Kf8Q3E6Vc=GF9MG+m10HkhkwbaOBfzs1cFcgVw@mail.gmail.com/

I still think my approach to the do-not-touch-worktree aspect was
cleaner, but both complicate the already excessively complex
merge-recursive codebase, and just dance around the fundamental design
flaw in merge-recursive (discussed more at the end of the email via
links to Junio's thoughts on the topic).  At this point, I'd rather
just fix the design flaw rather than complicate the code further.

>> If the idea is to give feedback on *code* rather than just
>> ideas/tradeoffs/pinpointing-buggy-lines, then it sounds like you're
>> actually suggesting posting the RFC later rather than earlier?
>
> Some people have complained that they don't get feedback on
> ideas/tradeoffs/pinpointing-buggy-lines, but did so after sending
> RFC code. So I'd think a sure way to get feedback is to send actual
> code as an RFC even if it misses some parts.

Makes sense.

>> Also, the bigger question for me wasn't so much "should I ask the list
>> about these changes?" before making them, but rather: Do folks want me
>> to bring these things up before I work on D & E -- even if I end up
>> not getting back to incorporating their answers for months until D & E
>> are completed and merged?
>
> I'd think A + C are worth asking early nevertheless, even if D & E are
> away for some month; having these niche cases covered (in code and
> tests) as well as a new UI/UX for user communication sound exciting
> (The latter could result in some bike shedding, and then having enough
> time before you spend time to do it one way or another in D&E sounds
> favorable)

Okay, sounds like I need to put a little code behind my ideas, at
least enough for some RFCs.

> My experience is that smaller patch series are reviewed faster,
> so if the cost of splitting them up is not prohibitive, I'd strongly
> consider doing that.

Will do.

> So your long term plan is to *replace* the whole merge recursive strategy
> giving the same results.

Yes, precisely.  :-)

>> For avoiding duplicate code...well, Junio's suggestion was "[to
>> rewrite] without using much from the existing code in
>> merge-recursive.c at all" because he has "written off that code as
>> mostly unsalvageable"[4].
>
>>>> [4] https://public-inbox.org/git/xmqqk1ydkbx0.fsf@gitster.mtv.corp.google.com/
>
> Did you mean:
> https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/

The email you link describes the new algorithm behind the replacement
strategy.  That's a useful email, but I was specifically trying to
reference where I was quoting Junio from, which was the email where
Junio suggested implementing the new algorithm as a replacement
strategy rather than re-factoring merge-recursive.c; those quotes came
from the email link I gave.

> So in that case my reply above ("..so it depends pretty strongly on E.."
> I have a different conclusion) is void, as that *is* the new strategy?

Yes, I think Junio's suggestion is a _much_ cleaner way of getting a
do-not-touch-the-working-tree merge than either Thomas' or my previous
submissions. It's a much, much bigger chunk of work to do it that way,
but will fix multiple other problems that the current design make hard
or impossible to fix.


Thanks for the feedback!
Elijah
