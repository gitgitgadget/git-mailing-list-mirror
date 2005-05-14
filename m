From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 2/2] update cg-* to use cg-Xignore
Date: Sat, 14 May 2005 14:18:46 +0200
Message-ID: <20050514121846.GE3905@pasky.ji.cz>
References: <E1DWihi-0007DQ-SD@ash.dgreaves.com> <20050513225516.GG32232@pasky.ji.cz> <4285B5CA.8060106@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 14:19:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWvbW-0006L1-67
	for gcvg-git@gmane.org; Sat, 14 May 2005 14:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVENMSw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 08:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVENMSv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 08:18:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50326 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262750AbVENMSr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 08:18:47 -0400
Received: (qmail 645 invoked by uid 2001); 14 May 2005 12:18:46 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <4285B5CA.8060106@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 10:24:42AM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> Petr Baudis wrote:
> 
> >Dear diary, on Sat, May 14, 2005 at 12:32:22AM CEST, I got a letter
> >where David Greaves <david@dgreaves.com> told me that...
> >  
> >
> >>Updated
> >>    cg-add
> >>    cg-commit
> >>    
> >>
> >
> >I consider this Bad Thing (tm). Or could you please point a situation
> >where this would be actually useful? If you explicitly cg-add, you
> >likely know what are you doing, and same thing with cg-commit - if it's
> >already added, it should be watches, no matter what ignore patterns, I
> >think.
> >  
> >
> OK, lets say I'm clever and know what an ignore pattern is.
> I can
> find * | xargs cg-add
> my laziness something my hubris acknowledges :)

Makes sense, ok.

What about cg-commit? You already even added it.

> >>Index: cg-status
> >>===================================================================
> >>--- d2490ad0bc8b38647c6baff9da3e72c0f25e9f35/cg-status  (mode:100755)
> >>+++ 03662df7d089d4a84987ef9edb50a017b8b42439/cg-status  (mode:100755)
> >>@@ -15,21 +15,11 @@
> >> 
> >> {
> >> 	git-ls-files -z -t --others --deleted --unmerged $EXCLUDE
> >>-} | sort -z -k 2 | xargs -0 sh -c '
> >>-while [ "$1" ]; do
> >>-	tag=${1% *};
> >>-	filename=${1#* };
> >>-	case "$filename" in
> >>-	*.[ao] | tags | ,,merge*) ;;
> >>-	*)   echo "$tag $filename";;
> >>-	esac
> >>-	shift
> >>-done
> >>-' padding
> >>+} | sort -z -k 2 | cg-Xignore -0 -t | tr "\000" "\n"
> >>    
> >>
> >
> >So you have two ignores now - exclude and Xignore.
> >  
> >
> No, cogito has an ignore.
> git has a less powerful exclude.
> cogito users won't need exclude but power-users aren't barred from it.

I think having two essentially redundant things is useless. But you'll
be able to use the --exclude powers now since you have to fall back to
good ol' globs.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
