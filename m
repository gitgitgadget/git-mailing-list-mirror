Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 306A5202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 06:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932815AbdJQG02 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 02:26:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57597 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756941AbdJQG01 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 02:26:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 195FCB9A28;
        Tue, 17 Oct 2017 02:26:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KaauFbDKslWVldesfxtxRzklATI=; b=RD1BLv
        LGO4FTGH+ZeEST+VJL3z5Vfrzu2JFlQVnirLZmHnHefB1K3KbQGztvLdPlhScAzU
        twYXBEaLV4sKWmSG3Arws2/f43CXaYFKV4AzOllnaq6fQVZi30EQpYXT+rHMqT7A
        I7iBctL2ZDqT2BHehiKXlqQohxmIQ7kdjZt74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ef7oQSP4gD+F0/P0Qro/LM4bKhHpZIHq
        Gcw0L0FChSaXPluzTfycHVmTPVhfja4zTjOdBBFSs53q58owdUP3dbdx6+1at1wd
        ZXNpBSunD3rWFkwAlrgyPlynModzIfiD6V0PiJhUGcsvmxa8FggoYSKEmHoSlKHY
        2WXSTAodzAY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E5A5B9A27;
        Tue, 17 Oct 2017 02:26:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80D7DB9A26;
        Tue, 17 Oct 2017 02:26:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk configuration
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
        <20171012021007.7441-1-gitster@pobox.com>
        <20171012021007.7441-2-gitster@pobox.com>
        <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
        <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
        <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
        <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
        <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net>
        <xmqqshemtoth.fsf@gitster.mtv.corp.google.com>
        <20171016215311.m72jarmqhjagy6o6@sigill.intra.peff.net>
        <xmqqo9p6r3ai.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 17 Oct 2017 15:26:25 +0900
In-Reply-To: <xmqqo9p6r3ai.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 17 Oct 2017 10:06:29 +0900")
Message-ID: <xmqqvajenvce.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A9760B6-B304-11E7-8B3B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> After pondering over it, I have a slight preference for that, too. But
>> I'm also happy to hear more input.
>
> OK, so it seems we both have slight preference for the "peel back"
> approach.  Adding Jonathan to Cc:

It was a bit more painful than necessary to make sure I have
something that can be merged for 2.14.x maintenance track, but I
think the topic is now in a reasonable shape, and I've merged it to
'next'.  On the first-parent chain from 'master' to 'pu', the merge
of this topic is the very first one, and after reading it over once
again, I think this is OK.

Thanks.
