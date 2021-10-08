Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3FBC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E4D610E7
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbhJHUFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:05:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58395 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhJHUFG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:05:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57593E311E;
        Fri,  8 Oct 2021 16:03:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZbZxmHP4Cc0s5MB9ZnU2/Qs2QM9rV3qrBpHS1C
        B9dHs=; b=Tl5eN14mH8rMTvdNcUnAPeLCCzpxcxswT9Ic9y26+RVf7cx0HeqfXt
        Mn6YFWsz1/y7hNZfUgy7FFi7gDu9hXP1pKJ0bE/AVBXc1zFY64EE61efLVgrMxxH
        Omrv8TAggY3nkvARPxYPoOxb4hV9F98/N/UVDkTlx23sRHg6y1KLA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EC1EE3116;
        Fri,  8 Oct 2021 16:03:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 996BAE3115;
        Fri,  8 Oct 2021 16:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
References: <xmqqfstdr8b5.fsf@gitster.g>
        <YV5aaD418SyZqS/1@coredump.intra.peff.net>
        <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
        <87sfxdgtpu.fsf@evledraar.gmail.com>
        <YV/EnxkTvWWZ6xVD@coredump.intra.peff.net>
Date:   Fri, 08 Oct 2021 13:03:08 -0700
In-Reply-To: <YV/EnxkTvWWZ6xVD@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 8 Oct 2021 00:10:07 -0400")
Message-ID: <xmqqsfxbjncz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C28688D2-2872-11EC-9FDC-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> They do have some limits posted here:
>
>   https://scan.coverity.com/faq#frequency
>
> It's on the order of 3 builds per day for a code base of our size. Which
> is plenty for our integration branches, but not enough to test every
> topic branch.

I usually have at least two pushout of 'seen' (one with the full set
of 'seen' including known-to-be-broken topic integrations, the other
with seen~$some_hopefully_small_number that I didn't see brekaage in
my local build), and then on graduation days 'next' and 'master' are
also updated, so 3 is cutting very close ;-)
