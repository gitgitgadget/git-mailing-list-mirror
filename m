Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174A5C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B9860BD3
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbhHTPix (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:38:53 -0400
Received: from mout.web.de ([212.227.17.11]:54199 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241129AbhHTPit (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1629473877;
        bh=8GWJ/jQZISgDkYArZzYN2AXPeORkREvCyiA/yMRMaIA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BvU1+puLSfZALQdf1TkDjIVQfwDM5/+aOeBNYDqcBr32IvBYlrl2QV1g4aRieVOeg
         X9ODzgkrdculJHg+HWViOESNzttmnUnpKKARJ1JaScmD62GsV8OVTRthIEiuRAda9Q
         oN2P3cSSD10XQN1dDz9hi5/A5zI3GtByebU/AbiI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtyA2-1n4NpJ2vGO-00uKwY; Fri, 20
 Aug 2021 17:37:57 +0200
Date:   Fri, 20 Aug 2021 17:37:56 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jonathon Anderson <janderson@acesquality.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: Git Modifying DLL
Message-ID: <20210820153756.c7b2d5zju7mkf4w5@tb-raspi4>
References: <CAG83euoGmVUUBh00wAEX1muZogNPOQUV6+ppL8x8qCaDnzTbDw@mail.gmail.com>
 <010f01d79525$f10a1f60$d31e5e20$@nexbridge.com>
 <CAG83euo2B4QFU_S6Yqd3UACWq63p=L+T30CwzT52D8H=S5pRVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG83euo2B4QFU_S6Yqd3UACWq63p=L+T30CwzT52D8H=S5pRVg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:iBSLyxUSPcRDEw78/y+c0TAhWNjIL+/+zeW6tkdIaUMaPQ+D+mb
 I01mXs7cAZ3sVEs1Vx1miPW1/v9Lq8f/qPlYIAsJ46ex4WzCdWZ9upt+MZ/ANE7nKdUCpSd
 /pOC/KU4yern/rxQT/KE00W8YRvDmltDoNvkvQJckDVe/aBvf9bORVqGlLHYFiIsQbKif1N
 4IEY8+FSiwn7XltkFf1Hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iwAd8VNWDGs=:jfyA7l4+fngLTNGhp7jc3b
 yjTb6A6ubh8sn38fx+q0DrVeP6i3ljJbaLgYT2AQRYE5828fK0M1recC4jHjRiDWvKzRnkyCD
 pC2/4ZyvqcSg0fov+USom0ZyvAyGQZ5IxySYl9E3MmVMFrJuV4+qSLLZm+uAQkU47c/tUpsG/
 zoVaoBerwbAzayNJb4RedLEoNQGHdoNzAWwHEt2Y7hoPG8w4Sh4/miSlke4ctgg4NN6aPCJ94
 YtrANH8D8fSed2qA3lwM/ZSaY1IqkzXQVJMA86F+Sw1uL9AdD8cURcKk5s4Ii9Aw3FcOyPUh/
 p+O4ZoqHOeewUibXWtOnCX1WiLYS+IhERJgMaKPTK0rr8t83hSNTalaDtOYLrAExLA6Vts5s3
 rh7egS7QsfOfuUVUIpaV3NcGJUA3eCvnkgaGeJqZgmyslCSLWoyhOOMqZ4ET2axVJCVZtM9IT
 M0W/yN49SWZVkMzapAeQi5SWVsGNe4JtD1IdEuCUP1mhoZjF5ngI96azPmSz3P51/KYHBIjFV
 9jSPTczS2cMaNpSaYpWtZWSsuutfDACEfRwOZ3A6gUvZgpsoefp5w5vQmGT/eTUvkwojxS9ip
 PC82iMled/pizhyAkFaW7rVFu+ycKCPUjTvQJCpg5S+C4J1QnuB8YwYdZ2t5Y6+Qzvupew3Tl
 isfPy0l7PJn0I28Bp8aCX5ZA4/6F8fiXnO/qaR1fifqLYI+yaN6AVYBIXFK126sSbfEXYFPbx
 BqqzX+lZkCF+B+hsSCkpq/xaykojhvx8WVpyO79/EpkTdpbO0lUZedyGDaNX3iGDfnKi6m0c/
 DWj+2312nHcHhFwFfNPFIjxong4+6TsXSoYm04eM262gvFCfL+NqXoUhbGlgojrKu7bzwH8e0
 2cwiZgl9JWK7bCb8o7v5+xE4uTIaiamT0grU80NdSOa/SqHRMpSL0nTzrG1usroeQt2AeJ1Sb
 6+yHGfTYfE4jBAI9xM/cC4myf+G1G60mSP39L5mhELHPyXXXHQGM1yHRNb+NewoqbLYuJzRVN
 cQkMA0f+j6bNg0RpYnL+kL5D5v6yYIGBqkS0TVQRRgVwhIh94hh+ZK8IBVwl900I5ghuK77Aq
 WZoeLzz4OfcsofG/796Zco7OIQSRm1Bq9D2
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, thanks for the report.
(And please, no top-posting in this list, see my comments at the end)

On Thu, Aug 19, 2021 at 01:21:03PM -0500, Jonathon Anderson wrote:
> I had not. I tested that and it worked. I assumed that git would
> automatically treat dll files as binary. Thanks for the help!
>
> On Thu, Aug 19, 2021 at 1:13 PM Randall S. Becker
> <rsbecker@nexbridge.com> wrote:
> >
> > On August 19, 2021 1:59 PM, Jonathon Anderson wrote:
> > >
> > >I'm having an issue with git modifying a DLL file and corrupting it.
> > >When I download the original working file, it has a hash starting wit=
h 8FE400... I then commit the DLL and push it to our repo. When I
> > >download the file from the repo, the DLL can't be loaded, and it has =
a hash starting with E004FB...
> > >
> > >Opening the DLL in a hex editor and using the compare feature, there'=
s a single change to the file. In the original, the byte code starting
> > >at 0x0074 is 2E 0D 0D 0A 24.
> > >In the git file, the byte code starting at 0x0074 is 2E 0D 0A 24
> > >
> > >A single carriage return character (0x0D) has been removed, and the f=
ile size has changed from 260,608 bytes to 260,607 bytes.
> > >
> > >I ruled out the possibility that the repo server was doing anything t=
o the file because I deleted the file in my local repository then ran "git
> > >reset --hard HEAD" to restore the file, and the hash had once again c=
hanged to E004FB...
> > >
> > >OS: Windows 10.0.19043 pro
> > >git: 2.32.0.windows.1
> > >
> > >I have no settings configured for git behavior handling line endings.
> > >
> > >The original DLL can be found here:
> > >https://www.powershellgallery.com/packages/PSWindowsUpdate/2.1.1.2
> > >
> > >Navigate to "Manual Download", download the nuget package and unzip i=
t. The file is PSWindowsUpdate.dll
> >
> > Have you set up an entry for *.dll as binary in your .gitattributes fi=
le?
> >
> > -Randall
> >

I downloaded the dll.

I can not reproduce the issue here - so I wonder, what is going on.

Could you run the following experiment, please ?
(in git bash or so)

mkdir  dlltest
cd dlltest
git init
cp whereveritis/PSWindowsUpdate.dll .

git ls-files -o --eol

# I get
git ls-files --eol -o PSWindowsUpdate.dll
i/      w/-text attr/			PSWindowsUpdate.dll

This means, that the file is "classified" as "-text" in the working tree.
"-text" means the same as binary.
And git should not change CRLF at all.

Do you have any more .gitattributes in you repo?
Of course, you can run the command inside your repo.
Omit the "-o" for other and simply run
git ls-files --eol


