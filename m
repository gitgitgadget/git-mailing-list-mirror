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
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D451F461
	for <e@80x24.org>; Mon,  1 Jul 2019 11:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfGALte (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 07:49:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:53533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbfGALte (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 07:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561981767;
        bh=PRca0WvKVHSBck6eqcgswDTwhpjwBFwXq5m/8DXXyCM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Nn0zZCbPkQQbkid1kywrevxV1wglbKOgxJqeEyYbOybvUoDadpYwGZBpulZf0/4cg
         OyKCYYvuuZEkYPdvmDyFT0KwwJRWXHxUvRTTlhgv9TYmED5tk5wu9CZOVbo9V1Qppl
         Y30YGUg8cxykjgNHDYWiLsZZOyvii+xORiWaC87Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtZcC-1iiNKl1zCG-010rAH; Mon, 01
 Jul 2019 13:49:27 +0200
Date:   Mon, 1 Jul 2019 13:49:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vas Sudanagunta <vas@commonkarma.org>
Subject: Re: [PATCH 1/1] Let rebase.reschedulefailedexec only affect interactive
 rebases
In-Reply-To: <xmqq4l498irq.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907011348280.44@tvgsbejvaqbjf.bet>
References: <pull.253.git.gitgitgadget@gmail.com> <fab124da41858b849ae74dfb1fe403bb834870f1.1561623167.git.gitgitgadget@gmail.com> <xmqqzhm2ang5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1906281342280.44@tvgsbejvaqbjf.bet> <e332eb5f-0818-763c-9de0-889644446a35@gmail.com>
 <xmqq4l498irq.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ObG8JfUAQCZofFa1g3k/z9kz6x1ScR+QlSRBN55lHGNCyhL3s+L
 bvJtKckDwUhKj9iJ+AjImMlHbo9BaaL5fZzHzDnkKn5TPVo1Btlb2h14+k4glXuf9MMUnMT
 6eidVzw/DS6DKlW5ppTWuGga9n7mJCOGt0qpFGFMADSkkjya5PWl3T0/fZ55Q9JzEfvsvf4
 Tv+SOSkk2hQrKhAiIVziA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YhPigF7yLCc=:Toe6ybSjfRWi7sfNkslL/d
 VA3SyUKNMmlAh8aZmjxPzOy/L0mtM/Z4t/1shV/o8R3kysePWp8tpIP5aAE8vEtSYmlZQatqi
 emiKQ2XjHVw4B7IEENwKu+HdtHXFF3nKQUSAfWtIzJK1bOvwXe6GzwQOoxR4stjIz9Da6otZm
 qHMhudzUFZb2QdIOJrHOk+UFUBvf6QpINQpb+OBWcGT5fTeGYLTmq6V7ucjJwYu9mD7YuvE2n
 wHx08q7WxSrruBca/Fk4NBn1M5h8T0yyyKPdZwXMkIoqx2BRdPfZF7ubPh9dwK8xdc2tPq5U1
 Bh8ngXzNc6uaVTXDDg/3t/C62aqEOr9steSgpLMdyPJvD8E/5tJ/sHzymNVMmvDSVeAvJCjf2
 M6GNNaiUJsstCnw/aS6qdCd8kjOEUc5ddJ8RtHkz3WJEDCWJN4Ux16p97qSnEEETptD35ZiVJ
 yZoHv5H5kSJ/zjIqZHWdEKCn2WvofNc06F8FF0HsYKLBHMMlhCLP2xd7GzHeg5yEq7a0qQfgE
 6eecRvMDgV/BWZ8h0ox0xcRX8QN1Giqn8hwIpVQ45iQ8shQcvSidguEurJf6diwia3XzhEZdb
 Tu008JqW3XfSaAwVFcWaNrBU58ApV19arBkC1oyjK3RBQRdHOIvv9BcTNo/LXTprlFJw331Of
 5r6vuCW/GGwRqcQ7M9ReQNqf/SmRuUCq7/Rh2URd0t57NU/BYWIQF75fZlZzPcXQ593x8N5xj
 UOGUs3nMC42bOqVqBXb2eJuxvgmc8LNGPewwlAGQaIrx7NI3eIzEaNC/70s53hAD4ZVCluWlT
 ZuhvdpBzfpbLI3K07AuhaaRJQrdLgIbdJEiJN9faw015Q9j2D8UYX+qsBmZOjShIiDMr8GIl7
 XQSzqzbUqwJU34gT3kswig/aMcE4j392MpOn20HuAGSOg3y+0EbT/DH38nMTiIdVGxsZLAPLY
 pHeOyi9Ii1hB/khL1Lc/BB6bw77H+Ub3S5KXlOrt2684fgBDNGASGrnp42w0m4iRfJobxwZ03
 GNqwYI5NPLrHz20YYBjKmr5S8e5g9rX72NP+QQajTJZgTBQu/jxHzeIjUcze0esZ/C+7rWauT
 VoujfjtGy4Bbn0v2KXYF9lNR55kfeOn3erA
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 28 Jun 2019, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > I was wondering about requiring --exec with --reschedule-failed-exec
> > rather than checking is_interactive() as that would be easier to
> > understand.
>
> ... I find this a reasonable way to think about the issue.

I don't: the `exec` command in interactive rebases' todo lists predates
the `--exec` option by quite some time IIRC.

In other words, `--reschedule-failed-exec` can very well influence a `git
rebase -i` without `--exec`.

Ciao,
Dscho
