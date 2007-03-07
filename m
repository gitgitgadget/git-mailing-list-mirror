From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle: fix pack generation.
Date: Wed, 7 Mar 2007 04:22:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45ECEB40.4000907@gmail.com> <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
 <45EE1242.8080405@gmail.com> <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net>
 <45EE2ECA.60403@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 04:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOmjJ-0003lh-Sv
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 04:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030781AbXCGDWP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 22:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030784AbXCGDWP
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 22:22:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:59195 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030781AbXCGDWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 22:22:14 -0500
Received: (qmail invoked by alias); 07 Mar 2007 03:22:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 07 Mar 2007 04:22:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pHgESyDBp5jTDCE+L7TQBTmC9x3qvkDDTchnZs9
	AKpaK1PJlnXT0X
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45EE2ECA.60403@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41647>

Hi,

On Tue, 6 Mar 2007, Mark Levedahl wrote:

> Junio C Hamano wrote:
> > That one is caused by the broken revision traversal in 'master'
> > and being worked on in 'next'.  Care to try the one from 'next'
> > instead?
> using next as just pulled from kernel.org (09890a9bce0bc27182bc1f74a34b53)
> ...
> 
> git>git bundle create test.bdl HEAD~1..HEAD
> error: rev-list died 255
> 
> I have not found any  rev-args set that avoids that error.

Have you tried "make test"? In particular, t5510-fetch.sh?

If it passes, git-bundle works at least for one particular case, and I'd 
suspect then that the inbuilt GIT_EXEC_PATH bites you. To avoid that 
particular peculiarity, just "export GIT_EXEC_PATH=/path/to/next/", and 
try again.

Hiw,
Dscho
