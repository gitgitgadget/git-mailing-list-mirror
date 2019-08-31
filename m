Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95EDE1F461
	for <e@80x24.org>; Sat, 31 Aug 2019 07:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfHaHRR (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Aug 2019 03:17:17 -0400
Received: from smtp01.domein-it.com ([92.48.232.141]:36806 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHaHRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Aug 2019 03:17:16 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id EAE2A807B72C; Sat, 31 Aug 2019 09:17:13 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id 44D78807B72D;
        Sat, 31 Aug 2019 09:17:12 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:45354 helo=[192.168.1.10])
        by ferret.domein-it.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <ben@wijen.net>)
        id 1i3xdF-0000qf-01; Sat, 31 Aug 2019 09:17:09 +0200
Subject: Re: [PATCH v6 1/2] builtin/rebase.c: make sure the active branch
 isn't moved when autostashing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Szeder_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190829164757.7301-1-ben@wijen.net>
 <20190830151607.4208-1-ben@wijen.net> <20190830151607.4208-2-ben@wijen.net>
 <xmqqsgpiwgts.fsf@gitster-ct.c.googlers.com>
From:   Ben <ben@wijen.net>
Message-ID: <bf659b1d-b9a4-cb9e-e660-fa743b4db84c@wijen.net>
Date:   Sat, 31 Aug 2019 09:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqsgpiwgts.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1i3xdF-0000qf-01
X-Domein-IT-MailScanner: Found to be clean
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30-08-2019 22:15, Junio C Hamano wrote:
> Ben Wijen <ben@wijen.net> writes:
> 
>> +
>>  			struct commit *head =
>> -				lookup_commit_reference(the_repository,
>> -							&options.orig_head);
>> +				lookup_commit_reference(the_repository, &head_oid);
> 
> This introduces decl-after-statement error, doesn't it?
> 
> Perhaps like so...

Would you like me to send in another patch or leave it like this?

