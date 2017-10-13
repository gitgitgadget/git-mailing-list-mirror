Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1048520372
	for <e@80x24.org>; Fri, 13 Oct 2017 03:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbdJMDiA (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 23:38:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52062 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753336AbdJMDiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 23:38:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F2FBA95B5;
        Thu, 12 Oct 2017 23:37:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=PSA61Yg9gQx/sOuhTMpdgMlDvDA=; b=d/Xhxis0GHT8Ke0LYZJH
        xJyHaSKiM1B+D38Y7SY6Uk+m0NNs5AzlrDm8Ejxv1aCMDee6jeYgxGSeUUAgH9jl
        nF8u0GGE2BHYphItvlLkndwht8OvfIN6szqLGbrVa8N6SB0FV7CAwk04M8xB7+pe
        QChqAhpciSdXMK/SW+er9/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=Vdn2iK1He2QnjIZ6vaP+ksv3ZOwt1X0pSnmSgFPp2ToV5j
        HoqQi8htpHKwLa3MQ2dMYmRhb5iraEQGgmgwobwkOA1SBx3468tl5mJYp9cX6FpZ
        0NKp1CW/p/Yd0cld+hQiH3hJjowZlT0pZpvu0JYrvQaMWDjhYOtrRs0qVGVs0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68268A95B3;
        Thu, 12 Oct 2017 23:37:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A93E6A95B2;
        Thu, 12 Oct 2017 23:37:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk configuration
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
        <20171012021007.7441-1-gitster@pobox.com>
        <20171012021007.7441-2-gitster@pobox.com>
        <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
        <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
        <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
Date:   Fri, 13 Oct 2017 12:37:57 +0900
Message-ID: <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E832A944-AFC7-11E7-88A3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> OK. For the record, I'm not against scrapping this whole thing and
> trying to rollback to your "plumbing never looks at color.ui" proposal.
> It's quite late in the -rc cycle to do that, but there's nothing that
> says we can't bump the release date if that's what we need to do to get
> it right.

I think that it is too late, regardless of our release cycle.

"Plumbing never looks at color.ui" implies that "plumbing must not
get color.ui=auto from 4c7f1819", but given that 4c7f1819 is from
2013, I'd be surprised if we stopped coloring output from plumbing
without getting any complaints from third-party script writers.
