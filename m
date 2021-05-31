Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D594AC4708F
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE40B61108
	for <git@archiver.kernel.org>; Mon, 31 May 2021 05:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhEaFQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 01:16:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50848 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhEaFQg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 01:16:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8820212CB0A;
        Mon, 31 May 2021 01:14:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=KBAE/JDuLC3+2yq82owoYHR4GD470FBV4IvB/vOSUcU=; b=OgiJ
        8l1X5Yi++CVKEjvKJMyKwS0jmADUF/skP444iwzVlcH1z0x9EV6fkNXjEULdNFCJ
        PcRXXogEpJaZlzsxFRjxWX1HnaVc33TPqF6Xt14O2BFXnBuhvDF1vuuzsMpnm16G
        YI6dWA4YAuLBXKmroogkN70eHBe8DZzA4LyQMww=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8028012CB08;
        Mon, 31 May 2021 01:14:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7AD2F12CB02;
        Mon, 31 May 2021 01:14:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH v2 6/6] doc: push: explain default=simple correctly
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
        <20210529071115.1908310-7-felipe.contreras@gmail.com>
Date:   Mon, 31 May 2021 14:14:51 +0900
Message-ID: <xmqqv96zwkl0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21D942F8-C1CF-11EB-A3C6-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +If you are working on a centralized workflow (pushing to the same repository you
> +pull from, which is typically `origin`), then you need to configure an upstream
> +branch with the same name.

I suspect it would be simpler to read and easier to understand to
bring the parethesized part front, e.g.

    If you are pushing to the same repository you pull from (which
    is typically `origin`), then you need to ...

as it would avoid "the project is not centralized, but I push to my
own repository and pull from it---what should I do?" questions.

>  +
> +This mode is the default since Git 2.0, and is the safest option suited for
> +beginners.

Nice.
