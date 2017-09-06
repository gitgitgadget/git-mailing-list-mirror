Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80ABE209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 15:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932901AbdIFPdh (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 11:33:37 -0400
Received: from siwi.pair.com ([209.68.5.199]:48930 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932852AbdIFPdg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 11:33:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8F0D684590;
        Wed,  6 Sep 2017 11:33:35 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 394E38458D;
        Wed,  6 Sep 2017 11:33:35 -0400 (EDT)
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
To:     Junio C Hamano <gitster@pobox.com>
Cc:     martin.agren@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, peff@peff.net
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <20170830185922.10107-1-git@jeffhostetler.com>
 <20170830185922.10107-2-git@jeffhostetler.com>
 <xmqqo9qoaab4.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <495c2fde-5592-e878-347f-dc7be7517724@jeffhostetler.com>
Date:   Wed, 6 Sep 2017 11:33:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9qoaab4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/5/2017 9:24 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
> 
> I feel somewhat stupid to say this, especially after seeing many
> people applaud this patch, but I do not seem to be able to even
> build Git with this patch.  I am getting:
> 
>      common-main.o: In function `hashmap_get_size':
>      /home/gitster/w/git.git/hashmap.h:260: multiple definition of `hashmap_get_size'
>      fast-import.o:/home/gitster/w/git.git/hashmap.h:260: first defined here
>      libgit.a(argv-array.o): In function `hashmap_get_size':
>      /home/gitster/w/git.git/hashmap.h:260: multiple definition of `hashmap_get_size'
>      fast-import.o:/home/gitster/w/git.git/hashmap.h:260: first defined here
>      libgit.a(attr.o): In function `hashmap_get_size':
>      ...
> 
> and wonder if others are building with different options or something..

That's odd. I'm not seeing that.  My Ubuntu VM is reporting:
     $ gcc --version
     gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005

I'll change it to static in the next version.  Hopefully that will
take care of it.

Thanks,
Jeff

