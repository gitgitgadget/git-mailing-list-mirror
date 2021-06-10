Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E86C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A89613E3
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhFJJrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:47:32 -0400
Received: from mout.gmx.net ([212.227.15.15]:40067 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229990AbhFJJrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 05:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623318329;
        bh=2IsgQtFkcHr1WJrZukdHgCOVbs7WnxRsrs9mIIjT2MM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dGYiPUogNDYYXGj/6Xkjg9TQugo9C7Oy8oZdA2iGNkbNRiwxNBUTAMZtUxMORKR9l
         c/l+auMtgO7UeMElDOTQSivM5VqsQw6LV7L6dA9V2Uwn8Mz+CMbK3QGzVnAS1BLnMq
         cej0VN5w4aRVC/ti0jK45lLisObPa15Zcod8j8vg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1lRs7R1Y8q-00jMH1; Thu, 10
 Jun 2021 11:45:29 +0200
Date:   Thu, 10 Jun 2021 11:45:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v2 0/3] Make CMake work out of the box
In-Reply-To: <xmqqpmwywl2z.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2106101144050.57@tvgsbejvaqbjf.bet>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>        <pull.970.v2.git.1622980974.gitgitgadget@gmail.com> <xmqqpmwywl2z.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n9xRCqbr2LPnNNJ8HNE1OMbnx76swVlmbSOQscxM7H0mG0VkAP9
 SOtQ0QNHVMRtlogMahOF522hq9C2GDXe/ivUiYXGYDURutUZLo8lRDU1TbWLsMVYSGsAZ3k
 gj4SDtmR5SINWL60NUbxSSJ2k9d0uoOFvVv/+LWjfHDoCoOdBnHRN6f+Vgm1OVkx9C0lZjU
 lmTfDIRq/p9qz5prdxTEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6OlnzgoY+z0=:2qxjXDageHT8SkUNwLD5b/
 6oTGB/yO9/5Mn7fT+sbchvuS/SC32Qdtp/T+PFrjim/S7xmj9lYJSEy5xMotmwquQv3rYNCxM
 gOL4le3IXlVOwxPJcrHOZHOy2c1nfcMNUJRGzPPbLurgf0dIF8g/AnUX4P6cUFlZVpPXbzFbL
 jhz13OmXKjR1knI11OoZpHiHToMARIw77fIBXddkfIeB7enDC6+dEg0WBgAyvmdLJBLZ9X5f8
 mVuK38vbbrnY/7m2j3tyRv0IMO1eBOs1xnhJ0LZ+UKnJknphjGOOxVB7O7/yb+FEZ5/hyrxop
 a+kxGs/1yg/e8Dpz19kRPvGTwYD7bAl1OxEbfIa/4ryuQaJnujd1vyd6Jdm3csj+64U23wY3U
 EDYxKGGTV/a+EJV2EPpfFddzX7ytfzH87HHERAeoIZ1U5i673pLLZZGq6US245GhLYhG02gkN
 AJItCfH0JDb7ZnoOwwyJIErFaW6BjTLPGnqDXHPK2xwSQj3vJBQhZd1Bdbd/+oaoxXWXj23sD
 KjYwf3KCqjEBuRckJyqnXR6jS2MwwKfXGeJO0WU5Ukqz10PxM8/aP+3K+1JGeop2+Tz/u0qz0
 szz5UXoZDsHWBR3nww5JHtyxq9QyFQJDzENg7LYDoa35bxovhy4rN8Rvj2PESqWHN14S8dWoO
 g9t5QGOZGbWXKXmhDSZbXVAwxTreQDuBIEMyXfj4W8DTRqu09cxXGsb1JnERyo4yWwa+0EI/e
 Lur6yLm1YJzVegzWxFWrqV27Knw+Hu0HtnPDPQWybigX3VTI8gjG+Hm/6sYsg9++PjmZ/muQp
 dCyT4V8TOOcc8bVe7miot7RKJy1w1H+6enK7I3O/FMrqCPfwl/i956LPvlqxh3QA1UiBciAAA
 WoR4u+LptcpMZB54zTKJ+sU1poUZBeVKIKaJ0FeRD0iChRuWS7NV/sOwNoRvtkWh0QtqnoUka
 5JtTxDLjsWVI6KQDCum9RlXlO5MduoU9Vl8rLp+KGGw7YizqfzdR74aBNi6qCcWHpM+v2MueE
 ltlLEBnfc4ERL1jTW+JUdqJWiSj9fLi21FnpQOc9mJCFK8Oq100EhmXLYwYXdml5Js0SNVBmg
 tb6MVOqPocRyCmIYL24PIyaPHhB7mHSc2qC1Ue/3nx5l4wSHQpoeuHmQQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 7 Jun 2021, Junio C Hamano wrote:

