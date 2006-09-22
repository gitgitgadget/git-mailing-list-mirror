From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 4/6] gitweb: Link to associated tree from a particular log item in full log view
Date: Sat, 23 Sep 2006 01:13:15 +0200
Message-ID: <20060922231315.GD8259@pasky.or.cz>
References: <20060922011941.15909.32671.stgit@rover> <20060922011948.15909.59511.stgit@rover> <7vmz8s7cvy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 01:13:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQuCu-0002R4-Hw
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 01:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWIVXNR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 19:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWIVXNR
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 19:13:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64406 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964907AbWIVXNQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 19:13:16 -0400
Received: (qmail 5424 invoked by uid 2001); 23 Sep 2006 01:13:15 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmz8s7cvy.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27541>

Dear diary, on Fri, Sep 22, 2006 at 06:18:09AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> I presume you are running this version at repo.or.cz, but
> 
> (1) go to http://repo.or.cz/?p=stgit.git;a=log
> (2) pick "tree" of one of the commits
> (3) go browser-back, then pick "tree" from the top navbar
> 
> The resulting tree view of (2) lacks navbar while (3) looks much
> saner.

Oops. It's trivial typo:

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d2366c7..c5f3810 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2880,7 +2880,7 @@ sub git_log {
 		      " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
 		      " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$commit), hash_base=>$commit}, "tree") .
+		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
 		      "<br/>\n" .
 		      "</div>\n" .
 		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .

> You do not have the tree object name available in git_log to
> generate an URL with both h and hb, and getting to it is an
> extra work.

Well using commit hash as a tree id works just fine...

> This would fix this particular breakage.

My knowledge of gitweb.perl innards isn't good enough for me to safely
ack/nak a change such deep down the chain.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
