Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5077C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 03:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiBODEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:04:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiBODEk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 22:04:40 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E392BD88B
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 19:04:30 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95F671851FE;
        Mon, 14 Feb 2022 22:04:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Kgszicx5RSpZoc+JgjyXUZR0b
        jE/yNG+iwTTXHZSjmE=; b=eAXKyt/6YSlt/WhIF3jOAw7iTT9/DS8y8HzxhpXEM
        gczqY5bKvS/jFKmyS1kbhtQT2IW/7hvw0Sgc7kXNFsT6mTY7WvV8MXVQAPNmY4+T
        Qe9KGGTs5DILXyna+S0HbGKVoyjHwbbGRqKZrW7+G6UpafzMqGHgdsw4QankKQNv
        as=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8DFBF1851FD;
        Mon, 14 Feb 2022 22:04:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EB8A61851FB;
        Mon, 14 Feb 2022 22:04:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] date API: create a date.h, split from cache.h
References: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net>
        <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
        <patch-2.5-7de62956db4-20220202T195651Z-avarab@gmail.com>
Date:   Mon, 14 Feb 2022 19:04:25 -0800
Message-ID: <xmqqo838zv7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC4541CC-8E0B-11EC-A121-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Move the declaration of the date.c functions from cache.h, and adjust
> the relevant users to include the new date.h header.

It makes the patch larger than it could be to split off part of
cache.h into a new header and force users to include the new date.h
in the same commit, rather than first including date.h in cache.h
so that users do not have to change, and then update the inclusion
in a separate follow-up commit.   The end result looks OK, though.

