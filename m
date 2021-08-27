Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555E0C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 15:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FDF60F5B
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 15:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245442AbhH0QAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:00:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58334 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbhH0QAc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 12:00:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51CF6ED333;
        Fri, 27 Aug 2021 11:59:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9vRw1EQ7GTeW
        5ZEV6NplahfvIIC5rbdtBCL6Qt7kRuY=; b=Sh8t/16I3bBazhH1yxq3QJgYZX/5
        dKI8L+DpQSdqdGxMomgmFvHrk7+/EmnODcy8uXYWhKFltO12BeoBbAAMrzrLCcmr
        uKPdH/u0SFUzwrLWHSfKQCBhEL9s/uCUJdDG4JlQl3ASf1NyAybRuScXvEvOtY44
        8nWZbhInu3NB5ZE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A0ECED332;
        Fri, 27 Aug 2021 11:59:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96ACDED330;
        Fri, 27 Aug 2021 11:59:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>
Cc:     Bryan Turner <bturner@atlassian.com>, Jeff King <peff@peff.net>,
        Git Users <git@vger.kernel.org>
Subject: Re: git log --encoding=HTML is not supported
References: <9896630.2IqcCWsCYL@localhost.localdomain>
        <CAGyf7-FhLQKQyCOishyrZHg0J+jk6=aszE3hMoH=L0j+0+TP7Q@mail.gmail.com>
        <xmqq5yvsgqt7.fsf@gitster.g>
        <3883941.fE8Og5qy2N@localhost.localdomain>
Date:   Fri, 27 Aug 2021 08:59:40 -0700
In-Reply-To: <3883941.fE8Og5qy2N@localhost.localdomain> ("Krzysztof
        =?utf-8?Q?=C5=BBelechowski=22's?= message of "Thu, 26 Aug 2021 22:52:36
 +0200")
Message-ID: <xmqqk0k6c1zn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CA1D921E-074F-11EC-A27A-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Krzysztof =C5=BBelechowski <giecrilj@stegny.2a.pl> writes:

> Dnia czwartek, 26 sierpnia 2021 17:37:40 CEST Junio C Hamano pisze:
>>         git log --html \
>>                 --format=3D'<tr><td>%h</td><td>%s</td>...</tr>'
>
> I would like to be able to say:
>  { git config i18n.logOutputEscape HTML; }
>
> What do you think?

It depends on what it does.

If the configuration means that "git log" output (with any supported
options, like "-p") will be given with '<' written to '^lt;' etc. so
that it becomes safe to dump it in HTML, it fails to interest me at
all.
