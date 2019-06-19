Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 309ED1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 14:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfFSO2F (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 10:28:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57793 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfFSO2E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 10:28:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9D59164A0F;
        Wed, 19 Jun 2019 10:28:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=syvOKrWKvVsj7BxZAoz7/Otv7SQ=; b=UQa9D+
        B4M1r0Lazl1/tQ6QDxRbS3NOtUlzLucfsqWoVkxGxQXe/aAdHpFkwdE8Duvw+Pse
        lYoJa7yC2rCws0xu/9tRaeG1+xI5w/LiBMQ3/ZwwtlEn26Y30wWYjIYD85gmv66r
        U9mX5/3CpenAHVyp89VTli6QMqvfT1NpOeVmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xkHxkPHavfDeTjv4jYns0rTgJbHL2K8k
        FrdzXMcE2j5JeQtmEgZroXVeB91meyDYvG9oSsa9dI7YgTI9fnqIybmNkOG5qw7C
        ftBkxn6RmSwa+vXNDcLphDtbaeupDtRAKXc2rkdUk622FIawVCYxqzDYmQq+kWiJ
        vFrNkY+Ld7A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AEBE2164A0E;
        Wed, 19 Jun 2019 10:28:02 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F085C164A0D;
        Wed, 19 Jun 2019 10:28:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/gcc-8-and-9, was Re: What's cooking in git.git (Jun 2019, #04; Fri, 14)
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906171940201.44@tvgsbejvaqbjf.bet>
        <xmqqpnncrnr0.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906181221360.44@tvgsbejvaqbjf.bet>
Date:   Wed, 19 Jun 2019 07:28:00 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906181221360.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 18 Jun 2019 12:26:06 +0200 (CEST)")
Message-ID: <xmqqsgs5r6of.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 719D4B0C-929E-11E9-BC23-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> What I *tried* to suggest is to take my minimal `kwset: allow building
> with GCC 8` together with the other three, as it fixes the build. Without
> it, the build is not fixed under `DEVELOPER=1`, it is still broken.

Ah, of course, we can do that.  

Whether we are going to replace with newer LGPL2.1 copy (which I
think is more conservative and tend to prefer) or removing it and
require PCREv2 from everybody who does not want to see their
fixed-grep performance degraded, we won't keep the "hack" when we
take the one of these solutions for longer term, but it is a minimal
and obvious workaround.
