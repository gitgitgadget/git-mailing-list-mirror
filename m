Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92955C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350938AbiHSS64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350144AbiHSS6x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:58:53 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245474E845
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660935528;
        bh=CTf36Ryv8lCDVoNawgu0TiWfqzcc51QYg4r+i0wENLc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fLK9b81DL3HWqd5h/Lkn0iMLh1FIsKIJxqx/5ALZr9kV9ALsPFdH6IL2vNeEwBKfp
         SWCtCcxZbYcB6i6mog3egejD+tQX0pxCvAcGZRuYpgDYRZX/i3M8jwQ3IfNWItMrL8
         rRzHqU5UXVfCvOvsIhBPpD76ysf+Ve449I1sjWTU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Gga-1nOnda2FZy-010Z9m; Fri, 19
 Aug 2022 20:58:48 +0200
Date:   Fri, 19 Aug 2022 20:58:47 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
Message-ID: <20220819185847.ulr5yjcfsahydeff@tb-raspi4>
References: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1326.git.1660855703816.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:o0BAEZl08zD+2spMBkBmq58FJFqCB0NQyd0B6B6YVEa2A7lI96e
 oVBPhnNjF4PYBFUdIQ06E0IdzuUCzA5B0Hb1NuEBCS7sXRQ1AsFHVdeSoEvVWOEgGi2o+c/
 SGEI84DVOwIpLNjE8/MPZygxdl/pQwtbjZVbHrlTAiG1cMi9O/ZvFuW5kP3lGB524d2BKlC
 kpCCvjNh6ajj2O6wEKwkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0YK1w9rbBKY=:+r403sVfFQfC6jR1d49xV7
 QL+qTlH9YU3xWvd3ayKLZWsiMiUQcxTjVxKimr3nVat9pMAi1NFWn3dabwvlMGG7eLWG7IsnZ
 HGHy6zEf8glk6rHXaZc/sKnyYZ2ytBAs37393f4UCDwJlO3Z9FFO7FSUwz4BhZVefvryQEGwb
 UEpa6ZcAPqSkeE1ZPJkKUTW0MUePoHQei4URh1x7KYmC6wwAlEaSjYs6TtfsuTLJvphEuvxgp
 p1yjdRZsHV7fHqqd5WTqrJhAt5cRMKn13slNQBD/cwRoR91Bv5uPfMYsu9zrzG7Bol+fKMRsc
 wMoNBCbp5CLrmf0PCb7A0S56Kpin+/yVYCN73K4p4HrJ7+egIryFPX40Z0RRO1dEghjTSLm6U
 wtgmtEQKduAYkJhjhbeZlp/yf2QapNlrb2UlTSNEMw8543sCC/Rh/T2gF4THFrRnSUBV57UeV
 WiWHf9ztkQuFZcovACJWlE1/BWN3fdwNwOCXRt4Hnvdu0wYTO4WbUDXJHYZK3DLamYRGr1IxU
 CgiKPaLjVyikKVfLOL0306dYE2OH+Wt1ZjH95vxW24KQJyMdKLv/qhZmbuWkTwKF9jCh/thTr
 XrhPJ+SabRGJcsOCx1Vk73XxlzFAGo8DWSdkFy7x5m5Y9VfMrVmN1D8vkIi/QNYThfY+5AyKz
 +EMuRmml4DGSkmVrh0QgHlKJRrEri0ZAbUCLjLOsgpY2qfgjSHMaCjKL1COao45afD/wV7XDw
 OHm9QJEcoR1LS8eJT/yhb0oT49MkfQK419m2+JRAjutqha2A8ZQq5w3SJS+nKNLDNl0Ccnp4D
 WFhF693DWyLZC9Wb5Q6l1fS3AZkzoWAEl4BCyuZH6Q53Kj0p0YxJiCVftnFlwvVLrbd280QV6
 SCKzrvSUNcmLT8XpxQRlf7vqUblirCsz1e9E5smiBMR/Twj19cHXtnSE6a2+FghLNTqAE4WDW
 +BZ4c38H66gURZTYNK2oVh43iFQMRoJVRw6CuXkEsqt+yTSAEeLWA85KYLtC8J6vBU5s4PouX
 OtoWmBdm9Jfm0Vdxx15I+bQbI7qb+uwULue4bwMf6BZeSCklAFUe0UzH+vpAV6PlbKDIrgASh
 OhDGVAJYikXVz5jlVmjMsAGiHIdOrfxp1PryFIDtXWJqzGnOuDuYzKoRQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2022 at 08:48:23PM +0000, Eric DeCosta via GitGitGadget wr=
ote:
> From: Eric DeCosta <edecosta@mathworks.com>

Just some comments on the commit message, please see inline.

>
> Though perhaps not common, there are uses cases where users have large,
> network-mounted repos. Having the ability to run fsmonitor against
> network paths would benefit those users.

I think that we can drop the "Though perhaps not common" - it doesn't
add any information about the technical part of the patch.
(And that is, what is important)

And I personally use network-mounted repos every day ;-)

Sone users have large, network-mounted repos. Having the ability
to run fsmonitor against network paths would benefit those users.

>
> As a first step towards enabling fsmonitor to work against
> network-mounted repos, a configuration option, 'fsmonitor.allowRemote'
> was introduced for Windows. Setting this option to true will override
> the default behavior (erroring-out) when a network-mounted repo is
> detected by fsmonitor.
[]
The same option is now introduced for macOS.

>
> The the added wrinkle being that the Unix domain socket (UDS) file
  ^^^ ^^^

> used for IPC cannot be created in a network location; instead the
> temporary directory is used.
