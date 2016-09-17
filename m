Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10162207DF
	for <e@80x24.org>; Sat, 17 Sep 2016 03:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755349AbcIQDsW (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 23:48:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60669 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755467AbcIQDsV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 23:48:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B6BF40E63;
        Fri, 16 Sep 2016 23:48:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6Mbm0xPzlbHhomMASlSS2QlzLfM=; b=EtJE/p
        d5p0lrhVBYN5a0wkQtjL/GjkrFSCq3NbblI8t9ALDjBLzFZGkn9C9L7jz4XUjIN9
        nRDTbH/Hi+bIy4ad1S9oGLtT8sFcB2N3Y5SR2jartl6SKNjVMPSKuH1uwfJbhzgk
        lL1g7kTJbMfHIRJXYV4TB74E9oDQFctyVLFBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZOX5pN0ahp1pRDcXhEZWpACvAxcgmJV3
        UZZIK5V7EBJaaaE1hhKbtzvnisVsI/MDvobKX3Jc6mxCGG2tyr8FwuCJ5jbLScRw
        HPQMYL5JLPEnh6Xi//WnkPY4FWjyJV4JmB5I0XQRWUDEj9azeSFTyEvLMtPYFSko
        2pcQ8WXwTxs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7125240E62;
        Fri, 16 Sep 2016 23:48:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED08640E61;
        Fri, 16 Sep 2016 23:48:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC/PATCH 2/3] mailinfo: correct malformed test example
References: <cover.1474047135.git.jonathantanmy@google.com>
        <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
        <cover.1474047135.git.jonathantanmy@google.com>
        <5dbb0b0f64906fd18c217908cd2c04e74d80fa68.1474047135.git.jonathantanmy@google.com>
        <xmqqk2ebk5zh.fsf@gitster.mtv.corp.google.com>
        <2bfc2fc7-f16b-6d51-7353-54d38353464a@google.com>
        <xmqqbmznihe0.fsf@gitster.mtv.corp.google.com>
        <3a27685f-a53b-03a7-93d5-0492638faf51@google.com>
Date:   Fri, 16 Sep 2016 20:48:16 -0700
In-Reply-To: <3a27685f-a53b-03a7-93d5-0492638faf51@google.com> (Jonathan Tan's
        message of "Fri, 16 Sep 2016 17:31:44 -0700")
Message-ID: <xmqqpoo3gpa7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 926504D4-7C89-11E6-AB2B-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>   From: bogosity
>     - a list
>     - of stuff
>
> Unchanged, the subsequent patch would break this test because it would
> interpret that as a multi-line "From" in-body header when in-body
> headers are *not* disabled.

Yes, that is totally expected.  So I would be perfectly fine if your
patch changed the test vector for that case, saying "Allowing a
folded in-body header means the expected result for the above three
lines has to change".

