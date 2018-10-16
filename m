Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6879B1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJQGF2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:05:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34553 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbeJQGF2 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 02:05:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9331C22102;
        Tue, 16 Oct 2018 18:13:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 16 Oct 2018 18:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=/
        HBT2ZH+NtsIxVGfVyQu+6gGYanUYQZEM1Ho0nIpmiE=; b=p1QQzFOfTjkAWnhBS
        sa1HT8SKFMF2x5lAyfo7ks1iZztXDzYql1X50HaX5PziZo5WhkJYF53625I98Ntg
        0QaZbiY08gwnF0SyIC6RUBjNnSkYNlh3fH+li9wuX2BgYn4joQ91vi4jG/DvMhyW
        jD6lsjKK9R9eGXtJAaYz1YQEdcEqQHZVorQNgA2w4pTzN33wfUzmNGrDwGZpST0r
        /YI1qwpPjWtiXbvDn933VC+zX9XrztuZCn4MGd9jaoN4GaP6uqKbXVP0Q+El9Rek
        17EWGSOgEj6I1+/QlYWUZVhXcmT2BVnIgn3vccnf0htDFtlO9iZCR9u1kBdBKLf8
        XG+EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=/HBT2ZH+NtsIxVGfVyQu+6gGYanUYQZEM1Ho0nIpm
        iE=; b=ioWbQDAtldDunqp6QB/6AeBELAH9L6QIO615muZkhfZUoc6aCCc4eqt44
        eKN1l0N907cWg1mGz9u4iTGaCDfEY5Qzv/sEVaB6Q4PNpo1y0jmqfIxi887BIDAe
        KFx8J4oMXz6p7jRovrbUk8XNWe092vu5z4G8YPhh2ICYmu7Dk8s+bBCVDy7hNZnS
        d50xJtICEGR/HfeDVDh4YMzIu+NbfHinHtSV3ZI0z6v19OYedNiTjNjjBDLq8rC+
        qMHZwlKWP9mP6SooZzxk7a+4MMTB7eyR9APl/twX2m5HaPokLdlYVZ7vUtxrMvdB
        an0qzvQp+30QQQHFNXYLr3iL5jjKw==
X-ME-Sender: <xms:bGLGW0YhEvKmwC261SMki36F2B2tLabxvl_cIYog0R-mIUr9qd_7ZQ>
X-ME-Proxy: <xmx:bGLGW5YVAIz8eYICHEtmqtvBXbeJInkeGwJjwdZFB6FaAa5YmNB5Kw>
    <xmx:bGLGW8g_lLQXKfkLYokgOK_lUaPNtwNuk41AVP6bUguBl3_kNcx2Ww>
    <xmx:bGLGW1P0IQ4RkdpWvof39SmDfwzno6T8aEEFJazgOUdheyezd_xXFQ>
    <xmx:bGLGW2v-XhBzrdcYdBnoPn2somdAOkz5JI7BLvuGkQ2YHKpTMVByxQ>
    <xmx:bGLGW41sKvy6rExf1OYRCyjLjWEY61c3K4OzF5bwMiUjtGG_qxVUEw>
    <xmx:bGLGW509sXJ3BPztlVBOGQdu2J4rU5-JwYqippXgiizFVZmM2DbSbw>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id CA3E9E405D;
        Tue, 16 Oct 2018 18:12:59 -0400 (EDT)
Subject: Re: problem with not being able to enforce git content filters
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <5d4966c8-8171-9a0a-5120-f7c151c2b81f@stason.org>
 <87y3axd21q.fsf@evledraar.gmail.com>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <a6dcfee6-595b-2375-e9cb-71da74ed80bb@stason.org>
Date:   Tue, 16 Oct 2018 15:12:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87y3axd21q.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-10-16 02:17 PM, Ævar Arnfjörð Bjarmason wrote:
[...]
>> We can't use server-side hooks to enforce this because the project is on
>> github.
> 
> Ultimately git's a distributed system and we won't ever be able to
> enforce that users in their local copies use filters, and they might
> edit stuff e.g. in the GitHub UI directly, or with some other git
> implementation.

In this particular case github won't be a problem, since for the problem
to appear it has to be executed on the user side. Editing directly in
github UI is not a problem.

Just to give a little big more context to the issue in first place. A
jupyter notebook is a json file that contains the source code, the
outputs from executing that code and the unique user environment bits.
We want to "git" the source code but not the rest. Otherwise merging is
a hell. Hence the stripping.

There are other approaches to solve this problem, besides stripping, but
 they all require some kind of pre-processing before committing the file.

> So if you have such special needs maybe consider hosting your own setup
> where you can have pre-receive hooks, or within GitHub e.g. enforce that
> all things must go through merge requests, and have some robot that
> checks that the content to be merged has gone through filters before
> being approved.

Yes, that would be ideal. But I doubt this is going to happen, I'm just
a contributing developer, not the creator/owner of the project. And as I
said this affects anybody who collaborates on jupyter notebooks, not
just in our project. I think there are several millions of them on github.

> *Picks up flag*. For the purposes of us trying to understand this report
> it would be really useful to boil what's happening down to some
> step-by-step reproducible recipe.
> 
> I.e. with some dummy filter configured & not configured how does "git
> pull" end up breaking, and in this case you're alluding to git simply
> forgetting config, how would that happen?

The problem of 'git pull' and 'git status' and 'git stash' is presented
in details here:
https://stackoverflow.com/questions/51883227/git-pull-stash-conflicts-with-a-git-filter
and more here:
https://github.com/kynan/nbstripout/issues/65
https://github.com/jupyter/nbdime/issues/410#issuecomment-412999758

The problem of configuration disappearing I sadly have no input. It
doesn't happen to me, and all I get from others is that it first works,
and then it doesn't. Perhaps it has something to do with some of them
using windows. I don't know, sorry.

>> The bottom line it sucks and I hope that you can help with offering a
>> programmatic solution, rather than recommending creating a police
>> department.
> 
> I think it would be great to have .gitconfig in-repo support, but a lot
> of security & UI problems need to be surmounted before that would
> happen, here's some previous ramblings of mine on that issue:
> https://public-inbox.org/git/?q=87zi6eakkt.fsf%40evledraar.gmail.com
> 
> It now occurs to me that a rather minimal proof-of-concept version of
> that would be:
> 
>  1. On repository clone, detect if HEAD:.gitconfig exists
> 
>  2. If it does, and we trust $(git config -f <untrusted file> -l)
>     enough, emit some advice() output saying the project suggests
>     setting config so-and-so, and that you could run the following one
>     liner(s) to set it if you agree.
> 
>  3. Once we have that we could eventually nudge our way towards
>     something like what I suggested in the linked threads above,
>     i.e. consuming some subset of that config directly from the repo's
>     HEAD:.gitconfig

I like it, Ævar!

I feel doing the check and prompting the user on the first push/commit
after clone would be a better. It'd be too easy for the user to skip
that step on git clone. In our particular case we want it where the
problem is introduced, which is on commit, and not on clone. I hope it
makes sense.


-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
