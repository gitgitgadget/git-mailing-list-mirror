From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn set-tree bug
Date: Sun, 10 Jun 2007 23:58:40 -0700
Message-ID: <466CF2A0.4080604@midwinter.com>
References: <466C8B35.3020207@midwinter.com> <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 08:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxds1-0007RR-8y
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 08:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbXFKG6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 02:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbXFKG6p
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 02:58:45 -0400
Received: from tater.midwinter.com ([216.32.86.90]:56133 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751974AbXFKG6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 02:58:44 -0400
Received: (qmail 18953 invoked from network); 11 Jun 2007 06:58:43 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=J/8F9GCXbWlJePuf9jdGu5P3WHGCZBtSWlg7Va+X01gkKojeKRFJ3st1Ztg9++kz  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 11 Jun 2007 06:58:43 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <20070611042509.GA19866@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49825>

Eric Wong wrote:
> Doable?  Yes.  However, I think using grafts is quite hackish and
> unreliable[1].  I'd rather just have users using set-tree if
> they want to deal with non-linear history in the first place.
>   

Agreed about grafts being hackish and unreliable. But they were what I 
had to work with, given that I know little enough about git-svn's 
internals to be able to implement Junio's more robust idea.

IMO set-tree is not much of an option. In my environment it is 
unacceptable for there to be any possibility of accidentally and 
silently overwriting some other change that just happened to hit the svn 
repo right before I committed my change, which (unless it has changed 
since I last tried it) set-tree will happily do. I can get away with 
doing that maybe once before my company's release manager will, quite 
justifiably, require me to stop using git and switch back to the 
standard svn client.

> I'd personally avoid any sort of non-linear history when interacting
> with SVN repositories, however.
>   

Which is a shame since git loses a lot of its utility without nonlinear 
history. For example, the script I posted uses git to do merges between 
svn branches. It works wonderfully even if, as you and Junio point out, 
its use of grafts to record svn merges scales poorly and is potentially 
susceptible to corruption. Thanks to the ability to record the fact that 
my merges between svn branches were actually merges, my git clone has a 
more complete picture of what's in my svn repository than the svn 
repository itself does!

-Steve
