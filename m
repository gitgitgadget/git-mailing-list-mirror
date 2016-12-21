Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE311FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 21:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756963AbcLUVJy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 16:09:54 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:55403 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756493AbcLUVJw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 16:09:52 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tkS306fXhz5tlP;
        Wed, 21 Dec 2016 22:09:48 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 632732222;
        Wed, 21 Dec 2016 22:09:48 +0100 (CET)
Subject: Re: Allow "git shortlog" to group by committer information
To:     Junio C Hamano <gitster@pobox.com>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
 <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
 <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
 <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
 <16b115e0-3a7e-a5c2-1526-44bbcfc97db8@kdbg.org>
 <xmqq60melazp.fsf@gitster.mtv.corp.google.com>
 <xmqq1sx2lara.fsf@gitster.mtv.corp.google.com>
 <xmqqvauejvnr.fsf@gitster.mtv.corp.google.com>
 <d2ac90d6-c4f4-a759-a6e2-2d7fe5bb1c1d@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a74c5915-d00e-cf85-1fbe-94647586c8aa@kdbg.org>
Date:   Wed, 21 Dec 2016 22:09:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <d2ac90d6-c4f4-a759-a6e2-2d7fe5bb1c1d@kdbg.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.12.2016 um 19:52 schrieb Johannes Sixt:
> Am 20.12.2016 um 19:35 schrieb Junio C Hamano:
>>  test_expect_success 'shortlog --committer (internal)' '
>> +    git checkout --orphan side &&
>> +    git commit --allow-empty -m one &&
>> +    git commit --allow-empty -m two &&
>> +    GIT_COMMITTER_NAME="Sin Nombre" git commit --allow-empty -m three &&
>
> Clever! Thank you. Will test in 12 hours.
>
>> +
>>      cat >expect <<-\EOF &&
>> -         3    C O Mitter
>> +         2    C O Mitter
>> +         1    Sin Nombre
>>      EOF
>>      git shortlog -nsc HEAD >actual &&
>>      test_cmp expect actual
>>
>

I confirm that t4201 now passes on Windows with this fixup.

-- Hannes

