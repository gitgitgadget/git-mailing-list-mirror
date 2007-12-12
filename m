From: Nicolas Pitre <nico@cam.org>
Subject: Re: Efficient retrieval of commit log info
Date: Wed, 12 Dec 2007 10:04:07 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712121001430.555@xanadu.home>
References: <34660cca0712120636w149e2a82h84609f8ac7c958a9@mail.gmail.com>
 <Pine.LNX.4.64.0712121453150.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Eirik_Bj=F8rsn=F8s?= <eirbjo@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2T9B-0007fu-Su
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbXLLPEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 10:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbXLLPEQ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:04:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34244 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbXLLPEP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:04:15 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSX00F3SZ6VHRF0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 12 Dec 2007 10:04:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <Pine.LNX.4.64.0712121453150.27959@racer.site>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68045>

On Wed, 12 Dec 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 12 Dec 2007, Eirik Bj?rsn?s wrote:
> 
> > I'm developing a piece of software that grabs logs from various types of 
> > SCMs and presents (hopefully) useful information about the history.
> > 
> > My current approach with Git is do a "git clone --n" and then parse the 
> > output of "git log". To check for updates I do a "git pull" followed by 
> > a new "git log".
> > 
> > This approach works fine, but cloning the whole repository just to get 
> > the change log seems like a somewhat inefficient use of bandwidth and 
> > storage.
> > 
> > What I would like to do is to fetch just the change log information
> > from the remote repository.
> > 
> > (Using the "CVS done right" tool I can do this with: "svn log --xml -v
> > -r<last, HEAD> http://svn.example.com/")
> > 
> > I haven't found a way to do this using the Git command line tools.
> 
> It is not possible to get just the metadata.  Remember, svn can do it only 
> since the repository is purely remote.  And git is a SCM (source code 
> management system), not a CMV (commit metadata viewer).
> 
> You might be able to cobble up something that works accessing gitweb, but 
> it might be even more inefficient.

On the other hand, this is pretty trivial to extend the protocol so only 
commit objects are transferred.  Using 'git log' on the client side 
would work, as long as you don't use any of the content walking options.


Nicolas
