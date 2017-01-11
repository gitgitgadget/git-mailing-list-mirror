Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74648205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 20:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757731AbdAKUuH (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 15:50:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57105 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751531AbdAKUtR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 15:49:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C67E5ECBC;
        Wed, 11 Jan 2017 15:49:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hCFKgUGeR8PeLRlr5HnVeaf6T4A=; b=PZjVTi
        JbY903Upkcwyula97qJ7r5pm2Vp7eemb/CwhyfOeCxvzQd2rqnwl/yBKVz40ipmq
        Wdvy4myTkbC55L+bRC2zPexTbC3GKc2FxX4K9fNtseVXOxxsSJN+bb9N5g+RAB+3
        IXzdQ9dla0Dw+uSXBBC0OSyp9AJ0+v8QUEiGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gx7kEjZXNyCTF/i4p552c4YCzHVZo0jv
        CNsk0sBv3QHcxKdFnIDv4hP/lrIRwi5oWXgCbm4VbsW7WZx5jQCjNKGiJ8WYPaOK
        76i4UGltwVd5zJzibaVtgAlZ9c8o/k7FX24/7/p5FY3C4+ERHZH4qhaQ4neDeJ+a
        z0VtCsnF9bI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EFF65ECBB;
        Wed, 11 Jan 2017 15:49:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB97C5ECB8;
        Wed, 11 Jan 2017 15:49:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>,
        "A. Wilcox" <awilfox@adelielinux.org>
Subject: Re: [musl] Re: Test failures when Git is built with libpcre and grep is built without it
References: <58688C9F.4000605@adelielinux.org>
        <20170102065351.7ymrm77asjbghgdg@sigill.intra.peff.net>
        <58736B2A.40003@adelielinux.org> <871swcjsd3.fsf@linux-m68k.org>
        <20170109213303.4rupe5cqwejfp6af@sigill.intra.peff.net>
        <5874B942.7070402@adelielinux.org> <20170110113959.GL17692@port70.net>
        <20170111100400.vhd5ytarqpujigbn@sigill.intra.peff.net>
Date:   Wed, 11 Jan 2017 12:49:12 -0800
In-Reply-To: <20170111100400.vhd5ytarqpujigbn@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 11 Jan 2017 05:04:01 -0500")
Message-ID: <xmqqfukpnwzb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6904D094-D83F-11E6-B3AD-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Another difference I found is that "[\d]" matches a literal "\" or "d"
> in ERE, but behaves like "[0-9]" in PCRE. I'll work up a patch based on
> that.

Wow, clever.

Thanks.
