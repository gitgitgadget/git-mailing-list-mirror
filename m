Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BC9A1FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 08:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbcIDIKm (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 04:10:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:65216 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbcIDIKj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 04:10:39 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lhwt0-1bJmrJ0dnu-00n9Y2; Sun, 04 Sep 2016 10:10:27
 +0200
Date:   Sun, 4 Sep 2016 10:10:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Beau Martinez <beau@beaumartinez.com>, git@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_git_add_-p=E2=80=94splitting_hunks=2C_limit_is_too_large?=
In-Reply-To: <20160902191425.ki7nfhlqgnihoqpw@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609041001421.129229@virtualbox>
References: <CAEtDOuV+0CKRSu9mJa27+yQKJ-QRyNmwecrZKaaCh0St+VagZg@mail.gmail.com> <20160902191425.ki7nfhlqgnihoqpw@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XSHbB5wnKGr7GnHMFvkrCiiiomMvV7Y7xeDjvcCkXxBiHSdlghn
 TaREDX1D9iqWyIrpJkguHl03wN7dEKQC5Yb5CBuQPNhQyFQsuNA2VZss4WFwioWl1tSR1vR
 mI53KpEm9bqeJRreHsOfPLgim4bVsJjbLNVgt1fMXCJOc6URHMLuKPLqSg9/HOwZMKk8vFL
 9uLV0Jmcc163mHGN3XeNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3DGwF3kq9q4=:SAKoalXLFbsTyAVuhG5DzM
 MjkPZgyXzLB2K+Rio88E5bHgSFUU2+Zyqb7yeKt/Ax8M7eQXHwlwtzDs8IIxydM5r0bRHdwCi
 KkCuKkN86HO6jyx2RmHnCE5KZikAi83sioe6990PalcS7Jn9EeRS/VthNgv0394xGyjS4H4/O
 gEWlMFDiAjv+bKfMwzdLmtEu2ADnrLy7OMKi3HY1Os+UYoo2ZSeKTubpINkKhCAtoUObc4F8N
 dYkNLa690wWTUlGoi7pstO2w1s4IIeAocygRRvku6PiGGb5/PkQj8+0YVEUI3d+enpql7FQ+z
 35ulix0MGPlH5rxck4bra0DCUyxZzWiWs44uoaATRAAgGzq2YxK0HVNVfjz1nVYo7Z/lFM8bB
 tM2ONcSWrHDSAOeY6VGhRVTMKzukooJGb1TPhyTsjVhW+qmG8G9cv8OVyFIZJ5ODTsE+epZMW
 tiZpJZwV7oDH0hWIkJ2W9Cy5beu3wJMOdQ4JEYasGW3hHqDz1QHXsDRx9IAumXcrQ13tmlQRW
 a/Q7yJHqjXp87VFt0gdqMWV0cGzldo2+FbRgtbPtPOUoCRijJKY6zZDMzbom5/qr6NQS9G/uN
 S/IqO19LBYSGLYbOKoiqmd8g8f0Lw+qwmL4gHvK9ryLCDQZ4iSSx6SK3gyWebARLUDjfgUkDn
 JGRAUOCO+YJUWuvLvohXYEycRD1XdY2+vcRO1gZ4/SLmkX0fSasqwSyeydreVuEgm78Vu64Xo
 uBIN/tsv4xC355nqmpPip0uKa8/GB40v+eML9erk8uYyaxH7G/cPEGc/wiTYpqsXd+N3bDx3d
 c0pHjyr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 2 Sep 2016, Jeff King wrote:

> The good news (or maybe the bad) is that "add -p" is implemented
> entirely in Perl. :)

Yeah, you would definitely not call this "good news" if you were in my
shoes.

There is no question that it has grown way too unwieldy and that we (once
again, as with so many other scripts) missed the boat to convert it to C.

Scripting is nice for prototyping. But it comes at a high
portability/performance cost if taken too far. And we took it way too far.

Just look at all of those 1667 lines of git-add--interactive and weep. So
many things reimplemented in Perl instead of reusing functions in
libgit.a (or introducing them, making them usable from other parts of
Git). Wasted time is what I see there.

The worst part is that it completely violates our original "Unix
philosophy" of implementing the business logic in C and combinig it using
light-weight scripting.

And of course now the script is *so large* that nobody wants to undertake
the task of porting it to C.

Ciao,
Dscho
