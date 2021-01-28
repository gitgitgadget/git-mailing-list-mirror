Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BACAC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E9264D99
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhA1GjR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:39:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57626 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhA1GjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:39:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA455124CD8;
        Thu, 28 Jan 2021 01:38:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZEVBRRxWUhnuPQ0cO106XDy6FOQ=; b=aoZZed
        FnlH2kl8Mh4vpPoENaXbW7HqdWvo0PJjsxwkCExdDHU7b/zqpS3ticVxceV/pWQb
        ZlUosWfyapjkaeUT9phM9Ntfc+mMsNn96gyHZgghwflPhraH17VPH3Q8fdOXQhai
        texo36uhlieY3F2b3rpwvyikdNDX8WSFZBegw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F632FMHi/RE2GULQphgKNJQXgXxN6HCS
        2+EPeNswjraNL3+A9jOtjBRdyfFLPQmYoVvu1wXd2sEaSVCqawrGfaOJgNG+3vD4
        apAc6ma2DqaVTaHKgnLi9vc5fqmekB4EeQQDhDGL7jvSx7PLloQjKZ51jD/dLCy+
        zsed5ewWVvU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D3C8E124CD7;
        Thu, 28 Jan 2021 01:38:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 25DF3124CD6;
        Thu, 28 Jan 2021 01:38:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] rerere: use strmap to store rerere directories
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
        <YBJXYMFu8dhOabDv@coredump.intra.peff.net>
Date:   Wed, 27 Jan 2021 22:38:31 -0800
In-Reply-To: <YBJXYMFu8dhOabDv@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 28 Jan 2021 01:19:12 -0500")
Message-ID: <xmqqzh0twopk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70FB7E34-6133-11EB-BAED-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 03, 2020 at 11:28:14AM -0500, Jeff King wrote:

Curiously, the reference of the message points at the cover letter
of this series, and there is no mention of a message from early last
December.

I think this is good.  These "conflict IDs" are not even object
names, so it would be strange to use "struct object_id" for them
(for that matter, packfile ids are not object names, either, but I
suspect we might use object_id there).

If there were a patch that can readily applied ;-)
