Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128FBC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 15:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242169AbiBYPhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 10:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242167AbiBYPhM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 10:37:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0CC21DF2E
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645803392;
        bh=p8Zyok1Yrp3E0HupnifeLQPhoFhktGR3BmNe9zwg44U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=efP1x2wbubp9H7I9wncw2X0D2EnctZJTf+LmrEzmmSnwYGEy//bivtwm3nqLvuDtA
         nYIrtAs6pWxQOD+7iZXndffjQKLksR7KAO5NsdVJ+P6G1MpRXRKMqOH2uf9OsVRukK
         uNi12RxtQe4Y+ZOBD33cDPqrt+CCGim3ocsS1lEs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNY2-1nwgPf4AMa-00ZSSQ; Fri, 25
 Feb 2022 16:36:32 +0100
Date:   Fri, 25 Feb 2022 16:36:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Julia Lawall <julia.lawall@inria.fr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for
 usage-strings
In-Reply-To: <e1c5a3258263d05530f236c247603c2f342dac85.1645766599.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202251632320.11118@tvgsbejvaqbjf.bet>
References: <pull.1147.v3.git.1645626455.gitgitgadget@gmail.com> <pull.1147.v4.git.1645766599.gitgitgadget@gmail.com> <e1c5a3258263d05530f236c247603c2f342dac85.1645766599.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nHWiNUVmnRQCiOYGa+SWYFRbkfzO7frykwPyRrp7vD6HmYB2idF
 f6beJ8FGZo12B38X1DRbXg81dyf5TVZdYUm6gv1CXtCmmqLKgc+yEm5dnBoA9GEW4Bo4i1y
 HxrK0CDmHTWjIi95wvW54SG8U/f+NkhubKPV4r9xDPRuatqoAkZuk8U9dcSLMMJDFmrmsFs
 ww4R0azs4FArjdDaGMyEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gIm/+9Qpr2w=:Sir6uVw8El7olKjg73O6fX
 ZaRHhhoWxAsMmnQLb2LkAL57U8bCGH2tLv5x2e62szP/NlvO9JEax4A9cQD4QXHimUgcUfY7y
 NELQ4zm8zZtvxLUq91a+sqGuEdgwpe4iQDBwnipDUVW4pB1mw3MMrGuHY2ENWSOjdyvGjTyml
 /luc9opto39MyosX11cqJeVoor1uAyAzk6j4hhPAfjOLeu0QkGC/64KEWkFNZmT0dphA2R6s2
 sgr3Xw8ONv9kRehfq4MXHt3ecWJL0TynJcc8UWeLp9vDV5YNDRXQyK6biFMcHG9+Bj6xOKDyi
 3qGzRCrN6jiry86qdnv98Mj/c81pocKcqRoChPxjWQGhzbemQIgGiARDt1KqD+toQ9GW9UbdA
 iBDgZKHVy5MzO4DivpUkhVPI293jYg/vbMuCtEEakpjzSNMSnbOfbbDx+NTZQY0uyfL7ClGbP
 YpAKuv/Gi/fQuNx4VabhC0WNtFaAbp5IK7pkhk0Iel8iQ700S0sCwzaURi2KeSx3TGMKVEQom
 Zy9vMd/O3jwP7Nq7KZ4xC7cnivenJoOP8+mnLF6sYI5XhfQvGJe0Nt6VsA/sZaF7OgDJ8F65D
 OOYNK9IgXcTHNpkZQStNBrtXum/lHt5QFzcyxGxioiAnUjp+NQLy3pySRvzbZx/xA93z7I9aM
 PWe1144Tm97v4tOaGBcn73aMYH2WhZ3MVKQqfxkDLfLqDv0NOPs8JOd3rm5blJrSq0PW35VsR
 PpHCWWt4vpbA5h0HgUXzu9dVi9pg1ZkXfw6dSKMii8ncWqAlA2KDwZjtS9BnobF6McLvgAEEt
 dPIs8K7dBL1gaCZWFQKYSpG4/1VapBnG81hXxIPGwN6bXmiHNd6Prx+mBHgxsUqX3/esDRMfB
 EgXA4ggSlTcRGaW7iLavMADbCZdJv7hXBGapBC2Fj3FS11NxpohMtX4eeaoO9Ge3pUm5Felon
 5kE2GzfTEZ4a4PsOPtcAmpKBQc5CtpZi/etnwdO2EQXjBb8b/eCOycQBU9D+0t9OFzBZK2dv+
 7Aw9TYMvo0soWy2Jduc5aykPqdnRDzh77HfhYnJG2OQjz7Kaw+O40xyVNHUAhhoUkmUZhj2/g
 znxqcDmZQgb6CU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Fri, 25 Feb 2022, Abhradeep Chakraborty via GitGitGadget wrote:

> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> `parse-options.c` doesn't check if the usage strings for option flags
> are following the style guide or not. Style convention says, usage
> strings should not start with capital letter (unless needed) and
> it should not end with `.`.
>
> Add checks to the `parse_options_check()` function to check usage
> strings against the style convention.

As I just pointed out in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202251600210.11118@tvgsbejv=
aqbjf.bet/,
it seems that replacing the static check presented in v1 by a runtime
check needs to be reverted.

In addition to the example I presented, there is another compelling reason
to do so: with the static check, we can detect incorrect usage strings in
all code, even in code that is platform-dependent (such as in
`fsmonitor--daemon`).

Ciao,
Dscho
