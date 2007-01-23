From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Repository Security
Date: Tue, 23 Jan 2007 22:38:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701232235050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701221433.13257.andre@masella.no-ip.org> <ep4q5e$ioc$1@sea.gmane.org>
 <200701230823.20061.andre@masella.no-ip.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 22:38:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9TLf-0003jn-Au
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 22:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965491AbXAWVi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 16:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965452AbXAWVi3
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 16:38:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:57982 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965491AbXAWVi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 16:38:28 -0500
Received: (qmail invoked by alias); 23 Jan 2007 21:38:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 23 Jan 2007 22:38:27 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andre Masella <andre@masella.no-ip.org>
In-Reply-To: <200701230823.20061.andre@masella.no-ip.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37574>

Hi,

On Tue, 23 Jan 2007, Andre Masella wrote:

> > > As I understand it, none of the repository backends allow any 
> > > per-user per-branch access control. SSH and HTTP come the closest 
> > > with the right hooks, but since the repository is writeable by those 
> > > users, there is little to stop them from changing the repository 
> > > directly.
> >
> > I wonder if it would be enought for SSH (and perhaps HTTP/WebDAV 
> > access) just to rely on filesystem write access to refs/heads files 
> > (different files having different access rights), and filesystem ACLs.
> 
> It could probably be done, but it would be very complicated. For 
> instance, if a user is allowed to run prune, then they must have 
> permissions to delete files which would include any of the objects.
> 
> For DAV, this breaks down completely because all access to the 
> repository will happen as the Apache user.

I read this, and I can't help myself thinking: This would be such a 
non-issue if you had one _repository_ per-user. If they take too much 
space, set them up with "git clone --reference=<official-central>", so you 
automatically use alternates.

You would not hit the problem where two developers want to push onto the 
same branchname, too.

Ciao,
Dscho
