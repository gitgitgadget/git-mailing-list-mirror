Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73E3C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B389D6141F
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhEHKp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 06:45:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52313 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhEHKp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 06:45:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3502F120123;
        Sat,  8 May 2021 06:44:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+iWjDbUEa+eN
        aShSYXBmno/nZcHu4vzINq4y6vAFtxM=; b=IrMqLYglnT2RQ1g4v+jsPgjiyDh6
        +7piD8Cw3cw2Xz5N4OEuT397BgHJVLlwXDW8Ys56+VZYWUzMyh15rjacWxsDMJPz
        5uEgrXhU7bPjA3t14LuXUsEq1tsjTvIX0QGuQRx/ltuswdj3zCEfmEWtPQMX5GHl
        7dXvFTNMXtNVQ5c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21C3E120122;
        Sat,  8 May 2021 06:44:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4C953120121;
        Sat,  8 May 2021 06:44:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/6] mailinfo: stop parsing options manually
References: <20210421013404.17383-1-congdanhqx@gmail.com>
        <cover.1620311544.git.congdanhqx@gmail.com>
        <1fb08bb37dc534296b3bf89efc9bfaad67a9b068.1620311544.git.congdanhqx@gmail.com>
Date:   Sat, 08 May 2021 19:44:51 +0900
In-Reply-To: <1fb08bb37dc534296b3bf89efc9bfaad67a9b068.1620311544.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Thu, 6 May
 2021 22:02:20 +0700")
Message-ID: <xmqq4kfdv718.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6BF3DCC8-AFEA-11EB-9E4F-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> In a later change, mailinfo will learn more options, let's switch to ou=
r
> robust parse_options framework before that step.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  builtin/mailinfo.c | 75 +++++++++++++++++++++++++++-------------------
>  1 file changed, 45 insertions(+), 30 deletions(-)

Looks quite straight-forward, thanks to the previous step.

Nicely done.
