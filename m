Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD2DE1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 19:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752808AbdARTPv (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 14:15:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59988 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752030AbdARTPt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 14:15:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5B655F5DF;
        Wed, 18 Jan 2017 14:15:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=woULxIPMvHTtADMB0xJ7zb0XitY=; b=cRVsKp
        kY7QVCztFlQ67y/4GppllaOxQHyJCVhpy+mWRuAfZUHjYYpezBr7QNvQikzv75ox
        whp6U2qwfkqTbF9UGGleTdOmyOnJWzziqtvxQnzGuHUMp2OBTei+B1mqJitGz/7G
        16qQU2xfeWpreCmfgqpOleR9PYpa9wwVJ5Csw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dv2q0C5Gc2fUt+gkU1iCw1oeucBLS2A8
        tZxfgGHOLAk9qr5xBFVxAZLHZIgtTQISGd6TuRklTyPcgnhyByrKznM/eBAeKw4V
        k2KKU8OugpEki8cVQ7Mj2ErV95sB1PvimAjjYrHT3XIhDrfqspplSm8IL7j4NTME
        zrXYb98wlfw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B34B15F5DD;
        Wed, 18 Jan 2017 14:15:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D53D5F5DC;
        Wed, 18 Jan 2017 14:15:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v5 3/3] Retire the scripted difftool
References: <cover.1483373635.git.johannes.schindelin@gmx.de>
        <cover.1484668473.git.johannes.schindelin@gmx.de>
        <8238bba389c031b091a37396fed43cac94d944e7.1484668473.git.johannes.schindelin@gmx.de>
        <xmqqk29tcqb8.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701181332230.3469@virtualbox>
Date:   Wed, 18 Jan 2017 11:15:03 -0800
In-Reply-To: <alpine.DEB.2.20.1701181332230.3469@virtualbox> (Johannes
        Schindelin's message of "Wed, 18 Jan 2017 13:33:39 +0100 (CET)")
Message-ID: <xmqqbmv49o3s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B407368-DDB2-11E6-82CE-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 17 Jan 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > It served its purpose, but now we have a builtin difftool. Time for the
>> > Perl script to enjoy Florida.
>> >
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> 
>> The endgame makes a lot of sense.  Both in the cover letter and in
>> the previous patch you talk about having both in the released
>> version, so do you want this step to proceed slower than the other
>> two?
>
> I did proceed that slowly. Already three Git for Windows versions have
> been released with both.
>
> But I submitted this iteration with this patch, so my intent is clearly to
> retire the Perl script.

Ok, I was mostly reacting to 2/3 while I am reading it:

    The reason: this new, experimental, builtin difftool will be shipped as
    part of Git for Windows v2.11.0, to allow for easier large-scale
    testing, but of course as an opt-in feature.

as there is no longer an opportunity to participate in this opt-in
testing, unless 3/3 is special cased and delayed.


