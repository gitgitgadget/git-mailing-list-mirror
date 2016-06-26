Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5981FE4E
	for <e@80x24.org>; Sun, 26 Jun 2016 06:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbcFZG5i (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 02:57:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:61245 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675AbcFZG5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 02:57:37 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MN748-1bJEnL2HWa-006bBz; Sun, 26 Jun 2016 08:57:31
 +0200
Date:	Sun, 26 Jun 2016 08:57:32 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] diff: let --output=<file> default to --no-color
In-Reply-To: <xmqqshw2dyks.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606260856480.12947@virtualbox>
References: <100cea0edf4f0986c000eb945a5e5955b8b59787.1466604435.git.johannes.schindelin@gmx.de> <xmqqshw2dyks.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9/rFXPIWSdMY/QCPsqJXs5H+l94iKdPb1VpUy6dvm4fDipjlrDy
 qhPShBrAKGCcnOlpcEg/keOn3NtN9dNoQbsZ/eqIb/Ry47DkaO9Ea2dU/hUr2L6VNn1j+pr
 R8Y0FW2uLgjSav2iBBIggyUFLGUh1wEw63NUviLtIZ1+24kyhKHjKAzVNIdjvS65ymKla8J
 N7nFDQNkzXqL/UPMzDHpA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:1iDu/R53slU=:9Ct/cfsRYuvE6kYWRIUNem
 iZUT/V9gvHBUbHPPl3qlNkURq4LqLhNUwU/ToNtzcSqUzP7t3vE2mKuFUyFz5BmyZvDq0Y/aX
 OB8QrVn+6O52TOjEq5LJTwYV1a3p7t354kRlEU/11PJLpRI+Q9sQ9gaZkdzGy1iedkINtWxKq
 6XRtZd0wcRC+L/A+0JvRMFRv+NJ3avPrGeN9QTmaUoi24NGb9fEirgI4pmYDT7eHLeNI26qWv
 Z/98SJVV3hjgxiNXIxVlnzp2CUn/aoloIn0CQPJ+gAoRmVWqv18HFXAMIFgS7OLR58S6NmBaw
 Dmi6ZBOUcB+TI4E62kUJLt+BBrOluhjNm6smn+kdwTAr7qpjKaPtokA+fq4ww6yWicjVf0LXm
 oB7Ce781FRr7vhmm/WsD4nJlloxWdiTOyK6zQaIsnwTfH+I05m3J9LXFlvkGxepP4B5Uyez07
 CSKM1VbYNMzzCqV3BtpJZo0Sn8lWlTK2l3Cn3QsW8A3Ze37HVA0RHYxXVgxV8O/DM80W6qMoL
 lspQokGMC6oByv+bcY3YaujrCotBEiMRPKp9W6yjm6jyDSS7Ye5hVLztrPgpyY97u4JgJAm3X
 cRQgB7HCP9+8Pk67YnbFMgbi2hVvTo73ycwzmD2GgNPhAv6dz0RYer6tl2oE5akZJt67waQhe
 N7Sz+sfSi1kBE8VMlWOAPpOPPdgyg/umIMafZJvj+jGefO7EZC+07FcpnezIJ4Sg6ukBJ0CPS
 Rg4QvjJupVgOpHXJ0CYe61EiMuoHIqAZizxEsNeJZ29DEh1cfVLpGslc1lW4Y5oL8Z5Da4NAS
 mvQX+am
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 24 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > It is highly unlikely that any user would want to see ANSI color
> > sequences in a file. So let's stop doing that by default.
> >
> > This is a backwards-incompatible change.
> >
> > The reason this was not caught earlier is most likely that either
> > --output=<file> is not used, or only when stdout is redirected
> > anyway.
> >
> > Technically, we do not default to --no-color here. Instead, we try to
> > override the GIT_COLOR_AUTO default because it would let want_color()
> > test whether stdout (instead of the specified file) is connected to a
> > terminal. Practically, we require the user to require color "always"
> > to force writing ANSI color sequences to the output file.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > Published-As: https://github.com/dscho/git/releases/tag/diff-o-v1
> >
> > 	Just something I noted while working on a bit more consistency
> > 	with the diffopt.file patches.
> >
> > 	This is a backwards-incompatible change, though. So I extracted it
> > 	from the patch series.
> 
> I think this is a bugfix.

Okay.

> Perhaps I should tweak 06/10 to assign GIT_COLOR_NEVER not 0 while
> queuing it.

Good point.

Thanks,
Dscho