> "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This pull request comes from our discussion here[1], and I think these
> > patches provide a good compromise around the concerns discussed there
> >
> > 1:
> > https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKM=
Rgi_oZAWw@mail.gmail.com/
> >
> > CCing the people involved in the original discussion. cc: Philip Oakle=
y
> > philipoakley@iee.email cc: Sibi Siddharthan
> > sibisiddharthan.github@gmail.com, cc: Johannes Schindelin
> > johannes.schindelin@gmx.de, cc: Danh Doan congdanhqx@gmail.com
> >
> > Matthew Rogers (3):
> >   cmake: add knob to disable vcpkg
> >   cmake: create compile_commands.json by default
> >   cmake: add warning for ignored MSGFMT_EXE
>
> I am neither cmake nor windows person, so I'll queue this as-is and
> wait for the stakeholders to chime in.

As long as the CI builds pass, I am in favor of integrating the patch
series.

> I did wonder if we want this to be applicable to the maintenance
> track for 2.31, though.  There is a textual conflict with the
> addition of SIMPLE_IPC that happened during 2.32 cycle, which is
> easily resolvable.

If it isn't much work, sure. But I would think that developers who want to
build using Visual Studio really should stay on newer branches.

Thanks,
Dscho

> I am tempted to queue a version of these three patches rebased on to
> 'maint' after making sure that the result of merging that into
> 'master' is byte-for-byte identical to applying these three patches
> directly on to 'master'.
>
> The range-diff looks like the attached.  Thanks.
>
> 1:  546c49cc88 ! 1:  585b7ca371 cmake: add knob to disable vcpkg
>     @@ contrib/buildsystems/CMakeLists.txt: endif()
>       	if(NOT EXISTS ${MSGFMT_EXE})
>       		message(WARNING "Text Translations won't be built")
>       		unset(MSGFMT_EXE)
>     -@@ contrib/buildsystems/CMakeLists.txt: file(APPEND ${CMAKE_BINARY_=
DIR}/GIT-BUILD-OPTIONS "X=3D'${EXE_EXTENSION}'\n")
>     - file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT=3D'$=
{NO_GETTEXT}'\n")
>     +@@ contrib/buildsystems/CMakeLists.txt: file(APPEND ${CMAKE_BINARY_=
DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT=3D'${NO_GETTEXT}'\n"
>       file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX=
=3D'${RUNTIME_PREFIX}'\n")
>       file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON=3D'${=
NO_PYTHON}'\n")
>     + file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SUPPORTS_SIMPLE=
_IPC=3D'${SUPPORTS_SIMPLE_IPC}'\n")
>      -if(WIN32)
>      +if(USE_VCPKG)
>       	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=3D\"$PATH=
:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
> 2:  efa8681a22 =3D 2:  1cba2f9bd1 cmake: create compile_commands.json by=
 default
> 3:  ceeca2bc0d =3D 3:  7824e74976 cmake: add warning for ignored MSGFMT_=
EXE
>
