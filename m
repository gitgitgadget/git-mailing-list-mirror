Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9829C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6AF610F7
	for <git@archiver.kernel.org>; Wed,  5 May 2021 04:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhEEEb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 00:31:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62193 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhEEEb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 00:31:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15DBDCC805;
        Wed,  5 May 2021 00:31:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Xka+T1g6BdD3
        FdVCl6jcxHl+B+5cUyD38g4RbBmHUy4=; b=ySFJyunxsyNcPFVt0aabKkrFlYV6
        +MwXIK/iSAeZ2Di1stSAFnI+JMX2iDfnoFjod3qGmnD3NSODJFlcXjA8w2W68Cu7
        y4NyE2d4LD/URjfel1fStvdWXyE9603Sn8rnJ0bVdy7vNJXlYk8RnTppr2nGx1wj
        H1sFjOXHOSZhfMg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECD8ACC803;
        Wed,  5 May 2021 00:31:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E5E9CC802;
        Wed,  5 May 2021 00:31:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/5] Teach am/mailinfo to process quoted CR
References: <20210421013404.17383-1-congdanhqx@gmail.com>
        <cover.1620148732.git.congdanhqx@gmail.com>
Date:   Wed, 05 May 2021 13:31:00 +0900
In-Reply-To: <cover.1620148732.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Wed, 5 May 2021 00:19:57 +0700")
Message-ID: <xmqq5yzx4xa3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B2352C10-AD5A-11EB-80D8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> When an SMTP server receives an 8-bit email message, possibly with only
> LF as line ending, some of those servers decide to change said LF to
> CRLF.
>
> Some mailing list software, when receives an 8-bit email message,
> decide to encoding such message in base64 or quoted-printable.
>
> This series try to help users of such softwares deal with such patches.
>
> This series is a complete rewrite of v1.
> Hence, no {inter,range}-diff.

Thanks.

I've left a few comments here and there, but like the overall
approach.
