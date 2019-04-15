Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21C3620248
	for <e@80x24.org>; Mon, 15 Apr 2019 12:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfDOMhT (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 08:37:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:50701 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbfDOMhS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 08:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555331832;
        bh=mm/Y7Yn2B1l9XDXAuwS/dOuTvq8QgeYpfPpVGsW1D6A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=daTw8Jmu2f1IfjCQTKRQJ64clTSy2mj4Mko9BP/z0LC/KjSSyCwPWp3n3z/xgpjXB
         6Fln4HjWVIRpZwxDEULRV+znHVsNZUbdsoHpdAj2sNsedVOt5df4yZoiZ6rE1VyyAs
         Pwz0vs5hrd5xwOTqE9yQOxM18eb1nAAnO6NnMIkM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZ7bs-1hYddc04kO-00L061; Mon, 15
 Apr 2019 14:37:12 +0200
Date:   Mon, 15 Apr 2019 14:37:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 1/2] t9822: skip tests if file names cannot be ISO-8859-1
 encoded
In-Reply-To: <6161c76702246ab34a520dae8104ad489b89b6a1.1555276767.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904151434520.44@tvgsbejvaqbjf.bet>
References: <pull.179.git.gitgitgadget@gmail.com>        <pull.179.v2.git.gitgitgadget@gmail.com> <6161c76702246ab34a520dae8104ad489b89b6a1.1555276767.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VebTZR36nPevtZ22+sfssLtuok9tCUtKv6CXRcUW0RrFgtduF1m
 naJ0JDy1aZY25Xmn4k3bbukP0prc0q3aSur8X5iaRofsdrciPcLS+EOUk/CkH4s3Zc6C4y0
 sHA9CWIGzeFpJGzTIMpJ54zZ0YCPY48+a4MF99+Hip7FporOQ82TPXXdqWrucgtaimuAtcE
 ZHRO4J4mGB4UtGgWj5HpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:svvJI5EhIFE=:Azp9Nue1tpO5M5pWI7wfd/
 UHhojztmljU6OY8iVpTNlsMekuDafIMqXvEO+hJMSdIELnR731slfWWDw4+x37BS6mqN7+Gmp
 XBsJgI5VaxzoGk3Eon7CIAEmI4ZQLuDR07JzIQWRiH3KALZ/Lw4kdIRDZ5OpdbcdKgS5ivE5i
 5AD8pjvQVP9H6v0srgZaHElhfNtdAzWyN9wNmLeUx/Jgv4ezhfOCI0TfG6YD+tnuRUhQ0HZ/y
 ZkJ1Qw+uQyxDwH+1aWJ5dmq4ZnX2sZ6yBayUoE37brENBFb21U9hsKuJklQcxZam8W3jUIkiX
 5mYavcFUwsey4MaOuwBGJmCxSob6IwGhRvl0K5xpTHXc7d5FPn07EBIqt5ysUNtynnBMFZzHI
 MBPFMXjNMba2IyIlTst3R3cbu9sKjfMUwAwVTIetSnJsX09gydyxMk8qMBiiwSRSfWtrd93SY
 5swEofl2qfGzWhe7Bmu0NXw+rW3A/NDWHfcTys+wp/8MLsSKS8DC9al0cenYa/TpWu6tmI6wd
 KCUAC7Y9ZbbvSLQbou2kMntL0VOIGBFZutm5EjJVvREQHK7GrBBmAPaXVRsgD9YevmFYV7hef
 LSDrcCaLP78MtkJtVhkMpI4KC5TNat0ezkaFe2iTtFE0QitClfSq1yUTFdpWw1Q+M74I9XYZ3
 n+3iXEisPLqXGoXX4D5wSPMSllDf2neVqnkflQ6RTfSIOOHzgf/1kpemTCiWi5VshLSTG2mA3
 fQBWaBtOIvjdbXvCPMcFboiCdPMBjVjziMg1hEz2aMfy3HDwAjA/b8RQ9t+Jtzd6fhwQTYYRg
 Z2A/K2SIUoUf4ydNUHxRZ9dUcCOiHuSr+/fQh5uoBh0pCUDcXPq0aoC9N6gcV5dKfW3QnW02E
 hPqNaeK/gawIfMCQNS15VwmLA2WhqsAdQIq3klZ5nLzlVQ7luZ+euW8FqnMjLD7TrclsB0ThR
 sOICoecJ4qw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 14 Apr 2019, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Most notably, it seems that macOS' APFS does not allow that.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

This is actually a quite important fix, really, as it makes *every* CI
build fail in the macOS part, meaning that I am swamped with false
positives until this is fixed.

It seems not to have made it into the js/macos-gettext-build branch,
though. Would you terribly mind picking it up, please?

Thanks,
Dscho
