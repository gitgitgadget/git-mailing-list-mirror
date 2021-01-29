Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DDFC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6714F64E00
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhA2Ami (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:42:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50559 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhA2AmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 19:42:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6B31126537;
        Thu, 28 Jan 2021 19:41:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Eri8of1ukahYQUQo7b1sOCS/oas=; b=S2pnDP
        ZbZsIrRWM7ZmOGu2G7c56KcHbPo9uI8dBtzFt/j/F9myqYzgnSG9sDfVkaidRHIJ
        +E6LikXBLeWhW4JNEfBWko2Maa6DxfjP6gqMMbRE5zc3lRN8kIxWYNXcUq4ULmPH
        zndxm7TG0t4NHRQkWNAikeHfqTO+wv5IU/WSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qf/Q5LG22c4SYDVWqn9Y/yFM1lQIrWLB
        xW8mt4Hm8AYE6H/KkXlQmqWyMrORdFA3Q7iR6pql5+3Kko9HFt8yPfvDxlQbaX4q
        LIiXXwcuP3WCzb5NPw4PvZsvXZ5A73jveCk2OWtGVybZ+W4Uywu64y/Wi2f+Mmbp
        R3A/8WFpt60=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DF939126536;
        Thu, 28 Jan 2021 19:41:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27F42126535;
        Thu, 28 Jan 2021 19:41:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
References: <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
        <20210110072902.GA247325@ellen>
        <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
        <20210116042454.GA4913@ellen>
        <YAo9aTkZBCSGLYTT@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2101221728410.52@tvgsbejvaqbjf.bet>
        <YAte7ixZYdz1AOMX@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2101261522200.57@tvgsbejvaqbjf.bet>
        <20210126180635.GA28241@ellen>
        <xmqqr1m71mty.fsf@gitster.c.googlers.com>
        <20210127033714.GA16914@ellen>
Date:   Thu, 28 Jan 2021 16:41:31 -0800
In-Reply-To: <20210127033714.GA16914@ellen> (Seth House's message of "Tue, 26
        Jan 2021 20:37:14 -0700")
Message-ID: <xmqqh7n0vakk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC16727E-61CA-11EB-8018-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> Sorry if it seemed like I left that thread hanging (busy week). Thanks
> for your reply(s). I'm finishing a v10 patchset with that change which
> I'll submit to the list for review this week.

Thanks.
