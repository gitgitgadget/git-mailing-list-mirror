Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525681F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757260AbcHXQq3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:46:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62642 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754622AbcHXQqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:46:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DDA9365AB;
        Wed, 24 Aug 2016 12:45:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ne+kcQ3fesJxnQc5pEDEa8lmalc=; b=mdwZ4O
        y6r/01EfpzPvfP/B7GW78CfdkRplCpFCz8FMe9sFFqsFjXWgCwBo+QDAo+yJGpte
        juYubRTPMLp6USletvxeV52JNIbcgRXnI25FXICFnd3rrLwzbtzhE9hiRD71XQX5
        2OGRGnlqIJx10+BbPXN3jdQWbR7kFq/UOSkog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j91v/cv+WAqFusKMrMmWuEQL/o2fIu1t
        2LSlMrHGV8nn9H4QiTO2AIisqWMXPmZVLK6zRZ4BoJVKo0YRvAHWmvH8XM27XLQk
        ZJy3fMkdcvPu2dQPmtnXB4iAiEsveCm8rYtqi7m1ub9zTiyj4vCpbvQR7MVgKXVS
        B8iCmIbAaMg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14F96365A9;
        Wed, 24 Aug 2016 12:45:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E735365A7;
        Wed, 24 Aug 2016 12:45:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Duy Nguyen <pclouds@gmail.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: core.autocrlf, was Re: [git-for-windows] Re: [ANNOUNCE] Git for Windows 2.9.3
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox>
        <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608171507530.4924@virtualbox>
        <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608181022250.4924@virtualbox>
        <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com>
        <alpine.DEB.2.20.1608231553030.4924@virtualbox>
        <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net>
        <alpine.DEB.2.20.1608231736180.4924@virtualbox>
        <alpine.DEB.2.20.1608231758260.4924@virtualbox>
        <xmqqbn0iu50a.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608241743460.4924@virtualbox>
Date:   Wed, 24 Aug 2016 09:45:52 -0700
In-Reply-To: <alpine.DEB.2.20.1608241743460.4924@virtualbox> (Johannes
        Schindelin's message of "Wed, 24 Aug 2016 17:48:40 +0200 (CEST)")
Message-ID: <xmqq37luru7z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3964A2E4-6A1A-11E6-9426-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In any case, in the ideal future, I would imagine that we would want
>> to have "cat-file blob" to enable "--filters" by default; that would
>> make cat-file and hash-objects a pair of symmetric operations.
>
> I would advocate against that. It is not like the terms "hash-object" and
> "cat-file" even *look* like they are opposites.

I do not quite understand your objection.

hash-object is "I have data somewhere on the filesystem, and I want
to store it in the object store even though I am not ready to add it
to the index yet (or I may not even add it to the index ever), just
to make it available to Git tools".  cat-file is "I have data in the
object store, I want to make it available to my other tools that
understand data stored on the filesystem."

When we taught "--no-filters" to "hash-object" back in 2008, we
should have realized that "cat-file :path >path" would want to be a
way to do "checkout path" (with "--no-filters" option to allow us to
inspect the "canonical version"), but we didn't.

Yes, correcting ancient mistakes is costly.  Such is life.

