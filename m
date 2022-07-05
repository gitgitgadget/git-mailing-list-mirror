Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C200CCA47B
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 17:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiGERx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiGERx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 13:53:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07202BCA
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 10:53:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7AAEB19E24E;
        Tue,  5 Jul 2022 13:53:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dHKk/mRnu83Y
        pT7FnTm6v+urVEqgROF1jcJOXns5xSs=; b=eWEmRhy/tHRixWkuTafTHmYmVDzO
        /NMujF6VXh/GhEuSimLurFqUBMOCMhlYDpI1IpBksivDKV2kILmcG9o3Frg9T/qm
        3FR6fbIbF2TEe34vUK0AIUnDuzC6rqb0NXxa8lLw4HZQyD4T3WUn7vcK8kTf7lpW
        mXW17mbOr2UgK7k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7273319E24D;
        Tue,  5 Jul 2022 13:53:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66ECF19E24C;
        Tue,  5 Jul 2022 13:53:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] remote-curl: send Accept-Language header to server
References: <pull.1251.git.1654678407365.gitgitgadget@gmail.com>
        <220609.86leu6thon.gmgdl@evledraar.gmail.com>
        <2022061010332322021051@oschina.cn> <xmqq1qv3m2rf.fsf@gitster.g>
        <202207051804341356418@oschina.cn>
Date:   Tue, 05 Jul 2022 10:53:49 -0700
In-Reply-To: <202207051804341356418@oschina.cn> (lilinchao@oschina.cn's
        message of "Tue, 5 Jul 2022 18:06:25 +0800")
Message-ID: <xmqqy1x7jviq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D334864-FC8B-11EC-90AF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

> I wonder if we can use a new protocol-capability like local-lang
> or something else, then Git client and server can tell each
> other's language ability in the negotiation stage.

That is how I read =C3=86var's message you were responding to.

Having said that, a mechanism that applies only to HTTP transport
was already there, and the patch in question recognises that the
coverage of the mechanism is incomplete even within the HTTP
codepath and attempts to make it more complete.  Unless we are
planning to deprecate the HTTP specific mechanism and replace it
with protocol-capability to cover other protocols in the same way,
I do not think it is a bad idea to have it.

Thanks.
