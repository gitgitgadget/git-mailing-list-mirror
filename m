From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Sun, 26 Apr 2009 19:39:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904261939190.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <200904232116.10769.j6t@kdbg.org> <alpine.DEB.1.00.0904251155130.10279@pacific.mpi-cbg.de> <7vws98y886.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	torvalds@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 12:58:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly8Lu-0000kw-8N
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 19:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbZDZRjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 13:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbZDZRjo
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 13:39:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:38759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752895AbZDZRjo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 13:39:44 -0400
Received: (qmail invoked by alias); 26 Apr 2009 17:39:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 26 Apr 2009 19:39:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+x8fo3Vb6x7e313wGvS7s8KLud+CbhclWtl0I5Ne
	eppR5bjzi1rOEW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vws98y886.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117653>

Hi,

On Sat, 25 Apr 2009, Junio C Hamano wrote:

> So if you do:
> 
> 	cat >corrupt-move.c <<\EOF
> 	#include <unistd.h>
> 	int main(int ac, char **av)
>         {
>                 return (link(av[1], av[2]) || unlink(av[1]));
> 	}
> 	EOF
>         cc -o corrupt-move corrupt-move.c
>         ./corrupt-move corrupt-move.c corrupt-move.c.new
> 
> you end up with a corrupt-move.c.new file that is full of NUL?

I have not compiled and run this code, but I am _real_ sure that this is 
exactly the issue.

Ciao,
Dscho
