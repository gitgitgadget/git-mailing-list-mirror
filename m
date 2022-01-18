Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F70AC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 21:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbiARVuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 16:50:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60427 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiARVui (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 16:50:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0EC2101E4E;
        Tue, 18 Jan 2022 16:50:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZU9Cty4PQOMMFB9zUwNZe2aGUDQo21h5VNVBgT
        B7DlE=; b=S6ZN83/CdZ0LH+ee5PYP52yYfF8V6el/SnAbSm7H9M1BKneurcWhli
        ENok11eTeOUG73pq6tkQrQ4KzVm9zFXwtqYHO4MlPbvRvaz/+Un/7lT9jAIBHwwQ
        lVFP8iyOnKUWA2Cg72qwjUwnF1nc2Os0i+r88k1BAmYP3Z8NMYKHc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8A3C101E4D;
        Tue, 18 Jan 2022 16:50:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 23107101E4C;
        Tue, 18 Jan 2022 16:50:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: unset trace2 parent envvars
References: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
        <xmqq35lqetzw.fsf@gitster.g> <Yecv7H5rrdMnRJBs@google.com>
Date:   Tue, 18 Jan 2022 13:50:35 -0800
In-Reply-To: <Yecv7H5rrdMnRJBs@google.com> (Josh Steadmon's message of "Tue,
        18 Jan 2022 13:23:56 -0800")
Message-ID: <xmqq4k60sogk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABAB990A-78A8-11EC-8A69-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Yes, due to the number of different TRACE2 modes, I figured it was
> cleaner to allow them by default and then explicitly unset the ones that
> cause trouble for trace parsing tests.

I think I would agree that it is a better solution, and the design
behind it (which makes me say it is better) should be recorded in
the log message (and possibly in-code comment near the place we
reset them) to help future developers who may add more TRACE2
variables.

Thanks.



