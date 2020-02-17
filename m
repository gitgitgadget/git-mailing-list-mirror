Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D590C34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56442064C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lHaNnbTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBQRIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:08:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63873 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgBQRIo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:08:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC7CDAF4F7;
        Mon, 17 Feb 2020 12:08:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iI4PbFAQIxEJddR7fR0S48jogZs=; b=lHaNnb
        TpdDCF30hsOUkNHYfFc21QHvGCpBwntNc3YNekpTpjixKBxOlRL3veaR/nBUx7xM
        +FpMPlwOBiWXZyuuADZhnpFdumYMNVWG62g4YrxYxxyXLG1iaKjf1K8wlkhOFsLF
        PQi8HrG9B1h7T5APVv4FNxL6HHEDL6Opi/BkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gak36vE4ehkrA379WxurgeLOadMXihE6
        5EeuvfuyZYfVI/vRRbNiOdmZnO6hyO0KTpSSU0ZlJSe6YWgpsyiE2+vV/uocWLLg
        eYuQPy+Lwr/T3pWmaUaReRDujLwQLfRb/4u1ZMnR8NCugfJfX1K2wBzU5qgwLxj5
        bKB42W2Gbac=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A41E1AF4F6;
        Mon, 17 Feb 2020 12:08:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C76A5AF4F2;
        Mon, 17 Feb 2020 12:08:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/ci-squelch-doc-warning, was Re: What's cooking in git.git (Feb 2020, #02; Mon, 10)
References: <xmqqmu9qxej1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2002120036570.3718@tvgsbejvaqbjf.bet>
Date:   Mon, 17 Feb 2020 09:08:37 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2002120036570.3718@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 12 Feb 2020 00:39:29 +0100
        (CET)")
Message-ID: <xmqqv9o5kup6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2494FB1A-51A8-11EA-A89F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 10 Feb 2020, Junio C Hamano wrote:
>
>> * js/ci-squelch-doc-warning (2020-02-10) 1 commit
>>  - ci: ignore rubygems warning in the "Documentation" job
>>
>>  Squelch unhelpful warning message during documentation build.
>>
>>  Will merge to 'next'.
>
> To be clear, this _is_ a warning message, but the CI builds are _failing_
> because of it (the "Documentation" job expects `stderr` to be clean except
> for some known warnings).
>
> As a consequence, all the PR builds at https://github.com/git/git are
> failing (except for PRs targeting `pu` or `next`, but I don't think that
> there are currently any).
>
> So maybe we could fast-track this change all the way into `maint`?

This has happened on Friday at 4e52c1ae ("Merge branch
'js/ci-squelch-doc-warning' into maint", 2020-02-14) and all
integration branches seem to be happy as of last night (I
tentatively dropped a topic or two from 'pu' to make it happen ;-)

Thanks for keeping an eye on the CI results.

