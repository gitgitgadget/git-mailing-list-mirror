From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase-merge/done: No such file or directory
Date: Mon, 12 Jan 2009 23:47:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901122342420.3586@pacific.mpi-cbg.de>
References: <87ocycjq29.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Jan 12 23:48:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMVaR-0005ew-Ck
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 23:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759862AbZALWrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 17:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757647AbZALWrE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 17:47:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:54708 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762299AbZALWrB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 17:47:01 -0500
Received: (qmail invoked by alias); 12 Jan 2009 22:46:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 12 Jan 2009 23:46:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186g+Z7Kc06j3DPULeP6CF2WYsor+LvHL7T0Ic5r8
	PiCtGRq+G8Y+BR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87ocycjq29.fsf@jidanni.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105407>

Hi,

On Tue, 13 Jan 2009, jidanni@jidanni.org wrote:

> Bug at git-rebase--interactive.sh:107: count=$(grep -c '^[^#]' < "$DONE")

Woohoo.  Buuuug.

> $DONE might not exist. Do test -f $DONE before you grep it.

I cannot reproduce here.  Since all the files in .git/rebase-merge/ are 
internal files to rebase--interactive, I think we do not have to guard 
against any possible user action rendering assumptions about internals 
invalid.

Wasting a minute, I seem to understand why I cannot reproduce.  Just 
looking all of _two_ lines above the line you mentioned:

	sed -e 1q < "$TODO" >> "$DONE"

Hrmpf.  You're right.  The user could have removed "$DONE"e between the 
two lines ;-)

Hth,
Dscho
