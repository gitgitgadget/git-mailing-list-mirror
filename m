Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AEE9208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 20:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbdHJUdW (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 16:33:22 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:53198 "EHLO
        homiemail-a111.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752889AbdHJUdV (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Aug 2017 16:33:21 -0400
Received: from homiemail-a111.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTP id 80E183C001C18;
        Thu, 10 Aug 2017 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=from
        :subject:to:cc:references:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        jupiterrise.com; bh=Fncv8tGZee4k7+sOhQ3MQkypeOo=; b=aJ/VcMKA+MRV
        /BCSmpXjlj3KLPrzWtxwlZkfegOezrDHbkJWK0Hik/X9KwIYBEliyRriCozrYcG5
        5BqS2WSZUQxnaE7Sn+TSrSddzV6BVEfVSVXh9K3uLRH8P1y4IfB2crcw7I74mSXo
        Gj2YFSIOOhhBMVYiSMYAEITyk2dJjU8=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTPSA id 492D03C001C16;
        Thu, 10 Aug 2017 13:33:21 -0700 (PDT)
Received: from [192.168.20.50] (router.tgcnet.jupiterrise.com [192.168.20.58])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTPSA id 9F2CD605F0;
        Thu, 10 Aug 2017 22:33:18 +0200 (CEST)
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
Subject: Re: [PATCH 0/4] dropping support for older curl
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
 <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
Message-ID: <873e1f31-2a96-5b72-2f20-a5816cad1b51@jupiterrise.com>
Date:   Thu, 10 Aug 2017 22:33:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GH
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[I am resending this since the original does not seem to have made it to 
the list, at least I cannot find it in any archives]

On 09/08/17 23:47, Jeff King wrote:
> On Wed, Aug 09, 2017 at 11:42:12PM +0200, Johannes Schindelin wrote:
>> I mean, if we even go out of our way to support the completely outdated
>> and obsolete .git/branches/ for what is likely a single user, it may not
>> be the worst to keep those couple of #ifdef guards to keep at least
>> nominal support for older cURLs?
> 
> You've totally ignored the argument I made back then[1], and which I
> reiterated in this thread. So I'll say it one more time: the more
> compelling reason is not the #ifdefs, but the fact that the older
> versions are totally untested. 

Perhaps you forgot but I stated in the original thread that I build RPMS 
for RHEL/CentOS 3, 4, 5, 6 and 7. I still do and I run the testsuite 
every single time.
I currently have 2.13.3 up for el4, el5, el6 and el7.
Only el4 requires any patches, the rest will build out of the box with 
the vendor supplied version of curl.

The plan was to drop the el4 builds for 2.14.0 to get rid of the patches.

> In fact, they do not even compile, and
> yet I have not seen any patches to fix that.
> 

I just built a pristine 2.14.0 on CentOS 5 with curl 7.15.5. No problems 
at all neither with building nor with running the testsuite.

> So IMHO this is about being honest with users about which versions we
> _actually_ support.
> 

I have no problem with you wanting to drop support for older curl 
releases (such as 7.15.5) but don't use the argument that it doesn't 
currently build and nobody cares.

Also FWIW Red Hat continues to support RHEL 5 with the Extended 
Life-cycle Support program until 2020-11-30.

-tgc
