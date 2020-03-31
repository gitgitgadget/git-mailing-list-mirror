Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9056C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 10:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BFD20772
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 10:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgCaK5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:57:22 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:61817 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730378AbgCaK5W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 06:57:22 -0400
Received: from [92.30.123.115] (helo=[192.168.1.38])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jJEa8-000AE6-EX; Tue, 31 Mar 2020 11:57:20 +0100
Subject: Re: Feature request: rebase -i inside of rebase -i
To:     George Spelvin <lkml@SDF.ORG>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com> <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <20200328163024.GA26885@SDF.ORG> <20200331000018.GD9199@SDF.ORG>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <7fbe0ddc-74a3-b6b5-09b1-bff171382d0e@iee.email>
Date:   Tue, 31 Mar 2020 11:57:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331000018.GD9199@SDF.ORG>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi george,

On 31/03/2020 01:00, George Spelvin wrote:
> Thinking about Philip Oakley's suggestion, it dawned on me that
> we can *already* do a nested rebase manually, and having a less
> manual alias for the procedure would be reasonable.
>
> Suppose the last four commits are O-A-B-C, and whether they were created 
> by this rebase or existed before is irrelevant.
>
> If I want to rebase --nested -i O, then I --edit-todo and

Maybe `--rework` as a possible alternate option name, if the concept of
it being truly nested process does not work out?

> prepend the following four lines:
> reset O
> pick A
> pick B
> pick C
>
> If a nested rebase command does just that, I think it would cover my
> use case.  If it adds a comment saying "nested rebase ends here",
> it's easy to cancel the nested rebase if there was a mistake.
>
> A slightly fancier thing a nestrd rebase could do is see if any of the 
> newly created picks are also used in merges that were already in the todo 
> list.  In that case, follow the pick by a label command and update the 
> later merge to refer to the label.

