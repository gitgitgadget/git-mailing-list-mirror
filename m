Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92AE81F461
	for <e@80x24.org>; Mon,  1 Jul 2019 11:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfGALry (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 07:47:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:42191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfGALry (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 07:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561981666;
        bh=M4fr3sg/SfgO0S0j97xBqxH//aiOiKUwWEdlPM9kANg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h1bDnifQcJCbVg98x163hikg7tG/HbhShM6BvRsi08lN3R4BXM7YOMj1UuUwxaMLT
         GrSRvCIu3DhLP+PkscO3zhNdKZyi0EGXw6PazpZBqJHDIIel2PgOwJgRfVRC26xNSx
         LFt05QBHgcMtNXg8dIE+QaIYYkurRp0UA0Ud4xho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRfl-1iEVeF23tx-00bqRL; Mon, 01
 Jul 2019 13:47:46 +0200
Date:   Mon, 1 Jul 2019 13:48:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Vas Sudanagunta <vas@commonkarma.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Let rebase.reschedulefailedexec only affect interactive
 rebases
In-Reply-To: <0F745CE4-3203-4447-B1D5-937CCDCC64C7@commonkarma.org>
Message-ID: <nycvar.QRO.7.76.6.1907011346411.44@tvgsbejvaqbjf.bet>
References: <pull.253.git.gitgitgadget@gmail.com> <fab124da41858b849ae74dfb1fe403bb834870f1.1561623167.git.gitgitgadget@gmail.com> <xmqqzhm2ang5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1906281342280.44@tvgsbejvaqbjf.bet> <e332eb5f-0818-763c-9de0-889644446a35@gmail.com>
 <xmqq4l498irq.fsf@gitster-ct.c.googlers.com> <0F745CE4-3203-4447-B1D5-937CCDCC64C7@commonkarma.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-307196112-1561981693=:44"
X-Provags-ID: V03:K1:DhLg+5+Hgszyf/1ykvMLT/5l026EFsOc5I3uirETOhNJEAwMM+K
 zys+zIs5qDtdZ0J2RVprrJVuZKB1aFimXR5wmzUqvsZEzRa3Efyj4OvgnH54zZKrdT6XddF
 pnk/PqVkSvaPBIzGCmX/qqwrXA98c3mO0fpJcYayrfIkMT1cxbe1ysobjNExhp8mLetrVMa
 I0vBMXJpAZm9wX3opTyzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GHucQx4Kn1Y=:tYwr7P3Tnzg9j4IkSI58W5
 XR9b8yOH6eXcNCKN1lOpUT/uAJ7LELYqqOyN3RGOXX+MLG9XO279JQ+mjvlb25dmOOO85uAHK
 1IbYEtEZKXm6uBJQ1AKbjyltsauj2bmTyiNAYQzL2Z4egHXvZJCoVYBzzVLzgODzv6Sl8Z9K4
 YM51pvm4rcbNxOU++k9qSHH5xOVHn1b9r63/UlkrNxiMzQ6aQqIH3jaeJuuYcTEcU1GQp4Ct+
 EkE3aCjbBE4ZD5YhX9oCkruY8vwHpFLwcVJP0Plsh/WDA15kkfuzpodJ09EvNFYp2huPQu3fM
 qTv8BZW6k0hw1AQObL0oexQ3Ur+jTxEonoV/wE+x/CC5cFmgPCMyq1teSugS/sIgrNxllva6h
 lRfxCQsskST8mjMLM2wtzD26plcbXRVudLmU29xwltoIgu81BGmGNhnA98Yey5yw6kh6cQgi4
 AcOK6ipJTGpVa8dji5M2KAYNhuLJvhbGsZs0og6llBNT3wTfKXCP3O29peulCJvzsoSifwonn
 fom5Hl48YLK3TKOM7VzxMHqRZk74axCpD2lulWmNw75yJIKABW7NjjZs9bb6gu4swnHfwe4BW
 bU/9f/lGI9xI0u6LNlh81Sxn0YnPvCv/1e6Re2SSVuFil15E7mD77rOnBIWXku42qS7t8EAQH
 UcOwznQtS3T4QadpHBIRTCsJyTsIwCLjaghtV6XkdC6ov+fveZyElijKsc7NHzJV17OqbIyBX
 5Ps1AnrthP/mNOqSJmb5CTh2IH8u6eG9uRxgS6z3C+THdEyYJpwbZmgKNO0ti/tqb2VOVImUP
 psvdVHMCOJOt6fP98YbSYU/xBDJmFy8yg/XA1DACLfkenJklWK1KicwrZzCqg7VlAxxiiznFL
 dRAIQxWXYfDGO2aMAlhIvDnqgLPfde1KNcrIyIFt5eKA20xrgccRXwa1CZsfge88u4oraz4kb
 sYBehwiFGA1argZ8LnpyOS/XaO/lqqNt8tK56/McGp7swGJxnMIVhhu3spMHnD8pI9c1ZPJzX
 VPgNbR5RFK74MvmOfnVaMYIUKLxq1CaXm17hcrVr02AixEhtV2dYEQ3J6yNyfoWMIkjrEtnAP
 DTGceUJQU3MDLj7ni1nMLmlhjyGzz8d1vrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-307196112-1561981693=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 28 Jun 2019, Vas Sudanagunta wrote:

> It seems unintuitive that including a command to execute between each
> rebase merge implies an interactive rebase. It=E2=80=99s no more interac=
tive
> than a sequence of rebase merges without intervening commands. A command
> failure interrupts a rebase just as a merge conflict does. If the fact
> that a rebase can be interrupts mid-sequence, then all rebases are
> interactive.

Indeed. I would consider it an implementation detail that the `--exec`
option uses the interactive rebase backend, and I would hate to force
users to know about this.

Ciao,
Johannes

--8323328-307196112-1561981693=:44--
