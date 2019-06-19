Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E671F462
	for <e@80x24.org>; Wed, 19 Jun 2019 15:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfFSPLS (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 11:11:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:41259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFSPLS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 11:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560957068;
        bh=tgEXf3odfT8QlXHDpdZIy7yZAk9ImZKYSdbgASgYx8E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jm6+Oe4k7qMn5hPmVx74gMfG1ehoN5QTQVZj41P4GokmiwK3L+TBmoayOcrslSP2z
         v2prYzmtemGOcXir7WBuz+ztf2rBaaHKia8YgiS7uhAfpK81Tx5Uow/6Ecq/GY/s32
         o+mtyeEWxBXw/E7zoyfe+RzjwGCYO0g/F1DwL5Ms=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPlsg-1hhRzl3hUw-004yQo; Wed, 19
 Jun 2019 17:11:08 +0200
Date:   Wed, 19 Jun 2019 17:11:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 13/17] msvc: support building Git using MS Visual C++
In-Reply-To: <CAPig+cTgmvwg_LV5zonQAR3c0et2p1Nm4YuAfAkYDF=2jY9YeQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906191500241.44@tvgsbejvaqbjf.bet>
References: <pull.149.git.gitgitgadget@gmail.com> <587cbcf61903693139ad4a02b32727bddd6d116d.1560860634.git.gitgitgadget@gmail.com> <CAPig+cTgmvwg_LV5zonQAR3c0et2p1Nm4YuAfAkYDF=2jY9YeQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qTLK54lnLZaFpsfTXEvzSOz0ZIahpZl81Kjizemy/LURcPGis5e
 +NPUp/MpVzI4SDrBJdVv7lTO8Fvk9BI4VHaqcQVL/CstYiy5xY4JW93UeZPk59Ps0OXiIIg
 LH/wW/NI8iA6efgRVGIoT/oIqw/lVtV05NoQqoY6J+/3497t9qK7r/g67N3wF5WE8HAtEfb
 qwz7+Uq4AN+H8+p6J99Pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jpCFQoGlBcI=:p6b9vUauyy8LfY8g7LYUdP
 3qvLt1YtPREwTDWlhyHjPJPcZM0L7jOrD3TkM0J2LVZwI+cAnsa8oTorPx11cXPN1ZX/eF+ys
 zZc4XMDpG421s2L1o2G3PqzSUHfOyKkvXXRXJfGjYPO3BzpCJMQ8X86diCotsem6fA5XYi8/Z
 eZzUAAiUdzdPktMOscCIwNNwurq9g6Q4c9P6RyJN1FhBLNjLdS6yX2/cOeGh8R8u3Um/pkC3P
 1QIhBEnfZ6Ix5F/msyTSSjtTOe6i9CMTtY6V8FQiGOhRJwlmY317i/3ExAYQiG/HhXHfSiAkg
 ltB+hDaUnRJPQbiKDwPFQ+cgY9zFuGsDDkDsgQR8skCGx7Jd7ranHLCf7PazKiZ0KAbbHt6ou
 UcDMLObP8KYs6JZbRvrw1KJEf983ngUKl2gfDSh7lvvfDVbxa0K6KZjcPf3sOqykfD/v5S1y+
 AZyXiT5ecbuNjIzqrGaT3mF6QdZcu+Y/50aZdoTg4JCZDqWgPoNrIzVHfeoUNrvyphzk2K50R
 ogCs/mG0IP3d0zJa4MOgXV7/BgzS6jpSIfjcFntaKkqYMw7DWXjqxGztJGELJZQyuWzmtGbzC
 ZjKeZtP0VzcvelVtgCtNINTHuLn2/qru60Z1wnCucp2eMqzihAGihsMd3tdhh3wozFusGCCfe
 YiAc0+5rk5vSWreiX5/HfDKNHxQjzL1K6jgR96wOR81HQU9sSoWBSXUtEmclmyGU1zQtnXesd
 R0iOUYWjvTikioFBWhK+gOtZQ4Ai/+foERmk9N6h2cPtK+gPhY12xIPRy704ds9o4Dl0plxNl
 PvO25Nsgyki7yqKoXdKuF4kwdHCZkka1/xYXDAUDygu/L1q4LZNcSyTzn6oShrknJ0QTzDWH2
 XSG0V77DkVY9PenU+DWf4a9oEs1IQmdiyk2PKxgw141iEcYCOEYzCuqT8ko73rc8iQEL/5kn+
 yhp4EllpH9kk+HoP2zSQksolQj1q4Jr9QskIhyz1m/BnyVOOTuaBn
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 19 Jun 2019, Eric Sunshine wrote:

