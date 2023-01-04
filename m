Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E21C4332F
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 16:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjADQgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbjADQgV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 11:36:21 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98BD1ADAB
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 08:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672850174; bh=TJcuhTe5wsAug4iboTysPT6Y0n+iNpruGZKjIrFdjx0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=nc+v0JeWPY66sQXUY84pI7VujnQahjjIHM9OSnm2lKL4ZI8LapZBA1kk3U94rxpGT
         Ji/IrluQmsENzgfXoCoNScxs8HlvqKmkHpZ3+CIsMaq2ujP5NMlvaFmwCnOOmp/Iz5
         kFsmDNZM2SQSutJO39CNm1K/Pwqzx+u1ts8Jb5BwoMspRIUa9I0Xao2O3urGvWkfp1
         VpBe6L/zMkMKzXh/AgAUBjbqbUnTYujD9lBSdMbjDKOhlcRrOPgYVQK+YX96oJQeuu
         t+GrzrWhiGSgxTHjb+QVStWl3lJHn3xnaamEcO7ISyhoFzvsGDWKaa0tAUAo+Yra7k
         GLZL3Rfcsl0eA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdfCN-1odUwp33Ef-00ZKPD; Wed, 04
 Jan 2023 17:36:14 +0100
Message-ID: <7ccf9109-1566-a2b9-5ca8-067ebf49706d@web.de>
Date:   Wed, 4 Jan 2023 17:36:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/5] environ: GIT_FLUSH should be made a usual Boolean
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq8rmkpsit.fsf@gitster.g>
 <20220915160659.126441-1-gitster@pobox.com>
 <20220915160659.126441-4-gitster@pobox.com>
 <c58476c9-f7d1-bea4-17eb-c5346790df2e@web.de> <xmqqwn62u7nh.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqwn62u7nh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B1tLuzvlCA/2ij8DYvICVRCAnIqO7eoy33OQCiAtfEv10ihZ6YO
 5I4guAR5sU51eYkHKKWZYN9ebKAUSOY08VidftUjRaVv+UYK/H9X0q0Gl8rktyHg60IWY1W
 OervjHg0SL7HLw1TbSgIziNk7wQ97NI84awDXysVr8Jtp6BnNeeh6DuJQ2nFk+Si5HohlbW
 zKZk84VBfMHFcd3j4Nsqg==
UI-OutboundReport: notjunk:1;M01:P0:SkSCXmlVHB0=;YdvBCvZnm+c2AJo0VeN8wKUdcr2
 DwUreb/F1CQEJhbfEISx3051JJDKmAJLaYXGxwdkjpp6bP15nmP2+v8XvBxQMBdaQ0BdVTf+s
 avaLKIoM+xSyX5+e+XaRftmSikLIvxHZtzZ22c72y1q4GBzjRbSL6tREvGHHAhu3VyPD+rgl+
 AqtL7/+5dd2oi4t0gnCegzgkpDZdni9uaKC3Yfxq89ebsV2Ry8ZmF+Ui7g8qoNpTlmZG4hYVo
 cX4hKT35RBqV8ULNMKWq47p3Tw+VgnJMfA40NklQfKF1YnLtJIkH0uBINM2GNCwo904/g1c+5
 cORv6Xa3qKT/o+By1Tsb4AWdUZtAoaqHcvtSE5muCf9tKeBebRyZIuxcxsJCpeGtjAf08mcBM
 3mf20p86gYmZcglIBbChmLg+5jQONtUyZ2U1PyvXMPjsRome+e0NbWu/PTbCe/r7cIgoTBLHm
 Kd8qioEQ7L4N7k0EWUIJ1MNYOqEWYqRbdJMQHcW7mJlDtMm1+w3Q6ZcJD2dgkhZDl3c9mxAQk
 5FomC85Dkg2TJ9MX99kBx8uGGvwYaDETa3eztMO0B+/7iBz9ls3VgZi00eAMoPHvQpRnDzHcz
 yNhFpFgRNXdrluiYH/DdzYh5hg0G1sw/Y+IssMMCgv4UBamYzzPgEs9H5FG4bQJlhLQHkrkDQ
 o/tJMxJ3wFEo3vE5GeRYZZ0WRvKZlIarsajtDA4ozPvrpu3Jo7IUyrn6Xc0NGlohqbsENwgGK
 kwvGOLME83KUeE8TsACLgsP4olFj+oBM/rR7rZCFuE7iNFGUMh+j0NqtVR4oTHYWoNad4sLzC
 asrazlVTGDG7UeD+gqzxeAT6A6yd8+0GvTqAHd5bXnCFvKVAAyrrjxv9NTHpzphl0kTH3i2if
 nHoxZkXf8AIg5xinO40lEx+01pyCIh1mdizhhAQroLITmlSkgrR6JTgxGv4jpegRWuWqBVZpH
 lecszU7WD2OKyxq2QLw6gG0TnTc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.01.23 um 07:37 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> GIT_FLUSH=3D10000000000  yes                     if stdin is not a file
>
> Is this because the int is so large that git_parse_signed() notices
> that it is out of bound (hence "bogus")?

Yes, atoi() overflows silently and git_parse_maybe_bool() returns -1.

Ren=C3=A9
