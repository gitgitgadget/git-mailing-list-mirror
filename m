Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36A0C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829CC61004
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhEQTrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 15:47:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64283 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbhEQTrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 15:47:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0BDDBEEE7;
        Mon, 17 May 2021 15:46:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ho5RFNAqjkMO
        75AjRHGH5ozrTALzSOtn1wA/RE5Jo+w=; b=wlkSF5PdSAqCzgxw0k4HstmFjQaf
        wBJVISLYh2O0AxB9y6N8LRpo7k8m/Otyu3Df7u7nOnPLf4AE0F97sT4ugnXNbsD8
        gTDLGqtLYtYsPGiGtlfNbCLTZ7OBw2uc2ey+lNVGufxyvsOkhEpSdT6M0DWG0dc3
        jjidLcjsMEd7va0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E49F9BEEE6;
        Mon, 17 May 2021 15:46:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49547BEEE3;
        Mon, 17 May 2021 15:46:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] t7500: remove non-existant C_LOCALE_OUTPUT prereq
References: <20210517151222.2865093-1-tmz@pobox.com>
        <87wnrxqphw.fsf@evledraar.gmail.com>
Date:   Tue, 18 May 2021 04:46:01 +0900
In-Reply-To: <87wnrxqphw.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 17 May 2021 18:42:34 +0200")
Message-ID: <xmqq5yzh6t52.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82B2A2EA-B748-11EB-B7A2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Thanks. This is obviously correct.
>
> Junio (added to CC): I also think it makes sense to pull this into rc1,
> since we have 3d1bda6b5b new in 2.32.0, and will be skipping this part
> of its tests everywhere without this patc.h

Yes, this is an obvious fallout of what we did during this cycle and
needs to be fixed up before the release.  Thanks for noticing and
fixing so quickly.

