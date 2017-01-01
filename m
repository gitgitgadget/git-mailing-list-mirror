Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C2320968
	for <e@80x24.org>; Sun,  1 Jan 2017 10:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754636AbdAAKUK (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 05:20:10 -0500
Received: from mout.web.de ([212.227.17.12]:60672 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752517AbdAAKUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 05:20:09 -0500
Received: from birne.lan ([195.252.60.88]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsyZi-1cUcDO48za-012byK; Sun, 01
 Jan 2017 11:19:57 +0100
Subject: Re: Test failures when Git is built with libpcre and grep is built
 without it
To:     "A. Wilcox" <awilfox@adelielinux.org>, git@vger.kernel.org
References: <58688C9F.4000605@adelielinux.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <38525b2e-2a5f-941f-2eca-912632f9a2ec@web.de>
Date:   Sun, 1 Jan 2017 11:19:51 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <58688C9F.4000605@adelielinux.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:64Qon0fqlpPCVxoImK1sl+nGWNKqrdEewBUyUjs+SAFXpgj9ZUV
 vmgE2gNxkFw5qG6YKUxlQzmwJuCwIHuQEe1N5zOguK6xvHbdDg6KIDS5F8AzilDXeAyS0ja
 YT0ICEmlXnFWFqr6XsUzDeDkBrnJS4IGXtWMN/5rxbw4xSeKLezrVueKkDz9dMnu1XOAlhw
 L+fdGxZOaJWBnS+ln20sQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QMJQnRMyIg4=:6PU7Q1cU8ujM3j+HWkZAmX
 bgfQeQACZOPi7g7A1JwWGJqMQEuNR1oYJF+/0CziOyAt0t82MRAj78NSNbvT6eK1hNXoNEE7H
 CM07mVCZ+8/EAgnCezpKzLWGXFKnCk1vzM3enOl1U74UwrVzf/wVdH5Yx+r4aJT5WlWew6Rpx
 QCMgKDB+GFmEh7rH6MwrmXwUNzHgm+JMMkLLmfPSNL1kkgrfmGTaiu7u5YVVaKoQrkAC54Cy0
 FsBYZPAIdY534Tfa4PxjSu2q4JF0aup9E9/WkZUjefWWkfp0FMVuxLg5YL6rUr7FmHV0Byy2r
 WgM0ShraVd7SGIJ4LUkd7OSYTXRSxvDUrzJFisJUC74C5C47NASzVY9aPdMfJB/BKNBfIhrhs
 ZS/BhimaF/qOq/DgGpcUq0MgVqI3mrSIh0lB/AIpZxEXzLy/D4LjAmQAuilCW6lADPsYI7PQp
 DBRFAZW2CtjaS+RyvtqFWAZwwjgBZcbNXkF+/wJ27fOHooWPiiQBm54SZH/xWtGVX8Gz2nGCx
 wjIDc9gKlK+O6ns7nAO2YIHrbsfydMqQKwVQkrMuqYXPj6dC2ClHXGNLW4JfcyNfW3sgLcM/+
 6Xi+RN9xBKgPGIvcIlKoDHVxeoiPc2whRt6SzvSxfe6WMYoLslvg2agU7d4VHJq8jYI5qvxXU
 uL8X8JVvXlStpf9ygsGEsBm/mS1+Bh7+ANoG5fDepHRm8vkCPLss/ugyZdQQcvFom5MxwKOEb
 i/iAmqElIa8iO79Ntqs/mN7W+Cxuj+VKOztJ32RQfNlhq2iUDLI8FJN0HkD6yVO7mt7ANtOQI
 j63NBJV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.01.17 05:59, A. Wilcox wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> Hello!
> 
> I'm attempting to package Git for our new Linux distribution and I
> have run in to a failure on our PowerPC builder while running the test
> suite.
> 
> The PowerPC builder runs a tiny version of grep(1) that was not built
> with PCRE.  As such, grep -P returns 2 and prints:
> 
> grep: support for the -P option is not compiled into this
> - --disable-perl-regexp binary
> 
> However, our Git build *does* link against libpcre.  This causes a
> tests numbered 142 and 143 to fail in t7810-grep.sh.
> 
> I am not sure the best way to handle this but I felt it would be
> prudent to inform you of this issue.  I will be happy to provide any
> other information you may require.

The first thing you can do is to run the test with debug and verbose:

debug=t verbose=t ./t7810-grep.sh  
and post the output of these 2 test cases here:
(mine looks like this)

expecting success: 
	echo "ab:a+bc" >expected &&
	git \
		-c grep.patterntype=extended \
		-c grep.patterntype=fixed \
		-c grep.patterntype=basic \
		grep "a+b*c" ab >actual &&
	test_cmp expected actual

ok 142 - grep pattern with grep.patternType=extended, =fixed, =basic

expecting success: 
	echo "ab:abc" >expected &&
	git grep -F -G -E "a+b*c" ab >actual &&
	test_cmp expected actual

ok 143 - grep -F -G -E pattern

