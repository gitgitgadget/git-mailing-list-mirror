Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79C51FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 13:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbcLFNXf (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 08:23:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:54566 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751593AbcLFNXe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 08:23:34 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJmcS-1cD9g92eYu-0017L3; Tue, 06
 Dec 2016 14:16:37 +0100
Date:   Tue, 6 Dec 2016 14:16:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming
 builtin
In-Reply-To: <xmqqy3zu43yk.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612061411000.117539@virtualbox>
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>        <alpine.DEB.2.20.1611242211450.117539@virtualbox>        <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>        <alpine.DEB.2.20.1611251201580.117539@virtualbox>       
 <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>        <alpine.DEB.2.20.1611251841030.117539@virtualbox>        <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>        <alpine.DEB.2.20.1611261320050.117539@virtualbox>       
 <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>        <alpine.DEB.2.20.1611261400300.117539@virtualbox>        <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net>        <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>       
 <alpine.DEB.2.20.1611281830040.117539@virtualbox>        <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1611292128340.117539@virtualbox>        <xmqqshqadn0f.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1611301325210.117539@virtualbox>
        <xmqqlgvz6x87.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1612051126320.117539@virtualbox> <xmqqy3zu43yk.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SzkKufc8GRy3xRhD0VCZgDCYfUCTWtKH7Ti212YpG7XDRkmCY/x
 8GmCZfVXhxIOV5svKTMWU7/DyjdcbrxkW5mkwb3XjN0Ri6rOQrSKCKlVdOZxD55p9DyWoZm
 5T5/I7IiVe7sDRqm2dm0q5Ob0+pChBDrD3aTIFsbcehhJCCgySVGM/L+jR5CywJ3uBIhuig
 jTuh5XkIpBFYuS4DA8yHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vn5kc3gfJqE=:y4BMXYWxVOZWwknKnutpLD
 d7nTEub3d5f51L4P7w/M4LxvmdQ/r72CEHglrh7Kp2yGv7wxsGtz4cQRlg1XQbmkEXAN7iUu+
 NOQaBl8ImHZClY6KOJeP1yORTlJB2XzxBIDyzXx82zKxxypPnU9yFt0aShNBcj9QRCjIEBMTo
 ouvxAi2ValpjjAMTWcrcxIPhbsIZp1OQF/zGLT6TTF7rtX3+69n2BonP3DmjcFtQg9NVdc6IY
 lDG2Mkt5cMyU4FwvjDIJfuXr4HNwVqJzNQC7lKvd1REwsbvAGRgX6jpRDFgDoHvQn8Vr3Lz3Q
 plR8dDO7lxK1iDQlm6n/nClMFW6dgA9/8e7A5EXBjgDyvxNqqAvHyt5GxjI4ZzqJZ6pYotNRZ
 vcu3zg+ahr2GmLCfoe5d96qyWHp/CHuItKKoRjBQq8gMKzby3stiSVzafBfoH6BpS4y0Cbtsu
 uNM98dKZ+C6HramL5wDy98kOZph2Ak9GKU38j/Mz3ZGExuwXqR//UeirMK6wLGoT66PdFfuoc
 LR3wfrq7qGSKoVzB9kzj+sfU8Lrb0YTFFy7bai7/eIk8VwY2KuasHH14mcFbypcjpmj90rNUJ
 YXLcszAAW0CbxHfeJX1BFJfY3CcwAFVyxbNw8J77KAZQnt8SXm3u6JQeiF6vzPcs76L0gJ40w
 msp96Gm/ZK4vCtLcFa+1dz1UxlY4z0I4MVT7RXF5kHQwsSlOInT8iTxYjEurqkVVjomoF9pRC
 8IbBMz6OaTkb0jfHsGKbhjTvdQ26m7kjdoa3zAjUidi+nBawUPGrDFY1awKpdLrZRo83m2d0K
 YHw37a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 5 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Seriously, do you really think it is a good idea to have
> > git_config_get_value() *ignore* any value in .git/config?
> 
> When we do not know ".git/" directory we see is the repository we were
> told to work on, then we should ignore ".git/config" file.  So allowing
> git_config_get_value() to _ignore_ ".git/config" before the program
> calls setup_git_directory() does have its uses.

I think you are wrong. This is yet another inconsistent behavior that
violates the Law of Least Surprises.

> > We need to fix this.
> 
> I have a feeling that "environment modifications that cannot be undone"
> we used as the rationale in 73c2779f42 ("builtin-am: implement skeletal
> builtin am", 2015-08-04) might be overly pessimistic and in order to
> implement undo_setup_git_directory(), all we need to do may just be
> matter of doing a chdir(2) back to prefix and unsetting GIT_PREFIX
> environment, but I haven't looked into details of the setup sequence
> recently.

The problem is that we may not know enough anymore to "undo
setup_git_directory()", as some environment variables may have been set
before calling Git. If we simply unset the environment variables, we do it
incorrectly. On the other hand, the environment variables *may* have been
set by setup_git_directory(). In which case we *do* have to unset them.

The entire setup_git_directory() logic is a bit of a historically-grown
garden.

Ciao,
Dscho
