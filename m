Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AF7C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BD460E08
	for <git@archiver.kernel.org>; Thu, 20 May 2021 02:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhETCZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 22:25:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53205 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETCZc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 22:25:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D708133E3F;
        Wed, 19 May 2021 22:23:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dPQlhSt1HND/Pms6b5+ffgb2IXQip51ASmc4ZT
        ZXnUM=; b=mGt5KMCgL8a7GgjurlFx1p03L/r97/9YYa1ToV+dLVh6seqGfN39yP
        LjXbrgv9lvAR2CmpRoSQnu1qVIVvAPSLEkBxzda7T9UX9TbzxPzrhMDFmd3mVsza
        f9OWJtvDGNu9uO0gP+zGtIKI+fvnjpplKOJF6voytllf7UHLb5C/o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69AC3133E3E;
        Wed, 19 May 2021 22:23:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A40B6133E3D;
        Wed, 19 May 2021 22:23:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] help: colorize man pages
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
        <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
        <60a332fd22dad_14c8d4208ed@natae.notmuch>
        <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
        <87im3fqci9.fsf@evledraar.gmail.com>
        <YKXBdQ36MYz2YG8s@camp.crustytoothpaste.net>
Date:   Thu, 20 May 2021 11:23:41 +0900
In-Reply-To: <YKXBdQ36MYz2YG8s@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Thu, 20 May 2021 01:55:01 +0000")
Message-ID: <xmqq35uiw3bm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66012862-B912-11EB-9EC5-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The documentation says, "use the man program as usual".  "As usual"
> implies the way the user would invoke it.

I guess what the documentation says matches what end users expect (I
as an end user certainly do expect that "git help -m foo" is running
the familiar "man" command on something that is related to "foo").

So while making the "less" customization more discoverable and
easily accessible would be a win for users, I have to agree that is
out of scope of this project's mission.

We used to give helpful hints how to configure LESS environment
variable in a way that does not conflict with our use somewhere in
the doc.  I think the hints how to configure these set of environment
variables for "less" users may belong to a similar place in the doc,
if we wanted to do something, but going beyond that would probably
be more confusing and disorienting than helpful to our users (they'll
start wondering why "git help"'s output does not look like the
output from "man ls").

Thanks for discussing this topic.


