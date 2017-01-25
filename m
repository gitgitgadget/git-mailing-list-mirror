Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 174301F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbdAYVU3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:20:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60343 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750930AbdAYVU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:20:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8D9464146;
        Wed, 25 Jan 2017 16:20:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o20rWdtlZbOx+gMBE5QXi4ieWnQ=; b=u6JuEG
        Ah5UYThdVsT/iwMXLn3i4it5HsFwWOn666lB1wGlT3y0u97W+pAdEhTbDcO0Swwe
        u52kc4jJzrb90k85yTLv6cWlgckhf2VT0HKq6IiLQq7eR3reTo5gpTY6VxxS4dUa
        TeR0sQAfUQeUgmPauKrzJ683UjH/IGqdHzQ44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G7A+kj0m6hY/XQsXH0DgBiyilamJXNKY
        jkYPYvaMUBHc8AvzJpw4W8qjdJOiTv3ZTtidGBnFMx2HUjRPAHWIhG/r9P3maeEY
        rdCW8kb9FXSTqMc98iP0f/TUBKigBedG/h9A+TdFgGIdPhhApez4xpSol7yFaMMK
        L1h1kQcX1Vw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFC2E64144;
        Wed, 25 Jan 2017 16:20:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3723864143;
        Wed, 25 Jan 2017 16:20:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Documentation/stash: remove mention of git reset --hard
References: <20170121200804.19009-1-t.gummerer@gmail.com>
        <20170121200804.19009-2-t.gummerer@gmail.com>
        <20170124201415.zzyg4vt35vflwjnb@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 13:20:25 -0800
In-Reply-To: <20170124201415.zzyg4vt35vflwjnb@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 24 Jan 2017 15:14:15 -0500")
Message-ID: <xmqqfuk6alba.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1782B9D8-E344-11E6-B10B-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jan 21, 2017 at 08:08:02PM +0000, Thomas Gummerer wrote:
>
>> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
>> index 2e9cef06e6..0ad5335a3e 100644
>> --- a/Documentation/git-stash.txt
>> +++ b/Documentation/git-stash.txt
>> @@ -47,8 +47,9 @@ OPTIONS
>>  
>>  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
>>  
>> -	Save your local modifications to a new 'stash', and run `git reset
>> -	--hard` to revert them.  The <message> part is optional and gives
>> +	Save your local modifications to a new 'stash', and revert the
>> +	the changes in the working tree to match the index.
>> +	The <message> part is optional and gives
>
> Hrm. "git reset --hard" doesn't just make the working tree match the
> index. It also resets the index to HEAD.  So either the original or your
> new description is wrong.
>
> I think it's the latter. We really do reset the index unless
> --keep-index is specified.

Correct.  So the patch is a net loss.  Perhaps not requiring readers
to know "reset --hard" might be an improvement (I personally do not
think so), but this loses crucial information from the description.

	Save your local modifications (both in the working tree and
	to the index) to a new 'stash', and resets the index to HEAD
	and makes the working tree match the index (i.e. runs "git
	reset --hard").

That's one-and-a-half lines longer than the original, though.
