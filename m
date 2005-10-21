From: Petr Baudis <pasky@suse.cz>
Subject: Re: Strange differences in cogito on SPARC and i386
Date: Fri, 21 Oct 2005 02:44:11 +0200
Message-ID: <20051021004411.GA30889@pasky.or.cz>
References: <200510171906.j9HJ6AQr015777@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 02:45:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESl17-0000eB-2k
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 02:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVJUAoO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 20:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVJUAoO
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 20:44:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48017 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964826AbVJUAoN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 20:44:13 -0400
Received: (qmail 28512 invoked by uid 2001); 21 Oct 2005 02:44:11 +0200
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200510171906.j9HJ6AQr015777@laptop11.inf.utfsm.cl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10398>

Dear diary, on Mon, Oct 17, 2005 at 09:06:10PM CEST, I got a letter
where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> git, cogito up to date everywhere.

Does that mean the latest development trees or the latest release
vesions? If the latter, could you try the former, please?

>    [vonbrand@pincoya linux-2.6.git]$ cg-update
>    Recovering from a previously interrupted fetch...
>    15:04:56 URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/HEAD [41/41] -> "refs/heads/.origin-fetching" [1]
>    Getting alternates list
>    progress: 10 objects, 24166 bytes
>    error: Empty reply from server (curl_result = 52, http_code = 0, sha1 = 0801ec7bf4953784f0f3279c1a80258ad29094d6)
>    Getting pack list
>    progress: 11 objects, 24873 bytes
>    error: Unable to find 0801ec7bf4953784f0f3279c1a80258ad29094d6 under http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> 
> Just started again each time, seems to work fine. On i386 the download goes
> smoothly, no hickups. And there are /no/ updates while SPARC is working its
> head off getting updates...
> 
> Then again, today on the SPARC it is getting several thousand objects (!),
> while on i386 it was only a few dozen.
> 
> Some stupid pilot error? Got different mirrors between machines? Sounds
> unlikely, as repeating the command (and presumably rotating between DNS
> entries) makes no difference.

Well, can you repeat the bug using git pull? (Try just "git pull".) If
so, and if you will slightly modify the subject in your reply, you
should hopefully get some interested debuggers who know this stuff
better. ;-) But I've seen those reports before, and it seems something
is rotten in the realm of fetching...

> Just finished SPARCwise. Almost 10K objects for changes to 4 files?! Yes,
> the files changed are the same on both machines.

This might be because of the interrupted merge - if it says the
"recovering" message, it will try to make sure you really have all the
objects, and depending on your exact git version, I can imagine it might
re-fetch some of them for some reason.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
