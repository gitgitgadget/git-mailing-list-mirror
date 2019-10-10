Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE471F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 11:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfJJLtn (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 07:49:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:56731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfJJLtn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 07:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570708160;
        bh=dDnowaIavlmIOJtftz3s3yuQpEzQme+mssikSeLKsjs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W0Gef1DgH2zAAJ1rZccFkfB0xIoGh79vDMG+V+0XC10r6A44S0u8ntSiij7oB+eUO
         tbJzbDnrZ/0x06VrgfZwwEOTwZ0jb/L9C0DamED6S0Eepx/0dFvhBEJnuyZbjXTyyr
         JQoBJTLqLbGTncKU/leWKp6xWcGKxT4uHw6jHqnE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv2xO-1i18YC0B6W-00qxlm; Thu, 10
 Oct 2019 13:49:20 +0200
Date:   Thu, 10 Oct 2019 13:49:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
In-Reply-To: <20191009203105.GA7007@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1910101345120.46@tvgsbejvaqbjf.bet>
References: <20191008074935.10972-1-toon@iotcl.com> <20191009014039.GA10802@szeder.dev> <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com> <20191009203105.GA7007@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oV86Xg60wsxAe99p6MFZbI5BnyUMnujfgMLNDKkEOQ/fc9if35r
 BiJbJAHenToNEgJ2quVt4zU1VdWfkuUGU5VkTeQZjrglpLIy9sJS4GsUocvjuSocUfEcQFm
 OPcqZpjAug7rOvStbVHLw/7XqAENVo+NEQY/t8ymFjkDZD42zWKUN18nfny0wEmbzhSHqHn
 L4EsT5gB67fdrE31mZcYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9lM9JFNI8s0=:SmzaWAwG88l0UU9RzN4LPZ
 re7FGLuu+wyMutchDPWaMYuP4LWRUsBt+U1/yRl6HboDVQSMih2WQbvlRSaMU/c3Dmw1U5pHA
 OzSj7t4ooesg8D5Dp4BJUwAsFWrM+sFw/SFA9iA+y+SFFJypL0ybqsPW7aKxWgDvIGbEXTLv2
 mFVlLpbEwyMDxfwiOzJf1ZYt/Y2XQPczWYvd0bQmeYPB6WBsQ8gOykV4yezS3vIoN2GKBJiKs
 sAOX/VKv/5+L/gupQFgB3Q3HY/lnLfXHrcljdjOguMJzhqPvaLWM8M9ZUNuyndZCs5R8xjzcM
 Rh+yWPzU7SMkI0PW3lCbdWRM1Z4WVnlJ7ZWHNHZImwysbTNktgCnzOBnaGvTBjZl1IAm8po4K
 FlMlU2a1DIOYsWaHmcQ6XL8Iy5LsKZ/w9WbcJLPVrF043K40YAThUbg+dicrHHqG/vXUmB70V
 UjWnXgDtHCo3JtwfHyhfQl69KetxdrPYMKjBwQcxORv6WssZ/sed8vvKuezbNjZox/Fm13sj2
 sbH6nP+6jodkKCpQdxfsNNOgcrWBDBRFmdmeIi0MQhPKYqilv5fnrQcMPIpOG4bKWxghNMr1S
 lOIsBoXp0Kx+QnDOCULlZmIMqn5nK9X1GE9WrVHz9aulIMY+sgaeuM1v2EeWoyGbdZKwfxovH
 jVHtj4hAwG/fl8UdKeU6dj0N8IN3M21PctKiqJ8ITkwkLaDDpuWej3IZosGsTAK17B8eu4IaR
 HOVZmeZCaLQFaSKtLH2ZGYjVEf+KdDrlb8rS46Za7dlHtHNdHsPqKsGQfeAeFyau44HG7MaoU
 im1hdrmFipqXgAcQav1UhxOcAAg3aFG5v6tDQTd5qdQ/E56X+dM7XH50vh/Vf8J02EFoTKsRK
 yl5mPm004ZTh2SpxXRv5ElsXtgYamoeuQ1y3xOISIlAUR2QZbWoOUGGXxWjpWcbLse8Vl3LlY
 Gf+3w2TGT0cJRRgOUr0GTHme4QO9qxKulGqnSoWQjUkbm5nIfhzTESSve68RQtXbgAyyPxI1n
 aBXC1ub2diaWj++TaFEnou4E9dJUfPTnvamLRYJdYUnORfzmXD36AMZuw3b8PmQ4AwTg0rcEC
 5OTn6+jk/f9EQ2fZQGhHkUrZqLsVtSqrmo/PPJpKknWlY1xBsCLEFX1Ti7dKetEvuOJsfE4bJ
 nBiWtzXnUeD82dtLYtfMHghfSDBeO49W1/GNdKxTTpGDWD2A9FSCniEsCGHXKnzBfvY4A5/z1
 cE5s52jFpuquTM+vHiWIcNLHdEDmxaBOt6LE+LM5O0NNYXyrxP+d9JC5NwZ8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 9 Oct 2019, Jeff King wrote:

> On Wed, Oct 09, 2019 at 11:19:47AM +0900, Junio C Hamano wrote:
>
> > > I wonder how we are supposed to use this trailer in the Git project,
> > > in particular in combination with Signed-off-by.  Should all
> > > (co)authors sign off as well?  Or will Co-authored-by imply
> > > Signed-off-by?
> >
> > I think we have been happy with (1) a comment at the end of the log
> > message that says X worked together with Y and Z to produce this
> > patch, and (2) the trailer block that has S-o-b: from X, Y and Z,
> > without any need for Co-authored-by: trailer so far, and I do not
> > see any reason to change it in this project.
>
> One advantage to making a machine-readable version is that tools on the
> reading side can then count contributions, etc. For instance:
>
>   https://github.com/git/git/commit/69f272b922df153c86db520bf9b6018a9808=
c2a6
>
> shows all of the co-author avatars, and you can click through to their
> pages.

FWIW I really like this. It bugged me ever since that GitMerge talk
(https://www.youtube.com/watch?v=3DusQgAy8YDVA) that we did not have any
standardized way to document co-authored commits.

> > If other projects wants to use such a footer, that's their choice,
> > but I am fairly negative to the idea to open the gate to unbounded
> > number of new options for new trailer lines.  We do not even have
> > such options like --acked=3D<acker>, --reported=3D<reporter>, for the
> > trailers that are actively used already (and to make sure nobody
> > misunderstands, I do not think it is a good idea to add such
> > individual options).
>
> Yeah, I'd agree that we should start first with a generic trailer line.
> There might be some advantage to building trailer-specific intelligence
> on top of that (for instance, it would be nice for coauthor trailers to
> expand names the way --author does). But that can come after, and might
> not even be in the form of specific command-line options. E.g., if the
> coauthor trailer could be marked in config as "this is an ident", then
> we we would know to expand it. And the same could apply to acked,
> reported, etc.

Yep, and we have to start somewhere. I think this patch is a good start.

FWIW I would not even mind introducing the synonym `--co-author` for
`--coauthor`. But that's just a very minor suggestion.

Ciao,
Dscho
