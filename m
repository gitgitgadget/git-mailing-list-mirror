From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] gitweb: Allow for href() to be used for projectless links
Date: Thu, 14 Sep 2006 23:17:20 -0700
Message-ID: <7vzmd1zma7.fsf@assigned-by-dhcp.cox.net>
References: <200609150453.42231.jnareb@gmail.com>
	<200609150457.16924.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 08:17:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO70u-0007tG-SO
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 08:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWIOGRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 02:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWIOGRW
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 02:17:22 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:11676 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750803AbWIOGRV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 02:17:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060915061720.PRWP13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 Sep 2006 02:17:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NWHN1V0061kojtg0000000
	Fri, 15 Sep 2006 02:17:22 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609150457.16924.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 15 Sep 2006 04:57:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27062>

Jakub Narebski <jnareb@gmail.com> writes:

> Change adding project to params if $params{"project"} is false
> to adding project to params if it not exist. It allows for href()
> to be used for projectless links by using "project=>undef" as
> argument, while still adding project to params by default
> in the most common case.

This did not parse very well, at least for me.

> @@ -1304,9 +1305,11 @@ sub git_footer_html {
>  		if (defined $descr) {
>  			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
>  		}
> -		print $cgi->a({-href => href(action=>"rss"), -class => "rss_logo"}, "RSS") . "\n";
> +		print $cgi->a({-href => href(action=>"rss"),
> +		              -class => "rss_logo"}, "RSS") . "\n";
>  	} else {
> -		print $cgi->a({-href => href(action=>"opml"), -class => "rss_logo"}, "OPML") . "\n";
> +		print $cgi->a({-href => href(project=>undef, action=>"opml"),
> +		              -class => "rss_logo"}, "OPML") . "\n";
>  	}
>  	print "</div>\n" .
>  	      "</body>\n" .

Argh.  While I very much welcome folding of the long lines, I'd
rather see a separate patch to clean up other loooooooong lines
the current gitweb code has.
