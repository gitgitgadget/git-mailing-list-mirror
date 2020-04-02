Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F89C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 18:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8399820721
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 18:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ab9g5o5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389070AbgDBS0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:26:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54440 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbgDBS0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 14:26:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 454BC40450;
        Thu,  2 Apr 2020 14:26:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CZ86EqeaAhT7MiAaFpLQoEDUJqA=; b=ab9g5o
        5T8kVRrZQButPd1QCjM6Qow9D5xJUMQLePzJuTesDM3aRjllvpNFqjkhRIdvwx5X
        5xofTtb32SRJy91/uvupxtRZ5ncfzhQrLUCNRmgdX0InX4EJA6Mdml9HKSbxCaQ3
        QosSW6mC6KS1XOjLr/4Ff0nCwuuFB1I2wY7jA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qIiCQBIOxbpKHo/cMJx08+lqWClGEZq7
        qNJBsUveVAwb+8bHpeo+ZxmWaQGWWaJDZI5nmjaAd0L1Se6aYpNO3pofiRx6NbPA
        qA2ZXcSWA+qTzl0cZyxyfNEv/wcWkprjAWBM239Wt8kg/8tZ4oO/gLAU3Hy6qEyn
        EqwgV446lMM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C23A4044F;
        Thu,  2 Apr 2020 14:26:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBCB34044E;
        Thu,  2 Apr 2020 14:26:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v6 0/7] New proc-receive hook for centralized workflow
References: <20200304113312.34229-1-zhiyou.jx@alibaba-inc.com>
        <20200402163520.1338-1-worldhello.net@gmail.com>
Date:   Thu, 02 Apr 2020 11:26:11 -0700
In-Reply-To: <20200402163520.1338-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Thu, 2 Apr 2020 12:35:13 -0400")
Message-ID: <xmqqftdl3fss.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E8C063E-750F-11EA-8B91-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> ## Changes since v5
>
> + Fixed code review issues on v5.
>
>   * s/cannot to/cannot/
>
>   * s/FLEX_ALLOC_MEM/FLEX_ALLOC_STR/

OK

>   * Add flag `C_LOCALE_OUTPUT` on test cases which may break
>     gettext-poison test.

We prefer to avoid the C_LOCALE_OUTPUT prerequiste when we can use
test_i18n<stuff> to make the poison test not care.  If it is too
hard to arrange in these tests, it is OK to omit, though.

>   * Note: `rp_errors()` in "receive-pack" is executed on the
>     server side, I think leave them unmarked for i18n is better.

Hmph, I vaguely recall saying something similar and then got a
disagreement from somebody.  Perhaps Jonathan (cc'ed)?

Thanks.
