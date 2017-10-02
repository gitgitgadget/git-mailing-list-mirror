Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E782D20281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbdJBXos (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:44:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52246 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750984AbdJBXos (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:44:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4658BA43E8;
        Mon,  2 Oct 2017 19:44:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9cRLkOmj0hFlbk4FLO+lvo9lzRI=; b=G4uHkp
        GVcd2MfQffLERBaUhjYwUeBs/Its0SKTz0HQGQINVWF/PFRo+n8qSVGGBrge1ia0
        MjRxoJA9afn8OP59E4t3CiXWO1DOZ5cP88QDgUuZCd2KieVkGN99KRMjZJ/hM/aS
        1kUBh+K2BgQWELRkpe9f9wmjy2RcFKNBnvY3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rzByMe5pXFJIjuSjEdx5WqDdRLjH4i9O
        fIReqEM2UF0pi4hdkp6a4/H5kMJxFNRNcZGiJ3LzrF3RPNt6aYw3L19vCqoBa6O4
        YBe3u1kh6gmnErWoeTBciBX16SgZhcjgK9rGeT9TK/VdB0UzR1Gg4x/eXdeCvpdp
        AmxgebyKUbA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DE38A43E6;
        Mon,  2 Oct 2017 19:44:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4284A43E5;
        Mon,  2 Oct 2017 19:44:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v6 7/7] ref-filter.c: parse trailers arguments with %(contents) atom
References: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
        <20171002052524.12627-1-me@ttaylorr.com>
        <20171002052524.12627-7-me@ttaylorr.com>
        <20171002065100.cjawz6pvxjj2w5nr@sigill.intra.peff.net>
        <20171002154916.GA39723@D-10-157-251-166.dhcp4.washington.edu>
Date:   Tue, 03 Oct 2017 08:44:45 +0900
In-Reply-To: <20171002154916.GA39723@D-10-157-251-166.dhcp4.washington.edu>
        (Taylor Blau's message of "Mon, 2 Oct 2017 08:49:16 -0700")
Message-ID: <xmqqr2ulm7wy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC366C0E-A7CB-11E7-ADE7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Thank you for pointing this out. I should have run "make test" on this
> patch set (or, as you suggested, `git rebase -x "make test" HEAD~7`)
> before sending it out. I appreciate you catching my mistake, and I'll
> make sure to run "make test" more diligently in the future :-).
>
> It sounds like Junio picked this up while queueing.

"Yup" in the sense that "you do not have to worry about it unless
there are other things you want to fix by rerolling" but I didn't
spot it myself and noticed the breakage; I tweaked it only after
Peff pointed out what is wrong.
