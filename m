Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0837820133
	for <e@80x24.org>; Fri,  3 Mar 2017 19:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbdCCTTy (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 14:19:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53619 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751809AbdCCTTv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 14:19:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6648764B43;
        Fri,  3 Mar 2017 14:19:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KQN/aKuKoTLZtGVXqguNWI5ovmU=; b=SK4O5V
        ce1kWx8AUkdacEpwhwMHrKYkRfEakMNGbwefqEtR21AZ3SMDaDdXEW1J0Su+1IAJ
        hNFQW3ttisCuqTgzt4V30HEyU7GZuPzYKVPHb47HQdKG2wL+JLFIDiJ50TOjjYbj
        h8tnplgAjR7tK2whPKKDEOxGT3jwkQEFCV354=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WbGgn+m4mSnlyADS0aJWrI+tZ/SeME/2
        dsTC1EjZ4Bg5XrbmA5l13Bs1MQbloHzYwyTk4neazO7geWX07xFE5PDL9i4rnz3U
        z9boRRb7rfe7bksTN8DOtC14BMIMUu9tEPdU7u2YUdvQhYkLOmIqIrlK7EsfR4EZ
        RWjiA957ztg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DBFE64B42;
        Fri,  3 Mar 2017 14:19:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BFD8C64B3C;
        Fri,  3 Mar 2017 14:19:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Allan Xavier <allan.x.xavier@oracle.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] line-log.c: prevent crash during union of too many ranges
References: <20170302172902.16850-1-allan.x.xavier@oracle.com>
Date:   Fri, 03 Mar 2017 11:19:02 -0800
In-Reply-To: <20170302172902.16850-1-allan.x.xavier@oracle.com> (Allan
        Xavier's message of "Thu, 2 Mar 2017 17:29:02 +0000")
Message-ID: <xmqqlgsm88yh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 437BAB34-0046-11E7-8202-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allan Xavier <allan.x.xavier@oracle.com> writes:

> The existing implementation of range_set_union does not correctly
> reallocate memory, leading to a heap overflow when it attempts to union
> more than 24 separate line ranges.
> ...

I'll add "Reviewed-by: Jeff King <peff@peff.net>" and queue, as I
know we already reviewed the change.

Thanks.
