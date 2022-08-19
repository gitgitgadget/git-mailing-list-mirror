Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AD7C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350332AbiHSSSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350214AbiHSSS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:18:28 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8813AE5C
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:18:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44D8B14679B;
        Fri, 19 Aug 2022 14:18:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=se3VGF9ecX+i
        lseTxXknB1lwYc6oks6JzKBk/ncP/78=; b=IMgrzNhYySIPvSEinEUtK2GxuPAX
        t6DgK4B95g7MSt6WXC1hZek7ZHHc+57CtYkjuLFonHxAbzPgb6OD9vFVpe9QAY0G
        +u8l59CAKMFrqrlZncXQwEvD2IkwErT5ens+IeKWAI8tX/HaLjPf/rrbWwoNRI78
        qXwXLUKk88qsxo4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C05614679A;
        Fri, 19 Aug 2022 14:18:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E9B2146799;
        Fri, 19 Aug 2022 14:18:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 04/20] t0040-parse-options: test parse_options() with
 various 'parse_opt_flags'
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
        <20220819160411.1791200-1-szeder.dev@gmail.com>
        <20220819160411.1791200-5-szeder.dev@gmail.com>
Date:   Fri, 19 Aug 2022 11:18:20 -0700
In-Reply-To: <20220819160411.1791200-5-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 19 Aug 2022 18:03:55 +0200")
Message-ID: <xmqqczcwksgj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4EAC6622-1FEB-11ED-9C60-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> +static void print_args(int argc, const char **argv)
> +{
> +	for (int i =3D 0; i < argc; i++)
> +		printf("arg %02d: %s\n", i, argv[i]);
> +}

It is not November 2022 yet (cf. Documentation/CodingGuidelines).

Curious why "%02d", not "%d", or autoscale for cases where argc is
larger than 99, but I'll let it pass (iow no need to reroll only to
"fix" it).
