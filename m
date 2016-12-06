Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95291FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 23:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbcLFXFv (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 18:05:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:56171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752203AbcLFXFu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 18:05:50 -0500
Received: from [192.168.178.43] ([188.108.240.182]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGB7j-1cPixB3xcl-00FAku; Wed, 07
 Dec 2016 00:05:47 +0100
Subject: Re: [PATCH v15 12/27] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ad5-0f90c88e-2077-4155-94e9-7d71dbbac38f-000000@eu-west-1.amazonses.com>
 <b54f7f46-a3c0-3334-24fa-e8d1e7d8f653@gmx.net>
 <CAFZEwPNZCSGzeabHMH6wihz-51OUMMtnBMsffwJJVm9G8Fn=tw@mail.gmail.com>
Cc:     Git List <git@vger.kernel.org>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <a492fb63-3642-1f97-4668-a927352169f9@gmx.net>
Date:   Wed, 7 Dec 2016 00:05:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <CAFZEwPNZCSGzeabHMH6wihz-51OUMMtnBMsffwJJVm9G8Fn=tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:UWcDvhknahd1gVgm1RpZTSowjN3ZzFhLClITZkx+Z0CeoesiY9R
 Xm/WF1YCyfLZ2Jw7fRmPHNXE0P6zSl7TeproCBRHxHOJFtLt4zx/sXLXY1SE162/A8krkgr
 mNQwh+JFHpmKvTBIXuuAoijvBLjBO8IJtDjJl/NKKg/5oIP/oaRIddJmqs30RT8I6zIDr7i
 gVlfPo/ADp7VHKGyjk32g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3q6U/o1OG5c=:GctwToT4VSR4JtcCd4/0Ny
 A6s29DCClXVvu/qfCCjgm8r8zmK8W31+2GH3+NYQ1uJ12mo9cKBw3BI2zchUCbC0GltFFSvBX
 H73QpMwp85JyneTsswasE4s1zn/q7xDR1lc5zKen9CKwYPGwepJ8gF6rJ2KYH2iYBwDgGqPiB
 IYesFd/eTkfFCXjFsVZOJwe+UwPXNmEDWgZ1H69Af0udsEkPTFkR90BAx2/rYnx29XUbgEhId
 8ur8xhy4WLE1sCCee+LXLYtxhU62TM3gSp9+dLqRczpXXOj+MlExgoOlkZFkzmK/DELuVHN1S
 ZGKgtjsqwRrARGEm9UZeIpha4zF/JCypTB0HAjl2nbY7Y+STdnL17nD12c1ODYP09jFOK69q2
 L8Q/3QiNhjW7/nOSKVXEGkvRCMX65inAiP++fy9zKFK14P5clNDK3xU/EfZVP4+CtIRGrQIM6
 W/qbe3ZDaC+l39Pv/8EQdMDVoxq5COtpSn6/Yq9z+K7UTugEHp0FY5Ug7vmZvyAVp4jm1osQC
 n/kCzlAyXrMkzrSmLefdCg6nzaVnbUSkuxX/nEgtbc0zkn53QADaBp8d4HXj7PWL8EKh0kRT2
 0a8TTjskC/rK6l/CFPK9+GMkEf59+kersJIZldnZ/+xBsJbpy+ny4MmrWlApygdB5naBlG2bR
 CC/GD/AtKjP9wQ8yJ4m3J872mNS7kIoxgquK/xXWVKN3+m7GpuymRBAIVms/YkQ9GsjMZFc4a
 wlZV6+lmtkolBooAPAlu9R90+j3Q8kpsuQMTsyFnAwBXxz2Sor4yjpjx4womUEF0VWxLirM4/
 o23ITzu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Pranit,

On 12/06/2016 10:14 PM, Pranit Bauva wrote:
>>> +
>>> +     if (argc == 0) {
>>> +             printf(_("Your current terms are %s for the old state\nand "
>>> +                    "%s for the new state.\n"), terms->term_good,
>>> +                    terms->term_bad);
>>
>> Very minor: It improves the readability if you'd split the string after
>> the \n and put the "and "in the next line.
> 
> Ah. This is because of the message. If I do the other way, then it
> won't match the output in one of the tests in t/t6030 thus, I am
> keeping it that way in order to avoid modifying the file t/t6030.

I think I was unclear here. I was referring to the coding/layouting
style, not to the string. I mean like writing:

	printf(_("Your current terms are %s for the old state\n"
	         "and "%s for the new state.\n"),
	       terms->term_good, terms->term_bad);

The string fed to _() is the same, but it is split in a different (imho
more readable) way: after the "\n", not after the "and ".


>>> +                     die(_("invalid argument %s for 'git bisect "
>>> +                               "terms'.\nSupported options are: "
>>> +                               "--term-good|--term-old and "
>>> +                               "--term-bad|--term-new."), argv[i]);
>>
>> Hm, "return error(...)" and "die(...)" seems to be quasi-equivalent in
>> this case. Because I am always looking from a library perspective, I'd
>> prefer "return error(...)".
> 
> I should use return error()

When you reroll your patches, please also check if you always put _()
around your error()s ;) (Hmmm... On the other hand, it might be arguable
if translations are useful for errors that only occur when people hack
git-bisect or use the bisect--helper directly... This makes me feel like
all those errors should be prefixed by some "BUG: " marker since the
ordinary user only sees them when there is a bug. But I don't feel in
the position to decide or recommend such a thing, so it's just a thought.)

~Stephan
