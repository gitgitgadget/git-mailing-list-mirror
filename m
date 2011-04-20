From: Drew Northup <drew.northup@maine.edu>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Wed, 20 Apr 2011 14:39:24 -0400
Message-ID: <1303324764.20895.35.camel@drew-northup.unet.maine.edu>
References: <201102142039.59416.jnareb@gmail.com>
	 <201104141154.55078.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 20:41:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCcLa-0000gs-Hs
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 20:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab1DTSll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 14:41:41 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:39154 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab1DTSli (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 14:41:38 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p3KIdT4e020070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 20 Apr 2011 14:39:34 -0400
In-Reply-To: <201104141154.55078.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=6
	Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p3KIdT4e020070
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1303929613.8079@NebEqWH4yPfd5k43jRDDLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171871>


On Thu, 2011-04-14 at 11:54 +0200, Jakub Narebski wrote:

> * incremental blame (Ajax-y, requires server side knowing above)
> * setting local timezone in which dates are shown
> 
> Possible other JavaScript-based enhancements include:
> * sorting tables like in Wikipedia, avoiding trip to server
> * MediaWiki-like history view for selecting commits to compare
>   (base does not exist yet, and could be used without JavaScript)

> First issue is which JavaScript framework or library to use:
> * jQuery (lightweight, most popular, used e.g. by MediaWiki)
> * MooTools (lightweight, 2nd most popular, opbject-oriented)
> * YUI, The Yahoo! User Interface Library 
> * other: Prototype, Dojo, ExtJS, SproutCore,...
> 
> 
> Second issue is how to use it / how to include it:
> 
> * Use some external Content Delivery Network (CDN), like 
>   Google Libraries API 

> * Mark appropriate JavaScript library as dependency in gitweb/INSTALL
>   to be downloaded in appropriate place but do not provide sources.
>   Perhaps add target in gitweb/Makefile that automatically downloads
>   it.

> * Provide copy in git sources (in git.git repository), minified or
>   development version or both.  This would bloat git repository a bit,
>   and we would probably want/have to update library at its releases.

> * Instead of including source code or build (minified) version in git
>   repository, we could include JavaScript library as a _submodule_.

> * WordPress (jQuery)::
> 
>     jQuery (development version) is in wp-includes/js/jquery/*
>     in wordpress RPM

> So what are your ideas and comments on the issue of JavaScript code
> and JavaScript libraries / frameworks in gitweb?

I would like to note that we are going to have to stick with a specific
version of whatever we end up using during a release/bugfix family. A
failure to do this has led to numerous headaches over in WordPress land.
Some theme designers were going out on a limb and overriding the version
of jQuery that WordPress itself includes (sometimes with a newer one,
sometimes with an older one). The substitution led to a lot of
brokenness all over the place. It apparently isn't that easy to debug
either.
If we do not insist on lockstep updating of our use of a JS library
we're probably just as well off not using one at all. The easiest way is
to distribute it with the sources, but it may not be the best.
Also, we are under no obligation to stay bleeding edge with whatever JS
library we choose. This is a good thing as we don't need the random
breakage that a "flavor of the month" updating policy would cause.
-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
