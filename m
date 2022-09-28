Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE0CC32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 17:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiI1Rjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiI1Rjj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 13:39:39 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313DCC07
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664386768; bh=leNv2uLTB2GELYxR+NbWTZq4b7ojVK3I23FtfqOb2fU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=felHOIUXDn2vseF942vdsjm/qln/rQj726hlBx8ptqU/N7MI73BnxfsxNLqhKc24j
         pLqha4xdiPt2FHEXFA0bfSNtyEawWOaPLGkcBKDD1FA/RZ8Pfyze0LGvuheOaEvFFA
         zu6IcVd9h0Xff5PAWD1TT19Ehp2ks7j8aWr7xlb+9vNkFkT2XwsaVbkYhOXSCzPjDE
         CLgtput4lzop+V0a2w0BQ6aTs874p7Wg03sTK+LDtEtN9c7FAKvpLSXo08X3Cu+ZQI
         uojKeFcWTNtplC7RAac1csYrtouykZjmA8k1GSJ+svqQRrA8QML5iJF9Jed+MdL8bV
         cIGKWMuASuq1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M43KW-1odb1s0qbw-000K0s; Wed, 28
 Sep 2022 19:39:28 +0200
Message-ID: <bbcb9a3f-c338-50ea-1d63-1a6939ecd735@web.de>
Date:   Wed, 28 Sep 2022 19:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: git diff ^! syntax stopped working for stashes in Git 2.28
To:     Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <6f729c8c43c4409faf6a11a69791f45a@garz-fricke.com>
 <9e0c1a2c-542b-156f-4c70-371d3a9b452d@web.de>
 <CAPx1Gve=BZ3J7KH0FA_BbAnYMEFXyDyiD=tX1vBiKCfHS0JfFg@mail.gmail.com>
 <70e87095-d8be-f859-f5b4-a5e15904149c@web.de>
 <15f30d59650b4de2b14d89f6e8cb21ce@garz-fricke.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <15f30d59650b4de2b14d89f6e8cb21ce@garz-fricke.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5++Z8qk8MJdhz8WqPFGQni7NV+09h4e5o1zsschWhGftKgxobeT
 1AmTN7H9Bq2Uut7ocwArAVM1C2RrmtDEVAv77nsha28oQJ67pbdnY6vUNiPS/OfC2nTQ9w9
 Z7zzGea42EM+r/3X7WNqR0KDDmGyb92FRFraA8Cv7HYzoo8/CDt9GRTCeub41JnJAyaJ6P5
 pPA6ceAK8T11DX0TInrvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WCMJSMO5xZk=:AmE7Y3WJNj9XzmpHhufPfQ
 Rtrm6s2MLufHM1UXCj3Tc09tOWtTF5LJHchFkf56wqP62wampCNo271ElkhbhZOigpm8r5mkJ
 WNQODbJ4cePwkZWP4pMCCIQLw+tCvZk2uW/bZfkO1stWLsf93i/SFWEHmGNbWJHmQP1Q3/0Fg
 JzB7GP16xv9Uci3dtCJLJIDTa+kzI3T6iY4+qqjrcJoJLmPOWcTyH7cEXCBUR3Nc/YMxsK9HS
 qjPwzNc3P8xprXy5Vp6FZIP7lqS832kGsgsUEUMaGxOxUrvHifkISl/beoSaJ+v6efZnoz1Mp
 dm++9wdVTOLXxkoIwOjRVzJxGByUwodDZp1A9cWZZXNf1XEc8ROYbqTipUGS80bRNPiGW05vN
 E5lU72ebMZZGDh/qgF9u6TYKRhVx7HZwURdjP6vyu4no0yH5HE7i0Dt/ZARiYE8p3K34ZDFfd
 zQwFWr2nveAhzNdCfPySDYP/ML2lbN6rZIu9gAKVQLVJyM5UxkHsn9C1mXNCzp890COEQGNim
 f4LadN5COlTvM56jAuhgwVneflc5uBn5qq4jS/KHK6BL/8z8Do3yF3uQI8SnH29CmU7bn+H1r
 Zcp3UPs4OzoaSD2Ct8v8Yxm1v7bTTdZ+7i1leM4YEZ5AaRvzXbeTJGlLXLYnPAYfVcSbZfhbW
 oAgy5xIlvT9xsfL1wZ42ezxNh8r36TOf74dxmHxYp0XjemXDDRq/2bqaiRo1eC/1sO0nNDw6y
 pwu/Tq2n5pNGd4C8o2mfiJr7yHwGo9Av7r3yZx25mSp0T0WeYRHYjp2MWhM+fgt2dGEW4FyzA
 3Qn8EVi8S5c6V6JJ95piqxLdhfiHkwgHGhuBt51bT4cHY4pldWK5VZQXpCYR+X/FlXmdqVR/t
 5lv9QS5xmkJXgUHyYNJjp/5KvT5Y9uJzT5ZCFt97JV13lXJjORa2l0CM9DUQolM1HPrgPLCxj
 xt9ssXMZXoXSquza1FC+dCvPdbEVvBiXLTsw8JZGJQKJjX1kjrKlArX02U+FGsrvh0ZTNYSLL
 hcxl98ZwlqNU+MgDlFmZpP+z7ZoWwrQ7dNm6gCvPhW7c6tKTa989Jg4+tSkTiDuPObF0vWKLK
 0sCcm1l8kbKdxI4Ih+5soybE9tRiTmfwDeAG4gBW4Tg6IJKoqRHidMLKggrIdW1z5gxr8QbIb
 oUAAA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.09.22 um 11:02 schrieb Tim Jaacks:
>
>> Letting `git diff X^!` mean the same as `git diff X ^X^` for a
>> non-merge makes sense to me given the definition from
>> gitrevisions(7) cited above. That in turn is the same as `git diff
>> X^..X` and `git diff X^ X`.
>
> Yes, that is exactly how it worked before. And all the other syntaxes
> still work correctly.

`git diff X^!` still works for a non-merge commit as well.  Only
merge commits were affected by the change made in v2.28.  And stashes
are stored as merge commits internally, causing them to be affected.

> Ren=C3=A9, I saw you submitted some patches already, but these weren't
> approved obviously. So how does this continue now?

It's RC time (release candidate) and only fixes for regressions added
after v2.37 are accepted currently.  I'll resend my patches once v2.38
is out, if necessary.

Ren=C3=A9
