Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FC7C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFDAA613DB
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 15:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhKSPrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 10:47:09 -0500
Received: from mout.web.de ([217.72.192.78]:49571 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230133AbhKSPrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 10:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637336646;
        bh=Vqg6S79eI18VntTUG0k6JJ6nnXEdpkKWQTmFkaJhgYU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=j79ljbLS1aZxdzMKA4oSmKbTDek1CdMIdnmLc5IlZjSAz+8ES5FczvQuq4mEp1MXk
         aXCX4atHhLQciU8HEc2O5+xfGm1zsFj9AtACuUNAuA7V1zwMUQGyhqdh5aKNnq+mik
         /je+NGkGoT75eNk2nPoPkpwNcON9wEKLbceGPJS4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk4e-1nG7J949QQ-00TfCo; Fri, 19
 Nov 2021 16:44:06 +0100
Date:   Fri, 19 Nov 2021 16:44:05 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [Question] Unicode weirdness breaking tests on ZFS?
Message-ID: <20211119154405.xhoqfh3vmljxbh5c@tb-raspi4>
References: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
 <20211117161226.xcat77ewhf5inaif@tb-raspi4>
 <20211117170613.kyoe6ov2m5wi2i56@tb-raspi4>
 <20211117173924.maporsti5cz2ixsu@tb-raspi4>
 <8a3d0d0e-cc82-b696-00f4-b71e6452e1bd@gmail.com>
 <5d1b5ce6-d9ff-1b2a-2ff2-19813c957a24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5d1b5ce6-d9ff-1b2a-2ff2-19813c957a24@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:ggNotp7oDlcVKU/9JM3Uwl1PWnP4epFS+3FQWNNmZAAKFccD8f/
 7F8DS9PL1ZbttlIQ5ZXhJdGLayd39Xid5fpagI58oRxGsUa1eZe31oVq/uChJO2i7GyEpiZ
 hqJqGt3xOphMSCSM6FdE727ePy8mQTJNzMvwYbirVdh3igShbJrn67Pq0pr/aRsuotU5Ewi
 08Pt4sTmYwr78zOvmlAKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:edBtekBNCA0=:vUgv7gb2viYacf8Ns0YQKw
 2F54tbX1XYDaFFDRtzpl8fjkC9PI61cxrWJEA0+4WyXxLNXgtfdYxEeS/szoyd8ckVn15L0EI
 WohppK/R3k0SIDi/s07/9IBvJvxsFOh+YV5Ng7BOW0/b/bDVT30aFaoj7MsE/ZvdjNHHOiH+7
 Qro8RyVTD/dgAOYOYFxmW/7hslKYwMCr6HeeIcPqAeEwSGl7riIACg2aVKcUrzPX/PV6Wfe2e
 q1mOs/jvLSgAE6EfQoF1F6nO9pMzSTcwVRcjPnDHfKgw3zhcLcF4l/doDh/BJCkMY7m8YPBDc
 YuJ9iXDIBEHQsjQB/fCYEaXg2C4838272qyqvDL6EYHELIcCm1d6m/RK9iMSa44LmlgRxLDF/
 4IK55uY3mMgav3EKCr4vIDeB/Mzb63m5Cye8oZmxfOJUaDrvsUKPDIpOXdKl0LZlHrYB3n5wx
 3L5NbCBq/EQXxo+bexs/UwsHgqP6J9lcacSpI1NlyUyBTtXpKNzD7SXehtLvhA0dYCzpkOF2n
 rxWAEDxmAkFACebp7yMIg7GIOBLwUUOBMkFu/uxRorHnwh1FcNI5NpUyOxGSv6k+GjZMAC+aI
 tMO024t5VLBNfdCgPFVbBEzsrlToP2EX9A+iNZ5AY++lbaf8Gp/F5vhBnOKTb+u6euOAxLcwS
 1JPlDlNhBu2Gc68WheNBrLqA6MwGibkgCrq+J9fJxuS4DVootOUMLBlng64SK42eQC1dgLx17
 b7S8FcBBfr+QH4GeRCj7JZjGsxgGEq7UQZPZlOy1W394qrkUxLOHTI7oWkUJBUk5img8tf6cz
 2cvyu5/KbkRGsUs1FatEruKQ/KeedTlpQ453yMW12J+DFOYTE4RV7Y0W4/Tk+NZje54Hkq9sT
 UaCpw6/t++cSQt/ODtczq4rOMIB9WXHN4s+rYYpZgbwqjNYM7Tvn65nriovozZfVH98kFAro3
 kb/BX3St+kCjyyOttrEzkCDC6AuxgZEiU/tabWeovZByMWfGLBn7TKbQkxwKgWsxRLbkYjebS
 nHf39NgYjhToOQh9WHSnoW5vN6dxglIJand9xeaL03WzniJ6bkwuAhO684mnoiKGDgkwfOFgw
 Rkyxf5uauc5hC0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 01:35:32PM -0500, Derrick Stolee wrote:
> On 11/17/2021 1:29 PM, Derrick Stolee wrote:
> > On 11/17/2021 12:39 PM, Torsten =3D?unknown-8bit?Q?B=3DC3=3DB6gershaus=
en?=3D wrote:
> >> On Wed, Nov 17, 2021 at 06:06:13PM +0100, Torsten B??gershausen wrote=
:
> >>> On Wed, Nov 17, 2021 at 05:12:26PM +0100, Torsten B??gershausen wrot=
e:
> >>>> I'll can have a look - just installing in a virtual machine.
> >>>
> >>> So, the virtual machine is up-and-running.
> >>>
> >>> I got 2 messages:
> >>>
> >>> ok 9 - rename (silent unicode normalization) # TODO known breakage v=
anished
> >>> ok 10 - merge (silent unicode normalization) # TODO known breakage v=
anished
> >>>
> >>> Do you get the same ?
> >
> > Halfway, I see this:
> >
> > ok 9 - rename (silent unicode normalization) # TODO known breakage van=
ished
> > not ok 10 - merge (silent unicode normalization) # TODO known breakage
>
> Making this even more confusing, my original output shows both of
> the TODOs vanishing, but I can't make that happen only running this
> test. However, with "prove -j8 t00*.sh" I can get them to both
> vanish:
>
> Test Summary Report
> -------------------
> t0050-filesystem.sh           (Wstat: 0 Tests: 11 Failed: 0)
>   TODO passed:   9-10
> t0021-conversion.sh           (Wstat: 256 Tests: 41 Failed: 1)
>   Failed test:  31
>   Non-zero exit status: 1
> Files=3D53, Tests=3D2896, 15 wallclock secs ( 0.59 usr  0.07 sys + 26.96=
 cusr 13.95 csys =3D 41.57 CPU)
> Result: FAIL
>

Should we conclude that the underlying os/zfs is not stable ?
Things don't seem to be reproducable

What Git needs here in t0050 is that stat("=E4") behaves the same as stat(=
"a=A8"),
when either "=E4" or "a=A8" exist on disk.
The same for open() and all other file system functions.
("=E4" is the precomposed form "a=A8" is the decomposed form,
 typically both render to the same glyph on the screen,
 and a hex dump or xxd will show what we had.
 I just use this notation here for illustration)

Should we contact the zfs developers ?

