Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18ABF1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 14:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeCNOYk (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 10:24:40 -0400
Received: from mail.javad.com ([54.86.164.124]:52517 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750827AbeCNOYj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 10:24:39 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 580983E89A;
        Wed, 14 Mar 2018 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521037478;
        bh=e4mn7Nzo8ELTbus8fNby/zg4THNIWtV2MoC96LfFj0c=; l=1653;
        h=Received:From:To:Subject;
        b=fVNkCEsr2pOuABy07BdTh6mNvxl6fCjf5moASO3usYF5JRyXm3XJKyItGwp3H3XTt
         FBGFpMcP8iB7jHhct/W5S4MvKRGcEquPYH3/rL8f35cmwYjvFuLBrBDWFl6w/Uf98T
         DXLZwYUMy6Yc4bQsjNyvXT5e4CB+fAsrZNh9Jr4M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521037478;
        bh=e4mn7Nzo8ELTbus8fNby/zg4THNIWtV2MoC96LfFj0c=; l=1653;
        h=Received:From:To:Subject;
        b=fVNkCEsr2pOuABy07BdTh6mNvxl6fCjf5moASO3usYF5JRyXm3XJKyItGwp3H3XTt
         FBGFpMcP8iB7jHhct/W5S4MvKRGcEquPYH3/rL8f35cmwYjvFuLBrBDWFl6w/Uf98T
         DXLZwYUMy6Yc4bQsjNyvXT5e4CB+fAsrZNh9Jr4M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521037478;
        bh=e4mn7Nzo8ELTbus8fNby/zg4THNIWtV2MoC96LfFj0c=; l=1653;
        h=Received:From:To:Subject;
        b=fVNkCEsr2pOuABy07BdTh6mNvxl6fCjf5moASO3usYF5JRyXm3XJKyItGwp3H3XTt
         FBGFpMcP8iB7jHhct/W5S4MvKRGcEquPYH3/rL8f35cmwYjvFuLBrBDWFl6w/Uf98T
         DXLZwYUMy6Yc4bQsjNyvXT5e4CB+fAsrZNh9Jr4M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521037478;
        bh=e4mn7Nzo8ELTbus8fNby/zg4THNIWtV2MoC96LfFj0c=; l=1653;
        h=Received:From:To:Subject;
        b=fVNkCEsr2pOuABy07BdTh6mNvxl6fCjf5moASO3usYF5JRyXm3XJKyItGwp3H3XTt
         FBGFpMcP8iB7jHhct/W5S4MvKRGcEquPYH3/rL8f35cmwYjvFuLBrBDWFl6w/Uf98T
         DXLZwYUMy6Yc4bQsjNyvXT5e4CB+fAsrZNh9Jr4M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521037478;
        bh=e4mn7Nzo8ELTbus8fNby/zg4THNIWtV2MoC96LfFj0c=; l=1653;
        h=Received:From:To:Subject;
        b=fVNkCEsr2pOuABy07BdTh6mNvxl6fCjf5moASO3usYF5JRyXm3XJKyItGwp3H3XTt
         FBGFpMcP8iB7jHhct/W5S4MvKRGcEquPYH3/rL8f35cmwYjvFuLBrBDWFl6w/Uf98T
         DXLZwYUMy6Yc4bQsjNyvXT5e4CB+fAsrZNh9Jr4M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521037478;
        bh=e4mn7Nzo8ELTbus8fNby/zg4THNIWtV2MoC96LfFj0c=; l=1653;
        h=Received:From:To:Subject;
        b=fVNkCEsr2pOuABy07BdTh6mNvxl6fCjf5moASO3usYF5JRyXm3XJKyItGwp3H3XTt
         FBGFpMcP8iB7jHhct/W5S4MvKRGcEquPYH3/rL8f35cmwYjvFuLBrBDWFl6w/Uf98T
         DXLZwYUMy6Yc4bQsjNyvXT5e4CB+fAsrZNh9Jr4M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1521037478;
        bh=e4mn7Nzo8ELTbus8fNby/zg4THNIWtV2MoC96LfFj0c=; l=1653;
        h=Received:From:To:Subject;
        b=fVNkCEsr2pOuABy07BdTh6mNvxl6fCjf5moASO3usYF5JRyXm3XJKyItGwp3H3XTt
         FBGFpMcP8iB7jHhct/W5S4MvKRGcEquPYH3/rL8f35cmwYjvFuLBrBDWFl6w/Uf98T
         DXLZwYUMy6Yc4bQsjNyvXT5e4CB+fAsrZNh9Jr4M=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1ew7KW-000487-Lk; Wed, 14 Mar 2018 17:24:36 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
        <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com>
Date:   Wed, 14 Mar 2018 17:24:36 +0300
In-Reply-To: <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com> (Igor
        Djordjevic's message of "Thu, 8 Mar 2018 16:16:33 +0100")
Message-ID: <87vadyd9az.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> Hi Dscho,
>
> On 07/03/2018 08:26, Johannes Schindelin wrote:

[...]

>> Second side note: if we can fast-forward, currently we prefer that, and I
>> think we should keep that behavior with -R, too.
>
> I agree.

I'm admittedly somewhat lost in the discussion, but are you talking
fast-forward on _rebasing_ existing merge? Where would it go in any of
the suggested algorithms of rebasing and why?

I readily see how it can break merges. E.g., any "git merge --ff-only
--no-ff" merge will magically disappear. So, even if somehow supported,
fast-forward should not be performed by default during _rebasing_ of a
merge.

>> If the user wants to force a new merge, they simply remove that -R
>> flag.

Alternatively, they'd replace 'pick' with 'merge', as they already do
for other actions. "A plurality is not to be posited without necessity".

Please, _please_, don't use 'merge' command to 'pick' merge commits!
It's utterly confusing!

Thinking about it I've got an idea that what we actually need is
--no-flatten flag that, when used alone, will just tell "git rebase" to
stop flattening history, and which will be implicitly imposed by
--recreate-merges (and --preserve-merges).

Then the only thing the --recreate-merges will tune is to put 'merge'
directives into the todo list for merge commits, exactly according to
what its name suggests, while the default behavior will be to put 'pick'
with suitable syntax into the todo. And arguments to the
--recreate-merge will specify additional options for the 'merge'
directive, obviously.

-- Sergey
