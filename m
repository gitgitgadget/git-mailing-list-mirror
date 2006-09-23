From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/6] gitweb: Link to associated tree from a particular log item in full log view
Date: Fri, 22 Sep 2006 17:44:33 -0700
Message-ID: <7vodt7xvgu.fsf@assigned-by-dhcp.cox.net>
References: <20060922011941.15909.32671.stgit@rover>
	<20060922011948.15909.59511.stgit@rover>
	<7vmz8s7cvy.fsf@assigned-by-dhcp.cox.net>
	<20060922231315.GD8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 02:44:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQvdG-0005Iz-Rn
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 02:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWIWAog (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 20:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWIWAog
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 20:44:36 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:649 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964980AbWIWAoe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 20:44:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923004433.QTZI13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Sep 2006 20:44:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rckb1V00K1kojtg0000000
	Fri, 22 Sep 2006 20:44:35 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27548>

Petr Baudis <pasky@suse.cz> writes:

> Oops. It's trivial typo:
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d2366c7..c5f3810 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2880,7 +2880,7 @@ sub git_log {
>  		      " | " .
>  		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
>  		      " | " .
> -		      $cgi->a({-href => href(action=>"tree", hash=>$commit), hash_base=>$commit}, "tree") .
> +		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
>  		      "<br/>\n" .
>  		      "</div>\n" .
>  		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
>
>> You do not have the tree object name available in git_log to
>> generate an URL with both h and hb, and getting to it is an
>> extra work.
>
> Well using commit hash as a tree id works just fine...

I agree that change is much safer.  Will apply with an
appropriate log message and attribution.  No need to resend.
