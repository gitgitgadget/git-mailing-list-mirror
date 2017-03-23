Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB56F20958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbdCWRG2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:06:28 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54154 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751360AbdCWRG1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Mar 2017 13:06:27 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2611120E2C;
        Thu, 23 Mar 2017 13:06:26 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 23 Mar 2017 13:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warpmail.net; h=
        cc:content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=ZqeZhu4KZNeyalY595
        8HDibvOKtVWZHLd+Q9pUfeedg=; b=K1TS5pdm72bb1B5Zoofn7nX2AK8/OiH+el
        B+7Uuxd2MSIspJ8dm63XoJqCAM1qVg1IOnGq1yAjShHHRfvamXLaPSJ3E5pTdJJP
        vzujUBcgnX3xXiqP6nYiRm/neHj0/dsQv+8Q+hEqzdshF0nMxGF8yELuFK1OFBmS
        1NCb15HJZDrvFqNvOM6I4phjgoLlbLwK9w13krU8tOSE41BV4Knq8q+OA/do3ZRu
        AyAaA1fbp7e77GoYnQmr2AnmBBCofCgbL3zNbOJ8pmFOWnS+itxDAFsGA35+uKTA
        qezeA2TewRRrfT6XoZpSHvPDahZlWQcwNhXKZTD5rH2gVbSqv0hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=ZqeZhu4KZNeyalY5958HDibvOKtVWZHLd+Q9pUfeedg=; b=X0K4ahxr
        hDvs3DeG++8/bGfqcefEINbeIwrIbsYzdO8YTGpiYRw1U0qXyPn8Qo/akTnCfwXv
        Im2tOCF4fFdI4968WpUcpuo7NyEkk+07T9EsCZbjQZJmDNgMUPHPU9oOs+mFcICu
        K17YOgEPudof+B+8TJ2/M5iu5s9mmkMUOOv78pmF5kCsYOf6M//xQHmMjjmnp62R
        IJ8SY0kKgcj9uT5k9NZlKGBiAyuLdudxzdsDXKh+74vLbb0rd2vZJ5rdkRz7bbiy
        T2mVVsINDEyvjqvQBLHyEE/v/e6wsZ6nvBkybYQ1BnM0qS7cRbYvpLvhZ5SZhoVZ
        7FQ+HuhrI3VdGA==
X-ME-Sender: <xms:kQDUWBX-tTfweteiDE2XtbzpwUtJpa0SyVP5IM258CoHUU65hX4TxA>
X-Sasl-enc: 6iLmP6RuakgFgwVHYaskHTmFNswEqKgThALtsZQERaHx 1490288785
Received: from UltraSam.fritz.box (dslb-178-011-152-076.178.011.pools.vodafone-ip.de [178.11.152.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 169E57E2E3;
        Thu, 23 Mar 2017 13:06:24 -0400 (EDT)
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on
 the file system
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
 <20170317225110.13417-1-sbeller@google.com>
 <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
 <xmqqbmsvx1ey.fsf@gitster.mtv.corp.google.com>
 <20170320185038.GU26789@aiede.mtv.corp.google.com>
 <CACsJy8CBmfj8wY+LQzEshJT0Ya+nmAGs=K8b1Nyr3qinvCo4kA@mail.gmail.com>
 <xmqqvar2ska7.fsf@gitster.mtv.corp.google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <3c16aea8-be53-ef41-d43f-7b4e8ca15d7d@drmicha.warpmail.net>
Date:   Thu, 23 Mar 2017 18:06:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqvar2ska7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 21.03.2017 16:48:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>> On Tue, Mar 21, 2017 at 1:50 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Junio C Hamano wrote:
>>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>>> While it may be true that you can have bare worktrees; I would question
>>>>> why anyone wants to do this, as the only thing it provides is an
>>>>> additional HEAD (plus its reflog).
>>>>
>>>> A more plausible situation is you start with a bare one as the
>>>> primary and used to make local clones to do your work in the world
>>>> before "git worktree".  It would be a natural extension to your
>>>> workflow to instead create worktrees of of that bare one as the
>>>> primary worktree with secondaries with working trees.
>>>
>>> For what it's worth, this conversation makes me think it was a mistake
>>> to call this construct a worktree.
>>
>> For the record, I am totally confused with Junio's last line, with two
>> "with"s, "worktree" and "working trees" in the same phrase :D
> 
> In case this wasn't just a tangential note, what I meant was:
> 
>  - In the old world, you may have had a single bare repository and
>    then made clones, each of which has a working tree (i.e. non-bare
>    clones), and worked inside these clones.
> 
>  - In the "git worktree" world, you can start from that same single
>    bare repository, but instead of cloning it, use "git worktree" to
>    create "worktree"s, each of which has a working tree, and work
>    inside these "worktree"s.
> 
> and the latter would be a natural extension to the workflow the
> former wanted to use.
> 
>>> It's fine for the command to have one name and the documentation to
>>> use a longer, clearer name to explain it.  What should that longer,
>>> clearer name be?
>>
>> No comments from me. I'll let you know that if Eric (or Junio?) didn't
>> stop me, we would have had $GIT_DIR/repos now instead of
>> $GIT_DIR/worktrees, just some extra confusion toppings.
> 
> I forgot about that part of the history, but you are saying you
> wanted to call these "repos", not "worktrees"?  I can see why
> somebody (or me?) would stop that by fearing "repo" is a bit too
> confusing with a "repository", in the same way that we are now
> realizing that "worktree" is too similar to an old synonym we used
> to call "working tree".
> 

I would say the new thing is really a "checkout", but that opens another
can of worms. On the other hand, "git checkout" already does:
- switching of branches
- creation of branches
- detaching of head
- partial updates of the working tree
So why shouldn't it manage worktrees, as well?

While that may sound a bit sarcastic it indicates that we may want to
rethink some things at some point rather than adding up to the
conflation. The discussion in this thread seems to show that "worktree"
is just as a good a name for the new feature, while "workbase" or
"workroot" (or "workdir") or so could have been for the old one.

Are we at a point where we can still rename the new feature at least? If
yes, and keeping everything else is mandatory, than "workspace" or
"working space" may be a serious contender for naming the new thing.

Michael
