Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C8C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 15:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiKBPLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKBPLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 11:11:21 -0400
X-Greylist: delayed 300 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 08:11:19 PDT
Received: from mx5.spacex.com (mx5.spacex.com [192.31.242.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C4319288
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 08:11:19 -0700 (PDT)
Received: from pps.filterd (mx5.spacex.com [127.0.0.1])
        by mx5.spacex.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2Dqfmg000683
        for <git@vger.kernel.org>; Wed, 2 Nov 2022 08:06:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=dkim; bh=/aIcry7wl/lPyxt+pHkxMwdMDQkTj8IpDZKd3pS7+N0=;
 b=KCRcOU4584+NLHnH/w3WHkzr0NF3+jA9VVJoXXXP9OiQ2KgsCd0huRpOoDDvrMbS490P
 zdtU06owOBEyn6Xu3l7ZOsspVPJv6zbK5kPAZQfmDVydNk17TA2wIPX0/Nn7hO44y6Da
 9mRoeUF2YblWxXobGHWBa/eJ7CGgBuarUD5G17oHGWNQQb9Ws4rlumS9Y2D1J0+i3Yr4
 CTYrGCoacWdKyRfaEfFs1EmycR9rewRqx/65RscwXyPbuqRCEsm1KNwHZ+oZJsmESmU7
 JKZP04ntCeiimz6/0sbWteTlwq+O3334W6gR8px4rxZpnKBG/vF588GJnUsAAMg5mszI XA== 
Received: from smtp.spacex.corp ([10.34.3.239])
        by mx5.spacex.com (PPS) with ESMTPS id 3kh1kjqmf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 08:06:17 -0700
Received: from ht-dc-ex-d4-n1.spacex.corp (10.34.3.239) by
 HT-DC-EX-D4-N1.spacex.corp (10.34.3.239) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 2 Nov 2022 08:06:17 -0700
Received: from ht-dc-ex-d4-n1.spacex.corp ([fe80::64d9:15b6:163b:e2f2]) by
 ht-dc-ex-d4-n1.spacex.corp ([fe80::4adf:37ff:fe24:4641%8]) with mapi id
 15.01.2375.032; Wed, 2 Nov 2022 08:06:17 -0700
From:   Stephen Loftus-Mercer <Stephen.Loftus-Mercer@spacex.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: bug report for "git status"
Thread-Topic: bug report for "git status"
Thread-Index: AdjuzJyyuoXgqqsIQIeOuz0G/TOv1A==
Date:   Wed, 2 Nov 2022 15:06:17 +0000
Message-ID: <84cd66d955ed4188aad093cc306080d0@spacex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.32.161]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-GUID: 2xF7ddRDqTQMBNesik5jFCANGUYmhYMG
X-Proofpoint-ORIG-GUID: 2xF7ddRDqTQMBNesik5jFCANGUYmhYMG
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211020097
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Two git commands that should be identical produce different results.=20

First command:
> git worktree add -d "c:\temp\junk\blah" 209134fc8f
> git status

Second command:
> git worktree add -d "c:\temp\junk\blah"
> cd "c:\temp\junk\blah"
> git checkout 209134fc8f
> git status

Full details discussed here:
https://stackoverflow.com/questions/74237452/why-is-there-a-difference-betw=
een-git-worktree-add-with-checkout-and-git-chec/74241950

What did you expect to happen? (Expected behavior)
I expected both "git status" calls to be identical results. They are not.=20

I expected that both would output the following:
> c:\temp\junk\blah>git status
> HEAD detached at 209134fc8f
> nothing to commit, working tree clean


What happened instead? (Actual behavior)
The first worktree command, the one with the commit hash in the command, ga=
ve this status instead:
> c:\temp\junk\blah>git status
> Not currently on any branch.
> nothing to commit, working tree clean

What's different between what you expected and what actually happened?
I do not understand why the first command has no head. Worse, why does it h=
ave no commit listed at all?=20
Clearly HEAD must be on *some* commit -- my workspace is synced to some set=
 of files!.=20

Anything else you want to add:
The Stack Overflow post gives a reasonable explanation of why this happens.=
 I think the difference is irrelevant to most users. I would prefer that bo=
th commands result in the same result. If that is impossible, I would ask t=
hat at least the "git status" command be amended to ALWAYS include a commit=
 hash since that's the primary way to figure out which files are currently =
synched in a directory.=20

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.36.1.windows.1
cpu: x86_64
built from commit: e2ff68a2d1426758c78d023f863bfa1e03cbc768
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19044=20
compiler info: gnuc: 11.3
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
