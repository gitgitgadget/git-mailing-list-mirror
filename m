Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D6CC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558CC61414
	for <git@archiver.kernel.org>; Sat,  8 May 2021 10:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhEHK60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 06:58:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63227 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhEHK60 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 06:58:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FF1B134E2C;
        Sat,  8 May 2021 06:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=26PUmUM46THV
        gxbsX61cprWjLTNagQdzYREKiq1bUEg=; b=RZzjzXGU6Ybb+U9FDdUZvcQEAEAP
        jRKuK1xTtsjDYEs3KXNX3HCgJgonMRIqGpQz2TqJ/oNmI4V8cAMR6WOSBV7QevP6
        xISRZRjVg/4vDX3M2HqB1zXiI1NEIHLflSLFQC8J6uXCpEEHjAmB7+K4GVq9kbku
        kGEx9iSDKlgz6do=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E94C7134E2B;
        Sat,  8 May 2021 06:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 211F0134E2A;
        Sat,  8 May 2021 06:57:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/6] Teach am/mailinfo to process quoted CR
References: <20210421013404.17383-1-congdanhqx@gmail.com>
        <cover.1620311544.git.congdanhqx@gmail.com>
Date:   Sat, 08 May 2021 19:57:19 +0900
In-Reply-To: <cover.1620311544.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Thu, 6 May 2021 22:02:17 +0700")
Message-ID: <xmqqv97ttrw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 29B0741E-AFEC-11EB-AE8E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> When SMTP servers receive 8-bit email messages, possibly with only
> LF as line ending, some of those servers decide to change said LF to
> CRLF.
>
> Some mailing list software, when receives an 8-bit email message,
> decide to encode such message in base64 or quoted-printable.
>
> This series try to help users of such softwares deal with such patches.

Thanks.  Use of parse_options() did make the overall series longer,
but the result looks a lot nicer.

I've left a few comments, but overall the series looks almost
perfect ;-)
