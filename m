Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C5AC41621
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 13:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37878206F6
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 13:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="k6jCDFX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgCXNgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:36:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:54555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgCXNgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 09:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585056956;
        bh=xIr7fbY9MN3BiwOoC29Fwdw/n87ryQ3ypczCnhmrnLI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k6jCDFX2t6o95jggYAkPdS2uQEdirPLsTriTje/LRgj8gALlNKMyuI1shu+o9kQCl
         xwYGw0VJ+oAu8UQ94Cj5+J2GhFXV+kq8Ip/cyexrDgLNLrHzJsLTMlWuJlSDFpBgfj
         bufKBKB0dUO9Un6uO2pWtDWDSaZbwHGBZBFbeYgc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.32]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N49h5-1jQ3II3Wd7-0105Rh; Tue, 24 Mar 2020 14:35:55 +0100
Date:   Tue, 24 Mar 2020 14:35:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] import-tars: ignore the global PAX header
In-Reply-To: <20200323232520.GE6499@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2003241433380.46@tvgsbejvaqbjf.bet>
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com> <20200323232520.GE6499@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yywdxs3YtJ57vwKIYZd23Xh/M1/OwYUgab57ixnbNJwDgna8zsh
 +YiJ/YA1AwfYmV6mM6/ha8Hk/kEdCysbaU8Nh95+N6lZUdno37Ntz0651P+1Npj7wLHVLRv
 Vnkc/ki7k52oCt5D4MSIpKV6+yPa4CEZpcD4Weqwh57H1DIM5LrbM8W5x66Zo50eWbFImrz
 oq3oQ7OiL1NLDisPTp9vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t28D63i4kbA=:LqC0cb8rpWJw0XFA+j/vjZ
 m2sJwDnJAmSLFVdKB27peI67rHAi1ntMn0H+bba6cZkQ22gXu8LjyvyEHjBw+fGvCIyU6B9af
 YfByDc3rZph62iJHRTbarIlzo4oipGn04vSwxV2dFRyml/ZE3Ac4/vtJqjzfKw+w0NhcHnMjK
 6PUFXATh+/VpuVQ0yu/Rf7WvpaNNQyY4UmLsAhjH/J87xmUAqjjPdgEZy9BWYh0NMBTnjFbTH
 uXD4wcY3zBgniaink0gptxw2awdoXNnvmtH+Tquedkk2Jf8lSlUxlbpQN7IZ5bchybVjJCnZK
 D64k/YxavVEixYaHwRmoAqvLY3Kp7qtfou+bHEBepZNEzrTTHlWCM7yH/iA6PyrFEHYVomYse
 aMJPtnjFab9w1c/PyW9sF0IRz1vrnttAsZXT3G917EHgz592zfKQi1kKbdpX0hsm6i/mvEBZn
 eJdvTF+UHkMAZ2WyPsv689pFRp2UCdIFjEtYWqH+7XC7spdx60hpoIEaZ/4P5FWDQSzw68BPA
 OJYObmjracBgSZ1wr94ft7a6wUVc6hOlowXsjRRvcY8wVwR1r88eqFKntlhMHmGhTxlC+ow8K
 +mViQBu39qAqr59nRrhoMRJtA5stdYus0H4lqtsL0EJ5DSYlscRVzFBQCKtY6VvVHONo5SPlW
 +yidJ5+0RDe8ua3SjiDxbe3ttwVLJO4/fMZSRscKE9ju27PZ0ULjXx7R3D6bvs50W+mzvPf30
 3OuD1YDdYOWGrDmwNMI6Zd8ASALqRYCmROyFK2RmYJTIQigZYTYy+s02Ay2nIZA+2oypr3KZ2
 dnO7wGrzAr2C4gu1ax5Wyr8XaK+dmKs7Eaucct7ozVB7XHuNycu4eMfjBUvXjUKj9xn6reCnL
 WdY/UGZ58y/WHWQGmJIBdFF1sRN5eH1ZuiNvmu3U/1LXrrGoTRLvIvHIrT0tUtnMkM//kU/BD
 g6IcfMDPCdNW3dAkUtZs2Fo95eE62Za2EPgtcx01m7ez1sO1V39IXj3DRbmSx1EAsSJRZvaVh
 ez4GIfkVk4/Ukp3i4w7ovIIum0R8aDXODbHl8dJRoPvE0hHsYfrLzWAAxxINjz447Dw+vYxww
 i7ebQs6zIBgzG9owGlcwc4sVggmsNi6WBvxeRDtseB93P+oX3LIXL98VwitOAjxzVTc6cufb/
 8oDP1YSfL4FzDbZnAa/Tvi5I5ZLAsuH9xdBD0+qYuJr6vI53s/uUhOZockPxl348pZGI6GeyC
 IrrnquWk+L8t9PL5i
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Mon, 23 Mar 2020, brian m. carlson wrote:

> On 2020-03-23 at 13:08:44, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Git's own `git archive` inserts that header, but it often gets into th=
e
> > way of `import-tars.perl` e.g. when a prefix was specified (for exampl=
e
> > via `--prefix=3Dmy-project-1.0.0/`, or when downloading a `.tar.gz` fr=
om
> > GitHub releases): this prefix _should_ be stripped.
> >
> > Let's just skip it.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     Ignore the global PAX header in import-tars.perl
> >
> >     This problem came up in Pacman-related work, where PKGBUILD defini=
tions
> >     would reference the tarballs downloaded from GitHub, and patches w=
ould
> >     be applied on top. To work on those patches efficiently (e.g. when=
 an
> >     upgrade to a new version of the project no longer lets those patch=
es
> >     apply), I need to be able to import those tarballs into playground
> >     worktrees and work on them. I like to use
> >     contrib/fast-import/import-tars.perl for that purpose, but it real=
ly
> >     needs to strip the prefix, otherwise it is too tedious to work wit=
h it.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-577%=
2Fdscho%2Fimport-tars-skip-pax-header-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-577/dsc=
ho/import-tars-skip-pax-header-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/577
> >
> >  contrib/fast-import/import-tars.perl | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-impor=
t/import-tars.perl
> > index e800d9f5c9c..d50ce26d5d9 100755
> > --- a/contrib/fast-import/import-tars.perl
> > +++ b/contrib/fast-import/import-tars.perl
> > @@ -139,6 +139,8 @@
> >  			print FI "\n";
> >  		}
> >
> > +		next if ($typeflag eq 'g'); # ignore global header
> > +
>
> In general, it isn't safe to do this.  A pax global header contains
> attributes that may live in a normal extended header at a lower
> priority.  So it is valid, for example, to write an mtime field in the
> global header that applies to the entire archive and overrides the
> ustar header block (and is overridden by a normal extended header).
>
> I think we need a different solution for this case.

I agree that we need a different solution for this case.

At the same time, I would like to point out that I am trying to address a
_different_ problem than "we're not using the information contained within
the PAX global header": I want to prevent that header from polluting the
top-level tree.

For what it's worth, my patch does not prevent future patches from using
the information contained within the global header :-)

Thanks,
Dscho
