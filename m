Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11329207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 17:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbcI3R4L (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 13:56:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63099 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932430AbcI3R4K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 13:56:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1DC93F94B;
        Fri, 30 Sep 2016 13:56:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Uz6c54HdzWVh0dksSa7zrR9HBA=; b=hIACyF
        VJttZG4adhwS30IPfjXtekMxYN0RJuad3CkML6QmFvCkVWv8DPFBt/xOiQh22XJF
        SiK9I0LPoiIFZTNcIk1qXusyfiGaICpjWpoblFkzM9XcWrnuBIB0nDJoKQpw2dmn
        /y/VDQZi98Budol3GYQ2jOym/RMqwUrWmsV18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NQIabul+fFC2935vKWYJ1MgWJK6JSOs8
        nwg9H/ZFwea5Q7WsY+8vjdVtS1ClO3WkfIJgfogVR9HpFYItFkcAQKe7dxu+a2AW
        vzCE/XCw5WfKLl2mwgsP6gZCJeINSzVRm/a+HUXUhplAAiis73DPqxn2WF9T0HXk
        JshmOOQffaw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C936B3F94A;
        Fri, 30 Sep 2016 13:56:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49F253F949;
        Fri, 30 Sep 2016 13:56:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
        <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
        <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
        <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
        <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
        <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
        <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
        <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
        <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
        <20160930080658.lyi7aovvazjmy346@sigill.intra.peff.net>
Date:   Fri, 30 Sep 2016 10:56:06 -0700
In-Reply-To: <20160930080658.lyi7aovvazjmy346@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 30 Sep 2016 04:06:58 -0400")
Message-ID: <xmqqr3819sqx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A40551C-8737-11E6-A7D2-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree that this deals with the performance concerns by caching the
> default_abbrev_len and starting there. I still think it's unnecessarily
> invasive to touch get_short_sha1() at all, which is otherwise only a
> reading function.
>
> So IMHO, the best combination is the init_default_abbrev() you posted in
> [1], but initialized at the top of find_unique_abbrev(). And cached
> there, obviously, in a similar way.

Hmm. I am undecided; both approaches look OK to me.

