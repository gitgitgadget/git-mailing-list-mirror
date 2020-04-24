Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFB3C2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 01:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB0B20728
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 01:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="skTPZjFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgDXByK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:54:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57785 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDXByK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 21:54:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84258CC806;
        Thu, 23 Apr 2020 21:54:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bOq/JlZJMx+WZJ7GfX3w5nyblRI=; b=skTPZj
        Fbop8sKHYMbhIjivkyhzWZ3zNyaX+NeWOLiH7n8vCpnlTGkKqFXZMBX8SJuAdi+f
        heJ32skqZfW65kXahGmMeuyP2uG9u/SSuS6TzblQXgPWlcRsmmLn/f5Y4Wr6GzY+
        +zDxptPabD2tI2BT7mT/j5y/S9GhYbCFzA9yU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DXUDx7amkRsL5T7k1KUpEN4jrV1sEk3x
        C1+sE4UHRzUw7u591iJFH0do5bHC9Tf56sUiOzMt+ftpWS+vrI/9DDMZQJBiurnp
        z2SFDeoqeWaexNnS0of1zn8I6k3XulHOeKURnQkjOENNaFnsgu8IgS/uCOs6oD3r
        /5oZf6BI+Sk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B4D4CC805;
        Thu, 23 Apr 2020 21:54:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C107BCC802;
        Thu, 23 Apr 2020 21:54:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 1/4] C: s/0/NULL/ for pointer type
References: <cover.1587648870.git.congdanhqx@gmail.com>
        <c4fac2ae9d10bc426cb26e4a102b808549696763.1587648870.git.congdanhqx@gmail.com>
        <1df91aa4-dda5-64da-6ae3-5d65e50a55c5@ramsayjones.plus.com>
        <xmqqd07xem9l.fsf@gitster.c.googlers.com>
        <20200424010924.GF1949@danh.dev>
Date:   Thu, 23 Apr 2020 18:54:04 -0700
In-Reply-To: <20200424010924.GF1949@danh.dev> (Danh Doan's message of "Fri, 24
        Apr 2020 08:09:24 +0700")
Message-ID: <xmqq8silejib.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7ACAC15E-85CE-11EA-A9B6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> So, to follow that idiom, this patch should be changed, too?
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet/

I didn't look at that patch carefully, but it seems that it changes

	struct foo variable_to_be_initialized = {};

into various forms, e.g.

	struct foo variable_to_be_initialized = { NULL };
	struct foo variable_to_be_initialized = { { NULL } };

depending on the actual shape of 'foo', and that old thread explains
that it is sufficient to consistently write "= { 0 };". 

Having said that, if I recall correctly, Dscho suggested even larger
style fixes to the code, so if that were to happen, the above initializer
fix may just be lost in the noise ;-)

Thanks.

> +Cc: Dscho and Han-Wen
>
>> > [Luc, this topic came up on the sparse and kernel mailing-lists at one
>> > point, but I didn't get around to posting my patch to the list - something
>> > came up. Hopefully, I will find some time to find it and post it soon.]
>> 
>> 
>> [References]
>> 
>> *1*
>> 
>> https://lore.kernel.org/git/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com/
