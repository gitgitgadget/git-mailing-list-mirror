Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6730C35253
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0681424741
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="J1ZAwCoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfLMNly (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:41:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:55283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfLMNlx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576244501;
        bh=Nk6SwnvTuvDjbUJ6v5O0XTVH4a+isDuWAAa9Tk4fSJY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J1ZAwCoImQ2JNPKTvzxsOPvHRyTgcq/pLiNTw9ZDzZLdwQXPOYBiTZ2t9C6ZZQUG6
         WlbTfvHISVGRS1rXEJDEilRWVGNRqGe3rdr6v3BKV3KtxqXljdJUjp1taJYINauMhf
         Z0YV5Oy3xynhmpzOutA7Ru3pAPwDiBfFD8Rqaeqs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4z6k-1hhE6D1HuO-010tZV; Fri, 13
 Dec 2019 14:41:41 +0100
Date:   Fri, 13 Dec 2019 14:41:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tom Clarkson <tqclarkson@icloud.com>
cc:     "Strain, Roger L." <roger.strain@swri.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "marc@msys.ch" <marc@msys.ch>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
In-Reply-To: <5C8CA727-370E-4CEE-BBF9-F336C5921D98@icloud.com>
Message-ID: <nycvar.QRO.7.76.6.1912131440400.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1912091615200.31080@tvgsbejvaqbjf.bet> <7E95BE86-BD96-482F-9ECA-DBDD9C10D114@msys.ch> <nycvar.QRO.7.76.6.1912092037540.31080@tvgsbejvaqbjf.bet> <D99ED706-EC49-4A52-8186-5C9B0B5BC744@icloud.com> <038c72f0349174bb92e1dd9c3b38f02543ba1d95.camel@swri.org>
 <5C8CA727-370E-4CEE-BBF9-F336C5921D98@icloud.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2136843227-1576244503=:46"
X-Provags-ID: V03:K1:GZmGReBKa8jGoIYpdrWRgBxCeun6KO1Hv99r71UA9CWzcgnvkkH
 yeQSeIY6x2ALWR7AZGKEzxXN8PK/u+8XPjxEx3+8D8v5Bin/Ax+3HDsrLhD0kvHznqeMb7o
 KllSgk+yX4egcW9OJPb0Ddnha9JHk6nzJPLcjEQ1OWNF6IZjkR/vv18Mb2m8Al7nN3o13e6
 DfC17LMp89jLtIGo9B3RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JAVAoHqvlGM=:Xook2OJ/rZPuvrYgZkfCXn
 vn6D7wwjXWxUWgqxgATuqDGR2DZKoyFXq7Cjq0KxFhoh4/t1kDAJT7sY0ZENAJUZTHILtiImv
 8bW5hw8OFfPzf8FdA721Z6EGeFdirkuI1uI9pqFdEkstQQiclbmDYTLFeGZn1jGRwSfFNO/a3
 3EQX88GwjB+2GiXjIG3E53m9tnKHRcKGhF7BFaEl/g/ClHjqIiyuJ0tSlecYZdqUrJL4rFsXh
 B/W61kMIqo1+P7EwePJozpUWiaF2C/fe5/yBQ/VuacuDsifygImG0G1wqxosFzinrRZcvtu1G
 4lsZntw1AXVtFNl9o9qgKiAMV/WoI/DebpIVcbx/CXYrN57A7RzsR7n6trShz7YbJIhMiRci2
 zDTT3KTrM39rIl/DhImP6rlWgGlffDQ/lh6IIlBmAIvs2YaOHPWm//RxviVO3tkiAyNKY0cWH
 bsk3RLLAC24dnOoyjkDXTey3eOQLCJnrGKjl2GRU5StYZEGbVew4SU99gSUa7PfFFLpcU/ADj
 wIg6SZHjMdYxs8u/b2l+56ORXjd3QCxWpjkSyxzDwEYq/kXdAK2VtRDQHyFtZOuw8TAfNhOoA
 ZN1pHpkM8sH3WUtJW0sgesXHwRO0i6Lm7SwRdAJsvw2HDybbke6PXQeE6WeX3+h3VI84H/s0u
 jxti3Dlv2EjksPoScwkTkWXAzrZIICBf/jpIzw97JrIAMkKt87z1zS3D1CFWx/Xi9dkJFFrQk
 t8e1jMdgNJGpmQP/HPeoTs/dAcrF+JmnjTXq5zINgoM1znyKVvkBR/Gjk3BMoH+ngR2QIgoes
 rZVQLEIaVE3jWK1CMll1q6hBGgd3eNPg8TWZCC5nDaBJPt+qtbaCl2Xfx9Q/Z2Xm1K/lEH8AG
 9U8vW2pGS8sW0+RN5AtofI21RQm7O7tBJ6Jgb59dCMH2SyzVplauiBRoGU23b9xEAOkxZt+cM
 1fSRLM00L4/mOTp1fQ9wSMQrMnw2xORRKkomdp6M5UO7d62wjGnmhBp3AsPIX7U4r8OUVT6fd
 v0nCLgFX2QXkwlxpBpEboQrcawj571+E8g7xfGcGR/zAO1LW3A83SMH4v5EqazEYnOps6K5iu
 HTSPkXMh6MTFeE0049vSv/uOMaATffdZV4o0zrOOiOofbyMWvkAflL/rwdh7plKBi15DUIqYL
 Qs3cxxSqeOSqkySKjVS+svULB2Kb/bWdgfSlWmDLeuKMldPt7HyDy3BhyuHs0+EFL0zpcy4UB
 3V8JsgZGk4vnCV2zI9AuCA7RR+y4zYJr3szWhw+xWdqSTh2kZqAEc5r37Sqk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2136843227-1576244503=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On Thu, 12 Dec 2019, Tom Clarkson wrote:

