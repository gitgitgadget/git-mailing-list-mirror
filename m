Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE96A1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 18:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763935AbcLTSYP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 13:24:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54906 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1763856AbcLTSYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 13:24:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33E78589BB;
        Tue, 20 Dec 2016 13:24:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XzfKuTIRF+hYnR0H3mOGTYu9+xw=; b=IKw4wu
        sUyppatvjWm/UVW2IsJ4G5HdQf3GqO4BG3ZwW3YgBT2k+bKePjGPZiBTVLXcB8Vl
        oOBt0TLA1eDmCrB4QYge52rQKlCGtT7hgjC/Nf4EeO++uY8pxSJR40cqgePPQsJ7
        a8iZPx7vRQJ2dULPwG8Xpp/E2Abcfcm4m41Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f7pXr52jzxeMIpqCg4RJptm3vtUBZDYf
        xmmAvCVETsQU8xHRc+yIFGKuQS2z9Dw3lVncpcaz8RqripSMVQrwFYXFVOeV4fX+
        RaiotQa6IuREUut0eLVngU4dgc2F1nHTgCTLiRzAFxALv4RwqG4CF8LZg3Uf6y61
        BaD0Vod7NVk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BBE8589BA;
        Tue, 20 Dec 2016 13:24:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E4E5589B9;
        Tue, 20 Dec 2016 13:24:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
        <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
        <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
        <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
        <16b115e0-3a7e-a5c2-1526-44bbcfc97db8@kdbg.org>
        <xmqq60melazp.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 20 Dec 2016 10:24:09 -0800
In-Reply-To: <xmqq60melazp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 20 Dec 2016 10:19:06 -0800")
Message-ID: <xmqq1sx2lara.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 807748D4-C6E1-11E6-A733-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> May I kindly ask you to make this work on Windows, too? Just
>>
>> sed -i -e s/MINGW/MINGW,HAVENOT/ t4201-shortlog.sh
>
> HAVENOT???
>>
>> on your Linux box and make it pass the tests.
>>
>> Thank you so much in advance.

Ah, I think I am slower than my usual today.
