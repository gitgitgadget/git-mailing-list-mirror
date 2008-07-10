From: Petr Baudis <pasky@repo.or.cz>
Subject: [CFH] Broken permissions in repo.or.cz repositories
Date: Fri, 11 Jul 2008 01:00:58 +0200
Message-ID: <20080710230058.GQ10151@machine.or.cz>
References: <56a0a2840807101218n7a280b67gfb3c579ada6b0e02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jesper Louis Andersen <jesper.louis.andersen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:02:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH59I-00081F-Lx
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbYGJXBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 19:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755019AbYGJXBE
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:01:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42459 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753810AbYGJXBD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 19:01:03 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C205E2C4C033; Fri, 11 Jul 2008 01:00:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <56a0a2840807101218n7a280b67gfb3c579ada6b0e02@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88048>

  Hi,

On Thu, Jul 10, 2008 at 09:18:18PM +0200, Jesper Louis Andersen wrote:
> I have run into a problem with your new fine cloud-changes: whenever I
> push changes to the 'master'
> branch of the etorrent.git repository, the overview page at
> http://repo.or.cz/w/etorrent.git removes
> the shortlog and shows no master branch at all. This problem means that we get:
> 
> jlouis@ogre:~/tmp$ git clone git://repo.or.cz/etorrent.git/
> Initialized empty Git repository in /home/jlouis/tmp/etorrent/.git/
> fatal: The remote end hung up unexpectedly
> 
> for new checkouts. Now, I've found a fix which is to pull over ssh:
> 
> jlouis@ogre:~/tmp$ git clone git+ssh://repo.or.cz/srv/git/etorrent.git
> Initialized empty Git repository in /home/jlouis/tmp/etorrent/.git/
> remote: Counting objects: 7510, done.
> remote: Compressing objReceiving objects:   9% (676/7510), 100.00 KiB
> | 167 KiB/remote: Compressing objects:  69% (1649/238Receiving
> objects:  10% (751/7510), 1remote: Compressing obReceiving objects:
> 12% (902/7510), 100.00 KiB | 167 KiB/sremote: Comremote: pressing
> objects: 100% (2389/2389), done.
> remote: Total 7510 (delta 4432), reused 7510 (delta 4432)
> Receiving objects: 100% (7510/7510), 1.93 MiB | 517 KiB/s, done.
> Resolving deltas: 100% (4432/4432), done.
> jlouis@ogre:~/tmp$ ls
> 
> which, as you can see, works. Then one can clone via git://... until I
> make another push and we are
> back to square one. I have not been able to find another repository
> having the same problem which
> makes me wonder if there is something wrong with my repository state
> which becomes fixed when it compresses
> the objects when I use the git+ssh transport?
> 
> For the sake of completeness, it is Ubuntu 8.04 here with git --version:
> 
> jlouis@ogre:~$ git --version
> git version 1.5.4.3

  turns out current git has buggy handling of the sharedRepository
config parameter, resulting in permission problems. Hopefully fixed.

-- 
				Petr "Pasky" Baudis
The last good thing written in C++ was the Pachelbel Canon. -- J. Olson
