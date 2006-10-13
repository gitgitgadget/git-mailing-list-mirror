From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-svnimport and tags
Date: Fri, 13 Oct 2006 22:15:37 +0200
Message-ID: <20061013201537.GV20017@pasky.or.cz>
References: <452FA667.1060003@computing.dcu.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 22:15:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYTRX-0007rZ-AP
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 22:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWJMUPk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 16:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbWJMUPk
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 16:15:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10980 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751863AbWJMUPj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Oct 2006 16:15:39 -0400
Received: (qmail 12633 invoked by uid 2001); 13 Oct 2006 22:15:37 +0200
To: Nicolas Stroppa <nstroppa@computing.dcu.ie>
Content-Disposition: inline
In-Reply-To: <452FA667.1060003@computing.dcu.ie>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28858>

  Hello,

Dear diary, on Fri, Oct 13, 2006 at 04:44:55PM CEST, I got a letter
where Nicolas Stroppa <nstroppa@computing.dcu.ie> said that...
> A small report. (I am using cogito-0.18 and git 1.4.2.3.)
> I have imported an SVN project using git-svnimport.
> This project has several tags. Here is what I get with one the tags.
> 
> tricatel $ git-cat-file tag `cat .git/refs/tags/alanis-0.9.4`
> object [...]
> type commit
> tag alanis-0.9.4
> tagger nico <nico>
> 
> 
> If I do the same thing on a git repository created from scratch, I get:
> 
> tricatel $ git-cat-file tag `cat .git/refs/tags/alanis-0.9.4`
> object [...]
> type commit
> tag alanis-0.9.4
> tagger nico <nico@[...]> 1160736694 +0100
> 
> The date information is missing in the first case, which confuses
> cg-tag-show:
> tricatel $ cg-tag-show alanis-0.9.4
> [...]
> cg-Xlib: line 215: nico <n (nic * 3600 + co> * 60):
> syntax error in expression (error token is "(nic * 3600 + co> * 60)")
> 
> I don't know if cg-tag-show should be more robust or if the date
> information should be in the tag.

  I think git-svnimport is broken here, the tagger line is clearly
defined that it must contain the time specification. And git-mktag is
broken as well since the verification of that line is a TODO so we let
the user put any garbage there.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
