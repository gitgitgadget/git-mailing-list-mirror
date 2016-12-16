Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 130F21FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 05:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbcLPFAR (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 00:00:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63124 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750799AbcLPFAP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 00:00:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4911F58F6D;
        Fri, 16 Dec 2016 00:00:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6SnDcMJVsIpKf6ULu4wJIGD33I4=; b=j/IG84
        b8fcfP1GaAoCSpzFJrP6SJXGP2xAGHg24hBfrPY7bDZlBP7RIiWZ0kX30gw0e5He
        d2LEvQ+9Mg5BTXqXfz8sec8PpJHq2K7LiPF/l+T/JnOdd6ev+HBKR7eLvZmHEDNF
        axs+nFDqScu0t3alKEYsCIcQqULBWIHMKwlyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jDksKSxqK9vT05taOciPZyrXUQwT/+Z5
        NGrUmhGSKKoy2XqUIiSfRkrllWejfo4xkAyv0kUaIi1qdtZSPszp8tJeqhLaFHA3
        sCSEEZxxi+Nb4h1qybiRRWthAAxUXr0nZBMaUfI1wTlBv3PpyPQvG67NBHCMAqOW
        LoJ1l8BAtIc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 144AD58F6B;
        Fri, 16 Dec 2016 00:00:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17BB758F5B;
        Fri, 16 Dec 2016 00:00:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        git <git@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Remove no longer used second struct cont
References: <1481806438-30185-1-git-send-email-geert@linux-m68k.org>
        <20161215162336.GA18152@pathway.suse.cz>
        <20161216013706.GA20445@jagdpanzerIV.localdomain>
        <CA+55aFz3B2BfjG54z7ALOwezCHSdQp+YbFaHcJkCg=fzoKtfNg@mail.gmail.com>
        <1481853432.29291.76.camel@perches.com>
        <CA+55aFxaOFoh+Zrm5tNhU4hWu4Z032+nqV3vXK=QPJyhZsU3_A@mail.gmail.com>
        <1481855446.29291.80.camel@perches.com>
Date:   Thu, 15 Dec 2016 21:00:07 -0800
In-Reply-To: <1481855446.29291.80.camel@perches.com> (Joe Perches's message of
        "Thu, 15 Dec 2016 18:30:46 -0800")
Message-ID: <xmqqtwa4tqnc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85D7594C-C34C-11E6-B3BD-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> grep 2.5.4 was the last version that supported the -P option to
> grep through for multiple lines.

Does anybody know why it was dropped?
