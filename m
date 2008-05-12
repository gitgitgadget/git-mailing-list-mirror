From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 18:27:31 +0300
Message-ID: <20080512152731.GM31039@zakalwe.fi>
References: <4827DEF6.1050005@gmail.com> <87ej87is50.fsf@offby1.atm01.sea.blarg.net> <alpine.DEB.1.00.0805121428310.30431@racer> <48285087.3090402@gmail.com> <alpine.DEB.1.00.0805121606010.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: bill lam <cbill.lam@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 12 17:28:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvZwv-0006yQ-4Q
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 17:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbYELP1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 11:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbYELP1f
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 11:27:35 -0400
Received: from zakalwe.fi ([80.83.5.154]:52066 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbYELP1f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 11:27:35 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 677FD2BBE5; Mon, 12 May 2008 18:27:31 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805121606010.30431@racer>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81874>

On Mon, May 12, 2008 at 04:08:21PM +0100, Johannes Schindelin wrote:
> No, rsync is particularly dumb in that respect.  The safest thing would be 
> to back up the reflogs first (e.g. with rsync), then repack and then clone 
> (the clone will transmit the objects referenced by the reflogs, too).  
> Note: the same holds _not_ true for a simple fetch.
> 
> But then, you usually do not want to back up reflogs anyway, since they 
> are purely local and not visible to anybody else.

Is there a simple and efficient mechanism for incremental backups?
It should be safe with respect to simultaneous repository access.
Incrementals should be efficient weven when a user runs "git gc". 
Preferably I would like to have one file per day: 
myrepo.YYYY-MM-DD.increment (and occasionally myrepo.YYYY-MM-DD.full)
I believe this is a common administration problem; 
something like "git-backup" script/tool would be nice so that not all 
the admins need consider these issues.

Currently, I'm doing daily clones of repos, and I preserve those cloned 
directories.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
