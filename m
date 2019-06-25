Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CEB11F461
	for <e@80x24.org>; Tue, 25 Jun 2019 01:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfFYBnt (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 21:43:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51071 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfFYBnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 21:43:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCDB368723;
        Mon, 24 Jun 2019 21:43:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=go4im5s94nE22Kvpvw2B5eecf3g=; b=LCgKtJ
        Qkdt9aGT6r3QZZTcEuFxXm5tAqwYOOBfAVbWw9Rdix9nq/1bWPZuiuagcrAkS6ql
        5S5bldseeWKC+HxNcqDEmXdDRSsFFSFXOG/t1bdTTS7KeN5li8Xf423YqpLfspGD
        Y0BTubc+3ABE+LW12GM+0gOf4vcoxlszU5+5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jrdj2hCx2gdyczI9zphBWcnbfgnf8mSk
        yRPGwIyrxleepwkNNjsvJGZ5PG0AoYB8Ti6c+kPIKqhJJZMS39KZELCQEhjfn8tL
        dChbsUsbutu8BRXDgN4FiwtyDAoyWK8rjSUpNfif7F0zDlIBA6qbjHjcdTV4wEJe
        xC+0H5lLiWw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4CDF68722;
        Mon, 24 Jun 2019 21:43:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F12D96871F;
        Mon, 24 Jun 2019 21:43:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 14/14] completion: add default merge strategies
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
        <20190621223107.8022-15-felipe.contreras@gmail.com>
        <xmqq5zouj3rl.fsf@gitster-ct.c.googlers.com>
        <CAMP44s0y_3Ltv_hnoVByTRwZrDU0+PfRo3R=Lxm6wDk+=sypJg@mail.gmail.com>
Date:   Mon, 24 Jun 2019 18:43:43 -0700
In-Reply-To: <CAMP44s0y_3Ltv_hnoVByTRwZrDU0+PfRo3R=Lxm6wDk+=sypJg@mail.gmail.com>
        (Felipe Contreras's message of "Mon, 24 Jun 2019 20:11:40 -0500")
Message-ID: <xmqq1rzih228.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABC834E0-96EA-11E9-989B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Jun 24, 2019 at 12:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>> > In case the command fails.
>>
>> It is unclear what you wanted to say with this.  What command?
>> After "git merge" fails?
>
> Yes. The command that __git_list_merge_strategies() uses.

Next round, write that in the proposed log message, please.  An
issue in the proposed commit log message that puzzles reviewers is
something we expect future readers of "git log" to also stumble on.

>  % cd /tmp
>  % git merge -s help
> fatal: not a git repository (or any parent up to mount point /)
> Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).

I think the recent <20190612085606.12144-1-pclouds@gmail.com>
established a good pattern we should follow; when a command we run
to get list of things to use in completion fails, we refrain from
caching that broken output, and arrange so that we will try again.
It looks to me that "git merge -s help" barfing outside a repository
is a good candidate to follow that pattern.  Outside a repository,
the user will not be able to perform a merge with any strategy, so
not completing the command line when the user say "git merge -s
<TAB>" outside a repository is not the end of the world, as long as
we follow the right codepath to grab the available strategies once
the user goes into a repository where "git merge -s help" works, no?

Thanks.
