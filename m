Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1878C2D0CD
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781BA20733
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GRkXub//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfLQLg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:36:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:39339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLQLg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 06:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576582575;
        bh=Tce0XOPaRS6OBeV3AO1FeNi1NECrAPVxoSh1QnyL67A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GRkXub//0JycTCaRRnaHgYIycZwvmc1ey62zXulO0lGZhm2fCZ4RBpbdk//LXd8Dt
         VPGjrqqSRFDcHDPJZV89dZm63r5ojIvkazEgonq42N3ghqJhGsP6xlkUV5C9e3r+9w
         1QTrgVUQn7sYkVS34UMbEAXc5WvgvgYIQVR30KVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSbxD-1iEseF3Mk5-00SsHN; Tue, 17
 Dec 2019 12:36:14 +0100
Date:   Tue, 17 Dec 2019 12:35:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: vcxproj target, was Re: [PATCH] Makefile: drop GEN_HDRS
In-Reply-To: <20191217052812.GB2762303@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1912171231450.46@tvgsbejvaqbjf.bet>
References: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com> <20191214003820.GA927924@coredump.intra.peff.net> <20191214010002.GA945704@coredump.intra.peff.net> <xmqqlfrcje1f.fsf@gitster-ct.c.googlers.com> <20191216192014.GA2678964@coredump.intra.peff.net>
 <20191217014321.GF10734@google.com> <20191217052812.GB2762303@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cGgxSs38ySROkVQa5oJ03NWwBWq81w3VPGK3AWfkMbsv469eKnM
 eoxcg62T0gm9E2bSOUz2feQimt5f6AnHjbC7zGpg0Wqq6rH/MV/jI6QfCQpcYdqXqjLJ9QI
 foM/RJwXilw+Ee9CdjRO4z6ugXY9SRByTiERhGEm6UTET1lRZZodazbiHB0i9KYAPoS/DIh
 1ubveC4a5v6SRcNFHLyww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PTe73DR6XUI=:mXfnMGXOV2/7/Mi2uNTuoY
 aQa23QIOt4r5yT+XV7Z2hefgj1q/WtARsjAT0xAOqk6PHxtldKIQe31QmUden51g0bsVTob8u
 MwHH5oEiVkjm1ryNSamvD3PgQ61Xi3/E/05k7ukUA0/2OzQ2PyG2LQRGRCJk/KZsC4FabGvhZ
 T/6tlZ89QmlPThrLP8InUhJQxzhmt+zgb4TiS+2Z/8uqvT8aZyY69nqI1fNDoS/xcCsDSsU6s
 xuUWhrdNMSOmvynQHg4lHagq9zfSjBguk7lJkYd4c8ciYi1o6dW/fwWXhml+sQkX6OSa0X2ha
 rlSJrq2hJTZA7Hd9CIh4lZwgwYbACyCcv7xsovu4Vdpz1EQKyDxkrkHxdSE3CgiUfCPrvhZNH
 9MaUsTrkbl4MH8EOtK8FkKWH//6D7qRmCRptGW1vpCg+hrORwAKvarNcNLKkkiaZVqhlrpXtL
 IMdIKNP6XCufUc0YfjNnf1bkJ5XPDtcrLikrVevalaogvJ/pc7j8QkMIOe2g7/LE4aNDy9wsz
 n285TYFVixryxyDcL3oyxjZzgIhMSouBlGOW8k8ClZjoDvSnpLcNDfNtUkaU81Kb25BpFCvWt
 74L3bdDAxHEHKGdqZ/mG2bg8tnQdsi/XJ4mlE4Qf3giQiiJO06bvsfRncgSvQnpWeAzFSmu6c
 GXkHSw0QQJVMgMg1bWgyf6pEHA7DaUAYZ983JTdC31pz71jja6CjCVL+PIcnIvyeCfxVxeCBH
 OaDaPnBykY9IPl9vnD7oV6MuD7YBKI3MEiFoSvwEzxvEW+d1JEBJrXaEq6ktcc4O85aycm6Fo
 jIGTelrRZ5YEMbqbQGEW+LUqkfPG+RTtaoz/hRG4c1gddv5cP3Kr47IQYbqUxOdcjN8tMwAzk
 F+ovue7dX/t3BeHc0pjdDw99UAuCMbay2qVa7aB3goBHE9cDC/l8L3XvabbUxAPnbLw8eeuGF
 QlJEYveljr3qcvd0YfouoqChc8N29jko6qbHNEVrtDT60ZpdMCWvSTAYlSvnKQMwML4ZN540x
 p62xPgF4e5D2VHLzLgln0LFvWuf4njWTaxRTqsTmI+99NJ+0Yr4ElImQP9NvDc+7xyjDwRZRv
 Us+By9jplNpR4SDgFT4C5vQ/Ysz6fC3/LkHi2P8a6SUSMo4N/EZ8FIm5VoBYC3YMBHvxWWNaW
 pjSFi3ZyBl7z/xWjY3+/2qORgH+cJ2SBGx2peWK4mAT2CnzywqWQIMBtk5NO79Tnj/It9Lwv2
 S4Zo38Oiwk/RICg1oJhVYE2IvsWJiHDPdehWurJK/xey6DRQ6Jldaukqxfj8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 17 Dec 2019, Jeff King wrote:

> (did you know that the vcxproj rule manually builds and git-adds
> command-list.h? No idea what is going on there),

The idea of this is that contributors can clone the `vs/master` branch
from Git for Windows repository, check it out, and open it in Visual
Studio, then build.

Meaning: we cannot use any Unix shell scripts or Makefile targets to
generate _anything_. That's just not an option. It is such a foreign
concept in Visual Studio projects, it is very much Unix-y to think that
everything uses `make` anyway and everybody has access to a Unix shell
interpreter and the many Unix tools including `sed`, `awk`, etc.

Therefore we pre-generate all of those generated files, commit them, and
the user does not have to worry about getting ~700MB worth of compressed
data, unpack that to a ~2GB build environment that I like to call "Git
for Windows SDK", _just_ to generate those files.

That's what's going on there.

Ciao,
Dscho
