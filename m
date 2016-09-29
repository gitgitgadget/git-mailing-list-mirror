Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5548E207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 19:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755499AbcI2Tpk (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 15:45:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59868 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755310AbcI2Tpi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 15:45:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E08D42DF2;
        Thu, 29 Sep 2016 15:45:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zkwkvecszskTCuxOBg/fri94Vns=; b=d0xnjg
        DPkoiAu4u5eEsl2wux7qFQmbfxYbiBnY5GYO/RW5pgnP5q74mlTyaTuuWN1QrUmF
        CJTRmcT2/WnDk48ofFLp8CB+v5dpNN22XOeUX2bpTKWW4vsw66MDUtPLEsD9F112
        0Lc7RIxSppY3saHRVUQVSfswMb2Xt+3GLVep0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r68OYaEQJdULsh0+HDwFoqeSDyEI+C3y
        IHC4rIGMcv1pg35rd816cra7NOuPYNUe0h6aUPOr1m4pQdabMHTBa8eBw4lvCwOn
        zWQ6edwzzVr+vW88HnnsLvlbAGSxnDe6HhOkeH8aa65fvAN10BwBkYdZw5wm/6fh
        Qd9UlZJ4NlY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4746042DF1;
        Thu, 29 Sep 2016 15:45:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C652842DF0;
        Thu, 29 Sep 2016 15:45:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-5-gitster@pobox.com>
        <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
        <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
        <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
        <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
        <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
Date:   Thu, 29 Sep 2016 12:45:34 -0700
In-Reply-To: <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 29 Sep 2016 12:40:43 -0700")
Message-ID: <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AF95FA2-867D-11E6-B2C3-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But you could easily also just instead have it do something like
>
>       if (default_abbrev < 0)
>             default_abbrev = initialize_abbrev();
>
> at startup time if "abbrev_commit" is set, and just do it once and for
> all rather rthan the odd loping behavior.

I think that is a reasonable way to go.

#define DEFAULT_ABBREV get_default_abbrev()

would help.
