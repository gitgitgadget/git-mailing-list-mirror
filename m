Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA7BC07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19F86136E
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 16:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhGOQxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:53:06 -0400
Received: from m12-17.163.com ([220.181.12.17]:35447 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhGOQxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 12:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=tGmSA
        8RdWlrNNk1X5Fmj/TauILDk6eiz7orjDjbgx4U=; b=eQub14UqkQpOQjS0Kx0pH
        hY/+mdyMxr5EZLWDGa/0nHyzb4aBduoSZ8T+ymmphegbQm4AwjF1V0Lgeu19Sh1m
        mS0z5jOWmwGojyQOIn4bGz0tcC9sQY18sgLHQ19RWfIwppMSz/NxbMZX7gfgLjLf
        PSPfASxAxwMrAu0Y+7avCY=
Received: from smtpclient.apple (unknown [60.176.228.14])
        by smtp13 (Coremail) with SMTP id EcCowADn97P2ZvBgMgzSAw--.12247S3;
        Fri, 16 Jul 2021 00:48:55 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2] packfile: freshen the mtime of packfile by
 configuration
From:   Sun Chao <16657101987@163.com>
In-Reply-To: <YPBlbNRoupMtT2dg@nand.local>
Date:   Fri, 16 Jul 2021 00:48:54 +0800
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B70F549-6A11-4FC7-B21F-C7FB014820CB@163.com>
References: <pull.1043.git.git.1625943685565.gitgitgadget@gmail.com>
 <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <87wnpt1wwc.fsf@evledraar.gmail.com> <YO5RZ0Wix/K5q53Z@nand.local>
 <ACE7ECBE-0D7A-4FB8-B4F9-F9E32BE2234C@163.com> <YO8XrOChAtxhpuxS@nand.local>
 <ACFA1FCF-3F24-470D-A3AE-DBAA269E9E2C@163.com> <YPBlbNRoupMtT2dg@nand.local>
To:     Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-CM-TRANSID: EcCowADn97P2ZvBgMgzSAw--.12247S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF15CrWxWr1fXF4furWDXFb_yoW8Ww15pr
        Wftr42krWkArs2g3W8Zw4xXr1rtws3G3W5Jr98JryUA398ZF1xKrW5Jw4FvFW5GrZrCw45
        XayFqFykCFyDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-TmfUUUUU=
X-Originating-IP: [60.176.228.14]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbi6xfQglXlw0deHQAAsZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> 2021=E5=B9=B47=E6=9C=8816=E6=97=A5 00:42=EF=BC=8CTaylor Blau =
<me@ttaylorr.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jul 16, 2021 at 12:30:18AM +0800, Sun Chao wrote:
>> I'm sorry to reply so late, I work long hours during the day, and the
>> company network can not send external mail, so I can only go home =
late
>> at night to reply to you.
>=20
> There's no need to apologize :-).
>=20
>> Thanks for your reply again, My explaination for 'why the mtime is so
>> important' lost some informations and it is not clear enough, I will
>> tell the details here:
>=20
> Let me see if I can summarize here. Basically:
>=20
>  - You have a number of servers that have NFS mounts which hold large
>    repositories with packs in excess of 10 GB in size.
>  - You have a lot of clients that are fetching, and a smaller number =
of
>    clients that are pushing, some of which happen to freshen the =
mtimes
>    of the packs.
>=20
> ...and the mtimes being updated cause the disk cache to be =
invalidated?
>=20
> It's the last part that is so surprising to me. =C3=86var and I =
discussed
> earlier in the thread that their understanding was that you had a =
backup
> system which had to resynchronize an unchanged file because its =
metadata
> had changed.
>=20
> But this is different than that. If I understand what you're saying
> correctly, then you're saying that the disk caches themselves are
> invalidated by changing the mtime.
>=20
> That is highly surprising to me, since the block cache should only be
> invalidated if the *blocks* change, not metadata in the inode. It =
would
> be good to confirm that this is actually what's happening.
>=20
> Thanks,
> Taylor

Oh, Maybe I didn't understand caching well enough, let me check it =
again,
and thanks for your and =C3=86var's answers, they are really helpful.


