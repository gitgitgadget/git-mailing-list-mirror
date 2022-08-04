Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19E4C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 21:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiHDVQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 17:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiHDVQU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 17:16:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EF718B18
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 14:16:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 728FB1BF46D;
        Thu,  4 Aug 2022 17:16:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GKXYMLDEYN9R
        m9ObgxVI8+n1/FnM1DbL2JyAtdpAeiA=; b=lMvnsoCsvR3Xmf48+2Unr4KV5aZN
        R2OPtMc/fMS8bUrNlA32GPdBBuvlIc5BvyDzITbI8gaBQFLYgm1cTsXdxFiWJQh4
        lE31j6UvJy2K48ecZLAHUR75Qp380VmWaG8Xt3qIuukW/Fwln4P53Xs0xO8bbzDu
        uE1jWz+2LWpub5o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A93F1BF46C;
        Thu,  4 Aug 2022 17:16:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1DE9E1BF469;
        Thu,  4 Aug 2022 17:16:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v8 01/12] help.c: refactor drop_prefix() to use a
 "switch" statement"
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
        <patch-v8-01.12-8ae30ce2e80-20220804T162138Z-avarab@gmail.com>
Date:   Thu, 04 Aug 2022 14:16:13 -0700
In-Reply-To: <patch-v8-01.12-8ae30ce2e80-20220804T162138Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 4 Aug
 2022 18:28:30
        +0200")
Message-ID: <xmqqo7wz3e1u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC661DB0-143A-11ED-9B1C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This means that we'd in principle strip "git-foo" down to "foo" if
> it's in CAT_guide. That doesn't make much sense, and we don't have
> such an entry in command-list.txt, but let's preserve that behavior
> for now.

That makes sense.  I guess the previous round of this step tried to
say the same thing, but it didn't "click" to me.  The updated text
does make sense.
