Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FFE81FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 16:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932152AbdAAQ17 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 11:27:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:63378 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932066AbdAAQ16 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 11:27:58 -0500
Received: from [192.168.178.43] ([88.71.226.185]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ls8Qd-1cVrFf1DiR-013z1O; Sun, 01
 Jan 2017 17:27:52 +0100
Subject: Re: [PATCH v15 15/27] bisect--helper: `bisect_next` and
 `bisect_auto_next` shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1af0-5d688c2e-868d-4d8c-a8fd-9a675f7f01da-000000@eu-west-1.amazonses.com>
 <06402c8a-14a4-3d70-8d98-659cfe9f1aa2@gmx.net>
 <CAFZEwPPtF5P5nGp+=btHtwNm1unTJ7qo1khJHCqLvNn1=RYAUQ@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <cdf41dcc-bdc5-a3a7-8d39-8b85e01cda85@gmx.net>
Date:   Sun, 1 Jan 2017 17:27:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <CAFZEwPPtF5P5nGp+=btHtwNm1unTJ7qo1khJHCqLvNn1=RYAUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:r4F8/62ssPeZu/ntnKCQaMEH6KA/90JoQ9BZevylfD57qWK796z
 uXP4jGK/Esz7kWUP1HTD1RJu6IbOx1Jvugp671vXLUbVrfnUrce+tgzy3wJ7ezIE2CcZtdd
 +OCdtRr77e4A/UoQnHja+sN9VXpnUEAvyupfl0argltIVk6zvlHENHF4FJZRVbqxqcxc9LL
 Bo426yufZ2tEySkLhre3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NQ8BL3rZiVY=:yBGdUyCC+aSdN+VvFgS/pB
 yyE5Zzl0bJhp2CIGWhgiQEhNs0u6QClbq7+MGcIEizFNdPys5LFTSBcU3Ce0C2l25sFLazxZo
 D4zZQowW7YCjm918eolY0HOQ89HUDFaHPfc/xmB3ImOzxdegMa9uZSbpi7rn6E+py4bpA2+Pz
 PLQVjv8z+nhDdkvrYYILA+feJCCkyeWoBkgKnU3VVGlVhZ6UZPEseZ9wsF71+79l902QOKti7
 eg9y9qfrRTzosVFWzu1BxFmBBI867QHRESVQaIhdf1VW2EXQAT+j7yFJzV+wCQl23SMf14qJj
 usVnoZ7/9KXw6hj+bfMLqtFS/RKmlwcRvqnOctR305BN6nBhHpZLTAvpDx3Tv2M+gDW9i0sS+
 hixTruAL+jv7U2tGW6aTLhApC5Az7qUicNEunwZKSRJnBpj+GQHkHGRocK7z0fArtFcAxaGsi
 z2kIL+xr87X0QiFUkxQFYaVf3uuVzdnDhrZA/einfxoyIhSfCYa84aDU/5Mk4QN9sIaCnsRP9
 p/mAOaVBKCE1ezT/JEGafJgQghE424W7g2eqSScnaOxlcQaY5+hV13PSjCkCMM4abl6wfBazD
 yG2CF56wBSwTLF6p93+d+P7sutg5kUZWAH+i9R/8ktxBGqNI8HB70AGIyrrOkMK6nASYWjPB4
 ZVb9Cikw5qkkPKdT4Imz7vmeKSzo0HtB+VD57Bl5y5aEvCpm0aRqEeUdOYC+EnXPDCWgnXP7d
 yhf6ItX5MNSTd0DLyr38KDqirmksjId8MsI8BrQj/Cs1oDalKBHbE+B4w6iBc/d1FczIDkfHB
 dDkQbfukc65qlWwlpv+Ie5zphXTavHizhTtZ3eHK0PcqGxTBCint8Z+p9UrJRgBqkeOoIXxfm
 3bdenp7h6ZKH16YnSJCrUViA8K/sT7il8LS7cvRpOBGr8W9fcLx2zzdmuIDy9toa5slxaKb0W
 4BSRq5nPhDG6kFhgVN8QmFCcyYS4tab62jsR48yfL0HvEWXffbWnbyCjOgOaPhI91kKNrXTDR
 n0t3FPMIl0Lu15KB3v08Du8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit,

On 12/31/2016 11:43 AM, Pranit Bauva wrote:
>>> +
>>> +static int bisect_auto_next(struct bisect_terms *terms, const char *prefix)
>>> +{
>>> +     if (!bisect_next_check(terms, NULL))
>>> +             return bisect_next(terms, prefix);
>>> +
>>> +     return 0;
>>> +}
>>
>> Hmm, the handling of the return values is a little confusing. However,
>> if I understand the sh source correctly, it always returns success, no
>> matter if bisect_next failed or not. I do not know if you had something
>> special in mind here.
> 
> Umm. Shell code used to die() and thus exit with an error code.

The invoked bisect_next shell code called "exit", right... you had to
replace this by passing return values. I get it. Thank you!

>>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>> @@ -643,6 +794,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>>                        N_("print out the bisect terms"), BISECT_TERMS),
>>>               OPT_CMDMODE(0, "bisect-start", &cmdmode,
>>>                        N_("start the bisect session"), BISECT_START),
>>> +             OPT_CMDMODE(0, "bisect-next", &cmdmode,
>>> +                      N_("find the next bisection commit"), BISECT_NEXT),
>>> +             OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
>>> +                      N_("verify the next bisection state then find the next bisection state"), BISECT_AUTO_NEXT),
>>
>> The next bisection *state* is found?
> 
> checkout is more appropriate. I don't remember why I used "find".

"checkout the next bisection commit" maybe?

Thanks,
  Stephan
