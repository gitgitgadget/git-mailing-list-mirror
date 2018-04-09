Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604121F404
	for <e@80x24.org>; Mon,  9 Apr 2018 19:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbeDITuA (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 15:50:00 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753729AbeDITt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 15:49:59 -0400
Received: from furore ([82.194.150.97]) by mrelayeu.kundenserver.de (mreue101
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LheYD-1ejGPF3nOr-00msDb; Mon, 09
 Apr 2018 21:49:57 +0200
Date:   Mon, 9 Apr 2018 21:49:55 +0200
From:   Florian =?utf-8?Q?Gamb=C3=B6ck?= <ml@floga.de>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [RFC PATCH 1/1] completion: Load completion file for external
 subcommand
Message-ID: <20180409194955.GA22994@furore>
Mail-Followup-To: Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>,
        Szeder =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGZ79kZzMDjKzuHn5ph+zMkh_9Zt_at37MssOjHvzJndUjt9yQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:EF6Ub2BABy59u/zIcTQGJWl+YG/nrqjZAT0iNFj5+00uWfCBQRu
 Q3rMufZSDbpiqB/SzsWglE+MuJfi37m9EydLvvqhU3zk1We4ekzO1TVJ+7Tu+gwBLZNsmu0
 EA+KxjTeW+xqXQMrl47WI21huoloLNJA1d1nafrC+pFV8Y8yDLfsEXpJcc15L8tq+eGTVS1
 ZwVOu3YFv2Tg4Yp8THL+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rD/wZGSzCYs=:keaHGMQY/OYJ+91cNok1NA
 ooNrHWp1JzuDTSbVCPJN7nTJEXAhqlcWoleCA+yrv3yCu1Ztdg05iOlRU3zoNRxtb9BH2O34d
 K/tLaMcb8Jq52YjWMeGF1uE74Z8NnSad96Awxjyr1vPT9PdAAeSV/Yj679NO/olVgtPSn8tpR
 wc4AwZSqAMsGU3ZDQe5S1cjcf2jwAvxhAtF7B5Cf/BUBsY6rdFmtaeuNm8ULM2r7laxm+Qpet
 Udv/X/9606iYfaqxqy7fOH6BTF+7cw+8RUkUPYB945CZt869YexhULgLJzM3VySiIQA3qIBuh
 AYgiYMFLro2l0L5KIq5ROnufe3ANnZzDYz+Q8pWpRor991TbW9iLgqFO4VM5knUN5jl0c1rkW
 JcyGQWb8BP/8cZWhedZpfwCftWnDLmnN/yjM4BkEfU1E/rD4NPepGNtO6Qul8bpqWfguN1y1M
 9Nm52odSGw3iTNSPtMJXgh5HQZJfp7LHNnvTqviVNdcBB2v9sTe+gVsrj1MZ1lz/jb9BWknUZ
 uPKGDYQ3F6Rv3dhtRkvTQ88xZQ3H6xO2y4/4g5D+S4myji63p5x9U151dCIMiia4yvAJAqwrp
 SpsdoSNnMm7ZT9YmlCRdU1O3p2Fo9UhTs+9/yMVrv5/1D64qlv38PgPmjbk33M6CG01mZ9K5p
 o/Bnt7UA0ZZ53zfqlcfWOeNldeG95GjylU3pCmUwo8pbq6gZTk9ij/YgFu+XTG1hdxRbt3o4q
 isAVokAbZGxIGiJ9g0a1OFkI4V9M0rZ5Xa8tBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-09 11:26, Stefan Beller wrote:
>> Since bash-completion started to use dynamical loading of completion 
>> scripts somewhere around v2.0, it is no longer sufficient to drop a 
>> completion script of a subcommand into the standard completions path, 
>> /usr/share/bash-completion/completions, since this script will not be 
>> loaded if called as a git subcommand.
>
> Also v1.90 here? (hint from the cover letter, please be exact)

Yes, it started at 1.90. I will reword the commit message and be more 
exact in the next iteration.

> If Gits own completion script would be broken up by subcommand, would 
> that also deliver an improvement in performance?

As it is now, the completion script is quite big. On a system with 
limited resources, the initial loading time can be long and the memory 
footprint is big, given that most users will just use a few commands. If 
you just use the "commit" subcommand, the first loading of the two 
(smaller) scripts will be slightly longer the first time (but not as 
long as with one big script, I think), but the footprint will be 
drastically lower. The whole script is 56kB big (without comments), 
after radically removing everything which is not connected to 
_git_commit, it is only 11kB.

So to answer your question: Yes. My first intuition is, that by 
splitting the completion script and loading the sub-scripts dynamically, 
it will improve in terms of speed and overall memory footprint, at least 
for the average user that does not fire up all possible git commands.

-- 
Regards

Florian
