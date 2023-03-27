Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AAAC7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 09:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjC0JHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbjC0JHd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 05:07:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FF640FB
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679907946; i=johannes.schindelin@gmx.de;
        bh=SmVBrtfA9kGc3/khB2Sr2G/JJsGanAYBf4sLw7y1Ij0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iC0qDR7mgtLfrb7OgQ1us7dEHOl45j+6xSAER1LSz5GTJSppn+6TYgoCsV0+LUHUi
         8We+YDr+O/62zl1xsyNoQW2ieJ3k0FfwRQKSNXd+nj5nuVEv+J3WqdNTt5uYP8R03D
         U1mV2BMcbvRimq9N0LC/xS7HuFrFVRhIxwHwXZWFCRkzcHFJAduIEr7/4zwZ7EWjG2
         llEPuuGiiEpcfBgj+AjXRIEc+yA/4dD3sBpmRAOYQHtqoKE0+Xiu8p4Y+Q8cLtmPRD
         odIrVdcJNqId1vUEqTvIuQS/PQppOpuFiVu3O+L1D4HBqbSxCRbviN+EsGSVBpgUEu
         ZfI2nY/3fL1rA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9nxn-1plvSx0kM9-005rXJ; Mon, 27
 Mar 2023 11:05:46 +0200
Date:   Mon, 27 Mar 2023 11:05:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
In-Reply-To: <230206.86y1pa4gdh.gmgdl@evledraar.gmail.com>
Message-ID: <a1d44a2f-fb3e-fa99-121d-804a884e6aed@gmx.de>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com> <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com> <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com> <xmqqwn5bg695.fsf@gitster.g> <Y9JkMLueCwjkLHOr@coredump.intra.peff.net> <xmqqfsbxcmdd.fsf@gitster.g>
 <6f83ed25-a7e1-06dd-f180-d70c7e1b1973@gmx.de> <230202.86edr8pax5.gmgdl@evledraar.gmail.com> <60c3f1d0-2858-8811-7eb0-d6f586bf2ab8@gmx.de> <230206.86y1pa4gdh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1551748266-1679907946=:123"
X-Provags-ID: V03:K1:XaX6B7Eie1QvoEcn9qR3sEMp/dK7XCXgTCqD5DX5aD+B2QzCHF6
 LA+WCtzIvyU3yD3yd7FKBqwnz+NTnHlKfhcELZ4cqCwIkXrT5tD7WRiV36wtX/ZqemljCQy
 uHyWMd/yca1AHjz58UTqVuLHkBW6q01Uq4PC5xV/vzDWChmAP1VtswRKdfAbHGpXz2Kmibk
 W4BDAOaH8GjCnmywbwbUQ==
UI-OutboundReport: notjunk:1;M01:P0:Wir7cM4gbMw=;eSg/T4H+lVD99cpbUERetiQYk4M
 EeEUEcnvMCw3N6cO+5R3vaLapobTCH2PttPrwUp0li7QFFk4f1GDXztgIfGE0tHkOPV6b1eDL
 0S2M5uEvpfoXDkqv8zinT+UCn2RMmQ4pLZEjje4eA+8LVgvM8N6fb5Sye460l3EL6+A8uhj3C
 M/Lgju8pQ0ziKRs8dDHxQNwCk//rOJNbFxkp3E3+gkh+Yx1hezPgS6cuiM5ht86QDjXzDVzuj
 nbu3XsmqSz2coChFGq3um3NfHpv3zUtfmgFjLUNWVVoQJcLvJ/T/wOxsaIzsRirB+SBROsPQ/
 K1sVib7PpSxmjQb5hGEdEkTMrviOYy61I7LzShfihf9Ds/+g2LWKDoEtA0+odRMmji7rLHh95
 +ad8JXGYzD+UxmYkpvSxGknsqzfVQS7TVIYdCK36NYplTAb+kKG2NRA1poY+S1+uooieV8yhs
 ihtU5JNlZ5f4z5J5jGnGlqrHnGwgHC1npCXx+X+twuz52NXxiZZz1+NNyvm6jMyJ6cpPAMCdS
 OHJG5ULZ537UuUWyizJKHHrvGCoUDMqKzSqwYTb1Mmrm80QbBf6gMMDm21XTBuoUnqBWRMmH5
 B6XjX+z5vixzttMhTxPJqUeKYc/7kfePpQzCBGbePozOLg2GbTyOBK+QQkflHbvAii/F6lLfx
 rdSMm84xSu9iyQ7j7sQuzK1PGmkOtiXLzDFNpw54tWjT/DeSC8LbsYrqJDXhGQf/YzuNhdb6s
 NbeDFo9GBpLXKSeuSeFbpfQl/4ohod/lyOuR8/yeNrHnRkPn15YEG0pIy+1Okmfo50TQekUXl
 C0zsKRsb5dC+2DW5txxsEtMy+EnBbaCCGo7lcSPnC0c7Akb7yXY1JwqHWca/R287AErcuCOlG
 WW/OGwJNBBd4tFp0jiC/YxZlt2wzUQBPRkgI9OCmAg1FCrp7MtcpW+xDsQcdbYYDQUKSaKOh8
 FGpiyMUN25HHpqLHGn4d4YHFCLM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1551748266-1679907946=:123
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 6 Feb 2023, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> we currently have CI tests running Apache on *nix boxes, but you're
> suggesting a loss of coverage on Windows
>
> Is it really harder to just install (or even ship our own package of)
> Apache for Windows than it is to embark on PID file handling, logging,
> timeout management and the long tail of "80% is easy, the rest is really
> hard" of writing our own production-class httpd (as the suggestion is to
> have it eventually mature beyond the test suite)?

Yes, it _is_ that much harder, and it would result in yet more painful
increases of the build times which have really gotten out of hand in the
past year.

Ciao,
Johannes

--8323328-1551748266-1679907946=:123--
