Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C403C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 21:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbhLGVms (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:42:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:55725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241933AbhLGVmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638913155;
        bh=TsCK1USk/0+jV7JcKcBjGqV1BdW0DXySgalvLs3I0O0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R4KhMBvL0DK1+ue7bFvhREFf2J+cooLFQJdK5EKKFppH6RTxv0LvVL3ZrSti1Wbu7
         6DJfHUr9CPqJbebtmct1drr0J7MM2s49uQ7e6bXmMBBGpBFNUts76q7mRs+IqrsVxO
         OPPWsxopOpen1ZPDR3AwjlVIkOnr8qP8i3UgfSMk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([89.1.212.223]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1mA9633hfd-00kjMC; Tue, 07
 Dec 2021 22:39:14 +0100
Date:   Tue, 7 Dec 2021 22:39:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Leland Weathers <leland@lcweathers.net>
cc:     git@vger.kernel.org
Subject: Re: BUG: git bash / python interaction with absolute paths as
 environment variables in Windows
In-Reply-To: <CAHeq4YxktibxMBnMLwEq9Nvsgw0UqCrjW2WPcerJCM4mXKxiEw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112072235400.90@tvgsbejvaqbjf.bet>
References: <CAHeq4YxktibxMBnMLwEq9Nvsgw0UqCrjW2WPcerJCM4mXKxiEw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0sb/bByHDLnpVL2LpHwH6kUVcj/F2yzd4tOpg7BVizpsQhQDFd/
 l1U0qW63tTOVBV245vOzJ4DEsEqKc0VD6tZaqJg8tUP2h2EpHIigqqrkmkRCQd7Iuis4qmW
 OgUlVsYINq3/gZHwktMFiR1VQIRMEVTQ0/ZkBsyWqyW9V7ZbB+DLbpW/9NzJTxpPmzMfQOj
 8gd76/fLTSb1E9J8+PvJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aaW00anpQhY=:yDTfgzgyrswRCAhc2OU9uS
 79CnM9I4Zkd7gQNe2++WbBk5fhBRfMOKhbLRNRjYNr2aZQ9s6ZIJn6LwRL7OH6t1P6GbODdgW
 UTRlMyGVEIJwRGYX2oZV4JuW6aomQSOjw8XkiZxRVwYKmmg+vfXNkVnK6YKDyf2YCAcj2pukc
 X8ZoMrAuvuQllvrswZUVbmGspRG9GSuORq+1LnMSwBCuc2TE7gWewxhCRcEurjOwS/UqLGMiN
 l+yuqL86r2AZVH3ftBDO2GwaKaJVgy3NFZ3Y0ifzaVsr/kuxDkRl3zhUhih0gvrnjCPaUPbR6
 zEJZqcM2NiILnbVFvj6oWZnlO1y1h6xgbmRA98PNU/2iDAxIAR1xC8n/mIPF3JpRPLey+5fvF
 A0ha7BoKDNka57G4uUZKMC0j3+niNGs9c3VEt0dJEolZbMKShPO3Q8XsciK9jBF59KrjYJHc0
 PIrqxCeG8sszphrH6nL6nnaiJXcq+o0I7iRQJUZSJMJOUjCOXu2OwuZ3P/UHo3nBzHl4IfXJ7
 Ovzj+lsEDJQ4gxf4Mmrz4PWDZIdu9xkIe61y7HPTO9M4CkTN44m9Iq0iGLO3ZsPAebrQI55ux
 OxJG4zlJ53vgc/MDMGmIlfHPIHyJvSIGGUmp76qHIOngTXttWLlv2UBEgMhTkuWJ+m1jRy4Wu
 w1Ve+eABwrmp9jV202WZDi894DkF0bCLotNkMZdr1qkSqmOH/5q7PEt4zMXWYcTI8C/uvQSLq
 pddXlaf3dOtcFaLzh18EMpluxusAtscMDW1UgQGu28EsGjaFz4FssWIsAPsJv6HESDTp9Lv1C
 HXPSptmrsxkWTFWTCQTvTAHncLObNHLuAqDAFQ8NA841jaNPUGADmq+tr5SKQ30r+pVMUIbba
 y661NHWr5hF/SYTLenfYrP8RET1bmYOFu9aqlh4v7t3OhZs6sBAhHYoN3+AM5hK76rOsF0sa8
 S0rdOsS+KURedWVdAR941rTkD5/xWTZ5PwNTyRUfMkbZo5tYlHFyLIJD6eBNbypjUq796Lygj
 1ASB3pkdK8v60RfzwUAIEETBlYUcqoi/jSLebFYBzAxvgmVf6M3OmVxr3bJEMt3ngFi292t7t
 Ycl7V84uT+jRW8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Leland,

On Mon, 6 Dec 2021, Leland Weathers wrote:

> Issue: Using Git Bash for Windows (2.34.1-64) and Python 3.9.9, a git
> path is incorrectly prepended to environment variables in Python code.

=46rom Git for Windows' [Release Notes' "Known Issues"
section](https://github.com/git-for-windows/build-extra/blob/master/Releas=
eNotes.md#known-issues):

	* If you specify command-line options starting with a slash,
	  POSIX-to-Windows path conversion will kick in converting e.g.
	  "`/usr/bin/bash.exe`" to "`C:\Program Files\Git\usr\bin\bash.exe`".
	 When that is not desired -- e.g.
	 "`--upload-pack=3D/opt/git/bin/git-upload-pack`" or "`-L/regex/`" --
	 you need to set the environment variable `MSYS_NO_PATHCONV`
	 temporarily, like so:

	 > `MSYS_NO_PATHCONV=3D1 git blame -L/pathconv/ msys2_path_conv.cc`

	 Alternatively, you can double the first slash to avoid
	 POSIX-to-Windows path conversion, e.g. "`//usr/bin/bash.exe`".

Those release notes are shown by default when you install Git for Windows,
and they are also accessible via the Start Menu as "Git Release Notes".

> [... snip ...]
>
> In both cases I am using the same Python virtual environment. Other
> environment variables (e.g. non-absolute directory paths) appear to be
> read correctly. I'm assuming that this is a git issue given the

Premature end-of-mail?

Ciao,
Johannes
