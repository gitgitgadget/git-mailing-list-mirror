Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23F3C1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 22:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfGIWFR (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 18:05:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62290 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGIWFR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 18:05:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6B117358C;
        Tue,  9 Jul 2019 18:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8dpnprmduJ9jNGLpb168aXPIbPQ=; b=xLWLTm
        SArabbfRO2+2UoiX42Ae+1tpzHjCsSRdAWI4q3y2ffk6eF/ktREPUVR8DswdqaUw
        MLA8J0wMVlsfb0UKM03OAAbsw35R+dkZVmTx1xe051p7y3t1qtVHokzC7VvhBGUa
        ZRbIXzGsX6duc6O598Ym+JZ3dctyIlfOijcDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vR+a6maZkGgWmeqEiFAhWVI3AoO8aCf3
        yjmVLEmN7ZmXhZ9Z2fyq/aStWY9N/MkBbzTdf9zIRjQEuHcW3Sk9zqUBCKaYOXuK
        Bzf9Y/XmH1PmfN3tgFrK7pVxQAmSloiMzffNjpTpQw7bR3RMOwOH3jkCXRGyj8dq
        UaoT+25fqEA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF6217358B;
        Tue,  9 Jul 2019 18:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E50EA73585;
        Tue,  9 Jul 2019 18:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 0/3] [RFC] Create 'core.featureAdoptionRate' setting to update config defaults
References: <pull.254.v2.git.gitgitgadget@gmail.com>
        <pull.254.v3.git.gitgitgadget@gmail.com>
        <50955e76-8b61-8ffd-b8ee-3621ecbd912b@gmail.com>
        <xmqqo923ui7x.fsf@gitster-ct.c.googlers.com>
        <afdaaa93-8769-c859-e957-e61d27b6d5a9@gmail.com>
Date:   Tue, 09 Jul 2019 15:05:08 -0700
In-Reply-To: <afdaaa93-8769-c859-e957-e61d27b6d5a9@gmail.com> (Derrick
        Stolee's message of "Tue, 9 Jul 2019 15:45:40 -0400")
Message-ID: <xmqqef2yvp7v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9ECCD514-A295-11E9-A779-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> From this list, do you think any of these settings are likely to
> become defaults? It seems that protocol.version = 2 may be a default
> now that _most_ services have an implementation, and it always falls
> back to protocol v1 without extra cost.
>
> When pack.useSparse was first introduced, I considered making it true
> by default after a while. But you protested, saying you want people
> knocking at the door saying it is useful. What if it lived here?
>
> fetch.negotiationAlgorithm and merge.directoryRenames seem like
> valuable features and maybe just need more time out in the world
> before they could be considered defaults.

I mostly agree with the categorization you gave above.

I think it is perfectly fine for a knob, after proving its worth by
existing in the world without being a part of any feature.* set, to
become part of feature.experimental, and then later be ejected
without ever becoming the default in response to reactions by real
world users.  This would be easier to arrange if we had at least two
experiment levels.  One class would be "we are firmly committed to
make these default in the future and ironing kinks out---please help
by setting feature.experimental on" and is more for early adopter
testing.  The other class may be "we try this on users to see if
there are some populations of them with usage patterns we did not
anticipate, and will yank it out if it turns out to be problematic
to some users."  The more guinea pig users opt into the latter
"Highly Experimental" category, the more help they can give us to
prevent an ill-thought-out feature that does not universally help to
become a new default.
