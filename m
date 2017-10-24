Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B625202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 05:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750897AbdJXFSw (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 01:18:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65275 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750783AbdJXFSw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 01:18:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94EDC98A87;
        Tue, 24 Oct 2017 01:18:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r/PcFuIp6En88sRSiSaPjIR6gBE=; b=RkTzpe
        RPCtV7ysIa2nWLUmbWY5KYkcVFXqMygeiUYVg5xjXM+qTxBDkNjuCR8qMCsD/IHx
        AZI+ZBMOVP8c2lh5V/hTEVuROkJcE4p2Tf80u8XNrsbvouBRhHiJAtxGjLbOaUCm
        wnrjc21/qv/2Hje8AQlvh1vwBDngvHZ7CmTa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E6w6nN10teQ1eXXSNF66XT0Zo2zGc4El
        ilOCo4Tfo0J0/yYC3GJCLeS8x2SZ6mpbINa4yaLBKEQa7S4qXChAKdoMQinAe+2/
        T6muFbSOBMttCxjem+1rP/78xJ7sngHQM5ifSZSjz8rnDUiQjT/z+X2HzoYoowhG
        pWzLF6ATMDA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CB8098A86;
        Tue, 24 Oct 2017 01:18:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAB0498A84;
        Tue, 24 Oct 2017 01:18:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] status: do not get confused by submodules in excluded directories
References: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de>
Date:   Tue, 24 Oct 2017 14:18:49 +0900
In-Reply-To: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 17 Oct 2017 15:10:11 +0200
        (CEST)")
Message-ID: <xmqqo9oxkts6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2183F32-B87A-11E7-820D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We meticulously pass the `exclude` flag to the `treat_directory()`
> function so that we can indicate that files in it are excluded rather
> than untracked when recursing.
>
> But we did not yet treat submodules the same way.

... "because of that, we ended up showing <<what incorrect result in
what situation>>" would be a nice thing to have here, so that it can
be copied to the release notes for the bugfix.  

How far back a release do we want to make this fix applicable?  It
seems that it applies cleanly to maint-2.13 without breaking from my
quick test, so that is probably where I'll queue this, even though
we may no longer issue further maintenance releases on that track.

Any comment from submodule folks?

Sorry that I didn't notice this was left unattended by anybody til
now.  Will queue while waiting for those who are into submodules to
respond.

Thanks.
