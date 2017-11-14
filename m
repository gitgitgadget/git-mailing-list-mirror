Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5881F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 14:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754148AbdKNOwr (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 09:52:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61502 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752772AbdKNOwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 09:52:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2F8DB4ADB;
        Tue, 14 Nov 2017 09:52:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CixEqibbTLmRFq0HapcFI359ocE=; b=Ng5MR4
        jwzds37hEvXHh+NQIWyd1OO7hy8fc/OxO7UoOzq7FSRL6Sa55QiHe/dqqNIJTPrC
        ylyvkxO+0aDDJkKL/mHfANp+uVsc/e1NAA9SqN9o6ddzlKVvsNxkWkZv3Ycrnq8x
        Gk/bsmIsMjBlxOtbhlh+3XTl+aCLFbAhYg+2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ySdx2wI9M5J8RgFomLwBcYTK/qHaNqq2
        213z3ROgKlE8fglxjGfXLgkSAQdNdk6gllX1F8fyQBaO+hQMSPPSg+XQOjx2nyX0
        dJnPQmzYq5jp9Aoz0mhZaDrIaIHHeha1SonIA+row4iRrC3udmtPmVUsJe2lrnKP
        ZkLxKifsSMo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EAC5DB4ADA;
        Tue, 14 Nov 2017 09:52:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E8E4B4AD9;
        Tue, 14 Nov 2017 09:52:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johan Herland <johan@herland.net>
Cc:     Todd Zullinger <tmz@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH] t/lib-gpg: fix gpgconf stderr redirect to /dev/null
References: <20171113210745.24638-1-tmz@pobox.com>
        <xmqq60ad7ewx.fsf@gitster.mtv.corp.google.com>
        <20171114030351.GS5144@zaya.teonanacatl.net>
        <xmqqshdh5ygy.fsf@gitster.mtv.corp.google.com>
        <20171114051520.GU5144@zaya.teonanacatl.net>
        <CALKQrgc427=JNkkH+k+EohgKYuJSBPbDNR3uUcmGuf_ZyQ0X4Q@mail.gmail.com>
Date:   Tue, 14 Nov 2017 23:52:44 +0900
In-Reply-To: <CALKQrgc427=JNkkH+k+EohgKYuJSBPbDNR3uUcmGuf_ZyQ0X4Q@mail.gmail.com>
        (Johan Herland's message of "Tue, 14 Nov 2017 10:31:49 +0100")
Message-ID: <xmqqd14k3oar.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79686AD8-C94B-11E7-A4F6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

>> Sounds like a good plan.  If the message does move to stderr, there are also
>> a few tests in 3310 that need adjusted.  They presume an error message from
>> `git notes merge`, but they only redirect stdout to the output file.
>>
>> While I was bored, I prepared a commit with these changes and confirmed the
>> test suite passes, in case we get an ACK from Johan.
>
> ACK :-)
>
> Error messages should go to stderr, and redirection in the tests
> should be fixed.

Thanks, both.
