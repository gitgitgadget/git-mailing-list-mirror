Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406701F462
	for <e@80x24.org>; Mon, 29 Jul 2019 04:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfG2EyF (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 00:54:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62183 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfG2EyF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 00:54:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB733154ED3;
        Mon, 29 Jul 2019 00:54:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SUZKTsq7ikRn
        z/iIORlhg7Ymjzw=; b=xbkAaL72uskWC9+24NnAUZ8g+qJJxzYsuDkg6JFOAMyx
        vKm+yYX7EHpDeDHJotWO2HGjBguPmZdHaGFgNzM085sJ+H5BCxSTkQIM8hQ5F/VB
        ASbltd3BW4JG2egW2T2SILow/oUT2G9ZvwKP/5a4b4VystNBewsb1XLph2xtrOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RCDt1L
        hdazmZHwql7F6AgV9evtgbRULNlEUNj93PfGNN5NPjiyKqSseUmEmbHM4+fB2yXx
        92rXdJjicjD+hIZYBcB39AFxE5jsVvtyVzFQ4vjvBqI47Q7khdj5rTwMMlIw8L92
        PJ8FZxLCqhrC9JoT45FzOFwWf0pJ6rIRrZX9w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0A83154ED2;
        Mon, 29 Jul 2019 00:54:02 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD12C154ED0;
        Mon, 29 Jul 2019 00:54:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 0/5] system header cleanup
References: <CAPUEspjp3WkHk376hu5EvvyufGYQCSHKM6cTT3hnQyfNgpnLzg@mail.gmail.com>
        <20190728200724.35630-1-carenas@gmail.com>
        <20190728221904.GA21379@sigill.intra.peff.net>
Date:   Sun, 28 Jul 2019 21:54:00 -0700
In-Reply-To: <20190728221904.GA21379@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 28 Jul 2019 18:19:05 -0400")
Message-ID: <xmqqmugxl9uf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E22AD0E6-B1BC-11E9-93B0-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Jul 28, 2019 at 01:07:19PM -0700, Carlo Marcelo Arenas Bel=C3=B3=
n wrote:
>
>> This series is a reroll of jk/no-system-includes-in-dot-c with
>> cb/xdiff-no-system-includes-in-dot-c applied on top with minor
>> fixes for the commit message based on feedback from Johannes
>> and the example put forward by Peff with his own patches.
>>=20
>> The changes proposed shouldn't affect any systems (except for
>> the 3rd one) and that has since shown to also be needed
>> in Alpine Linux (because of _XOPEN_SOURCE redefinition).
>>=20
>> The last 2 patches are new to the series and just cleanup
>> the dependency list in xdiff.
>
> Thanks, these all look good to me.

Thanks, both.  They look good to me too.
