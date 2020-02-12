Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB42BC35242
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 02:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF762082F
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 02:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ogq2dugi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBLCUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:20:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60915 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgBLCT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 21:19:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9EDA462CB;
        Tue, 11 Feb 2020 21:19:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G1kPEDb5gGJCe0KI/Yqz8aVYcPs=; b=ogq2du
        giJjPJIV6WNk4Um+tHUAdbZSzLEiPbMi/EQHX4jG3lgooBnzjqA4YpLCvV/irmtx
        ZbOmd5Nb5/2eitPcPmWBJfK1rmeZu6nM2w9WnqLVNR/sk2TBmBFPhvcCSuvoEiec
        RFg1zSZyrqaTpsryyT7TqMaaY62SOx02kCiqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xl4zipgwIdFvLhbh+Q2YMeA23PBQh4Ci
        zqkiEZlU3cVX0fE09c9fcVSSBfuMIUNqejRaXG2W94RKXOXBRHpOBEJdSTbEumoa
        oyjIIG5kDeDNl0edPV1qwvoba+AqptzoLlxuHTDAwdkfocJVvdOe0Z2/bpjjVZSW
        GW7aM7/VPfk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2C71462CA;
        Tue, 11 Feb 2020 21:19:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12690462C9;
        Tue, 11 Feb 2020 21:19:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/ci-squelch-doc-warning, was Re: What's cooking in git.git (Feb 2020, #02; Mon, 10)
References: <xmqqmu9qxej1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2002120036570.3718@tvgsbejvaqbjf.bet>
Date:   Tue, 11 Feb 2020 18:19:56 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2002120036570.3718@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 12 Feb 2020 00:39:29 +0100
        (CET)")
Message-ID: <xmqqk14sv96b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A483FEA-4D3E-11EA-B5AC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 10 Feb 2020, Junio C Hamano wrote:
>
>> * js/ci-squelch-doc-warning (2020-02-10) 1 commit
>>  - ci: ignore rubygems warning in the "Documentation" job
>>
>>  Squelch unhelpful warning message during documentation build.
>>
>>  Will merge to 'next'.
>
> To be clear, this _is_ a warning message, but the CI builds are _failing_
> because of it (the "Documentation" job expects `stderr` to be clean except
> for some known warnings).
>
> As a consequence, all the PR builds at https://github.com/git/git are
> failing (except for PRs targeting `pu` or `next`, but I don't think that
> there are currently any).
>
> So maybe we could fast-track this change all the way into `maint`?

Don't worry.  As it only affects the doc builds and nothing else,
there is no need to rush, but unlike topics that update end-user
experience (for which, the minimum gestation periods are 1 day
outside 'next' and 7 days in 'next' before hitting 'master'),
obvious and trivial docfixes and developer support topics are
usually fast-tracked by often immediately hitting 'next' and
spending as few as 2 days in 'next'.  I think this is one of these
topics.



