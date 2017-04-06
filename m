Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B478F1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 16:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933405AbdDFQnP (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 12:43:15 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:45084 "EHLO
        homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932560AbdDFQnN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Apr 2017 12:43:13 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id 343C66000503;
        Thu,  6 Apr 2017 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
        :to:references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=jupiterrise.com; bh=i
        RXKCdQNaTBtNyUtlTbNpUOT5kY=; b=w2JHMX/bKXm9qDcp1JFpkBZCBaZawvD31
        KFyaluwgsHgK19rsAED181MS7L5o9bWdsZqyDQbOLNFlBQOj3ceuV2CZHJ2QCEwc
        ebwKomQKzMFuGgnwGkEcI0o7PYpZZko+GlW+GLU1SQTMgYaCvF9Hpz9jRCDZArQ6
        u0SABalC+0=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id E3BA36000501;
        Thu,  6 Apr 2017 09:43:11 -0700 (PDT)
Received: from [192.168.20.43] (router.tgcnet [192.168.20.58])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTPSA id A4AC0612D7;
        Thu,  6 Apr 2017 18:43:09 +0200 (CEST)
Subject: Re: [RFC] dropping support for ancient versions of curl
To:     Jeff King <peff@peff.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
 <20170406092122.titsfyxpucj6xoe4@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
Message-ID: <ef64656b-12d7-a041-e1b9-ce83f8cbd2fc@jupiterrise.com>
Date:   Thu, 6 Apr 2017 18:43:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170406092122.titsfyxpucj6xoe4@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04/17 11:21, Jeff King wrote:
> On Wed, Apr 05, 2017 at 11:33:37AM +0200, Tom G. Christensen wrote:
>> I don't use the el3 and el4 versions much any more and el5 use will also
>> drop of now as I'm busy converting machines from el5 to el7.
>
> Thanks for sharing, that's a really interesting data point.
>
> I'm not quite sure what to take away from it, though. Either "yes,
> somebody really is using Git with antique versions of curl". Or "even
> the antique people are giving up el4, and it might be reasonable to
> start requiring curl >= 7.11.0".
>

I do not know of anyone who actually need to have the latest git on 
their el3 or el4 system, myself included.
I'm not here to champion the inclusion of support for el3 and el4, there 
is no point.
I kept git buildable on those platforms since I could do so with minimal 
effort and good testresults, but this was entirely for my own satisfaction.

I know of no users of the packages that I make available other than 
myself and my work place (only el5 and later, soon just el6 and later).

There is not currently any patches needed to use git on el5 with curl 
7.15.5. The only thing not working out of the box in 2.12.2 would be the 
emacs integration.

If you must drop support for old curl releases then from my perspective 
the cutoff should be 7.19.7 at the latest since that is what ships with 
RHEL 6 and that is still supported by Red Hat.
Other long term supported Linux releases may have different ideas, I 
wouldn't know.

-tgc
