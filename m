Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9E3C2D0E4
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5032242B
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yaNiXiIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgKTSIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:08:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56067 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgKTSIo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 13:08:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45C8B8A72D;
        Fri, 20 Nov 2020 13:08:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Is5jBLBXm2ypNaebBhdJKAapoJo=; b=yaNiXi
        IudqRU7g+6HmECQVDsoDRmrRA70tQp2G+ztwcm2AWlk+rPxhgo5smimC6XUyd/A5
        5RScwCmNVDRLxMuxs0bTxW1yoynyzbtUHMa6NQbxMQME/SzRpRupCDWcrVD0ZGlm
        P7Ku/WbXKrA3AbdwFVv6kg4K9bS5+HvcQ8eks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fRrPC96px3pPdBDGAdRPZIqJ4aIlDBPV
        yUhYiEvhl0d9vTUMHzKh7OK7RRQJSLPr15CNKJpxATx7NpHYNRnYnhlGivVtrrNP
        5glAa0dBT8Qy9vAY9KJuKItgRT6vU8EoJHwft5W0ZlgaiK8F2m/5eiEcBX6GW/4n
        wsYRjCGL4pk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A7248A72B;
        Fri, 20 Nov 2020 13:08:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88B948A72A;
        Fri, 20 Nov 2020 13:08:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 28/27] tests: run tests omitted by
 PREPARE_FOR_MAIN_BRANCH
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <20201118114834.11137-1-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2011190044100.56@tvgsbejvaqbjf.bet>
        <xmqqo8jtxhyu.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011201403440.56@tvgsbejvaqbjf.bet>
Date:   Fri, 20 Nov 2020 10:08:40 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011201403440.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 20 Nov 2020 14:09:06 +0100 (CET)")
Message-ID: <xmqqy2ivucif.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BD1717E-2B5B-11EB-B084-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Perhaps I should start to more aggressively drop topics from `seen`
>> that are not sufficiently reviewed?  The guiding principle ought to
>> be "unreviewed patches are not worth applying", but I have a feeling
>> that we have become more and more lax over time due to shortage of
>> quality reviews.  I dunno.
>
> FWIW I think you do a wonderful job of keeping the patch series in `seen`.
> I wish we could keep the CI build passing a bit more, but I'd rather have
> the branches that are in flight in one place, so that it is easy e.g. to
> find out whether `git diff next..seen -- t/t9902\*` is empty (to determine
> whether working on that script would cause conflicts right now).

I have to disagree.  There are a few topics, perhaps more than a
few, that is age old in Git timescale nobody has bothered to ask the
list why we still have it in 'seen' [*1*].

It may be a good thing to pick up as many potentially interesting
new topics as possible and to merge them to 'seen' while resolving
possible conflicts with other topics in flight.  I am willing to
continue doing so.

But I doubt that a series lingering in 'seen' that has not been
touched for more than say four weeks has much chance of gaining any
new interest to push it forward.  Perhaps we need a policy to
discard a topic whose author timestamp is 8 weeks or older and not
in 'next', without preventing those who care about the topic from
resurrecting it in support, or something along that line.


[Footnote]

*1* The question can be asked in two ways.  "Shouldn't it go 'next'
already?  I've read it over, here is the review and the thread shows
a clear concensus that it is a good idea" is one happy outcome (even
though that would indicate the maintainer doing a poor job).

Alternatively, "Shouldn't it be discarded?  Nobody seemed interested
back then and now we have X instead, so it is not necessary." is
also a possible happy outcome.
