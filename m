Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA74C1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 18:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753998AbdAZS0I (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:26:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60859 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753857AbdAZS0H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:26:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90FD3621C6;
        Thu, 26 Jan 2017 13:26:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s1bhZqz603+WKLc7R+2vHH7MsZc=; b=eEK12P
        52hzUVI/0TcFWo5wOKZfHimcVkqCFRSIR/irgu1L3+Y3IxKpZv5sa/bcClpINz5K
        S8jKjy4azZUCOe1baOQFVBcgSKjFyXDdUET1u8Xt4NZ+gsLCp6PhdiL3WuwAkEgN
        YartlLI5uXOZPZoOL4lgsPq3gCB0HgBxhT7Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s/LvhXHHRF3AJwxQQnD7Jf90lXuckFYQ
        OnqcWSMIHi3U1BQFS0MayiW7Jgrv5Cfbw7w0/EztM4wkLMkP/XDC59q9ZECb9jLA
        s3A5u1bU1rLp9lrxv46IEfktqt4FTJi8YlJEnwj2J2vVQRFcR1VEp+4vmFBC09Y+
        P72K96fFq6M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87C91621C5;
        Thu, 26 Jan 2017 13:26:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB223621C4;
        Thu, 26 Jan 2017 13:26:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Fixing the warning about warning(""); was: Re: [PATCH] difftool.c: mark a file-local symbol with static
References: <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
        <20170122052608.tpr5pihfgafhoynj@gmail.com>
        <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
        <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com>
        <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701251135090.3469@virtualbox>
        <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net>
        <xmqq7f5iakxw.fsf@gitster.mtv.corp.google.com>
        <20170125220101.et67ebkumsqosaku@sigill.intra.peff.net>
        <546179e0-1d6e-86f7-00cf-e13218b76de1@kdbg.org>
        <20170126143252.ne533mcv3n2ksbai@sigill.intra.peff.net>
Date:   Thu, 26 Jan 2017 10:26:03 -0800
In-Reply-To: <20170126143252.ne533mcv3n2ksbai@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 26 Jan 2017 09:32:53 -0500")
Message-ID: <xmqqlgtx65l0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5D08EF4-E3F4-11E6-9452-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 26, 2017 at 07:39:55AM +0100, Johannes Sixt wrote:
>
>> Am 25.01.2017 um 23:01 schrieb Jeff King:
>> > +#pragma GCC diagnostic ignored "-Wformat-zero-length"
>> 
>> Last time I used #pragma GCC in a cross-platform project, it triggered an
>> "unknown pragma" warning for MSVC. (It was the C++ compiler, I don't know if
>> the C compiler would also warn.) It would have to be spelled like this:
>> 
>> #pragma warning(disable: 4068)   /* MSVC: unknown pragma */
>> #pragma GCC diagnostic ignored "-Wformat-zero-length"
>> 
>> Dscho mentioned that he's compiling with MSVC. It would do him a favor.
>
> Bleh. The point of #pragma is to ignore ones you don't know about.

Yes.  Let's not go there; somebody else's compiler will complain
about "#pragma warning(disable: 4068)" that it does not understand.

> Anyway. I do not want to make life harder for anyone. I think there are
> several options floating around now, so I will let Junio decide which
> one he wants to pick up.

Well, I'll keep the "do nothing other than squelching this instance"
to solve one of the two problems for now.  

The other "can we make it harder to make the same issue and reduce
the need to discuss this again on the list?" can be an independent
follow-up patch, and I do have a preference (the "less horrible
version, that is static inline warning_blank_line(void)" you gave us
in <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>), but I
do not think we are in a hurry.

Thanks.


