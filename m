Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B06C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4E961423
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbhJEUae (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:30:34 -0400
Received: from mout.web.de ([212.227.17.11]:47067 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232250AbhJEUae (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 16:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633465720;
        bh=LT+cgJcg9vawQG2QnNYAfvXu1KCFg2d4YurjJqA6NmA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=SV4/S03sp7CZv/d7WoacOXLptj4D/2VQRpd6Siz3pYSir2Ii8X6AeK9D+Q/d24PfU
         pKZNBjik6yZmShO0bWqZb7s49hbg1NY8Y5jXIkW8Xcpu1vvA6l4AX+8v+XiUTlhBOK
         qrdddbVm4CjeTItJgbKf3aYlmyeRMA7f3pghM9Jo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Meje0-1m9iSG3JXc-00OCYT; Tue, 05 Oct 2021 22:28:40 +0200
Subject: Re: p2000 failure due to empty reflog
To:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
References: <b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de>
 <30df5e39-3f2a-00d8-541b-347c43f36b38@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <581663a7-9b16-e464-ada7-368f20c99ff1@web.de>
Date:   Tue, 5 Oct 2021 22:28:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <30df5e39-3f2a-00d8-541b-347c43f36b38@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nzhq2x7dg/jThd8bip2aPGc70DEcCz69dqeT1a7vb5NOOCOA68J
 UI45WmbNkhUOu7V6rWWnO1fvJMAu5Jp1C3ujV46aNlplZmTTjx/uN+SNos+HqcTk0kzitJQ
 VWEXRsbt4BVgKfQoNhBdaVMcSMcvJALCz34dov7+kyGlRTYGExhqC/FQkZJC7CecVBgXnuL
 tWLyzjeIWhRg6xoKMpH4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3u8rqWiAhPY=:ZRcUJiFCuLA/yQLTccTIEo
 16aRzh4OsFzzijRW8JP1tpu+CZsRSjS0FA7SE/Le/uVjuCKMTpflXJUgwH2z8wQ5Ke57mt2XY
 aiCF31LLmB4HGowu14iXoaRbVx3BKhXMgXkxYrGzgN6cLRlN2IkoGyhwxyFligZKodqSngfew
 K3rmfi7+e75moGHzW0w77RjshHrZYP0ahEuDWgeJ7XlSGw9AuO31ZGIJnQhf9ngaPFLHE3mNp
 ExAhIsNiDjrMKy8bfVapS/go2DJ6Mq8teM1DF6QPkm1/A3t7t8vf0kDQb/pm5APNQ396n0AVt
 7MPBNjkZxWBkKgDOsKWHDFvaMs3McXLaKDZbINfnofH6dN+sx5ys8i7ntE3xLoOxJ2q0TIqmD
 5u8GajsxOtI2IkAraNLlvhQj5+aHJZjM+tjZY30zp9/ydVa6IuyYlJLZfA1cQRyO3iTSJDXME
 5s8eayb0UPFa12v+4qGE+4MNdEY4RmJmp7YCm5sxIdHbtqYFTXcX5a8vZa2w6S/thVWoGICLi
 f0MrByWTcCYWBkgHiJJkwxGvpufB8pOTr/3jAdNYZd+CWtBGxC7VgHntGSAKBxpWFNvWIOLnq
 BLHUvYcnLW6Y2KlKSdfBNLTUB1cRMvQd0friLil+qTnSRVcY0w7kpv9uaklP0Wnv5ZAP1dNiC
 jMBuq5PB9blaTn6oVAyQ4PtUF7PlxF3dL0yboY/ps+gpFP2mgHUV4nuIIalUCMoBeGgePHSSJ
 nCdbzeCAhVwwlcC3y5qTnN+r4TFQTVMZclC5fD2UK/2X/XKaAby6QURlPQ3wPQz2EKfNp0hwT
 hHmvLb8m/fAQ2b8tCQ24pnj/A88MQ0WO3+M+jNhDOTCwWu1PMdUzZRh1BWht5uFwofkV7mb/r
 ze5fsM7lvHuR4wfZ9F6wavHDzq9XXnwdEPZuguvPrTYpgF+aLPQH6gWXdEbaup8AIQ36yYyIf
 pyHckFXGeuiLG6bCazznp9QRQlUsivRFQ53/IDFxndsoUXMAxf5cXyRdDMRvwa6+CQ1ZxgTlR
 DiHPDEInvdUrhDkI6LHV0sB2aiBFvwjp57T4vg5dalCoTz/gWSLsqnGn3alDBYnLTCU4pk3tr
 aXbYizO/tL8CRg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.10.21 um 21:55 schrieb Derrick Stolee:
> On 10/2/2021 1:37 PM, Ren=C3=A9 Scharfe wrote:
>> p2000 fails for me and reports:
>>
>>    perf 18 - git checkout -f - (full-v3):
>>    running:
>>    			(
>>    				cd full-v3 &&
>>    				echo >>f2/f4/a &&
>>    				git checkout -f -
>>    			)
>>
>>    error: pathspec '-' did not match any file(s) known to git
>>
>> checkout fails because the reflog is empty, so the "-" can't be
>> resolved.  The pathspec error message is confusing, though.
>>
>> The patch below adds a reflog entry and allows the script to
>> succeed.
>>
>> Before the "test_perf_on_all git commit -a -m A", there are two
>> reflog entries in each of the five clones, after it there are
>> none.  How is that even possible?
>
> That is certainly confusing. Is there something about your global
> (or local to your test repo) GC settings that cause an auto-GC to
> prune the reflog aggressively?

Good point.  I have gc.auto=3D0 in my config, but the tests use their own,
empty config.  A trace shows that "git gc --auto --no-quiet" is started.
The following patch turns that off and allows the tests to succeed.

Not doing maintenance in parallel to a performance test is a good idea
anyway, but I still don't understand why it would empty the reflog --
that seems excessive, dangerous even.

One of the maintenance commands from the trace is "git reflog expire
=2D-all".  If I put that in before the "checkout -" test (on top of the
patch below) then the reflog is emptied again and the test fails.

Ren=C3=A9

=2D--
 t/perf/p2000-sparse-operations.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-opera=
tions.sh
index 597626276f..9a06904247 100755
=2D-- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -105,6 +105,13 @@ test_perf_on_all () {
 	done
 }

+test_expect_success 'disable housekeeping' '
+	for repo in full-v3 full-v4 sparse-v3 sparse-v4
+	do
+		git -C $repo config gc.auto 0
+	done
+'
+
 test_perf_on_all git status
 test_perf_on_all git add -A
 test_perf_on_all git add .
=2D-
2.33.0
