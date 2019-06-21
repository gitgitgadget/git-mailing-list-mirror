Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7231F461
	for <e@80x24.org>; Fri, 21 Jun 2019 15:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfFUPEY (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 11:04:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54409 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfFUPEY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 11:04:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2D3116C5EE;
        Fri, 21 Jun 2019 11:04:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XQaVt4mbaIsV
        CHQ3sH2CBEV0IWg=; b=yARLedwmVfofeBRD1xyb/ChIypccumoeRsW135K0uD31
        JqV5VWEscE4aCBly90KahEIor4oFwaXUbJbo+IpzserQ0ePD8hTuM4oE3znfsIrO
        tZaiEk58jcEJpCu9DrCZKmuamsKVx9sbaPQT6rlvv0p9gCUX2lzMpMHhYiV4WzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WOr8Fb
        bPp5yzXwILDjx6gV/B/l8FSlGKfTHtAuQFd/i2Y1zf3n90z41ZHS4cFhEnW3Evny
        pUvky+GjLj8lyIuNr0vEpm955WFaNrwg5CPG06ZbZn/RBEwzu64aVbnh6PC7ox3P
        Qi73ZgfiojrNpQufu8RIajmLIg6MkCz7CPoRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8CBE16C5ED;
        Fri, 21 Jun 2019 11:04:21 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 375A516C5EC;
        Fri, 21 Jun 2019 11:04:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/8] env--helper: new undocumented builtin wrapping git_env_*()
References: <20190619233046.27503-1-avarab@gmail.com>
        <20190620210915.11297-3-avarab@gmail.com>
        <xmqqpnn7lxet.fsf@gitster-ct.c.googlers.com>
        <xmqqlfxvlwyg.fsf@gitster-ct.c.googlers.com>
        <87blyr8ijr.fsf@evledraar.gmail.com>
Date:   Fri, 21 Jun 2019 08:04:20 -0700
In-Reply-To: <87blyr8ijr.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 21 Jun 2019 10:11:04 +0200")
Message-ID: <xmqqh88jkmiz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D95CC068-9435-11E9-A1DF-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Just thought I'd ask if appeasing older analyzers is what we want for
> these sorts of optional warnings in general.

Yeah, examples of such "let's help users with common compilers so
that they can focus on real errors" are abound.

Thanks.
