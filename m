Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25187C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 20:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiGUUPh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 16:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGUUPf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 16:15:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5552BB23
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 13:15:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5984F136DA5;
        Thu, 21 Jul 2022 16:15:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=D+jBG5KRDd7V
        05dKK0kH4eyQ0KKKgTNrBV+L0wbbtD0=; b=USu0JL32qwGGp8WWZtnRaxTx351Z
        BMcgoqVceOW98SmW4qD42fdP+0PrQYY24VTrIxb5JvdngORtej/DLSEt9MQgbtw5
        MW4TE9NY7csLFooow6+qzVDERPPimVQPo6poSHaAfeGt10Iyop5LKU1FlrEKud8q
        JhngibPxt6AKrqs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C8D8136DA4;
        Thu, 21 Jul 2022 16:15:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AFAC9136DA3;
        Thu, 21 Jul 2022 16:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: re-mentioning --preserve-merges in the docs
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
        <2d7a4a2c564aaafbf8da97cf017766163c77b70b.1631048713.git.gitgitgadget@gmail.com>
        <220721.86wnc6s2uh.gmgdl@evledraar.gmail.com>
Date:   Thu, 21 Jul 2022 13:15:31 -0700
In-Reply-To: <220721.86wnc6s2uh.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Jul 2022 21:02:14 +0200")
Message-ID: <xmqqwnc6fcik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DF93CC6E-0931-11ED-B57D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Sep 07 2021, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> [...]
>> --p::
>> ---preserve-merges::
>> -	[DEPRECATED: use `--rebase-merges` instead] Recreate merge commits
>> -	instead of flattening the history by replaying commits a merge commi=
t
>> -	introduces. Merge conflict resolutions or manual amendments to merge
>> -	commits are not preserved.
>
> [In reply to an old commit]
>
> I opened "man git-rebase" today due to an on-list discussion and went
> through pretty much:
>
>  1. /preserve-merges # fails
>  2. skimming the SYNOPSIS, forgetting what the new thing is called
>  3. Paging down, eventually findinging & remembering the new thing is
>     "--rebase-merges".
>
> I wonder if there's objections to reinstating this in the docs
> somewhere, just as something like:
>
> 	--preserve-merges:
> 		An old "rebase" backend which is no longer supported,
> 		and which was removed from git in version v2.35.0.
>
> We don't do that with all flags that we've dropped, but perhaps this on=
e
> was well known enough to not leave readers hanging...

My impression is that we consider that we have done so already for a
few releases by keeping "DEPRECATED: use rebase-merges", exactly
because "this one was well known enough", and now it is time to go
one step further, i.e. drop it from the document like the quoted
patch does, while recognising an attempt to use the option and
giving a custom message than the bog-standard "unknown option".

    $ git rebase --preserve-merges
    fatal: --preserve-merges was replaced by --rebase-merges
    Note: Your `pull.rebase` configuration may also be set to 'preserve',
    which is no longer supported; use 'merges' instead

The next step will be to drop that custom error support, I think.
