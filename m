Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC7D1F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758994AbdKHAtg (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:49:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59534 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758991AbdKHAtf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 19:49:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 963BFB796B;
        Tue,  7 Nov 2017 19:49:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pOo6Is313TTFWblXCXjq/fyGbOg=; b=rx8Q1R
        M28bGYzPhxagFffgddx8xUfg+mrsSs/2yZgXMCj0HjlHaAReQIuVJs6ZMAVhzejw
        7pFVJXx0GZGQ56HjwtnUhwmOBvEy4ZDvwV6HH0/VxrHqIRRgV+nWRorRO680Y02i
        1HTSngiumOvSqZNySKGjAQXh6/gjeuvDdRzvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uGmUl6Ys7ASIr6kYLGJSMX+eKapQEtVz
        LQz5uv7iY2x1BIQTJgOGKoiqwQX8QDJM2OhJBgY8mCqBnRhHOYyDPHA//UVEQRrJ
        8Rm56B6NqouVsLAHf1BISJ4FJuY70dlZOmeDZA3VyiyeFu6F+p/LjJtEJ17CdTHG
        /xutnFmynJA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D697B796A;
        Tue,  7 Nov 2017 19:49:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 054DFB7969;
        Tue,  7 Nov 2017 19:49:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] diff: --ignore-cr-at-eol
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
        <20171107064011.18399-1-gitster@pobox.com>
        <20171107064011.18399-3-gitster@pobox.com>
        <alpine.DEB.2.21.1.1711071345430.6482@virtualbox>
        <xmqqh8u5ob0h.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 08 Nov 2017 09:49:32 +0900
In-Reply-To: <xmqqh8u5ob0h.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 08 Nov 2017 09:43:42 +0900")
Message-ID: <xmqqd14toaqr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0164AAA-C41E-11E7-A9E9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> These "--ignore-*" whitespace options are to help reviewing _other_
> changes without getting distracted by the class of changes these
> options represent.  I guess I may have to update the log message (I
> do not think I wrote anything like that in the documentation update).

Here is what I just did with "commit --amend" (there is no change
in the contents of the patch).

    diff: --ignore-cr-at-eol
    
    A new option --ignore-cr-at-eol tells the diff machinery to treat a
    carriage-return at the end of a (complete) line as if it does not
    exist.
    
    Just like other "--ignore-*" options to ignore various kinds of
    whitespace differences, this will help reviewing the real changes
    you made without getting distracted by spurious CRLF<->LF conversion
    made by your editor program.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
