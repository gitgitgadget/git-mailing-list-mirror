From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: git-p4 submit, Can't clobber writable file
Date: Tue, 2 Dec 2008 22:07:29 -0500
Message-ID: <20081203030729.GB5624@jabba.hq.digizenstudio.com>
References: <40586.80065.qm@web37902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 04:09:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7i6h-00034L-Ll
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 04:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbYLCDHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 22:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753236AbYLCDHj
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 22:07:39 -0500
Received: from k2smtpout02-01.prod.mesa1.secureserver.net ([64.202.189.90]:46480
	"HELO k2smtpout02-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751252AbYLCDHi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 22:07:38 -0500
Received: (qmail 19297 invoked from network); 3 Dec 2008 03:07:37 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout02-01.prod.mesa1.secureserver.net (64.202.189.90) with ESMTP; 03 Dec 2008 03:07:37 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 80B60100A34;
	Wed,  3 Dec 2008 03:07:37 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rdCwOqxs5JYb; Tue,  2 Dec 2008 22:07:30 -0500 (EST)
Received: from jabba.hq.digizenstudio.com (ip70-174-182-254.dc.dc.cox.net [70.174.182.254])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTPSA id D53A410008B;
	Tue,  2 Dec 2008 22:07:30 -0500 (EST)
Received: by jabba.hq.digizenstudio.com (Postfix, from userid 1000)
	id E2BB348E9A; Tue,  2 Dec 2008 22:07:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <40586.80065.qm@web37902.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102206>

On Tue, Dec 02, 2008 at 02:30:51PM -0800, Gary Yang wrote:
> 
> I followed the instructions at http://modular.math.washington.edu/home/mhansen/git-1.5.5.1/contrib/fast-import/git-p4.txt
> 
> But, I am not able to git-p4 submit. Any idea?
> 
> git-p4 clone //build/scripts build_scripts
> cd build_scripts
> vi foo.h
> git commit foo.h
> git-p4 rebase
> git-p4 submit
> 
>   from sets import Set;
> Perforce checkout for depot path //build/scripts/ located at /home/gyang/workspace/build_scripts/
> Syncronizing p4 checkout...
> //build/scripts/foo.h#1 - added as /home/gyang/workspace/build_scripts/foo.h
> Can't clobber writable file /home/gyang/workspace/build_scripts/foo.h
> //build/scripts/foo.c#1 - added as /home/gyang/workspace/build_scripts/foo.c
> Can't clobber writable file /user/home/gyang/workspace/build_scripts/foo.c
> ......
> command failed: p4 sync ...

You might want to clone to a git working dir different than the p4
working dir.

For instance, if your p4 workspace has the working dir set to
build_scripts/, try 'git p4 clone //build/scripts build_scripts.git'.

You would then normally work under build_scripts.git/. build_scripts/
would only be used by git-p4 at submission time.

Cheers.
-- 
Jing Xue
