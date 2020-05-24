Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B409C433E2
	for <git@archiver.kernel.org>; Sun, 24 May 2020 07:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBD320723
	for <git@archiver.kernel.org>; Sun, 24 May 2020 07:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Rdy/WfLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgEXHXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 03:23:39 -0400
Received: from mout.web.de ([212.227.15.3]:36499 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbgEXHXj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 03:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590305013;
        bh=zfM0w4Cn7bQMYQ0ceH0tW6Y2i7cCQEsHXK1kVEB3jeY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Rdy/WfLpvq+dcdWoi8nTejLVXwhgIBxxu7E2qYzpLfSLhww8gIOh1LHLRBAwIk3IP
         dEsVwK9LNWK8SQT0y5+kEfCVsb4PEwpNN/l4x0eA8qZRgenPVbo9E3pJHCE8xMy60A
         l9gVZR+qA8n6o+UhZ10VMLxPc1tPrZSOBqycSi38=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.155.84]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXBh7-1jZmwS09sz-00WJEG; Sun, 24
 May 2020 09:23:33 +0200
Subject: Re: 'HEAD' is not a commit (according to git-checkout)
To:     Jeff King <peff@peff.net>
Cc:     Dana Dahlstrom <dahlstrom@google.com>, git@vger.kernel.org
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
 <20200521191626.GC1308489@coredump.intra.peff.net>
 <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
 <20200523162914.GA2178752@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ad267e83-eea0-bb78-d88c-a37a28d04dbe@web.de>
Date:   Sun, 24 May 2020 09:23:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200523162914.GA2178752@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2MhJyWcvrfd7o7NYwQ/6JJIGWAqY0A9K2+PTcMW1MFd76fSgL8n
 hNiW1fxcq7YHV+rxhl16tgxMcfZ7QjQY2EQjHljRrEVLtuz24d/e+UeJvOOb8tWGkFFLhgi
 +y52v3q85NT02b8nS1zoxWTckDstwnpGY/sdwr8yTT4crGeXLdWAqjcgXIMlZqjBg2cMIOj
 g6rWbQHZENDTjZPBI2+MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zeai9s/seUE=:Wv0DiiIn1qUHjMkElmp/fR
 MQ2UZ1jwt543ZadV4HCulNbY2lkkHq7mdXzBXWuHnQmmyr1mvB0+ZFMb93Q0XmqD5VyOBOfFu
 kXPvRM9/i65cOSw25tv6J/3FLmD43JZ7gWSacc3g5LCdZNl038mSxCpFI0d1bLai9vV0wk1cJ
 SGpUjeyY5hbaoCHFoZst7Pw1Xu6HBcJ24RJBU5MfReg1TvS8Mg7CfLDoZE9l+iTpFKfaf+xHi
 73SL0rTjIfPYtuiN/Iby6HaHND6OZcc2LjPre23wZwr5rvHP5xQUB6n6e8KCVB4ZNxEX2MTBe
 1FuXvUFjZ6mAqCIkhTSUaIHLvMabc3BLPQgQM68nxijKupWX+7i4ehgyqpzazEv4wKGOJ4Iat
 v35ZyIzWdXFJWl1Tu7ILteqtCozei0ApfIJNeTh2TFe4xPOFdHx9yFxe0Di0pj7qKYj931IVj
 3QxyToojInln1S1Pzk4ByIhbsKJRnen9v7f+n2Rc0UPPKHo8Gax1SqmwzhWc4KoffHkaOwTx2
 6Tyk0Vl1JCMFKl7R/CqkLaSoSqHIMfsG6T1PwefSLT1Of03rxDqGCZkTaifLkf01Ney+mpAMY
 chw06iIlQjyO1RJKVdN5nkTCJkxc3fa24/v7IOUt4Ix8OUncEtb21mi1y7dOEc661oKPSKIPb
 K6JXk6q6PKxHe6mTxO1CGHgU+FFEt1JpFyGbUl8MKCFT4Sv4HrtlwEK8ehAXACXOvx8ahJgY4
 A6CiQagdNPn4G3SjonBMSYIwjxeA+ioPB51XyIiMgIaDRGAv8Q09Qp4TU+RBGsYD2dXJDWFtK
 vFnSwIZG2EV8aeQ/ZYccZYj5Py6aseRQ9phrGihGJ+8DkuXLJP84Wp89qHAi3dNrWcteZFRiP
 Kt/CskNtTwcb+Fc+6ogTtScWlXELhcbhEW4fKpnh8lVR34b0KBOUn51TNztsVsTA5zf7kj9Eh
 80Bx9MCXYx2avdIE9iF5WSgg57YQeTJuzhVVAamnRxag05jCkIKcYBsHAERHX//Qtx7gc/wb7
 4pdQkdzdLjLVA1i/WY+MjZWTpinEvx8/tJY9DqI2YfZ8AXh2mgkG02niLNJIlVq26NDhklGi4
 4Ay0JJa7rTijY+2aebMEm1khZgsZ8AEPoFbfmIrEmO6ZhULE5hsiMh9gewRL6Ox96pzM8JRIP
 FK9Ql+Hl8AQk8uGE6WKzQfwWvF31CKBXpU6+pd4VuHbLUzgQO77nS2A+0yAWv5dit0fMM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.05.20 um 18:29 schrieb Jeff King:
> On Sat, May 23, 2020 at 09:07:50AM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> which are both correct. I wonder if there's a more elegant way to do i=
t,
>>> though (probably not, as there's definitely some heuristic parsing goi=
ng
>>> on to determine which checkout mode we're in; the new switch/restore
>>> alternatives don't suffer as much from this).
>>
>> Perhaps:
>>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index e9d111bb83..24336e1017 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -1689,7 +1689,7 @@ static int checkout_main(int argc, const char **a=
rgv, const char *prefix,
>>  		 * Try to give more helpful suggestion.
>>  		 * new_branch && argc > 1 will be caught later.
>>  		 */
>> -		if (opts->new_branch && argc =3D=3D 1)
>> +		if (opts->new_branch && argc =3D=3D 1 && !new_branch_info.commit)
>>  			die(_("'%s' is not a commit and a branch '%s' cannot be created fro=
m it"),
>>  				argv[0], opts->new_branch);
>>
>
> Oh, indeed, that's way better. Want to wrap it up as a patch?

OK, but stepping back a bit and trying to forget what I know about the
option --track and pretending to see it for the first time, I have to
ask: Why doesn't it take an argument?  If I check out a raw commit, it
cannot guess the upstream branch anyway.  So I'd assume this to work:

   git checkout -b new-branch --track=3Dupstream start-point

Ren=C3=A9
