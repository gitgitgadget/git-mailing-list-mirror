Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D7CC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 19:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDA08610A3
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 19:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbhHYTIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 15:08:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62173 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhHYTIS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 15:08:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3ADEFDD565;
        Wed, 25 Aug 2021 15:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4uyHC7ECzEZ9
        Q/n6moMgyL1nnP/w8xKXHf2krxGxdRM=; b=SivV8W7TFUWEOuA2/dPBMHOa+2eQ
        //EDhOMj/V+LRVueuJ57vxrF2+hZfa34PZLsHkZumas90Ih9hzEsl8ufjSmG5B0J
        HfJbvDYbNE3GgnaStV1D50zee802uQEivMoJ7Paguzah/8zxcmVfaCL/XWC8K+wB
        IdOyRFt5osedqW8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32329DD564;
        Wed, 25 Aug 2021 15:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8F3ADD563;
        Wed, 25 Aug 2021 15:07:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] advice: move advice.graftFileDeprecated
 squashing to commit.[ch]
References: <RFC-cover-v3-0.4-0000000000-20210806T191231Z-avarab@gmail.com>
        <cover-v4-0.4-00000000000-20210823T103719Z-avarab@gmail.com>
        <patch-v4-4.4-7f79fb282e5-20210823T103719Z-avarab@gmail.com>
Date:   Wed, 25 Aug 2021 12:07:30 -0700
In-Reply-To: <patch-v4-4.4-7f79fb282e5-20210823T103719Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 23 Aug
 2021 12:44:02
        +0200")
Message-ID: <xmqqk0k9ibrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B2C67898-05D7-11EC-B188-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -static struct {
> -	const char *name;
> -	int *preference;
> -} advice_config[] =3D {
> -	{ "graftFileDeprecated", &advice_graft_file_deprecated },
> -};
> -

Nice.
