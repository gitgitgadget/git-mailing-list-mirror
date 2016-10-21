Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C9A20229
	for <e@80x24.org>; Fri, 21 Oct 2016 17:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932684AbcJURTL (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 13:19:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57041 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932626AbcJURTL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 13:19:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAAEF450FC;
        Fri, 21 Oct 2016 13:19:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DOaJeWaFlLWaPmB7W3vSSXKF5FY=; b=o2ddDS
        yKWk99vO8vqsPQxnatpvOw5l5xdbbe/D3cpWtxd0Xth+IO7r4hErOKZocIQAzh5J
        JArnC/dI830XM8KZO+yHIELVJGxV6B6u0tMXhyq6gVJHckaH5RcedDLHvuolZ2yA
        og0x70lKVtDMR0IIigCYyr0/UkInvQX1Xpv1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RJah8tMe1wqnPwsKqXrBCGi4XUR36eg2
        w0BmlybgcwNGifQ4YuOKNq9H0hnMyGyhSPtnyhzp/bR1MlT58d3kKJFikxr11w8V
        KHCKtMdt3K2aWPGBAeKiDtBOROhFZzdlckAxfVQFErq/W1bU5mAsEk2vGro/sFq2
        zP2hC7FsugA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E313B450FA;
        Fri, 21 Oct 2016 13:19:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 651AA450F6;
        Fri, 21 Oct 2016 13:19:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: [BUG] [PATCH]: run-command.c
References: <20161021055013.GA31554@dimstar.local.net>
        <20161021090029.glr5u6gwrxluavir@sigill.intra.peff.net>
Date:   Fri, 21 Oct 2016 10:19:07 -0700
In-Reply-To: <20161021090029.glr5u6gwrxluavir@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 21 Oct 2016 05:00:29 -0400")
Message-ID: <xmqq37jpd3hw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A5DF83E-97B2-11E6-84D4-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> 16:42:45$ cat /proc/2601/cmdline | xargs -0 -n1 echo
>> /bin/sh
>> -c
>> echo $PWD;sleep 600
>> echo $PWD;sleep 600
>
> This duplicated argument is expected and normal.

Well explained.  Thanks.
