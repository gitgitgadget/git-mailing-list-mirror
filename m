Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4ECC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 06:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2E060FC0
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 06:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhIMG2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 02:28:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58798 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhIMG2f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 02:28:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F0FCE2AEC;
        Mon, 13 Sep 2021 02:27:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=umdHyJzhXK8T
        X9Xa95/lGyllNTp54u1c1ap0Vk5Rd8M=; b=goywmYXScX3uaR52wNls8B5439Fl
        KhwZQcxgi9utZeD9k26u9zlkBEoul8oP+HQLRU8oz7Sm8ZfPtANm2nAi+kYUMYYI
        z8N3NpH2X9sDTJyoKxosOL9O27M7xIFwYgIVamSDY3Wpq5+Shi7Ftb0x8k9BYK+w
        hJkWZVWgbTYUxII=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25E0FE2AEA;
        Mon, 13 Sep 2021 02:27:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 422D5E2AE9;
        Mon, 13 Sep 2021 02:27:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] parse-options API: remove OPTION_ARGUMENT feature
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
        <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
        <patch-v2-4.4-4fddce0a38d-20210913T033204Z-avarab@gmail.com>
Date:   Sun, 12 Sep 2021 23:27:18 -0700
In-Reply-To: <patch-v2-4.4-4fddce0a38d-20210913T033204Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 13 Sep
 2021 05:35:40
        +0200")
Message-ID: <xmqqh7epgfcp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A5802A0C-145B-11EC-8419-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Now that the preceding commit has migrated this code over to using
> "struct strvec" to manage the "args" member of a "struct
> child_process", we can just use that directly instead of relying on
> OPT_ARGUMENT.

Nice.
