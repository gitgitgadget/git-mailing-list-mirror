Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37DCD20899
	for <e@80x24.org>; Sat, 12 Aug 2017 06:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbdHLGUH (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 02:20:07 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:54527 "EHLO
        homiemail-a111.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750895AbdHLGUH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Aug 2017 02:20:07 -0400
Received: from homiemail-a111.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTP id 8D90A3C000740;
        Fri, 11 Aug 2017 23:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=jupiterrise.com; bh=k
        LQfKUI8DesW1iMBtk5mBcnV8HI=; b=U7TCwiYQtl5gtkGNNBfRsrKy5Ni7vFASZ
        TL/gbMSlzfhHfRW/nIjisHknk2vLHIc+DI3JFH1xmt9rWl4GLyUMht4hDk5nVgQF
        h52/jAlofqrhT28VXIvn1BpNdxIdjO9HE1tVMFiah+/9eBxaGdLtYxaL/4ZXyr9P
        eS6NpUYGBQ=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTPSA id 5B93F3C001C16;
        Fri, 11 Aug 2017 23:20:06 -0700 (PDT)
Received: from [192.168.20.50] (router.tgcnet.jupiterrise.com [192.168.20.58])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTPSA id 3F3D960608;
        Sat, 12 Aug 2017 08:20:04 +0200 (CEST)
Subject: Re: [PATCH 0/2] http: handle curl with vendor backports
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
References: <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com>
 <cover.1502462884.git.tgc@jupiterrise.com>
 <xmqq1sohzr85.fsf@gitster.mtv.corp.google.com>
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
Message-ID: <1b91d00f-eeae-30cf-0889-8fad05d849d3@jupiterrise.com>
Date:   Sat, 12 Aug 2017 08:20:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq1sohzr85.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GH
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08/17 00:15, Junio C Hamano wrote:
> "Tom G. Christensen" <tgc@jupiterrise.com> writes:

>> I have build tested these changes against upstream curl 7.12.0 (fails),
>> 7.12.1 and 7.15.5. I have also built and run the testsuite against the
>> Red Hat provided curl versions listed above.
> 
> Hmph, what does "(fails)" mean here?
> 

It means building against 7.12.0 fails which is expected because it is 
missing CURLINFO_SSL_DATA_{IN,OUT}. There are patches in the other 
thread that would add support for curl < 7.12.1 if necessary.

-tgc
