Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68ADD1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 19:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbcH3TP0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 15:15:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59697 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750846AbcH3TPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 15:15:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E8E73A2BB;
        Tue, 30 Aug 2016 15:15:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C2SVE3klc94Ep6x7myK9qBARyQw=; b=rAsvkI
        H5fL2xg9gUb8cwRMHhsYl4MdXhgJYtpbRAV3m/wnm2wdU484/2hmf26fADX6DgPi
        y6l9ulsqgDMJD1Q5AHTKMCBP3INd6lvUooXYPRC3Tt8a/QKcY6wJIt5E9xO5x+8E
        j6Lzw3MhN230uTTAQGUQc3oRihbefXDnUt4Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DqgANpXmSfULYheLiyab+0m/4z8QqGe4
        s0QjO/Xuump1KMY3wWq29E3Sz8/Uv7cwXllQ4DGyZYmqSnOTaXc2i2h/yTMQendL
        JhmDIKMcdfpf/9Al0TsrKMkPBwN4HVUfaoq7oN5iaenDvNNsnLNNm8qEahlLWgl7
        rBAvClo+qtI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3592C3A2BA;
        Tue, 30 Aug 2016 15:15:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3BDC3A2B9;
        Tue, 30 Aug 2016 15:15:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] t/Makefile: add a rule to re-run previously-failed tests
References: <b2d016e44fa04e8a318967c43762d6933faf7956.1467183740.git.johannes.schindelin@gmx.de>
        <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
        <20160830084357.rdmt2ehngrz6rqaq@sigill.intra.peff.net>
Date:   Tue, 30 Aug 2016 12:15:21 -0700
In-Reply-To: <20160830084357.rdmt2ehngrz6rqaq@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 30 Aug 2016 04:43:57 -0400")
Message-ID: <xmqq37lm3w6u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19DD2EF2-6EE6-11E6-9B77-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm, interesting. Your approach seems reasonable, but I have to wonder
> if writing the pid in the first place is sane.
>
> I started to write up my reasoning in this email, but realized it was
> rapidly becoming the content of a commit message. So here is that
> commit.

Sounds sensible; if this makes Dscho's "which ones failed in the
previous run" simpler, that is even better ;-)

