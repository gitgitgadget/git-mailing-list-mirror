Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37990203E2
	for <e@80x24.org>; Tue, 26 Jul 2016 01:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbcGZBni (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 21:43:38 -0400
Received: from mout.web.de ([212.227.15.4]:61994 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbcGZBng (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 21:43:36 -0400
Received: from [172.20.0.236] ([207.179.142.2]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MQL8O-1btKxQ0Yiy-00ToOM; Tue, 26 Jul 2016 03:43:28
 +0200
Subject: Re: [PATCH v10 12/12] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
To:	Junio C Hamano <gitster@pobox.com>,
	Pranit Bauva <pranit.bauva@gmail.com>
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
 <010201560a4782ce-8d6545f1-2454-492b-a2c6-6e0f2ac824d4-000000@eu-west-1.amazonses.com>
 <7a408f75-74d9-7e59-35d6-3a931414a7f9@web.de>
 <CAFZEwPOH+V+Nfq1KoOBBdVgeFD7YCG5c1PJrUHB50O1DkMg39Q@mail.gmail.com>
 <xmqqh9bd7j6k.fsf@gitster.mtv.corp.google.com>
Cc:	Git List <git@vger.kernel.org>
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <f6657922-555e-affa-8904-678bc7ee3f71@web.de>
Date:	Tue, 26 Jul 2016 03:42:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqh9bd7j6k.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:P3O8k3+QXb5FmvxlQ8zcvW4sTNYD3D9ANM9PZAF6+lZkRDmGt2K
 Zao/AV9WUhBWyO8n7tWHnd8GYXzvGE4cVf7v9yWcurmfJGO8y/u5K5+MbSWFOeA9TqErC7M
 bISI3TyPuAQB3fvvrDLErQTFKG8huJA+A1r6D1eqdaWQPiG+sKMdodveFernlo2NCnkPOdv
 8PrsqWvNBIO7TuOS00yfg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:mWuYUbjMmic=:bhUsWKtNDXXcHxJ2LSd9yd
 FpmXHjqiyHTbLL3TiUndXtx5vajDRSMF8hP1/FjyzOLXF98hE5p4qfN0Y6Mz3D9TpwAfu6rTm
 tNQlVb6bzVFkqgLthUiUQiFPOds3f9EmKOKZywHAXwcnrz2CGKJl1v8nAcEDh0ynqfFjrL/49
 8WHOVI+z4ttSGUiScVErYxe4nkYntmM2JB5Uvjyn5lUGYhcltBB+1iixZ60BnlceRnobEClyc
 uPG5aJ3GHBA0DA0G7hdeKTd1vPVbus4a2dpXHbItloPvif2x+0NFOBR6m11Jm+dbMo4fD7gCi
 cxODbu6vyASQnMMy2+mGPJRt3qAIz0woq3dAATH0PTV/6f1DtOUAh8biMfmReXuzFNTc24vQx
 Vi/R+zb0uMy6LgGkYYj4z1sx6e90J0gVUkwCMdUaiyz2765nxX+LvxFE0TIgUv+i3g6LvuTWG
 Oi66OQmODEgSD193HmBNygOc3d6iNxrsvrSDW1QpPPBpXHv77lFGHtjvIsz4exrmMxnm5WnNF
 iExn5L37tZr7FSvMzj2wlX2/AIxa3q4DP4QwSQhcncaEHM36BWR66z3e7AsAoKJl7jrU5opHJ
 FZo56fCO8Y+K3DtpXUap9zBQYP49W35Gb44e7v8/ZXfw60ehqaWP8E+O+C8GfI9/+iBo3+S21
 K1uCpbcwPDANR62ps7VblD+lZLEtzihU6/hUkqtt1FWj0KokEHZ8tICWv5VnsxQLmbSq2xTny
 DBLw5+yDE3jb3Zplx+AtyWDVN/Zt8t5NTNtZ2Win+7yMc1G1EU4dw5U/SHWJLx9fUUXpP9hct
 /AvSP6R
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/25/2016 06:53 PM, Junio C Hamano wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>>>> >>> +enum terms_defined {
>>>> >>> +       TERM_BAD = 1,
>>>> >>> +       TERM_GOOD = 2,
>>>> >>> +       TERM_NEW = 4,
>>>> >>> +       TERM_OLD = 8
>>>> >>> +};
>>>> >>> +
>>> >>
>>> >> What does TERM stand for  ?
> The terms (words) used to denote the newer and the older parts of
> the history.  Traditionally, as a regression-hunting tool (i.e. it
> used to work, where did I break it?), we called older parts of the
> history "good" and newer one "bad", but as people gained experience
> with the tool, it was found that the pair of words was error-prone
> to use for an opposite use case "I do not recall fixing it, but it
> seems to have been fixed magically, when did that happen?", and a
> more explicit "new" and "old" were introduced.
>
Thanks for the explanation.
Is there any risk that a more generic term like "TERM_BAD" may collide
with some other definition some day ?

Would it make sense to call it GIT_BISECT_TERM_BAD, GBS_TERM_BAD,
BIS_TERM_BAD or something more unique ?
