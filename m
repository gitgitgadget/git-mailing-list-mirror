Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F365FC433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 15:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C97207DF
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 15:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pt4hbANM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgGHPny (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:43:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55782 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbgGHPnw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 11:43:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C83569F05;
        Wed,  8 Jul 2020 11:43:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y5ZiO/8QbBarAYsHLs1mI9mUPOg=; b=pt4hbA
        NMI+YnXQU1HRadKBC+M38kEUwBvF6swLf2JB3qWut8aDzyUg92WBVaUoUkUxWECj
        6j6S88TNUnBpUcQ6IVxKGGwXXn4TGFG0Xx9KJhi0998MMc91LjaHm/vRaWcK923a
        T8/84pu86PybIgWuSpF82tmXvQvLlTkt1fL/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fY1/NHF56Se/SPdQ7CzKol/SJW47WNVr
        wI99ztzjEgpaZ3C7veLuevdpJcyT/IPYc6nbTtpSduVXUln/uY8tEvCCnrDC0bYD
        Wh/9YfyqHTimKzVWaHtSRkfataELH9EiJkWzbUd308qie1pcWbA9lerJIMlNYWi/
        xKrCzqUSRhw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 649C669F04;
        Wed,  8 Jul 2020 11:43:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECDF769F03;
        Wed,  8 Jul 2020 11:43:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: mr/bisect-in-c-2, was Re: What's cooking in git.git (Jul 2020, #01; Mon, 6)
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2007081630180.50@tvgsbejvaqbjf.bet>
Date:   Wed, 08 Jul 2020 08:43:49 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2007081630180.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 8 Jul 2020 16:31:16 +0200 (CEST)")
Message-ID: <xmqq36622eru.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D174A5EE-C131-11EA-AADB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  Rewrite of the remainder of "git bisect" script in C continues.
>>
>>  Expecting a response to reviews.
>>  cf. <nycvar.QRO.7.76.6.2005230007260.56@tvgsbejvaqbjf.bet>
>
> Maybe you could change this to
>
>    Needs more reviews.
>    cf. <20200701133504.18360-1-mirucam@gmail.com>
>
> ?

Thanks, absolutely.
