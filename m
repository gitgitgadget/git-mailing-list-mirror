From: martin f krafft <madduck@madduck.net>
Subject: Re: reviving a git-svn clone
Date: Tue, 21 Apr 2009 10:14:57 +0200
Message-ID: <20090421081457.GC28007@lapse.rw.madduck.net>
References: <20090420104316.GA11433@lapse.rw.madduck.net> <1240296712.3424.8.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 11:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwCSp-0002ae-16
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbZDUJix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 05:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbZDUJiw
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:38:52 -0400
Received: from clegg.madduck.net ([193.242.105.96]:46762 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbZDUJiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 05:38:52 -0400
Received: from lapse.rw.madduck.net (lapse.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:214:a4ff:fe04:eadc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 4B1F91D40A2;
	Tue, 21 Apr 2009 11:38:43 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id CEEDF8080; Tue, 21 Apr 2009 10:14:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1240296712.3424.8.camel@maia.lan>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.29-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9264/Tue Apr 21 10:05:09 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117118>

also sprach Sam Vilain <sam@vilain.net> [2009.04.21.0851 +0200]:
> eg for this use case something like this to copy the
> refs/remotes/origin/* refs to refs/remotes/upstream/*:
> 
>   git for-each-ref --format="%(refname)" refs/remotes/origin/* |
>      perl -le '$x = $_; $x =~ s{origin}{upstream};
>        system "git update-ref $x $_"'

Let me see if I parse this right: you want me to put the same SHA
into refs/remotes/upstream/trunk as there is in
refs/remotes/origin/upstream (since the upstream branch tracks the
trunk)?

> It's a bit hard to test without access to the upstream svn!

Sorry, I should have been more careful. You can access the upstream
SVN at http://svn.tuxonice.net/svn/hibernate-script . I am on
a train, so I cannot verify that, but the exact URL is listed on the
http://svn.tuxonice.net/ website.

One reason why I was a bit hesitant to change the URL from svn+ssh
to http was because my study of the code base suggested, that
git-svn actually matches the git-svn-id in the last commit message
with the URL in the svn-remote config stanza, and recurses the
commits parents until it finds a match. The error I am seeing
actually seems to occur when git-svn recursed all the way to the
first commit without a match.

Then again, I may well have misparsed the Perl code, so feel free to
ignore me.

Many thanks,

-- 
martin | http://madduck.net/ | http://two.sentenc.es/
 
all of you that believe in telekinetics, raise my hand!
 
spamtraps: madduck.bogus@madduck.net
