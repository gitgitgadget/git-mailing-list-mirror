Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284E620756
	for <e@80x24.org>; Tue, 17 Jan 2017 20:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750893AbdAQUeA (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 15:34:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51890 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751176AbdAQUcw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 15:32:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCDFA60D8F;
        Tue, 17 Jan 2017 15:32:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4ubwKyUNUBPbaM4dg3SapKyIHG8=; b=x1/eCD
        9acAHf9UcYwXhiizm+dzTMgp2eQBm+SDKxL6dQoh9TxBC9a9lsql9s6NgXOLlHRu
        uCBH2nYMDKW+gOA32Hb8BIsvNXLogsrWUWkLGY+UOXH+XL1qufRaC4SlAFJhEvzi
        B13RnFcGlDhYnf6N8dH7Ogzxf5ik3sWD7zNM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S8WSdskYXBXtIosbCihhx6Py1gBA99SB
        arGNDFISgyUBc9x26jIL8nPtx98sN2i4cV9pBJXbArMeRt6+gDh/xzFVw1Pk6xB9
        jPCEMvTs03VSqj8MMuWHiQwk+OqGAJiooUS3wlzcAYV9m3N1lYEPDwkhjD314a+h
        hH80eMoDba4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C463E60D8C;
        Tue, 17 Jan 2017 15:32:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3020A60D8B;
        Tue, 17 Jan 2017 15:32:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
        <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
        <alpine.DEB.2.20.1701161251100.3469@virtualbox>
        <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701161746200.3469@virtualbox>
        <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
        <xmqqk29tfq79.fsf@gitster.mtv.corp.google.com>
        <20170117193639.mt3x3md3nbh2qgws@sigill.intra.peff.net>
Date:   Tue, 17 Jan 2017 12:32:26 -0800
In-Reply-To: <20170117193639.mt3x3md3nbh2qgws@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 17 Jan 2017 14:36:39 -0500")
Message-ID: <xmqqtw8xe8bp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F892948-DCF4-11E6-B6BE-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That was my general impression, too. But I seem to recall it was you in
> a nearby thread saying that:
>
>   if (foo)
> 	bar();
>   else {
>         one();
> 	two();
>   }
>
> was wrong. Maybe I misunderstood.

If it were a new code written like the above, that would have been
fine.  If a new code written with both sides inside {}, that would
have been fine, too.

IIRC, it was that the original had {} on both, and a patch tried to
turn that into the above, triggering "why are we churning between
two acceptable forms?"
