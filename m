Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B9F1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 12:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934284AbdACM6q (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 07:58:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59520 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933987AbdACM6p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 07:58:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEE6C5A71D;
        Tue,  3 Jan 2017 07:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dQRGC0bXeag8dGLkUWY73Ti+wcI=; b=xtLjPF
        Sh1SBIlkVFrhvc0+Cl4DabDnxrWSLKhsX3VWglNXzHqj9XnetvQcLHTR6ujrrZqb
        Sij72LoXQ4hRWj02IXIiOdp+Nm6ymETEqA5vPf9SIZGNacdNVY/uKDdaVYDSfVC3
        gzp7yT3Q5Rwt23sMmUCeHa0NkMI0FHqJYXzxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J/4SGwptsYboE3UOq6bxTqUdFbSslODq
        Ukk3/3YPw1fTYG8Vu76TPLNM1NvRtpi94i2jzfa9aXN8D5PbgjI10mLQbvKds+Mf
        kuGWB6fJSri4I1ROr4bfOxErqxYq5Qe4i3r6i/MdpfMMs3ydWGFkfdQQbsGO7rpd
        VZ73TG8fEn4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A4545A71C;
        Tue,  3 Jan 2017 07:58:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAD1D5A719;
        Tue,  3 Jan 2017 07:58:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 06/21] t1700: add tests for core.splitIndex
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-7-chriscool@tuxfamily.org>
        <xmqqvau59ocy.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1TwVvsvuffyHuzse_9afbNvSEJtyQyWzn6Rc4KwJNwHQ@mail.gmail.com>
Date:   Tue, 03 Jan 2017 04:58:42 -0800
In-Reply-To: <CAP8UFD1TwVvsvuffyHuzse_9afbNvSEJtyQyWzn6Rc4KwJNwHQ@mail.gmail.com>
        (Christian Couder's message of "Mon, 2 Jan 2017 09:29:21 +0100")
Message-ID: <xmqq8tqs47wd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B6FE310-D1B4-11E6-AADE-D6957A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Ok, I will add a patch to update the style of the existing tests at
> the beginning of the series and then use the same new style in the
> tests I add in later patches.

That's not what I meant---I was expecting and was willing to accept
a corrected patch that leaves existing old-fashioned ones as they
are while making sure that added ones are modern, to reduce the cost
of finishing this series, leaving the style fixes of existing ones
for future clean-up task that can be done by anybody after the dust
from this series settles.

A preparatory clean-up patch before the series like you plan is fine
(eh, rather, "extra nice"), so... thanks.
