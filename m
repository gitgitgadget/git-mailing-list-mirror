Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10A0C433DB
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AF261920
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCUQzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:55:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50409 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhCUQzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:55:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FEDAA81DA;
        Sun, 21 Mar 2021 12:55:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ns9jfdowP6okZ8oiKQANA7pzSso=; b=cgW6vA
        wHaovbVzgAqCqDb2UUxZg+5E+NqeTpYw7JU1s6uY0mS160+OMA/iNpH3VGnGTB4d
        ybSXbHAZr2oOQ4RHALd7fIlOowplHQUdvrjqPf9QLccL6sUPT1qEJe1guyobovKJ
        wX4+O6R/vr779HFXFjKL+r0K1SpQiGf6MGsCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tb8Cw5ARJP8ktC1rgm1glAl799NLmjxF
        inSO3Vnipoh50xPYnhTOcpxtIJfb6GPdaDL2EbcPiiL4otUvjc0sWVGizXV6pFxY
        4LUohhjXcxcDSPmWzROQiysmlE3LIT7uuP+F3Y/QqPIppKFj+JZMUUeJSnZyVLa+
        xIOtbHgaVp8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8239A81D3;
        Sun, 21 Mar 2021 12:55:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80FEAA81C7;
        Sun, 21 Mar 2021 12:55:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis" <geko1702+commits@99rst.org>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] gitweb: redacted e-mail addresses feature.
References: <pull.910.git.1616283780358.gitgitgadget@gmail.com>
        <xmqqft0pcagu.fsf@gitster.g>
        <20b1b63fe22560205d7e7c50b9f826e5.squirrel@mail.kodaksys.org>
Date:   Sun, 21 Mar 2021 09:55:00 -0700
In-Reply-To: <20b1b63fe22560205d7e7c50b9f826e5.squirrel@mail.kodaksys.org>
        (Georgios Kontaxis's message of "Sun, 21 Mar 2021 06:43:47 -0000")
Message-ID: <xmqqsg4obg63.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D41306A-8A66-11EB-B7D6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Georgios Kontaxis" <geko1702+commits@99rst.org> writes:

>> And more importantly, I do not see why it should be made impossible
>> to override per repository/project in a multi-tenant installation.
>> Some projects may be more "privacy" sensitive than others.  Those
>> who want to use tighter setting should be able to enable it even
>> when the side-wide default is set to false, no?
>>
>> Thanks.
>>
> I was actually thinking about the other way around;
> preventing projects from disabling this feature.

Yes, it cuts both ways, and override should be allowed for most
cases (unless absolutely necessary for healthy operation of the
system) for a simple reason that anybody who sets site-wide default
is not in a better position than those who set per-repository or
per-project setting to judge what is good for them.

Thanks.
