Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3C0C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 01:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A10610C9
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 01:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhIJBgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 21:36:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61580 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhIJBgq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 21:36:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6796BE1609;
        Thu,  9 Sep 2021 21:35:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Q4VKHL/9IoyQ
        ZWILG+16V3++ZqKEPy+GZW9SCYQ13Hg=; b=gUuD01HEvW2yWGJA+xb2ZXGmZPOw
        7ksSlSPT7bjthvsqqa1GsI38FKWu3Eoe9J+flOSuX4zJSQ3+Zk1vS2h9Xia8MCnu
        fEAXv/EALZvO7vwd6wopvzM6CFBu08gw5ZYcrXUqZ82k1RRsG/6W7zc7uB0Uc8B4
        JUvlHwynngK2VGg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A9E1E1605;
        Thu,  9 Sep 2021 21:35:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8BEEE1604;
        Thu,  9 Sep 2021 21:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v2 0/9] packfile: avoid .idx rename races
References: <cover.1631157880.git.me@ttaylorr.com>
        <cover.1631228928.git.me@ttaylorr.com>
Date:   Thu, 09 Sep 2021 18:35:35 -0700
In-Reply-To: <cover.1631228928.git.me@ttaylorr.com> (Taylor Blau's message of
        "Thu, 9 Sep 2021 19:24:21 -0400")
Message-ID: <xmqq5yv9w6u0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 655B3074-11D7-11EC-8A1B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is a relatively small reroll of mine and =C3=86var's series to pre=
vent
> packfile-related races when moving the `.idx` into place before other a=
uxiliary
> files are renamed.

Will replace.  I didn't see anything questionable in range-diff (of
course, lack of anything is hard to spot but at least there is no
new iffy stuff and there wasn't anything iffy in the original, so
... ;-)
