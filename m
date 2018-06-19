Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7322E1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030274AbeFSRdX (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:33:23 -0400
Received: from mout.web.de ([217.72.192.78]:49073 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030259AbeFSRdV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:33:21 -0400
Received: from [192.168.209.18] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MY6sm-1fiXu80Mnw-00UvzJ; Tue, 19
 Jun 2018 19:33:17 +0200
To:     Git Mailing List <git@vger.kernel.org>, peff@peff.net
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: t5310 broken under Mac OS
Message-ID: <b9dfbd6d-60fb-056a-0f06-b5c3350c7623@web.de>
Date:   Tue, 19 Jun 2018 19:33:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:2TAMdxEbI7WvZj7oqML2EKuw8fZAz60ar/u/QFIVeJ+OPl2ZK86
 HJdlKmtIyjhTaPoQ9i/pVe/1+demfr+eat3BEwn5A+a2fZK36bEFUEJTbbE8ak15AAToa33
 r0elMxbz03uiRR+yniDsUhIR7ZI/GnwijrlgMc7ixc/HgBdHh4p711wtEphAR29BAq6XU9t
 vx/2DLaLFovuT5bYK8xRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CEPQuerJcJo=:2ZDXJfaA3PhlktlLa8BVbB
 GYDUD+DSiLxV3KHLVrvhh98YERs9GfrojFGDn+n0fQR8o+NgmUtEcxuBAZJ7vw7i0e+2cZFT3
 PLmOZMo2n6oJmADmttChy9TjukzRF78HNn306t7skgerW+CmN3MHrcQPjOsgphwS1knFme3cI
 2TL2HoMYTKK9p7eppzKUX9/IvATxyCM/oHgxftT/J+tAMc4AVLYzQChZIcTECMqx8e9tOlmiC
 4DBij7VmrPSWGldRqbwgcGVGkW7nY27VTKzUsaKpttq+ghPC0WKCqIzPKRY+2/zu65g9i0Alg
 jE4MlIfL/hFehdE+3E1hE2m6xeB79RZCZl0CPV23tTYs78b9MsGZd1vABBnCbu5t2E1IOtnvW
 qM5kSJro9MpsKn8z+iGum997K+d1PJ/zqiZFe6XRWxsTg1/3PZ/0M7ieQ9M77lZGSiRgBK88n
 +hbFsWUk8E5/28niVzfuMIjyvpDW+P89gNV6R6WlAlK6gLNY2tZbZQbSVKPVzO0QXEYrUwfMc
 pXN31Ux4F/4wIaHsxGbOgbQAq2ABFvLWq7Q0pTFrXGDKZiXLF+c906lVj0+jtk5O4gcrQ/Ofr
 CmfI7WD3mzra55GyPLpFjTN/m7EBGoUZT9NDWrSKm2s0F1wxER0yHUqTSSy6KRnmI8v/1HN66
 kPCrfhSmK6Lfuj5X/iyqKNGRUB7AzG7sbSnBKlYxvKGtyZWctzws8FCQX8gII9FkW/zRpwF+l
 ZelVyBF3yROzwb+B2dcz48D+6DHi9AbbdoduDyQkRGX3RapobpJmmtEgFDvTM99i7uNjgnyEg
 EdCZvGj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One test case fails here,
but I am to tired to dig further.


ok 42 - pack reuse respects --incremental

expecting success:
     git repack -ad &&
     git rev-list --use-bitmap-index --count --all >expect &&
     bitmap=$(ls .git/objects/pack/*.bitmap) &&
     test_when_finished "rm -f $bitmap" &&
     head -c 512 <$bitmap >$bitmap.tmp &&
     mv $bitmap.tmp $bitmap &&
     git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
     test_cmp expect actual &&
     test_i18ngrep corrupt stderr

override r--r--r--  tb/staff for 
.git/objects/pack/pack-8886db3fce4f9657c1a43fee7d3ea4f2a4b5be2d.bitmap? 
(y/n [n]) not overwritten
error: 'grep corrupt stderr' didn't find a match in:
<File 'stderr' is empty>
not ok 43 - truncated bitmap fails gracefully
#
#        git repack -ad &&
#        git rev-list --use-bitmap-index --count --all >expect &&
#        bitmap=$(ls .git/objects/pack/*.bitmap) &&
#        test_when_finished "rm -f $bitmap" &&
#        head -c 512 <$bitmap >$bitmap.tmp &&
#        mv $bitmap.tmp $bitmap &&
#        git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
#        test_cmp expect actual &&
#        test_i18ngrep corrupt stderr
#

# failed 1 among 43 test(s)
1..43

