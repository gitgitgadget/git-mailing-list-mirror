Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90191F454
	for <e@80x24.org>; Wed,  6 Nov 2019 03:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbfKFDP5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 22:15:57 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63855 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbfKFDP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 22:15:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8655A1677;
        Tue,  5 Nov 2019 22:15:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=74nu9AarGn2gXvqBG53pWPZS5G0=; b=QrpJVn
        Ce9Q9/BgyYOJKKfPpBSw4sj5UFbki+rrAE7p2MG9wzyaC/DKl4PzWHS1zyseYJ71
        fS4/Kvw8NfFAyTqOtEbKDmll5t6i+nOoDUvr3zHjuzErYxUlFzeCbZwszNkYlEn/
        PR3CviV7j6yRc09hCiQSBHWArfDH+44TpO698=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jtHFSKDLObVySDAYG4haxB9/Ize5c8O7
        R70YgOy+O4TBczIU2PaPahFYJchttJ2nD4qi95GlRXsda7fSlVVEuXX1g7P0k9Hx
        jOUtXrlFj8zAPBWPjEdKh5WFLdZPYyhPmFumrZK6NBiKdaw+Ij3KknA5V2VtLUKK
        1WtXzQUXW9I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0F69A1676;
        Tue,  5 Nov 2019 22:15:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E726EA1672;
        Tue,  5 Nov 2019 22:15:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Documentation for common user misconceptions
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
        <20191104222634.GC22367@sigill.intra.peff.net>
        <xmqqsgn1wyt2.fsf@gitster-ct.c.googlers.com>
        <20191106021935.GF32531@camp.crustytoothpaste.net>
Date:   Wed, 06 Nov 2019 12:15:51 +0900
In-Reply-To: <20191106021935.GF32531@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 6 Nov 2019 02:19:35 +0000")
Message-ID: <xmqqpni5vgns.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE0DEBFA-0043-11EA-A77A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2019-11-06 at 01:58:33, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > Thanks. I think this is an improvement over v1, but I'm still a little
>> > iffy on some of the other movement in the first patch.
>> >
>> > TBH, I don't think it's making anything _worse_, but I think it
>> > highlights how some of our documentation is a mish-mash of low-level and
>> > high-level details. ;) So it might be a good opportunity to at least
>> > clean up the documentation around ident environment variables.
>> 
>> Yeah, I hate to suggest another round, but agree with your comments
>> on 1/4 wrt the way how and the place where the environment variables
>> are explained, which invalidates the changes in 2/4.  Fortunately
>> 3/4 and 4/4 are unaffected ;-)
>
> Yeah, I agree another round is warranted, and it's not the end of the
> world: it'll get into 2.25 either way.  I'll try to get a reroll out in
> the next few days.

Thanks.  I also agree with what Peff and you said on 3/4 wrt the
addition of "ship template, tweak it into an untracked config that
gets used".

