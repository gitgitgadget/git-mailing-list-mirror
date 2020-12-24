Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCF4C433DB
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A6C22518
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgLXWyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 17:54:49 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:19747 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbgLXWyt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 17:54:49 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4D253d3rB6z5tlC;
        Thu, 24 Dec 2020 23:54:05 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 731A620EE;
        Thu, 24 Dec 2020 23:54:04 +0100 (CET)
Subject: Re: Git Feature Request (Fixdown in interactive rebase)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mike McLean <stixmclean@googlemail.com>, git@vger.kernel.org
References: <CAM0jFOeCE-iTAMkiGE6m8bVNjJRn-BUmbUAP2ANrj4FbhuQG=g@mail.gmail.com>
 <CAM0jFOdCD1uEcHaPB_go7aarapEBKx6M4d35zVOP8h9=MuZEmA@mail.gmail.com>
 <xmqqczz05b4x.fsf@gitster.c.googlers.com>
 <CAM0jFOfSE3_TQ7WXiR_G6eHOZnr-0ryv=CniXs4sxs1=JnucUg@mail.gmail.com>
 <ab835195-0c69-830b-c7cb-71d50b4ce4db@kdbg.org>
 <xmqq8s9m3kx4.fsf@gitster.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7b5ad849-ca6c-a462-fdef-c06f8511d946@kdbg.org>
Date:   Thu, 24 Dec 2020 23:54:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq8s9m3kx4.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.12.20 um 23:21 schrieb Junio C Hamano:
> I wonder if we deliberately designed how each insn you can write in
> the todo list should come up with the authorship data (i.e. ident
> and timestamp), or if we are just using the natural consequence of
> how the implementation happens to work?  I think it makes sense for
> "fixup", as an instruction used to make a small tweak to the bulk of
> work you've done some time ago, to use the authorship information of
> the original commit that gets fixed up. I don't know offhand what
> other insns like "edit", "reword", etc. do, and if there is a room
> to improve them.

For 'squash' it was a deliberate decision to keep authorship of the
first commit, see 81ab1cb43a87. Initially, 'edit' changed authorship
including the date to the current author and date; that was changed to
preserve them, but I cannot find the responsible commit.

-- Hannes
