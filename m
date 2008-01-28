From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: http-push as a builtin ? (Was: Is there a reason to keep walker.c
 ?)
Date: Mon, 28 Jan 2008 14:45:00 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801281438450.13593@iabervon.org>
References: <20080127204535.GA4702@glandium.org> <alpine.LNX.1.00.0801271603280.13593@iabervon.org> <20080128071749.GA12488@glandium.org> <20080128185828.GA14804@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 20:45:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJZvI-0004vD-HN
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 20:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbYA1TpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 14:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYA1TpF
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 14:45:05 -0500
Received: from iabervon.org ([66.92.72.58]:46117 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbYA1TpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 14:45:03 -0500
Received: (qmail 12125 invoked by uid 1000); 28 Jan 2008 19:45:00 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jan 2008 19:45:00 -0000
In-Reply-To: <20080128185828.GA14804@glandium.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71898>

On Mon, 28 Jan 2008, Mike Hommey wrote:

> On Mon, Jan 28, 2008 at 08:17:49AM +0100, Mike Hommey wrote:
> > On Sun, Jan 27, 2008 at 04:23:17PM -0500, Daniel Barkalow wrote:
> > > On Sun, 27 Jan 2008, Mike Hommey wrote:
> > > 
> > > > Hi,
> > > > 
> > > > While working on the http code refactoring, I got to wonder if the
> > > > walker.c "wrapper", that is only used for the http transport, is still
> > > > worth keeping. If there are plans for others transport to use this code,
> > > > obviously, it would be worth keeping, but on the contrary, I think it
> > > > would simplify the http transport code even more. What do you think ?
> > > 
> > > It would be a good base for sftp (i.e. dumb file access over ssh). In 
> > > fact, I think stuff should ideally be moved into walker.c such that the 
> > > HTTP-specific code just handles access to files by filename and the logic 
> > > of what files to request in what order is in walker.c. I think this would 
> > > get the simplification you're looking for while making it easy to add sftp 
> > > or any other situation where you have only slow remote filesystem-like 
> > > access to the repository.
> > 
> > I like this idea. I'll probably implement that, then.
> 
> BTW, would there be objections to have http-push as a builtin ?

Not from me. Actually, it would be ideal to call its functions directly 
from transport.c and deprecate the separate command. (And possibly 
separate the control structure from the HTTP code and move the former into 
walker.c where it could be used by sftp)

	-Daniel
*This .sig left intentionally blank*
