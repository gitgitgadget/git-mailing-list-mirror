From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: segfault during clone via http
Date: Wed, 4 Feb 2009 21:34:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902042132110.10279@pacific.mpi-cbg.de>
References: <loom.20090204T160827-822@post.gmane.org> <76718490902041000x3cda2390t25254e8372c9af50@mail.gmail.com> <loom.20090204T183407-350@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>
To: Adam Thorsen <adam.thorsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 21:35:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUoT5-0000O0-9A
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbZBDUeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 15:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbZBDUeF
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:34:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:47200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751143AbZBDUeC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:34:02 -0500
Received: (qmail invoked by alias); 04 Feb 2009 20:34:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 04 Feb 2009 21:34:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Dz49IrP3DY9fliAk6Qbo8M1aSp83QxlfgDZ8vLm
	GBJ3QzKJjZPrBl
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <loom.20090204T183407-350@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108427>

Hi,

On Wed, 4 Feb 2009, Adam Thorsen wrote:

> 
> Here is the stack trace:
> 
> Program received signal EXC_BAD_ACCESS, Could not access memory.
> Reason: KERN_INVALID_ADDRESS at address: 0x00494000
> 0x0015bb04 in multi_runsingle ()
> (gdb) bt
> #0  0x0015bb04 in multi_runsingle ()
> #1  0x0015d5af in curl_multi_perform ()
> #2  0x000b8782 in step_active_slots () at http.c:450
> #3  0x000b881c in run_active_slot (slot=0x50a450) at http.c:474
> #4  0x000bac5c in fetch (walker=0x5008d0, 
> sha1=0x4a791c "?u^?9l?\003?5??#??X\"?XL") at http-walker.c:846

FWIW I think the issue is related to the double cleanup I mentioned to 
Mike Hommey earlier.  At least when I undo the double cleanup, I do not 
get any segfaults anymore.

Ciao,
Dscho