> On Tue, Jun 18, 2019 at 8:24 AM Jeff Hostetler via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > With this patch, Git can be built using the Microsoft toolchain, via:
> >
> >         make MSVC=3D1 [DEBUG=3D1]
> >
> > Third party libraries are built from source using the open source
> > "vcpkg" tool set. See https://github.com/Microsoft/vcpkg
> > [...]
> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/Makefile b/Makefile
> > @@ -1240,7 +1240,7 @@ endif
> > -BROKEN_PATH_FIX =3D 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix =
$(SANE_TOOL_PATH_SQ)|'
> > +BROKEN_PATH_FIX =3D 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix =
"$(SANE_TOOL_PATH_SQ)"|'
>
> This seems like a distinct bug fix which should live in its own patch.

And so it did! And so it will do again, starting from the next iteration.
Thanks.

> > diff --git a/compat/mingw.c b/compat/mingw.c
> > @@ -2388,6 +2388,12 @@ static void maybe_redirect_std_handles(void)
> > +#ifdef _MSC_VER
> > +#ifdef _DEBUG
> > +#include <crtdbg.h>
> > +#endif
> > +#endif
> > @@ -2405,6 +2411,12 @@ int wmain(int argc, const wchar_t **wargv)
> > +#ifdef _MSC_VER
> > +#ifdef USE_MSVC_CRTDBG
> > +       _CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
> > +#endif
> > +#endif
>
> Shouldn't these changes be squashed into 16/17 (with the commit
> message of 16/17 adjusted accordingly), rather than being included in
> this patch?

Not really. This has little to do with assertions, and much more with
memory usage debugging support in Visual Studio.

I guess that this (together with the other `USE_MSVC_CRTDBG`) should go
into its own, separate commit.

> > diff --git a/compat/vcbuild/README b/compat/vcbuild/README
> > @@ -1,3 +1,54 @@
> > +Alternatively, run `make MSVC=3D1 vcxproj` and then load the generate=
d
> > +git.sln in Visual Studio. The initial build will install the vcpkg
> > +system and build the dependencies automatically. This will take a whi=
le.
>
> Is this bit implemented yet, or will it be introduced by a subsequent
> patch series mentioned in the cover letter? If the latter, perhaps
> this README snippet belongs to that future patch series.

It is actually implemented in a future patch series (I hinted at it in the
cover letter).

> > +Note that this will automatically add and commit the generated
> > +.sln and .vcxproj files to the repo.  You may want to drop this
> > +commit before submitting a Pull Request....
>
> Yuck. An automatic commit as part of the build process has high
> surprise-factor, and it seems like it's creating extra work (and
> possibility for error) if the user needs to remember to drop it before
> submitting.

The thing to keep in mind is that the *primary* reason for this Makefile
target is to publish a version of the source code that works in Visual
Studio out of the box. Read: without getting a (pretty heavy) Git for
Windows SDK on top.

The idea is to avoid having to download several hundred megabytes of
Git for Windows SDK, and instead run the tests in the Git Bash of a
regular Git for Windows.

Of course, this only works when certain "build products" (such as shell
scripts that have been copy-edited to their final form, or certain
generated files that the test suite wants to see) are included.

If you do not include them, tough luck, you cannot run the tests.

Of course, I *do* want contributors to run the tests, even if they choose
the convenience of a full-fledged IDE, and I don't want to punish them for
it by forcing them to pick all of the bits and pieces for themselves.

To achieve that, I force-add those generated files and commit the whole
bunch, and publish the result as `vs/master` at
https://github.com/git-for-windows/git. Actually, it is a trusty Azure
Pipeline that does that.

> > +Or maybe we should put the .sln/.vcxproj files in the .gitignore file
> > +and not do this.  I'm not sure.
>
> Seems like a better choice.

Unless you struggled for yourself to find all the missing files you need
in order to run the test suite. Or to cobble together a working Git from
the build output of Visual Studio (which only contains the compiled C
code, after all, and as you and me know fully well, Git insists on support
files such as templates, too, and yes, they have to be "generated" and are
of course excluded via `.gitignore`).

Once you went through those struggles, you don't want to do it again. I
went a step further, and I don't want anybody but me to have to go through
that again, either.

That is why I think that your statement might have been made under the
false impression that this is an easy decision.

In any case, this is indeed a discussion for the next patch series, not
this one.

> > diff --git a/compat/vcbuild/find_vs_env.bat b/compat/vcbuild/find_vs_e=
nv.bat
> > @@ -0,0 +1,169 @@
> > +:not_2015
> > +   REM TODO....
> > +   echo TODO support older versions of VS. >&2
> > +   EXIT /B 1
>
> As this is a user-facing error message, perhaps it could be worded
> differently. Maybe:
>
>     ERROR: unsupported VS version (older than VS2015)
>
> or something.

Good idea! I made it so.

Thanks!
Dscho
