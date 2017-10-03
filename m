Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26C9620365
	for <e@80x24.org>; Tue,  3 Oct 2017 06:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750797AbdJCGkc (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 02:40:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63840 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750720AbdJCGkc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 02:40:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59FDAB696D;
        Tue,  3 Oct 2017 02:40:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gkkDTPU8Ae7BfpVkMJQYFchZaGo=; b=xfqazM
        vySYYFgK10VE6gFElQuHJ8h7RiaZ3q5saq2cvoXYcVjr78aaCaunbx+BkQh054vO
        i/M1eiekLFj/8b2NcGnFZyAoBvkojn1BC81n5w9/2R+rE+mq1NgXFUyn3FAYazV7
        WzKtKKOtTHnK94ld+uRX6CClGauAw7d23VyUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v78uYAzapGDCl6uGLvDpLEQDFHFt0k2x
        9xl9EbdjXg4c++oWhlCc83xkWoI+2nTQyjr4Hr4fXbWDUigvyzaM885WGWGvEiSq
        cB4pU3adkL3ew96LB9xAqWz0OhHL/KlOKqptr9XZ7LVHTUqjn90J7WejnMa1ZBdo
        xqFCVRn5dXY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5311AB696C;
        Tue,  3 Oct 2017 02:40:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA468B696B;
        Tue,  3 Oct 2017 02:40:30 -0400 (EDT)
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
        <xmqqtvzgiw9i.fsf@gitster.mtv.corp.google.com>
        <20171003063605.laenmn66swwyac6z@sigill.intra.peff.net>
Date:   Tue, 03 Oct 2017 15:40:29 +0900
In-Reply-To: <20171003063605.laenmn66swwyac6z@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 3 Oct 2017 02:36:06 -0400")
Message-ID: <xmqqpoa4ivj6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C002326A-A805-11E7-ACC4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Out of curiosity, do you frequently test with GETTEXT_POISON, or did you
> just guess at a potential problem after reading the tests?  Proper use
> of test_i18ncmp is definitely something we ought to be looking for
> during review, but I confess it's something I often miss.

I learn of breakages after the fact, when Travis reports.
