Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7639C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 09:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4447611CA
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 09:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhFAJqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:46:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64106 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFAJqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 05:46:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32968B17C4;
        Tue,  1 Jun 2021 05:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=4K71KvewG/3BDtv6vA2A0/e5tw3q/10fN9WVBo4k+VY=; b=KUfs
        UikitZ/nAxW2HaP+J5jhbhPWyOyQ4Bl46XUO9oXxnAV8kjii4A6W9TP9auLnW0y9
        vIyg403oWMCApk68Ha85gXPyhZ9naVE2IQjRjU+LNUj/mpJ4hEq11KHgMviDOdXE
        4B/LQIYpG5oSbiGNSW2kAliO5ne07oPed0qO3Hw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26A19B17C2;
        Tue,  1 Jun 2021 05:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D6B8B17BE;
        Tue,  1 Jun 2021 05:44:52 -0400 (EDT)
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
Date:   Tue, 01 Jun 2021 18:44:51 +0900
Message-ID: <xmqqfsy1udf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03A1B3DE-C2BE-11EB-A8D8-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I suspect it would be simpler to read and easier to understand to
>> bring the parethesized part front, e.g.
>> 
>>     If you are pushing to the same repository you pull from (which
>>     is typically `origin`), then you need to ...
>> 
>> as it would avoid "the project is not centralized, but I push to my
>> own repository and pull from it---what should I do?" questions.
>
> The top of `push.default says:
>
>   Different values are well-suited for specific workflows; for instance,
>   in a purely central workflow (i.e. the fetch source is equal to the
>   push destination), `upstream` is probably what you want.
>
> We already brought up the central workflow, I think it's fine to reuse
> the concept below.

Oh, thanks for finding another instance to be corrected.  Even in
that sentence, the more important point is that upstream would be
appropriate if you push to the same place as you fetch from, and
we do not have to say "purely central" at all.
