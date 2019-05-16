Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8311F461
	for <e@80x24.org>; Thu, 16 May 2019 08:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEPIkJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 04:40:09 -0400
Received: from thoth.sbs.de ([192.35.17.2]:40539 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfEPIkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 04:40:09 -0400
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x4G8e5M7017823
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 May 2019 10:40:05 +0200
Received: from [147.54.65.49] (MD11GXTC.ad001.siemens.net [147.54.65.49])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id x4G8e5QH001808;
        Thu, 16 May 2019 10:40:05 +0200
Subject: Re: [PATCH] sha1dc: update from upstream
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <3cabed9e-3949-93cc-2c9c-500a9cd9d4cd@siemens.com>
 <20190513221701.1837-1-avarab@gmail.com>
 <09f64da1-b8aa-3cd7-89d7-475b8722e176@siemens.com>
 <87a7fovsz8.fsf@evledraar.gmail.com>
 <6aabf669-a73f-d23d-8d65-8b96eefbae4b@siemens.com>
 <87y336vm0h.fsf@evledraar.gmail.com>
From:   "Osipov, Michael" <michael.osipov@siemens.com>
Message-ID: <bd8bf9da-23e6-a2a6-1e90-ed2a62c73cb4@siemens.com>
Date:   Thu, 16 May 2019 10:40:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87y336vm0h.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 2019-05-16 um 10:31 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Thu, May 16 2019, Osipov, Michael wrote:
> 
>> Am 2019-05-15 um 13:48 schrieb Ævar Arnfjörð Bjarmason:
>>>
>>> On Tue, May 14 2019, Osipov, Michael wrote:
>>>
>>>> Hi,
>>>>
>>>> Am 2019-05-14 um 00:17 schrieb Ævar Arnfjörð Bjarmason:
>>>>> Update sha1dc from the latest version by the upstream
>>>>> maintainer[1]. See 07a20f569b ("Makefile: fix unaligned loads in
>>>>> sha1dc with UBSan", 2019-03-12) for the last update.
>>>>>
>>>>> This fixes an issue where HP-UX IA64 was wrongly detected as a
>>>>> Little-endian instead of a Big-endian system, see [2] and [3].
>>>>>
>>>>> 1. https://github.com/cr-marcstevens/sha1collisiondetection/commit/855827c583bc30645ba427885caa40c5b81764d2
>>>>> 2. https://public-inbox.org/git/603989bd-f86d-c61d-c6f5-fb6748a65ba9@siemens.com/
>>>>> 3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/50
>>>>>
>>>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>>>> ---
>>>>>
>>>>> n Thu, May 09 2019, Osipov, Michael wrote:
>>>>>
>>>>>> Hey there,
>>>>>>
>>>>>> Am 2019-05-09 um 09:32 schrieb Ævar Arnfjörð Bjarmason:
>>>>>>>
>>>>>>> On Wed, May 08 2019, Osipov, Michael wrote:
>>>>>>>
>>>>>>>> Hi folks,
>>>>>>>
>>>>>>> Hi see Documentation/SubmittingPatches for how to submit patches inline
>>>>>>> instead of as attachments.
>>>>>>
>>>>>> Do you want me to resend the configure.ac change as per wiki article?
>>>>>> I can also create a PR on GitHub. I am happy with both as long as I
>>>>>> don't have to retain the patch for myself only ;-)
>>>>>
>>>>> Yeah that patch to git.git should be done separately. I see your PR
>>>>> went in upstream, here's a patch to update our code to match.
>>>>
>>>> To avoid misunderstandings, I have factored out the Git patch and
>>>> created a PR: https://github.com/git/git/pull/608
>>>
>>> Thanks. If you want to submit it for inclusion you'll need to submit it
>>> as a patch here to the ML as described here:
>>> https://github.com/git/git/blob/master/Documentation/SubmittingPatches
>>>
>>> Or you can use this pull-request-by-proxy thing:
>>> https://gitgitgadget.github.io/
>>>
>>> Or if you don't want to deal with any of that crap just say and I'll
>>> E-Mail this to the list for you. Just want to give you a chance to do it
>>> :)
>>
>> Yes, please do so. It seems like our corporate mail relay server does
>> not allow sending emails outside of our dns namespace. I get bounces
>> from mailer daemon.
> 
> Hi. No problem, but I just noticed your commit is missing a
> signed-off-by (required for inclusion in git.git), please "git commit
> --amend -s" it and re-push that PR, then I can pull it from there.

Done as requested!

Michael
