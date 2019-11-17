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
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5FF1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 18:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfKQSgb (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 13:36:31 -0500
Received: from mout.web.de ([212.227.17.11]:32979 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKQSgb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 13:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574015789;
        bh=TTPMyL9TD3LE37mDm9jFEie1gtWEoCi/yX1O6rHqcZE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Im1AfveLqE1Tlh04WCwpgRjK4HJ6ZTSgwJSThJenhqTeSgfqHW9024IfGX/kxHeal
         9JT/laMrdVtHGSFgfCepXeNk6lDdLfxBNrwFX1FjFYc6IqDEIyMUvowfOBbDp5Du6G
         hCd6XUb4RJyBf1BCRhrstw6cAm3Ewphmpb+Dn0NM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.59.42]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgfJz-1iBq1a1rhX-00O3SK; Sun, 17
 Nov 2019 19:36:29 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
 <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ac67f805-fbff-68e9-214e-3f353a1c038f@web.de>
Date:   Sun, 17 Nov 2019 19:36:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CsVAZOPwlnBhp51xFb8MXuJGnkd8om9+XriDX/kBENasB/L+oUf
 KZOI5vzfPUOx1N9S+Sv7gxd8jvJAtLg+4sWCWO+NUz/j3YA+NzxeWRvTH2AZco8VTeUcMo4
 2PhsO8JRl2zve/bcHkVV5vpQNTvoZyeq1ueBYtOmeM9Cy5miTjXtexx8m854esgil4UjgwF
 2fLOfhk2IeVuwA9DuYixA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fBeO1nUZSOM=:d0XWJglsKDL5KFK5lbC7P6
 GJ1cDEawxYKJ1zYlYmBFV32mfEblXPV55DrswyW3r/JjIeNizytZ0fN9u0tlpPGXg5H/o/gus
 NLPXHOF1i5v4MQFHqVILtn/hYacfqC5ZmYwWwfT6NSbJfoTfuFt7iP5+UpCeZ3APw1316U7bz
 ROh177VDEouRYejfMXFc3zFahqdPT1ghBzAhhbRkox4BJBKBw+O2fph+eme9sKOBNolJ7bNuQ
 JHLj0CV4V2bmY+IcGrZaEL1B48MhhlSGyfVbmMaHFBKLRuFuSbsZjFYgiO180dCmy5eBB01BS
 Yc7n5KRuVJKKaqlKELp56qeOkSskSIOUU5eBBObKSL3BMm6j8z9M3uzeqmLehV71LoQI8qbdn
 WW37uREKymTdSCyplte5ievnDZ+77h4uB7Urc8gW2v03fWgFcM8fwh3HEqN8Gqlrh5CGPU6VE
 XoVUqaPMWAGM/zfxnnQf11iwqENLeYmg4IfRcPutaWd0qBS856kHtY1SPijVznq+8/xzS9WM6
 T3g2f2EU+QJ9N2vuEA2VAsGg8puQRp5LiZDrYqhQw4+ebmqKhMIes/MEvsE1FuoU6XJp/VR+I
 uJDAcrrLDKO0qFHuRlb8RIIjq4Ya0FZna6l2CL2nKoxklFknrbf06Z809nSkfur4foYKzQyE6
 mlB11h9tTu9miqIlab6EqG0F89/SkrOsCf/O0uXtUpaFvqQI0yKzXjqI/XkKxKrUtTjHs4xtx
 s3O8n5kCjoABBaf4MlgSFSi+gy1l/hvsuDTRZI9FZdRISvEeiwhBKW5C9mxLkrs9zaMDdfVzm
 XACIH1DCa6WhkZahfO5GPnRG9vswb9jAEaKQL57ZfTPm7rM3zV9Lq/12atWnw8rQdgV+sUR6z
 3liBIyUZPpHaS7n4U2SJUfrjskwSzp+WaUCPZf63v4tGCZU3vFNluOa9hQVbx+skETpmieTce
 yHcjX1CICMSXzav9HpUfvj0LcwYA3njLsPRSZaaDwKp3WyMs71bOZ4zE2HVa3Wh0enGpICJLu
 R7AQUAUEqCSWlLxjTUSNRpAJr0QCN541uIb4nkGIKtt9zOBJCMu+DRV/l91q6zLRlT7MWyGU8
 hsIm/PapAqnR9fFcvh7G9mYJ0aiQhbVk3Ou9rIR90vIkwe1GygAbYFKxJhXdi2mTDUbRyqj6i
 ErMni+hhWnCYw2LwwW8tZNCGuZEGF2bBiYm9qbtyT8563Uco7CVWwgARDyfHwa4MTl2az57Dl
 aFrxchBPdKvrwsjeLfOFRP2zAw92yO3MnVxQvpknX4fslD/zAJp91Cd7LS3U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> It was chosen to transform source code fragments (pointer expressions)
>> by two SmPL rules so that the search pattern =E2=80=9Csizeof(T)=E2=80=
=9D would work
>> in the third rule.
>
> Ah, right, it would be nice to get rid of those normalization rules,
> especially the second one.

Thanks for such positive feedback.


> I don't see how,

Where is your view too limited at the moment?


> though, without either causing a combinatorial explosion

Growing combinations can become more interesting, can't they?


> or loosening up the matching too much.

I hope that we can achieve another reasonably safe transformation
approach together.

Regards,
Markus
