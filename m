Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A51B1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 20:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKSUVw (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 15:21:52 -0500
Received: from mout.web.de ([212.227.15.4]:34025 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfKSUVw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 15:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574194910;
        bh=2jS32S7aMVyyab/6do0pSZuonOljTN2PbvVMX6x+zpA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GhU7sytBPf6faVPEF1hLTlOs09KeJbfdwxIbMaPH1O85Mdm/IhDYyz12UJbFU/bd5
         Dzesi7/xFE6GyA4XibQ+6oTXJGwVB7qfqyS8pyacYed9POBZJCVOh8YzB/Az1Nc9q6
         yo8wg08B80wiIAw6MiPJgjkyzre9eJavRpu2hu28=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.93.164]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtoGb-1hoRBb0Be9-011A8D; Tue, 19
 Nov 2019 21:21:50 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <75b9417b-14a7-c9c6-25eb-f6e05f340376@web.de>
 <fc56b970-4ca1-7734-c4bb-f57cae7a273f@web.de>
 <57b5d1c9-72c1-6fff-a242-90f5f24f0972@web.de>
 <37c84512-ba83-51ce-4253-ea0f7bd41de0@web.de>
 <eff19da9-3f9f-0cf0-1e88-64d2acdbabcd@web.de>
 <321802c9-e5ea-452f-a3fd-7e01ab84b1f9@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a4a882eb-5e0d-dbcf-fd01-9d5831c4a8e6@web.de>
Date:   Tue, 19 Nov 2019 21:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <321802c9-e5ea-452f-a3fd-7e01ab84b1f9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JczqUb65yCdbhiDG4PqwIokkIBT9Zgp2xpMjAQtzRQJQ5MxJzKd
 v9H1fwR355Ssd8ST9beeSp/+l4bhGnYY9FDX0v+r47V8UmcmWUr7UZ9oOHeXMHmQsNxDmcC
 6Xp2TzLmK9a/GzoeK1ANmfDUM6JfMiuRuzwxJIXDg+pjtIhAjNnuuiw1dFVCPKghJDd1ZBA
 7xNxQn7hW61ZeRLRtdnEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ag9kVN0k/nE=:yvyQBP7iOn/a6w1z0B1HHk
 Rx0NnHd4+ns0wUmt7wifkIZ0hdUk2s45Wyn9/vPx99BVuVyt1C2pYsMa4pqdv/PPJ1UxT6j80
 KfPdEC9CthnARVe+lz1EjBtIJY+LgUhaiNs6NAaHnKoR7mY2tFwdAXZEdN3/bIUeqlHjy8qw+
 J6V8b9vtRroqC2BULTfBgDfI+8E0yLmSJu7lRngE+Qf/j5n86UoJzeZm63A+SoNhdUEwvHQjJ
 NcDePqjr6JdzIAMG0cOWGnUFBbEhL39o/Uer3C2TWwHKE7nQkbwRwlIpTybpqavbF+FUOJ+H/
 gJC4wgdJcVV1QR+d7y2dy37FAb2MPMlHiUc+P1UM/3QyDQVUs2gz0jOUeJQ309MfLRNYlaZn+
 zk5cMKxpAVd6eAGb0jD1C/aI5A52OLaqkt6QiapsQKiVhISieGFpG456BGGq8fJ13XdHlz9Rh
 /4Pf/nrpuhgUVXx5gF1gtCOdD2OTJo/Ei5NbXIHWgQoz/4i9kwuE7bqh5LivcuOSjhWF2H0ES
 oBcjVg7Vqco697U5nLw151qBWdJOuhdyGmADDI5k6VNuSOxzcYP7bOaRazg7kqwqsZqq2HAc1
 zatlF1OcsZAw/kyDXLOmppAe/wi3V4E1X5dTKo5Tj+jOljDYjy5ooq8JOAQRZoPifXEyTTfcx
 3U3eZnKtz7XgVsqC8RvluMBlJeunJykJOTQpu+YymBR918frLfhvq2CbCWi/1qz+7ET5rY4F/
 pVCfAZJxS2rnI1jaUjDUjfrmVQFjVnXt7/epn/98z79uW503/c50VaebHgW/vvdL0SxwLifHi
 v5bvHb979Fzds1PszSMrC3DeQzJQDSwuY4JtE6jKoG5vSukVcogg4nXgl+/2aXwHawmQufigq
 OSusKrbU+aBIFDH/9dacSs4r1SUos29ZqNn6H0rdYrwHhRFOZe5UTlvJEsRf+qDsoElXcFlKF
 rskWM9g1A8lQma9ifbvPfCnEbrOaT8bZ+vTdgtLSVl7t5k3MEfD0+tA9Xeg7gBLCFCWCW36xF
 J9maNMOI1H3LAb6bfobimUwpUgOa35e7VOLywex+WT7svEqx7e7kIe3sp6pAuI6/1gmih7WDo
 5cXcKQaXpmZnDF3CCguIE0NZvbpZpxHzDnv592QOB13r6WeJkQkzPdBU/4Op/K704Djx9fPHC
 dFyRoz0mmT5e2uUFCFbHm2+5j140OAPQ1By4YojBWS60F8FvIHH2978ms41o+aVdmGOflAYPd
 EF01B6BzvWu+GP9P/7yrL8SdhkDvs1uQWlsWbPcyunC2n6MSiyB4KC3yG0Jg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Will there occasionally be a need to change only the required source co=
de parts?
>
> Changing parts that don't need to be changed does not make sense to me.
> Why do you ask and how does it relate to the example at hand?

How does such feedback fit to the discussed SmPL change specification?

- E[...]
+ *(E)


>> Would you like to support corresponding development anyhow?
>
> I don't see me learning OCaml in the near future.

This can be fine.


> Or are you looking for donations?

Other (software) projects can benefit also from additional resources,
can't they?

Regards,
Markus
