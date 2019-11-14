Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5E51F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 17:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKNRqU (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 12:46:20 -0500
Received: from mout.web.de ([212.227.17.12]:54625 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfKNRqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 12:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573753573;
        bh=XbiKO/NJdY+28kf52AWoTay/cQ0LnH92fbeyKx0noCc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UoqzDIctawUQh93Sc+dfqSjaxvsuck7gvvgfRLsmNUL41RkcJmZhOiUZl/HJRl4fU
         h72h4L2BvQ4+kyrb6mQe4gNE7UI6UW0/sLtOW1kBJg+yItq9QmeImIzj4N+8vSSs3O
         BtSEIctUAn9Jchj7rTtEdmAoR7lBj87d+2qp4KK0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lhvpu-1i9jkc3cg6-00nDcD; Thu, 14
 Nov 2019 18:46:12 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     Markus Elfring <Markus.Elfring@web.de>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
 <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
 <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
 <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
 <53346d52-e096-c651-f70a-ce6ca4d82ff9@web.de>
 <6c4ef61f-5fef-ffc8-82d6-ee42006756b4@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de>
Date:   Thu, 14 Nov 2019 18:46:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6c4ef61f-5fef-ffc8-82d6-ee42006756b4@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LxhasRPG2Fg3SSfmYHPrtDvuZc/FUKXImpVw3++vPaqMNLg5iTK
 QWoPISMUy5I7oJ7K8dC8J3t2UDH4P4n/M9XLjRZ1jBEdeuuWZ8TrphP4Rviv9jIWXBGEip4
 CQVc1VW+OXfXcXX51LwbgT+CHeGvKxRbg99KsIItfZ3hWaVbbZ2G1GSFWloCbuqikJQUfjo
 4n683l0xl+8JTytlCEkYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EqQ7KRwvwNg=:3MmPkKrPuY4C0GTdZuCNw7
 6TvfB3/uWIMD+egn3cbtSJBzAB05a+vWw/S3GACnZRVzDCzDge803bdqUnBU7k/nWZL+dLpcZ
 wXCwtPABATLGps8zVwshl2G0lV/0xBm07xbWHbkD4FNfXYihSDHfmpjh8+e74Y2QByZyXz95B
 i6NBml77Rc5F3FIz1CWT63xj4w7dVPw08DQjbYyIizVUCmeMi0rdX1y9EArX+bro86uRcstiZ
 I3Al1asdqbHmR2hWgqNgsrrn0MNA5WRmdRMrqaHrcW0rag3+82QKBvikWes2PX7WYCQk24jqh
 Oo3yisKqUroZf15ZU3Vg6Le0ywGAnyLL0GHOMGniH76vCTgU4iwfIX4OO6oIdmJ+ZbS7pweMr
 mm+iSaxbYNNB6jOT9K525Anxpp4BGFoeKIEams5OhD+EawD0+0qYi/03FpFUVNWhzBsk03OK/
 R9P6hWNHSZByygPVEbpEcA3P5n2UAZwulAcetypawzLMfQz9dDwurwvm10E+B9MZqdP8h7BTA
 VAmDAayBYq7dvYkmTqH90FVqGIOWNlmHJplorfOGXsdgTbBzH2VmjI4zOrKBpM4CNhR+dKCEF
 Zm0apBy12TSpJB+9rLeFMtBx3bBFd+vedOVLyAlC3aexdq9ISq6jXt2QMB8ZyQuqwNbaPIELb
 XK/QHtgm+Vu7uu9jrIOIXPZ6DHYOU0b3O46aLZZ9EpZ66s6MUF8l0ygvMcYSsf9lMjxUBAYbv
 zpUTTYyBWP3ThOgEB7cZvV0Px3hBKIzSyEwmRPyl/ecWKr134gjjyFQF8rVhYYPAcOOzw5QWr
 ailolf8MScYpYOT5lCVc+JvDsUe/amVzZ89lw7LGvaA2NyNgEidTxUTqCYwtovqSub4UzfEhk
 fggYU2EhJfdSjU/e0t5ORoK6FVJnDG2iezsjZF1m8TspsJoJIrl4ZD+cGbWpJxNcayNeWIT+F
 EFa7xq0qW40NEwnMTM84eDnf0q4o9J95VlHDB4tfCcrVASUvvxXT+IJn5xNJ2NVfHznmFKM5k
 BoAO9MJrdim3StLOe1fJqu8F5qKlPtcs1iSnlQLvOVs4iWaI794yS3boHeMdalDUmihwlbjB6
 t36JVeNavWmZKXUL1XhWMn7wlsnP9VERCqdyaa4pdPs45GpzrRAwSNFYgnHJCVVAJk8hOTMwM
 GxVN52Ws6a5lwIkTNNCuO7NYqgcKx0nL7OOULMaMGsla0DOFBCHVqOp9XI2/zODJZFOIE9DHt
 IP9b7XQzMZiLHym0EN8mMKJ4AC6GqAwM7zYTZgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.11.19 um 18:14 schrieb Markus Elfring:
>> If the new version of array.cocci is equivalent to the current one then
>> that last step should show no difference.
>
> I hoped it.
>
>
>>  contrib/coccinelle/array.cocci | 30 ++++++++++++++----------------
>>  fast-import.c                  |  2 +-
>>  packfile.c                     |  4 ++--
>>  pretty.c                       |  4 ++--
>>  4 files changed, 19 insertions(+), 21 deletions(-)
>>
>> The changes in array.cocci are expected of course, but the others
>> indicate that the new version missed transformations that the current
>> version generated.
>
> Would we like to submit a bug report for the Coccinelle software?

Not really, because...

> Which version did you try out for the comparison of generated patches?

... I use the last version of the Debian testing package, 1.0.4.deb-4.
https://tracker.debian.org/pkg/coccinelle says it was removed from
testing recently.  I was actually waiting for a more recent version
like 1.0.8 to be packaged; not sure what's going on there.

Anyway, someone who can reproduce the issue using the latest release
of Coccinelle would be in a better position to file a bug report.

Ren=C3=A9
