Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C3C202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 04:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbdKBEkh (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 00:40:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63523 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751030AbdKBEkg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 00:40:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17F6CADA77;
        Thu,  2 Nov 2017 00:40:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vRQrpsHfZfvVTLywAa3Jrk9/rVg=; b=o0HGvs
        ZnVdpilzdMlMwmsN+lYqi+kDNRAqm8IPkgTh9YvjS2RLeMCHburLRQGHRZIRP0cH
        n1prFdqMEz7bPhHJOcM4lRMmQsV+jlid6M42uiXC9tlajYgU+4pXPV13wZnbwrGt
        YG/yUDxoIm3sK/F2aBPjylIMyqjr35Fn9zo0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xX16IcaIDjAZ3ybb5IgkBBmjna93822c
        Syrhn/3L8CJbloLW6idyshqf4qSm5ZeJkqdHiWJ2WkNQZKy23TA6LR/AdoO0NvDm
        mLsyM75FgmnDyuzQFylTLYOGLRjY2qwLvOXclpRDz+L8oy/6Hi1I5dwp05pkITL3
        fD8F1ob/hxc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EF45ADA76;
        Thu,  2 Nov 2017 00:40:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C4AEADA73;
        Thu,  2 Nov 2017 00:40:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] wrapper.c: consistently quote filenames in error messages
References: <22afeefa-cdd5-cd32-0a7c-6bad4de79f05@web.de>
        <32c515d01d4257c1532004d0bf21b2c330f6b81b.1509547231.git.simon@ruderich.org>
Date:   Thu, 02 Nov 2017 13:40:29 +0900
In-Reply-To: <32c515d01d4257c1532004d0bf21b2c330f6b81b.1509547231.git.simon@ruderich.org>
        (Simon Ruderich's message of "Wed, 1 Nov 2017 15:44:44 +0100")
Message-ID: <xmqqvaitqon6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4ADF442-BF87-11E7-96F0-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Ruderich <simon@ruderich.org> writes:

> All other error messages in the file use quotes around the file name.
>
> This change removes two translations as "could not write to '%s'" and
> "could not close '%s'" are already translated and these two are the only
> occurrences without quotes.
>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>  wrapper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This patch is incomplete without adjusting a handful of tests to
expect the updated messages, no?
