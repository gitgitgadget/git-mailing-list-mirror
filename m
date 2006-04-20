From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Thu, 20 Apr 2006 09:49:08 -0700
Message-ID: <20060420164908.GA540@tumblerings.org>
References: <20060419053640.GA16334@tumblerings.org> <20060419094916.GD27689@pasky.or.cz> <20060419142131.GD4104@tumblerings.org> <20060419144827.GX27631@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 18:49:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWcLO-0003eR-CU
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 18:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWDTQtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 12:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWDTQtX
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 12:49:23 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:21210 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S1751097AbWDTQtW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 12:49:22 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.61)
	(envelope-from <zbrown@tumblerings.org>)
	id 1FWcL6-0000IM-QP; Thu, 20 Apr 2006 09:49:08 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060419144827.GX27631@pasky.or.cz>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18979>

Hi Petr,

On Wed, Apr 19, 2006 at 04:48:27PM +0200, Petr Baudis wrote:
>   Hi,
> 
> Dear diary, on Wed, Apr 19, 2006 at 04:21:31PM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> said that...
> > On Wed, Apr 19, 2006 at 11:49:16AM +0200, Petr Baudis wrote:
> > > Dear diary, on Wed, Apr 19, 2006 at 07:36:40AM CEST, I got a letter
> > > where Zack Brown <zbrown@tumblerings.org> said that...
> > > > When I do something like
> > > > cg-clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
> > > > 
> > > > The first few lines of output are:
> > > > 
> > > > defaulting to local storage area
> > > > warning: templates not found /home/zbrown/share/git-core/templates/
> > > > /home/zbrown/git/cogito/cg-clone: line 137: .git/info/cg-fetch-earlydie: No such file or directory
> > > > /home/zbrown/git/cogito/cg-clone: line 148: .git/info/cg-fetch-initial: No such file or directory
> > > 
> > > Could you please list the contents of the .git subdirectory? It seems
> > > that git-init-db did not create the .git/info subdirectory.
> > 
> > 07:19:57 [zbrown] ~/git/trees/tmp/git/.git$ ls -F
> > total 28
> > 4 HEAD  4 branches/  4 config  4 index  4 info/  4 objects/  4 refs/
> 
>   hmm, could you please do this just after running git-init-db in an
> empty directory? I just realized cg-fetch will mkdir -p the .git/info/
> directory.

You're right, the "info" directory is not there if I just run git-init-db in an
empty directory.

> error. If the .git/info/ directory is not there after git-init-db,
> either it is somehow broken in git-1.3.0, or it belongs to a much older
> git version.

I just downloaded the latest versions of git and cogito from kernel.org:
cogito-0.17.2 and git-1.3.0; put their directories in my path, and ran "make" on
both of them. There's no other version in my path.

I see the same behavior: git-init-db does not create the .git/info directory.

> 
> > 07:18:38 [zbrown] ~$ which git-init-db
> > /home/zbrown/git/git//git-init-db
> > 07:18:52 [zbrown] ~$ which git        
> > /home/zbrown/git/git//git
> 
>   It might be a good idea to compare the ctimes.

09:46:55 [zbrown] ~/git/trees$ "ls" -ltc `which git; which git-init-db`
-rwxrwxr-x 2 zbrown zbrown 452312 Apr 20 09:44 /home/zbrown/git/git//git
-rwxrwxr-x 1 zbrown zbrown 235282 Apr 20 09:43 /home/zbrown/git/git//git-init-db
09:47:29 [zbrown] ~/git/trees$ 

Be well,
Zack

> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> Right now I am having amnesia and deja-vu at the same time.  I think
> I have forgotten this before.

-- 
Zack Brown
