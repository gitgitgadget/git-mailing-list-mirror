From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Add title attribute with unshortened value for table cells
Date: Tue, 20 Jun 2006 02:15:51 -0700
Message-ID: <7vd5d4chmg.fsf@assigned-by-dhcp.cox.net>
References: <200606201012.31684.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 11:16:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FscL6-0001Zy-Ed
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 11:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWFTJPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 05:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWFTJPx
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 05:15:53 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:62919 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965085AbWFTJPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 05:15:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620091552.FEVL11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Jun 2006 05:15:52 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200606201012.31684.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 20 Jun 2006 10:12:31 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22183>

Jakub Narebski <jnareb@gmail.com> writes:

> Doesn't work well with values outside us-ascii, but that might be
> considered web browser bug (misfeature), not a bug in gitweb.

That's sad.

Are you sure about it?

What does start_td({-title=>"blah"}) produce? <td title="blah">?
If so, is http://members.cox.net/junkio/t.html close to what you
are trying to achieve here?

>  		      "<td>$pr->{'descr'}</td>\n" .
> -		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
> +		      $cgi->start_td({-title => $pr->{'owner'}}) . chop_str($pr->{'owner'}, 15) . "</i></td>\n";

Where did the opening <i> go?  Not that I care about italics,
since I think this should all be done with stylesheet, but I do
care about unbalanced pairs.

BTW, I haven't nailed down the procedure to update the
kernel.org gitweb installations (I suspect the burden is on me
since Kay orphaned gitweb onto me).

I wonder if there is somebody who is willing to run gitweb from
the "next" branch on some public site, so that I can be
reasonably confident before breaking one of the most important
infrastructure of the kernel development?  Volunteers?
