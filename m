Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3510C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A327564E40
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhBBUVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 15:21:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55922 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhBBUTX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 15:19:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 537989DA3A;
        Tue,  2 Feb 2021 15:18:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t7/4VUi81uqDxW0rgLQXxOD2ZLs=; b=Vzqkt6
        T/fMzZ/w6CR/Ppn7N0xeO34xpaTjZDygHnPYCVm+6vV4/g3AXtZSV6THMbh5fdKH
        +upCIqfgd07D7qhCt8p3742xZp91M0mGtJ9ZvIkDe0KHXzSIg2u9YQNThEJSPYFS
        JCyYTeCfnZZ2ukeCbkDq+07KWYLuJ9cEkn1SI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OiwGqfAi/GwE4PAbjrVfn4hEl2oXrzyK
        saxhwGQa3RP3Pkp2McpIdB3NrfAUPTSnLtdqdWN9GLqd0eEUaqmJ3RZAFavFUcHp
        um9thIkdsUDd15G7/EXnwAsZLk2OZ7OZwlNs91BzMVPVD4v1NjdDZaMqk0RClnkI
        /92DWL5vMRA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B2539DA37;
        Tue,  2 Feb 2021 15:18:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5BD49DA36;
        Tue,  2 Feb 2021 15:18:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
        <87lfc8ocmt.fsf@evledraar.gmail.com>
        <xmqqy2g8mubh.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2102021652350.54@tvgsbejvaqbjf.bet>
Date:   Tue, 02 Feb 2021 12:18:39 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2102021652350.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 2 Feb 2021 16:54:56 +0100 (CET)")
Message-ID: <xmqqy2g6fckg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6803D12-6593-11EB-BCDF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'll give you a reason. We're not really strong on the inclusion front,
> and translations are one thing that we actually do right on that end.
> Removing even the scant testing of translated messages that we do have
> strikes me as the opposite of improving the situation.

If you are adding something that helps to encourage translation,
that is totally a different story, and I thought that perhaps the
rot13 stuff would be a good starting point for that.

But I do not think keeping the fixed "### GETTEXT POISIN ###" would
contribute to that very much.  Keeping a "framework" that does not
help to encourage translation and pretending that we have something,
and complaining about its removal, is the opposite of helping wider
translation.
