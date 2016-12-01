Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CE4C1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751111AbcLAUZr (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:25:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56729 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750955AbcLAUZq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:25:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACCEC544EF;
        Thu,  1 Dec 2016 15:25:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4zOHQmLtJQMiM3j9d1CGNZlJrkU=; b=iG2m2E
        2gPc1RuHfXSIYpg3zU80ChNaC/L6SjOEuae/gdjiG1QqSXPdVDI3Je4my1nYKs8x
        +ck1RV67Pte5UHyJ0eX73HnwrJmXSBOVlPSRurU6BiAcaYLwC87dfIwMxEPocnak
        Dbdk8fSk1+9fG261/KK12aXVY1pyoaNrBUxOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eAP4jhm7cKvSAe+6sTE8vJBaX9bMeeeG
        KMlxyOjvAY3U8GORWpgFF2Dz59mbkoSpLlV1sWFLhsBofG3CB/01GFSj5ydjkpK5
        CGf68I7Kr1nPfv8pxADH1rtHmT7CYK9pGLw3oWB6b1yAVa5JrBjKGJZpnPMqMHUx
        3eTWG7/zLeE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D85C544EE;
        Thu,  1 Dec 2016 15:25:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 281B1544ED;
        Thu,  1 Dec 2016 15:25:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] compat: add qsort_s()
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
        <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
        <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net>
        <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com>
        <20161201201917.nqx3v5fl2ptl3bhr@sigill.intra.peff.net>
Date:   Thu, 01 Dec 2016 12:25:44 -0800
In-Reply-To: <20161201201917.nqx3v5fl2ptl3bhr@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Dec 2016 15:19:17 -0500")
Message-ID: <xmqqpolb8khj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 567CF24A-B804-11E6-897F-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 01, 2016 at 12:14:42PM -0800, Junio C Hamano wrote:
>
>> Eh, wait.  BSD and Microsoft have paramters reordered in the
>> callback comparison function.  I suspect that would not fly very
>> well.
>
> You can hack around it by passing a wrapper callback that flips the
> arguments.

Apparently our mails crossed.
