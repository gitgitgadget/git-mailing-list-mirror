Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91909C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 20:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B08A20759
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 20:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KuVQ96U0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIZUpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 16:45:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:60231 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgIZUpz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 16:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601153148;
        bh=9tdYbJvLkr6SmDekZu4ES/F2C/5NXm9En2HR8QuTqTk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KuVQ96U09h8TkAqk2iCWyKgK9808yoynm9fraRvJDjxBIhNvV/dVeVJAQ6JTH+SJc
         /0p7wsWMGicOJtpBzIU2jfR/cYd10D7IW22nLQkhxkGFk32vn7d+bOceIpPu2naz9B
         yTsBnXoAYFy9Wo3Env2cvsQ7FpCUexmfbyqFw3tw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.213.116]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9T1-1kDAOD21sP-0098Uw; Sat, 26
 Sep 2020 22:45:48 +0200
Date:   Sat, 26 Sep 2020 22:45:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 09/10] cmake (Windows): recommend using Visual Studio's
 built-in CMake support
In-Reply-To: <xmqqd029lnr3.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009262243410.50@tvgsbejvaqbjf.bet>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>        <f07e4216669bcda728668d8c5cc99081bfca9f49.1601044119.git.gitgitgadget@gmail.com> <xmqqd029lnr3.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rE4/Arg2/FUKaykasAU43/IJFr/3hW+ElGgWGUpGVoTgvS/qV6V
 LmVE/2xkuoW0Tk0UWpo7YsFKYrMucxLy54dipIxrpUWl/nkxygx/3sWKyVYeEe4K6vn2GOK
 qS1EMKRGvBQPTiQaAvesqqR1MhAr8t5hssak4Vwg82+Zz+f8eBZrL7bGdU0tWI5rv0m1C/g
 Fx/OIfzzlxJAe9e/bpgWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6krqPl9nY90=:k4O+TV681UTj6vxg628s2t
 ZH6C7cnJWF+DW18pXbJ5oHnAYd45zhBY5C8N016z+nA85UKbuKsBXGttHvGbgGfTpgEcudsMV
 WdZLxJ77oYbT2i9qrt7mNH2tHcRFuP7PiU5ZUoUOM43WH3xLgZGFQky4Py+UlX3ntP6xAVJ7B
 6RI0lc2vHIV2aFCNVtnCN0S6UyjUXuQyJ6GpQNOyPyqEyzqZARXPdUMc9HM70btcbgZy61h5W
 qb6wpf79t+jsTOCRcV5X4WlzwwVLLf9mJc6y4uFpDISsNDwhbTk8bJoC/xUBd1d+bnhoZTt7L
 JXId1tDM/Qz65gcDwuKYXfb+3gMSk0h9WMdPlo21wK8OrXmuS8A+WmuRCX1WX7G5P5+bilD9a
 zJ0ESbtBfBrb14wzV1UO0c4e7w86u+3fkZMrzyj0VS9q85WWrguonNAY52/WzxoDxRE8SOqQ5
 EJvLZSYLh155AwM46qpc859NwoXioKmX6sUqFBNN54qms6lCYLbmHC+wa0g1vL9lqri+yo9sE
 +OvkcEZC7EpAORyNKhZv3PgjP6Vu9w9owH6phgZufB7TIohioQ23OINroHtNl8BLBsqT8bWok
 BCmD+/XWu/ADOnfhtsucLaT68D5EeTTvPum7KAc8Cl5qOR+bbnXn5q/fFi9oDAVY6Qytmd16h
 /gPu3RLw0hqmHQ8PJL19aGosMrs3xlH25/Jg2p3eYHm8SSGekPbOD2kRSP/7NIgxmuOpK6r8t
 45OIhcsDZ2TnyDPAgaV1hapSi+LE9eyrodpP61+ptjqVMJVr2SaSoafBpaD9oUzt6sceOKVyZ
 Mqft3LKBApI79X2wIiHcB6XYHCI62JvSq0BuMIkpTRGU6AE5qDsfKIMpttmKdqnHG09q97yws
 atyV1T1LsgF1TISeiUqfdlqbeqHDut2tRdMiNozq4UPcgy/Qbmjqsa8Npw/1UoUFlvThYPNMT
 UOZqE278E0zLA3jVeG7CnhE4U7SnYDov2CVQRcYbb2ptkjOOMyZCX7nhpi/mYFWn0TFOs3HOl
 +xBeE5bRgZI0tZZq7uzWgNNN9gVbTWHTPxfbSaAvZ6KQ8fS+nrrf+iS0FPSNfXKeKgnZ0Qk36
 PlzcqZiPJOfTieAoWZ5l1pnyi5HLDOXW0doErwdc+WRfE9GjCmUyq3YqA4T6pchZ9UKlA74yy
 9QZ4l8SdC4c0764cu/WgG7Bfc05heSZEgCKbKqEXSPLZFdqbYyELyzWyftz7ulmcJLnC8k5iK
 sHax2s8XJe9lg+wkWu2ACQ85Kx4nyNuEojUvE1g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 25 Sep 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It is a lot more convenient to use than having to specify the
