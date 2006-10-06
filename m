From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: prepare for repositories with packed refs.
Date: Fri, 6 Oct 2006 17:40:59 +0200
Message-ID: <20061006154059.GQ20017@pasky.or.cz>
References: <7vsli5pwqf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 17:42:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVrpg-00048j-5f
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 17:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWJFPlt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 11:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWJFPlt
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 11:41:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37820 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751385AbWJFPlt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 11:41:49 -0400
Received: (qmail 13568 invoked by uid 2001); 6 Oct 2006 17:40:59 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsli5pwqf.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28408>

Dear diary, on Tue, Oct 03, 2006 at 11:36:08AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> When a repository is initialized long time ago with symbolic
> HEAD, and "git-pack-refs --prune" is run, HEAD will be a
> dangling symlink to refs/heads/ somewhere.
> 
> Running -e "$dir/HEAD" to guess if $dir is a git repository does
> not give us the right answer anymore in such a case.

I think this is a wrong answer to this problem - I guess Cogito's going
to be confused by HEAD a dangling symlink as well and I'll bet there's
more places where this will give us trouble. Having HEAD a dangling
symlink is just wrong and git-pack-refs --prune is buggy if it causes
that.

  You should fix the problem at that side and make sure it either
changes HEAD to a symref or doesn't pack the ref HEAD points at. Or just
error out and leave the policy decision on the user.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
