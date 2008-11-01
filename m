From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] connect.c: add a way for git-daemon to pass an error back
 to client
Date: Fri, 31 Oct 2008 22:20:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810312218300.13034@xanadu.home>
References: <b97024a40810311859t2e5a6102u31ad4480e7c75c03@mail.gmail.com>
 <alpine.DEB.1.00.0811010316340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tom Preston-Werner <tom@github.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 01 03:22:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw67d-00080J-U7
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 03:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbYKACUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 22:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbYKACUl
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 22:20:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:56374 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbYKACUl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 22:20:41 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9M00COCUIB6YB0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 31 Oct 2008 22:20:35 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0811010316340.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99713>

On Sat, 1 Nov 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 31 Oct 2008, Tom Preston-Werner wrote:
> 
> > The current behavior of git-daemon is to simply close the connection on
> > any error condition. This leaves the client without any information as
> > to the cause of the failed fetch/push/etc.
> > 
> > This patch allows get_remote_heads to accept a line prefixed with "ERR"
> > that it can display to the user in an informative fashion. Once clients
> > can understand this ERR line, git-daemon can be made to properly report
> > "repository not found", "permission denied", or other errors.
> > 
> > Example
> > 
> > S: ERR No matching repository.
> > C: fatal: remote error: No matching repository.
> 
> Makes sense to me.

Note that this behavior of not returning any reason for failure was 
argued to be a security feature in the past, by Linus I think.


Nicolas
