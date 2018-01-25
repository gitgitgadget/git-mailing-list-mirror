Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2740B1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 16:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeAYQd6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 11:33:58 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:41478 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbeAYQd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 11:33:57 -0500
Received: from [192.168.2.240] ([92.22.6.159])
        by smtp.talktalk.net with SMTP
        id ekTJegwcObjdZekTKespr5; Thu, 25 Jan 2018 16:33:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1516898035;
        bh=XM/ZgakkbbrkMEhjqGVIdXufZGCCPzT1aJM1B0p+lCg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LI36lCXsFtoIhPPfMdaU0Q7eF6CcjxofgPs5XoEjOoKZgDKaNwcWB+87L+otUcEeM
         hhaCa6Nf7xo+Q8tXtz1Er/gpBCDvnFVL2I8dIZ3tM2JAQSd28UbT6KP1FO0TdkN2iE
         hVJlDBv3k5KC0eAF9lWkhOTZpiHSnvaGiR8nnXZk=
X-Originating-IP: [92.22.6.159]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=zHCrIP3pJrCm+L4FAUKT3Q==:117
 a=zHCrIP3pJrCm+L4FAUKT3Q==:17 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8
 a=evINK-nbAAAA:8 a=pGLkceISAAAA:8 a=Pe2gm5_r0UhPUR4akd0A:9
 a=DmOjOt0yi2vgyUOV:21 a=SVBS2Lvw-hvUI28N:21 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/3] sequencer: run 'prepare-commit-msg' hook
To:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
 <20180124123422.10637-1-phillip.wood@talktalk.net>
 <20180124123422.10637-4-phillip.wood@talktalk.net>
 <3587bc5f-c5f7-d037-6644-25e21a5f4942@ramsayjones.plus.com>
 <xmqqh8rbdqwk.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <f4953ce5-0fb2-e1f8-fe07-cd541a53cc4e@talktalk.net>
Date:   Thu, 25 Jan 2018 16:33:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqh8rbdqwk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOYt0qJZVVtWWzDekVmUgZkCgNGByYjwUizClPMtv9jDLGQDUm5pindiDDMVbp/+c+6qVz1WPZP3d4XeEbmxJh8TIbNIOAAShe+/2VjTrkPm2mcz/ogT
 /CPJhmnSJaUkF52kzF0H/wd6l8rsAOIWK9vRdcMo3u5luI5ZXGcNiJ8VgSYzrOlL2lktt8Yeg6C3ulRDTZcLBaehfQlUz5fjcckc3O2DA0LIbX70wylDqB2j
 +ievjuYRGwKMx6U45OQifSjKxzIZC0vWhRlP+RAaQ+1XPDW2gAfPQdPPgkqC78p7eIvP/rfLYu8sCcR/cWC6GwiDZ0uwu30iA6CtGRDIE3ZBWFRM1lOLXvdU
 KRPcqZaiejJwokVTxs76ceUffnv2S18/449rYgdHe0ZUStZ90xw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/01/18 18:59, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> On 24/01/18 12:34, Phillip Wood wrote:
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Commit 356ee4659b ("sequencer: try to commit without forking 'git
>>> commit'", 2017-11-24) forgot to run the 'prepare-commit-msg' hook when
>>> creating the commit. Fix this by writing the commit message to a
>>> different file and running the hook. Using a different file means that
>>> if the commit is cancelled the original message file is
>>> unchanged. Also move the checks for an empty commit so the order
>>> matches 'git commit'.
>>>
>>> Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> Reviewed-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>>
>> Echoing Eric's earlier email, I don't think this Reviewed-by is
>> warranted - I only requested the addition of a static keyword,
>> I didn't actually review the patch.
> 
> Thanks for clarification, and I tend to agree.  You, Eric and I
> certainly did not review what is posted here, so if I "git am" these
> patches as-is, we'd be lying.
> 
> Having said that, I think this round takes all the review comments
> raised against the previous round(s) into account.  So I'm tempted
> to tweak them with s/Reviewed-/Helped-/ and queue.
> 
Thanks Junio, I wasn't sure whether to go with Reviewed-by or Helped-by, 
I'll know for next time

Best Wishes

Phillip
