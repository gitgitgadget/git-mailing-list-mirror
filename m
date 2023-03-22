Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E829DC76195
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 18:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjCVSzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 14:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCVSy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 14:54:27 -0400
X-Greylist: delayed 349 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 11:53:41 PDT
Received: from st43p00im-ztfb10063301.me.com (st43p00im-ztfb10063301.me.com [17.58.63.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58BF6505B
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1679510870; bh=zxcps7qNbVVizxhvAhh9/iCyekK0kKE3s2L1siz8w2g=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=MDVOkWP8LnpQeG/RwN66LADb04c8V7h5RYFbBWkii1ygaFK/dJBHDVQoqoR7c0Ffn
         dFAkMqy6ypY/n1K5w8Y2i1vcNdvf3moNCnGzv5/as6MpbMRHEbOHbQ3nshxYeloHWV
         Bhmi+rooK+TjPmwCyaP9wcCAlxWCyRfq/qhW5xTuUo7SnZn4erHvcg065aE6duUqWK
         btYrzEckewMbFEGAkXUtsNKdtX+N08NKmf8/1oSU3klO8jIZWNDpknVw3anNFbFgTH
         sBjfeHe7miQhY+zuV+uLHMmuTvvk/4WFLYfbHkG6zbM+3aXNHlwn7nyXtn63i5HI8e
         syWdaHynFxqwg==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztfb10063301.me.com (Postfix) with ESMTPSA id EBDEC701D0C;
        Wed, 22 Mar 2023 18:47:48 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: BUGREPORT: Modified files on a fresh clone on M2 MacBook Pro
From:   Sjur Moshagen <sjurnm@mac.com>
In-Reply-To: <73af529d-e918-445d-b0ee-9506e28188af@app.fastmail.com>
Date:   Wed, 22 Mar 2023 19:47:35 +0100
Cc:     Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <68ACFE61-5D19-43D8-887A-7150E8B90BDB@mac.com>
References: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
 <CAJoAoZkKTGzgVyL2wM9a4VcFObx4YpjMSatH9Bpqcgyi=zzBrQ@mail.gmail.com>
 <3FC6072C-5856-437F-9B4F-BC182921426D@mac.com>
 <73af529d-e918-445d-b0ee-9506e28188af@app.fastmail.com>
To:     Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Proofpoint-GUID: cgTfQ630wJBjZB-TCqk-JIok1bH9Vi4w
X-Proofpoint-ORIG-GUID: cgTfQ630wJBjZB-TCqk-JIok1bH9Vi4w
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2020-02-14=5F02,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=743 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303220131
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

22.3.2023 kl. 19:22 skrev Kristoffer Haugsbakk =
<kristofferhaugsbakk@fastmail.com>:
>=20
> I still get a dirty working repository after a fresh clone (on Linux,
> git version 2.40.0) on your commit 6425cb09a8d0 (Apply changes 127,
> 2023-03-22):
>=20
>    $ git status
>    On branch main
>    Your branch is up to date with 'origin/main'.
>=20
>    Changes not staged for commit:
>      (use "git add <file>..." to update what will be committed)
>      (use "git restore <file>..." to discard changes in working =
directory)
>            modified:   "corp/SN\303\205SNINGEN 2014/43 =
uke/N\303\246ringsliv.doc"
>            modified:   "corp/SN\303\205SNINGEN 2015/26 =
uke/\303\230lsamling.doc"
>            modified:   "corp/SN\303\205SNINGEN 2015/38 uke /SAK1 =
-s\303\270rsamisk.doc"
>            modified:   "corp/SN\303\205SNINGEN 2015/38 uke /SAK1.doc"
>            modified:   "corp/Sn\303\245sningen 2012/20 uke/Artig med =
animasjon - samisk.doc"
>            modified:   "corp/Sn\303\245sningen 2012/20 uke/Artig med =
animasjon.doc"
>            modified:   "corp/Sn\303\245sningen 2012/4. uke/Mange vil =
l\303\246re s\303\270rs/Mange vil l\303\246re s\303\270rsamisk - =
saemien.doc"
>            modified:   "corp/Sn\303\245sningen 2012/4. uke/Mange vil =
l\303\246re s\303\270rs/Mange vil l\303\246re s\303\270rsamisk.doc"
>            modified:   "corp/Sn\303\245sningen 2012/4. uke/P\303\245 =
sameskolen/Det er p\303\245 sameskolen jeg f\303\270ler meg hjemme - =
samisk.doc"
>            modified:   "corp/Sn\303\245sningen 2012/4. uke/P\303\245 =
sameskolen/Det er p\303\245 sameskolen jeg f\303\270ler meg hjemme.doc"
>            modified:   "corp/Sn\303\245sningen 2013/50 uke/Dramatikk =
og kj\303\246rlighet - S\303\270rsamisk.doc"
>=20
>    no changes added to commit (use "git add" and/or "git commit -a")
>=20
> Note that this `doc` extension was not covered by your update.
>=20
> But it becomes clean if I remove this line:
>=20
>    $ git diff
>    diff --git a/.gitattributes b/.gitattributes
>    index bbd8c0db810d..3959fefadfc1 100644
>    --- a/.gitattributes
>    +++ b/.gitattributes
>    @@ -2,7 +2,6 @@
>     # DO NOT EDIT - the file is updated via the template system.
>=20
>     # Some defaults:
>    -* text   eol=3Dlf

Thanks for pointing this out - git status did not return these files for =
me. Also interesting that you got it on a Linux box, that has not =
happened to us, cf earlier email in this thread.

I will add this and other missing extensions.

Best,
Sjur=
