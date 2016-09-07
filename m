Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21C3C2070F
	for <e@80x24.org>; Wed,  7 Sep 2016 18:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755831AbcIGSL0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 14:11:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57849 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751263AbcIGSLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 14:11:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19FB237A17;
        Wed,  7 Sep 2016 14:11:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nFO/pinLj2gJNAGly2wUUZrP2Ng=; b=hjzCg7
        Ophy2JrUVDw9sh2h6Eg+Q18+IQ+wygX827JzoiHGICdQkKgV5iLDiDIW45TdEfyr
        Dss1h69MNvLb0z0z2vxYvq9qosS69fdco94Ht4AcRCMIabUXLOMyPYGz4Owfe7Da
        qLexu88f5S76k1YP6YRBpCZKJhGMXpXmfUGi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RteH/z6SlRuusmEq1okdztJiKsJJDUF4
        EH8OJwb3vQfWvJJXduXt2v49OMVvGmEAJtJk2+lWcHeN++LdUyiowzMGjAFAtjt1
        7zqi1PnpySELLUXpKcACZIPBRfmVVac512OIHyPCVNlCsfRxqDdGHLOL5bpS4XKI
        GW09Ax2JNdw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 106EE37A16;
        Wed,  7 Sep 2016 14:11:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8476337A15;
        Wed,  7 Sep 2016 14:11:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 0/8] Better heuristics make prettier diffs
References: <cover.1473068229.git.mhagger@alum.mit.edu>
Date:   Wed, 07 Sep 2016 11:11:21 -0700
In-Reply-To: <cover.1473068229.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Mon, 5 Sep 2016 11:44:45 +0200")
Message-ID: <xmqqy433mvg6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C4FDE5E-7526-11E6-A348-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * In "blame: honor the diff heuristic options and config":
>
>   * In v2, I suggested making `blame` honor all diff-related options.
>     Junio explained why this was a bad idea. So this version only
>     makes `blame` honor `--indent-heuristic` and
>     `--compaction-heuristic`.

This makes a lot more sense to me.  I am not sure if it is worth
adding 7/8 to expose these experimental knobs to the end users, but
the amount of the code needed is very small, so let's take it.

I am hoping that we can lose both of the experimental knobs and use
the indent heuristic unconditionally in the future, though ;-)

Thanks.


