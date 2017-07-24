Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFA19203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 21:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756726AbdGXVri (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 17:47:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54974 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756466AbdGXVra (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 17:47:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CDCB9B8FB;
        Mon, 24 Jul 2017 17:47:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7u27PmKIz5Qr
        HP+KepHvvyMIKB0=; b=TQ1tCrr+VVsHN5cXpGDUNRzFz9HKCAi3q4c69J/NVkwD
        F3ZuvrBLCO4SlxSVjQ0+BTRAWDIjYPV1R17y3+JdUXudWcVH3pKHTGMkDmAargel
        Id8jMMcIlqW2EIu2txSBXDsAYlv9BUFVaHXgLCot4oxvRbOGnUHyL77Yo3+lP5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Rx5JeL
        dFSdW72uw1wNJAI34X4zSSq1QDARKc6VfpzViXI17hBAkEeE1IXvhQCzrpm8HeSm
        mP1AU63Gdh2SPtsdNtcjJY8mwyI0PcVTPLXAnQGUvqbMSs+RPDw+3A8FzsQgie5M
        NRb8YO8aYz4O/GmnGx1stALIBc2TkS090OtFY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 145CD9B8FA;
        Mon, 24 Jul 2017 17:47:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47C849B8F7;
        Mon, 24 Jul 2017 17:47:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
        git <git@vger.kernel.org>
Subject: Re: Remove help advice text from git editors for interactive rebase and reword
References: <20170724184707.22828-1-szeder.dev@gmail.com>
Date:   Mon, 24 Jul 2017 14:47:28 -0700
In-Reply-To: <20170724184707.22828-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 24 Jul 2017 20:47:07 +0200")
Message-ID: <xmqqvamhbj7z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0A6EA14-70B9-11E7-9981-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> While these reminders are useful for new users, with time they learn
> what the score is, and experienced users might find these advices are
> just wasting a couple of lines' worth of screen real estate.
>
> Make displaying these advices configurable via the 'advice.commitMsg'
> config variable.

It may not be a bad idea, but the code after the patch does look
ugly with too deep indentation levels.  Can some refactoring help, I
wonder?

Is that advice.commitMsg?  It looks more like commitEditor advice to
me but it may be just me.
