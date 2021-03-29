Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B1EC433E1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00516195B
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhC2NgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:36:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:56425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhC2NgE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617024961;
        bh=ZF0JU8UXxQG4gtaxCXKluOVvuKapyUgLoln94OXfWZg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZE102NUMSARkDXgADt+12KYw3gKvTypydPkaHGYOADN58f7mzeBAFLRP1+kdDjJYG
         gl6IDHLVlZXjFNr4ZJhGyQlMgfys6KIv0Jpo2VX4U3YCaT2MJHK1wIowe+kezMveuj
         PnlaHUWuXK5HyroiGB2MZnHzXrAwKX2TOssfT1zg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.207.193] ([89.1.213.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1l3k571zdE-00TlS9; Mon, 29
 Mar 2021 15:36:01 +0200
Date:   Mon, 29 Mar 2021 15:36:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/4] cmake: add a preparatory work-around to accommodate
 `vcpkg`
In-Reply-To: <YF/117C6LcNGQ7sm@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2103291535220.53@tvgsbejvaqbjf.bet>
References: <pull.887.git.1616886386.gitgitgadget@gmail.com> <543fd0f5d7e5ee297364d1d28091f2004a35f2d0.1616886386.git.gitgitgadget@gmail.com> <YF/117C6LcNGQ7sm@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1876820553-1617024963=:53"
X-Provags-ID: V03:K1:rK/VGXR7L+cHIamu9JVDUBugNcnP02xmk4zpJwqMZgxEA6erLBW
 HcKi/c2sAm4weP1XPJbCqvBh61rBoiSdqlOas8UkTM/s3FsV+cnbCjhjp+1nIPlBslzjW93
 7MCn1rAFi+mutyaesy2kJr5o5bBdaYuS/lIP8NFDO//epA5Yq0sOXBlrMVsCjEsElNkyK56
 RwVY9CZ3Kuz+Nnq2jskNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dZGQpaoeIDU=:d6hLVKZcujV13/3rtCI7ml
 lezizkBU6+iEoqgoqt3M9WBPC0heLEXn7sraoaQOadTgUNpTCUWSXYb0VDqO8Em+u4LiDKfrx
 IEpq4Yx/VZaAArpwuV/E7RKCjByU2+7kxvke6xyOZ/REJnbdjdjqiZ3pwMyvBY9GB7WMLDWXo
 Y2rlE+yqym3wWWAq85StJc3lRBuIHJh30zVgxKGJvILFDGC9Q74Uxp9aKeKUjeLpjiKM3yBxc
 YCsvLz6Ezn8l6yNo9gXqL6npcXjhFSdDwFzulDwANeRPJ823zQOLd3U5c+Pqw0KfZMA9qlvhI
 d5ogTYDwj9bci8VXNL7Uy6CjNXXxpjSiUCd0fqhS9Rkq7KHAi7KKycy9c7bn0xRs1PqiS+1K6
 Tjn3M+MGKTnX+GEs7PH0rzVbmhbzI+jemkrB+X+zPpHI6a7g3ZaO1KpN7KBDsiL4PD9MZO9yy
 MVAwlShgnSY9z0Icp7lyJ4/a5cAexD8v8X5wFt5ltxUaS/lBsc8pZPQfrzWW5FUv3BQLz3BOR
 f67U+LuMhKJwmNiXkFX/yCT3D/JSbB/NhJjXw1+Mhf8BprtAiGUhDXcjkjNQYRTX6uxPzOD4/
 Y4rQRukS/y0oon/XIju4mk3QRvyEdjMhKMlHpiAjYSBiT+9QyCoMRvZxm0vA/0bOqiK1r9Aw4
 8vsL4g1Zv3qjGM4K+AszGjF1CKEpqfKM0z0txEJR/nJEFTMttomTRUKeUcmC8mpWvmxNH+Sqn
 4Hkh4SOYnrMbcm5GUSlOgK3LiDoIXj2hx8fP3ByrAJCazk/wEpiHAe6yZbijMiIwm/kV9UItz
 u0+o21k4evvkQHxi9REdm87o7ZLMg7Ukwy/UhADz2q1dpjxUOOiZ+Q7CzJiFzUZnlkIkUwrNY
 /Hebxb3u66UuMHZ2UrpoLCiYato/ug0NJ3a457boxQCFJxBmRPwLcTTwoIU2p8mKx1s7q/AkQ
 bikFU6Y6AjyFmkPIRUOT8mrZD+VpdufgPPJEPz9M24d44xtIIDD22Vo0XUTVAjnTAeMr4MHkH
 /Lrziq422HTTxxZwatse9bBmTCUav0mKJd5aCwCufnFy6yYYd4g11aDpWVpbBPPylZoTiTCeq
 Stz1Y6k9Ce2Nj1mgNrSpq/4TpkmxUySuBR1v8DmwoPDageEyEZ/KmPAOAzuwLwd8ttB5PcFrY
 fe30ncCDM75XHy7zHxbT7ZBi1spVqQ3aGHe1yXHv83uLH6uw5o/qc1jEom6vOm8tkAiKju3NU
 okejiqYTb5Ovw5KUs
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1876820553-1617024963=:53
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Sun, 28 Mar 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2021-03-27 23:06:24+0000, Johannes Schindelin via GitGitGadget <gitgi=
tgadget@gmail.com> wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > We are about to add support for installing the `.dll` files of Git's
> > dependencies (such as libcurl) in the CMake configuration. The `vcpkg`
> > ecosystem from which we get said dependencies makes that relatively
> > easy: simply turn on `X_VCPKG_APPLOCAL_DEPS_INSTALL`.
> >
> > However, current `vcpkg` introduces a limitation if one does that:
> > While it is totally cool with CMake to specify multiple targets within
> > one invocation of `install(TARGETS ...) (at least according to
> > https://cmake.org/cmake/help/latest/command/install.html#command:insta=
ll),
> > `vcpkg`'s parser insists on a single target per `install(TARGETS ...)`
> > invocation.
> >
> > Well, that's easily accomplished: Let's feed the targets individually =
to
> > the `install(TARGETS ...)` function in a `foreach()` look.
> >
> > This also has the advantage that we do not have to manually cull off t=
he
> > two entries from the `${PROGRAMS_BUILT}` array before scheduling the
> > remainder to be installed into `libexec/git-core`. Instead, we iterate
> > through the array and decide for each entry where it wants to go.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  contrib/buildsystems/CMakeLists.txt | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystem=
s/CMakeLists.txt
> > index da2811ae3aad..a166be0eb1b8 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -811,15 +811,19 @@ list(TRANSFORM git_shell_scripts PREPEND "${CMAK=
E_BINARY_DIR}/")
> >  list(TRANSFORM git_perl_scripts PREPEND "${CMAKE_BINARY_DIR}/")
> >
> >  #install
> > -install(TARGETS git git-shell
> > +foreach(program ${PROGRAMS_BUILT})
> > +if(${program} STREQUAL git OR ${program} STREQUAL git-shell)
>
> Please don't use `${}` around variable inside `if()`, and quote the
> string. CMake has a quirk with the `${}` inside if (expanded variable
> will be treated as a variable if it is defined, or string otherwise).
> Unquoted string will be seen as a variable if it's defined, string
> otherwise. IOW, suggested command:
>
> 	if (program STREQUAL "git" OR program STREQUAL "git-shell")
>
> We also have another problem with quoted arguments could be interpreted
> as variable or keyword if CMP0054 policy not enabled, too.
> I think it's better to have it enabled, but it's not in the scope of
> this patch.
>
>  https://cmake.org/cmake/help/latest/policy/CMP0054.html

Thank you for this information! I've sent out v2 based on your suggestion.

Thanks,
Dscho

--8323328-1876820553-1617024963=:53--
