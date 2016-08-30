Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CBD61F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbcH3TA7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 15:00:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53697 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751146AbcH3TA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 15:00:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60EDF3A090;
        Tue, 30 Aug 2016 15:00:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l2rK0hIyI+xeNvpjVOWvnofcXF0=; b=vVjcEb
        UZi+dqXxiHdVafiJxFXYjH4uy0WSu4fHzcqTguW3V7GtjXsBRa8og5WBWOjAv1m0
        zPKuyrRUx3VjvKF2FV7HxmHoFFfBMdNwFbafzdj27MWDQQ8Iud6kJnNOly9lubXn
        /jm4am1l6cmWC9SQb7Gb8t0XU3sfoyhzmd+iY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wyia/A8tRFdnWdmtxA9QhILpSUlgEuth
        92kWia6N1AAR1K5arSrbVwH4w2PCIS8IDeTsDwDW21CyvYWkyXrw0TOGz0uBS7Qv
        efvPFFnJMQIIWvg51bva1ka8vBJe15NFK36lsgiO3ERnIm+xpWyELtKIrxo45L8a
        /LEGXWAnMwQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A1A03A08F;
        Tue, 30 Aug 2016 15:00:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D62403A08E;
        Tue, 30 Aug 2016 15:00:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Perches <joe@perches.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: git am and duplicate signatures
References: <1472573556.5512.93.camel@perches.com>
        <xmqqwpiy5haf.fsf@gitster.mtv.corp.google.com>
        <1472577999.5512.107.camel@perches.com>
        <xmqq8tve5fet.fsf@gitster.mtv.corp.google.com>
        <1472578879.5512.111.camel@perches.com>
        <1472579363.5512.113.camel@perches.com>
        <xmqqshtm3yur.fsf@gitster.mtv.corp.google.com>
        <1472581284.5512.117.camel@perches.com>
Date:   Tue, 30 Aug 2016 12:00:54 -0700
In-Reply-To: <1472581284.5512.117.camel@perches.com> (Joe Perches's message of
        "Tue, 30 Aug 2016 11:21:24 -0700")
Message-ID: <xmqq7fay3wux.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15371CCA-6EE4-11E6-B853-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Tue, 2016-08-30 at 11:17 -0700, Junio C Hamano wrote:
>> Joe Perches <joe@perches.com> writes:
>> 
>> > 
>> > On Tue, 2016-08-30 at 10:41 -0700, Joe Perches wrote:
>> > > 
>> > > Maybe something like traces or chains.
>> > Or "taggers" or "tagged-bys"
>> I am afraid that you are way too late; the ship has already sailed a
>> few years ago, if not earlier, I think.
>
> What's the ship's name?  Is it footers or trailers?

I think we casually call them footers (as they are counter-part to
"headers"), or trailers (probably more official as that is half of
the name of the subsystem that is supposed to deal with them).

