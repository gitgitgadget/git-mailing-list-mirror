Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2127FC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9D123A9F
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgLSRJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 12:09:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56686 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgLSRJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 12:09:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72387A67D8;
        Sat, 19 Dec 2020 12:09:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C1mQsY/1hVJwT8Ap8HuSCPXfQGg=; b=C0+OzB
        vAKJRXR4/vsXIreM5eoJeVcm+l5mF+6qGhD13pWkc2gWEGn4sn/Rpkmfwu/aOL8Y
        hzlpqPbk/fuHypzFcFlOqDw5DCWRgAPkXuOP1zqyfMhNYXIdLN8264MS5Vm0T09c
        iDVjj9jBb7Wks2zZC7x97phedCy54ecX9W21Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H6f4/AP8zIe+EZwvdIFqW+PumMIxIzNM
        Q5h7WqSHOzXWLzhKV/yNIZQbEGGFMLp93wyCBAXl5fDpFXZx05Ax6/EpUu68ZFDt
        8Kx5bD44084rDTfI3vYO3zfeGYwVoDtjmjYk1x8kwhTcazEICwrgy5Z2CZNtP41t
        KZtAehFzNnw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68FE8A67D7;
        Sat, 19 Dec 2020 12:09:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E707DA67D2;
        Sat, 19 Dec 2020 12:09:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2020, #03; Fri, 18)
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com>
        <5fde09c1ac7d_1def912083c@natae.notmuch>
Date:   Sat, 19 Dec 2020 09:09:15 -0800
In-Reply-To: <5fde09c1ac7d_1def912083c@natae.notmuch> (Felipe Contreras's
        message of "Sat, 19 Dec 2020 08:10:09 -0600")
Message-ID: <xmqqwnxdpvt0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC85AC9A-421C-11EB-97DB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> * fc/bash-completion-post-2.29 (2020-11-10) 26 commits
>>  - completion: bash: shuffle __gitcomp functions
>>  - completion: bash: cleanup __gitcomp* invocations
>>  - completion: bash: add __gitcomp_opts
>>  - completion: bash: improve __gitcomp description
>>  - completion: bash: rename _get_comp_words_by_ref()
>>  - completion: bash: trivial cleanup
>>  - completion: bash: cleanup _get_comp_words_by_ref()
>>  - completion: bash: refactor _get_comp_words_by_ref()
>>  - completion: bash: simplify _get_comp_words_by_ref()
>>  - test: completion: switch __gitcomp_nl prefix test
>>  - completion: bash: simplify config_variable_name
>>  - completion: bash: improve __gitcomp suffix code
>>  - completion: bash: change suffix check in __gitcomp
>>  - completion: bash: simplify __gitcomp
>>  - completion: bash: refactor __gitcomp
>>  - completion: bash: simplify equal suffix check
>>  - completion: bash: factor out check in __gitcomp
>>  - completion: bash: get rid of any non-append code
>>  - completion: bash: get rid of _append() functions
>>  - completion: bash: remove non-append functionality
>>  - test: completion: add run_func() helper
>>  - test: completion: fix currently typed words
>>  - completion: bash: do not modify COMP_WORDBREAKS
>>  - completion: bash: fix for suboptions with value
>>  - completion: bash: add correct suffix in variables
>>  - completion: bash: fix prefix detection in branch.*
>> 
>>  Needs review.
>
> I think I already mentioned these should be dropped in favor of an
> easier to digest series [1].

Thanks.  I didn't even notice these were still in my tree, as these
didn't seem to get any attention to those who know/care about
completion.

> I just sent another try as a reminder [2].

Will eject and replace.
