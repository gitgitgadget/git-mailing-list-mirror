Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34851F790
	for <e@80x24.org>; Mon,  1 May 2017 08:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1952054AbdEAIa1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 04:30:27 -0400
Received: from mout.web.de ([212.227.17.11]:56216 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425877AbdEAIa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 04:30:26 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MeBDG-1dRa5J1vZ8-00PysW; Mon, 01
 May 2017 10:30:07 +0200
Subject: Re: [PATCH v3 0/5] archive-zip: support files and archives bigger
 than 4GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <3df2b03f-ab86-09ac-0fc8-3c6eb10c6704@web.de>
 <edf33657-f74b-3cd5-44a7-8e16231bd978@web.de>
 <e30554f3-1aa3-acea-500b-6392fce902be@web.de>
 <d8a1edfc-e4d6-2bd2-7b07-a1a10d89490a@web.de>
 <9f6cb421-db61-51ca-6a4b-ea7c94bd513e@kdbg.org>
 <d1cea1c3-f974-c839-dbdd-5bc95756be84@web.de>
 <xmqqfugplamn.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <85744f48-c408-4fc7-bdf1-1e3961703dd0@web.de>
Date:   Mon, 1 May 2017 10:30:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <xmqqfugplamn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:B8pnGeWR0vX4AToMAOzg1c+1oT0Kr8UQEvDOC1BlPsV7eAA9u5c
 HzeGQRYgbe6Ze7AR3FyU1GMfXyKPmF6ICr4TeshE/khlWKxKtG4Gyc9D+WXoWNglUfy4MKo
 4QvjvPA2d25aGuwftGItb/gFxBbgeunisjvkgM1lRRMS9PuQz2hWncKE4Mb+Nlm82EOOmye
 LTFsdC4MDR5DedvQxieyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0j4tWRL8rRs=:+iXvOAjFMfda1sZO6jiaOY
 9aw6M/IoVeyIF7iqEbf9O6MSmEwfQ1sFcjYTeeTDNOvU5FaBppW8KNKy5lw9dZmGLsFLbv8xh
 y32RxY7gbilzzN8C6iP92+lbMwrkWEI1M/zbbu4N8Ho3apO9DBbGhdpiU1u/SP82/NpFVB2WR
 ydffkclS2mEM+aUcEckSZhKryaA37PXfkBogDjqbaHZBW+76G/R+xBzsjCHflvqZaoPvVd7aJ
 4Ecl8b9Z1ICGqViU7xC3dZ2odcLSmOdxIaQcY8Hr1/5cAGxrQnHrVz/i/ie2O/Ws8mXCTImp0
 jny3c+yGMO+0CV06PVEgQ2tvqFEV/8ulgVZrMDaCXJh1g/jRjPfGAwIkTt26dRrpBcIGiAfMf
 APMJQXzA3mNPz0xXhJ+vv8IP4eEF/BIaMBZprt+ICis/sDibmY69MqoquJyHBUEE5+auI4qE+
 B73SGdH7mG/J5SVHEuk2dx0p91rfPhuvx6ja0+/Ui6uEWk0voDHzbcMILpYtJ8sfWanFs5cjI
 sXd8Utt4y0mk9Y0ZswxEXcj+9iIUBw1mhP51O8bFTCSnjHThZn5tIcX1CKGk3myNq5hiNhmmG
 xujlMxJ+QM8mNRL5BaQ9WtPuLv7uIvRFwobAFWNvRw+hSzAps8UgXfaQ2VUD6sx+l/+MYeN92
 bwOssGnxCWa4GGDUUDuLvs21Nv/Yos6lrWjzSVwoxUi/K5vKzivZj1WvHa/FzYVr9z647B822
 tQHePiTai3DHw6/LUNkUvZZeix/B2cCjyVhoAGTjyxOLas22iTD5Q2W7DKPhThq9DZrgRX1Ed
 F+UGqkW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.05.2017 um 01:49 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Am 30.04.2017 um 18:32 schrieb Johannes Sixt:
>>> Am 30.04.2017 um 09:53 schrieb René Scharfe:
>>>> @@ -178,7 +182,8 @@ test_expect_success EXPENSIVE,UNZIP 'zip
>>>> archive bigger than 4GB' '
>>>>       "$GIT_UNZIP" -t many-big.zip
>>>>   '
>>>>
>>>> -test_expect_success EXPENSIVE,UNZIP,ZIPINFO 'zip archive with
>>>> files bigger than 4GB' '
>>>> +test_expect_success
>>>> EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
>>>
>>> Why is LONG_IS_64BIT required?
>>
>> Blob sizes are kept in variables of type unsigned long.  64 bits are
>> required to store file sizes bigger than 4GB, and this test is about
>> such a file.  A 32-bit git can't use the pack we supply the test file
>> in, so we have to skip this test.
>>
>>>> +    'zip archive with files bigger than 4GB' '
>>>>       # Pack created with:
>>>>       #   dd if=/dev/zero of=file bs=1M count=4100 && git
>>>> hash-object -w file
>>>>       mkdir -p .git/objects/pack &&
> 
> OK, so let's queue this on top and have it in 'next' to unblock
> users of older unzip and unzip compiled wihtout zip64 support?

Yes, please; it allows them to run t5004 with --long-tests or 
GIT_TEST_LONG set (but not to actually test zip64 functionality).

René
