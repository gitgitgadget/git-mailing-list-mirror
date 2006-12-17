X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Sun, 17 Dec 2006 20:33:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612172027400.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
 <46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com>
 <0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de>
 <Pine.LNX.4.63.0612161227510.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90612170221u4c3b5c2asef378d3d4e159ba7@mail.gmail.com>
 <906f26060612170633h50e3e974h3b84f1829e546278@mail.gmail.com>
 <17797.35177.550000.996862@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 17 Dec 2006 19:33:33 +0000 (UTC)
Cc: Stefano Spinucci <virgo977virgo@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"Florian v. Savigny" <lorian@fsavigny.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17797.35177.550000.996862@lapjr.intranet.kiel.bmiag.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34700>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw1lJ-0005we-Ob for gcvg-git@gmane.org; Sun, 17 Dec
 2006 20:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750862AbWLQTdI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 14:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWLQTdI
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 14:33:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:56893 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1750862AbWLQTdH
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 14:33:07 -0500
Received: (qmail invoked by alias); 17 Dec 2006 19:33:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp043) with SMTP; 17 Dec 2006 20:33:05 +0100
To: Juergen Ruehle <j.ruehle@bmiag.de>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 17 Dec 2006, Juergen Ruehle wrote:

> Johannes claims that there are additional problems with mmap on cygwin, 
> but it passes the complete test suite on NTFS, so it should be ok for 
> most operations

I encountered a problem with git-log, where the fork() tried to 
reestablish a mmap()ed file, which unfortunately was renamed (since it was 
a .lock file[*1*]). This triggered the implementation of NO_MMAP.

I am sure that there are more problems with it. BTW the problem stems from 
Windows having _no_ equivalent to fork().

Notefoot 1: Isn't it funny that Windows cannot delete files which are 
still opened, but does not care when it is renamed?

Ciao,
