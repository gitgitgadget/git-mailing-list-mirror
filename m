Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8B40208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 15:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeG2RDw (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 13:03:52 -0400
Received: from avasout06.plus.net ([212.159.14.18]:46745 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeG2RDw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 13:03:52 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id jngpfYZj3WLW2jngqfC0HJ; Sun, 29 Jul 2018 16:33:01 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=BCjA09oAAAAA:8
 a=QxYYmKw9cizZgx1knY8A:9 a=lxSSdP6VzNgZo_c9:21 a=VNVQsAW917523ZzG:21
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22
 a=jYKBPJSq9nmHKCndOPe9:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] t5562: avoid non-portable "export FOO=bar" construct
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Max Kirillov <max@max630.net>
References: <c5b2a072-5058-0d3e-8fb0-52b84bfcdfa9@ramsayjones.plus.com>
 <CAPig+cSCsOXi4e8idXwLo41rjDREvvtG5P_bNtEWybUbAZj9Hg@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <da1bba33-b2c4-08b4-60f9-d545da56882a@ramsayjones.plus.com>
Date:   Sun, 29 Jul 2018 16:32:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cSCsOXi4e8idXwLo41rjDREvvtG5P_bNtEWybUbAZj9Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD/JzLeamvashh/jb1afoJh2TM35inh8W39swFVplt60cGcil0Ctg0AFDdb48wDM8XdxvZYQhp11XQPOBaoi/qZA1uxZRk3fdyL2SvxEYSBNpJv3dymQ
 J0aQFbgFr9Kq8SglHP0CB3jJp9aVSCFWovpY92SC7gHymQT2CAc+UoI2e6U1ZWhFoGk6EIMPbcaUDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/07/18 04:13, Eric Sunshine wrote:
> On Sat, Jul 28, 2018 at 6:51 PM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>> Commit 6c213e863a ("http-backend: respect CONTENT_LENGTH for
>> receive-pack", 2018-07-27) adds a test which uses the non-portable
>> export construct. Replace it with "FOO=bar && export FOO" instead.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>> Could you please put this on top of the 'mk/http-backend-content-length'
>> branch. This test tickles the new "export FOO=bar" check, so the test
>> suite does not run otherwise.
> 
> The "export FOO=bar" check comes from 9968ffff0d (test-lint: detect
> 'export FOO=bar', 2013-07-08), so is not exactly new.
> 
> Perhaps you were thinking of [1] a0a630192d

Heh, yes you are obviously correct. Although 'thinking' might
be being too generous! ;-)

[I can't even claim that it was late ... midnight is actually
quite early for me!]

> (t/check-non-portable-shell: detect "FOO=bar shell_func", 2018-07-13),
> when you wrote this, though it is not related to "export FOO=bar"
> detection.
> 
> The patch itself looks fine, by the way.
> 
> [1]: https://public-inbox.org/git/20180713055205.32351-5-sunshine@sunshineco.com/
> 

Thanks!

ATB,
Ramsay Jones

