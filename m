From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [PATCH] Add git-relink-script to fix up missing hardlinks
Date: Sun, 26 Jun 2005 21:11:13 -0400
Message-ID: <20050627011113.GA26049@delft.aura.cs.cmu.edu>
References: <20050626181516.GC20369@mythryan2.michonline.com> <7v7jghq6lt.fsf@assigned-by-dhcp.cox.net> <7vy88wq5hs.fsf@assigned-by-dhcp.cox.net> <42BF058F.8010301@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 27 03:04:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmi37-0007md-CR
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 03:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVF0BLW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 21:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVF0BLW
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 21:11:22 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:19396 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261694AbVF0BLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2005 21:11:18 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1Dmi9Z-0000ja-00
	for <git@vger.kernel.org>; Sun, 26 Jun 2005 21:11:13 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <42BF058F.8010301@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 26, 2005 at 03:44:15PM -0400, Jeff Garzik wrote:
> Junio C Hamano wrote:
> >I am a bit puzzled, though, why Jeff was the original requestor
> >for this feature --- I thought he handles 50 heads in one
> >repository which means there is no multiple repositories to
> >relink across.
> 
> Sure there are.  Just watching my submissions on the mailing list, you 
> can see ones mentioned such as "misc-2.6", "libata-dev", "netdev-2.6", etc.:
> 
> [jgarzik@pretzel repo]$ ls -FC
>  config-2.4      ethtool/    libata-dev/  netdev-2.6/     sparse/
>  config-2.6      git/        linux-2.6/   old-SCM/
>  config-2.6-uml  git-tools/  misc-2.6/    scsi-misc-2.6/

I actually have been using subdirectories in refs/heads with quite a bit
of success. All of the core tools have no problem with them and only
gitweb and gitk need some small changes to show them correctly.

The subdirectories in refs/heads are user specific in my case, this end
up being pretty useful when combined with Coda's directory ACLs, each
user can maintain their own branches, but cannot modify anyone elses.
All developers have insert, read and lookup rights on the main objects
repository, they can add new objects, but not remove or overwrite any
existing ones.

My branch names end up looking something like 'jaharkes/wdonly',
'awolbach/expand', etc. and it works like a charm.

Jan
