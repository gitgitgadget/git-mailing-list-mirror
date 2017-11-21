Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E4B42036D
	for <e@80x24.org>; Tue, 21 Nov 2017 13:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbdKUNMY (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 08:12:24 -0500
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:61731 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbdKUNMX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 08:12:23 -0500
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 4B67413271;
        Tue, 21 Nov 2017 08:12:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7bS381y71r+nyKcxe6EFA0KJAj0=; b=xaeV+O
        VMoqva6kCTSCkojkQaj4uak9C/qLZnDHWThb9hiyIWeP2imT3Epn+Lbi1+nDaRUB
        vMoa7bQZ3AhCEfAwImIssD3uim5HlD4/uMco/GBEfiXnuDE+n++CmF0tnOhbwogp
        j1AOiJ0Zl9YzvwdJIqXQ/TjRqrbenJsOea66A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cX+bZxJ6qlc2vd4n2relNJkLMIUMcGvi
        IudPJIkXXBFPKgD3lo+g8Jm+OkowwwhJCSgYqh5P83BFTui3mA4y5Zp1QcuBl0F8
        sV79lCJe2tRzaqR5u8EzIcHCvzX1bJRIgxSPPGM9z8z+mZdQuhJW9E039Neox8cX
        yYjNfoSJt2A=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 266CB13270;
        Tue, 21 Nov 2017 08:12:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63C0696FEE;
        Tue, 21 Nov 2017 08:12:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Yubin Ruan <ablacktshirt@gmail.com>, git <git@vger.kernel.org>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Ross Kabus <rkabus@aerotech.com>,
        Henry Kleynhans <hkleynhans@bloomberg.net>,
        Charles Bailey <charles@hashpling.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Draft of Git Rev News edition 33
References: <CAP8UFD0ggpUGGoOEjAt3sB9=ek+Av+6GemiyqZ4kTCHLC9dWoA@mail.gmail.com>
        <CAJYFCiOj1DwgMMrFRxV315CB7xuvXMFRbRAkbx6s14oPm3ui1Q@mail.gmail.com>
        <20171121011017.e2aac53zfo2n2whc@aiede.mtv.corp.google.com>
        <CAP8UFD0dN2V5GVokvMD-XLDEhPVJrE=m3h8oM5VC_Lq6x3=9=A@mail.gmail.com>
Date:   Tue, 21 Nov 2017 22:12:17 +0900
In-Reply-To: <CAP8UFD0dN2V5GVokvMD-XLDEhPVJrE=m3h8oM5VC_Lq6x3=9=A@mail.gmail.com>
        (Christian Couder's message of "Tue, 21 Nov 2017 09:17:11 +0100")
Message-ID: <xmqqvai3zsge.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A88AD5A-CEBD-11E7-A6D7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Nov 21, 2017 at 2:10 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>> That said, I believe that the gitattributes(5) manpage does an okay
>> job of covering this and that that thread came to a clear conclusion:
>>
>>   https://public-inbox.org/git/20171026203046.fu3z5ngnw7hckfrn@aiede.mtv.corp.google.com/
>>
>> I commented at [1] that I found the conclusion of the rev news entry
>> misleading and confusing but it doesn't appear that there is anything
>> I can do about that.
>
> Well, you could have provided a pull request or otherwise suggested
> what you think would be a better conclusion for the article and why.

I just re-read the sub-thread Jonathan pointed at, and to me it does
look like the original request was adequately addressed and talk has
concluded at around that article.

I somehow was hoping that Jonathan's citing the above URL is a
suggestion enough for the editors, especially given that the
announcement for the draft invites a reply to this thread.

> Perhaps nothing was missed, but as the issue is complex, it is just
> difficult to explain and summarize it in a good way.

Perhaps you want to take a bit more time between a draft to the
final publication?  I've often wondered if the time between a draft
announcement and the release is too short for those who understand
the discussions on the list well enough to give useful input to help
editors regurgitate the issues to arrive at a clear summary article.

