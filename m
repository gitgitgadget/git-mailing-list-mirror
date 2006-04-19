From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Wed, 19 Apr 2006 16:48:27 +0200
Message-ID: <20060419144827.GX27631@pasky.or.cz>
References: <20060419053640.GA16334@tumblerings.org> <20060419094916.GD27689@pasky.or.cz> <20060419142131.GD4104@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 16:48:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWDyq-00082Z-Fi
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 16:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWDSOsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 10:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWDSOs3
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 10:48:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35973 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750810AbWDSOs3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 10:48:29 -0400
Received: (qmail 7946 invoked by uid 2001); 19 Apr 2006 16:48:27 +0200
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20060419142131.GD4104@tumblerings.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18927>

  Hi,

Dear diary, on Wed, Apr 19, 2006 at 04:21:31PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> said that...
> On Wed, Apr 19, 2006 at 11:49:16AM +0200, Petr Baudis wrote:
> > Dear diary, on Wed, Apr 19, 2006 at 07:36:40AM CEST, I got a letter
> > where Zack Brown <zbrown@tumblerings.org> said that...
> > > When I do something like
> > > cg-clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
> > > 
> > > The first few lines of output are:
> > > 
> > > defaulting to local storage area
> > > warning: templates not found /home/zbrown/share/git-core/templates/
> > > /home/zbrown/git/cogito/cg-clone: line 137: .git/info/cg-fetch-earlydie: No such file or directory
> > > /home/zbrown/git/cogito/cg-clone: line 148: .git/info/cg-fetch-initial: No such file or directory
> > > 
> > > The rest of the process seems to go without incident. However, when I look
> > > at the repository I see:
> > > 
> > > $ ls -A
> > > .git  ___
> > > $
> > 
> > Could you please list the contents of the .git subdirectory? It seems
> > that git-init-db did not create the .git/info subdirectory.
> 
> 07:19:57 [zbrown] ~/git/trees/tmp/git/.git$ ls -F
> total 28
> 4 HEAD  4 branches/  4 config  4 index  4 info/  4 objects/  4 refs/

  hmm, could you please do this just after running git-init-db in an
empty directory? I just realized cg-fetch will mkdir -p the .git/info/
directory.

  If the .git/info/ directory would be there after git-init-db, I
couldn't explain the

	/home/zbrown/git/cogito/cg-clone: line 137: .git/info/cg-fetch-earlydie: No such file or directory

error. If the .git/info/ directory is not there after git-init-db,
either it is somehow broken in git-1.3.0, or it belongs to a much older
git version.

> 07:18:38 [zbrown] ~$ which git-init-db
> /home/zbrown/git/git//git-init-db
> 07:18:52 [zbrown] ~$ which git        
> /home/zbrown/git/git//git

  It might be a good idea to compare the ctimes.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
