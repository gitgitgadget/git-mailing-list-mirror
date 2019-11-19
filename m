Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B63C432C0
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE1E2245D
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WM4dPZyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKSXZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:25:09 -0500
Received: from mout.gmx.net ([212.227.17.22]:53333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfKSXZI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574205899;
        bh=l34w0NVHztI7JYfdYfAj9+AuT4UAc+xIzJuXxR5DnA4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WM4dPZyATcK7/MoSq5ub0kbiHuwjosCMP2UQgVpmYJty8PW+ShD595ggIiAl67bOp
         12hh6L6v8zIaQkmThuhV6YDK06bAGhizT8e8qb6twpS3bbgWMIT4Q7HvEXjSI1Vua0
         qPU6Zdi73Zx+u1icVZbYVrr80NSSF++icI6SGsOo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKbg4-1iGdNv2iuS-00L0Kl; Wed, 20
 Nov 2019 00:24:59 +0100
Date:   Wed, 20 Nov 2019 00:24:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/9] bugreport: add tool to generate debugging info
In-Reply-To: <20191119202542.GB36377@google.com>
Message-ID: <nycvar.QRO.7.76.6.1911200018470.15956@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-2-emilyshaffer@google.com> <xmqqr2284is5.fsf@gitster-ct.c.googlers.com> <20191119202542.GB36377@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UDiZwl0jst1PzieiMktdLVRvpcfVaTXsFeDxe+8Zkfjryd92xC1
 OsqYVaRvFR32WAPvO6/IhJaXhdB86ahWxHVpBQDxYk0oHWSjk483bP9i+OtSvAgAa2befd9
 kdGHJQp+itw9dWQ3eom/e057Ki3MvFr246727Fc0ZrndGq2pOM0mdjfmSge2/9numspVGE4
 ZemrGEK7tl/hUXLs9kyqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fxpIUwZKPt4=:JyIpJIkofHg7/56cSmW2++
 mdakW7QQKYz7LuMyVwO5EBFmLy6GCQyfBKLcxSB/D6NDOoIje270G/kp9ZAnA/V+zW9Wp7FSA
 Rh6Pr1OXaRsdR1ithfFCC/YMfuW75CW3eYi5MAFnrjHXZnlr8YP0popiPNsbD4qjSD+Mt/Xcw
 Nr+bnfHainoX8V26BSJuwP341kjcPI0z4JjuywLYxzPEZf53NnR25ISoeqO05cDSYm3c1LyMx
 k8kYvJCPApFgoqQ7B9FyZ2swLElNZirZ8F1K8skWF+PYxbeodnWiducwqjgl5N1Hl4TctIDSW
 vkq+8RMff9x8IQ1kS9LeyYhtsG3iUmNP0Q5ZrdV0wV2BG1/0xG+Qccis1ujUzPsY02F/tIm9U
 Y2ky+Sv9GuubLQcDNrSZ3XcDl76eOOMF+1oA79ZHc5Jk4fKbNGFee4ZEtt/XD23TlL3zX5XjG
 pVkSiLVUUAcz+s+2F5dYaavbhe88YnUtBcry8iZ1gD/uXlYDjzvL7mkPN250YwPltjbTGxsCF
 NKSb5uoAD7RL0MSlhs/rl2Pk5nTVdtATf5kiwz5952PqRL2zEegvFw+p3pOvNTBuOan0xfrJh
 wplFJZgJrz9o3ujA8mwzrHJM2i75u7kHnP2pu1J8N5v5fIYrAlw6Xh6wTOfb1xtYDqFgAgR+X
 AT6r2jRj4KFqz0Gt9Qy1XsYzHz9cTQiVhkvzgPoV+anJk/EI2ogX+dGMVdkpdCfnz1JXwh9/k
 y+8zwDyJVR46jZA2R9VXVMEc+8gHx1lJRf0yZl+Fb9uYnDQ8BF9nZ+7+F8fk68h0dEzFPWrnW
 EsthhNB5Ix11KbwqCtVZ6gzlApMufhMgBueT7Ce8jTy4BBqjOxiCppeEQpN7TEfWvePH89WWW
 hgAYjSA+ElkBaVtMR4cbRoWJaJSkrI2pMYzaoX/WQdcLK8VDi7FjHNL1QUTauAbPduJCsMer8
 0kdvzjZ6Nt6SiwpMpzoGXNolUmdcWWtpQAcXrdd58r7HlSzRC8zhs4457w0qpoB54/d7AyZYA
 LdUU4bKRg++f68jBse7I0aUFjpt9SGu85Wmrhb7nEbjRBEc05ndyjvuIdtbDCL8gLir6CYB28
 H9uXX4m0+we4oUNPI7RBBPTwUlIRH2rVJ3fajNZEeODIPvYhUITNpzuJs/qWRoFgRo3XU4Af/
 hoWHBjnIxEKFcsB4/5G4GppBFdFYHE3Ligh6RTL2fDUf6OzTXRJg/DvqqFZvJO39+TNGwVgAq
 NWtnufBE4xXQRo/O2Ganv233DWncAuUCnohZ+/aADF/Z9LzxMN6EW5idtt9w=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 19 Nov 2019, Emily Shaffer wrote:

> On Sat, Nov 16, 2019 at 12:11:38PM +0900, Junio C Hamano wrote:
> > Emily Shaffer <emilyshaffer@google.com> writes:
> >
> > > Teach Git how to prompt the user for a good bug report: reproduction
> > > steps, expected behavior, and actual behavior. Later, Git can learn =
how
> > > to collect some diagnostic information from the repository.
> >
> > It makes sense, but I do not think of any good reason why this
> > should be implemented as a builtin.  I'd expect it would probably
> > need to collect more info on the running environment than otherwise
> > necessary for the regular Git operation, and perhaps you'd want to
> > even link with libraries that are not needed for the regular Git
> > operation to achieve that.
> >
> > Can you make it a standalone binary instead to avoid bloat of the
> > main "git" binary?
>
> Sure. This would fix some other issues (needing to link against curl to
> get the curl version, which is exactly what you implied). I wasn't
> certain which circumstances a standalone binary was preferred, but I
> agree with your reasoning here for sure.

FWIW I disagree with the idea that a tiny built-in command like
`bugreport` would "bloat" the main `git` binary.

In contrast, I think that stand-alone commands _do_ bloat. Look here:

$ ls -lh git-daemon.exe git-credential-store.exe
-rwxr-xr-x 1 me 4096 1.8M Nov  6 13:43 git-credential-store.exe*
-rwxr-xr-x 1 me 4096 1.8M Nov  6 13:43 git-daemon.exe*

In other words, even a super simple stand-alone like `credential-store`
(the `credential-store.c` file has only 198 lines!) weighs in with almost
two megabytes.

So I fear that the claim that a stand-alone command would add less bloat
than a built-in one, especially for a relatively small thing like
`bugreport` has it exactly backwards.

Ciao,
Dscho
