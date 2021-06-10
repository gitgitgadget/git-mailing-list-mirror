Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA8CC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D7560C40
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFJJpm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:45:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:47497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhFJJpk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 05:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623318222;
        bh=VZ7n6ppX0Ar8/Pui8OQMnBgH9KphL3EWkaH0LOJdz10=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H6MLg/Eco1Sh73wTXHit8tKZwN93fKggP8qBzeIsjSJ3rw/KOvkq5r35lFswKn/7s
         Ynhgrctpr4qedLZaEwpwe6UGaMWQX+LZYMMUPzfk6+vR5bs4dQOjgrxFiCPZQpHQtv
         6kL3GfW5vmDc8hf2XyWP+8A3kdV5yFI2+DW8eW/w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1ltC6B1tDF-002WGN; Thu, 10
 Jun 2021 11:43:42 +0200
Date:   Thu, 10 Jun 2021 11:43:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH 0/3] Make CMake work out of the box
In-Reply-To: <6a9150ca-5c1a-1874-5f8b-35187f197d47@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106101140590.57@tvgsbejvaqbjf.bet>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com> <6a9150ca-5c1a-1874-5f8b-35187f197d47@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3tbqDgJCZLD8jX3nKBDMp2tYjbaF9digu7IQgt9RU0c3x6q0sND
 FG8CC34FW9I96IedMpjVxRza20L2QJ5t39sts/aLd558DWp17594D1mmmR+dMp/ZUCsycie
 OsX5hPv0f9T2LimvWszbjpdPrbow+dw61L//25RRrt3hy268R/REtOm59x9EL553R0GfVXX
 /ElNuI1Z97d4Blwekt4qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wu2uh/C8uGc=:iRfSfP1tn/gX+lhdGz0VFK
 6n8xLO0eNiS4nLIcsbfE0IQQPxWz0kLI5+YX/ey8KcOWChUzrn8da1gD/XLJzt2+bzuHwQeQl
 5VJQH6lewZxhQiAtS6cqjdU8GwhccAUFNr3krYKvPimr39qPLsLWP+4RrEtuf3WjhgtI82vOG
 zreJsi0jErsfEi4T7jSe1Nko6VbOKlL988KyX5Z2LPKuQNnV65p+gLHSrFJ6ZcXVloDV6eJuj
 eww0gsjk02w3f6dharnf01N7bmmTZWwqQVIrTkfnJxRzy+9L6QvmxlM68EJ/cc+qXvnzKltcO
 aE0ug0SDlnM/sC8Di6u5A2nShArRcI4Y3iVYGUyvIGCIHzESnDg5zDiHPacXki7O7kKRONs1e
 gix8nmLzXE97H18YHqFpilTAkty34EaIo/9OcsxDCX41bziOcoCTuHZ4ipz4FUc9udkaDTNXv
 ljK4qhqcoueVFO4cte/BbtLKIkt0rNmgqv8q+BdgQz/uD77kM+Ur7HN89lj+o/SeCZ/yMgzMu
 KDkzn0eYdNIzPBMq9lfBHAEPY3cVZJ72Go9QOYyBnF15c2PvVP36XJpr8D4REpOA7pEb4WDBK
 HuuPhsTeyKJuVOlB1pufvrlwB8vs58kFmTZV8iloXmmseYIYe4BhWRhs++w5lNhgn2xYvVDGS
 pNzi4EcaOTwHdw3sk9RyRFKhjQnm7i9rl2SuDt7TdhIP+QY6rdOgY+PkUomzQ0iF8/z1hcnwt
 wODgzTTN5pwYHBnqdpPQW/3cyMDRGHwDL7cmKf/kslowkzkOCnz4HvvrfzJkD08KrIEeY4Pdp
 SFlKkKiFnGF28WLaY6TUiRhUB2JyToYja2fEoa8MIX6pz9iWzHWY4zwvOr2iO5NxJ2kNLTOmQ
 wnMnTA/kaCfdjo5ElozNeTSi4CpBwgHRxFLpzfhf59jl7+s/r1Me1R97v0a7j6xLdb28BoMqW
 PJ00qsQhXjgZxVp5ua3wlaUZAxzh7MKtGsVCblFD7AeLnjX+ro4Ofn7b+FrsxM1Q1oW3bno/z
 aPjefI+gY3GKtO2Li1aY3XkH0VLtFITLiMB1XjSA0H7sOwWlLUNjRh6IZP03UUai6vhBvwmUR
 asUWi4MzFK2mo5RN775TqhPyKYIXvBbLhwf4zY1cbznYnjmg/d7cEZ82w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 5 Jun 2021, Bagas Sanjaya wrote:

> On 05/06/21 00.43, Matthew Rogers via GitGitGadget wrote:
> > This pull request comes from our discussion here[1], and I think these
> > patches provide a good compromise around the concerns discussed there
> >
> > 1:
> > https://lore.kernel.org/git/CAOjrSZusMSvs7AS-ZDsV8aQUgsF2ZA754vSDjgFKM=
Rgi_oZAWw@mail.gmail.com/
> >
> > CCing the people involved in the original discussion.
>
> This focused on improving CMake support, especially on Visual Studio, ri=
ght?
>
> Then so we have three ways to build Git:
> 1. plain Makefile
> 2. ./configure (really just wrapper on top of Makefile)
> 3. generate build file with CMake
>
> If we want to support all of them, it may makes sense to have CI jobs th=
at
> perform build with each options above.

We already exercise the plain Makefile plenty, and the CMake-based build
using Windows (in the `vs-build` job in `.github/workflows/main.yml`).

I do not see that it is worth spending many electrons exercising the
`./configure` way, seeing as the preferred way to build Git is by using
the `Makefile` directly.

And our CMake configuration only really works on Windows, the attempts to
get it to work on Linux were met with less enthusiasm, seeing as the
`Makefile` approach is the recommended (and supported) one.

tl;dr I don't think we need to augment our CI jobs as suggested.

Ciao,
Dscho
