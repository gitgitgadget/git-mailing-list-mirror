Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352F11F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 14:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfJYOPk (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 10:15:40 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.98]:56419 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfJYOPk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 10:15:40 -0400
Received: from [84.175.189.53] (helo=[192.168.2.6])
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iO0NM-0006da-56; Fri, 25 Oct 2019 16:15:36 +0200
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com>
 <pull.407.v2.git.1571755538.gitgitgadget@gmail.com>
 <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
 <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com>
 <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <4bd58e13-4e6e-5122-6127-4399d34fde43@syntevo.com>
Date:   Fri, 25 Oct 2019 16:15:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25.10.2019 16:02, Johannes Schindelin wrote:
> My example is even worse (read: more convincing), though:
> 
> fatal: git uploadfata-lp: raemcokte :error:  upload-pnot our arcef k6: n4ot our ea4cr1e3f 36d45ea94fca1398e86a771eda009872d63adb28598f6a9
> 8e86a771eda009872d6ab2886
> 
> So maybe you want to use that?

OK.

> Again, I don't think that it is wise to try to make this work for
> arbitrary sizes of error messages.

 > My point is: I don't want to "fix" truncation. I actually think of it
 > as a feature

It would be helpful to hear opinions from someone else, before the patch 
is reworked significantly.

> I know _which_ two processes battle for `stderr`.

I think I said the same in code comment, bullet 3, near t5516?
