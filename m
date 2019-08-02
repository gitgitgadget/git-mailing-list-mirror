Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E651F731
	for <e@80x24.org>; Fri,  2 Aug 2019 16:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbfHBQre (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 12:47:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55009 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388211AbfHBQre (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 12:47:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13EBF16D133;
        Fri,  2 Aug 2019 12:47:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v73RapPkJZlutsdWBbpH7Qbiur8=; b=BAqhE3
        okHK7A+yUbdH8RMYeJrrdRvdBraOt4klCwBgH8IBPFgqMykQ0OlLzeWLpTlXy3FN
        OVFwQuJwOjQ3UC3fuw4ZaBxnWf3zMjjzXpZifuIQSmk2d9ZQXZZr3CFjYV0Itabt
        oLlJN10mK74DJ9Fg09nI5krL2fovmYGxqIvB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HcF+X4xPN7/bvKH+FUltfChHo2Pg4v9I
        7rUtF+i7OU1ulctSfimSSGS8cXNcbuPnBd8bOYsh8TjU794RaL9Quo97viOAjiVh
        Vk7ohz/PTJoLb7J7nukfa94Hh7G26I3M6kGXnKri/OqzFnnCckwVB9rClpw0fTuy
        TrtB5tpYhuw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09DFE16D132;
        Fri,  2 Aug 2019 12:47:32 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A2F016D130;
        Fri,  2 Aug 2019 12:47:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Mark Levedahl <mlevedahl@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
References: <20190728151726.9188-1-me@yadavpratyush.com>
        <20190728213634.GB162590@genre.crustytoothpaste.net>
        <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com>
        <20190728224943.GC162590@genre.crustytoothpaste.net>
        <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
        <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com>
        <nycvar.QRO.7.76.6.1907312132190.21907@tvgsbejvaqbjf.bet>
        <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com>
Date:   Fri, 02 Aug 2019 09:47:30 -0700
In-Reply-To: <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com>
        (Pratyush Yadav's message of "Fri, 2 Aug 2019 03:22:09 +0530")
Message-ID: <xmqqftmjldjx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 385D3234-B545-11E9-8C2A-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> +Junio

I do not have a strong opinion on this one---a Meh by default means
a moderately strong preference for status-quo.

> All right, the patch in its current state can't fly. So what is the
> correct way to do this? I see the following options:
>
> 1. Add this as an option that is disabled by default, but people who
> don't mind it can enable it. This is the easiest to implement. But I
> leave it to you and Junio (and anyone else who wants to pitch in :))
> to decide if it is a good idea.

I think this is a good first step.  As I said already, I am not
convinced that "focus in" is a good heuristics for triggering auto
rescan, and I suspect that you or others may come up with and
replace it with a better heuristic over time.  During that
experiment, it would be better to allow interested others to opt
into the feature to help, while not disturbing ordinary users who
are OK with the current behaviour.
