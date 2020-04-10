Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696DDC2BB1D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 18:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36000207FF
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 18:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v+JgcKO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDJS3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 14:29:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50790 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJS3G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 14:29:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A36A2C4168;
        Fri, 10 Apr 2020 14:29:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9kio5WUt+ORRLChIlw7UrczjW00=; b=v+JgcK
        O44dkjztfSSv6L7Q6KVAk5W6qQ/+GP0sYVCyn1STRr3rUtJbcSyBXRiiRHTLIGDA
        E5ES3nGLWG7OFOIJu55RQYMzox2gsB7A2JCf/eAB14BIRFyHwoBPGqJiQzA0sJNI
        QSPMi6Og5inW3LlE6rE0AXdUbhBRRxJ+uncJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Krm6Ud0xda0OmF4tgBay1Hnk6bAwoDiH
        KbQTYpJB9zklLsPhPoRy3XKY37Ek79LFufD6kw1NrRMKJEO4oAPaufi8qs+PISY9
        EDvAHtaUVlYVAPnzk54vcUhdUFeVsyFrgkxl0JTwEqNLOOeYbzPoE3WHW8tW1mWB
        BuOkVc9t8ME=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 995B0C4167;
        Fri, 10 Apr 2020 14:29:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D639AC4165;
        Fri, 10 Apr 2020 14:29:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net, emilyshaffer@google.com,
        martin.agren@gmail.com
Subject: Re: [PATCH 1/2] gitfaq: cleanup gitfaq.txt
References: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
        <20200406181216.5340-2-shouryashukla.oo@gmail.com>
        <xmqqy2r8tbxn.fsf@gitster.c.googlers.com>
        <20200408182247.jz5xnlw3sbrazq36@yadavpratyush.com>
Date:   Fri, 10 Apr 2020 11:29:00 -0700
In-Reply-To: <20200408182247.jz5xnlw3sbrazq36@yadavpratyush.com> (Pratyush
        Yadav's message of "Wed, 8 Apr 2020 23:52:47 +0530")
Message-ID: <xmqqblnzjitv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26A55456-7B59-11EA-95F9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> Maybe we should just have a consistent convention throughout the 
> documentation on whether to use one space after a full-stop or two. 
> Right now in some places we use one space, in some others we use two, 
> even in the same file. This is slightly distracting when reading.

As somebody who almost always goes to the source on a fixed width
font terminal and not to formatted output, I personally find it
distracting not to have the extra space at the end of a sentence.

> And FWIW, our man pages are always 
> rendered with one space, even if the source file has two.

Or three, for that matter ;-)

It is one of the reasons why we didn't really care and have not gone
churning the source.

> Having a convention would at least result in uniformity, even if
> it won't end the debate on which is better.

Yup.  If I were to dictate a convention, I'd say we should have one
extra space after a full-stop or similar that ends a sentence.

As you pointed out, the choice of the convention does not make any
difference to the end product for end users, and only affect those
who work on the source with mark-ups, that is a fairly easy thing
to declare, without letting anybody argue for or against---it is not
better or worse than the other choice, but choosing one and sticking
to it is probably much better than not having a uniform convention.

Having said that, let's not go berserk and start reformatting,
especially areas that are actively touched for non-stylistic
reasons.  Those other changes are much much more important.

Thanks.
