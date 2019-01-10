Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798ED1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 12:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfAJM0C (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 07:26:02 -0500
Received: from mout.web.de ([212.227.17.11]:35515 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfAJM0C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 07:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1547123142;
        bh=caSdWVL1Q59V+1cAfRZVdCQW1KNlBM0gvkey9ZH8UbA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hpy52wO/UPKr0eue4bezB/gxEazU7aSr9XeUzL15tD638iKkkqcms5z6QMMbudlRg
         NmhxAZnEpyIzoDM39rgR1kHhrwmwzlNMUGYnFwx1A3RyGUz0QoQTwr/pdzlmouKKs6
         LZDkZBLSCctQvjVCERW2XHBlKcVBYgJCoEvJUMF8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.88.140] ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgpNC-1h20jA0knW-00oBbW; Thu, 10
 Jan 2019 13:25:42 +0100
Subject: Re: [PATCH v3 1/3] t5323: test cases for git-pack-redundant
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Sun Chao <sunchao9@huawei.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
References: <20181219121451.21697-1-worldhello.net@gmail.com>
 <20190102043456.15652-2-worldhello.net@gmail.com>
 <20190109125628.GG4673@szeder.dev>
 <CANYiYbGqLHr-t+f6m6gyY3QiYgxbzbqsmmRw-afKe6NG_mxhPQ@mail.gmail.com>
 <20190110115704.GL4673@szeder.dev>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <700045da-2d91-a3c7-aaf2-c9d7bdd86a51@web.de>
Date:   Thu, 10 Jan 2019 13:25:35 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190110115704.GL4673@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4GPkK6mBk3H/zN3wH4qsZu3iC+uv7Yam2Rc/CU85WCqi/1mysdp
 MCK0H3KHY7Zq53gAYFhpRVEaCkwtKGtaHJHjLNOZFFOvfmQcG2JVmPzt3gReOHj6PcyuTo0
 on4ahjXJNUnoOq7tNOzdImDhQ2U8RRM0UVRealHmckUhNjiTWh3WphH/UM/KcQ1BzBzG/nQ
 uK8Utqo6MWRtlBVAM5otQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ho7waJ2UBZE=:PC3VZZ99rkY5eilEfGZ1pu
 rXu0fhRg1WoMuGW8Y67WWuZnxR0w+rBT2SNosB39Dcu+/k9FXaBfUpOwdE1fMhttWa9sBugpa
 mC+kb4Mxn5sOvEeXi95gsPGI17OvPe99K0jLqObgeekzUvfZSLL0V1Zb1vuCVDEdQWhKj2y5W
 8JqlKiwENRLM887JgY2epS/pnGxgWjUL1csxDO5kI6SJv74x8dnvkX+UsOCLPiDuhNXeSEXMf
 +N8qwn3BToqhyx4jYwQWoO6nNY6tK59AsZEaput0kOEZ1G41PTTE7Rj5ncwoBW3CCatihSihH
 nMyNWQwGuhz3f6L/3RegYS+TWGBFMCiw4vCiRq+CYRNRnqgGdFu12faFI16fcEIqKapPRuQCE
 kaM/C6IgWO4DmODBroZj5anMMK1jhT8afMQrpUiTOB+ugNAfiHHMQXA4LeFMS4pznQtWxtCnS
 0K20TvR/lR1LKbRDueZf6ch3IzDbY8kTDBDGWMdB+wGSIwrQf03+X5F0ONaxBxeReRW38nWMk
 MpYofYPCO8p38jz3Q/mCwjzE7jP4J3oGrXYyQLDSkMRQUTEsJs0Kubrrb6rM2Ay220lErO4iE
 GxLgHMYjUvL/NhCMpnEu4fZhDhoSRfgY72eiP0ZYPmcx/UkEYGUaeYGjBWaiPzw/jPx2LBCfK
 DUbFA2WmYQjutrX4YdhQ71KCd3fqct2ybjP2kj3l12GoCcRMHQhY0ulroO4yaTglySClu7zDe
 +vkcY8jEYd3LrNWZfrRRecLFSq+LlU29fgnuIin9fZlygIUF1bMHLz78XHLt7e4hA3m7u5H1N
 /sMUiDy3shLWwJEXXcgDt7zBaKQcK6XA+rgE4no1M1EiBzze9H31jL4hZuDqffNBntLu0si+0
 84EiOLLyGjankye3lyDvhrKWjNEH8liO7ur9YZlQgZ094clqLjJRrZavPjFteUj9EH1sQqRmc
 PPjl/4Yg729SlltpJgvmbJ6oQ05KH5FM0MXIBUS7H5T93XiIwgWUa474hdtrx00wa70yoI3nV
 4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.01.19 12:57, SZEDER Gábor wrote:
> On Thu, Jan 10, 2019 at 11:28:34AM +0800, Jiang Xin wrote:
>> SZEDER Gábor <szeder.dev@gmail.com> 于2019年1月9日周三 下午8:56写道：
>>>> +             sed -e "s#^.*/pack-\(.*\)\.\(idx\|pack\)#\1#g" | \
>>>
>>> This sed command doesn't seem to work on macOS (on Travis CI), and
>>> causes the test to fail with:
>>>
>>
>> It works if rewrite as follows:
>>
>>     git pack-redundant --all >out &&
>>     sed -E -e "s#.*/pack-(.*)\.(idx|pack)#\1#" out | \
>>
>> Without `-E`, MasOS has to write two seperate sed commands, such as:
>>
>>     git pack-redundant --all >out &&
>>     sed -e "s#.*/pack-\(.*\)\.idx#\1#" out | \
>>     sed -e "s#.*/pack-\(.*\)\.pack#\1#"
>>
>> Option '-E' is an alias for -r in GNU sed 4.2  (added in 4.2, not documented
>> unti 4.3), released on May 11 2009.  I prefer the `-E` version.
> 
> Is 'sed -E' portable enough, e.g. to the various BSDs, Solaris, and
> whatnot?  I don't know, but POSIX doesn't mention it, there is not a
> single instance of it in our current codebase, and it appears that
> we've never used it before, either.  OTOH,

If we can use "two seperate sed commands" i would (really) prefer to so,
to avoid "sed -E".
My conclusion is that it is not portable enough.
> 't/check-non-portable-shell.pl' doesn't catch it as non-portable
> construct...

Good point.
Actually that script only checks "known non-portable" options.
Every time somebody finds a non-portable option, we update it.
A growing blacklist, so to say.
May be we should have a white list instead.



