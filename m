Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 386F01F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfD3WhX (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:37:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:45281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfD3WhW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556663829;
        bh=FpZDD5Cy0wXqbb6q6JoLI7nGGWT0BSpvrJcC/FoIXlQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=haPa7F+4/kAVLT2VknsGZca47tErBXGK4wvhgoCa23r/e+MRQsgGRLvqXpdbIVa8w
         nO4sBuqz4zPVcYuEqhNAPjY/MEuOrV0K23nVEOleVnk062FS5LvS4JJLV2iSyfL+JS
         IoR02UZ3L2JvU3RhOUuh4JJP9vgqNz0bIS82kcsE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbyUS-1gwCFl0CUm-00jHeu; Wed, 01
 May 2019 00:37:09 +0200
Date:   Tue, 30 Apr 2019 18:37:06 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Thomas Braun via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Braun <thomas.braun@byte-physics.de>
Subject: Re: [PATCH 1/1] mingw: optionally disable side-band-64k for
 transport
In-Reply-To: <20190429231928.GQ6316@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1904301834230.45@tvgsbejvaqbjf.bet>
References: <pull.137.git.gitgitgadget@gmail.com> <31aa7bfcab834b753cc9f52fc9cc187f65e2d964.1556575475.git.gitgitgadget@gmail.com> <20190429231928.GQ6316@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ps46aTls+ogQSYwPNxeWuI4SUtkOQZy5f9FfslAP9HniEMLcLuD
 w0tOiZYuw4VsFkZSGVgRDac2Ui70XtGrP4CknVssyKnUXqWnqjFvJeYZZO7JQmFauxMEj6p
 +7rq0KjRIYxBcJzQsuvpNdxXjjmv9D8X3CRrweCujdZQMIyd0DWX8PnJCsTRG0msVzTHYzK
 4kSBK0WGJMNch7EzZpCKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mudEVTYhmc0=:xlD4oBXc0v73llQ0MZRJ1I
 RfnbUhQgKcgndVf1Bx4tm4d0QLEqSHiJR/ctDZr8zqYrC8uBFI3AVasAKsZG1ttI8I+s50bq/
 /4jThmjj9yqS75M2kWAK68uTK2Ch6UdSztvSlSfHSkMakWfK3/TUfEnS2GZrRHgrrzh7ZWseG
 zQF4qSVPQCeaxkXNlu6JNhLZbQcgge9tfvVNbdmxn1p/NWMzFk3EvKOnVqLSKzVopoTISadkh
 cGo7C2AYixG+AnIiFQg+QbAUEhlks9MDz9+mYrZrq+oOsvLavlglrfyUJby8ql2AbkcJ7tVZj
 OnDfAUMMcJBWYApQ1LAj9wF0Fyavi3dAEvTS2RwSBCmHYXKZL5IpV1rXEw8o0xJdQbNMzDEAe
 29YHAjxsYZvtoSxknxhO1F9s6M2WRjU2fJQwcJspL+9tK/GeW3OKXDtoN2ofepL1OiV4SCOXg
 DPue/uN1qnm3HfwvhTpCCSzXbv0tNkBMZg7CEk/kcl9nDmWpZ/fUkIGxtZmZ49vXD1ZsgEi+7
 pYKZJgMy9ezerk5y/RiEagUpEbUFvVYjaINMLZjBTyqUe2a/6v8cMeg0NwHrRobQJkBmXPMvx
 kp3P8lPaJ4k/gjmKrjZhPQq45+CRSglUJbwUl+v9c3w/kfFsT7kHmR40uCsGC4mrQgiqH9JFD
 DiRxCC0V5M21/3zBCVwJYjpNraRE3WT+GTt/SC5hKkiG0b1t6hv3HK6j+TfeP/kxyqdVZfyJ9
 uTb4TG1HxbCSLqwZj1NKYdElJSE0v32PVtazHaajHoQW1A+lUXtN4NJSbN2YiDT2+8lscGw43
 M51jamgyPOCs72S/wgYOTOeMxN1RPtAUdTjq98TMniyceAm6rHC8/DWrAWUtgOyEzHCPBMU6V
 PFnIsjS+aJEQgJEjs0DK+Y0iidYKSLer5k2kLB/DuT2uo2Ny5FAOoPGzUr0xk37KHz/XMZ01k
 5lX75282VwA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Mon, 29 Apr 2019, brian m. carlson wrote:

> On Mon, Apr 29, 2019 at 03:04:36PM -0700, Thomas Braun via GitGitGadget =
wrote:
> > From: Thomas Braun <thomas.braun@byte-physics.de>
> >
> > Since commit 0c499ea60f (send-pack: demultiplex a sideband stream with
> > status data, 2010-02-05) the built-in send-pack uses the side-band-64k
> > capability if advertised by the server.
> >
> > Unfortunately this breaks pushing over the dump git protocol if used
> > over a network connection when using MinGW (but *not* when using
> > mingw-w64).
> >
> > The detailed reasons for this, are courtesy of Jeff Preshing, quoted
> > from https://groups.google.com/d/msg/msysgit/at8D7J-h7mw/eaLujILGUWoJ:
> >
> > 	MinGW wraps Windows sockets in CRT file descriptors in order to
> > 	mimic the functionality of POSIX sockets. This causes msvcrt.dll
> > 	to treat sockets as Installable File System (IFS) handles,
> > 	calling ReadFile, WriteFile, DuplicateHandle and CloseHandle on
> > 	them. This approach works well in simple cases on recent
> > 	versions of Windows, but does not support all usage patterns.
> > 	In particular, using this approach, any attempt to read & write
> > 	concurrently on the same socket (from one or more processes)
> > 	will deadlock in a scenario where the read waits for a response
> > 	from the server which is only invoked after the write. This is
> > 	what send_pack currently attempts to do in the use_sideband
> > 	codepath.
>
> Since this is a platform-specific issue, can we address this using a
> compile-time constant instead of a config option? It would be better to
> do the right thing automatically in this case and not have to have
> people set a config option. It will also allow us to not to have to
> maintain a config option indefinitely if MinGW becomes more capable in
> the future.

I was really not sure at the time whether this would be fixed in MinGW at
some stage, and with the switch to mingw-w64 (by moving from MSys to MSYS2
as of Git for Windows 2.x) we do not really have any concrete need for it
anymore.

I just thought that it might benefit somebody (it was my impression that
Hannes Sixt still built his own copy with MSys/MinGW, and we do have a
track record of maintaining certain things even for single users, see e.g.
our insistence on creating the .git/branches/ directory upon `git init`).

But if the consensus is that we do not need this at all anymore, I'll be
just as happy to drop that patch.

Ciao,
Dscho
