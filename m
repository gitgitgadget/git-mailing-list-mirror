Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFCAC64E7B
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA77221F7
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 22:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgLBWgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 17:36:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61099 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgLBWf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 17:35:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0C76FE790;
        Wed,  2 Dec 2020 17:35:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g1jC2NdGEaX1Z60FG3XjGPPA3s8=; b=o9sZwC
        jMDKEKYimADTgHZCh9BqprjsF2L9IHzEBpfXHW/SzjvntBfyV36lZO8PfJlc5RaI
        z2QtAl4rNt3YPHKUxdsIGnRwefTcCYbiog2BYL2K5sHPaR9wgV/e/vAdT757u2xj
        FShevEi4zvEXyCQ08XcOSrEwNStxqdtcaq7a8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KTii7hXGqOZnSo0qFeqwvW3TuFtHHkYm
        zL4+vy09HjVp25YM/Q+AIi1817MFL9U6KIgRoxY2IqBMO/8B/SFi7Y0cONNwnKrs
        0Wq9q60OvMa1RkghHMDaZIsIEjbgJ9oesx5ufevAYkmBpIMOU33PxeLsUPb//gpV
        1zxVzXvctI4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D92EBFE78F;
        Wed,  2 Dec 2020 17:35:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0600DFE78E;
        Wed,  2 Dec 2020 17:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arnout Engelen <arnout@bzzt.net>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: make HTML manual reproducible
References: <20201201095037.20715-1-arnout@bzzt.net>
        <20201201154115.GP748@pobox.com>
        <X8bhdyu/OlscI1ME@camp.crustytoothpaste.net>
        <20201202160755.GX748@pobox.com>
Date:   Wed, 02 Dec 2020 14:35:13 -0800
In-Reply-To: <20201202160755.GX748@pobox.com> (Todd Zullinger's message of
        "Wed, 2 Dec 2020 11:07:55 -0500")
Message-ID: <xmqqim9jltum.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A59E6FD2-34EE-11EB-AB96-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> brian m. carlson wrote:
> ...
>> I don't think that's necessarily the case.  I just tested using a random
>> name with another DocBook project I have and it seems to work fine, so
>> there shouldn't be a problem with specifying a name undefined in the
>> stylesheet using xsltproc.
>
> Oh, that's very good to know.  Thanks for testing the fine
> details.  I checked that works on a CentOS 6 system where
> the docbook-xsl version is 1.75.2, to test whether an older
> docbook-xsl is similarly forgiving of unknown --param's.

That is very good, indeed.
