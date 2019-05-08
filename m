Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3156F1F45F
	for <e@80x24.org>; Wed,  8 May 2019 03:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfEHDqw (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 23:46:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58310 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfEHDqw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 23:46:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A4926B2F6;
        Tue,  7 May 2019 23:46:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oDHWTHCr8CoaDNRD4zaqjOzTr7A=; b=llJdC2
        o8xAIFzcP9Nk7WTjDR7XqLvOz+QZmavKSDpQ4nJGcHQaS+Y6OZgrf+Du2cwmdJa3
        ucRW4Jq4xrDh2pUl/s4I4+Y+PLHjVyqUfDrUrL00gYZqFpFM4pdHS9KZKJfe8ro6
        FaQI3rDbBJYwnDnUizDFIR88a1LX/9Eljic78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=djQP8nY770JIe/0p04/b2iQRzNfrkB4D
        QjqNQi1+lFqUCgbUv6ocZ00xIeLigXd+mNoMEsxHN9zhcmkXy0IrbdKoJKP3nUqn
        lIhzMU0DJEb9snRqnnDRubsrYnrmnH+bw+e1bb2MngoiKfXKhusg3+IiQv7x5+XS
        +ouH/InmPzg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 136C36B2F5;
        Tue,  7 May 2019 23:46:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 40D086B2F4;
        Tue,  7 May 2019 23:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v5 1/2] documentation: add tutorial for first contribution
References: <20190423193410.101803-1-emilyshaffer@google.com>
        <20190507213040.151799-1-emilyshaffer@google.com>
        <20190507213040.151799-2-emilyshaffer@google.com>
Date:   Wed, 08 May 2019 12:46:47 +0900
In-Reply-To: <20190507213040.151799-2-emilyshaffer@google.com> (Emily
        Shaffer's message of "Tue, 7 May 2019 14:30:39 -0700")
Message-ID: <xmqqimulip5k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8BA92D4-7143-11E9-B049-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +=== Clone the Git Repository
> +
> +Git is mirrored in a number of locations. Clone the repository from one of them;
> +https://git-scm.com/downloads suggests one of the best places to clone from is
> +the official mirror on GitHub.

I didn't want to have to get into fine-grained wordsmithing (let
alone bikeshedding) this late in the iteration of the topic, but
"the official mirror" is not something anybody suggested in the
recent reviews (JTan's rephrasing, which I already said that I am OK
with, said something like "one of the many mirrors").

And "official" is a phrase I have trouble with in this context.  A
mirror does not have to be blessed as official; that's the point of
a mirror---anybody can make one to help users with better
connectivity or availability, as long as its users trust the mirror
maintainer for mirror's correctness and freshness.

So perhaps "... clone from is the mirror maintained by GitHub folks"
or just simply "is the mirror on GitHub"?

> +$ git send-email --to=target@example.com
> +		 --in-reply-to="<foo.12345.author@example.com>"

Very nice attention to the detail here.  I like it (the earlier
round did not have dq around the message ID).

> +		 psuh/v2*
> +----

All other edits relative to the previous round look very sensible to
me.  Thanks.
