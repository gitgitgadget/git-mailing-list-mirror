From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sat, 9 Feb 2008 23:59:49 -0500
Message-ID: <BAYC1-PASMTP10AF630E8A5B3D6C255317AE290@CEZ.ICE>
References: <200802081828.43849.kendy@suse.cz>
	<m3ejbngtnn.fsf@localhost.localdomain>
	<200802091627.25913.kendy@suse.cz>
	<alpine.LFD.1.00.0802092200350.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jan Holesovsky <kendy@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 06:01:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO4JU-0008MZ-9m
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 06:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbYBJFAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 00:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbYBJFA3
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 00:00:29 -0500
Received: from bay0-omc2-s14.bay0.hotmail.com ([65.54.246.150]:35574 "EHLO
	bay0-omc2-s14.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755030AbYBJE74 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 23:59:56 -0500
Received: from BAYC1-PASMTP10 ([65.54.191.183]) by bay0-omc2-s14.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 9 Feb 2008 20:59:51 -0800
X-Originating-IP: [74.14.66.77]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.14.66.77]) by BAYC1-PASMTP10.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 9 Feb 2008 20:59:51 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JO5E4-0002A8-Hl; Sun, 10 Feb 2008 00:59:40 -0500
In-Reply-To: <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.7; i686-pc-linux-gnu)
X-OriginalArrivalTime: 10 Feb 2008 04:59:51.0260 (UTC) FILETIME=[C49D29C0:01C86BA1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73314>

On Sat, 09 Feb 2008 22:10:06 -0500 (EST)
Nicolas Pitre <nico@cam.org> wrote:

> On Sat, 9 Feb 2008, Jan Holesovsky wrote:
> 
> > On Friday 08 February 2008 20:00, Jakub Narebski wrote:
> > 
> > > Both Mozilla import, and GCC import were packed below 0.5 GB. Warning:
> > > you would need machine with large amount of memory to repack it
> > > tightly in sensible time!
> > 
> > As I answered elsewhere, unfortunately it goes out of memory even on 8G 
> > machine (x86-64), so...  But still trying.
> 
> Try setting the following config variables as follows:
> 
> 	git config pack.deltaCacheLimit 1
> 	git config pack.deltaCacheSize 1
> 	git config pack.windowMemory 1g
> 
> That should help keeping memory usage somewhat bounded.
> 

Hi Nicolas,

Tried that earlier today and got a 1.6G pack (on a 2G machine).  There are
some big objects in that repo.. over 100 are 30 to 62M in size, 400 more
over 10M, and ~40,000 over 100K.  Would you expect a larger memory window
(on a better machine) to help shrink the repo down any more?

Sean
