Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409BF20899
	for <e@80x24.org>; Wed,  9 Aug 2017 05:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbdHIFpB (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 01:45:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52221 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752453AbdHIFpA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 01:45:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF62FA934C;
        Wed,  9 Aug 2017 01:44:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cUCiaFgjJyXCoyrWmhccEInnpJs=; b=CcgWGd
        YRjh9y2h1CJKneAod+jK0g9qDLsKIrteEnzVjfMWzFNkuPL81KDlkM4trAa1N/lU
        MYif+OxSwHkXW8i5uRvSqpwg/zOCxUWXcSihVTl23dEEWOuueAIaWJVYkRLuZM0K
        w2CpzjuUDHBYSgkBdI6uwerhoEnHjqurGZwX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=inWp/XuWGcOCYoDkWK7M5c7sUMC78Tkr
        gm8RrV/QeBNyRBSHrJRBeH/6/O4RWs2Z2uRr0LNiTiXp9kl4pC0UBvm7VYVzrCme
        PZQTynVYVwXskzH2Xf59/aNlYq4UMKOvAx6cpxoFx31GxwjC7bL5Ob5cuYxgNyhW
        Drh6x3WM9Gk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E685FA934B;
        Wed,  9 Aug 2017 01:44:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46F19A9349;
        Wed,  9 Aug 2017 01:44:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] t1200: remove t1200-tutorial.sh
References: <20170808234308.25565-1-sbeller@google.com>
        <20170809000742.GG169894@aiede.mtv.corp.google.com>
        <CAGZ79kZ45=2ngM437fdj8KCJjJo5h0R7FtmEBBG+VVkm0pTLrw@mail.gmail.com>
        <20170809003330.GH169894@aiede.mtv.corp.google.com>
        <20170809003841.GI169894@aiede.mtv.corp.google.com>
Date:   Tue, 08 Aug 2017 22:44:52 -0700
In-Reply-To: <20170809003841.GI169894@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 8 Aug 2017 17:38:41 -0700")
Message-ID: <xmqqh8xh8fcb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE009902-7CC5-11E7-ADD5-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Correction: the tutorial is now called gitcore-tutorial and mostly
> survives.  A search for -p --root failed because of v1.5.5.1~19^2
> (core-tutorial.txt: Fix showing the current behaviour, 2008-04-10).

Yeah, I was wondering why neither of you find it while reading your
exchanges on a phone.

> That said, the conclusion that this test has mostly bitrotted as far
> as its original purpose goes still applies.
>
> An alternative method of addressing the goal you described would be to
> fuzz object-id shaped things out of the sample output.  I don't have a
> strong preference, given how little this test contributes to coverage
> (as you mentioned) and how difficult it is to make it continue to
> match the documentation it is trying to test.
>
> Thanks and sorry for the confusion,

OK, so can one of you give the final version of the patch with
updated description?

It _would_ be nice to have an executable tutorial/documentation or
docs with built-in tests like some other systems have, but I realize
that it would be a different matter.  We'd need some toolchain to
mark up tests in our tutorial, extract and run them, and compare the
result, which we currently do not have and it won't fit under our
test framework very well anyway.

Thanks.

