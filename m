Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C557520C11
	for <e@80x24.org>; Tue, 28 Nov 2017 02:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbdK1CKX (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 21:10:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60143 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751393AbdK1CKW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 21:10:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 123D8A3A9B;
        Mon, 27 Nov 2017 21:10:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LKBkDDZNiZSE/EaGuXnvlc5njG4=; b=ZJ4+MG
        tCu+qrIpTdOfodp7fL0MZpOvkRkWKx7COZyF1AUyhSNqFyMW2XABEo/f20ntlP+4
        9vO9XBPHOQQ2aleTi0m547TD31uLmT5uNQ7F5GZ8Np5PRz55fxsXtUtjUjJafFle
        c75gkim9Kpi77iA+PZLG2buEgEtaZoR0GZ018=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cy9BkebQ838zFtwogDJWqypR+TPH/MPU
        OgknJbRU50FPL+E7BRQoWM0H1ib4LWDazZILIibpoD/AWCmjx51XTweJUCKFWsJR
        CmSRiuZB7ntDH+2CHtdH8kF5LJrVLStECgYKqDOnVuXi+5mdZiEzA8LZxxEoTY6q
        W0q8QCVnfG4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08167A3A9A;
        Mon, 27 Nov 2017 21:10:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75E19A3A99;
        Mon, 27 Nov 2017 21:10:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     mwnx <mwnx@gmx.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pretty: fix buffer over-read with %> and %<
References: <20171126025222.7831-1-mwnx@gmx.com>
        <xmqqh8tgfq8g.fsf@gitster.mtv.corp.google.com>
        <20171127232927.x5iamt5rlxrafkhe@debian>
Date:   Tue, 28 Nov 2017 11:10:20 +0900
In-Reply-To: <20171127232927.x5iamt5rlxrafkhe@debian> (mwnx@gmx.com's message
        of "Tue, 28 Nov 2017 00:29:27 +0100")
Message-ID: <xmqqtvxf886r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49A83742-D3E1-11E7-A89E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mwnx <mwnx@gmx.com> writes:

> On Mon, Nov 27, 2017 at 10:46:23AM +0900, Junio C Hamano wrote:
>> By the way, Documentation/SubmittingPatches has this in "(5) Certify
>> your work" section:
>> 
>>     Also notice that a real name is used in the Signed-off-by: line. Please
>>     don't hide your real name.
>
> (especially since I'm not quite sure what the rationale behind it
> is).

As DCO is something we'd need to present to the court when the next
SCO comes after us, we'd prefer to see that we can refer to, and
contact if necessary, a real person when we need to say "this is not
a stolen code, here is the person who presented it to us and we'll
let him or her explain".

> What are your thoughts on this issue?

Not limited to this, but our stance for things are that previous
mistakes do not justify repeating and spreading the same.
