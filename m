Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC6C20323
	for <e@80x24.org>; Thu, 16 Mar 2017 22:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbdCPWYs (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:24:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56298 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754534AbdCPWYq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:24:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0A6E692CF;
        Thu, 16 Mar 2017 18:24:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d6Ze3Fwn40D5l2dttyI51RUiQbg=; b=F8cXhA
        N2qVnY+TPEs/c9TbA4VxJNNzvPccs/BkZVDH/w60zcBsmUzbvcWlvZFYgg5K0CQM
        s9YKcIvWMTAR2AyX9MMgn8B7NhP+pu2a5oc66DhBK3s3J0H6Q1ioh7Fk4uKcAFZu
        oYCQB2jO0EP6BQVqXEKGiyNmgFOZeJesnHFmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dI9R6jh6PtQKHJWWuTaX9yxSQm1RDNVJ
        t6J8c9e2breLMkdgSi/mAGxUIcN0MjVIqw894iG4p/839t8fG1elTSQMsYI6h96+
        AU0OIo6vok0rX2j8miNXmb+cBNqtrBHKm2UEGQfnJmyt+xz3RYFxmRyqBVgUc6HW
        3icIMTz+PyE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9DE0692CE;
        Thu, 16 Mar 2017 18:24:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4208D692CD;
        Thu, 16 Mar 2017 18:24:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Re-integrate sha1dc
References: <alpine.LFD.2.20.1703161315310.18484@i7.lan>
        <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
        <20170316221044.ij5yuifmohktn6cl@sigill.intra.peff.net>
Date:   Thu, 16 Mar 2017 15:23:59 -0700
In-Reply-To: <20170316221044.ij5yuifmohktn6cl@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 16 Mar 2017 18:10:45 -0400")
Message-ID: <xmqq37ecc134.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4210E66E-0A97-11E7-B280-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 16, 2017 at 06:04:56PM -0400, Jeff King wrote:
>
>> So here's my version. It's on top of the hash.h tweak, as well.
>> 
>>   [1/5]: add collision-detecting sha1 implementation
>>   [2/5]: sha1dc: adjust header includes for git
>>   [3/5]: sha1dc: disable safe_hash feature
>>   [4/5]: Makefile: add USE_SHA1DC knob
>>   [5/5]: t0013: add a basic sha1 collision detection test
>> [...]
>>  t/t0013/shattered-1.pdf |  Bin 0 -> 422435 bytes

A 420k binary blob has become ~500k base85 binary patch, which is
larger than 100k.

> So obviously I had the same 100K problem you did on the first patch, but
> the fifth one also won't make it to the list. You can pull the whole
> thing from:
>
>   https://github.com/peff/git.git jk/sha1dc

Thanks.  

For today's integration, I have the one from Linus only because it
came earlier and today's integration cycle was already running.  I
agree with this series that disables the safe-hash thing.

I am wondering if we should queue another one for .travis.yml on top
to force use of USE_SHA1DC=YesPlease during the tests.  I expect
that we'd be encouraging its use for ordinary users without any
specific needs in the release notes in 2.13 release.


