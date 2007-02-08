From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 23:29:11 +0100
Message-ID: <200702082329.12572.jnareb@gmail.com>
References: <17866.27739.701406.722074@lisa.zopyra.com> <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org> <17867.40122.51865.575762@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 23:27:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHk8-0003oU-WD
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423487AbXBHW1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423494AbXBHW1s
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:27:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:6305 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423487AbXBHW1r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:27:47 -0500
Received: by ug-out-1314.google.com with SMTP id 44so602533uga
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 14:27:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=F/bZ+WKz38ndlRvgSV9T8VKNojx6dC/EHc1spwxc8N1PbPdDV10qz+Pealw6etGT3kbEvqsDUetCKF517A6EgSWRakGilm++1WqeFpe3RvgO5qgW1xKVsXoDF3lNoWHpzioV754S/l/SWi21o/1xRKt3SZOrAEdnk3ECgca1YI8=
Received: by 10.78.165.16 with SMTP id n16mr14086hue.1170973656024;
        Thu, 08 Feb 2007 14:27:36 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id 39sm3282498ugb.2007.02.08.14.27.35;
        Thu, 08 Feb 2007 14:27:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <17867.40122.51865.575762@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39107>

Bill Lear wrote:
[cut]

With git 1.5.0-rc4 cloned repository, with globbing refspecs for origin
you don't have the problem. When you are on branch 'master', "git pull"
fetches and merges 'origin/master' into 'master'. When on any other
branch, "git pull" would fetch only (unless configured otherwise).

Note: you cannot pull into 'master' if you are not on 'master' because
of possibility of merge conflict: you need working area for that.

> In CVS, if I am on branch topic and say 'cvs update', it updates my
> branch topic.  If I am on branch master and say 'cvs update', it
> updates my branch master.  Etc., etc.  It doesn't matter that you move
> from one branch to the other, the update behavior is the same.  In
> git, if I am on master, things seem to work wonderfully --- one 'git
> pull' and my entire repo is synced (that is, merged) as I expect with
> the other repo.

In CVS branches are totally f**ked up. And enforced update before commit 
workflow doesn't help, also. Get rid of bad CVS habits. Please.

> I really don't want to do 'git fetch'.  I really want 'git pull'.  I
> really want the changes put into my repo, from that repo's branch X
> onto my branch X, and that repo's branch Y onto my branch Y.  I really
> don't want to have to remember to switch to my master branch before I
> do git pull (this, however, as it stands, does seem to me to be the
> best option).  Perhaps I'll just write a script 'git-sync' that does
> 'git checkout master; git pull'...

It's the only option.

> Jakub is of course literally correct when he says "'Crossing of the
> streams' is _required_ ... If you do parallel work ... you have to
> do merges".  Again, I recognize that my "foo" branch is different
> from your "foo" branch, and that when they come together they are
> in fact merged, but logically they are one thing --- one stream of
> shared work that we don't want to slip over into another one, at
> least not until we are ready.

So do fetch, and do pull only when changes are ready...

RTFM. Take a look at http://git.or.cz/gitwiki/GitLinks namely section
"Seminars and presentations", read new Git User's Manual also at
http://www.fieldses.org/~bfields/git-user-manual.html, browse GitWiki.

By the way, the workflow looks slightly different if you pull directly
from one another (A pulls or fetches from B, B pulls or fetches from A),
and if you have one central public bare repository (A pulls or fetches
from 'public' and pushes her changes to 'public', B pulls or fetches
from 'public' and pushes his changes to 'public'). In the latter git
asks you to pull (fetch) before pushing if you are not up to date. Notice
that it is on push, not on commit!


We should really update http://git.or.cz/gitwiki/GitWorkflows ...
but how to make diagrams: ASCII art is hard because it needs monospace,
upload of images attachements is not possible...
-- 
Jakub Narebski
Poland
