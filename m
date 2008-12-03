From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: git-p4 submit, Can't clobber writable file
Date: Wed, 3 Dec 2008 09:24:59 -0500
Message-ID: <20081203142459.GC5624@jabba.hq.digizenstudio.com>
References: <20081203030729.GB5624@jabba.hq.digizenstudio.com> <410584.87710.qm@web37905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 15:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7sgH-0006jq-Ps
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 15:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbYLCOZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 09:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbYLCOZE
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 09:25:04 -0500
Received: from k2smtpout02-01.prod.mesa1.secureserver.net ([64.202.189.90]:40282
	"HELO k2smtpout02-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750845AbYLCOZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 09:25:01 -0500
Received: (qmail 1802 invoked from network); 3 Dec 2008 14:25:01 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout02-01.prod.mesa1.secureserver.net (64.202.189.90) with ESMTP; 03 Dec 2008 14:25:01 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 051D6100A34;
	Wed,  3 Dec 2008 14:25:01 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xw4aj49cmkQV; Wed,  3 Dec 2008 09:25:00 -0500 (EST)
Received: from jabba.hq.digizenstudio.com (ip70-174-182-254.dc.dc.cox.net [70.174.182.254])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTPSA id 29DDF10008B;
	Wed,  3 Dec 2008 09:25:00 -0500 (EST)
Received: by jabba.hq.digizenstudio.com (Postfix, from userid 1000)
	id 4A5AA48E9A; Wed,  3 Dec 2008 09:24:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <410584.87710.qm@web37905.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102264>


(Just a friendly reminder - I believe the convention on this list is "no
top-post.")

On Tue, Dec 02, 2008 at 10:04:20PM -0800, Gary Yang wrote:
> 
> --- On Tue, 12/2/08, Jing Xue <jingxue@digizenstudio.com> wrote:
>
> > You might want to clone to a git working dir different than
> > the p4
> > working dir.
> > 
> > For instance, if your p4 workspace has the working dir set
> > to
> > build_scripts/, try 'git p4 clone //build/scripts
> > build_scripts.git'.
> > 
> > You would then normally work under build_scripts.git/.
> > build_scripts/
> > would only be used by git-p4 at submission time.
>
> So, I have to keep two copies of source tree at my home directory. One
> is for Perforce build_scripts workspace, another is for Git
> build_scripts.git. I normally work at build_scripts.git. But, when I
> need to submit changes to Perforce, I have to copy changed code from
> build_scripts.git to build_scripts.

You don't have to do that, not manually. That's git-p4's job. When you
do 'git p4 submit', it basically:

1. calls 'p4 sync' in the p4 working dir,
2. generates patches from p4/master..HEAD,
3. for each of the patches, applies it in the p4 working dir, and 'p4
submit' it as one changelist.

> Then, p4 submit code into
> Perforce. Is this the only way of using git-p4?  Note: I cannot use
> git-p4 submit at build_scripts. It claims "Cannot clobber writable
> file". Is it a bug of git-p4 or the instruction is not correct?

Git-p4.txt does mention this (although briefly) in the "Submitting"
section:

"git-p4 has support for submitting changes from a git repository back to the
Perforce depot. This requires a Perforce checkout separate from your git
repository..."

Cheers.
-- 
Jing Xue
