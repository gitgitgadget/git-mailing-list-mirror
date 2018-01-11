Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2B91F406
	for <e@80x24.org>; Thu, 11 Jan 2018 10:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933356AbeAKKlG (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 05:41:06 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:34567 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933141AbeAKKlF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 05:41:05 -0500
Received: from [192.168.2.201] ([92.22.5.17])
        by smtp.talktalk.net with SMTP
        id ZaIAeMFhImITaZaIAe2vs9; Thu, 11 Jan 2018 10:41:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1515667263;
        bh=TxqpglZ2rty0ey/kwfMoSx5yHI2Tikda3bq9kKFII74=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W20ZNASVwB0A6Bc5NUs8Rb5OnejX+x7i46wgdAJoP+x5DWfkzWXusXzlPnfnmyA0z
         2jvtKCW61rMqX7uIuSvwNGakBCCkSxyKAbENKTJQx0VXVpVofpeucZ5dzadn27SXef
         bvo50cE3nXmp5q4WguHrbHDwBMPzxdj3oXauqDk4=
X-Originating-IP: [92.22.5.17]
X-Spam: 0
X-OAuthority: v=2.2 cv=W/RIbVek c=1 sm=1 tr=0 a=6mE+822v9fraWtSSWJ0Caw==:117
 a=6mE+822v9fraWtSSWJ0Caw==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=siVpqwWV6uSITwen9UsA:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 8/9] sequencer: try to commit without forking 'git
 commit'
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171211141330.23566-1-phillip.wood@talktalk.net>
 <20171211141330.23566-9-phillip.wood@talktalk.net>
 <20180110205351.GA73826@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1801102332350.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <5efbad65-6afe-e135-4681-ba380cd6797f@talktalk.net>
Date:   Thu, 11 Jan 2018 10:41:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1801102332350.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHyB09K+LhaeKfgpTwa250FnldUFF4txcDgC2B5cQkKgArkeiIiqwapdm1L8a4IDYRl0+1eqTex8LTIAMiauIftI7Am5sg1O5kDEBRG0VtE6UGhuY8oI
 j5BfIq9SqlZdomYJ4QTEQA6Ejjm8+fSAMER17+VPSqe0EHOoCqIDKvE9LKCGxcdrrVUYE4T8ScaaoupgX2eeSB93SQt7IA8yfTCD2VNGtNX419AMR7u16mhb
 yGl22FIEfsCjzi2k15NQbNPrEHipZ3FTcc4qSyAYV8QY+ODN1ID1cXtAyCQ5cJiTMDcN44JcbSPP2oBc4WqtZ64fDuDybt+mwZhz13nhGLFhko7Ft3tE9bED
 HZoMY/6UKnGeEZ3qao2asAt13MkwjmfwUurV67AvaHhW2ENndr909Q+Xw4ZDKQltMKw/ROxiz3y+8mtgbyATmeYI67i2UA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/01/18 22:40, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 10 Jan 2018, Jonathan Nieder wrote:
> 
>> Phillip Wood wrote:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> If the commit message does not need to be edited then create the
>>> commit without forking 'git commit'. Taking the best time of ten runs
>>> with a warm cache this reduces the time taken to cherry-pick 10
>>> commits by 27% (from 282ms to 204ms), and the time taken by 'git
>>> rebase --continue' to pick 10 commits by 45% (from 386ms to 212ms) on
>>> my computer running linux. Some of greater saving for rebase is
>>> because it no longer wastes time creating the commit summary just to
>>> throw it away.
>>
>> Neat!  Dmitry Torokhov (cc-ed) noticed[1]

Thanks for reporting and bisecting this Dmitry. When I was preparing
this series I checked to see if it needed to run the 'pre-commit' hook
but missed the 'prepare-commit-msg' hook.

> that this causes the
>> prepare-commit-msg hook not to be invoked, which I think is
>> unintentional.  Should we check for such a hook and take the slowpath
>> when it is present?
> 
> We could also easily recreate the functionality:
> 
> 	if (find_hook("pre-commit")) {
> 		struct argv_array hook_env = ARGV_ARRAY_INIT;
> 
> 		argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s",
> 			get_index_file());
> 		argv_array_push(&hook_env, "GIT_EDITOR=:");
> 		ret = run_hook_le(hook_env.argv, "pre-commit", NULL);
> 		argv_array_clear(&hook_env);
> 	}

Thanks Johannes, though it needs to run the 'prepare-commit-msg' hook,
the current code in master only runs the 'pre-commit' hook when we edit
the message. I'll send a patch with a test.

Best Wishes

Phillip

> (This assumes that the in-process try_to_commit() is only called if the
> commit message is not to be edited interactively, which is currently the
> case.)
> 
> Ciao,
> Dscho
> 

