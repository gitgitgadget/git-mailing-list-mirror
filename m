Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18A2A1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 18:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753547AbdAZSHA (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:07:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55326 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753880AbdAZSG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:06:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D900863378;
        Thu, 26 Jan 2017 13:05:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GxghYeyIB57uvvPPQNS8ljss1Qo=; b=RXzXyl
        Bwl2My9/m6ozclavatcf0uEfsSS0ik7ZJ1yMGMGCjoTSWvEHlU6HlC4iPbfJk8hH
        RFugYadPOHuurQ4eiMI882Q/pYRkm7xA8aBPPxEnLh5d/zUXqcsWdVFzMaimCl0n
        wpehu5vtD1I/sUv9VgrW4lJnhOv7FPO38jnlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vEhnsDWHsu0Cip6tngyOO5Cjp5FqHTsr
        0C9lwyxDQcJz5ISKbjGoCzF4d10rhoASXMyPvF+INScYvzVI+FuVKtggpTd8maCo
        m2KZS/NrQF+iC/GYwhacswgLRXfF1u4nNh2ga9U3cgNEJcKhIqmh15Xzp68JbSr0
        SYBOPDVlG8A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0C7B63377;
        Thu, 26 Jan 2017 13:05:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 239A763372;
        Thu, 26 Jan 2017 13:05:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
        <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com>
        <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701251800120.3469@virtualbox>
        <20170125173958.pg546a6w33dirp5k@sigill.intra.peff.net>
        <xmqq4m0nc8dz.fsf@gitster.mtv.corp.google.com>
        <20170125183924.6yclcjl4ggcu42yp@sigill.intra.peff.net>
        <xmqq7f5i92jk.fsf@gitster.mtv.corp.google.com>
        <D9F0976B-9F78-44BE-B9DD-CAB6506FA3A9@gmail.com>
Date:   Thu, 26 Jan 2017 10:05:48 -0800
In-Reply-To: <D9F0976B-9F78-44BE-B9DD-CAB6506FA3A9@gmail.com> (Lars
        Schneider's message of "Thu, 26 Jan 2017 10:14:01 +0100")
Message-ID: <xmqqtw8l66ir.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11CD801E-E3F2-11E6-BA96-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> The difference between Travis and my machine is that I changed the 
> default shell to ZSH with a few plugins [1]. If I run the test with 
> plain BASH on my Mac then I can reproduce the test failure. Therefore,
> we might want to adjust the commit message if anyone else can reproduce
> the problem on a Mac. 

With "Reportedly macOS does this, at least in the Travis builds.",
even with the result from you in your follow-up message to the
message I am responding to, I think what Peff wrote in the log
message is good enough.

Thanks for digging, and thanks Peff for coming up the workaround.
