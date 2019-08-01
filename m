Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77EBA1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 03:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfHADVk (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 23:21:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55669 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfHADVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 23:21:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A25882773;
        Wed, 31 Jul 2019 23:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hTZfiDOFMBH13JWdxaWYoFgtSDM=; b=dgfs2N
        pzzNkbH5weeECSteLHMdEy+WACnGwkfPffV/Mx+NiqSp3TAh5JAexpyLCXgZf1DB
        aT3G7WRBcYz80olZCo+ws+QjSeTrBIZyV05kaW1Fy0dnSUKlnf7Sw6yhS9P/4MAk
        qV7xTJJ3KQY7p1twyHViwd6KUZHO8phLyYToY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i4SMaeTjVsKZI1qElCUyF51izvoMy2q2
        QlGFoGRSUunWKjnAcHdDfH8RASPI+dtwSmu8EAOTKm/7ZM/HAs5QiIX473bWCfke
        NmKL2DeHhvJTO4ON1kkop8BsCwg5ES3QgOQ8Uxj6qPy4RO2vsgvOEN2FyvqgKCVZ
        sMM7rMJ01rA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4050682772;
        Wed, 31 Jul 2019 23:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 64BBC82770;
        Wed, 31 Jul 2019 23:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
        <20190731231848.GC1933@sigill.intra.peff.net>
        <20190801002125.GA176307@google.com>
        <20190801010022.GA6553@sigill.intra.peff.net>
Date:   Wed, 31 Jul 2019 20:21:33 -0700
In-Reply-To: <20190801010022.GA6553@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 31 Jul 2019 21:00:23 -0400")
Message-ID: <xmqqsgqlo9j6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 778461D4-B40B-11E9-AF37-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This seems OK to me, though I kind of wonder if anybody really wants
> "auto". Unlike log.decorate, which changes the syntax, there is no real
> reason to avoid mailmap when somebody else is parsing the output. And I
> could imagine it is especially confusing if:
>
>   git log --author=whoever
>
> and
>
>   git log | grep whoever | wc -l
>
> do not agree.

I personally do not think it is too late to change for the upcoming
release, either.

But 'auto' that changes the displayed name depending on the output
being or not being a terminal makes little sense, I would think, for
the above reason.

