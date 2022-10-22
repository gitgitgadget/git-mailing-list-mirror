Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B76C04A95
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 23:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJVXOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 19:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVXOI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 19:14:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D9F8053E
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 16:14:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B1D214108B;
        Sat, 22 Oct 2022 19:14:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nEnM0m3vDve7fLDE35hNgKsmI06KoUR5AAE1Ax
        mLeOg=; b=QirxLsklttl6MJTorKTICmw/dQ7vI6KU/AgVPGYJDzN/Bg276pL15X
        54xntzq/8yclGlnCphsQaOApAOqNbuA+DHoWRxSMKm8XIYwQWG0dYU7lGt/zFGzu
        LzX2Ig1tzcbIneIN+D50A4Ud8fJT8nguj7fd+CmgrKP0pAkIUxL7A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 623EA14108A;
        Sat, 22 Oct 2022 19:14:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B5BF141088;
        Sat, 22 Oct 2022 19:14:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael McClimon <michael@mcclimon.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] setup: allow Git.pm to do unsafe repo checking
References: <20221016212236.12453-1-michael@mcclimon.org>
        <20221022011931.43992-1-michael@mcclimon.org>
        <20221022011931.43992-3-michael@mcclimon.org>
        <Y1Rdtog/XQV0YLj0@coredump.intra.peff.net>
Date:   Sat, 22 Oct 2022 16:14:02 -0700
In-Reply-To: <Y1Rdtog/XQV0YLj0@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 22 Oct 2022 17:16:38 -0400")
Message-ID: <xmqq35bfh2o5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38003F6A-525F-11ED-8FE2-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It feels like this try/catch should just go away:
> ...
> And then the code below that to check for bare/not-bare should be using
> "git rev-parse --is-bare-repository" or similar. Something like:

Yeah, exactly.  I very much like the straight-forward way of
thinking to have "git" do the real work.

Thanks.




