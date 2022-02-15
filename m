Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41431C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 23:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbiBOX4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 18:56:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiBOX4y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 18:56:54 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0D2C9A06
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 15:56:43 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1555E129178;
        Tue, 15 Feb 2022 18:56:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=13qe8qnEU+Zdc0hVZIdI05VSKRHa6U8s+y844i
        3OQGw=; b=f491MeDnvs7wpZkmzPJHHAjQYpVu6WLgkpVS24UzJDQ+jNoAzg3+Xe
        pW3FWFS61CSe70OScPcEVPYhOQ8ecauoGDFUmQ6vDWjR3+rfBXPwDUJ0XC1CHdfG
        zJaG+KyQm3nrDZl6D8O0N/y06h7Ovl4kN+pnNCGBHPBJwKxgCnNK8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B552129177;
        Tue, 15 Feb 2022 18:56:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66CDB129176;
        Tue, 15 Feb 2022 18:56:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chen BoJun <bojun.cbj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2022, #03; Sat, 12)
References: <xmqq5ypj6rw6.fsf@gitster.g>
        <20220215020923.38168-1-bojun.cbj@gmail.com>
Date:   Tue, 15 Feb 2022 15:56:38 -0800
In-Reply-To: <20220215020923.38168-1-bojun.cbj@gmail.com> (Chen BoJun's
        message of "Tue, 15 Feb 2022 10:09:23 +0800")
Message-ID: <xmqqfsojznt5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAB45222-8EBA-11EC-B85C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chen BoJun <bojun.cbj@gmail.com> writes:

>> * cb/clear-quarantine-early-on-all-ref-update-errors (2022-02-01) 1 commit
>>  - receive-pack: purge temporary data if no command is ready to run
>>
>>  Check if "receive-pack" will do any ref updates (various conditions
>>  could reject a push) before received objects are taken out of the
>>  temporary directory used for quarantine purposes, so that a push
>>  that is known-to-fail will not leave crufts that a future "gc"
>>  needs to clean up.
>>
>>  Will merge to 'next'.
>>  source: <20220129063538.24038-1-bojun.cbj@gmail.com>
>
> I noticed that the merged patch was v2, not v3 which I sent last week. Apart 
> from a more complete commit message, there is no change in patch v3. So merge 
> patch v2 is OK.

Sorry, my mistake.  The log message in the updated one reads a lot
better.
