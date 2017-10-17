Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C857F1FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 20:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757986AbdJQUzW (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 16:55:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54816 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754052AbdJQUzV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 16:55:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4E829A60F;
        Tue, 17 Oct 2017 16:55:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WPL7HbRwj+JEjEOVKN4+BEL4KwE=; b=BXbhCX
        ssa/EKgE2VeIAVrm+tFxxsJl7t13bP+kkEnWtDuJkFF36zexc98co6GH4eWN/gCy
        oZhRqTwKK3h66JEQ3ZMqU+5tU655WvZnK4kQyKKgh/mrYWMQ6FMxH0kfn/uAiR/T
        sHKSGS/1O5MVl1bijleSggwqJEuvFn8u/xt8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vK6gfefwVM7qTVyrF84p0kMBsL6BtgyX
        HdUed+XKQQdgRf7VFYDtGJ9FSdZmI0lHNBKR+69SeKz2HWllvTc2CXuGfHujua9v
        i6euqsWBINcklyLqYkjTc02ea64QCfaerunsQtW/PJ5DJ1Mv47Gq+jE1a5rgrCNZ
        m8VKznDO748=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAC079A60E;
        Tue, 17 Oct 2017 16:55:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2619B9A60A;
        Tue, 17 Oct 2017 16:55:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] check-ref-format doc: --branch validates and expands <branch>
References: <20170717172709.GL93855@aiede.mtv.corp.google.com>
        <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
        <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
        <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
        <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
        <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
        <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
        <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com>
        <xmqq7evupemj.fsf@gitster.mtv.corp.google.com>
        <20171017070619.bdgvujmbw4uxvwle@aiede.mtv.corp.google.com>
        <20171017071234.m6j4rqn6izdvla6d@aiede.mtv.corp.google.com>
Date:   Wed, 18 Oct 2017 05:55:18 +0900
In-Reply-To: <20171017071234.m6j4rqn6izdvla6d@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Tue, 17 Oct 2017 00:12:34 -0700")
Message-ID: <xmqq60bdo5op.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CA7C998-B37D-11E7-BB32-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> "git check-ref-format --branch $name" feature was originally
> introduced (and was advertised) as a way for scripts to take any
> end-user supplied string (like "master", "@{-1}" etc.) and see if it
> is usable when Git expects to see a branch name, and also obtain the
> concrete branch name that the at-mark magic expands to.
>
> Emphasize that "see if it is usable" role in the description and
> clarify that the @{...} expansion only occurs when run from within a
> repository.
>
> [jn: split out from a larger patch]
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Missing sign-off, unlike the other two, intended?

I'll take these three to replace what I tentatively queued, not
necessarily because I like the change in 1/3 better, but because
these are explained much better; besides I prefer a version that at
least two people deeply looked at.

Thanks.
