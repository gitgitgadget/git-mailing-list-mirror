From: Christopher Faylor <me@cgf.cx>
Subject: Re: Cygwin git and windows network shares
Date: Fri, 16 Jun 2006 18:10:14 -0400
Message-ID: <20060616221014.GA22181@trixie.casa.cgf.cx>
References: <4492AAFA.20807@grin.se> <17554.48926.852000.679014@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 17 00:10:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrMWI-0007Z0-F2
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 00:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWFPWKQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 18:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWFPWKQ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 18:10:16 -0400
Received: from pool-71-248-179-97.bstnma.fios.verizon.net ([71.248.179.97]:651
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S1751338AbWFPWKO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 18:10:14 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 4E4FE13C01F; Fri, 16 Jun 2006 18:10:14 -0400 (EDT)
To: Niklas Frykholm <niklas@grin.se>, git@vger.kernel.org,
	Juergen Ruehle <j.ruehle@bmiag.de>
Content-Disposition: inline
In-Reply-To: <17554.48926.852000.679014@lapjr.intranet.kiel.bmiag.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21978>

On Fri, Jun 16, 2006 at 04:24:30PM +0200, Juergen Ruehle wrote:
>Niklas Frykholm writes:
> > I'm trying to use cygwin git (compiled from the 1.4.0 tarball) to create 
> > repository on a windows network share, but I get an error message.
> > 
> >     $ cd //computer/git/project
> >     $ git init-db
> >     defaulting to local storage area
> >     Could not rename the lock file?
>
>cygwin's rename seems to be capable of overwriting an existing target
>only on NTFS. The following hack is a workaround, but is probably not
>safe.

Actually, Cygwin's rename has a specific check to make sure that the
file is deleted.  It tries very hard to do things the right way but if
your samba server doesn't return the correct error code then it is
possible that it could be confused.

cgf
