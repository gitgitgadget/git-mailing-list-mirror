Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C8D207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 23:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934980AbcI2XUl (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 19:20:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57709 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934911AbcI2XUj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 19:20:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59B7943B10;
        Thu, 29 Sep 2016 19:20:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zwEwf2kRIntDohnhajZoJ8OqVH4=; b=LI++io
        OgElM/9tQunIQH+d348OWSA/gHcBaMkam8BnsIGOnkG/iTNhjMkbdjbUoY5Pjlil
        lPMobqMr8sWTQFO5xcdDFgQrXv/wldamz9rzTkbdSvw7Zxvr0U14d0Jn6sq6M/Hd
        pPDCq6nflrmcQfu+CYH5pvCY1T4QgQknSCrdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gXc/5i6cZa8DCplvORmURdIuXnqExB55
        3lwPDGoyG3aeYW6Dkn/tMFPBcoJdEaGMqRZNNTdn2OsVc+VrduNSOZZlq0ESi633
        PLqF/rDQV5MvV4QKkZ1y5kH+lg7NQ5J4XdKqOLgP5pJSuFjOpGA9oO8Tjuxldfsn
        QqbFNW7lLMY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5165C43B0F;
        Thu, 29 Sep 2016 19:20:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF71A43B0E;
        Thu, 29 Sep 2016 19:20:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-5-gitster@pobox.com>
        <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
        <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
        <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
        <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
        <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
        <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
        <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 29 Sep 2016 16:20:35 -0700
In-Reply-To: <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 29 Sep 2016 16:13:38 -0700")
Message-ID: <xmqq7f9ucmyk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54972526-869B-11E6-AB70-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> The advantage of the
>> previous patch was that it got the object counting right almost
>> automatically, this actually has its own new object counting code and
>> maybe I screwed it up.

I guess another advantage of your original approach was that it
delayed the counting to the very last minute, so the things that
worried me in my previous response were automatically made
non-issues.
