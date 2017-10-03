Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B46E2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 06:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750812AbdJCGYo (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 02:24:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53144 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750720AbdJCGYo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 02:24:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6AF5B6722;
        Tue,  3 Oct 2017 02:24:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U8OYhE5zlfEwTqgu+PkojQeHlLA=; b=IFwJgx
        83QAlpS9pENZmGHZQkZ2jWab/JkxFLePpwmsADnkqwNIT7YpAQf6uYVx1juuD+z0
        VCH+FX5KulowE4RRtScj4Nr8OevHs2i2jbCLWzs6Fhlcvml0vggRsd+wJqeXcyQE
        sEMIaK5qFfnknlMru4cNBC2owukv5sXKW1S5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fnTKNTLfqxqBq5o7Nvx9tq2xOWMkB1D+
        Nj8zz9lla0upftzVGVdvRvfcC/nIaWj6ZfscFpGPEzWyPKX/+zxnPktmtua51qis
        DwU9Tt9J1fRObyAsHvuhJlizCMDWIYeYhx3O+nUazs2Z4sokxLnTxf7Anger/Z/L
        nSigiXVZoBw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD0DFB6721;
        Tue,  3 Oct 2017 02:24:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21781B6720;
        Tue,  3 Oct 2017 02:24:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Support %(trailers) arguments in for-each-ref(1)
References: <20170930062238.87077-1-me@ttaylorr.com>
        <20170930184151.GB43975@D-10-157-251-166.dhcp4.washington.edu>
        <20171001000647.GA20767@D-10-157-251-166.dhcp4.washington.edu>
        <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
        <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
        <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
        <20171002065621.ob3icxhlkefpsm4v@sigill.intra.peff.net>
Date:   Tue, 03 Oct 2017 15:24:41 +0900
In-Reply-To: <20171002065621.ob3icxhlkefpsm4v@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 2 Oct 2017 02:56:21 -0400")
Message-ID: <xmqqtvzgiw9i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B2E41FC-A803-11E7-B743-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Since that's the only thing I noticed, let's hold off on a reroll for
> the moment to see if there are any more comments (and I won't be
> surprised if Junio just picks it up with the tweak, but we'll see).
>
> Please do make sure that "make test" runs clean before posting (I
> usually run it on each commit to catch any "oops, we broke this and then
> refixed it" in the middle of the series, too).

OK, I think fixes for both the "flipped" and the "gettext-poison"
breakages are solved locally in my tree already, so I guess this is
ready to be merged to 'next'.
