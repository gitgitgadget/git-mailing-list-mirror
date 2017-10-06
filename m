Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7281FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 00:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbdJFAde (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 20:33:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51207 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752276AbdJFAdd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 20:33:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D92C2A5D35;
        Thu,  5 Oct 2017 20:33:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2eCmvhX6Dz2i
        hSF4f3BE1UA0M04=; b=i0qRsQlw9efOnTglLWJFHolqd2Mh7tHPQ8Mztt/5dLjk
        RxoNAMZnFob3r6h6g0d3LwEq8vfjrw4bjextV5NtUgarU+yRBYRc6WNpEKngXQhG
        1PmBTFl1ucQro0Dq28+o2MuPP+YX+jmQmG5/8mKt6yRVb2HsMGqM65e5K0OBIHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=RhEuYm
        e0EEVpwtmEWsj1W1ybB3axGPz2B32O3eGJz6lpeEW1jd1axe1PNr6WvO6VwtC0SC
        YqQLpMvIGaj7uPD11UUg5Uyuq3pGBRuh1j3CJmr7s2z7cjxCGXpG4EI6UDF0NbrH
        +GekRVAs3aNgpzpDDsf9vup7ujEz1+vF26Pvo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0061A5D34;
        Thu,  5 Oct 2017 20:33:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54A05A5D32;
        Thu,  5 Oct 2017 20:33:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
        <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
        <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
        <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
        <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
        <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
        <20171004211734.GA25379@tor.lan>
        <xmqq7ewa9xw6.fsf@gitster.mtv.corp.google.com>
        <xmqqo9pm8e4l.fsf@gitster.mtv.corp.google.com>
        <20171005214248.GA31593@tor.lan>
Date:   Fri, 06 Oct 2017 09:33:31 +0900
In-Reply-To: <20171005214248.GA31593@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Thu, 5 Oct 2017 23:42:48 +0200")
Message-ID: <xmqqa8156rok.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FB3FD6D2-AA2D-11E7-BB6B-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Before we put this into stone:
> Does it make sense to say "renormalize" instead of "rehash" ?
> (That term does exist already for merge.
>  And rehash is more a technical term,  rather then a user-point-of-view=
 explanation)

I do not mind "renormalize" at all.

As to the toy patch, I think it needs to (at least by default) turn
off the add_new_files codepath, and be allowed to work without any
pathspec (in which case all tracked paths should be renormalized).

And we really shouldn't do the "rm && add", which would not work
well on platforms where filesystem without executing-bit support is
prevalent.  This new feature is primarily needed on platforms where
CRLF line endings are used, and unfortunately these two sets of
platforms overlap quite a bit X-<.


