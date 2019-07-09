Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5781F461
	for <e@80x24.org>; Tue,  9 Jul 2019 19:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfGITVr (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 15:21:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56509 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGITVq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 15:21:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9DB6172471;
        Tue,  9 Jul 2019 15:21:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dr7iqNTH7W52yUDi2H+u+G2zIQs=; b=iRh901
        xUDnVwIY1VigF1vLrk1uvQ7rbKPb8OzhoKD2aZqXr6jD9XtAq5g5qgdyrU8sSKwg
        GbiLxe1g2l8Q9TGnXmtnstNnbOw/ywIAXjvqHVxTD58fKIO9Q7JJnMcxtwnLBrkr
        1rVaX7jiKT6aWqgf7PjHTUYcH/hAqQNQfnKls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ExBY4U2bl480ZGMgYX2IOk7fpbzDypV/
        CiSfs/tl90/hkhT1GghnmzOjSDWn6wmRAkAwzuaSgBkRbwEPufPvk+hLSgXE9d7/
        GfNEW64a+PoQy6u3Wzy6NCJTCpMd5YpiqDDcjd6zuKWn+7ndd5zQ/7HWfL81UYwk
        SkZ8XCgorvY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9546372470;
        Tue,  9 Jul 2019 15:21:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A00397246F;
        Tue,  9 Jul 2019 15:21:40 -0400 (EDT)
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
Date:   Tue, 09 Jul 2019 12:21:38 -0700
In-Reply-To: <50955e76-8b61-8ffd-b8ee-3621ecbd912b@gmail.com> (Derrick
        Stolee's message of "Mon, 8 Jul 2019 15:22:49 -0400")
Message-ID: <xmqqo923ui7x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C76A5D0A-A27E-11E9-A1E9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The other category that has been discussed already is that of "experimental
> features that we generally think are helpful but change behavior slightly in
> some cases".
>
> 	feature.experimental:
> 		pack.useSparse = true
> 		status.aheadBehind = false
> 		fetch.showForcedUpdates = false
> 		merge.directoryRenames = true
> 		protocol.version = 2
> 		fetch.negotiationAlgorithm = skipping

Other classes you listed I can easily support, but I have trouble
deciding if this concept itself is bad, or merely that some/many of
the sample knobs you listed above are not exactly appropriate.
Either way, I have hard time swallowing this one as-is.  You may
think aheadBehind==false is helpful, but I don't, for example, and
there may be people for and against each of the experimental knobs.

But there may be a clear set of "this is agreed to be the way to the
future, but the implementation currently is too convoluted and
suspected of bugs, so we'll let early adoptors opt into the feature,
and when that happens, eventually this knob will go away (i.e. you
won't be able to turn it off)" type of knobs.  Or it may change the
behaviour drastically, but as long as it is agreed that the future
lies in that direction, I think it is OK to throw such a knob into
this class.  The key points are (1) we are committed that in the
future everybody will be forced to have it and (2) it is not merely
"we generally think", but "the decision about the future has been
made---there won't be any other way".  The feature.experimental
becomes merely a way to let early adoptors in.  If you limit the
individual features governed by feature.experimental to that kind of
knobs, I can be easily convinced that this class is a good idea.
