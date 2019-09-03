Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C411F461
	for <e@80x24.org>; Tue,  3 Sep 2019 01:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfICBVh (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 21:21:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56476 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfICBVh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 21:21:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C0B615AFD0;
        Mon,  2 Sep 2019 21:21:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PQ44W7QrkM1fRxe8lajKeIa2sGM=; b=TR2Kw+
        FHH0eO9XhKq1Ls6bfEsbjkYBXT/pOogCdLlP29O/Xf1/htWGks72L70NmD+rC209
        JjY98HFb3BiXb2Cs6B88rE/LkwF7zkNM1Sj7omZzRrzDJ9ZLqm3X2VVOmGbZKdU3
        cDEYg1/QanR6WU9k4i690Q1hVTc2G8MwxskxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tupL+lf4SSYi/ehxU+5XK1KsOqhuR6CB
        seeI8MUlA0IwzZcj9dlXNDwvFpKhAsAakdnidyQFD16rKREWh/05iL6H60yle31T
        IqJN2DyYhxnwuGtMz8Te/dUsPFdnLLNTNDWO4ch2uxFiUmuroZOgn7L+9eLpWNCT
        fj4teka42mA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3484D15AFCF;
        Mon,  2 Sep 2019 21:21:35 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9965C15AFCA;
        Mon,  2 Sep 2019 21:21:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Warren He <pickydaemon@gmail.com>, git@vger.kernel.org,
        Warren He <wh109@yahoo.com>
Subject: Re: [PATCH] rebase: introduce --update-branches option
References: <20190902234109.2922-1-wh109@yahoo.com>
        <20190903005018.GH11334@genre.crustytoothpaste.net>
Date:   Mon, 02 Sep 2019 18:21:33 -0700
In-Reply-To: <20190903005018.GH11334@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 3 Sep 2019 00:50:18 +0000")
Message-ID: <xmqqwoeqtbs2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B26159C-CDE9-11E9-BAE7-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I like the idea of using existing tooling for this and not needing an
> additional verb.
>
> My gut tells me folks may want a bit more control over *which* branches
> are rebased, but I don't have a personal need for that, so I'm not going
> to request it or propose an interface for it.

FWIW, I am in favor of both of the above two points.  It is quite
clear because "exec git branch -f <that branch name>" is spelled
out, people can remove the ones they want to keep a copy of when
they need to.

I didn't look at the code more deeply than just eyeballing and
noticing style violations etc., and will leave the reviewing to
others for now.

Thanks.
