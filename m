Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E34B202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 16:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965297AbdIYQRZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 12:17:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:63508 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965284AbdIYQRX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 12:17:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MdKDb-1dfGSw34kd-00IWFq; Mon, 25
 Sep 2017 18:17:13 +0200
Date:   Mon, 25 Sep 2017 18:17:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] git: add --no-optional-locks option
In-Reply-To: <1506252671.8678.3.camel@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1709251816120.40514@virtualbox>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net> <1506252671.8678.3.camel@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ehlqBW1Kiapz3r4veDHsgbzUbX75WWuYqWl8oTrfHlI9XwaC2nn
 WMKV/3gyOkRCmVkovmRcm12zdihWYDAp51O81TC1A5nIrB1fepnI0VmfAPbv36Iz94WCX8f
 WSDNZaK7aPZlvHNbyoUwDISd9fxWwv4nX9/dWNGyMcPr+IGrHna/jgiXWubhbsXC/eUYvvU
 98pjmPiCpTy8xobUSgB7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HcklitU/X3Q=:CPzXyuYM3DjLxy0QkMorK2
 9yCiKbK4/OIGk71lDMFfcejLnHzDgiY6jLzULMjpEiaICI2A9PhUYmS5mkN0ZpQ6//JW9NJbV
 dugO3WBPRP2HWu1pUykQFmwv0C6yuQn06OYQtbkgJgz3+Hd5IjFntCp4DLpgZC0YZa77KVVx1
 GT64F6go8bhRTPnOMTOehKhV18YTb1JvZJCpFhCciL5SFlo1XwpPgrdHYhjr6LF1SG2Iyhj9M
 PxNcAJVbPA55NY8MCDHV/Swl8tJKDMewL3znJlyhCvzRFSq5oBW3HAT7yCItw5EfpMSJQh7pg
 RqvvwKuHho2vmkh/HJazavucz/GQ8WatIbTFqU0iXDPiVn5ANZyU6QPkRhNSl87eVnxfjqvnC
 PY39/b5Q5S/H3Ave+bcpauSF+tkcd6ids//9P2BPYaniB4RiazszFl53EYyqTAQf/Di7qBE8g
 fGxo62WQQS26A+SF5dMx5JPhnh9PX8bb9Hll/IE5RcvFDmblstHHul80D0M3JoW0ZibFMkCGa
 AeNKz2tLM7GNsmd4oE+yVigUp7iO37kfK7ChHd2VbXQ/kushSuqiwD9LPALzTw9rcay4sb91y
 AmFKR+hlD34lVzzqi+zUBymvOjs+iNdgmRP+I/mOO9KzYyY8rHKVVO6uXKRtiAUL98BU+3Ove
 EWTLJgsvh1PksWwhkiWgthnUeylu+dt0MOcpvSXOr7VS063TL+J2yicXo+dL+TPnHYffo1vf8
 AFXmkDoHvREeTLMtawsX0zWPts9iT+3sn/bgpmRkkdlzlrcnkkRLyD8qJIPkI+UFJO7md+ln2
 rW33R9VQBktD67z2qL42bJibKJ65nFw1+PbSAYyqnA79YFInHs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

On Sun, 24 Sep 2017, Kaartic Sivaraam wrote:

> On Thursday 21 September 2017 10:02 AM, Jeff King wrote:
> > Some tools like IDEs or fancy editors may periodically run commands
> > like "git status" in the background to keep track of the state of the
> > repository.
> 
> I might be missing something, shouldn't the IDEs be encouraged to use
> libgit2 instead? I thought it was meant for these use cases.

There are pros and cons. Visual Studio moved away from libgit2 e.g. to
support SSH (back then, libgit2 did not support spawning processes, I have
no idea whether that changed in the meantime).

Ciao,
Johannes
