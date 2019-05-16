Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ABE21F461
	for <e@80x24.org>; Thu, 16 May 2019 09:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEPJTV (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 05:19:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50878 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPJTV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 05:19:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F40D114FFE7;
        Thu, 16 May 2019 05:19:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/oMsZUHtqtOLqiBI5pzWSDqF8B8=; b=FUDb7D
        DsaUE5kONGFsY1iLaMKqpIRdLHPGM0KSCDdwL0NasQ26pf3TFfgTAsV24R+dFMWz
        Y9NXLqpEg+3VaV1/Q7mB+TwQyaIhDyZKtm2c7K5V5ZLpjc7cG6qYzcqmhE/yA9wV
        O62yOmBxXKaB0qlrdBlwAxyWEuFV+xM4YaT8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I7g66alU9RVQHE1akv/Gbkg+m4fTobLE
        lLUoAPW6NoxSZUtYyP3lHmKySUF2uVIG/lFpko8itEDP4wZdzVNsA4TYQGyJ98cM
        D7jJgzHVGqpL5uahksBKMImclqE0SoIKnq7qqkPMMLcKu1iM2k/ztMPf8GMB70j0
        C4mMq57imMg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EBFCE14FFE6;
        Thu, 16 May 2019 05:19:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F84C14FFE5;
        Thu, 16 May 2019 05:19:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "LI\, BO XUAN" <liboxuan@connect.hku.hk>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        philipoakley@iee.org
Subject: Re: [PATCH v3] userdiff.c & doc/gitattributes.txt: add Octave
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
        <20190511041331.51642-1-liboxuan@connect.hku.hk>
        <aa86f483-9c73-eb6d-1a73-80fd4894c093@kdbg.org>
        <CALM0=-n_=8K4RWE9MvwPFT26UwN-rAA09ryqdTfEF4GJ57YBjg@mail.gmail.com>
        <a2455214-9ce5-71e3-74bc-114af6fcfca7@kdbg.org>
Date:   Thu, 16 May 2019 18:19:15 +0900
In-Reply-To: <a2455214-9ce5-71e3-74bc-114af6fcfca7@kdbg.org> (Johannes Sixt's
        message of "Wed, 15 May 2019 19:46:18 +0200")
Message-ID: <xmqqlfz64uzw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD7319D4-77BB-11E9-96C4-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> In Matlab, is %%% followed by space at the beginning of a line
> *commonly* used for something different? If I were to make a guess, I
> would say no. If I'm right, it does not hurt to merge the Octave rules
> into the Matlab rules.

That is true because we are not syntax-aware and error-highlighting
text editor.  If we were, I'd suspect that your stance may probably
be different.  But instead we apply these patterns to a program that
is assumed to be correctly written.

And from that point of view, I agree with you that it would not hurt
to make the existing patterns for Matlab slightly more receptive so
that a correctly written programs in either language would be matched
appropriately.

But would it hurt to have two similar entries, with a clear
description on how they are different, in our code there, given how
infrequently individual entries have historically been updated?
