From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Archiving tags/branches?
Date: Tue, 21 Oct 2008 02:33:48 -0700
Message-ID: <48FDA1FC.2030206@pcharlan.com>
References: <48F93F52.4070506@pcharlan.com> <m3prlvibb7.fsf@localhost.localdomain> <48FD55BF.1020207@pcharlan.com> <200810211015.27257.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	SZEDER Gabor <szeder@ira.uka.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 11:35:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsDdm-00034u-Pi
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 11:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbYJUJdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 05:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbYJUJdu
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 05:33:50 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:60505 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751929AbYJUJdt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2008 05:33:49 -0400
Received: from [192.168.0.101] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id 57B128F2C3;
	Tue, 21 Oct 2008 02:33:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <200810211015.27257.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98766>

Jakub Narebski wrote:
> > (The above notional --ls modifier is probably very easy to write, and if
> > I do so it may address all of my woes.  Subversion's branching/tagging
> > can be organized pretty much exactly like this, and importing into git
> > such a repository is what initially led me to ask about organizing tags
> > and branches.)
>
> Hmmm... it looks like what you are complaining is not the fact that
> tags have flat namespace, but the fact that recursive mode is the
> default behavior (something like "ls -R" or "git ls-tree -r").
>   

Yes, though I hope it didn't sound like I was complaining, just trying 
to understand how people manage these things.  (And "recursive" mode
being the only mode is precisely what flattens the namespace.)


> > What I'm usually likely to want from a "list tags" command is to see the
> > most recent few tags, not (say) all 226 tags in git.git.  I'll probably
> > write a little alias that does that, but even then when looking at the
> > whole list it would be nice to have the option to navigate it
> > hierarchically.  (Or in some other manner, and/or possibly with a
> > configurable directory separator.)
>
> So you would want some '--local' / '--non-recursive' option to listing
> all tags (for git-tag) and branches (for git-branch).
>
>   
Sure, though I hadn't thought of it in those terms.

> As to the "most recent few tags":
>   $ git for-each-ref --format='%(refname)' --sort=-taggerdate --count=10 refs/tags/
>
>   

Well that's pretty slick, thanks :)  I have aliased that to "lt", and
"lb" to:

for-each-ref --format='%(refname:short)'  --sort=-authordate --count=8
refs/heads/

(which seems less useful, but it was useful as homework...)

Thanks again,

--Pete
