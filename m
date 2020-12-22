Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D7FC433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 19:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EAC723137
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 19:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgLVTnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 14:43:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59472 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgLVTnO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 14:43:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A63B10213B;
        Tue, 22 Dec 2020 14:42:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xfo/nlvnvQp/MrOFWL5FfQ9fu7c=; b=SaARuz
        rGYYmOCO2OUPo/PaCrL+IWKNvl8+ST7y/pkGoxC3DDIisJ+pV0rB5jLcZpRChC3x
        Lf8y2BN62vsxT5Bd6JGqCjAsjx+zZ/XOU3Gvft233KYjj1kcW6hbzm5etkLrThoH
        oWhGbczzE3ekb4L/ct8t4agiafGqHeXuB3KNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NO6rK2gaFEuM3/KAUW4aQAqB4RXldDIY
        4jCXVVVRcHHfTcLYgRbe1gnx2h4TaAIUE3TphtMJHVirfI4GCkvbCIpv7KPogxLU
        ZmIl3CJs1NOF4zd0FQu6CW7gxismYoiFmEpH9DzyvE2bSc//DFPTySX0OtQIGgtC
        H7YLWfZL1/U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8271310213A;
        Tue, 22 Dec 2020 14:42:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B8A14102139;
        Tue, 22 Dec 2020 14:42:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
References: <20200901074355.GA4498@dcvr>
        <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
        <20200901144323.GA14554@dcvr>
Date:   Tue, 22 Dec 2020 11:42:27 -0800
In-Reply-To: <20200901144323.GA14554@dcvr> (Eric Wong's message of "Tue, 1 Sep
        2020 14:43:23 +0000")
Message-ID: <xmqqbleliq58.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D319EDE8-448D-11EB-BFAC-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Thanks for the comments, will wait a few days for comments
> before sending out v2.

This has seen some review suggestions and as far as I remember, can
be summarised as:

 - there was a rough consensus that this was a desirable feature.

 - a one-off hardcoded list of "false" would rather want to be
   consistent with config.c::git_parse_maybe_bool_text().

 - documentation is missing for the configuration variable.

It has been almost three months; has a v2 been posted that I missed?

Thanks.
