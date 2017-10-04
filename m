Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A28F2036C
	for <e@80x24.org>; Wed,  4 Oct 2017 06:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdJDG0S (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 02:26:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54102 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751234AbdJDG0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 02:26:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBF9DA1B16;
        Wed,  4 Oct 2017 02:26:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hwQf6O+S9K4ocu2raycgnxbzb5w=; b=ozhNWE
        GHI3Y4uAfW0srJHY4yf1WyBw/Zo+rYhxVsLIfJUBmt+9qPIKWRjooPnexkfqHf3C
        vsxi/0rOsdgazIhq8NLSuSP8iUdSUZyEw8zgY23bDz95Zg/pejGkKDTG3915tfWd
        jnEWdV5qBV6r6mkfTnq9oBixh9DHMXUEZbVaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aaj2kACWK/HHg7HRiXj1uUMbtia1LPIJ
        IEJpMESbWhAjy3RrkBfll+tCwrgVEe7CAviUqgmYgDVo0kwzoIRFzXgg8zmWQ7Oh
        CVMHnbWQ2a0GThbbwq/TaY86eLFU7v2beOzK54LsaMxYz0wc9yOQxznesMbTrdz8
        D1sPQdTVLlk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2F5FA1B15;
        Wed,  4 Oct 2017 02:26:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29500A1B13;
        Wed,  4 Oct 2017 02:26:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: Re: [PATCH 2/3] http-push: fix construction of hex value from path
References: <20171003195713.13395-1-t.gummerer@gmail.com>
        <20171003195713.13395-3-t.gummerer@gmail.com>
        <20171003225315.GE19555@aiede.mtv.corp.google.com>
        <20171003233638.fq6lgls2qsucfbn3@sigill.intra.peff.net>
        <xmqqbmlnecxd.fsf@gitster.mtv.corp.google.com>
        <xmqqy3orcwvu.fsf@gitster.mtv.corp.google.com>
        <20171004052640.3sxpluokhcyh4c2y@sigill.intra.peff.net>
Date:   Wed, 04 Oct 2017 15:26:14 +0900
In-Reply-To: <20171004052640.3sxpluokhcyh4c2y@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 4 Oct 2017 01:26:40 -0400")
Message-ID: <xmqqd163cttl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED0B9DC4-A8CC-11E7-9544-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> More seriously, is there any interest in marking it as deprecated in the
> release notes and issuing a warning when it's used for a few cycles?

No objection from me.

I do not object with such a well designed deprecation plan for any
other features, if there are other "favourite" ones people would
want to deprecate and eventually remove, by the way.
