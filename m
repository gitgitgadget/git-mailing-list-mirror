Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C649A20248
	for <e@80x24.org>; Tue, 26 Mar 2019 13:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCZNoI (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 09:44:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:37323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCZNoI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 09:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553607841;
        bh=Jw8Uout5siM1xW5Vr+RS9lFxZLxXINEbOXHmXWeQCz8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Udp2AlcUYDOlDmKDRj8LjLonn4QTlhBxO+w2M+K4h+bQkUT5/bjMEng9lOZGz3f50
         rFf/xGPjDC/6cCHjqcjiqDcWxbBgqcYW3ci9ft6ETiA5y+0TSujFwweMavYoOVZcOq
         hd9f2H5WhCPLP1TsgFUQzJtCkNHabmbJHz980/8I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.144.175] ([95.208.59.4]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lt1S6-1gxOY70bow-012VRe; Tue, 26
 Mar 2019 14:44:01 +0100
Date:   Tue, 26 Mar 2019 14:43:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Mike Hommey <mh@glandium.org>
cc:     git@vger.kernel.org
Subject: Re: Auto-gc in the background can take a long time to be put in the
 background
In-Reply-To: <20190325232223.r72qtffyzn5qzoxc@glandium.org>
Message-ID: <nycvar.QRO.7.76.6.1903261443140.41@tvgsbejvaqbjf.bet>
References: <20190325232223.r72qtffyzn5qzoxc@glandium.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zr/UexT1oCY0RLuNs2oQSNghSlwAOwCjhWdDeTnDuiZHIaWgJ+O
 YutBRP/ZOpiIxe/7KF3X1H26nwwGcnRmYtKZwqWaGoWzN5wzFhC41+8D0ouU/7kQLqvBu99
 TcXl4ESm2lbtLMLMvEGhLkYBV3X88bGXEMdGv7YWHFxTZJAbfvFFjF+ZHsjySaniS1kOIOt
 HNQdRcDdqFKJdpuqbVTQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hpSlSLnW7+I=:xbb8mwPmYonWP/TAb2EHVV
 +TpdrAFkHEtEAZBc0euLmDrHHcMlQplcNiT8+1QIwXoAp6bPLHhQKwxc4R45sZrCkTzSe+OPr
 8Nvh9r2CYrYdM30zVhZKL6L9eNE0L4rMXCxzNB6t+TjHATrQma9IPu4VxBhkcVCwOTB+7l8O2
 /+dcqg8C1jkTEMrlb43DRuiEJJ3aLc7DpvcocclCBQBT2TFaxPowdY93NER7A9nZvL+KJ1ksU
 dJQZENSdICzhvgMVbK6wVksp5vBAypvWcWjDjbvybw/ZZZeZYcrWViniY/Ky2HwYQ8nONmzy/
 doyhJ5oIvio0NKJIdM8JlLfeyt+OW6nKUgnpyqD9eylC6ZP9goAhnYj41kj6DIPV+a0QKzzyu
 JeK7E+MyAkmAtSUm14cBKlrZsaEbqauZYF/T9FbF0pZOZAVsrh8xLHFfDXB5ZrIr6YPdkBast
 nXKSaSii+vuyXCEYFhHojRV26KdCbRIXqVsOE6MlOC9/1gDcTOBPdPuJdj8bbN0K88VWFimHq
 nFDVCyw6kB+LbIG2lcEJh7bnfoQ2LNeoOIMaujDpUDe3BpJfyKyUVJgPzMpmw088igefbTtu/
 2rdm/iu9B+xEY8EGEJ52F3Txim5JIgdKvir56TqJCyz/ZbvJhQbWK9f2rVb8egp9h0YAR0X3u
 1ji1o2eGmar/kiQMD5WkfpFlV0/jdIQKU0u6UEI9drXc4CqN/TEINK41sM17C0Qf7qUabMXvv
 lDLNoR7hrlh3G2fJ0Jan9oOZ1ZFSNwEWmLMKWvDzslMlesqMvAa1AiGcuXBNF77QQ28s3oV1D
 ZBsDFqeKTS2hTT2837mBiv50gqkXrrtCQrkW4wwvWW42IcGaXPHIxJT7D10cZR3iLFVH5FVwe
 avhHmBHF4CuHY67j5vmZGQzxpNLcC3d71D8dZrbNVEMkYhj4fpBxxY3WcAQr/fmo1MgsOiOxh
 sQITDJJWV7TaMhcwbcHE+20WmL8CNrps=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mike,

On Tue, 26 Mar 2019, Mike Hommey wrote:

> Recently, I've noticed that whenever the auto-gc message shows up about
> being spawned in the background, it still takes a while for git to
> return to the shell.
>
> I've finally looked at what it was stuck on, and it's
> `git reflog expire --all` taking more than 30s. I guess the question is
> whether there's a reason this shouldn't run in the background? Another
> is whether there's something that makes this slower than it should be.

Thanks for tracking this down. I hit this problem yesterday and was too
busy with other things to dig into it.

Thank you!
Dscho
