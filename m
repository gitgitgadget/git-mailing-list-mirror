Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F331F4C1
	for <e@80x24.org>; Wed, 23 Oct 2019 04:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfJWELq (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 00:11:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52540 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfJWELq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 00:11:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 00D8C8C215;
        Wed, 23 Oct 2019 00:11:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IqkPr0Qc/+RUNFly3wTcQ53NEhY=; b=H3q9LZ
        kSWf2Y6jxEpjg6AIO6sT5E+f1b3gy1uw+dwGIV3sJ2cKeN+GDRapnn/n1H8m1L+6
        OkipEsfq2dqoJx+9vFf1jVorPfbZXVnkWliZ105NeI2pXQWV3BoS7vmExh/5bJQn
        iCIv63Mj9u5MPwKg9LBkCCONem6Trwu49tvPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sNQC8CDmFX/Xi88xJQOXx15R2HyirHhD
        4vRZmQyZKQOMditnq7XfFBiIHFaECElTYGaqg8O0BvE/4Bxc52DK2MzHKJpU5SHI
        yVkfbJ/7xJopGoaaMUtF+HNLBhEmTlHm+E4Ayae35F7N7kHw3pkSj1lgC/UzRdKy
        Ts7wHXlc3CM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ECE538C213;
        Wed, 23 Oct 2019 00:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27C098C211;
        Wed, 23 Oct 2019 00:11:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC/WIP] range-diff: show old/new blob OIDs in comments
References: <20191017121045.GA15364@dcvr>
        <nycvar.QRO.7.76.6.1910222111430.46@tvgsbejvaqbjf.bet>
        <20191023015629.GA15495@dcvr>
Date:   Wed, 23 Oct 2019 13:11:38 +0900
In-Reply-To: <20191023015629.GA15495@dcvr> (Eric Wong's message of "Wed, 23
        Oct 2019 01:56:29 +0000")
Message-ID: <xmqq5zkghzid.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 375E23F2-F54B-11E9-AB4B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> What Konstantin said about git repos being transient.
> It wasn't too much work to recreate those blobs from
> scratch since git-apply has done it since 2005.

;-)

> We could get around transient repos with automatic mirroring
> bots which never deletes or overwrites anything published.
> That includes preserving pre-force-push data in case of
> force pushes.
>
>> Instead, we will have to rely on your centralized, non-distributed
>> service...
>
> I'm curious how you came to believe that, since that's the
> opposite of what public-inbox has always been intended to be.

I think the (mis)perception comes from the fact that the website and
the newsfeed you give are both too easy to use and directly attract
end users, instead of enticing them to keep their own mirrors for
offline use.

Thanks for injecting dose of sanity.
