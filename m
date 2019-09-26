Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92C61F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfIZVO0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:14:26 -0400
Received: from smtp82.ord1d.emailsrvr.com ([184.106.54.82]:53217 "EHLO
        smtp82.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbfIZVOZ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Sep 2019 17:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1569532464;
        bh=UZ4+buuoN2bPVsiy0PZwj81jeWVY4xu3MdrfkkRClSM=;
        h=Subject:To:From:Date:From;
        b=Wg8Pv6G033x1YiAxTfcPm+ASKUD/adEUQrWtUgfhbOODZ41jMhoPNhKiPhS1M3LsV
         aqyt/gDdW4qp+8Bc9uopTG4m4Cd4ZXfc5ualrkgIygsWou6k4ZrivkFltntsUu4wbf
         BTe3TFUNU12JzgTuQeGPKS3RDMSnvW5qpOQFTHBg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xiplink.com;
        s=20181102-2c3qeqyt; t=1569532464;
        bh=UZ4+buuoN2bPVsiy0PZwj81jeWVY4xu3MdrfkkRClSM=;
        h=Subject:To:From:Date:From;
        b=Tk67z02LD+kYPX18Mn+eHlXXCP0kXpMTpHZfdr9bo7WaRxwlOcfeBJK7F6nTU1cxY
         bee8LR5PT8uvP29pc7AD3yr0CmDdLbjL1L0DH5cdZbzcXiMd/SnbyxwmAsGMlj0eKD
         o+3hQhwJgsg7E+yTu1a9WuFz6KsXBQRmMFzhOpuQ=
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp11.relay.ord1d.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 368536026C;
        Thu, 26 Sep 2019 17:14:24 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 26 Sep 2019 17:14:24 -0400
Subject: Re: git-gui: disable the "loose objects popup" dialog?
To:     Pratyush Yadav <me@yadavpratyush.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CAGr--=K15nUcnsJWOP87uMMjeQmTgAeO_6hnr12k2zuNQjNyBw@mail.gmail.com>
 <91e5b3b0-08f9-66a8-ebdf-90effd34c888@kdbg.org>
 <20190926191545.ro7w6lbtlpbyxpk7@yadavpratyush.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <497c6951-6eba-9794-2590-2f34388598f4@xiplink.com>
Date:   Thu, 26 Sep 2019 17:14:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926191545.ro7w6lbtlpbyxpk7@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-09-26 3:15 p.m., Pratyush Yadav wrote:
> On 26/09/19 08:54PM, Johannes Sixt wrote:
>> Am 26.09.19 um 19:31 schrieb Birger Skogeng Pedersen:
>>> Every once in a while, I get the "This repository currently has
>>> approximately (some number) loose objects." popup dialog.
>>>
>>> I don't want to sound arrogant, but I find this popup along with the
>>> dialog showing after that prints the result of the compression,
>>> immensely annoying. And I've seen people mention before that they
>>> would, in some casese, rather not have to deal with the dialog[0].
>>>
>>> [0] https://stackoverflow.com/questions/1106529/how-to-skip-loose-object-popup-when-running-git-gui
>>>
>>> I get that git-gui merely wants to resolve a performance issue. But
>>> personally I'd prefer if git could just assume I always wanted to
>>> compress the database, and automatically do it without bugging me with
>>> the popups.
>>
>> I dislike the popup, too. But I want total control over my repository:
>> No automatic compression behind my back, in particular, when that
>> expires reflogs, and git-gui does that.
> 
> I agree. Doing stuff like this in background by default is not the best
> idea IMHO. If the user asks explicitly, fine, but don't do it by
> default.
>   
>>> I propose we implement the following options in git-gui:
>>> - ignore loose objects (do not show the popup), disabled by default.
> 
> Reading the Stackoverflow link, it seems this is already possible via an
> undocumented config variable "gui.gcwarning". I haven't tried using it
> though, but I see no reason for it to not work (looking at
> git-gui.sh:4141).

I use this, and it works.  I haven't seen that dialog in years of 
near-daily repo usage.

> Maybe we should add this variable in the options dialog, so people at
> least know it exists?

My experience with qui.gcwarning (i.e. that git-gui hasn't compressed my 
repo in a very long time) suggests that we can just get rid of this part 
of git-gui.  I seem to recall that this was suggested the last time this 
was discussed, because the rest of git's auto-gc machinery is now 
working quite well (compared to when git-gui was first introduced).

		M.


>>> - automatically, silently compress the database, without prompt. Also
>>> disabled by default.
>>
>> What about a configurable limit, but still show the dialog?
> 
> Do people really care that much about configuring this limit to warrant
> something like this?
> 
> 
> Talking about auto compression, would it be a better idea to let users
> disable the dialog, and then if they do want auto compression, they can
> just run a cron job (or the Windows equivalent) to do this on their
> repos? What reasons do people have to have this feature in git-gui,
> instead of running cron jobs?
> 
