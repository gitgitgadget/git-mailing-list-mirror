Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769BF1F461
	for <e@80x24.org>; Tue, 14 May 2019 14:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfENOFS (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 10:05:18 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:57582 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENOFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 10:05:18 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id QY3PhRj5rp7QXQY3PhXt37; Tue, 14 May 2019 15:05:16 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=RcLbxc6eQJiBPGDZ0JYA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: git --help not actually showing the git(1) help page..
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <0d37203a-e738-bad3-41e1-05204abc138b@iee.org>
 <20190513205301.GA22745@sigill.intra.peff.net>
 <a0afd3c4-93ff-31e6-a622-5751c6b5a549@iee.org>
 <xmqqwoiu9dpb.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <3cd065d1-9db5-f2e6-ddff-aa539746d45e@iee.org>
Date:   Tue, 14 May 2019 15:05:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqwoiu9dpb.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfAxFtktzy7zMX5GdnJM/nR22CGMQvytBnb/JSP2ywjxJAziizKAgE0fSVK90PbwuBgk8ySvdkaoOGX//8vptr2GHcNQeKlGJ0hJUZp8Y7sqPom2zT7ib
 Q2sjbZV6qlUViCv0osX7Tn/ekn2WyXe3O8Uz3jY8kAquOeVFPBKQu7KsZf6U2iaip2/UBer/Pgtw1/nmtZf1GmCgguR4vIfTxQmJaHG4iDT+3qmAPzqEk6Dk
 AAutLjbq/CzgAE0ytiA3ZY/1w6X4x81ZeByHRJPNDNRqYuZsio45XLo/KSqRFJhN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,
On 13/05/2019 23:44, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
>
>> On GfW I commonly use the `git <cmd> --help` when things go wrong, so
>> making the response to that give the right advice would be good.
> There are three levels of details ;-) "git --help" is meant as a
> shorter and sweeter version of "git help git" that is more detailed
> than "git -h".
Though that's not what happens at the moment. For the plain `git --help` 
case it simply defaults to the `-h` case, while for any other `git cmd 
--help` it does pop up the git-for-windows configured web browser manual 
page.
> It is conceivable for an enterprising developer to write a set of
> documentation with medium level details and make "git add --help"
> give such a medium level doc, more detailed than "git add -h" but
> more concice than "git help add".
I'd agree that there's a need for some typical usage/teaching level 
documentation to _complement_ the reference manual nature of the man 
pages. It's a chicken - egg situation for some users we/they need the 
bit of education before they can know they need to refer to, and 
understand, the respective man pages.

> Those who did "git <cmd> --help"
> did not bother doing so.
>
I tend to go with including the complementary usage/teaching aspects in 
a distinct section of the man pages, though some of this is based on 
examples from other software, e.g. Matlab for design/systems engineers.

A simplistic patch for just the 'usage' message to follow.

Philip
