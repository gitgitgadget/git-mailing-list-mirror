Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318E4C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1515760E94
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhIILKD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:10:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:44285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233990AbhIILKA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 07:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631185727;
        bh=oTb09RQVRjLu3iVNUby3Hx2lozL+ZuHPpKeTBJjhSGA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lhhNFwEG6nrsC9BDpYBUb3QKwWy+xvRFVolfzDubZhfGEc1oRY5M3FP0KBdX1ml9T
         Af05GLVUMJ9OmJyMH8hx/eRI/nTQpoZkKrIBLHgBvHQd6hPMbQOSWR4ysmqTZP9PgG
         e2C4m1K7efxnFeNFxnhsk9W3ONoKyPkezegRxc8A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1mKSAH3FGE-0052QW; Thu, 09
 Sep 2021 13:08:47 +0200
Date:   Thu, 9 Sep 2021 13:08:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: mr/bisect-in-c-4, was Re: What's cooking in git.git (Sep 2021, #02;
 Wed, 8)
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109091308200.59@tvgsbejvaqbjf.bet>
References: <xmqqsfyf5b74.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C7DWlwLi2iQ903/rjX+aTRgOC64u3TuvpAG4bp/x4hATVhZHAYR
 ykT4NAUW9gxo1CTOq4OvA37aZFkIqvhfcizWO8BWIhbwXa+yVWGn6StGhgjWkt/wS27gpmO
 6iDPlgvS3Xfv0s2jZq+qNoNa309omeYyYM4rpmWH/x2ySplYH7lfDWG0CnBTFBzEsvcBU9y
 vUrlyxPICZeHVx5V5mdUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jNi0DxljUJc=:F18qH8KNsD0gd6UgP7EpQI
 ALoKrbHV7oRO90G4oyMsJCRkq7H7NbgRMthVOPrcJ11H6r7cdGanBA/wY5NVXnYDSfHucFwk5
 qqtXLntihK4ZQjR1vd01mGhCgYQIe2TLGNNsIN9cw3cyBgUk8AO3SyO1REFUYVBMNW9JX5CNE
 3Hqez8gPEZt/GmD/gjSpXHgwi5Yd1wkWbj0GQ6grw35n/azot/P6Kt9RGJNdJXD74LHp1diL5
 vHWNB16snyFeGcipDbOG8mMFkaemxK0D80aeHDZfgYHZB/M+70zVq4zCIstY+umiACWrJgAFl
 V40e3A3nYYPeTmonEt8uE/+j0MniVh9/5+JxOEjzaW+iBV5xMFIYHPRWdLrtB5UG2IXePp8Yj
 jgr170cU4NmZ1SLoVONf+nbXi6ZGH3qp8yq4kQ5WCQkw2MPdTOBfwWC9HtODCxcfmNYd2uo7u
 V/S6D/ZkJUV71sA7I2C2Jj07jk4k1vhvvdP40PM+2jb53ilGSD6HmMCO3srPgN1XB/coyLSuM
 geIY5UK2+93RDUnMUcfjLSKtX9ibIp8dOfeb7M80U5h1Ce/1/gDppz17bERsUZmTF41RU2ODx
 i4aW3MrjBCXmsA+9qWdZzQ/urCTVvagv2z9IZGghpD9ALwtKvTb2OS82AaN/33scSWHnsUUL0
 YPPQy7wfJ/ECl9DZ0us48xJKThH0OK3R1Gyjdae8RrY5koFtInIdvH0mbae5MW4tZQ5gvYJkG
 KHdP5Q+ILqGfao95IAe4x2T/l1G5Lr+88HzzH1b4nkQ+/Q64angRL1uzaF7w3Wph4PlkknqNs
 chUPbtTeBzzGFpPgAc69LBJok4csTLypf2x/QMDDqcqT/hl41KAMgnCZShAiifxIU3J3IXLj5
 lYsFtv3Iz57Gy3u2kwN40aobdf7sZpDIcxE60m42453U4RTJ93ZHY+M3GKQXcW8YnGyo1OmtE
 3Mrypc42kEMWX25NQzCGWiqCfZ1hKAo3Pg/8CRZK6sOi2IhauPtW9uv0rgL76jH+T03D9VQSc
 tDNvyOsfMAZV3qnKgLjIW43wKewbaiaj6tUS5WUKLTn5YklNapcDkf0crBQAtXktGQmm60WjE
 Pu8RsnLTnD0tIM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Sep 2021, Junio C Hamano wrote:

> * mr/bisect-in-c-4 (2021-09-02) 6 commits
>  - bisect--helper: retire `--bisect-next-check` subcommand
>  - bisect--helper: reimplement `bisect_run` shell
>  - bisect--helper: reimplement `bisect_visualize()`shell function in C
>  - run-command: make `exists_in_PATH()` non-static
>  - t6030-bisect-porcelain: add test for bisect visualize
>  - t6030-bisect-porcelain: add tests to control bisect run exit cases
>
>  Rewrite of "git bisect" in C continues.

=46rom my point of view, this is ready for `next`.

Ciao,
Dscho
