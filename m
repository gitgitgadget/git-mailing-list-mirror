Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B19C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 19:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56993613AD
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 19:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhFATgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 15:36:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60015 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFATgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 15:36:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 110ADC65EA;
        Tue,  1 Jun 2021 15:34:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=mfvhyU5gX6Pqg+y/3wgyj2LmH8A3VZaOYcTPoQRBsME=; b=Mo/1
        HgQUWkM5Z5MvR8zxq58GO8qKuazLg/LP+YoQTPImTdJqHcAW+j5CGWQKXNCUsUot
        TMqBJX7OqCAWx+s7CuEtOUWuBDyIBTDU2rYo63aAuJdeHHw/PHjIShy7saWOSotK
        2p0+zuYFKfAPk51i8x4nvqWDUAD82uzNIRKPkC0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 068D9C65E9;
        Tue,  1 Jun 2021 15:34:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84360C65E8;
        Tue,  1 Jun 2021 15:34:52 -0400 (EDT)
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
        <xmqqv96zwkl0.fsf@gitster.g> <60b49a3ae829b_24d28208fd@natae.notmuch>
        <xmqqfsy1udf0.fsf@gitster.g> <60b62420858c4_e409520828@natae.notmuch>
Date:   Wed, 02 Jun 2021 04:34:51 +0900
Message-ID: <xmqqpmx5s7j8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FAFC82A-C310-11EB-8F77-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Therefore your proposal:
>
>   If you are pushing to the same repository you pull from (which is
>   typically `origin`), then you need to ...
>
> is actually better, I just had to remind myself that centralized and
> same repo are not the same thing.

Yes, that is exactly why I brought up

>> as it would avoid "the project is not centralized, but I push to my
>> own repository and pull from it---what should I do?" questions.

as a reason why we want to phrase it that way, so we are on the same
page ;-)

