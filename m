Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444A9202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbdGMTbD (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:31:03 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:37221 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbdGMTbC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:31:02 -0400
Received: by mail-it0-f54.google.com with SMTP id m84so2996119ita.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jpv2QJClqEqyDvsjs4KaljtXsg8JY+/+HqZPBpKEXQA=;
        b=N5vO8CWkWmNbO30PZYMA1PnOlaR4c9ngcL1KofcUO9SsxxQDmQF7hLRHgx/qQC7y/z
         OZfCoSjoOh+RS5rEu4++rN74AHlUnjWAZkZh1P1SPiRJVq0gDxNZ+OwYHmQF4wJrEP/W
         LiO8D3YzJyfKmeK96YQf1YpmTVcA84OjLkO/bvob20EvnKCw9oTtmNQ8Gb+fTUTYLg+X
         tRIfzsrC3qzY/925hEMrsef0EHxi5cfuXL8PUsZuMcZGeSH60QmxWDPikX+jRiLubroD
         zkaZpjAHPyj30OmFqQtFF17oJy+0uWCKhQlw1PzS2OCSGwMKMeiBX3jWVLAGw+llo27P
         yUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jpv2QJClqEqyDvsjs4KaljtXsg8JY+/+HqZPBpKEXQA=;
        b=AOvloRPGFIV7ZBvBBNvwNMWm8Y9tem/MVuHouaSBgsGyKxfiob4t4ox17pLLPmp49z
         W/zm8+6cokniikrFLVvVKfNb+jESVUqEf7/pwC4bycUfOTV3bAKHqVNeDPeVtd0tEfu0
         kzb0VH9fO9lvbH1yP5O19ojdXoOcJK3QnzmrGRbZ5y54g43ndQCWflPjhbavqprqa+NX
         otd7wK5iPuXKFMs6w1IEDdkleQsBOkSjpLD4fLeFedL4OJjxOIpPeYbEeIi99w00XePb
         /LNgqgygrLCfl1bvzGmFUCM7TXjICe2/QybQ2vOjzi7kvqtcALt1EYMDEVzN6XslzMuK
         U5GA==
X-Gm-Message-State: AIVw113xjNTDvjNJ6Z63MtzawFmFJ5FkvWSy/jU1qDXB4M7ZptgzkqGT
        gMlz1G9+FkT4bQd97y3zlexiw+T5vcIU
X-Received: by 10.36.214.150 with SMTP id o144mr285441itg.57.1499974261810;
 Thu, 13 Jul 2017 12:31:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.138 with HTTP; Thu, 13 Jul 2017 12:31:01 -0700 (PDT)
In-Reply-To: <xmqqmv88xl7f.fsf@gitster.mtv.corp.google.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <B5FDF25C-ED5A-4CD1-AAD7-04BD8D705C59@gmail.com> <6e4096fd-cbab-68f0-7a23-654382cb810e@gmail.com>
 <CAEcERAxRmRh5pp=nXN7X9u=HQsJdSQfsXoedM_5eCDgDWwAkKg@mail.gmail.com> <xmqqmv88xl7f.fsf@gitster.mtv.corp.google.com>
From:   Nikolay Shustov <nikolay.shustov@gmail.com>
Date:   Thu, 13 Jul 2017 15:31:01 -0400
Message-ID: <CAEcERAyf+np9U-o-SGSOCWsibVPyEWPh2yY+uEOgLL+qYFe1mw@mail.gmail.com>
Subject: Re: "groups of files" in Git?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, but I am not sure I quite understand the idea.
Could you please elaborate on it for the following example?

I have two Perforce changelists ("A" and "B") that group uncommitted
sets of files (paths to each of files could be different):

changelist A:
file1
file2

changelist B:
file3
file4

In Perforce, I am able to do the following:
- move files between changelists (e.g. file1 could be moved to changelist B)
- add new files to changeslit (e.g. changelist B can get additional file5)
- revert file changes which would effectively remove file from the
changelst (e.g. revert file2 will remove it from changelist A)

How would I do it with sets of files that would belong to Git commit?


On Thu, Jul 13, 2017 at 2:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nikolay Shustov <nikolay.shustov@gmail.com> writes:
>
>> Thank you for the detailed explanation, it looks like merging the
>> commits would be helpful in my case. And I think it is a very good
>> analogy that Perforce changelists are like multiple pending committs,
>> if Git were supporting such.
>>
>> What it won't be achieving by using commits in this schema is the
>> following thing I can do in Perforce:
>> In the uncommitted Perforce changelists I can revert the changed file
>> to the original state and move the files between the changelists.
>> Quite often, while working on something, in the middle I would decide
>> to isolate changes to a certain set of files to a separate changelsit
>> - but then I might change my mind. It is all flexible until I actually
>> commit my Perforce changelist, after which it becomes very much as
>> committed changes in any other source control.
>> This is actual flexibility I am looking for achieving in Git.
>
> I actually think we already have such a flexibility.  Unlike
> Perforce, Git is distributed, and the most important aspect of the
> distinction is that what happens _in_ your local Git repository may
> be called "committed" in Git lingo, but not visible to the public.
>
> You can consider these commits you make in your repository "pending"
> when you think of your workflow in Perforce terms, until you merge
> and push out the result, which roughly corresponds to "submitting"
> in Perforce lingo.
>
> Once you start treating your local commits that you haven't pushed
> out as changes that are still "pending" when observed from the
> outside world, you'd realize that you have as much flexibilty, if
> not more, to dice and slice them with the local tools like "rebase
> -i", "add -p", etc., as you would have in your Perforce workflow,
> I would think.
>
>
