Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63F920989
	for <e@80x24.org>; Mon, 10 Oct 2016 16:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbcJJQqo (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 12:46:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65014 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752971AbcJJQqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 12:46:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EBAE45E20;
        Mon, 10 Oct 2016 12:46:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r3JKhGdblUGe+Fk/eKu0Tb617+E=; b=w/lKdv
        XiYCo1VhNqqV3PXvA4h1CJkjzuIpj1qIfzWdeWswNPKMpr89Iy2Rj1y51XvvIXZU
        Buh9V/FUcVq4zuJkU2JuB1iDS5pJocvEiAsZm1trz3IkVhtOUAOI3Ec/uufuoPyS
        YrDA2Yjd6mgpTTW1XFli9XSZSVAWeDRd4KBos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qsDbMskyu0VBI4DTrA+7zaXMzOOMamrg
        7ZXZ3r/mcwLGO+J7wS+YopESv5XEicD9KyRFHqda4J4k+Ox8n3y6kgZQJTwFmNyd
        D8KpFx41Zu2GDm+pGrnITzjLO5+yF8kv9cbOsAOpd41IMUc0CnnpXQ1WN1KWORoK
        53k4xobfXtU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84F1145E1F;
        Mon, 10 Oct 2016 12:46:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBBE845E1D;
        Mon, 10 Oct 2016 12:46:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] t4014-format-patch: Adjust git_version regex to better handle distro changes to DEF_VER
References: <20161010025323.9415-1-jeremyhu@apple.com>
        <20161010131041.lpdh4a7nol24hsz2@sigill.intra.peff.net>
Date:   Mon, 10 Oct 2016 09:46:39 -0700
In-Reply-To: <20161010131041.lpdh4a7nol24hsz2@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 10 Oct 2016 09:10:41 -0400")
Message-ID: <xmqqh98kgnio.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F0310CA-8F09-11E6-9FB1-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Oct 09, 2016 at 07:53:23PM -0700, Jeremy Huddleston Sequoia wrote:
>
>> Subject: Re: [PATCH] t4014-format-patch: Adjust git_version regex to better
>>  handle distro changes to DEF_VER
>>
>> Regressed-in: 480871e09ed2e5275b4ba16b278681e5a8c122ae
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>
> I see there was a discussion elsewhere on the list about exactly what
> you are putting into DEF_VAR that causes the problem. Perhaps the commit
> message here would be a good place to mention that, why the current
> regex breaks it, and why your new version fixes not only it, but other
> possible values of DEF_VAR.

Ah, should have known that you'd already be helping with this.
Thanks.
