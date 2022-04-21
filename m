Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A302C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 17:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390808AbiDURiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 13:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390806AbiDURis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 13:38:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8E04927B
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:35:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 75AB71936F7;
        Thu, 21 Apr 2022 13:35:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4DqyEuGUH19k
        6OViaKqkIEOBJ3UlFQbqzv7M/PS4++g=; b=gBV5UfXv1gaxkdWclu1nEg3x2e1E
        uqonpMR8HiyLJ4GAnydRGA6owEOkVG7oL8v8urxiFquoVA2QLr68rrayow7fnvJg
        HLrP9RbB/iteeRuaPpXPAoO9x8xt4aY68zsVNtCM2K+nJ36ZfXdtjH9wq7MdkRmK
        S3btTppLGF72FKc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6685B1936F4;
        Thu, 21 Apr 2022 13:35:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA5571936F3;
        Thu, 21 Apr 2022 13:35:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 0/6] hook API: connect hooks to the TTY again, fixes a
 v2.36.0 regression
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
Date:   Thu, 21 Apr 2022 10:35:51 -0700
In-Reply-To: <cover-0.6-00000000000-20220421T122108Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Apr
 2022 14:25:25 +0200")
Message-ID: <xmqqmtgejq4o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7E007EF0-C199-11EC-8AC0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This fixes the regression reported by Anthony Sottile[1] with hooks
> not being connected to a TTY. See 6/6 for details.

It is surprising that it takes 6 patches that rewrites ~100 lines
and adds ~200 new lines, which would need to be treated as a new
development with its own risk of regressions (hence going through
the normal review cycle, starting out of 'next', and gradually
getting merged down), instead of being able to be fast-tracked.

Let's see who comments on the patches first and perhaps people may
shoot to gain "works with Git" star by testing it ;-)

Thanks.
