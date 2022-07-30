Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D07C04A68
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 14:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiG3OpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 10:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiG3OpG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 10:45:06 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C1F1403A
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1659192292;
        bh=07wchVofc/5aJWk+hH/We/fX1PfLLEYtWujgQYFs5TA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Va4vw25fgRXZ6hT6qr73NJ98S+pXHX0wwJix1IU6i4RBjUz6Y2EFbQfixlw5UBI4z
         rWZ1B7idAlw3xyV6RErUGeJQE1ZPTf3XhBYHJhvO002HJlf7rwIZpCP4rUlo4i/jmf
         9fWVdTt7/H+W1QtpWzHRRLCLxAfy9k7N3jY1QiYw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.155.233]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLijs-1o08Id3xpI-00I7Nm; Sat, 30
 Jul 2022 16:44:51 +0200
Message-ID: <d461718f-cc72-96e2-4de6-4cc67e3b95a5@web.de>
Date:   Sat, 30 Jul 2022 16:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: Lost file after git merge
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?TGHEj2EgVGVzYcWZw61r?= <lada.tesarik@olc.cz>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <HE1PR0501MB24096E2FBDB66318A2FDADAAF8969@HE1PR0501MB2409.eurprd05.prod.outlook.com>
 <220728.865yjhl8wk.gmgdl@evledraar.gmail.com> <xmqqilnhcgd7.fsf@gitster.g>
 <701c318c-1a1b-1793-90e8-807cf97dc948@web.de>
 <CABPp-BE4saKAboS=SPQmQe6n2=Fnhv7pL4_JfF2Zwg5Zhp7Vjw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CABPp-BE4saKAboS=SPQmQe6n2=Fnhv7pL4_JfF2Zwg5Zhp7Vjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:it9k5aXpbaXPRSaoxKTwPQVGrKAH+0TRpX79X7pw3Xz1Rhk2uee
 CnBzYSQOJYlFRhmF+UbuLYP/XW1R8wi/+4VCyKSYXRZlVJRftFhg3h9krjfbSBsm2SPnPmX
 eLgU+348Tlx+vbbYDlkOHg1sGf591HHQpuiBZDetBoGCfQeP/XrsUejwCfmYR8bqAL5mQ1V
 r1av5d1TAb4UzoQGxJ2aA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rnvsNb7uIlM=:psXDPgh2npB76IzpV7SDNZ
 ftlPqIidGx5nkH+dxPpDMEevwU9Wn1iG6l8x79ai2RKCn7Fo7iOe6/A4XKkd3lYK0FqKeD4Lv
 eNIhJw/6km0lacniCnCtCnVfmlO6CfpCAwGq6B0q8jdDCbjVz6BUZs6CPc86XQQOtG9v7jY9K
 lhD8R4+JRPbrz4lazNX0jlbvsxjHnZvIwbBJVq8EszPdQ/KEtoR1dtuA+4qcTjiovXsi9u9qd
 VWHpuK0kiZT7wsNMsFVjtNY4stqevStr7+5sBLhmFJ+xlOm0U89XQBGXE9uhl5TUAcdQ3l6O+
 jR3qvhmduqIXj0xh7z3R3eZrwdP2ubbs4TEOGKJEMZaFsE7C0RIqdLAUZ59ccS1+KUIW21qnl
 ZIlNieUswbmFnAjbYBdJl78mp0PHTR4aKtrYZtuiXbOkOZ0Uj2q3GhcVIFK5otB6nflvLZUWh
 zjYBLTDAOHUY4d+K732mCe+zrqJivJ/FqBT+HbkQWHWDC/1JHJl2JgaznQVpAnuYDjPPDLejr
 FQ143Yz7jLZCob1mmvzdiyGFEBi4VeFz2DaWPTbTF3WMoF5E6B0hxKHHhUwamDs0F4LHxJXMg
 tghXtpDuMQhAi0mWFpsvJW/iAUzaH667jO4/HbmMoyX14XYaggL/exs7Jhd/9UMopMymDZxzd
 YSoHfNuIp039W9QudO2NpdC69SN9xximq+CPf009yGSjI6zgxwIBZ2lrkyuZX+Fykq2w4bKB6
 t/pw5Xg50hFaBXwNzmZ9cvfAlNzfMpTZejh+tx04+WAEW0XrwDWjTvBpA8+F4N3CAdVVGqGhH
 KYoKdEd4jbxapn59a0ofiG6sbnSXJfZog9KsOi5EtZfUVrpuMoek59jErKzF52cXdu/eYBkqm
 6IkQwJCnlgE+STmTEOcGESp53SwVyeFEekLrqsSvoVqvFdK0r5kjMiNscZzhgX33XPrPVJ5/a
 fiieZ4Z0CEHkW5vqegY6mtIL+FKThbkBXMJCQfSgNtZAd0TkfXSXsl2iqTJI8TH1wBEkERdr2
 8270JaWj7iKKUzAE5REN8iOMTqKODVwzpWqEKtMRbCs69wZUIQ4tngit//eBiCHlMZJ4R44kB
 Z1Q7vTRS+zIqmaDYStvfkd7PP9HnOUePcvu
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.07.22 um 04:16 schrieb Elijah Newren:
> On Fri, Jul 29, 2022 at 1:34 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> Am 28.07.22 um 19:11 schrieb Junio C Hamano:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> On Thu, Jul 28 2022, La=C4=8Fa Tesa=C5=99=C3=ADk wrote:
>>>>
>>>>> 1. I added a file called 'new_file' to a master branch.
>>>>> 2. Then I created branch feature/2 and deleted the file in master
>>>>> 3. Then I deleted the file in branch feature/2 as well.
>>>>> 4. I created 'new_file' on branch feature/2 again.
>>>
>>> It heavily depends on how this creation is done, i.e. what went into
>>> the created file.  Imagine that a file existed with content A at
>>> commit 0, both commits 1 and 2 removed it on their forked history,
>>> and then commit 3 added exactly the same content A to the same path:
>>>
>>>           1---3
>>>          /     \
>>>     ----0---2---4---->
>>>
>>> When you are about to merge 2 and 3 to create 4, what would a
>>> three-way merge see?
>>>
>>>     0 had content A at path P
>>>     2 said "no we do not want content A at path P"
>>>     3 said "we are happy with content A at path P"
>>>
>>> So the net result is that 0-->3 "one side did not touch A at P" and
>>> 0-->2 "one side removed A at P".
>>>
>>> Three-way merge between X and Y is all about taking what X did if Y
>>> didn't have any opinion on what X touched.  This is exactly that
>>> case.  The history 0--->3 didn't have any opinion on what should be
>>> in P or whether P should exist, and that is why there is no change
>>> between these two endpoints.
>>
>> The last sentence is not necessarily true.  You could also say that
>> 0--->3 cared so much about path P having content A that it brought it
>> back from the void.  Determining whether a de-facto revert
>> - intended to return to an uncaring state of "take whatever main has" o=
r
>> - meant to choose *that* specific content which incidentally is on main
>> is not possible from the snapshots at the merge point alone, I think.
>>
>> Checking if 0...3 touched P and leaving that path unmerged out of
>> caution shouldn't be terribly expensive.
>
> I think it might be terribly expensive.
>
> Walking history can easily be the slow part of such an operation, e.g.
> can_fast_forward() taking roughly 100 times as long as doing the
> merge_incore_recursive() portion that creates the new merged toplevel
> tree[1].  (And can_fast_forward() is a form of history walk that
> doesn't involve traversing into any trees, so I suspect it's a cheaper
> history traversal than what is being suggested).
>
> Focusing on the tree traversal side, this suggested change would
> essentially disable the trivial directory resolution optimizations in
> merge-ort[2].  (Note that the trivial directory resolution sped up a
> rebase that didn't involve very many renames by a factor of 25).  The
> whole point of that optimization was to avoid walking into trees that
> were only changed on one side, where possible.  Your proposed change
> would be saying we always have to walk into trees that either side
> modified...and do so for every intermediate commit as well so that we
> can fully enumerate all (temporarily) changed files.

True: Compared to just checking if a path was touched by 3, a history
traversal can take arbitrarily long.  At least it's bounded by the merge
base and a specific path.  And renames complicate the picture, but only
full renames (same blob or tree ID) need to be considered.  That feels
doable in a reasonable amount of time, but it's not as cheap as ignoring
the history.

Assuming that one side doesn't care about a path because it has the same
content as the merge base is tempting.  And reverts that break this
assumption are probably quite rare.  Still it led to an unintended
outcome here.  Reminds me of a recent chess robot incident [3].  Speed
is nice and safety has a cost, but do we already make the best possible
tradeoff here?

> [1] https://lore.kernel.org/git/CABPp-BE48=3D97k_3tnNqXPjSEfA163F8hoE+HY=
0Zvz1SWB2B8EA@mail.gmail.com/
> [2] https://lore.kernel.org/git/pull.988.v4.git.1626841444.gitgitgadget@=
gmail.com/

[3] https://www.theguardian.com/sport/2022/jul/24/chess-robot-grabs-and-br=
eaks-finger-of-seven-year-old-opponent-moscow
