Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E453C20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbdK0Xsg (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:48:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57600 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752259AbdK0Xsg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:48:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8048DBF11F;
        Mon, 27 Nov 2017 18:48:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V3PnAl5m5iPNJAAY89pGOVbnhKg=; b=ip/FSc
        ilRXoj06PWQmr6MhNICxOgIhEm0g4q9q72lsWB31GOOM+gkQNmr/a5GdGZIZAteP
        l/SoT6p9b2X+wkFV2XmgK6MT+u3pLJunM+/y8HCIW9w5yDg2ZuTgddi2J+KRsqyb
        rdW8MUXEyw1zmCI6Kde1UQ7csT8fqW3nixW8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sjtHb+0QrYpgUTIJoo9vW57hcGR2/9zr
        ltRYFtUbwP/2u20WfBoX3xxCIpb9iMrVxo6dqQZpc/Ldz0bWPTpQCCHp6zzTByGB
        ErMEAov34u/RgiaYomKBe4590QUU9Mk3C/KRD8M6GqBlG+XqYbnaNzG2i9uwBg0/
        edivswAUvyw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77D9ABF11E;
        Mon, 27 Nov 2017 18:48:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E91F4BF11C;
        Mon, 27 Nov 2017 18:48:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH 3/5] rebase -i: add exec commands via the rebase--helper
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171127045514.25647-4-liambeguin@gmail.com>
        <alpine.DEB.2.21.1.1711272241590.6482@virtualbox>
Date:   Tue, 28 Nov 2017 08:48:33 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711272241590.6482@virtualbox> (Johannes
        Schindelin's message of "Mon, 27 Nov 2017 23:42:32 +0100 (CET)")
Message-ID: <xmqqfu8z9tbi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B5F5E1E-D3CD-11E7-8A70-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> could I ask for a favor? I'd like the oneline to start with
>
> 	rebase -i -x: ...
>
> (this would help future me to realize what this commit touches already
> from the concise graph output I favor).

Excellent.

>> Recent work on `git-rebase--interactive` aim to convert shell code to C.
>> Even if this is most likely not a big performance enhacement, let's
>> convert it too since a comming change to abbreviate command names requires
>> it to be updated.
>
> Since Junio did not comment on the commit message: could you replace
> `aim` by `aims`, `enhacement` by `enhancement` and `comming` by `coming`?

Yes, I noticed them but don't mind me ;-)  The above are all good fixes.

All suggestions in the remainder looked sensible.  Thanks for a
review.
