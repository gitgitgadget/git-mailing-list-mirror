Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927B0C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 22:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6513760D43
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 22:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJ2WzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 18:55:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56193 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJ2WzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 18:55:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B882015EFDF;
        Fri, 29 Oct 2021 18:52:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pUWqE7hhCqAn
        Byj6KKryTMySkv2BiRUISxwxBBP5Dr8=; b=X+gpNE/GA/NDNYShHKdtAIxgeDBo
        C69E9irCHFto1y2Osr5k242N5llj15Yw/usmzcD0tS+052ovmDB7pSGGcbCORrl/
        Nzl8r8U9cgkuqWclnxbKCtWh/TwQ6S6IzIZ+/jipf+SoH9EBvWqiNujEf6KdNdUZ
        6ZRbxeQMf94jUY8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B16E815EFDE;
        Fri, 29 Oct 2021 18:52:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68CB715EFDD;
        Fri, 29 Oct 2021 18:52:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/8] test-lib: add prerequisite for 64-bit platforms
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <489500bb1dcaffecab42672658990cfc26d52d7c.1635515959.git.gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 15:52:43 -0700
In-Reply-To: <489500bb1dcaffecab42672658990cfc26d52d7c.1635515959.git.gitgitgadget@gmail.com>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Fri, 29
        Oct 2021 13:59:14 +0000")
Message-ID: <xmqqtugzh29w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EDD7985C-390A-11EC-97A0-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlo Marcelo Arenas Bel=C3=B3n via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> +test_lazy_prereq SIZE_T_IS_64BIT '
> +	test 8 -eq "$(build_option sizeof-size_t)"
> +'
> +
>  test_lazy_prereq LONG_IS_64BIT '
>  	test 8 -le "$(build_option sizeof-long)"
>  '

In the longer run, LONG_IS_64BIT wants to be renamed to indicate
that it is at least 64-bit long.  LONG_HAS_64BIT, perhaps?

Obviously it can be left outside the scope of this series.