> > configuration in CMake manually (does not matter whether using the
> > command-line or CMake's GUI).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  contrib/buildsystems/CMakeLists.txt | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystem=
s/CMakeLists.txt
> > index 1eaeb8b8e0..442b4e69ad 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -4,7 +4,17 @@
> >
> >  #[[
> >
> > -Instructions to run CMake:
> > +Instructions how to use this in Visual Studio:
> > +
> > +Open the worktree as a folder. Visual Studio 2019 and later will dete=
ct
> > +the CMake configuration automatically and set everything up for you,
> > +ready to build. You can then run the tests in `t/` via a regular Git =
Bash.
> > +
> > +Note: Visual Studio also has the option of opening the CMake configur=
ation
> > +directly; Using this option, Visual Studio will not find the source c=
ode,
> > +though, therefore the `File>Open>Folder...` option is preferred.
> > +
> > +Instructions to run CMake manually:
> >
> >  cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=3DRelease
> >  Eg.
>
> Having the primary case upfront is a good idea.  As we discussed,
> our source tree structure (especially the .gitignore we ship) only
> supports an separate-dir build in contrib/buildsystems/out, so we
> should update the "manually" part of the instruction to guide users
> to use the same location.  Perhaps something along the line of the
> attached.

I squashed your changes into the patch.

> Also, after the post-context of the attached patch, there are
> mentions of Visual Studio.  Please double check if they need
> adjustment, or more preferrably the above paragraph the patch in
> question added is all that is needed by Visual Studio users, in
> which case perhaps it would be a good idea to remove all mention of
> Visual Studio there to avoid sending confusing choices to the
> readers.

The parts that still mention Visual Studio are in the part that talks
about running CMake manually, in which case they strike me as helpful,
still.

Thank you,
Dscho

>
> Thanks.
>
>  contrib/buildsystems/CMakeLists.txt | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index 442b4e69ad..0c748949f9 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -16,15 +16,13 @@ though, therefore the `File>Open>Folder...` option i=
s preferred.
>
>  Instructions to run CMake manually:
>
> -cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=3DRelease
> -Eg.
> -From the root of git source tree
> -	`cmake contrib/buildsystems/ `
> -This will build the git binaries at the root
> -
> -For out of source builds, say build in 'git/git-build/'
> -	`mkdir git-build;cd git-build; cmake ../contrib/buildsystems/`
> -This will build the git binaries in git-build directory
> +    mkdir -p contrib/buildsystems/out
> +    cd contrib/buildsystems/out
> +    cmake ../ -DCMAKE_BUILD_TYPE=3DRelease
> +
> +This will build the git binaries in contrib/buildsystems/out
> +directory (our top-level .gitignore file knows to ignore contents of
> +this directory).
>
>  Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
>  compiler flags
>
>
