Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE31C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0082222F
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bFQfw5gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgKMNyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 08:54:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:59855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgKMNyF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 08:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605275641;
        bh=xbNBiu4o7mwhAjgE4GNivlQjo4mEmxGwPfB7pnnOULI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bFQfw5gr3+Kxe+/t93EumvOlksNl3zhTMejSBItfOhokD4HDDR4mQiGQ9H4+n1fau
         SW18Kap+zcscpHaPuiGjNXlOarjfHTSMACXffJ+xkknaceDXQhB9dIx3JtzHXRrfsI
         c8LOrASGfkUNs/oGCLQJnO25/qmfa9hwGGb624fk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1krNHb0F4Q-00LS2x; Fri, 13
 Nov 2020 14:54:01 +0100
Date:   Fri, 13 Nov 2020 14:53:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 04/11] add -i: use `reset_color` consistently
In-Reply-To: <6405f7c9-b084-ed48-e33e-009f388933bf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011131452120.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <pull.785.v2.git.1605097704.gitgitgadget@gmail.com> <c857c4493213bd7cc4d057487db2d1a74fa0bbd6.1605097704.git.gitgitgadget@gmail.com> <6405f7c9-b084-ed48-e33e-009f388933bf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F1BubG19ecMhlbVxxJ6Z5XedaXa6RQL+2sIk+Tyy2enBMp+WJCo
 /DPcrxprcLXqYqNSAERgluEWegcBmDbSG9KFvS5kL06vYBpwcmN3f5dvaxnp6BtNB093pew
 JC3ChTvM+ebbSOHHyLVHhrioRKCFX4u3jerl7L8k8FnHdO2pw/ScK0G5iG23hHWDECjsj2J
 JK0vrbZrWgro1ulxX9ZBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZQXFwvy89Cg=:UC5tNzLnGWeFeYl2GIv2HM
 hOsakPbdMWqUNAMQ/JFgEzD9Xyzk/1VAR4qmprpGVql7stpzRzepi3aJY2fheiBcrVfUkOl/o
 4hPjrDreRQW/77Q/j4FyLinFva+HVMgBg2Iuu9cTrL/SXt9APZ4gg57crLA0NijU1qE5hQc9a
 BYKXEZk7WV6DZ8XKUPwa+kKLnsHoAuB4DJFnL8bHBtP0b/JTZNlfQ5MzbO+BliZY/36WuPWmH
 WvrTRJaPgC85B7Qd1CEk8+cEhJkkFZjcW1KA3T3bDCWlNYgz5YuQ0feyoInPdA8wSKkKeVFSj
 xd5UYOxro/O/3YV4iUUhd/F6c4hb7qkuVMu+djn6G/oNHmc43+pKgF/QfIi3MLQfE09ixeYMg
 utwBnMDqAaBVt6RY5Q9xP+4xeWds4gcOuAdCzndvxcmbhoRkrKpzoELvx6cAsOMANbiT6r3d7
 CgR5N5u8tLzzAxnz6xtNAWxvHDoSlRJwR6mW4ABKVUxX7xBoABmup9Jbqf0FectTfO7vCLJnB
 C8leQkbHyDvaSE0cXDXYHORdwCD/B4M4msDF0xdbKqX0EiPfTnuXOmU7CgWWeRZReXpQSc0pq
 MkDX0nqjAmU0y5xQR2MqBWsSvFLCEEHSbQ1ZxZVOOAEU3ROCkkiWnmZtTuMWdoIV3/AUNihwv
 UV4PCHO5W/XRPtUzRVG5nHRnsJgeoBVsJSQ9uXdtJ4enZC6S9b6hHpyLkVm0y4x8YkoX5orQx
 PkWHJDWBRvI03YgXaBfYQNpuLCufh+OjRGXXC9o82NsWQVSTxuS677OZ5KXWCpo8feo7LaQTA
 3aTipQVCW3y5zVW87zkXUWdvuYEsotYSKlT/1SxrjeEO5Bp7ppybb8SNfyGgz+hX/emF/8xcU
 Z0+S72BjChrUWTGwYxtv+bDJCkxy2XVolYxUkO5k4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 13 Nov 2020, Phillip Wood wrote:

> Hi Dscho
>
> On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > We already maintain a list of colors in the `add_i_state`, therefore w=
e
> > should use them.
>
> Playing devil's advocate for a moment - why do we have a reset entry in =
that
> list? The next patch makes sure it cannot be customized which is a good =
thing
> so why not drop the `reset` member from `add_i_state` entirely? The perl
> version needed to get the reset string from `git config` and store it
> somewhere but in the C version we have a perfectly good constant we can =
use
> instead.

Right.

On the other hand, does it hurt to keep that field for consistency with
the rest of the coloring stuff? It would probably cost more to make the
change you suggested than it would benefit us.

Ciao,
Dscho
