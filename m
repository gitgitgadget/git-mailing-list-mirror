From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Is there a reason to keep walker.c ?
Date: Sun, 27 Jan 2008 16:23:17 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801271603280.13593@iabervon.org>
References: <20080127204535.GA4702@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 22:24:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJEyj-0000nk-E3
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 22:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbYA0VXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 16:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbYA0VXU
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 16:23:20 -0500
Received: from iabervon.org ([66.92.72.58]:39328 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159AbYA0VXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 16:23:19 -0500
Received: (qmail 26380 invoked by uid 1000); 27 Jan 2008 21:23:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jan 2008 21:23:17 -0000
In-Reply-To: <20080127204535.GA4702@glandium.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71834>

On Sun, 27 Jan 2008, Mike Hommey wrote:

> Hi,
> 
> While working on the http code refactoring, I got to wonder if the
> walker.c "wrapper", that is only used for the http transport, is still
> worth keeping. If there are plans for others transport to use this code,
> obviously, it would be worth keeping, but on the contrary, I think it
> would simplify the http transport code even more. What do you think ?

It would be a good base for sftp (i.e. dumb file access over ssh). In 
fact, I think stuff should ideally be moved into walker.c such that the 
HTTP-specific code just handles access to files by filename and the logic 
of what files to request in what order is in walker.c. I think this would 
get the simplification you're looking for while making it easy to add sftp 
or any other situation where you have only slow remote filesystem-like 
access to the repository.

	-Daniel
*This .sig left intentionally blank*
