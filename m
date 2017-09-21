Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CACCF2047F
	for <e@80x24.org>; Thu, 21 Sep 2017 09:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdIUJj0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 05:39:26 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:61238 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdIUJjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 05:39:25 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MU9x3-1dlzmq0sy1-00QoAO; Thu, 21 Sep 2017 11:39:13 +0200
Subject: Re: [PATCH 2/3] merge-base: return fork-point outside reflog
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
 <cover.1505394278.git.git@grubix.eu>
 <5513a1415d11517c28158d9b4212d383a233182f.1505394278.git.git@grubix.eu>
 <xmqq60ckzng7.fsf@gitster.mtv.corp.google.com>
 <cd97bb1b-13f3-0856-a250-8f4921b9f6d8@grubix.eu>
 <xmqqshfnx1kl.fsf@gitster.mtv.corp.google.com>
 <xmqqshfgk1mr.fsf@gitster.mtv.corp.google.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <5a2fca1d-4edf-965f-4840-58c924c91051@grubix.eu>
Date:   Thu, 21 Sep 2017 11:39:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqshfgk1mr.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:BcHU4OJAiMY3B02DYu8UVzxNg1j3MfgIPdZpdX1KXjWWuiJtkxQ
 7kdGNgb61CBq7UnRQhurE9N9dkafZyRcUlmMpeyuB6XOXP+qMAyYzxNyBfYEf/BTmu50mb2
 qT0wIB7rsapjWXz/LSs0b51Hxi/kRv05mb2xDTmwZSydJbdlkqCoYZ7AKL5havw5NY6kSSQ
 N2P2Ctcx18bZ5wiKXI81g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TUaKWqYcVpg=:7kufFcXI3nZgQ+DgTLRtBT
 Jpy7eHis2YX2hGXfvb7njxa2xrQEyUZALqDmsGw5QgBzr4K6t7kNnegSDpUtAlLhpZNX/J9KT
 eZlz/eGY1KG3LrQ6moyjsbFo+JwXEgs/v+dhmV96weADLYKIYYzcc+PJShvJ4XC1aEoz0lHgj
 S3ih98xNoc5JpKZUJEXCrYZJsXbEQlPV/NeEa0YzJpT9QycbWCgcwRSdtjTjo6bEPAq+O+fTS
 WTi7/y56s7blZEYj+CEjI1N88ogJVG+CGjVwD8ZFxUTjE66rHauDtH0z4nPcUm19eS2OpO96N
 TnAHdtUzFL4orFRzE3eOZb6ZVx5nNN+4XGHQen7LhkkHu9++fY1VUieWNxqdM7tVMEYjxVjlP
 SOwibBmntxmsScG4iPQ47mYyDh+IFvGPgvbevPo44B5yh94jBhqeuIursWiQgTfzVzJ2yV6+f
 zA905Po1j1uA/Id8wcfCmgnVGNuRDHNQ9jCIxXZsth+2Jyz/IVci2JBdatZEU4qUbF/mIK/KF
 DjvAXLK/1qmxMbNogFbWY+Yh87ADki70O4mG2M0vP53/UgDMYlZ09Rr8TDbRof77wbAt2vWj2
 pRq7Xcb+egcdPGrzj9MUjcQQKKuYIYRcDeIwjWTocOW2TLr2GX8C45p7J6E27OVUlYwzL3LuT
 tdHcUm9jG0/CjVwcILYgb8W0Vtg6zHldqjRcX8bgWzi3AcwboGM7NWT4qHILPlfzRnOw5mS45
 6EZIhXBOUQ6g1S1y+1ie0LqA8NRCxH291FX57gjlTh6tlWAQm0SRfaL0OiE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 21.09.2017 08:27:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> ...  I agree that there is a value in what your patch 2/3
>> wants to do when the current one that is more strict would say
>> "there is no known fork-point"---we would gain a way to say "... but
>> this is the best guess based on available data that may be better
>> than getting no answer." which we lack.
>>
>> Having said all that, I do not agree with your last sentence in the
>> paragraph I quoted above.  It is a mere implementation detail to
>> consult the reflog to find out the set of "historical tips of the
>> Branch"; the current tip by definition is among the commits in that
>> set, even when the reflog of Branch is missing.  What 4f21454b55 did
>> was a reasonable "fix" that is still in line with the definition of
>> "--fork-point" from that point of view.
>>
>> Whether we add a "looser" version of "--fork-point" to the system or
>> not, the more strict version should still use the current tip as one
>> of the historical tips (i.e. those that we would take from the
>> reflog if the reflog were not empty) in the more "strict" mode.  The
>> looser version may also want to do so as well.
> 
> So, should I mark this in What's cooking report as "expecting a
> reroll", anticipating that a new option would be added to trigger
> the new & looser behaviour?
> 

I dunno. Some participants in this thread considered my patch to be a
fix rather than alternative behaviour. So I hoped for more responses to
your response. (Re-adding dscho on cc - our thread graph forked...)

Also, I'm undecided about about your reflog argument above - if we leave
"--fork-point" to be the current behaviour including Jeff's fix then the
documentation would need an even bigger overhaul, because it's neither
"reflog also" (as claimed in the doc) nor "reflog only" (as in the
original implementation) but "historical tips as inferred from the
current value and the reflog".

In any case, for two modes we need two names for the options. Maybe
--fork-point and --fork-base because in the loose mode, you may get a
"base of a strict fork point"?

Michael
