Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B3F206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbcLLTY1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:24:27 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:53983 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752708AbcLLTY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:24:26 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 5760FC3442;
        Mon, 12 Dec 2016 20:24:21 +0100 (CET)
Received: from mcmini.bolli (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id 291AFC3419;
        Mon, 12 Dec 2016 20:24:21 +0100 (CET)
Subject: Re: [PATCH 1/3] update_unicode.sh: update the uniset repo if it
 exists
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
 <64bc846c-0304-dd7b-73bf-a6c3a4135381@web.de>
 <c96d013c38df7737cfd551a0fce87314@drbeat.li>
 <ca10a51a-0fab-e4a4-8d7d-035673af4c06@web.de>
Cc:     git@vger.kernel.org
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <f068b579-fb1a-447b-283b-006686b90861@drbeat.li>
Date:   Mon, 12 Dec 2016 20:24:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <ca10a51a-0fab-e4a4-8d7d-035673af4c06@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.12.16 19:12, Torsten Bögershausen wrote:
> 
>>> Minor question, especially to the next commit:
>>> Should we make sure to checkout the exact version, which has been tested?
>>> In this case  cb97792880625e24a9f581412d03659091a0e54f
>>>
>>> And this is for both a fresh clone and the git pull
>>> needs to be replaced by
>>> git fetch && git checkout cb97792880625e24a9f581412d03659091a0e54f
>>>
>>>
>>> (Which of course is a shell variable)
>>
>> I was actually wondering what the policy was for adding submodules to the Git repo,
>> but then decided against it. Another option would be to fork uniset on GitHub and
>> just let it stay on a working commit.
>>
>> Junio, what's your stance on this?
>>
>> Beat
> 
> If I run  ./update_unicode.sh on the latest master of   https://github.com/depp/uniset.git ,
> commit  a5fac4a091857dd5429cc2d, I get a diff in  unicode_width.h like this:
> 
> -{ 0x0300, 0x036F },
> 
> +{ 768, 879 },
> 
> IOW, all hex values are printed as decimal values.
> Not a problem for the compiler, but for the human
> to check the unicode tables.
> 
> So I think we should "pin" the version of uniset.

That's what patch 3/3 fixes.
