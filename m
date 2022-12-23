Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D93C4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 07:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbiLWHes (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 02:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiLWHeh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 02:34:37 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7C130F48
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 23:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671780870; bh=Q79e2wfvNP1NMCnTs9IS1bm9F369F7jvTnIA+cSq/tY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HP3GGpTin+7ZG9ZbPHrVk9FQjuC7HusikjZa1OTS9cv9Dg1bh7kUgRGv7RoCupPSm
         0JejjCYXfOsnMJcEnmLUfMIl5G8/1RXX/4+K6RTk858y0wddXSnL8JKEWrCGYJoxhm
         4Ha0i0mXfpsBjADbo8GTAYAxxOZp1+4/ccwE7PlewhRtCWaRb9mx8rbnjhrRHF6Gzg
         HK58BkiRJsw8WwZWmfMmg13cXvjYNwBEUyC3gbCYZHTBt767Saas9tdXwEj86k2K1x
         /5TgJ656KoSjTt6LEV1GIHR8Yh3X+38tlI6jx1Lm2LGl6mrNOiBUT1n6M4+e2fADd8
         zJxGs00Pp2XYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.64.45] ([89.1.213.120]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV63g-1pGq4810lC-00S6fM; Fri, 23
 Dec 2022 08:34:30 +0100
Date:   Fri, 23 Dec 2022 08:34:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #06; Sun, 18)
In-Reply-To: <xmqqcz8csz5k.fsf@gitster.g>
Message-ID: <f4f8f704-2b87-9d4a-37e8-ac4d9dd995dd@gmx.de>
References: <xmqqh6xtw4uw.fsf@gitster.g>        <b3e0db14-6c57-4188-7217-b38b5b0acdde@gmx.de> <xmqqcz8csz5k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Nls4Uw9IjH4bw9BKjbGdCs5PHWaD2FtDJSf4rQ+w6XkE5Cqtyxh
 kH2kUyETwlpcmS7G+M/julfaf+op9a3I05qxhTk5lKxTap8coN51hrzMrmv2foBmyzwWrQu
 t53/T366TSKJyBG/sE4qCmrrySwpm8NRgqLBd62/Xuia3VA2lOh2vJ2+Py7Yo7qpy4Am9DI
 15GWfv64A6XHKlUBjrL3A==
UI-OutboundReport: notjunk:1;M01:P0:hZsNPeK/uk0=;U5hEJdAre67RSHW7YT5A3HbSPDJ
 n6Zo1n/M5So8FYu92qMD4pPio7VLCTw6HbUx7oN5IBGEnguBJpA+fCYHbZf9krUYmmScI3I8c
 GTYro+l8Lp3rq4tmTlYZ2g06wgujrqv2Vybv+XPwapX3z2UYJtytG4tmXYpgebcehwx7l1VBs
 vm6SLdRz10sEljBPsc1PrWX0GbJmVn0o7fNH2xpQKE4bklG+zGZoK8MD+owuFdcwkGIHdcYfU
 EUPahM7pQWUMDShY2Op/cizi99LlIxnbGT6OxKYxqWjOwjcXC9PMludY2VYlLnZAz1PRbC0ko
 HDBIGxoninPRuXUJMSQLucPaHM6UIf7a+1BzZwneXvM6l/9X5XyAxptnvvklrl1DU2Edz8Nk9
 EyJI4GenPhMdxnWupK6NdGy0BQUnhD0bLJb1zjBEdKpCBAbx4dvZ3OUHwdJdN7HtUaoT+GZoe
 D9tLoM7cOUO4ILiUFI6cD/OpH/k7V2Xwj5KE0Lb7RJDuhmppkBflIPfuo+8JTnk1ktfAhJREF
 iundFmZtk7Som0oSZ7qjqeZS4eFZjIvYTafp2ZO0nZn2/04k8jubwIYu8OJz+Yyk16Efp31Zs
 y+7+0pVOvKmcUGh9tYQpogLi9koT3hyklxkz5nQwKQbazuvMw2Q+aS7CMKzoj7E7Gz7gWSvXi
 /4M2U6PujLGD1qv7g7ob4xzhsmZphvWo0WrVtkzcddV7dXCgpZoyyYp/5KovVCPql87tMqCEl
 w3zLBnmIMrpWb51p03N/NbLZF9EeNiHPq4FIoqatvxsK8z5z4n44FXYIGfx4EjUfnPH0v0XJ5
 vtcBcQQIjUlhLfkndmUzqrDgnadNF1gO7MJWRa96WMSAStlkXE65u6NMI4NKNTk76xfbQE5lF
 PGRiywkISWhSXBMZZWjcAeujjTlOxn+bN+KYkCgHRVUMOh0K7uO7g+40M+Os8xLCo0QD+dQ8c
 zTfRpA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 21 Dec 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Are there more regressions that would maybe merit a v2.39.1? How immin=
ent
> > do you think Git v2.39.1 is?
>
> As fewer eyes on the codebase and the list traffic toward the end of
> the year, I was aiming for January 5th (even though officially I
> would be on vacation around then til the week after).

It's only vacation when one's not working. I am also on vacation during
that week. How about releasing v2.39.1 after January 8th?

Ciao,
Johannes
