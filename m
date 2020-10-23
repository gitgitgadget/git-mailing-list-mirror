Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478B9C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40EA2168B
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463021AbgJWSI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:08:57 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:64586 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409403AbgJWSI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 14:08:56 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4CHsgC2KfDz5tlD;
        Fri, 23 Oct 2020 20:08:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4E51317FA;
        Fri, 23 Oct 2020 20:08:53 +0200 (CEST)
Subject: Re: [PATCH] apply: clarify description of --index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqzh4dk3ey.fsf@gitster.c.googlers.com>
 <23806f2c-df96-b105-3b85-f40b0e8ec7ca@kdbg.org>
 <xmqqzh4dhurk.fsf@gitster.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <92f3ec02-14f2-482c-5754-5bff0db9d634@kdbg.org>
Date:   Fri, 23 Oct 2020 20:08:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqzh4dhurk.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.10.20 um 16:38 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>>> -	Apply the patch to both the index and the working tree (or
>>> -	merely check that it would apply cleanly to both if `--check` is
>>> -	in effect). Note that `--index` expects index entries and
>>> -	working tree copies for relevant paths to be identical (their
>>> -	contents and metadata such as file mode must match), and will
>>> -	raise an error if they are not, even if the patch would apply
>>> -	cleanly to both the index and the working tree in isolation.
>>> +	After making sure the paths the patch touches in the working
>>> +	tree have no modifications relative to their index entries,
>>> +	apply the patch both to the index entries and to the working
>>> +	tree files or see if it applies	cleanly, when `--check` is in
>>> +	effect.
>>
>> I don't think that this is an improvement. The purpose of --index *is*
>> to apply the patch to both index and worktree, and that should be
>> mentioned first. The check that both are identical, is a prerequisite
>> and not the primary objective of the option.
> 
> Yeah, but this was an attempt to clarify what that "apply to both",
> which is the central part of the operation, exactly means.
> 
> The only mode of operation we offer is that we start from identical
> index and working tree, and make the same change so that we arrive
> at the same outcome.  It is not like you can have some changes in
> the working tree file as long as they do not overlap and collide
> with the incoming patch, make the same change with the patch to
> arrive at different contents as the outcome.  We explicitly forbid
> that, but "apply to both" does not exactly tell it to the readers.

Your have point that the original text muddies the preconditions a bit,
but I still think that "what it does" must be the first thing to be
mentioned, and the preconditions the second.

-- Hannes
