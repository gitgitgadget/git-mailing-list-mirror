Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC682C28B2B
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 20:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346053AbiHRUbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 16:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346103AbiHRUal (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 16:30:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED575EDDA
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 13:30:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BA851C09B6;
        Thu, 18 Aug 2022 16:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T3AhQQHw6X0vaaA3QJ7Vr/iljlsD5UQgw0LwKy
        2dAH8=; b=JhPuZi412z+adwe9oj4aUPZl08sUt4jnU8hjg4hNN8mI6uK5wDAazC
        ZSc/nR1BP74YmxgPe3ZqGj8jo8g3OWGz2StQmtv8BRoDUqmXOi+keNZ1V9lkxpZS
        OJPMdSwTOy20VUV7kfo2cSRaHYSg+TnZr0H14VJhmkKFjoGdjZIqU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23EA51C09B5;
        Thu, 18 Aug 2022 16:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B35F21C09B4;
        Thu, 18 Aug 2022 16:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/4] sequencer: do not translate parameters to
 error_resolve_conflict()
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
        <cover.1660828108.git.git@grubix.eu>
        <4684d54aeb3e00c96ba581c824a04e47b7236db7.1660828108.git.git@grubix.eu>
        <220818.86v8qp8uid.gmgdl@evledraar.gmail.com>
        <CAA19uiTDeVmUHRVd8JK+qLmwTCN_eiY49yEJERi1mLn9oU4hYA@mail.gmail.com>
Date:   Thu, 18 Aug 2022 13:30:34 -0700
In-Reply-To: <CAA19uiTDeVmUHRVd8JK+qLmwTCN_eiY49yEJERi1mLn9oU4hYA@mail.gmail.com>
        (Michael J. Gruber's message of "Thu, 18 Aug 2022 17:23:39 +0200")
Message-ID: <xmqqpmgxnvkl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D612F6C-1F34-11ED-AD9F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Rather than setting out to do that, I'd retract 2/3/4 just to get 1
> done, which was my original motivation ... or switch git to C again as
> I did for a while in the past ...

While I found 4/4 a bit questionable, these early three patches
looked eminently sensible to me.
