Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8211F404
	for <e@80x24.org>; Mon, 12 Feb 2018 05:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750838AbeBLFWW (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 00:22:22 -0500
Received: from mail.javad.com ([54.86.164.124]:47121 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750824AbeBLFWU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 00:22:20 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6DB5F3E926;
        Mon, 12 Feb 2018 05:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518412939;
        bh=VkzNdjtavc6BEVQSBvKjCuf9zGiLYZBVBSheuS8g2mw=; l=4653;
        h=Received:From:To:Subject;
        b=QCGfz+JwumuzMcVB76Ki5GgfP8XQORS0RvFtZj9POQTPz9FoBQpDC1NuaKKSscGK4
         bRQIwZeB9qF/CQHy50dKBLSdNEP4E2DmZqFELbcr1Q+b28EGAGsZdhr4IQT7K+98E7
         bDTqeDL3zXbH9xWiySQaClq4TbJ+gdf59LzYWN98=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518412939;
        bh=VkzNdjtavc6BEVQSBvKjCuf9zGiLYZBVBSheuS8g2mw=; l=4653;
        h=Received:From:To:Subject;
        b=QCGfz+JwumuzMcVB76Ki5GgfP8XQORS0RvFtZj9POQTPz9FoBQpDC1NuaKKSscGK4
         bRQIwZeB9qF/CQHy50dKBLSdNEP4E2DmZqFELbcr1Q+b28EGAGsZdhr4IQT7K+98E7
         bDTqeDL3zXbH9xWiySQaClq4TbJ+gdf59LzYWN98=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518412939;
        bh=VkzNdjtavc6BEVQSBvKjCuf9zGiLYZBVBSheuS8g2mw=; l=4653;
        h=Received:From:To:Subject;
        b=QCGfz+JwumuzMcVB76Ki5GgfP8XQORS0RvFtZj9POQTPz9FoBQpDC1NuaKKSscGK4
         bRQIwZeB9qF/CQHy50dKBLSdNEP4E2DmZqFELbcr1Q+b28EGAGsZdhr4IQT7K+98E7
         bDTqeDL3zXbH9xWiySQaClq4TbJ+gdf59LzYWN98=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518412939;
        bh=VkzNdjtavc6BEVQSBvKjCuf9zGiLYZBVBSheuS8g2mw=; l=4653;
        h=Received:From:To:Subject;
        b=QCGfz+JwumuzMcVB76Ki5GgfP8XQORS0RvFtZj9POQTPz9FoBQpDC1NuaKKSscGK4
         bRQIwZeB9qF/CQHy50dKBLSdNEP4E2DmZqFELbcr1Q+b28EGAGsZdhr4IQT7K+98E7
         bDTqeDL3zXbH9xWiySQaClq4TbJ+gdf59LzYWN98=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1el6ZE-0008Eu-6k; Mon, 12 Feb 2018 08:22:16 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        <874lmqirma.fsf@javad.com>
        <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Mon, 12 Feb 2018 08:22:16 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Sun, 11 Feb 2018 00:06:28 +0100
        (STD)")
Message-ID: <87zi4edbp3.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi Sergey,
>
> On Fri, 9 Feb 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> [...]
>> 
>> > With this patch, the goodness of the Git garden shears comes to `git
>> > rebase -i` itself. Passing the `--recreate-merges` option will generate
>> > a todo list that can be understood readily, and where it is obvious
>> > how to reorder commits. New branches can be introduced by inserting
>> > `label` commands and calling `merge - <label> <oneline>`. And once this
>> > mode has become stable and universally accepted, we can deprecate the
>> > design mistake that was `--preserve-merges`.
>> 
>> This doesn't explain why you introduced this new --recreate-merges. Why
>> didn't you rather fix --preserve-merges to generate and use new todo
>> list format?
>
> Because that would of course break existing users of
> --preserve-merges.

How exactly? Doesn't "--recreate-merges" produce the same result as
"--preserve-merges" if run non-interactively?

> So why not --preserve-merges=v2? Because that would force me to maintain
> --preserve-merges forever. And I don't want to.
>
>> It doesn't seem likely that todo list created by one Git version is to
>> be ever used by another, right?
>
> No. But by scripts based on `git rebase -p`.
>
>> Is there some hidden reason here? Some tools outside of Git that use old
>> todo list format, maybe?
>
> Exactly.
>
> I did mention such a tool: the Git garden shears:
>
> 	https://github.com/git-for-windows/build-extra/blob/master/shears.sh
>
> Have a look at it. It will inform the discussion.

I've searched for "-p" in the script, but didn't find positives for
either "-p" or "--preserve-merges". How it would break if it doesn't use
them? What am I missing?

>
>> Then, if new option indeed required, please look at the resulting manual:
>> 
>> --recreate-merges::
>> 	Recreate merge commits instead of flattening the history by replaying
>> 	merges. Merge conflict resolutions or manual amendments to merge
>> 	commits are not preserved.
>> 
>> -p::
>> --preserve-merges::
>> 	Recreate merge commits instead of flattening the history by replaying
>> 	commits a merge commit introduces. Merge conflict resolutions or manual
>> 	amendments to merge commits are not preserved.
>
> As I stated in the cover letter, there are more patches lined up after
> this patch series.

Good, but I thought this one should better be self-consistent anyway.
What if those that come later aren't included?

>
> Have a look at https://github.com/git/git/pull/447, especially the latest
> commit in there which is an early version of the deprecation I intend to
> bring about.

You shouldn't want a deprecation at all should you have re-used
--preserve-merges in the first place, and I still don't see why you
haven't. 

>
> Also, please refrain from saying things like... "Don't you think ..."
>
> If you don't like the wording, I wold much more appreciate it if a better
> alternative was suggested.

Sorry, but how can I suggest one if I don't understand what you are
doing here in the first place? That's why I ask you.

>
>> Don't you think more explanations are needed there in the manual on
>> why do we have 2 separate options with almost the same yet subtly
>> different description? Is this subtle difference even important? How?
>> 
>> I also have trouble making sense of "Recreate merge commits instead of
>> flattening the history by replaying merges." Is it "<Recreate merge
>> commits by replaying merges> instead of <flattening the history>" or is it
>> rather "<Recreate merge commits> instead of <flattening the history by
>> replaying merges>?
>
> The documentation of the --recreate-merges option is not meant to explain
> the difference to --preserve-merges. It is meant to explain the difference
> to regular `git rebase -i`, which flattens the commit history into a
> single branch without merge commits (in fact, all merge commits are simply
> ignored).

Yeah, that's obvious, but the point is that resulting manual is ended
up being confusing.

> And I would rather not start to describe the difference between
> --recreate-merges and --preserve-merges because I want to deprecate the
> latter, and describing the difference as I get the sense is your wish
> would simply mean more work because it would have to be added and then
> removed again.

I suspect you actually didn't need those new option in the first place,
and that's the core reason of these troubles.

-- Sergey
