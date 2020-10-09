Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D68C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C2B2225D
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hNH7O28C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389618AbgJIQMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 12:12:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57649 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIQMf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 12:12:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AB7EFF026;
        Fri,  9 Oct 2020 12:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UPBwEZzKOj4Y7Xo3+dVOMIDrI0E=; b=hNH7O2
        8CAw2N4FhXWMf3mFJdQYkfcgn/oGxeqyy6RV1mX/FJJFV9dZQUbSQSrzZ61wzzMA
        Fg0sF7PLaqclXiDU0v1/UzBRiRHLwCPJbfOSTXv/596sF1uLd6pv5J6etyCTq0jn
        Iv1tn+h8muWtwQ9wRzVIiPU635gZCzBaEcDtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nYmVegE9QLzvZW+rCaa8YdWbXJovc0qE
        qIrHV2nVIOhCUc6KF5LanllpCO8e6Y+mIAq74Xr9AccPsrqagY2KIkYAvAz+av0I
        x5VRHCejRLFefOSihKj8la9xibZDfzjRfYeedSwacvlUbLp2nE///90eukqmbv8D
        +TIoqd6J+o8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EF56FF025;
        Fri,  9 Oct 2020 12:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9261CFF022;
        Fri,  9 Oct 2020 12:12:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: ASCII-sort += lists
References: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com>
        <nycvar.QRO.7.76.6.2010081156350.50@tvgsbejvaqbjf.bet>
        <20201009014528.GA1314@generichostname>
        <nycvar.QRO.7.76.6.2010091250200.50@tvgsbejvaqbjf.bet>
Date:   Fri, 09 Oct 2020 09:12:29 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010091250200.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 9 Oct 2020 12:51:11 +0200 (CEST)")
Message-ID: <xmqqy2kftm36.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C0B8A9C-0A4A-11EB-A670-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > -BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
>> >  BASIC_CFLAGS += -fno-omit-frame-pointer
>> > +BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
>> >  ifneq ($(filter undefined,$(SANITIZERS)),)
>> >  BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
>> >  endif
>> > -- snap --
>>
>> I opted to exclude this hunk because it didn't seem like a list that
>> should be sorted. Perhaps if we include this in the static-analysis
>> script, we could define a whitelist of lists that we want to keep
>> sorted?
>
> I agree, modulo s/whitelist/allow list/.

If we were to do this, I agree that explicitly enumerating "lists
whose elements must be sorted" would be a much better approach than
declaring that our lists by default must be sorted and have a list
of "lists whose elements are sorted in an order that has meaning,
not just by codepoints".

But I somehow find the use of allow-list (as a concept [*1*])
awkward in this context.  Technically, a list of things whose
sortedness we care about may be "allowed to be automatically
modified", and the remainder would be "forbidden from getting
touched".  But both are quite awkward way to think about them.

It would become even more awkward if the list is going to be used in
a make target whose name has "check" in it, in which case the target
would only point out problem so that the user can fix, and at that
point, the said list would become a list of things that are "allowed
to be checked".


[Footnote]

*1* ... not the phrase---I do not care in what color the allowed
    things are painted.
