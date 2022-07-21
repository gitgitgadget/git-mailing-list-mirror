Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31544C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 21:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiGUV0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiGUV0J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 17:26:09 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A8F8F530
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1658438757;
        bh=dvoqxH2qts6sZxMAcE/lN9nj3Uu3LiO1n+ZsXVyJUMY=;
        h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
        b=oP6OzWnf80/qhGOJ0X4tMe48LR22suIJQGjRjz92wgrWVMERN8fHs80r9siqw1EyG
         zpFH5UAzLXMZHI0YTTAYwM3G7Q6wLN61ODBbgomJHCYz1ywOGYOKXy43J5aNwZ8jmC
         kUxib2Tn1LhBs60Lcc8u2Doh1tOnZzGiE1K17Ps8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.34] ([91.47.155.233]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MP3CA-1nrUd70s6G-00PgGa; Thu, 21
 Jul 2022 23:25:57 +0200
Message-ID: <b908b42b-2cd5-12b2-b47d-abecfb370429@web.de>
Date:   Thu, 21 Jul 2022 23:25:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: rs/mergesort (was: What's cooking in git.git (Jul 2022, #06; Tue,
 19))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqpmi04m1f.fsf@gitster.g>
In-Reply-To: <xmqqpmi04m1f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/xwtOs6RhgugfG00BcaWzJAlWGnJWr/YoEP63pRgYN620ng3DwF
 /fGcmCmK7nzwvIa/mUavt8JI8BJpmoHySF/6kcZSBC4xcQMZ2VkiktSoD8bgcBND29kdvGg
 7t/yLHiA0y+gPlFQRLriMTQjLt8jkBzFC20uN5Fnm6hTc6FwYiyNxLVcHgTJWE/taUudnlq
 9WqY21CzZ6GZ5eivUgY2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KNgREyvmPVg=:b8M9wnH6nUV+MZlk/erROW
 kfX4RfnElnfCRlvGfAGXuZo1MZDTeN0hKbVcqO4LT1wm04C/OAGq7MHy95f4cDlfunaatkutC
 QQafW3rFVpnrW3hmkUw5cDRGQDsEIIofQTrPkR1rWexEFr2jByLHspTtPnG8XtKYGlu1X/wZ/
 lAxNKgsPM7D3XTRceFaKo0878ajUdUxSShbLwWlK+LgGRHTmWdDJQGbTJT070Qxq53rYxkUaA
 PWxRZPaHgiSF7u/+2siFz6Oi6pRjwyQU8csUUgxzHStRC4SJJvfWkvgEG0JTImmSklUpLWy0v
 /jFo4FKh2aXddoFJr+uYRQ70XCPuwjgTOR6iahQlKD6x9YbMXAwYe6tSxuz9lSh1t3NyNV9EF
 X19hAEZ+2Np272HtKxkb8Cne/TVP68Q8Bv48YHFEtdf+w0BbAKjkklb2Rk41+982DPiuR7Bs3
 wq2KzMeyi31QNP+zlClRZsyW89Ft4crLA8rKbuX4JdMN8DEN80RXx0YPn5CK6ql/60AT1XTaH
 XrzcOrWfU85tBH0Vge8D/EzezChHuYsXORSpdMGQ+A5M5x2OwdO4Wl0LvDUR+rTRpbjtHL9qP
 li8ImpyzA5C1zUq/BKdNhWfc5wycXoHjgcNb++uribqUXmf7Ntfg6Bs8f8ueobT+WpSDENGvR
 fbD4oHKUN6TIBMcXy789e9AO13Uww/BjiqeIf67q7Nkub6FVN+bDFA0HIet4zl3wKkiyFGDbH
 99GLgiVDWtsUTfuqFtN97vPKIvhmeYDqitsbR7ZAha1hJwKP6+L9kktRUrPfiDnw2iemmvCLP
 Bi2MvwtJjn4gxTq8NToeR8t7Ex/qB6+f5NI+fkAfdxujfuQYQIbGLkrpmGbeJoMJDnXuc4+qJ
 y7GG5Q8eZWhkuQ86w+KVkIKf4ulwVPaSGcxIx6WX02zPhknINoV7qO55BL/KkxJLugam+1RSE
 ChbWLqjO4OS8WP+jWvi72/5QLd+m6b5wcNeDJJlfHPLONbK3QL/HnPIvpLugvTiyZledNopx5
 oh4OkkYk34DWrs1J1m66eiGT1QWLHky7FanGfz7AhK7Jdxf13q9C8hGV+shsyE5/mbV0DDF9e
 sFM/+fMRy4muF9M/+s4Pa88u8v9//kzVXCX
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.07.2022 um 03:20 schrieb Junio C Hamano:
> * rs/mergesort (2022-07-17) 10 commits
>   - mergesort: remove llist_mergesort()
>   - packfile: use DEFINE_LIST_SORT
>   - fetch-pack: use DEFINE_LIST_SORT
>   - commit: use DEFINE_LIST_SORT
>   - blame: use DEFINE_LIST_SORT
>   - test-mergesort: use DEFINE_LIST_SORT
>   - test-mergesort: use DEFINE_LIST_SORT_DEBUG
>   - mergesort: add macros for typed sort of linked lists
>   - mergesort: tighten merge loop
>   - mergesort: unify ranks loops
>
>   Make our mergesort implementation type-safe.
>
>   Will merge to 'next'?
>   source: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>

