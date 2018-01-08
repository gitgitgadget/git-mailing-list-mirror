Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FEC1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 23:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756235AbeAHXRu (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 18:17:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53941 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755752AbeAHXRt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 18:17:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8322B91E0;
        Mon,  8 Jan 2018 18:17:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g8r+02bGPnFwqr9riQBjMArOH1s=; b=hrkhVW
        x7e8xFtLFpbuFVBTCN8BQB5ldP1xGYwwPo/9f/v8jUFQq5NF50OelEC/+qB0/mqY
        XNHmzyuDrc4VlW2EWIGIEHoxnZnVqJ//aOU4LB+LdJrxZWbORZ2XUoLb5SnViVgb
        tiaivT9+VI090Cvpo8spP5aYbPTBD85Hm1J2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cG4voQq38ZJWTPqCQLOMCj8KjB1LSg1R
        6gq8TYseVYGNcQUYVB2r6MR1/0C4F4Ecwl/9yxjVEhioLy/3grQvhy6BTJyR18Sy
        0rtMWOUeRrYTNzY+CgNhzjULaUEOiU8U4K/skRbL0JsLdWYFYjvGT0+uXiPc8Rhn
        P3A5L4IozVQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BFE49B91DF;
        Mon,  8 Jan 2018 18:17:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C925B91DE;
        Mon,  8 Jan 2018 18:17:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 5/7] convert_to_git(): safe_crlf/checksafe becomes int conv_flags
References: <20180106004808.77513-1-lars.schneider@autodesk.com>
        <20180106004808.77513-6-lars.schneider@autodesk.com>
        <xmqq4lnw82hi.fsf@gitster.mtv.corp.google.com>
        <FFFF054A-6049-49A6-9B31-3E2D6585B21A@gmail.com>
Date:   Mon, 08 Jan 2018 15:17:46 -0800
In-Reply-To: <FFFF054A-6049-49A6-9B31-3E2D6585B21A@gmail.com> (Lars
        Schneider's message of "Mon, 8 Jan 2018 23:47:20 +0100")
Message-ID: <xmqqmv1o6iud.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23FFF638-F4CA-11E7-80F5-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Nice catch. I'll fix that in the next iteration.
>
> Is it OK if I send the next iteration soon or would you prefer
> it if I wait until after 2.16 release?
>
> Plus, is it ok to keep the base of the series or would you prefer
> it if I rebase it to the latest master (because of a minor conflict)?

I do not see this topic as a fix for grave bug that needs to go to
older maintenance track---it is rather a new feature, isn't it?  So
a rebased series that cleanly applies on top of 2.16 final would be
a reasonable way to go forward.

Thanks.
