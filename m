Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B3320248
	for <e@80x24.org>; Mon, 11 Mar 2019 18:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCKSP3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 14:15:29 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:55900 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726977AbfCKSP3 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Mar 2019 14:15:29 -0400
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1h3PSN-0005Tm-CN; Mon, 11 Mar 2019 19:15:23 +0100
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test
 on Fedora 29
To:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net>
 <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
 <20190311033755.GB7087@sigill.intra.peff.net>
 <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
Date:   Mon, 11 Mar 2019 19:15:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1552328128;0b5c991f;
X-HE-SMSGID: 1h3PSN-0005Tm-CN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.03.2019 um 12:58 schrieb Duy Nguyen:
> On Mon, Mar 11, 2019 at 10:48 AM Jeff King <peff@peff.net> wrote:
>> And AFAIK there is no good way to
>> modify the submodule-provided content as part of the build. Why do we
>> even have the submodule again? ;P
> 
> Because of dogfooding of course. This is an interesting use case
> though. I wonder if people often want to "patch" submodules like this
> (and what we could do if that's the case)

I usually do the following:

- Fork the sub-project
- Add a branch with my proposed patches
- Update the URL and the commit of the submodule in the super-project

This of course requires all users to do

git submodule sync

which is a bit incovenient, but works.