A confirmation that performance improves or at least doesn't get worse
on other platforms as well would be a good.  The numbers I gave in the
commit messages were for macOS 12.4 on an M1.

I managed to install the Git SDK on a Windows 11 laptop with a Ryzen
5800H, and it gives me mixed results:

main:
0071.12: llist_mergesort() unsorted    0.69(0.01+0.03)
0071.14: llist_mergesort() sorted      0.42(0.03+0.04)
0071.16: llist_mergesort() reversed    0.41(0.01+0.04)

Benchmark 1: .\t\helper\test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     136.0 ms =C2=B1   1.8 ms    [User: 0.7 ms=
, System: 3.8 ms]
  Range (min =E2=80=A6 max):   132.9 ms =E2=80=A6 140.4 ms    20 runs

After patch 1:
0071.12: llist_mergesort() unsorted    0.68(0.00+0.06)
0071.14: llist_mergesort() sorted      0.41(0.01+0.06)
0071.16: llist_mergesort() reversed    0.41(0.00+0.04)

Benchmark 1: .\t\helper\test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     137.8 ms =C2=B1   2.2 ms    [User: 0.7 ms=
, System: 1.3 ms]
  Range (min =E2=80=A6 max):   133.8 ms =E2=80=A6 142.8 ms    20 runs

After patch 2:
0071.12: llist_mergesort() unsorted    0.69(0.00+0.04)
0071.14: llist_mergesort() sorted      0.41(0.00+0.04)
0071.16: llist_mergesort() reversed    0.41(0.00+0.07)

Benchmark 1: .\t\helper\test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     138.4 ms =C2=B1   3.1 ms    [User: 2.9 ms=
, System: 1.9 ms]
  Range (min =E2=80=A6 max):   134.3 ms =E2=80=A6 144.0 ms    21 runs

After patch 5:
0071.12: DEFINE_LIST_SORT unsorted     0.70(0.01+0.04)
0071.14: DEFINE_LIST_SORT sorted       0.40(0.01+0.03)
0071.16: DEFINE_LIST_SORT reversed     0.40(0.00+0.04)

Benchmark 1: .\t\helper\test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     119.2 ms =C2=B1   2.3 ms    [User: 0.6 ms=
, System: 2.7 ms]
  Range (min =E2=80=A6 max):   115.8 ms =E2=80=A6 124.1 ms    24 runs

So there's higher variance to begin with, and test-mergesort seems to be
held back by something else than the sorting itself -- perhaps memory
allocation or layout?  Not a showstopper, I would say, but also not as
nice a success story as given in the commit messages.

Ren=C3=A9
