Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB7F1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 15:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfFDPiI (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 11:38:08 -0400
Received: from mout.web.de ([212.227.15.4]:59985 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbfFDPiI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 11:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559662683;
        bh=78qCpt4OTWb5DycbHcdyLOZGuTqQb7IHXoXfigcABfE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AE40nBAOY8ekz14K6n+/OjPVmB9iK0hDzyKpAGkwLoH0xmsm8NZ0UKe+UGXVrvu6U
         7nTyXFgds73n3PMZBlcmkqkJdCzav/sqUe7HM0aPIdLdttN4RP8pilj7iNeKbzpqxY
         JnV1MZftdkjHSBK3ZrHWae3B9sPUsPay6KTvbM+E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.20.65]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lbrk4-1gozPC40No-00jGh3; Tue, 04
 Jun 2019 17:38:03 +0200
Subject: Re: [PATCH] am: add --check option
To:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
References: <20190603142523.3826-1-sir@cmpwn.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0683d141-544e-12da-17ae-dc1157a2985b@web.de>
Date:   Tue, 4 Jun 2019 17:37:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603142523.3826-1-sir@cmpwn.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ud8PwgG7PVueIS3XH0tOVK6tkEJ8cf/bHNQgBfh52MXTLzLaTWm
 MduWQFPSQvt94NICFJcbFSuA+xcxcTZ20f6Sl+DbcUYFdOGRcmL0KdZvSYoHAR2qfmN21q5
 cR8gvIMW+uzwhvUMcpwKlKwgpLW7y1u2xZ4c5UuExKqRcggt+0VzSa0l4ZJdl8v59rN14Js
 eV7XuXgVhbXnmshYJmPQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dH4Tl+EBKZU=:/m5FKydaIS0el5y6wDST42
 NvSEpR7eWPvsp7dme8uMBGxvF/XSDZZxWLRsZxG06n/dsz4lBwKR7U0o+6/Ixe8z78zEUzt8x
 UO8tAMjY9kL1GgGo2hi+1aWN3Ljc5xfVOrMF6RSEhIoLr8amdO4BGd9XXRftl/q36C1z5PFhU
 xpy11vyylur26EVezDNPLejDjHaN3SYPCrsqjaNwY8bkk1NaEuzqu4c914BnaI1WPmzSvcndf
 Lp/W/OveLJHHOxZSZWgg7BV9zCMMKDthltmYyHrTFv6wHi4/hDGXBIxTXgU/khMD+ZbuIJ2mZ
 LPgFs+Ed4n0NzxuIHpxzztV2oqaSaNtaCIMmJX4F9q57j1pgItI+oKlYR2ASe3ToT6Obq1AlZ
 b3C1QbmzEkf4EwTtMQuLFseuNt/IeF1bAhF61FVAMRFsDspV90sR7eKW0tNg+K2qgsdYLFtE1
 2NXOgD0pGLDJpT208w0u9ZiLU/ZLiJroptcNXHXLB7UlDzlDWz2fw+gpePg4tPPZn0nUVc9SC
 Tk/yHAiOnKi6JB3xafABj3eEWsMKVgWeLzmaQfxe9X15C5YV8zmZVDiFkW3Q6/CEOiSB5/mlF
 OSpttLtOTX+6aMpBHaKn2Jt3g/sfOetyY9vg4ujQpWMIjMunP5bCLtZfkHIYFcVvqCKHC5zHE
 B6IFjT9H5vEWqfpAijT0ZaOddTZIkWEfMWBiIVw1Y/YxdixyK+om9CHKeSeToHAYmlEaF5Y1J
 MtOtI9VmLllChp+e1d9DdTrrp0kfuoh++4/s9LVnD+081HkQ4otzDwyJ4qgRwguoFNSD+Tgkc
 /dM53KxPEe46hG3AhAAmJKBM/tJ7TGcpAhVngUG2o1nQ0OnKLC+O5eNHh+XezSFwcGtwY7C5d
 43LRWqboAllY+BepCBmxnu7ofI3EMHynVdEsFrsqRUdRUyiSGrMMWBnkZJIbLlyv+rVwCFAsw
 4PY9UIsVuaV40QS+VCakDodM7UZKBi0A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.19 um 16:25 schrieb Drew DeVault:
> @@ -2195,6 +2206,8 @@ int cmd_am(int argc, const char **argv, const char=
 *prefix)
>  			0, PARSE_OPT_NONEG),
>  		OPT_BOOL('c', "scissors", &state.scissors,
>  			N_("strip everything before a scissors line")),
> +		OPT_BOOL(0, "check", &state.check,
> +			N_("instead of applying the patch, see if the patch is applicable"))=
,
>  		OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"=
),
>  			N_("pass it through git-apply"),
>  			0),
>

Git apply has a --check option as well for the same purpose.  Other
commands have an equivalent option called --dry-run instead.  Would it
make sense to move towards the latter for greater consistency?

Ren=C3=A9
