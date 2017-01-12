Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638031FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 20:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbdALUkR (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 15:40:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61764 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750794AbdALUkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 15:40:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 147A15D0F4;
        Thu, 12 Jan 2017 15:40:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jggzQMc/iUT0kN0KyaiJqCK7oKQ=; b=gXwjU8
        8Mr0J7Rf1C1shSk66D8YTEHT81/s6UKYH2J27DhyG+o47O5VuWig2BItAZBItE7H
        c4R1xMRkKYzDXBGP0aRT1gEapXPmjfcXAnNFhILRxsa63Xjg6IbXWX4gYpSbtJlG
        n/9rte0mAabAK/ujSxVbB+VTVL8iM2r8BvZUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g3LU8tz6yHvAUM74P6WTWnZL4m8C/oVD
        cZDxyAcb2Gh7Y6A0H0T1tws74ECGNF3mLtVbIoeOi2T6xm65PyXtYVudRHIvwm3F
        KGDiRk+6xORI69KAAQIgUPNP5JvHhLhczmcKR6ITk9BGZA7aSEYQuMpMH9qd3o2A
        0Fpl1Rm04BQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0921A5D0F3;
        Thu, 12 Jan 2017 15:40:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 531BB5D0F2;
        Thu, 12 Jan 2017 15:40:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pat Pannuto <pat.pannuto@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
        <20170112055140.29877-3-pat.pannuto@gmail.com>
        <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
        <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
        <alpine.DEB.2.20.1701121118170.3469@virtualbox>
Date:   Thu, 12 Jan 2017 12:40:13 -0800
In-Reply-To: <alpine.DEB.2.20.1701121118170.3469@virtualbox> (Johannes
        Schindelin's message of "Thu, 12 Jan 2017 11:21:47 +0100 (CET)")
Message-ID: <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51E90C9A-D907-11E6-A4F8-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So if this patch would make it into upstream Git, I would *have* to revert
> it in Git for Windows, adding to my already considerable maintenance burden.

I do not think we want "#!/usr/bin/env $language" in the upstream,
either.

