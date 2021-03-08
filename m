Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969DBC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE3D6528A
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhCHU62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:58:28 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33126 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCHU6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:58:01 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DvVzV1hlrz1qs39;
        Mon,  8 Mar 2021 21:57:58 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DvVzV1DBKz1qqkW;
        Mon,  8 Mar 2021 21:57:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id pMera3PJmZdZ; Mon,  8 Mar 2021 21:57:57 +0100 (CET)
X-Auth-Info: sdJSlsVDsI1vKzcgnq6RJpQZkgK0cu6m2/avxK5UE3pLvVz8b4k7D2Nksd2pZdBB
Received: from igel.home (ppp-46-244-182-153.dynamic.mnet-online.de [46.244.182.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  8 Mar 2021 21:57:57 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id C23442C37BB; Mon,  8 Mar 2021 21:57:56 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Fabien Terrani <terranifabien@gmail.com>, git@vger.kernel.org
Subject: Re: remote.<name>.merge missing from the git-config man page?
References: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
        <xmqqlfax7dya.fsf@gitster.c.googlers.com>
        <YEZwY0721KvQNkK+@nand.local> <87pn092yja.fsf@igel.home>
        <YEaI5JIobsbtBQO1@nand.local> <87lfax2xat.fsf@igel.home>
        <YEaM7ruZCvaQQbPI@nand.local>
X-Yow:  I'm CONTROLLED by the CIA!!  EVERYONE is controlled by the CIA!!
Date:   Mon, 08 Mar 2021 21:57:56 +0100
In-Reply-To: <YEaM7ruZCvaQQbPI@nand.local> (Taylor Blau's message of "Mon, 8
        Mar 2021 15:45:34 -0500")
Message-ID: <87h7ll2wiz.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mär 08 2021, Taylor Blau wrote:

> On Mon, Mar 08, 2021 at 09:41:14PM +0100, Andreas Schwab wrote:
>> >> >  `git push origin`::
>> >> >  	Without additional configuration, pushes the current branch to
>> >> > -	the configured upstream (`remote.origin.merge` configuration
>> >> > +	the configured upstream (`branch.<name>.merge` configuration
>> >> >  	variable) if it has the same name as the current branch, and
>> >> >  	errors out without pushing otherwise.
>> >>
>> >> That doesn't say what <name> is.  Is that supposed to be <branch>?
>> >> Also, what is "it" referring to in "if it has the same name"?
>> >
>> > <name> refers to the currently-checked-out branch's local name. (That's
>> > how it's used in Documentation/config/branch.txt).
>> >
>> > The antecedent is "the current branch", so I think that this one may
>> > already be quite clear if you read past the parenthesis.
>>
>> That doesn't make sense: "if the current branch has the same name as the
>> current branch".
>
> OK, now I see where your confusion is. I was incorrect in saying the
> antecedent was "the current branch"; it should instead by "the
> configured upstream". IOW, "if both your and the remote copy call the
> branch you have checked out the same thing."

The configured upstream is the value of branch.<name>.merge, isn't it?
That would be the name of a remote, not the name of a branch.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
