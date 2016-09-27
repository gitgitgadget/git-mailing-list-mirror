Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F40620986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934237AbcI0Ufc (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:35:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63776 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934047AbcI0Ufa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:35:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C3263D04D;
        Tue, 27 Sep 2016 16:35:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6teiGkhK3dxy7qBemKykqRPxkAs=; b=Hpbk9S
        5Y6Zq85G+dcUGa/k+1CHWgJ9ebLE2+MHUV1dEeSGsM0jJfkJ83agByNmzNy8XSjH
        VA510Y4g/gnS9l6t8KskVkfBGgU3YXyo0fN/RS+448UHjbyJgOqbn5L9bjZIAvHm
        S7scnEBvbv8LmrV1+rieqKCcVpTOyH9DGikKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lCj4u+e/efwoNNHkYsulPX7cPIAaVeFS
        Qn/OASRxofpyz1xR1BO2NKUd8A2AFUuhbPldDikEFhe1XzygqV/H3TLA5/+DPWTI
        8zqm24kd7ifvTbFCi5UOgWo6C8ndCuvHUiM9c1qpN+9MGHp1Qi6jqBKK3LEwqwhL
        z0tEDVqVj8g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14A063D04C;
        Tue, 27 Sep 2016 16:35:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8AB423D04B;
        Tue, 27 Sep 2016 16:35:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4 v4] submodules: make submodule-prefix option
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1474930003-83750-2-git-send-email-bmwill@google.com>
        <xmqqtwd1nr56.fsf@gitster.mtv.corp.google.com>
        <20160927202925.GA32565@google.com>
Date:   Tue, 27 Sep 2016 13:35:26 -0700
In-Reply-To: <20160927202925.GA32565@google.com> (Brandon Williams's message
        of "Tue, 27 Sep 2016 13:29:25 -0700")
Message-ID: <xmqqoa39m67l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED5F6864-84F1-11E6-B6BE-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> s/submodules/submodule-prefix/ at least.
>
> So should the #define be SUPPORT_SUBMODULE_PREFIX instead?  That may be
> too narrow minded and not looking toward future submodule options
> support but I'm not sure.

I am not convinced that this prefix needs to be tied/limited to
submodule, at least not yet, though.  I view it as a prefix that
points from above the repository's top, of which submodule support
may be a good sample user, but the caller may not necessarily be
doing or interested in "submodule support".

That's also part of figuring out how we want define the semantics of
this thing and how we want to present it to the end-users, I guess,
so we may have to rename it when we know more, but that's OK.
