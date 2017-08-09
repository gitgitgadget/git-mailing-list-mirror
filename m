Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25E1208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 19:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbdHITLD (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 15:11:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61554 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751560AbdHITLC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 15:11:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0C528F524;
        Wed,  9 Aug 2017 15:11:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DmB9+w3/uolPj9JpUMivB7GsHJk=; b=ea5I+z
        MNAIsLOZ9qVi8wfhUhUiia9Ox7P87zCEBbPd/L2OcKJQ16X3d3KVMl2SYVzFAjOY
        nwGAUx2L2fC+/wRlhyaDE+Jhe6t94QTLyt5Ei9E5LCAkC9cFfEGfw+CzrInKsWSK
        7N5+02eC0U7NWEU3aSCkPzVoazLETX/B9iTjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J/+cCTCvv/mGc2gm1WK3J1bVYhp8q47x
        x6s0Hu62MX8v0wed4EEmZLjnwafnf6v3zfWKPmh9U9ClaCprSTmRshfo8WiXBO2T
        OgR7BxLPSwUUOa/fG+S+RSq8zRqSxfbZMj+iMTmwrBM3omNoRh1dVkPC49k76BQ1
        zoqO+PvPaIE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D971A8F523;
        Wed,  9 Aug 2017 15:11:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 516E88F51A;
        Wed,  9 Aug 2017 15:11:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Campbell <ijc@hellion.org.uk>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] filter-branch: Handle rewritting (very) old style tags which lack tagger
References: <1502179560.2735.22.camel@hellion.org.uk>
        <20170808080620.9536-2-ijc@hellion.org.uk>
        <20170809102040.l5sb6ukqh2225zqm@sigill.intra.peff.net>
        <xmqqlgms7nbl.fsf@gitster.mtv.corp.google.com>
        <1502305353.2735.33.camel@hellion.org.uk>
Date:   Wed, 09 Aug 2017 12:10:59 -0700
In-Reply-To: <1502305353.2735.33.camel@hellion.org.uk> (Ian Campbell's message
        of "Wed, 09 Aug 2017 20:02:33 +0100")
Message-ID: <xmqqo9ro5zgc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B01F3F2-7D36-11E7-9E70-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Campbell <ijc@hellion.org.uk> writes:

> Indeed. I'll add a --allow-missing-tagger option (suggestions for a
> snappier name accepted!) and pass it unconditionally from the filter-
> branch script.

Thanks.  That's much better.
