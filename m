Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF83C433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 22:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F83B222F9
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 22:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgL1W7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:59:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50545 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgL1W70 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 17:59:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEA2C890CF;
        Mon, 28 Dec 2020 17:58:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=G5t9TKrUpb30
        Ubd42bosRCRiKek=; b=aQkzRBvCMMDV8ZsDhsPOJDslbA2J8n9WQlNYXl7MvHDP
        fkR3X8uxYg3zTb2+npW4e0WY0Zb/7Q5Zf2ve7gmvHjcBmXtja76kW7/nv4IaTPs9
        czQAqIXm3KIEKfeaWwNvj8WhgAoyy3BsGMX+HsXC1dINwLys/eCgYGbjqvC5Iv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aJrNY1
        8MDuRt3Jc/x3Yo040bJfyImZVQk3Xb4VSSOLP04s2kJLNca70QqoE5UNqg+NlMQG
        X0CAzgqJGsgB88wR1dkStKOi3R3LigVh6eRRodD69qrgmFVJ4Aw+1Ess0zINyFFe
        jTaD6BCWHUTwpU2dat5ctDY7hoQ3EJhoU6ggM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6D5C890CE;
        Mon, 28 Dec 2020 17:58:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5080E890CD;
        Mon, 28 Dec 2020 17:58:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] CoC: update to version 2.0 + local changes
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
        <20201228171734.30038-3-avarab@gmail.com>
Date:   Mon, 28 Dec 2020 14:58:42 -0800
In-Reply-To: <20201228171734.30038-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 28 Dec 2020 18:17:34 +0100")
Message-ID: <xmqqmtxxedwd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3BC5DA24-4960-11EB-9195-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This change intentionally preserves a warning emitted on "git diff
> --check". It's better to make it easily diff-able with upstream than
> to fix whitespace changes in our version while we're at it.

I think there are only two lines that needs to tolerate trailing
whitespaces, and even if we strip them, it should be still easily
diff-able with the upstream with --ignore-space-at-eol or whatever
appropriate option, so I am not sure if it is worth try "keeping"
these whitespace breakage.

If you still want to do so, we should tweak .gitattributes so that
"git diff --check" would not trigger.

> 1. https://www.contributor-covenant.org/version/2/0/code_of_conduct/cod=
e_of_conduct.md

Yes, thanks for the full URL.  In 5cdf2301 (add a Code of Conduct
document, 2019-09-24) we pointed at the HTML version, but if we ship
MD and they have MD, using theirs as the base makes perfect sense.

Sign-off plus acks need to be collected here.

Thanks.
