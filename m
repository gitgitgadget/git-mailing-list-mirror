Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB07A201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 04:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbdKMEY2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 23:24:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56339 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751330AbdKMEY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 23:24:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EC98B6080;
        Sun, 12 Nov 2017 23:24:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PIAxPk484UZUtjFdr/I+5xGNpVY=; b=lnfNar
        P+nrT6fSDNICcCKtkSvySUjQrnwt7B/9Rom7AoaYaBQorZQhe3/SZWHWV9Y7+KIF
        QHieGk//un+Uyb68YRpaZbUKRHchKo+v0jGl9s8bTznclcTtr/aDOM9uUgAQO/X2
        3/RtyBnesbyU696VaQghiquSu4uSUUWgVNkPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EPXBrmup166P0asuWHESkxXauLZ1xODG
        iqbUInx9Jrwk7Qa5aszjrBiq10tQwXtVc9DbzSU+z6tYRoWcmv7vGHBsYUUXlc29
        cmEn/TUPWO1Bd/aEcmw3i8Jl+8FjgQ7QA+BLLcPFZYfvV+gDZ/DlLA1FrluhNqbG
        G1UouRGmV04=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66220B607F;
        Sun, 12 Nov 2017 23:24:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA759B607D;
        Sun, 12 Nov 2017 23:24:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/4] Hash abstraction
References: <20171112212854.791179-1-sandals@crustytoothpaste.net>
Date:   Mon, 13 Nov 2017 13:24:25 +0900
In-Reply-To: <20171112212854.791179-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 12 Nov 2017 21:28:50 +0000")
Message-ID: <xmqq4lpyajra.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88E71D8C-C82A-11E7-94A3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is a series proposing a basic abstraction for hash functions.
>
> The full description of the series can be found here:
> https://public-inbox.org/git/20171028181239.59458-1-sandals@crustytoothpaste.net/
>
> At the bottom of this message is the output of git tbdiff between v2 and
> v3.
>
> Changes from v2:
> * Remove inline.
> * Add dummy functions that call die for unknown hash implementation.
> * Move structure definitions to hash.h and include git-compat-util.h in
>   hash.h.
> * Rename current_hash to the_hash_algo.
> * Use repo_set_hash_algo everywhere we set the hash algorithm for a
>   struct repository.

Change for all of the above in this series looked sensible to me.
Thank, will queue.