>
> > This makes me wonder if the problem is perhaps related to the hardware
> > involved; maybe the algorithm is doing exactly what it should, but the
> > available RAM isn't sufficient. If that's the problem, perhaps we coul=
d
> > find a way to perform the recursive work without using actual
> > recursion, reducing the number of instances on the stack.
>
> It=E2=80=99s not so much hardware as OS I think - After adding stack dep=
th (the indent parameter on check_parents) to the log, I have been able to=
 get different results with ulimit settings.

Do you mean to say that the stack overflow is reported as a segmentation
fault? If so, that message was sure a red herring...

Thanks,
Dscho

>
> With the default stack size on macOS of 8MB, It falls over at depth 445.=
 Being less than the shortest path to the root commit, that matches my ini=
tial count, which was just the number of lines in the log.
>
> Reducing the stack size with ulimit -s 4096 makes it fall over at 225
>
> Increasing to the hard limit of 64MB should allow a depth of around 4000=
, and as it turns out that did allow the script to complete, reaching a ma=
ximum depth of 1148.
>
> I=E2=80=99m not seeing any issues with the hashes being wrong (all show =
no parents or subtree) but processing all those commits that resolve to no=
thing does take forever.
>
> The mainline commit test seems to work ok on my repo, but it=E2=80=99s f=
airly easy to see scenarios where it would break, such as having a  subfol=
der with the same name within the subtree.
>
> So while part of the fix will be a more reliable test, it also needs to =
work before parent commits are processed to mitigate the recursion issues.
>
> The rules I have  come up with so far are below. There are still scenari=
os where the recursion is unavoidable such as running an initial split on =
a large repo, but that should be much less common than using a small subtr=
ee with a more complex existing repo.
>
> In the initial setup of cmd_split, collect some extra information:
>
> 	- Add rev-list of all git-subtree-split values to the cache. I=E2=80=99=
d expect subtrees to usually be smaller than mainline, but since we can do=
 that non-recursively we may as well.
>
> 	- Find the git-subtree-mainline value from subtree add/rejoin. Anything=
 in its rev list should only be reachable by mainline commits. If not (whi=
ch probably requires doing something convoluted like having subtree includ=
e mainline as its own subtree), this is a good place to check that and fal=
l back to the existing behavior.
>
>
> When processing each commit:
>
> If no prior splits were found, we only have mainline commits.
>
>  	- If $dir exists, it is a mainline commit needing copy - use existing =
process.
> 	- If $dir does not exist, it is a mainline commit that will map to noth=
ing - no need to process further.
>
> If we do have some known subtree commits:
>
> 	- If it is in the cache, it is a subtree commit we don=E2=80=99t need t=
o process further.
> 	- If subtree root is not reachable (rev-list or merge-base), must be ma=
inline pre subtree add. Map to nothing and skip further processing.
> 	- If any subtree root is reachable, could be either mainline commit wit=
h subtree merged in, or subtree commit newer than the last add/squash (sub=
tree pull/merge without squash does not use a custom commit message)
> 		- If $dir does not exist, must be subtree - add to the cache as mapped=
 to self, no need to process parents.
> 		- If the folder does exist, it is  either a mainline commit to be proc=
essed normally, or a subtree that happens to contain a folder with the sam=
e name.  Check if mainline root is reachable.
>
>
>
>

--8323328-2136843227-1576244503=:46--
