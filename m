Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A47EC433F5
	for <git@archiver.kernel.org>; Wed, 18 May 2022 22:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiERWDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 18:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiERWDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 18:03:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79B6282451
        for <git@vger.kernel.org>; Wed, 18 May 2022 14:53:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC9E218D68D;
        Wed, 18 May 2022 17:53:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Uqbm2UnJpCYH
        SIQ0qUG1ZCMY6hvgj8lGzdq8ZU05Hj4=; b=L1qN+yvEDa7jOQqAQkP1iSZskz3+
        Q+TpZrqh5Rrnpgwhvv6/OP04sBCrZ+SYgW7gCtczq3DvIeBN7etbCaX8gw9NKvcN
        ZvCcOdu1OuZCQ6wmneyTr7RiKvDNgVBmZlJ98jzZVkhnug/e5WlhyGgZnStwA6gq
        VJJb2F214uWpD+4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4DB018D68C;
        Wed, 18 May 2022 17:53:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1684F18D68A;
        Wed, 18 May 2022 17:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 8/8] hook API: fix v2.36.0 regression: hooks should
 be connected to a TTY
References: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20220518T195858Z-avarab@gmail.com>
        <patch-v2-8.8-238155fcb9d-20220518T195858Z-avarab@gmail.com>
Date:   Wed, 18 May 2022 14:53:53 -0700
In-Reply-To: <patch-v2-8.8-238155fcb9d-20220518T195858Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 18 May
 2022 22:05:24
        +0200")
Message-ID: <xmqq5ym2tslq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 02A0EC92-D6F5-11EC-9FBC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In the preceding commit we removed the "stdout_to_stderr=3D1" assignmen=
t
> as being redundant. This change brings it back as with ".ungroup=3D1"
> the run_process_parallel() function doesn't provide them for us
> implicitly.

This part I recall commenting on the earlier round.  The above
message and the change in the patch makes sense.

Thanks.
