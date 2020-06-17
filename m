Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF21C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E9B21532
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 20:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aGvUt6bI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgFQUNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:13:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50432 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQUNu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 16:13:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D07CCC1998;
        Wed, 17 Jun 2020 16:13:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZtT4O3G5A/W9MtWB27k7b5CIjDA=; b=aGvUt6
        bIKaZTu8bFTIyUwedCiR3a2+R+BAf9TuJCnBTW/iP0vkr6ujgh5t4QCgdJ9ph9gf
        1ErHoJPpB0on90khWs6Q5a6Y//mczvgPaqcY2R6ZFdk/t4HeoQXNLRNTziXdkOzN
        7EHhOsxEqezUBx5pvbEEaBgladLfJTTYx0Ztc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eM7nlPPgKO01QKRj0yAaDFD6nlRk00LJ
        7jKE8lZOQI1bnzXFFKmBofFNt1S8U30E5AC9NsLra1Z0e1OsZg6yiYebQ4kFNOtA
        zdsZPgHXH3JGdFrvMukIeRMJ5Ge8F9gYgCbjcVSbv7OKjXqI0PPurSZp4bGz6VbX
        LZ8F8be8AIA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7C87C1997;
        Wed, 17 Jun 2020 16:13:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 12800C1991;
        Wed, 17 Jun 2020 16:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        James Ramsay <jramsay.com.au@syl.local>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: Consensus on a new default branch name
References: <20200615205722.GG71506@syl.local>
        <CABPp-BE3UAeMKCtwnTf-5ifVhveRPzQfT1T+sHsm_LDOubCHCQ@mail.gmail.com>
        <20200616143202.GM666057@coredump.intra.peff.net>
Date:   Wed, 17 Jun 2020 13:13:44 -0700
In-Reply-To: <20200616143202.GM666057@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 16 Jun 2020 10:32:02 -0400")
Message-ID: <xmqqpn9xtpqf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C69C14A-B0D7-11EA-B1DB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks for writing this out (I'm still catching up on list email after a
> vacation, so I missed the earlier thread). It really cemented for me
> that "main" is better than "default".

In any case, it makes sense to use separate words for the concept
("default" --- as in "the name given to the first branch created in
the repository by default") and the actualy value chosen for the
entity (master or main in this case).  

The statement:

    I configure in ~/.gitconfig that the default branch name for all my
    repositories to be 'main'

is much easier to read than the last 'main' replaced with 'default'.
