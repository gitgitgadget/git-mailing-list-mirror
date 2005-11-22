From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] speedup allocation in pack-redundant.c
Date: Wed, 23 Nov 2005 00:38:45 +0100
Message-ID: <20051122233845.GC2916@steel.home>
References: <81b0412b0511220656l528436b1xea80ee18965e4dda@mail.gmail.com> <7vek58ct4b.fsf@assigned-by-dhcp.cox.net> <20051122230011.GA2916@steel.home> <4383A66D.2030201@etek.chalmers.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Nov 23 00:41:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EehjA-00041F-8v
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 00:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVKVXjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Nov 2005 18:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbVKVXjE
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 18:39:04 -0500
Received: from devrace.com ([198.63.210.113]:16400 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1030251AbVKVXjC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 18:39:02 -0500
Received: from tigra.home (p54A0E32F.dip.t-dialin.net [84.160.227.47])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAMNcnRW004101;
	Tue, 22 Nov 2005 17:38:50 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1Eehin-0000gC-00; Wed, 23 Nov 2005 00:38:45 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Eehin-0000wH-5J; Wed, 23 Nov 2005 00:38:45 +0100
To: Lukas =?iso-8859-15?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <4383A66D.2030201@etek.chalmers.se>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.8 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12586>

Lukas Sandstr=F6m, Wed, Nov 23, 2005 00:14:53 +0100:
> >>I think making allocation/deallocation to the central place is a
> >>good cleanup, but I am not sure about the free-nodes reusing.
> >>Does this make difference in real life?
> >=20
> > It definitely does, though nor very much. I have no real numbers at
> > hand (being home now), but I remember it was 1 min with against 3 m=
in
> > without the patch on cygwin+fat32, which is already bad enough all =
by
> > itself. Very big repository with no redundant packs in it.
>=20
> Would you mind sharing the .idx files?

this time I probably would (they're not here)... But for a perfomance
testing any big repository will do, linux kernel, for example.
